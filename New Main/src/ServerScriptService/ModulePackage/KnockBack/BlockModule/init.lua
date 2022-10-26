local BlockModule = {}

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local Utility = require(script.Parent.Utility)
local ModifierModule = require(script.Modifiers)

local PlayerConnections = {}

local DefaultConditionalTable = {
	CustomAnimation = nil,		-- (INSTANCE) Sets the custom block animation.
	RequiredForm = nil			-- (STRING) Checks to see if said attribute value is set to true to use the custom animation (if false, it'll use the default one)
}

function CalculateDefense(Character)
	
	local BlockValue
	local Quirk = Character:GetAttribute("Quirk")
	local ReducedBlockDefense = false
	
	if Information.PermanentBuffs[Quirk] and Information.PermanentBuffs[Quirk]["Defense"] then
		BlockValue = Information.PermanentBuffs[Quirk]["Defense"]
	else
		BlockValue = Information.Base_Unblock_Defense
	end
	
	if Character:GetAttribute("Blocking") then
		if Information.PermanentBuffs[Quirk] and Information.PermanentBuffs[Quirk]["BlockDefense"] then
			BlockValue *= Information.PermanentBuffs[Quirk]["BlockDefense"]
			ReducedBlockDefense = true
		elseif Information.Forms[Quirk] then
			for v,p in pairs(Character:GetAttributes()) do
				if Information.Forms[Quirk][v] and Information.Forms[Quirk][v]["BlockDefense"] and p then
					BlockValue *= Information.Forms[Quirk][v]["BlockDefense"]
					ReducedBlockDefense = true
					break
				end
			end
		end
		
		if not ReducedBlockDefense then
			BlockValue *= Information.Forms["All"]["Blocking"]["Defense"]
		end
	else
		if Information.PermanentBuffs[Quirk] and Information.PermanentBuffs[Quirk]["Defense"] then
			BlockValue = Information.PermanentBuffs[Quirk]["Defense"]
		else
			BlockValue = Information.Base_Unblock_Defense
		end
	end
	
	for v,p in pairs(Information.Forms["All"]) do

		if v ~= "Blocking" and Information.Forms["All"][v]["Defense"] and Character:GetAttribute(v) then
			BlockValue *= Information.Forms["All"][v]["Defense"]
		end

	end
	
	if Information.Forms[Quirk] then
		for v,p in pairs(Information.Forms[Quirk]) do

			if Information.Forms[Quirk][v]["Defense"] then

				if Character:GetAttribute(v) then
					BlockValue *= Information.Forms[Quirk][v]["Defense"]
				end

			end

		end
	end
	
	return BlockValue
	
end

function BlockModule:Link(StartEvent, EndEvent, Conditional)
	-- // If neither exist
	if not (StartEvent and EndEvent) then return end
	
	-- // if the player connection exists then don't add again
	if PlayerConnections[self] then return end
	
	local Player = game.Players:GetPlayerFromCharacter(self)
	local Hum = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")

	local CurrentBlockAnimation
	local BlockAnimation, CustomBlockAnimation
	
	local Conditions = DefaultConditionalTable
	
	PlayerConnections[self] = {}
	
	if Conditional and typeof(Conditional) == "table" then
		for v,p in pairs(Conditional) do
			Conditions[v] = p
		end
	end
	
	BlockAnimation = Hum:LoadAnimation(script.Block)
	CurrentBlockAnimation = BlockAnimation
	
	if Conditions.CustomAnimation then
		CustomBlockAnimation = Hum:LoadAnimation(Conditions.CustomAnimation)
		
		if Conditions.RequiredForm then

			self:GetAttributeChangedSignal(Conditions.RequiredForm):Connect(function()
				if self:GetAttribute(Conditions.RequiredForm) then
					if CurrentBlockAnimation.IsPlaying then
						CurrentBlockAnimation:Stop()
						CustomBlockAnimation:Play()
					end
					CurrentBlockAnimation = CustomBlockAnimation
				else
					if CurrentBlockAnimation.IsPlaying then
						CurrentBlockAnimation:Stop()
						BlockAnimation:Play()
					end
					CurrentBlockAnimation = BlockAnimation
				end
			end)
			
		else
			
			CurrentBlockAnimation = CustomBlockAnimation
			
		end
		
	end

	if Information.PermanentBuffs[self:GetAttribute("Quirk")] and Information.PermanentBuffs[self:GetAttribute("Quirk")]["Defense"] then
		self:SetAttribute("Defense", Information.PermanentBuffs[self:GetAttribute("Quirk")]["Defense"] or Information.Base_Unblock_Defense)
	else
		self:SetAttribute("Defense", Information.Base_Unblock_Defense)
	end
	
	local Forms = 1
	if Information.Forms[self:GetAttribute("Quirk")] then
		for v,p in pairs(Information.Forms[self:GetAttribute("Quirk")]) do

			if Information.Forms[self:GetAttribute("Quirk")][v]["Defense"] then

				PlayerConnections[self]["FormHandler" .. Forms] = self:GetAttributeChangedSignal(v):Connect(function()

					self:SetAttribute("Defense", CalculateDefense(self))

				end)
				Forms += 1

			end

		end
	end

	PlayerConnections[self]["FormHandler" .. Forms] = self:GetAttributeChangedSignal("Enraged"):Connect(function()
		self:SetAttribute("Defense", CalculateDefense(self))
	end)
	
	ModifierModule.Quirk(self, StartEvent, EndEvent)
	
	PlayerConnections[self]["DefenseUp"] = StartEvent.OnServerEvent:Connect(function(plr)

		if plr.UserId ~= Player.UserId then return end
		
		if not (plr == Player) then return end

		if self:GetAttribute("Attacking") then return end 
		if self:GetAttribute("Stunned") then return end 
		if self:GetAttribute("Stamina") < Information.Forms["All"]["Blocking"]["StaminaConsumption"] then return end
		if self:GetAttribute("Blocking") then return end

		self:SetAttribute("Blocking", true)
		self:SetAttribute("Attacking", true)

		CurrentBlockAnimation:Play()

		self:SetAttribute("Defense", CalculateDefense(self))
		
		repeat

			Utility.IncrementStamina(self, -Information.Forms["All"]["Blocking"]["StaminaConsumption"])
			task.wait(Information.Stamina_Consumption_Delay)

		until not self:GetAttribute("Blocking") or self:GetAttribute("Stamina") < Information.Forms["All"]["Blocking"]["StaminaConsumption"]
		
		if self:GetAttribute("Blocking") then
			self:SetAttribute("Blocking", false)
		end
		
		self:SetAttribute("Defense", CalculateDefense(self))
		
		CurrentBlockAnimation:Stop()

		self:SetAttribute("Attacking", false)

	end)

	PlayerConnections[self]["DefenseDown"] = EndEvent.OnServerEvent:Connect(function(plr)

		if plr.UserId ~= Player.UserId then return end
		
		if not (plr == Player) then return end

		if self:GetAttribute("Stunned") then
			repeat game:GetService("RunService").Heartbeat:Wait() until not self:GetAttribute("Stunned")
		end
		if self:GetAttribute("Blocking") then
			self:SetAttribute("Blocking", false)
		end

	end)
	
	PlayerConnections[self]["RemovingCharacter"] = Player.CharacterRemoving:Connect(function()

		if not PlayerConnections[self] then return end
		PlayerConnections[self]["RemovingCharacter"]:Disconnect()
		PlayerConnections[self]["RemovingCharacter"] = nil
		for index, value in pairs(PlayerConnections[self]) do
			value:Disconnect()
		end
		PlayerConnections[self] = nil
		
	end)
end

return BlockModule
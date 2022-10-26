local BlockModule = {}

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local Utility = require(script.Parent.Utility)
local ModifierModule = require(script.Modifiers)

local DefaultConditionalTable = {
	CustomAnimation = nil,		-- (INSTANCE) Sets the custom block animation.
	RequiredForm = nil			-- (STRING) Checks to see if said attribute value is set to true to use the custom animation (if false, it'll use the default one)
}

function BlockModule:Link(StartEvent, EndEvent, Conditional)
	
	if not StartEvent or not EndEvent then return end
	
	local Player = game.Players:GetPlayerFromCharacter(self)

	local Hum = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")

	local CurrentBlockAnimation
	local BlockAnimation, CustomBlockAnimation
	
	local Conditions = DefaultConditionalTable
	
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
	
	local function CD(Quirk)

		local BlockValue
		if Information.PermanentBuffs[Quirk] and Information.PermanentBuffs[Quirk]["Defense"] then
			BlockValue = Information.PermanentBuffs[Quirk]["Defense"]
		else
			BlockValue = Information.Base_Unblock_Defense
		end
		
		if self:GetAttribute("Blocking") then
			
			if Information.PermanentBuffs[Quirk] and Information.PermanentBuffs[Quirk]["BlockDefense"] then
				
				BlockValue *= Information.PermanentBuffs[Quirk]["BlockDefense"]
				
			elseif Information.Forms[Quirk] then
				
				local HasBlockDefense = false
				for v,p in pairs(self:GetAttributes()) do
					
					if Information.Forms[Quirk][v] and Information.Forms[Quirk][v]["BlockDefense"] and self:GetAttribute(v) then
						
						BlockValue *= Information.Forms[Quirk][v]["BlockDefense"]
						HasBlockDefense = true
						break
						
					end
					
				end
				
				if not HasBlockDefense then

					BlockValue *= Information.Forms["All"]["Blocking"]["Defense"]

				end
				
			else
				
				BlockValue *= Information.Forms["All"]["Blocking"]["Defense"]
				
			end
			
		else
			
			if Information.PermanentBuffs[Quirk] and Information.PermanentBuffs[Quirk]["Defense"] then
				
				BlockValue = Information.PermanentBuffs[Quirk]["Defense"]
				
			else
				
				BlockValue = Information.Base_Unblock_Defense
				
			end
			
		end

		if Information.Forms[Quirk] then
			for v,p in pairs(Information.Forms[Quirk]) do

				if Information.Forms[Quirk][v]["Defense"] then

					if self:GetAttribute(v) then
						BlockValue *= Information.Forms[Quirk][v]["Defense"]
					end

				end

			end
		end

		return BlockValue

	end

	if Information.Forms[self:GetAttribute("Quirk")] then
		for v,p in pairs(Information.Forms[self:GetAttribute("Quirk")]) do

			if Information.Forms[self:GetAttribute("Quirk")][v]["Defense"] then

				self:GetAttributeChangedSignal(v):Connect(function()

					if self:GetAttribute(v) then

						self:SetAttribute("Defense", self:GetAttribute("Defense")*Information.Forms[self:GetAttribute("Quirk")][v]["Defense"])

					else

						self:SetAttribute("Defense", self:GetAttribute("Defense")/Information.Forms[self:GetAttribute("Quirk")][v]["Defense"])

					end

				end)

			end

		end
	end
	
	ModifierModule.Quirk(self, StartEvent, EndEvent)
	
	StartEvent.OnServerEvent:Connect(function(plr)

		if plr.UserId ~= Player.UserId then return end
		
		if not (plr == Player) then return end

		if self:GetAttribute("Attacking") then return end 
		if self:GetAttribute("Stunned") then return end 
		if self:GetAttribute("Stamina") < 3 then return end
		if self:GetAttribute("Blocking") then return end

		self:SetAttribute("Attacking", true)
		self:SetAttribute("Blocking", true)

		CurrentBlockAnimation:Play()

		repeat

			self:SetAttribute("Defense", CD(self:GetAttribute("Quirk")))
			Utility.IncrementStamina(self, -Information.Forms["All"]["Blocking"]["StaminaConsumption"])

			wait(Information.Stamina_Consumption_Delay)

		until not self:GetAttribute("Blocking") or self:GetAttribute("Stamina") < 3
		self:SetAttribute("Defense", CD(self:GetAttribute("Quirk")))
		
		CurrentBlockAnimation:Stop()

		self:SetAttribute("Attacking", false)
		self:SetAttribute("Blocking", false)

	end)

	EndEvent.OnServerEvent:Connect(function(plr)

		if plr.UserId ~= Player.UserId then return end
		
		if not (plr == Player) then return end

		if self:GetAttribute("Stunned") then
			repeat game:GetService("RunService").Heartbeat:Wait() until not self:GetAttribute("Stunned")
		end
		if self:GetAttribute("Blocking") then
			self:SetAttribute("Blocking", false)
		end

	end)

end

return BlockModule
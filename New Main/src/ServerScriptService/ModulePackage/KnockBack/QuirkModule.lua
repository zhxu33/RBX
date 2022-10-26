QuirkModule = {}

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local Utility = require(script.Parent.Utility)

QuirkModule.QuirkConnections = {}

function QuirkModule:Link()

	local Hum = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")
	
	local Player = game.Players:GetPlayerFromCharacter(self)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(self.Name) or workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name)
	
	local Quirk = PlayerData:FindFirstChild("Quirk") or PlayerData:WaitForChild("Quirk")
	local Agility = PlayerData:FindFirstChild("Agility") or PlayerData:WaitForChild("Agility")
	local Durability = PlayerData:FindFirstChild("Durability") or PlayerData:WaitForChild("Durability")

	self:SetAttribute("Quirk", Quirk.Value)
	self:SetAttribute("MaxStamina", Information.Starting_Stamina+(Agility.Value*Information.Agility_To_Stamina_Multiplier))
	self:SetAttribute("Stamina", self:GetAttribute("MaxStamina"))
	
	if QuirkModule.QuirkConnections[self] then
		for index, val in pairs(QuirkModule.QuirkConnections[self]) do
			val:Disconnect()
		end
	end
	QuirkModule.QuirkConnections[self] = {}

	if Information.Forms[self:GetAttribute("Quirk")] then
		for v,p in pairs(Information.Forms[self:GetAttribute("Quirk")]) do
			self:SetAttribute(v, false)
		end
	end
	
	for v,p in pairs(Information.DefaultAttributeValues) do
		self:SetAttribute(v, p)
	end
	
	local RegeningStamina = false
	local RegeneratingHealth = false
	local CanRegenStamina = false
	local CanRegenHealth = false
	local HealthRegenMultiplier = 1
	
	Hum.MaxHealth = Information.Starting_Health + Information.Health_Per_Durability*Durability.Value
	Hum.Health = Hum.MaxHealth
	
	QuirkModule.QuirkConnections[self]["GadgetHandler"] = self:GetAttributeChangedSignal("Tool_Type"):Connect(function()

		local Tool = self:GetAttribute("Tool_Type")
		local Quirk = self:GetAttribute("Quirk")
		
		if not Information.Forms[Quirk] then return end
		if not Information.Forms[Quirk][Tool] then return end
		if not Information.Forms[Quirk][Tool]["Gadget"] then return end
		
		if self:GetAttribute(Tool) == false then

			self:SetAttribute(Tool, true)
			self:GetAttributeChangedSignal("Tool_Type"):Wait()
			self:SetAttribute(Tool, false)
		end
		
	end)
	
	QuirkModule.QuirkConnections[self]["HumanoidHandler"] = Hum.Died:Connect(function()
		QuirkModule.QuirkConnections[self]["HumanoidHandler"]:Disconnect()
		self:SetAttribute("Attacking", true)
		QuirkModule.QuirkConnections[self]["HumanoidHandler"] = self:GetAttributeChangedSignal("Attacking"):Connect(function()
			self:SetAttribute("Attacking", true)
		end)
	end)

	QuirkModule.QuirkConnections[self]["StaminaHandler"] = self:GetAttributeChangedSignal("Stamina"):Connect(function()

		if not RegeningStamina then
			
			RegeningStamina = true
			repeat
				
				CanRegenStamina = true
				if Information.Forms[self:GetAttribute("Quirk")] then
					for v,p in pairs(self:GetAttributes()) do
						if p and Information.Forms[self:GetAttribute("Quirk")][v] and Information.Forms[self:GetAttribute("Quirk")][v]["DisableStaminaRegen"] then
							CanRegenStamina = false
							break
						end
					end
				end
				
				if CanRegenStamina then
					local dh = Information.Stamina_Regeneration_Rate*self:GetAttribute("MaxStamina")
					self:SetAttribute("Stamina", (self:GetAttribute("Stamina") + dh))
					if self:GetAttribute("Stamina") >= self:GetAttribute("MaxStamina") then
						self:SetAttribute("Stamina", self:GetAttribute("MaxStamina"))
					end
				end
				task.wait(Information.Stamina_Regeneration_Delay)
			until self:GetAttribute("Stamina") == self:GetAttribute("MaxStamina")

			RegeningStamina = false

		end

	end)

	QuirkModule.QuirkConnections[self]["AgilityHandler"] = Agility:GetPropertyChangedSignal("Value"):Connect(function()

		self:SetAttribute("MaxStamina", Information.Starting_Stamina+(Agility.Value*Information.Agility_To_Stamina_Multiplier))

		if self:GetAttribute("Stamina") > self:GetAttribute("MaxStamina") then
			self:SetAttribute("Stamina", self:GetAttribute("MaxStamina"))
		end

	end)

	QuirkModule.QuirkConnections[self]["HealthHandler"] = Hum:GetPropertyChangedSignal("Health"):Connect(function()

		if not RegeneratingHealth and Hum.Health ~= Hum.MaxHealth then
			RegeneratingHealth = true

			repeat
				
				HealthRegenMultiplier = (self:GetAttribute("HealthRegen_Multiplier") or 1) -- // Defaults to one (Makes it so it doesn't error if it's not added to main world)
				CanRegenHealth = true
				for v,p in pairs(self:GetAttributes()) do
					
					if p and Information.Forms[self:GetAttribute("Quirk")] and Information.Forms[self:GetAttribute("Quirk")][v] and Information.Forms[self:GetAttribute("Quirk")][v]["DisableHealthRegen"] then
						
						CanRegenHealth = false
						break
						
					end
					
				end
				
				for v,p in pairs(self:GetAttributes()) do
					if p and Information.Forms["All"][v] and Information.Forms["All"][v]["HealthRegenerationBoost"] then
						HealthRegenMultiplier *= Information.Forms["All"][v]["HealthRegenerationBoost"]
					end
				end
				
				if CanRegenHealth and Information.PermanentBuffs[self:GetAttribute("Quirk")] and Information.PermanentBuffs[self:GetAttribute("Quirk")]["HealthRegenerationBoost"] then
					HealthRegenMultiplier = Information.PermanentBuffs[self:GetAttribute("Quirk")]["HealthRegenerationBoost"]
				end
				
				if CanRegenHealth then
					
					for v,p in pairs(self:GetAttributes()) do
						if p and Information.Forms[self:GetAttribute("Quirk")] and Information.Forms[self:GetAttribute("Quirk")][v] and Information.Forms[self:GetAttribute("Quirk")][v]["HealthRegenerationBoost"] then

							HealthRegenMultiplier *= Information.Forms[self:GetAttribute("Quirk")][v]["HealthRegenerationBoost"]

						end
					end
					
				end
				
				if CanRegenHealth then

					if Hum.Health > Hum.MaxHealth then
						Hum.Health = Hum.MaxHealth
					else
						Hum.Health += Hum.MaxHealth*Information.Health_Regeneration_Rate*HealthRegenMultiplier
					end
					
				end

				task.wait(Information.Health_Regeneration_Delay)

			until Hum.Health == Hum.MaxHealth

			RegeneratingHealth = false

		end

	end)

	QuirkModule.QuirkConnections[self]["DurabilityHandler"] = Durability:GetPropertyChangedSignal("Value"):Connect(function()
		Hum.MaxHealth = Information.Starting_Health + Information.Health_Per_Durability*Durability.Value
	end)
	
	local FormsToHandle = 1
	if Information.Forms[self:GetAttribute("Quirk")] then
		for v,p in pairs(Information.Forms[self:GetAttribute("Quirk")]) do
			
			if Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"] then

				QuirkModule.QuirkConnections[self]["FormHandler" .. FormsToHandle] = self:GetAttributeChangedSignal(v):Connect(function()

					if self:GetAttribute(v) then
						
						local Amount, Bind
						if typeof(Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"]) == "table" and Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"][2] then
							if Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"][2] == "%" then
								Amount = self:GetAttribute("MaxStamina")*Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"][1]
								Bind = self:GetAttributeChangedSignal("MaxStamina"):Connect(function()
									Amount = self:GetAttribute("MaxStamina")*Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"][1]
								end)
							else
								Amount = Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"][1]
							end
						else
							Amount = Information.Forms[self:GetAttribute("Quirk")][v]["StaminaConsumption"]
						end 
						
						repeat
							
							Utility.IncrementStamina(self, -Amount, Information.Forms[self:GetAttribute("Quirk")][v]["MoveType"])
							task.wait(Information.Stamina_Modifier_Drain_Rate)

						until not self:GetAttribute(v) or self:GetAttribute("Stamina") < Amount or (self:GetAttribute("Protected") and not Information.Safezone_Whitelisted_Forms[v])
						if Bind then Bind:Disconnect() end
						if self:GetAttribute(v) then
							self:SetAttribute(v, false)
						end
					end

				end)
				FormsToHandle += 1
				
			end
			
			if Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"] then
				
				QuirkModule.QuirkConnections[self]["FormHandler" .. FormsToHandle] = self:GetAttributeChangedSignal(v):Connect(function()
					
					local Amount, Bind
					if typeof(Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"]) == "table" and Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"][1] and Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"][2] then
						if Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"][2] == "%" then
							Amount = Hum.MaxHealth*Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"][1]
							Bind = Hum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
								Amount = Hum.MaxHealth*Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"][1]
							end)
						else
							Amount = Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"][1]
						end
					else
						Amount = Information.Forms[self:GetAttribute("Quirk")][v]["HealthConsumption"]
					end
					
					if self:GetAttribute(v) then
						repeat
							
							Hum.Health -= Amount
							task.wait(Information.Health_Modifier_Drain_Rate)
						
						until not self:GetAttribute(v) or Hum.Health <= Amount*2
						if Bind then Bind:Disconnect() end
						if self:GetAttribute(v) then
							self:SetAttribute(v, false)
						end
					end
					
				end)
				FormsToHandle += 1
				
			end
			
			if Information.Forms[self:GetAttribute("Quirk")][v]["DamageBoost"] then
				
				QuirkModule.QuirkConnections[self]["FormHandler" .. FormsToHandle] = self:GetAttributeChangedSignal(v):Connect(function()
					
					if self:GetAttribute(v) then
						self:SetAttribute("DamageBoost_Quirk", self:GetAttribute("DamageBoost_Quirk")*Information.Forms[self:GetAttribute("Quirk")][v]["DamageBoost"])
					else
						self:SetAttribute("DamageBoost_Quirk", self:GetAttribute("DamageBoost_Quirk")/Information.Forms[self:GetAttribute("Quirk")][v]["DamageBoost"])
					end

				end)
				
			end
			
		end
	end
	
	QuirkModule.QuirkConnections[self]["CharacterBeingRemoved"] = Player.CharacterRemoving:Connect(function()
		if not QuirkModule.QuirkConnections[self] then return end
		QuirkModule.QuirkConnections[self]["CharacterBeingRemoved"]:Disconnect()
		QuirkModule.QuirkConnections[self]["CharacterBeingRemoved"] = nil
		for index, value in pairs(QuirkModule.QuirkConnections[self]) do
			QuirkModule.QuirkConnections[self][index] = QuirkModule.QuirkConnections[self][index]:Disconnect()
			--value:Disconnect()
		end
		QuirkModule.QuirkConnections[self] = nil
	end)
	
end

function QuirkModule:BindTraining(BindedEvent)
	
	if not BindedEvent then return end
	if self and self.Parent == nil then self.AncestryChanged:Wait() end
	local Player = game.Players:GetPlayerFromCharacter(self)

	local Training = false
	local Hum = self.Humanoid or self:WaitForChild("Humanoid")
	local TrainingAssets = script.TrainingAssets
	
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData[Player.Name] or workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
	local EXP = PlayerData.Experience or PlayerData:WaitForChild("Experience")
	
	if not Hum:IsDescendantOf(workspace) then
		Hum.AncestryChanged:Wait()
	end
	
	local SitUpAnimation  = Hum:LoadAnimation(TrainingAssets.SitUp)
	local PushUpAnimation = Hum:LoadAnimation(TrainingAssets.PushUp)

	QuirkModule.QuirkConnections[self]["TrainingBind"] = BindedEvent.OnServerEvent:Connect(function(plr)

		if plr.UserId ~= Player.UserId then return end
		
		if not (plr == Player) then return end

		if not self:GetAttribute("Attacking") and not self:GetAttribute("Stunned") and self:GetAttribute("Stamina") > Information.Punch_Stamina_Cost and not Training then 
			self:SetAttribute("Attacking", true)
			Training = true
			Utility.IncrementStamina(self, -Information.Training_Stamina_Cost)

			local Time

			if math.random(1,2) == 1 then
				SitUpAnimation:Play()
				Time = SitUpAnimation.Length
			else
				PushUpAnimation:Play()
				Time = PushUpAnimation.Length
			end

			EXP.Value += Information.EXP_Gain

			local StillBV = TrainingAssets.TrainingBV:Clone()
			StillBV.Parent = self.HumanoidRootPart

			task.wait(Time)
			StillBV:Destroy()

			Training = false
			self:SetAttribute("Attacking", false)
		end

	end)

end

return QuirkModule
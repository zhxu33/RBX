local SprintModule = {}

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local Utility = require(script.Parent.Utility)

local PlayerConnections = {}

local function Calculate_Speed(Agility)
	local newMultiplier = 1

	if Agility.Value >= Information.Agility_Cap then
		newMultiplier = (Information.Max_Speed/Information.Default_Speed)
	else
		newMultiplier = ((Information.Start_Speed/Information.Default_Speed) + ((Information.Speed_Per_Agility/Information.Default_Speed) * Agility.Value))
	end

	return newMultiplier
end

local function Link_Normal(self, Event)
	if not Event then return end
	if PlayerConnections[self] then return end -- // Character is already connected
	
	local Player = game.Players:GetPlayerFromCharacter(self)
	local Hum = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")

	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(self.Name) or workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name)
	local Agility = PlayerData:FindFirstChild("Agility") or PlayerData:WaitForChild("Agility")

	PlayerConnections[self] = {}
	PlayerConnections[self]["Sprint"] = Event.OnServerEvent:Connect(function(play)
		if play.UserId ~= Player.UserId then return end
		if not (play == Player) then return end

		if not (self:GetAttribute("Running") or self:GetAttribute("Stunned") or self:GetAttribute("Cannot_Run") or (self:GetAttribute("Stamina") <= 2)) then

			self:SetAttribute("Running", true)
			
			local Multiplier = Calculate_Speed(Agility)
			Hum.WalkSpeed   *= Multiplier 
			
			repeat
				if self:GetAttribute("Cannot_Run") then
					self:GetAttributeChangedSignal("Cannot_Run"):Wait()
					Hum.WalkSpeed /= Multiplier -- // Recalculating speed
					Multiplier     = Calculate_Speed(Agility)
					Hum.WalkSpeed *= Multiplier 
				end

				Utility.IncrementStamina(self, -Information.Stamina_Cost_Rate)
				task.wait(Information.Stamina_Cost_Delay)
			until not self:GetAttribute("Running") or (self:GetAttribute("Stamina") < Information.Stamina_Cost_Rate)

			self:SetAttribute("Running", false)
			Hum.WalkSpeed /= Multiplier -- Information.Default_Speed

		elseif self:GetAttribute("Running") and not (self:GetAttribute("Stunned") and self:GetAttribute("Cannot_Run")) then
			self:SetAttribute("Running", false)
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

local function Link_Engine(self, Event)
	if not Event then return end

	local Player = game.Players:GetPlayerFromCharacter(self)
	local HUM = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")

	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(self.Name) or workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name)
	local Agility = PlayerData:FindFirstChild("Agility") or PlayerData:WaitForChild("Agility")

	local EngineAssets = script.EngineAssets
	local RightEngine = self.RightLowerLeg:WaitForChild("EngineLeg")
	local LeftEngine = self.LeftLowerLeg:WaitForChild("EngineLeg")

	local ChargeSound = EngineAssets.ChargeSound:Clone()
	ChargeSound.Parent = self.HumanoidRootPart
	local DashSound = EngineAssets.DashSnd:Clone()
	DashSound.Parent = self.HumanoidRootPart

	local Shockwave = EngineAssets.Shockwave:Clone()
	Shockwave.Parent = self.HumanoidRootPart

	local ChargeAnimation = HUM:LoadAnimation(EngineAssets.Charging)
	local RunningAnimation = HUM:LoadAnimation(EngineAssets.Running)

	PlayerConnections[self] = {}
	PlayerConnections[self]["Sprint"] = Event.OnServerEvent:Connect(function(play)
		if play.UserId ~= Player.UserId then return end
		if not (play == Player) then return end

		if not self:GetAttribute("Engine_Dash") and not self:GetAttribute("Stunned") and not self:GetAttribute("Cannot_Run") and self:GetAttribute("Stamina") > 1 and not self:GetAttribute("Recipro_Burst") then
			self:SetAttribute("Engine_Dash", true)
			ChargeAnimation:Play()
			RightEngine.Smoke.Enabled = true
			LeftEngine.Smoke.Enabled = true
			
			HUM.WalkSpeed /= (18/6)
			
			ChargeSound:Play()
			task.spawn(function()
				for i = 1,15 do
					RightEngine.Glow.Transparency = RightEngine.Glow.Transparency - .05
					LeftEngine.Glow.Transparency = LeftEngine.Glow.Transparency - .05
					if not self:GetAttribute("Engine_Dash") then
						break
					end
					task.wait()
				end
			end)
			wait(.5)
			ChargeAnimation:Stop()
			RightEngine.Glow.Transparency = 1
			LeftEngine.Glow.Transparency = 1
			
			local Multiplier = 1 
			HUM.WalkSpeed   *= (18/6) -- // Speed increase || Because someone decided it's a good idea to have a speed of 6 when using engine 🤯
			
			if self:GetAttribute("Engine_Dash") then
				local SW = Shockwave:Clone()
				SW.Parent = self.HumanoidRootPart
				SW.CFrame = self.HumanoidRootPart.CFrame
				DashSound:Play()
				game.TweenService:Create(SW,TweenInfo.new(0.5),{Transparency = 1}):Play()
				game.TweenService:Create(SW,TweenInfo.new(0.5),{Size = Vector3.new(35,10,35)}):Play()
				game.TweenService:Create(SW,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 10),{Orientation = SW.Orientation + Vector3.new(0,10,0)}):Play()
				game.Debris:AddItem(SW,0.5)
				RunningAnimation:Play()
				
				if self:GetAttribute("Tool_Type") == "EngineBoots" then
					if Agility.Value >= 2000 then
						Multiplier = 15.5 -- // 280 | 15.5 * 18 | Double 140
					else
						Multiplier = (4.5 + (0.0055 * Agility.Value))-- 80 + 0.1 * Agility.Value
					end
				else
					if Agility.Value >= 2000 then
						Multiplier = 13 -- // 240 | 
					else
						Multiplier = (4.5 + (.00425 * Agility.Value)) -- 80 + 0.08 * Agility.Value
					end
				end
				
				HUM.WalkSpeed *= Multiplier
				
				RightEngine.Smoke.Enabled = true
				LeftEngine.Smoke.Enabled = true
				RightEngine.ParticleEmitter.Enabled = true
				LeftEngine.ParticleEmitter.Enabled = true
				RightEngine.Trail.Enabled = true
				LeftEngine.Trail.Enabled = true
				repeat
					game:GetService("RunService").Heartbeat:Wait()
				until self:GetAttribute("Stamina") < 2 or not self:GetAttribute("Engine_Dash") or self:GetAttribute("Recipro_Burst")
			end
			self:SetAttribute("Engine_Dash", false)
			self:SetAttribute("Recipro_Burst", false)
			RunningAnimation:Stop()
			
			--HUM.WalkSpeed = Information.Default_Speed
			HUM.WalkSpeed /= Multiplier
			
			RightEngine.Smoke.Enabled = false
			LeftEngine.Smoke.Enabled = false
			RightEngine.ParticleEmitter.Enabled = false
			LeftEngine.ParticleEmitter.Enabled = false
			RightEngine.Trail.Enabled = false
			LeftEngine.Trail.Enabled = false
			RightEngine.Recipro.Enabled = false
			LeftEngine.Recipro.Enabled = false
			RightEngine.Glow.Transparency = 1
			LeftEngine.Glow.Transparency = 1
		elseif self:GetAttribute("Engine_Dash") and not self:GetAttribute("Stunned") and not self:GetAttribute("Cannot_Run") and not self:GetAttribute("Recipro_Burst") then
			self:SetAttribute("Engine_Dash", false)
		end
	end)

	PlayerConnections[self]["RemovingCharacter"] = Player.CharacterRemoving:Connect(function()
		for index, value in pairs(PlayerConnections[self] or {}) do
			value:Disconnect()
		end
		PlayerConnections[self] = nil
	end)
end

function SprintModule:Link(StartEvent)
	if self:GetAttribute("Quirk") == 0 then
		Link_Engine(self, StartEvent)
	else
		Link_Normal(self, StartEvent)
	end
end

return SprintModule
local SprintModule = {}

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local Utility = require(script.Parent.Utility)

function Calculate_Speed(Agility)
	local Speed
	
	if Agility.Value >= Information.Agility_Cap then
		Speed = Information.Max_Speed
	else
		Speed = Information.Start_Speed + Information.Speed_Per_Agility*Agility.Value
	end
	
	return Speed
end

function Link_Normal(self, Event)
	
	if not Event then return end

	local Player = game.Players:GetPlayerFromCharacter(self)

	local Hum = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")
	
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(self.Name) or workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name)
	local Agility = PlayerData:FindFirstChild("Agility") or PlayerData:WaitForChild("Agility")

	Event.OnServerEvent:Connect(function(play)

		if play.UserId ~= Player.UserId then return end
		if not play then return end
		if not play == Player then return end

		if not self:GetAttribute("Running") and not self:GetAttribute("Stunned") and not self:GetAttribute("Cannot_Run") and self:GetAttribute("Stamina") > 2 then

			self:SetAttribute("Running", true)
			Hum.WalkSpeed = Calculate_Speed(Agility)

			repeat

				if self:GetAttribute("Cannot_Run") then
					self:GetAttributeChangedSignal("Cannot_Run"):Wait()
					Hum.WalkSpeed = Calculate_Speed(Agility)
				end

				Utility.IncrementStamina(self, -Information.Stamina_Cost_Rate)
				wait(Information.Stamina_Cost_Delay)

			until not self:GetAttribute("Running") or self:GetAttribute("Stamina") < Information.Stamina_Cost_Rate

			self:SetAttribute("Running", false)
			Hum.WalkSpeed = Information.Default_Speed

		elseif self:GetAttribute("Running") and not self:GetAttribute("Stunned") and not self:GetAttribute("Cannot_Run") then

			self:SetAttribute("Running", false)

		end

	end)
	
end

function Link_Engine(self, Event)

	if not Event then return end
	
	local Player = game.Players:GetPlayerFromCharacter(self)

	local HUM = self:FindFirstChild("Humanoid") or self:WaitForChild("Humanoid")
	local EngineAssets = script.EngineAssets

	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(self.Name) or workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name)
	local Agility = PlayerData:FindFirstChild("Agility") or PlayerData:WaitForChild("Agility")

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
	
	Event.OnServerEvent:Connect(function(play)

		if play.UserId ~= Player.UserId then return end
		if not play then return end
		if not play == Player then return end

		if not self:GetAttribute("Engine_Dash") and not self:GetAttribute("Stunned") and not self:GetAttribute("Cannot_Run") and self:GetAttribute("Stamina") > 1 and not self:GetAttribute("Recipro_Burst") then
			self:SetAttribute("Engine_Dash", true)
			ChargeAnimation:Play()
			RightEngine.Smoke.Enabled = true
			LeftEngine.Smoke.Enabled = true
			HUM.WalkSpeed = 6
			ChargeSound:Play()
			coroutine.wrap(function()
				for i = 1,15 do
					RightEngine.Glow.Transparency = RightEngine.Glow.Transparency - .05
					LeftEngine.Glow.Transparency = LeftEngine.Glow.Transparency - .05
					if not self:GetAttribute("Engine_Dash") then
						break
					end
					wait()
				end
			end)()
			wait(.5)
			ChargeAnimation:Stop()
			RightEngine.Glow.Transparency = 1
			LeftEngine.Glow.Transparency = 1
			if self:GetAttribute("Engine_Dash") then
				local SW = Shockwave:Clone()
				SW.Parent = self.HumanoidRootPart
				SW.CFrame = self.HumanoidRootPart.CFrame
				DashSound:Play()
				game.TweenService:Create(SW,TweenInfo.new(0.5),{Transparency = 1}):Play()
				game.TweenService:Create(SW,TweenInfo.new(0.5),{Size = Vector3.new(35,10,35)}):Play()
				game.TweenService:Create(SW,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 10, false, wait()),{Orientation = SW.Orientation + Vector3.new(0,10,0)}):Play()
				game.Debris:AddItem(SW,0.5)
				RunningAnimation:Play()
				if self:GetAttribute("Tool_Type") == "EngineBoots" then
					if Agility.Value >= 2000 then
						HUM.WalkSpeed = 280
					else
						HUM.WalkSpeed = 80 + 0.1 * Agility.Value
					end
				else
					if Agility.Value >= 2000 then
						HUM.WalkSpeed = 240
					else
						HUM.WalkSpeed = 80 + 0.08 * Agility.Value
					end
				end
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
			HUM.WalkSpeed = Information.Default_Speed
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
	
end

function SprintModule:Link(StartEvent)
	
	if self:GetAttribute("Quirk") == 0 then
		Link_Engine(self, StartEvent)
	else
		Link_Normal(self, StartEvent)
	end
	
end

return SprintModule
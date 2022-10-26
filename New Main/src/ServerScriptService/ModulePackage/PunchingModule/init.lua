local PunchModule  = {}
local MainModule   = require(game.ServerScriptService.ModulePackage.KnockBack)
local Settings     = require(game.ServerScriptService.CombatScripts.Settings)
local HitboxModule = require(game.ServerScriptService.ModulePackage.SpatialHitbox)

function PunchModule:BindPunching(BindedEvent, Table)
	local Player = game.Players:GetPlayerFromCharacter(self)
	local Quirk = self:GetAttribute("Quirk")
	
	if Quirk == 20 then
		local Punching = false
		local AnimationPick = 1
		local DSAnimationPick = 1
		local ABAnimationPick = 1

		local DarkShadow = self:WaitForChild("DarkShadowModel")
		local AbyssalBody = self:WaitForChild("AbysalBody")

		local Hum = self:WaitForChild("Humanoid")
		local Strength = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name):WaitForChild("Strength")
		local PunchAssets = script.PunchAssets

		local PunchingAnimation = {
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim1),
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim2),
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim3),
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim4)
		}

		local DSPunchingAnimation = {
			Hum:LoadAnimation(PunchAssets.DS.Normal.PunchAnim1),
			Hum:LoadAnimation(PunchAssets.DS.Normal.PunchAnim2)
		}

		local ABPunchingAnimation = {
			Hum:LoadAnimation(PunchAssets.DS.Abyssal.PunchAnim1),
			Hum:LoadAnimation(PunchAssets.DS.Abyssal.PunchAnim2)
		}

		BindedEvent.OnServerEvent:Connect(function(plr)
			if plr.UserId ~= Player.UserId then return end
			if not (plr == Player) then return end

			if not self:GetAttribute("Attacking") and not self:GetAttribute("Stunned") and self:GetAttribute("Stamina") > Settings.Punch_Stamina_Cost and not Punching then
				self:SetAttribute("Punching", true)
				self:SetAttribute("Attacking", true)
				Punching = true
				MainModule.IncrementStamina(self, -Settings.Punch_Stamina_Cost)

				local CurrentAnimation
				local Form = 1

				local Arm
				if self:GetAttribute("AbyssalBody") then
					
					if ABAnimationPick == 2 then
						Arm = "LeftLowerArm"
					else
						Arm = "RightLowerArm"
					end

					for i,v in pairs(AbyssalBody[Arm]:GetChildren()) do
						if v:IsA("Trail") then
							v.Enabled = true
						end
					end
				elseif self:GetAttribute("DarkShadow") then

					if DSAnimationPick == 2 then
						Arm = "Hand right"
					else
						Arm = "Hand left"
					end

					for i,v in pairs(DarkShadow[Arm]:GetChildren()) do
						if v:IsA("Trail") then
							v.Enabled = true
						end
					end
				end

				if self:GetAttribute("AbyssalBody") then
					Form = 3
					CurrentAnimation = ABPunchingAnimation[ABAnimationPick]
				elseif self:GetAttribute("DarkShadow") then
					Form = 2
					CurrentAnimation = DSPunchingAnimation[DSAnimationPick]
				else
					CurrentAnimation = PunchingAnimation[AnimationPick]
				end

				CurrentAnimation:Play()

				local Hitbox = PunchAssets.PunchHitbox:Clone()
				Hitbox.Parent = self.HumanoidRootPart

				local Weld = Hitbox.Motor6D
				Weld.Part1 = self.HumanoidRootPart
				Weld.C0 = CFrame.new(Vector3.new(0, 0, 2))
				if Form == 2 then
					Weld.C1 *= CFrame.new(0, 0, -4)
				end

				local DMG
				if Settings.Forms[self:GetAttribute("Quirk")] then
					for v,p in pairs(self:GetAttributes()) do
						if p and Settings.Forms[self:GetAttribute("Quirk")][v] and Settings.Forms[self:GetAttribute("Quirk")][v]["PunchMultiplier"] then
							DMG = Settings.Forms[self:GetAttribute("Quirk")][v]["PunchMultiplier"]
							break
						end
					end
				end
				
				local newSettings       = HitboxModule:GetSettings()
				newSettings.Player      = self
				newSettings.HitboxType  = "box"
				newSettings.AttackId    = {
					["Damage"]     = DMG or Settings.Base_Punch_Multiplier,
					["DamageType"] = "Quirk"
				}
				newSettings.HitSound    = PunchAssets.HitSound
				newSettings.GetFullBody = false
				newSettings.VelocityType = "Light"
				HitboxModule:Add(Hitbox, newSettings)

				wait(CurrentAnimation.Length)
				Hitbox:Destroy()

				if Form == 3 then
					if ABAnimationPick == #ABPunchingAnimation then
						ABAnimationPick = 1
					else
						ABAnimationPick += 1
					end
					
					if AbyssalBody:FindFirstChild(Arm) then
						for i,v in pairs(AbyssalBody[Arm]:GetChildren()) do
							if v:IsA("Trail") then
								v.Enabled = false
							end
						end
					end
				elseif Form == 2 then
					if DSAnimationPick == #DSPunchingAnimation then
						DSAnimationPick = 1
					else
						DSAnimationPick += 1
					end
					
					if DarkShadow:FindFirstChild(Arm) then
						for i,v in pairs(DarkShadow[Arm]:GetChildren()) do
							if v:IsA("Trail") then
								v.Enabled = false
							end
						end
					end
				else
					if AnimationPick == #PunchingAnimation then
						AnimationPick = 1
					else
						AnimationPick += 1
					end
				end

				Punching = false
				self:SetAttribute("Attacking", false)
				self:SetAttribute("Punching", false)
			end
		end)
	else

		local Punching = false
		local AnimationPick = 1

		local Hum = self:WaitForChild("Humanoid")
		local Strength = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(self.Name):WaitForChild("Strength")
		local PunchAssets = script.PunchAssets

		local PunchingAnimation = Table or {
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim1),
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim2),
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim3),
			Hum:LoadAnimation(PunchAssets.Normal.PunchAnim4)
		}

		BindedEvent.OnServerEvent:Connect(function(plr)
			if plr.UserId ~= Player.UserId then return end
			if not (plr == Player) then return end

			if not self:GetAttribute("Attacking") and not self:GetAttribute("Stunned") and self:GetAttribute("Stamina") > Settings.Punch_Stamina_Cost and not Punching then
				self:SetAttribute("Punching", true)
				self:SetAttribute("Attacking", true)
				Punching = true
				MainModule.IncrementStamina(self, -Settings.Punch_Stamina_Cost)
				PunchingAnimation[AnimationPick]:Play()
				
				local Hitbox
				
				if self:GetAttribute("Gigantification") then
					
					Hitbox = script.PunchAssets.GigantoHitbox:Clone()
					Hitbox.Parent = self.HumanoidRootPart
					Hitbox.Size = Hitbox.Size*Hum.BodyDepthScale.Value
					Hitbox.Weld.Part1 = self.HumanoidRootPart
					Hitbox.Weld.C0 = CFrame.new(Vector3.new(0, 0, 1.5*Hum.BodyDepthScale.Value))
					
				else
					
					Hitbox = script.PunchAssets.PunchHitbox:Clone()
					Hitbox.Parent = self.HumanoidRootPart
					Hitbox.Motor6D.Part1 = self.HumanoidRootPart
					Hitbox.Motor6D.C0 = CFrame.new(Vector3.new(0, 0, 2))
					
				end

				local DMG
				if Settings.Forms[self:GetAttribute("Quirk")] then
					for v,p in pairs(self:GetAttributes()) do

						if p and Settings.Forms[self:GetAttribute("Quirk")][v] and Settings.Forms[self:GetAttribute("Quirk")][v]["PunchMultiplier"] then

							DMG = Settings.Forms[self:GetAttribute("Quirk")][v]["PunchMultiplier"]
							break

						end

					end
				end
				
				local newSettings       = HitboxModule:GetSettings()
				newSettings.Player      = self
				newSettings.HitboxType  = "box"
				newSettings.AttackId    = {
					["Damage"]     = DMG or Settings.Base_Punch_Multiplier,
					["DamageType"] = "Quirk"
				}
				newSettings.HitSound     = PunchAssets.HitSound
				newSettings.GetFullBody  = false
				newSettings.VelocityType = "Light"
				HitboxModule:Add(Hitbox, newSettings)

				wait(PunchingAnimation[AnimationPick].Length)
				Hitbox:Destroy()

				if AnimationPick == #PunchingAnimation then
					AnimationPick = 1
				else
					AnimationPick += 1
				end

				Punching = false
				self:SetAttribute("Attacking", false)
				self:SetAttribute("Punching", false)
			end
		end)
	end
end

return PunchModule

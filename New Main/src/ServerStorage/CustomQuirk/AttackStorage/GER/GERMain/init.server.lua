local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
wait()
local SwordAttack = false
local Dashing = false
local AnimationsFolder = script.Animations
local Sword_1 = Humanoid:LoadAnimation(AnimationsFolder.Sword_1)
local Sword_2 = Humanoid:LoadAnimation(AnimationsFolder.Sword_2)
local Sword_3 = Humanoid:LoadAnimation(AnimationsFolder.Sword_3)
local SnowSwordSlash = Humanoid:LoadAnimation(AnimationsFolder.SnowSwordSlash)
local SnowSword_1 = Humanoid:LoadAnimation(AnimationsFolder.SnowSword_1)
local SnowSword_2 = Humanoid:LoadAnimation(AnimationsFolder.SnowSword_2)
local SnowSword_3 = Humanoid:LoadAnimation(AnimationsFolder.SnowSword_3)
local DualSword_1 = Humanoid:LoadAnimation(AnimationsFolder.DualSword_1)
local DualSword_2 = Humanoid:LoadAnimation(AnimationsFolder.DualSword_2)
local DualSword_3 = Humanoid:LoadAnimation(AnimationsFolder.DualSword_3)
local EasterKatana_1 = Humanoid:LoadAnimation(AnimationsFolder.EasterKatana_1)
local EasterKatana_2 = Humanoid:LoadAnimation(AnimationsFolder.EasterKatana_2)
local EasterKatana_3 = Humanoid:LoadAnimation(AnimationsFolder.EasterKatana_3)
local DualEasterKatana_1 = Humanoid:LoadAnimation(AnimationsFolder.DualEasterKatana_1)
local DualEasterKatana_2 = Humanoid:LoadAnimation(AnimationsFolder.DualEasterKatana_2)
local DualEasterKatana_3 = Humanoid:LoadAnimation(AnimationsFolder.DualEasterKatana_3)
local EasterKatanaSupaAnim = Humanoid:LoadAnimation(AnimationsFolder.EasterKatanaSupa)
local DualEasterKatanaSupaAnim = Humanoid:LoadAnimation(AnimationsFolder.DualEasterKatanaSupa)
local EasterKatanaSheathAnim = Humanoid:LoadAnimation(AnimationsFolder.EasterKatanaSheath)
local DualEasterKatanaSheathAnim = Humanoid:LoadAnimation(AnimationsFolder.DualEasterKatanaSheath)
local DualSwordXSlash = Humanoid:LoadAnimation(AnimationsFolder.DualSwordXSlash)
local Scythe_1 = Humanoid:LoadAnimation(AnimationsFolder.ScytheSwing_1)
local Scythe_2 = Humanoid:LoadAnimation(AnimationsFolder.ScytheSwing_2)
local Scythe_3 = Humanoid:LoadAnimation(AnimationsFolder.ScytheSwing_3)
local DualScytheSwing_1 = Humanoid:LoadAnimation(AnimationsFolder.DualScytheSwing_1)
local DualScytheSwing_2 = Humanoid:LoadAnimation(AnimationsFolder.DualScytheSwing_2)
local DualScytheSwing_3 = Humanoid:LoadAnimation(AnimationsFolder.DualScytheSwing_3)
local Hammer_1 = Humanoid:LoadAnimation(AnimationsFolder.HammerSwing_1)
local Hammer_2 = Humanoid:LoadAnimation(AnimationsFolder.HammerSwing_2)
local HammerSlamAnim = Humanoid:LoadAnimation(AnimationsFolder.HammerSlam)
local Staff_1 = Humanoid:LoadAnimation(AnimationsFolder.Staff_1)
local Staff_2 = Humanoid:LoadAnimation(AnimationsFolder.Staff_2)
local StaffSupaAnim = Humanoid:LoadAnimation(AnimationsFolder.EasterStaffSupa)
local StaffWalkAnim = Humanoid:LoadAnimation(AnimationsFolder.StaffWalk)
local PumpkinPistolSupaAnim = Humanoid:LoadAnimation(AnimationsFolder.PumpkinPistolSupa)
local CandyGunSupaAnim = Humanoid:LoadAnimation(AnimationsFolder.CandyGunSupa)
local CandyGunShootAnim = Humanoid:LoadAnimation(AnimationsFolder.CandyGunShoot)
local CandyCaneIdleAnim = Humanoid:LoadAnimation(AnimationsFolder.CandyGunIdle)
local GunAnim = Humanoid:LoadAnimation(AnimationsFolder.Gun)
local Gun2Anim = Humanoid:LoadAnimation(AnimationsFolder.Gun2)
local UpDashAnim = Humanoid:LoadAnimation(AnimationsFolder.UpDash)
local FrontDashAnim = Humanoid:LoadAnimation(AnimationsFolder.FrontDash)
local BackDashAnim = Humanoid:LoadAnimation(AnimationsFolder.BackDash)
local LeftDashAnim = Humanoid:LoadAnimation(AnimationsFolder.LeftDash)
local RightDashAnim = Humanoid:LoadAnimation(AnimationsFolder.RightDash)
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerFolder = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Level = PlayerFolder.Level
local Exp = PlayerFolder.Experience
local Strength = PlayerFolder.Strength
local Agility = PlayerFolder.Agility
local Durability = PlayerFolder.Durability
local Quirk = PlayerFolder.Quirk
local Attack = Character:WaitForChild("Attack")
local Stamina = Character:WaitForChild("Stamina")
local ArmorDefense = Instance.new("NumberValue", Character)
ArmorDefense.Value = 0 
ArmorDefense.Name = "ArmorDefense"
local Katana = game.ServerStorage:WaitForChild("Weapons"):WaitForChild("Katana")
local SwordEF = game.ServerStorage:WaitForChild("Weapons"):WaitForChild("WeaponEffects"):WaitForChild("KatanaEffect")
local Equip = script:WaitForChild("Equip")
local Swing = script:WaitForChild("Swing")
local Dash = script:WaitForChild("Dash")
local RightSwing = script:WaitForChild("RightSwing")
local WeaponType = Instance.new("StringValue", Character)
WeaponType.Name = "WeaponType"
WeaponType.Value = "N/A"
local ToolType = Instance.new("StringValue", Character)
ToolType.Name = "ToolType"
ToolType.Value = "N/A"
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local TweenService = game:GetService("TweenService")
local OrigIdleAnim = Character.Animate.idle.Animation1.AnimationId
function CreateSwordEF(Cframe)
	local SwordEffect = SwordEF:Clone()
	SwordEffect.Parent = script
	SwordEffect.CFrame = Cframe
	TweenService:Create(SwordEffect, TweenInfo.new(0.5),{Transparency = 1}):Play()
	game.Debris:AddItem(SwordEffect,0.5)
end

Humanoid.Died:Connect(function()
	repeat wait(.1)
		Attack.Value = true
	until Character == nil
end)

ToolType.Changed:Connect(function(Type)
	if Type == "SantaArmor" then
		local SantaArmor = Character:WaitForChild("SantaArmor")
		local Tier = SantaArmor:FindFirstChild("TierValue")
		if Tier.Value == 1 then
			ArmorDefense.Value = Durability.Value*0.75
		elseif Tier.Value == 2 then
			ArmorDefense.Value = Durability.Value
		elseif Tier.Value == 3 then
			ArmorDefense.Value = Durability.Value*1.25
		elseif Tier.Value == 4 then
			ArmorDefense.Value = Durability.Value*1.5
		end
	elseif Type == "PumpkinArmor" then
		local PumpkinArmor = Character:WaitForChild("PumpkinArmor")
		local Tier = PumpkinArmor:FindFirstChild("TierValue")
		if Tier.Value == 1 then
			ArmorDefense.Value = Durability.Value*0.75
		elseif Tier.Value == 2 then
			ArmorDefense.Value = Durability.Value
		elseif Tier.Value == 3 then
			ArmorDefense.Value = Durability.Value*1.25
		elseif Tier.Value == 4 then
			ArmorDefense.Value = Durability.Value*1.5
		end
	elseif Type == "BunnyEars" then
		ArmorDefense.Value = Durability.Value*1.25
	else
		ArmorDefense.Value = 0
	end
end)

WeaponType.Changed:Connect(function(Type)
	if Type == "Katana" then
		local Sword = Character.RightHand:WaitForChild("Katana")
		local Blade = Sword:WaitForChild("Blade")
		local DmgMultiplier = Sword:WaitForChild("DMG")
		Blade.Touched:Connect(function(hit)
			if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				SwordAttack = false
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
				if HRT:FindFirstChild("Light") == nil then
					DmgFunction:Fire(Character,hum,23*Strength.Value/2*DmgMultiplier.Value)
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(10000,10000,10000)
					Velocity.Velocity = RootPart.CFrame.lookVector * 40
					Velocity.Name = "Light"
					CreateSwordEF(Blade.CFrame)
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.1)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
					wait()
					Velocity:Destroy()
				end
			end
		end)
	elseif Type == "Dagger" then
		local Sword = Character.RightHand:WaitForChild("Dagger")
		local Blade = Sword:WaitForChild("Blade")
		local DmgMultiplier = Sword:WaitForChild("DMG")
		Blade.Touched:Connect(function(hit)
			if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				SwordAttack = false
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
				if HRT:FindFirstChild("Light") == nil then
					DmgFunction:Fire(Character,hum,26*Strength.Value/2*DmgMultiplier.Value)
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(10000,10000,10000)
					Velocity.Velocity = RootPart.CFrame.lookVector * 40
					Velocity.Name = "Light"
					CreateSwordEF(Blade.CFrame)
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.1)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
					wait()
					Velocity:Destroy()
				end
			end
		end)
	elseif Type == "SnowSword" then
		local Sword = Character.RightHand:WaitForChild("SnowSword")
		local Blade = Sword:WaitForChild("Blade")
		local DmgMultiplier = Sword:WaitForChild("DMG")
		Blade.Touched:Connect(function(hit)
			if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				SwordAttack = false
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
				if HRT:FindFirstChild("Light") == nil then
					DmgFunction:Fire(Character,hum,45*Strength.Value/2*DmgMultiplier.Value)
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(10000,10000,10000)
					Velocity.Velocity = RootPart.CFrame.lookVector * 40
					Velocity.Name = "Light"
					CreateSwordEF(Blade.CFrame)
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.1)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
					wait()
					Velocity:Destroy()
				end
			end
		end)
		if Character.LeftHand:FindFirstChild("SnowSword") then
			local Sword2 = Character.LeftHand:WaitForChild("SnowSword")
			local Blade2 = Sword:WaitForChild("Blade")
			local DmgMultiplier2 = Sword:WaitForChild("DMG")
			Blade2.Touched:Connect(function(hit)
				if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					SwordAttack = false
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
					if HRT:FindFirstChild("Light") == nil then
						DmgFunction:Fire(Character,hum,45*Strength.Value/2*DmgMultiplier.Value)
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(10000,10000,10000)
						Velocity.Velocity = RootPart.CFrame.lookVector * 40
						Velocity.Name = "Light"
						CreateSwordEF(Blade.CFrame)
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.1)
						if hum.Health < 1 then
							if game.Players:GetPlayerFromCharacter(hum.Parent) then
								local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
								local enemyplrFame = enemyplrf.Fame
								if enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
								elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
								end
							end
						end
						wait()
						Velocity:Destroy()
					end
				end
			end)
		end
	elseif Type == "EasterKatana" then
		local Sword = Character.RightHand:WaitForChild("EasterKatana")
		local Blade = Sword:WaitForChild("Blade")
		local DmgMultiplier = Sword:WaitForChild("DMG")
		if DmgMultiplier.Value == 1 then
			EasterKatanaSheathAnim:Play()
		else
			DualEasterKatanaSheathAnim:Play()
		end
		Blade.Touched:Connect(function(hit)
			if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				SwordAttack = false
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
				if HRT:FindFirstChild("Light") == nil then
					DmgFunction:Fire(Character,hum,45*Strength.Value/2*DmgMultiplier.Value)
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(10000,10000,10000)
					Velocity.Velocity = RootPart.CFrame.lookVector * 40
					Velocity.Name = "Light"
					CreateSwordEF(Blade.CFrame)
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.1)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
					wait()
					Velocity:Destroy()
				end
			end
		end)
		if Character.LeftHand:FindFirstChild("EasterKatana") then
			local Sword2 = Character.LeftHand:WaitForChild("EasterKatana")
			local Blade2 = Sword:WaitForChild("Blade")
			local DmgMultiplier2 = Sword:WaitForChild("DMG")
			Blade2.Touched:Connect(function(hit)
				if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					SwordAttack = false
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
					if HRT:FindFirstChild("Light") == nil then
						DmgFunction:Fire(Character,hum,45*Strength.Value/2*DmgMultiplier.Value)
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(10000,10000,10000)
						Velocity.Velocity = RootPart.CFrame.lookVector * 40
						Velocity.Name = "Light"
						CreateSwordEF(Blade.CFrame)
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.1)
						if hum.Health < 1 then
							if game.Players:GetPlayerFromCharacter(hum.Parent) then
								local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
								local enemyplrFame = enemyplrf.Fame
								if enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
								elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
								end
							end
						end
						wait()
						Velocity:Destroy()
					end
				end
			end)
		end
	elseif Type == "HalloweenScythe" then
		local Scythe = Character.RightHand:WaitForChild("HalloweenScythe")
		local DmgMultiplier = Scythe:WaitForChild("DMG")
		Scythe.HB.Touched:Connect(function(hit)
			if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				SwordAttack = false
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
				if HRT:FindFirstChild("Light") == nil then
					DmgFunction:Fire(Character,hum,45*Strength.Value/2*DmgMultiplier.Value)
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(10000,10000,10000)
					Velocity.Velocity = RootPart.CFrame.lookVector * 40
					Velocity.Name = "Light"
					CreateSwordEF(Scythe.Blade.CFrame)
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.1)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
					wait()
					Velocity:Destroy()
				end
			end
		end)
		if DmgMultiplier.Value == 1 then
			Character.Animate.idle.Animation1.AnimationId = "rbxassetid://2594705012"
		elseif DmgMultiplier.Value >= 1 then
			Character.Animate.idle.Animation1.AnimationId = "rbxassetid://4352868646"
		end
	elseif Type == "EasterStaff" then
		Character.Animate.idle.Animation1.AnimationId = "rbxassetid://507766666"
		StaffWalkAnim:Play()
	elseif Type == "BanHammer" then
		local BanHammer = Character.RightHand:WaitForChild("BanHammer")
		local Blade = BanHammer:WaitForChild("Blade")
		Blade.Touched:Connect(function(hit)
			if SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				SwordAttack = false
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
				if HRT:FindFirstChild("Light") == nil then
					DmgFunction:Fire(Character,hum,50*Strength.Value/2)
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					Velocity.Velocity = RootPart.CFrame.lookVector * 100
					Velocity.Name = "Heavy"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.7)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
					wait()
					Velocity:Destroy()
				end
			end
		end)
	elseif Type ~= "HalloweenScythe" or Type ~= "EasterStaff" then
		Character.Animate.idle.Animation1.AnimationId = OrigIdleAnim
		StaffWalkAnim:Stop()
	end
end)

Dash.OnServerEvent:Connect(function(play,DashType)
	if Stamina.Value >= 25 and Attack.Value == false and Dashing == false and not RootPart:FindFirstChild("Heavy") and not RootPart:FindFirstChild("Light") then
		if DashType == "Up" and Quirk.Value == 6 or DashType == "Up" and Player.Name == "xlxAuroraxIx" or Player.Name == "xlxAuroraxlx" or Player.Name == "TONYSTANKED" or Quirk.Value == 15 and DashType == "Up" then 
			return end
		Stamina.Value = Stamina.Value - 25
		Attack.Value = true
		Dashing = true
		local Velocity = Instance.new("BodyVelocity")
		Velocity.Name = "Skill"
		Humanoid.AutoRotate = false
		Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		if DashType == "Front" then
			FrontDashAnim:Play()
			wait(.1)
			Velocity.Parent = RootPart
			if Agility.Value >= 2000 then
				Velocity.Velocity = RootPart.CFrame.lookVector * 325
			else
				Velocity.Velocity = RootPart.CFrame.lookVector * (125 + Agility.Value * .1)
			end
			game.Debris:AddItem(Velocity,.4)
			local endin = coroutine.wrap(function()
				wait(.4)
				FrontDashAnim:Stop()
			end)
			endin()
		elseif DashType == "Back" then
			BackDashAnim:Play()
			wait(.1)
			Velocity.Parent = RootPart
			if Agility.Value >= 2000 then
				Velocity.Velocity = RootPart.CFrame.lookVector * -325
			else
				Velocity.Velocity = RootPart.CFrame.lookVector * -(125 + Agility.Value * .1)
			end
			game.Debris:AddItem(Velocity,.4)
		elseif DashType == "Left" then
			LeftDashAnim:Play()
			wait(.1)
			Velocity.Parent = RootPart
			if Agility.Value >= 2000 then
				Velocity.Velocity = RootPart.CFrame.rightVector * -325
			else
				Velocity.Velocity = RootPart.CFrame.rightVector * -(125 + Agility.Value * .1)
			end
			game.Debris:AddItem(Velocity,.4)
		elseif DashType == "Right" then
			RightDashAnim:Play()
			wait(.1)
			Velocity.Parent = RootPart
			if Agility.Value >= 2000 then
				Velocity.Velocity = RootPart.CFrame.rightVector * 325
			else
				Velocity.Velocity = RootPart.CFrame.rightVector * (125 + Agility.Value * .1)
			end
			game.Debris:AddItem(Velocity,.4)
		elseif DashType == "Up" then
			UpDashAnim:Play()
			wait(.1)
			Velocity.Parent = RootPart
			Velocity.Velocity = RootPart.CFrame.upVector * 100
			game.Debris:AddItem(Velocity,.3)
			local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
			UpDashEf.Parent = script
			UpDashEf.CFrame = RootPart.CFrame
			game.Debris:AddItem(UpDashEf,0.5)
			TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(35,0.05,35)}):Play()
			TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
		end
		wait(.5)
		Humanoid.AutoRotate = true
		Attack.Value = false
		wait(.1)
		Dashing = false
	end
end)

local CanFreeze = true
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
function FreezeHumanoid(hum, HRT, amount)
	if CanFreeze == true and not PartyFinder:Invoke(Player, hum.Parent) and not HRT.Parent:FindFirstChild("ForceField") then -- Don't freeze party members
		local coo = coroutine.wrap(function()
			hum.PlatformStand = true
			HRT.Anchored = true
			if not HRT:FindFirstChild("FrozenScript") then
				local FrozenScript = game.ServerStorage.FrozenScript:Clone()
				local FrozenTime = game.ServerStorage.FrozenTime:Clone()
				FrozenTime.Name = 'FrozenTime'
				FrozenTime.Parent = HRT
				FrozenTime.Value = amount
				FrozenScript.Parent = HRT
			else
				HRT.FrozenScript:Destroy()
				HRT.FrozenTime:Destroy()
				local FrozenScript = game.ServerStorage.FrozenScript:Clone()
				local FrozenTime = game.ServerStorage.FrozenTime:Clone()
				FrozenTime.Name = 'FrozenTime'
				FrozenTime.Parent = HRT
				FrozenTime.Value = amount
				FrozenScript.Parent = HRT
			end
			wait(.1)
			local Frozen = game.ServerStorage.Frozen:Clone()
			Frozen.Parent = script
			Frozen.Name = Player.Name
			Frozen.CFrame = HRT.CFrame
			game.Debris:AddItem(Frozen, amount)
			--            wait(amount)
			--            Frozen:Destroy()
			--            hum.PlatformStand = false
			--            HRT.Anchored = false
		end)
		coo()
	end
end

Humanoid.Died:Connect(function()
	CanFreeze = false
end)

local Anim = 1
local GunAnimType = 1
local cooldown = false
local SupaSwing = false
RightSwing.OnServerEvent:Connect(function(play,direc)
	if WeaponType.Value == "HalloweenScythe" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then
		local Scythe = Character.RightHand:FindFirstChild("HalloweenScythe")
		local DmgMultiplier = Scythe:FindFirstChild("DMG")
		if DmgMultiplier.Value == 1 then
			if Anim == 1 then
				Scythe_1:Play()
				Anim = 2
			elseif Anim == 2 then
				Scythe_2:Play()
				Anim = 3
			elseif Anim == 3 then
				Scythe_3:Play()
				Anim = 1
			end
			local Clone = game.ServerStorage.Weapons.WeaponEffects.HalloweenBossEffect2:Clone()
			Clone.CFrame = RootPart.CFrame*CFrame.new(0,0,10)*CFrame.Angles(math.rad(90),math.rad(90),math.rad(90))
			local BV = Instance.new("BodyVelocity", Clone)
			BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			BV.Velocity = RootPart.CFrame.lookVector * 200
			Clone.Parent = script
			game.Debris:AddItem(Clone,2)
			local coo = coroutine.wrap(function()
				wait(1)
				for i,v in pairs(Clone:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v.Enabled = false
					end
				end
				wait(.5)
				for i,v in pairs(Clone:GetChildren()) do
					if v:IsA("Trail") then
						v.Enabled = false
					end
				end
				TweenService:Create(Clone,TweenInfo.new(.4),{Transparency = 1}):Play()
			end)
			coo()
			local PlayersHitted = {}
			Clone.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.25)
						if hum.Health < 1 then
							if game.Players:GetPlayerFromCharacter(hum.Parent) then
								local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
								local enemyplrFame = enemyplrf.Fame
								if enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
								elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
								end
							end
						end
					end
				end
			end)
			local Scythe = Character.RightHand:FindFirstChild("HalloweenScythe")
			for i,Trail in pairs(Scythe.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			Attack.Value = true
			SupaSwing = true
			cooldown = true
			Stamina.Value = Stamina.Value - 25
			wait(.6)
			for i,Trail in pairs(Scythe.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end
			cooldown = false
			Attack.Value = false
			wait(3)
			SupaSwing = false
		elseif DmgMultiplier.Value > 1 then
			if Anim == 1 then
				DualScytheSwing_1:Play()
				Anim = 2
			elseif Anim == 2 then
				DualScytheSwing_2:Play()
				Anim = 3
			elseif Anim == 3 then
				DualScytheSwing_3:Play()
				Anim = 1
			end
			local AttackAngles = {CFrame.Angles(math.rad(0),math.rad(-72),math.rad(0)),CFrame.Angles(math.rad(0),math.rad(-81),math.rad(0)),
				CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),CFrame.Angles(math.rad(0),math.rad(-99),math.rad(0)),CFrame.Angles(math.rad(0),math.rad(-108),math.rad(0))}
			local PlayersHitted = {}
			for i=1, 5 do
				local Clone = game.ServerStorage.Weapons.WeaponEffects.HalloweenBossEffect2:Clone()
				Clone.CFrame = RootPart.CFrame*CFrame.new(0,0,10)*AttackAngles[i]
				local BV = Instance.new("BodyVelocity", Clone)
				BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				BV.Velocity = Clone.CFrame.RightVector*-200
				Clone.Parent = script
				game.Debris:AddItem(Clone,2)
				local coo = coroutine.wrap(function()
					wait(1)
					for i,v in pairs(Clone:GetChildren()) do
						if v:IsA("ParticleEmitter") then
							v.Enabled = false
						end
					end
					wait(.5)
					for i,v in pairs(Clone:GetChildren()) do
						if v:IsA("Trail") then
							v.Enabled = false
						end
					end
					TweenService:Create(Clone,TweenInfo.new(.4),{Transparency = 1}):Play()
				end)
				coo()
				Clone.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
						if HRT:FindFirstChild("Light") == nil then
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							Velocity.Name = "Light"
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.25)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
						end
					end
				end)
			end
			local Scythe = Character.RightHand:FindFirstChild("HalloweenScythe")
			for i,Trail in pairs(Scythe.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			Attack.Value = true
			SupaSwing = true
			cooldown = true
			Stamina.Value = Stamina.Value - 25
			wait(.6)
			for i,Trail in pairs(Scythe.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end
			cooldown = false
			Attack.Value = false
			wait(4)
			SupaSwing = false
		end
	elseif WeaponType.Value == "SnowSword" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then
		local Sword = Character.RightHand:FindFirstChild("SnowSword")
		local DmgMultiplier = Sword:FindFirstChild("DMG")
		Attack.Value = true
		SupaSwing = true
		cooldown = true
		Stamina.Value = Stamina.Value - 25
		if DmgMultiplier.Value == 1 then
			SnowSwordSlash:Play()
			wait(.3)
			local Clone = game.ServerStorage.Weapons.WeaponEffects.SantaSliceEffect:Clone()
			Clone.CFrame = RootPart.CFrame*CFrame.new(11,15,10)*CFrame.Angles(math.rad(90),math.rad(-45),math.rad(90))
			local HB = Instance.new("Part", Clone)
			HB.Anchored = false
			HB.CanCollide = false
			HB.Name = "HB"
			HB.Massless = true
			HB.Size = Vector3.new(20,50,50)
			HB.CFrame = Clone.CFrame
			HB.Transparency = 1
			local Weld = Instance.new("Weld", Clone)
			Weld.Part0 = Clone
			Weld.Part1 = HB
			Weld.C1 = Weld.C1*CFrame.Angles(math.rad(45),math.rad(0),math.rad(0))
			local BV = Instance.new("BodyVelocity", Clone)
			BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			BV.Velocity = RootPart.CFrame.lookVector * 200
			Clone.Parent = script
			game.Debris:AddItem(Clone,2)
			local coo = coroutine.wrap(function()
				wait(1)
				for i,v in pairs(Clone:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v.Enabled = false
					end
				end
				wait(.5)
				for i,v in pairs(Clone:GetChildren()) do
					if v:IsA("Trail") then
						v.Enabled = false
					end
				end
				TweenService:Create(Clone,TweenInfo.new(.4),{Transparency = 1}):Play()
			end)
			coo()
			local PlayersHitted = {}
			HB.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.25)
						if hum.Health < 1 then
							if game.Players:GetPlayerFromCharacter(hum.Parent) then
								local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
								local enemyplrFame = enemyplrf.Fame
								if enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
								elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
								end
							end
						end
					end
				end
			end)
			local Sword = Character.RightHand:FindFirstChild("SnowSword")
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			wait(.6)
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end
			cooldown = false
			Attack.Value = false
			wait(3)
			SupaSwing = false
		elseif DmgMultiplier.Value > 1 then
			DualSwordXSlash:Play()
			wait(.3)
			local AttackAngles = {CFrame.Angles(math.rad(90),math.rad(45),math.rad(90)),CFrame.Angles(math.rad(90),math.rad(-45),math.rad(90))}
			local PlayersHitted = {}
			for i=1, 2 do
				local Clone = game.ServerStorage.Weapons.WeaponEffects.SantaSliceEffect:Clone()
				Clone.CFrame = RootPart.CFrame*CFrame.new(0,15,10)*AttackAngles[i]
				local HB = Instance.new("Part", Clone)
				HB.Anchored = false
				HB.CanCollide = false
				HB.Name = "HB"
				HB.Massless = true
				HB.Size = Vector3.new(20,50,50)
				HB.CFrame = Clone.CFrame
				HB.Transparency = 1
				local Weld = Instance.new("Weld", Clone)
				Weld.Part0 = Clone
				Weld.Part1 = HB
				Weld.C1 = Weld.C1*CFrame.Angles(math.rad(45),math.rad(0),math.rad(0))
				local BV = Instance.new("BodyVelocity", Clone)
				BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				BV.Velocity = RootPart.CFrame.lookVector * 200
				Clone.Parent = script
				game.Debris:AddItem(Clone,2)
				local coo = coroutine.wrap(function()
					wait(1)
					for i,v in pairs(Clone:GetChildren()) do
						if v:IsA("ParticleEmitter") then
							v.Enabled = false
						end
					end
					wait(.5)
					for i,v in pairs(Clone:GetChildren()) do
						if v:IsA("Trail") then
							v.Enabled = false
						end
					end
					TweenService:Create(Clone,TweenInfo.new(.4),{Transparency = 1}):Play()
				end)
				coo()
				HB.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						DmgFunction:Fire(Character, hum, 70*Strength.Value/2)
						if HRT:FindFirstChild("Light") == nil then
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							Velocity.Name = "Light"
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.25)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
						end
					end
				end)
			end
			local Sword = Character.RightHand:FindFirstChild("SnowSword")
			local Sword2 = Character.LeftHand:FindFirstChild("SnowSword")
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			wait(.6)
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end
			cooldown = false
			Attack.Value = false
			wait(4)
			SupaSwing = false
		end
	elseif WeaponType.Value == "PumpkinPistol" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		SupaSwing = true
		cooldown = true
		Stamina.Value = Stamina.Value - 25
		PumpkinPistolSupaAnim:Play()
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.Size = Vector3.new(2,2,2)
		pp.CFrame = CFrame.new(pp.CFrame.p, direc.p)
		local cframe = pp.CFrame
		wait(0.5)
		pp.Anchored = false
		local Laser = game.ServerStorage.Weapons.WeaponEffects.PumpkinPistolLaser:Clone()
		Laser.Parent = script
		Laser:SetPrimaryPartCFrame(pp.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		TweenService:Create(Laser.Inside, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-205)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(15.012, 400, 15.012)}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-205)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 400, 19.168)}):Play()
		TweenService:Create(Laser.HB, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-205)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 400, 19.168)}):Play()
		TweenService:Create(Laser.Head, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-400)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()
		TweenService:Create(pp, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-400)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()
		game.Debris:AddItem(Laser,2.5)
		game.Debris:AddItem(pp,2.5)
		local Hitted = false
		local PlayerHitAmount = 0
		local PlayersHitted = {}
		local PlayersHit = {}
		pp.Touched:Connect(function(hitto)
			if Hitted == false and not hitto:IsDescendantOf(Character) then
				Hitted = true
				local ExplodeModel = game.ServerStorage.Weapons.WeaponEffects.PumpkinPistolExplosion:Clone()
				ExplodeModel.Parent = script
				ExplodeModel:SetPrimaryPartCFrame(pp.CFrame*CFrame.new(0,0,0))
				local coo = coroutine.wrap(function()
					repeat wait()
						ExplodeModel.Effect.CFrame =  ExplodeModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect2.CFrame =  ExplodeModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect3.CFrame =  ExplodeModel.Effect3.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect4.CFrame =  ExplodeModel.Effect4.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect5.CFrame =  ExplodeModel.Effect5.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect6.CFrame = ExplodeModel.Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
					until ExplodeModel.HB == nil 
				end)
				coo()
				TweenService:Create(ExplodeModel.Effect, TweenInfo.new(.5), {Size = ExplodeModel.Effect.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.5), {Size = ExplodeModel.Effect2.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.5), {Size = ExplodeModel.Effect3.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.5), {Size = ExplodeModel.Effect4.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.5), {Size = ExplodeModel.Effect5.Size*3.3}):Play()
				TweenService:Create(ExplodeModel.Effect6, TweenInfo.new(.5), {Size = ExplodeModel.Effect6.Size*3.3}):Play()
				TweenService:Create(ExplodeModel.HB, TweenInfo.new(.5), {Size = ExplodeModel.Effect6.Size*3.3}):Play()
				game.Debris:AddItem(ExplodeModel,2)
				local coro = coroutine.wrap(function()
					wait(1.5)
					TweenService:Create(ExplodeModel.Effect, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect6, TweenInfo.new(.5), {Transparency = 1}):Play()
				end)
				coro()
				ExplodeModel.HB.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
						if HRT:FindFirstChild("Light") == nil then
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							Velocity.Name = "Heavy"
							Velocity.Velocity = RootPart.CFrame.lookVector * 75
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.75)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
						end
					end
				end)
			end
		end)
		Laser.HB.Touched:Connect(function(hitto)
			if hitto.Parent:FindFirstChild("Humanoid") and hitto.Parent:FindFirstChild("Humanoid").Health > 0 and hitto.Parent.Name ~= Player.Name and PlayerHitAmount < 2 then
				for i,tableValue in pairs(PlayersHit) do
					if tableValue == hitto.Parent then return end
				end
				table.insert(PlayersHit, hitto.Parent)
				PlayerHitAmount = PlayerHitAmount + 1
				local hum = hitto.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hitto.Parent:FindFirstChild("HumanoidRootPart")
				local ExplodeModel = game.ServerStorage.Weapons.WeaponEffects.PumpkinPistolExplosion:Clone()
				ExplodeModel.Parent = script
				ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame*CFrame.new(0,0,0))
				local coo = coroutine.wrap(function()
					repeat wait()
						ExplodeModel.Effect.CFrame =  ExplodeModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect2.CFrame =  ExplodeModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect3.CFrame =  ExplodeModel.Effect3.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect4.CFrame =  ExplodeModel.Effect4.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect5.CFrame =  ExplodeModel.Effect5.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect6.CFrame = ExplodeModel.Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
					until ExplodeModel.HB == nil 
				end)
				coo()
				TweenService:Create(ExplodeModel.Effect, TweenInfo.new(.5), {Size = ExplodeModel.Effect.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.5), {Size = ExplodeModel.Effect2.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.5), {Size = ExplodeModel.Effect3.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.5), {Size = ExplodeModel.Effect4.Size*4}):Play()
				TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.5), {Size = ExplodeModel.Effect5.Size*3.3}):Play()
				TweenService:Create(ExplodeModel.Effect6, TweenInfo.new(.5), {Size = ExplodeModel.Effect6.Size*3.3}):Play()
				TweenService:Create(ExplodeModel.HB, TweenInfo.new(.5), {Size = ExplodeModel.Effect6.Size*3.3}):Play()
				game.Debris:AddItem(ExplodeModel,2)
				local coro = coroutine.wrap(function()
					wait(1.5)
					TweenService:Create(ExplodeModel.Effect, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.5), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect6, TweenInfo.new(.5), {Transparency = 1}):Play()
				end)
				coro()
				ExplodeModel.HB.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
						if HRT:FindFirstChild("Light") == nil then
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							Velocity.Name = "Heavy"
							Velocity.Velocity = RootPart.CFrame.lookVector * 75
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.75)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
						end
					end
				end)
			end
		end)	
		wait(1.5)
		Attack.Value = false
		cooldown = false
		wait(4)
		SupaSwing = false
	elseif WeaponType.Value == "CandyCaneGun" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		SupaSwing = true
		cooldown = true
		Stamina.Value = Stamina.Value - 25
		CandyGunSupaAnim:Play()
		local CandyCaneGun = Character.RightHand:FindFirstChild("CandyCaneGun")
		local DmgMultiplier = CandyCaneGun:FindFirstChild("DMG")
		wait(0.5)
		local Clone =  game.ServerStorage.SnowExplosion:Clone()
		Clone.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
		Clone.Anchored = true
		Clone.Parent = script
		game.Debris:AddItem(Clone,1.5)
		TweenService:Create(Clone,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(200,200,200)}):Play()
		local PlayersHitted = {}
		Clone.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				for i,tableValue in pairs(PlayersHitted) do
					if tableValue == hit.Parent then return end
				end
				table.insert(PlayersHitted, hit.Parent)
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				DmgFunction:Fire(Character, hum, 45*Strength.Value/2*DmgMultiplier.Value)
				if DmgMultiplier.Value > 1 then
					FreezeHumanoid(hum, HRT, 2)
				end
				if HRT:FindFirstChild("Light") == nil then
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					Velocity.Name = "Heavy"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					Velocity.Velocity = Vector3.new(0,50,0)
					game.Debris:AddItem(Velocity,.5)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
				end
			end
		end)		
		wait(1.5)
		Attack.Value = false
		cooldown = false
		wait(4)
		SupaSwing = false
	elseif WeaponType.Value == "EasterStaff" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		SupaSwing = true
		cooldown = true
		Stamina.Value = Stamina.Value - 25
		StaffSupaAnim:Play()
		local DmgMultiplier = Character.RightHand:FindFirstChild("EasterStaff"):FindFirstChild("DMG")
		for i,v in pairs(Character.RightHand:FindFirstChild("EasterStaff"):GetDescendants()) do
			if v:IsA("Trail") then
				v.Enabled = true
			end
		end
		local colors = {Color3.fromRGB(253, 234, 141),Color3.fromRGB(204, 255, 204),Color3.fromRGB(175, 221, 255),Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 255, 204),
			Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 201, 201),Color3.fromRGB(204, 255, 204)}
		local velocities = {Vector3.new(25,25,0),Vector3.new(-25,25,0),Vector3.new(0,25,25),Vector3.new(0,25,-25),Vector3.new(25,25,25),Vector3.new(-25,25,-25),Vector3.new(-25,25,25),Vector3.new(25,25,-25)}
		wait(0.3)
		for i=1, 8 do 
			local coo = coroutine.wrap(function()
				local EasterEgg = game.ServerStorage.EasterEgg:Clone()
				EasterEgg.Parent = script
				EasterEgg.CFrame = RootPart.CFrame
				EasterEgg.Color = colors[i]
				EasterEgg.Trail.Color = ColorSequence.new(colors[i],colors[i])
				if DmgMultiplier.Value > 1 then
					game.ServerStorage.Weapons.WeaponEffects.EasterStaffPE:Clone().Parent = EasterEgg
				end
				game.Debris:AddItem(EasterEgg,2)
				local BV = Instance.new("BodyVelocity",EasterEgg)
				BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				BV.Velocity = velocities[i]
				game.Debris:AddItem(BV,.5)
				local PlayersHitted = {}
				local Exploded = false
				EasterEgg.Touched:Connect(function(hitto)
					if not hitto:IsDescendantOf(Character) and Exploded == false and BV.Parent == nil then
						Exploded = true
						local EggExplosion = game.ServerStorage.EggExplosion:Clone()
						EggExplosion.Parent = script
						EggExplosion.CFrame = EasterEgg.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
						EasterEgg:Destroy()
						EggExplosion.Color = colors[i]
						game.Debris:AddItem(EggExplosion,1)
						TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(150,150,150)}):Play()
						if DmgMultiplier.Value > 1 then
							local PE = game.ServerStorage.Weapons.WeaponEffects.EasterStaffPE:Clone()
							PE.Speed = NumberRange.new(100,100)
							PE.Size = NumberSequence.new(15,15)
							PE.Parent = EggExplosion
							game.Debris:AddItem(PE, 1)
							local coo = coroutine.wrap(function()
								wait(.5)
								PE.Enabled = false
							end)
							coo()
						end
						EggExplosion.Touched:Connect(function(hit)
							if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and not hit:IsDescendantOf(Character)then
								for i,tableValue in pairs(PlayersHitted) do
									if tableValue == hit.Parent then return end
								end
								table.insert(PlayersHitted, hit.Parent)
								local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
								local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
								if HRT:FindFirstChild("Light") == nil then
									if DmgMultiplier.Value > 1 then
										local PE = game.ServerStorage.Weapons.WeaponEffects.EasterStaffPE:Clone()
										PE.Speed = NumberRange.new(4,5)
										PE.Size = NumberSequence.new(1,1)
										PE.Parent = HRT
										game.Debris:AddItem(PE, 1)
										local coo = coroutine.wrap(function()
											wait(.5)
											PE.Enabled = false
										end)
										coo()
									end
									DmgFunction:Fire(Character,hum,8*Strength.Value/2*DmgMultiplier.Value)
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.5)
									if hum.Health < 1 then
										if game.Players:GetPlayerFromCharacter(hum.Parent) then
											local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
											local enemyplrFame = enemyplrf.Fame
											if enemyplrFame.Value > -1 then
												PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
											elseif enemyplrFame.Value <= -1 then
												PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
											end
										end
									end
									wait()
									Velocity:Destroy()
								end
							end
						end)
					end
				end)
			end)
			coo()
		end
		wait(1.5)
		Attack.Value = false
		cooldown = false
		for i,v in pairs(Character.RightHand:FindFirstChild("EasterStaff"):GetDescendants()) do
			if v:IsA("Trail") then
				v.Enabled = false
			end
		end
		wait(4)
		SupaSwing = false	
	elseif WeaponType.Value == "EasterKatana" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		SupaSwing = true
		cooldown = true
		Stamina.Value = Stamina.Value - 25
		local Sword = Character.RightHand:FindFirstChild("EasterKatana")
		local Sword2 = Character.LeftHand:FindFirstChild("EasterKatana")
		local DmgMultiplier = Sword:FindFirstChild("DMG")
		if DmgMultiplier.Value == 1 then
			EasterKatanaSupaAnim:Play()
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
		elseif DmgMultiplier.Value > 1 then
			DualEasterKatanaSupaAnim:Play()
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			if Sword2 then
				for i,Trail in pairs(Sword2.Blade:GetChildren()) do
					if Trail:IsA("Trail") then
						Trail.Enabled = true
					end
				end
			end
		end
		local colors = {Color3.fromRGB(253, 234, 141),Color3.fromRGB(204, 255, 204),Color3.fromRGB(175, 221, 255),Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 255, 204),
			Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 201, 201),Color3.fromRGB(204, 255, 204)}
		for i=1, 8 do wait(.2)
			local amt = 1
			if DmgMultiplier.Value == 1 then
				amt = 1
			elseif DmgMultiplier.Value > 1 then
				amt = 2
			end
			for ii=1, amt do
				local coo = coroutine.wrap(function()
					local Clone = game.ServerStorage.Weapons.WeaponEffects.EasterSliceEffect:Clone()
					Clone.CFrame = RootPart.CFrame*CFrame.new(0,15,10)*CFrame.Angles(math.rad(90),math.rad(-45),math.rad(90))*CFrame.Angles(math.rad(math.random(-120,120)), math.rad(0),math.rad(0))
					Clone.Color = colors[i]
					Clone.Color = colors[i]
					Clone.Trail1.Color = ColorSequence.new(colors[i],colors[i])
					Clone.Trail2.Color = ColorSequence.new(colors[i],colors[i])
					Clone.Particle.Color = ColorSequence.new(colors[i],colors[i])
					Clone.Particle2.Color = ColorSequence.new(colors[i],colors[i])
					if ii == 1 then
						local HB = Instance.new("Part", Clone)
						HB.Anchored = false
						HB.CanCollide = false
						HB.Name = "HB"
						HB.Massless = true
						HB.Size = Vector3.new(20,50,50)
						HB.CFrame = Clone.CFrame
						HB.Transparency = 1
						local Weld = Instance.new("Weld", Clone)
						Weld.Part0 = Clone
						Weld.Part1 = HB
						Weld.C1 = Weld.C1*CFrame.Angles(math.rad(45),math.rad(0),math.rad(0))
						local PlayersHitted = {}
						HB.Touched:Connect(function(hit)
							if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
								for i,tableValue in pairs(PlayersHitted) do
									if tableValue == hit.Parent then return end
								end
								table.insert(PlayersHitted, hit.Parent)
								local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
								local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
								if DmgMultiplier.Value == 1 then
									DmgFunction:Fire(Character, hum, 9*Strength.Value/2)
								elseif DmgMultiplier.Value > 1 then
									DmgFunction:Fire(Character, hum, 11*Strength.Value/2)
								end
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									if hum.Health < 1 then
										if game.Players:GetPlayerFromCharacter(hum.Parent) then
											local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
											local enemyplrFame = enemyplrf.Fame
											if enemyplrFame.Value > -1 then
												PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
											elseif enemyplrFame.Value <= -1 then
												PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
											end
										end
									end
								end
							end
						end)
					end
					local BV = Instance.new("BodyVelocity", Clone)
					BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					BV.Velocity = RootPart.CFrame.lookVector * 300
					Clone.Parent = script
					game.Debris:AddItem(Clone,1.5)
					local cooo = coroutine.wrap(function()
						wait(.5)
						for i,v in pairs(Clone:GetChildren()) do
							if v:IsA("ParticleEmitter") then
								v.Enabled = false
							end
						end
						wait(.5)
						for i,v in pairs(Clone:GetChildren()) do
							if v:IsA("Trail") then
								v.Enabled = false
							end
						end
						TweenService:Create(Clone,TweenInfo.new(.5),{Transparency = 1}):Play()
					end)
					cooo()
				end)
				coo()
			end
		end
		wait(1.5)
		Attack.Value = false
		cooldown = false
		for i,Trail in pairs(Sword.Blade:GetChildren()) do
			if Trail:IsA("Trail") then
				Trail.Enabled = false
			end
		end
		if Sword2 then
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end
		end
		wait(5)
		SupaSwing = false	
	elseif WeaponType.Value == "BanHammer" and SupaSwing == false and Attack.Value == false and cooldown == false and Stamina.Value >= 25 and not RootPart:FindFirstChild("Heavy") then	
		Attack.Value = true
		SupaSwing = true
		cooldown = true
		Stamina.Value = Stamina.Value - 25
		HammerSlamAnim:Play()
		wait(0.8)
		local Clone =  game.ServerStorage.Shockwave2:Clone()
		Clone.Size = Vector3.new(10,2,10)
		Clone.CFrame = RootPart.CFrame
		Clone.Parent = script
		game.Debris:AddItem(Clone,1)
		TweenService:Create(Clone,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(150,30,150)}):Play()
		local PlayersHitted = {}
		Clone.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				for i,tableValue in pairs(PlayersHitted) do
					if tableValue == hit.Parent then return end
				end
				table.insert(PlayersHitted, hit.Parent)
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				DmgFunction:Fire(Character, hum, 65*Strength.Value/2)
				if HRT:FindFirstChild("Light") == nil then
					Exp.Value = Exp.Value + 50
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					Velocity.Name = "Heavy"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					Velocity.Velocity = Vector3.new(0,50,0)
					game.Debris:AddItem(Velocity,.5)
					if hum.Health < 1 then
						if game.Players:GetPlayerFromCharacter(hum.Parent) then
							local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
							local enemyplrFame = enemyplrf.Fame
							if enemyplrFame.Value > -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							elseif enemyplrFame.Value <= -1 then
								PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							end
						end
					end
				end
			end
		end)		
		wait(1.5)
		Attack.Value = false
		cooldown = false
		wait(4)
		SupaSwing = false	
	end
end)

Swing.OnServerEvent:Connect(function(play,direction)
	if WeaponType.Value == "Katana" and Attack.Value == false and cooldown == false and Stamina.Value >= 10 and not RootPart:FindFirstChild("Heavy") or WeaponType.Value == "Dagger" and Attack.Value == false and cooldown == false and Stamina.Value >= 10 and not RootPart:FindFirstChild("Heavy") then
		if Anim == 1 then
			Sword_1:Play()
			Anim = 2
		elseif Anim == 2 then
			Sword_2:Play()
			Anim = 3
		elseif Anim == 3 then
			Sword_3:Play()
			Anim = 1
		end
		Attack.Value = true
		SwordAttack = true
		cooldown = true
		Stamina.Value = Stamina.Value - 10
		wait(.5)
		SwordAttack = false
		cooldown = false
		Attack.Value = false
	elseif WeaponType.Value == "SnowSword" and Attack.Value == false and cooldown == false and Stamina.Value >= 10 and not RootPart:FindFirstChild("Heavy") then
		local Sword = Character.RightHand:FindFirstChild("SnowSword")
		local DmgMultiplier = Sword:FindFirstChild("DMG")
		if DmgMultiplier.Value == 1 then
			if Anim == 1 then
				SnowSword_1:Play()
				Anim = 2
			elseif Anim == 2 then
				SnowSword_2:Play()
				Anim = 3
			elseif Anim == 3 then
				SnowSword_3:Play()
				Anim = 1
			end
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
		elseif DmgMultiplier.Value > 1 then
			if Anim == 1 then
				DualSword_1:Play()
				Anim = 2
			elseif Anim == 2 then
				DualSword_2:Play()
				Anim = 3
			elseif Anim == 3 then
				DualSword_3:Play()
				Anim = 1
			end
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			local Sword2 = Character.LeftHand:FindFirstChild("SnowSword")
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
		end
		Attack.Value = true
		SwordAttack = true
		cooldown = true
		Stamina.Value = Stamina.Value - 10
		wait(.5)
		for i,Trail in pairs(Sword.Blade:GetChildren()) do
			if Trail:IsA("Trail") then
				Trail.Enabled = false
			end
		end
		if DmgMultiplier.Value > 1 then
			local Sword2 = Character.LeftHand:FindFirstChild("SnowSword")
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end	
		end
		SwordAttack = false
		cooldown = false
		Attack.Value = false
	elseif WeaponType.Value == "EasterKatana" and Attack.Value == false and cooldown == false and Stamina.Value >= 10 and not RootPart:FindFirstChild("Heavy") then
		local Sword = Character.RightHand:FindFirstChild("EasterKatana")
		local DmgMultiplier = Sword:FindFirstChild("DMG")
		if DmgMultiplier.Value == 1 then
			if Anim == 1 then
				EasterKatana_1:Play()
				Anim = 2
			elseif Anim == 2 then
				EasterKatana_2:Play()
				Anim = 3
			elseif Anim == 3 then
				EasterKatana_3:Play()
				Anim = 1
			end
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
		elseif DmgMultiplier.Value > 1 then
			if Anim == 1 then
				DualEasterKatana_1:Play()
				Anim = 2
			elseif Anim == 2 then
				DualEasterKatana_2:Play()
				Anim = 3
			elseif Anim == 3 then
				DualEasterKatana_3:Play()
				Anim = 1
			end
			for i,Trail in pairs(Sword.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
			local Sword2 = Character.LeftHand:FindFirstChild("EasterKatana")
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = true
				end
			end
		end
		Attack.Value = true
		SwordAttack = true
		cooldown = true
		Stamina.Value = Stamina.Value - 10
		wait(.5)
		for i,Trail in pairs(Sword.Blade:GetChildren()) do
			if Trail:IsA("Trail") then
				Trail.Enabled = false
			end
		end
		if DmgMultiplier.Value > 1 then
			local Sword2 = Character.LeftHand:FindFirstChild("EasterKatana")
			for i,Trail in pairs(Sword2.Blade:GetChildren()) do
				if Trail:IsA("Trail") then
					Trail.Enabled = false
				end
			end	
		end
		SwordAttack = false
		cooldown = false
		Attack.Value = false
	elseif WeaponType.Value == "HalloweenScythe" and Attack.Value == false and cooldown == false and Stamina.Value >= 10 and not RootPart:FindFirstChild("Heavy") then
		local Scythe = Character.RightHand:FindFirstChild("HalloweenScythe")
		local DmgMultiplier = Scythe:FindFirstChild("DMG")
		if DmgMultiplier.Value == 1 then
			if Anim == 1 then
				Scythe_1:Play()
				Anim = 2
			elseif Anim == 2 then
				Scythe_2:Play()
				Anim = 3
			elseif Anim == 3 then
				Scythe_3:Play()
				Anim = 1
			end
		elseif DmgMultiplier.Value > 1 then
			if Anim == 1 then
				DualScytheSwing_1:Play()
				Anim = 2
			elseif Anim == 2 then
				DualScytheSwing_2:Play()
				Anim = 3
			elseif Anim == 3 then
				DualScytheSwing_3:Play()
				Anim = 1
			end
		end
		for i,Trail in pairs(Scythe.Blade:GetChildren()) do
			if Trail:IsA("Trail") then
				Trail.Enabled = true
			end
		end
		Attack.Value = true
		SwordAttack = true
		cooldown = true
		Stamina.Value = Stamina.Value - 10
		if DmgMultiplier.Value >= 1 then
			wait(.5)
		else
			wait(.6)	
		end
		for i,Trail in pairs(Scythe.Blade:GetChildren()) do
			if Trail:IsA("Trail") then
				Trail.Enabled = false
			end
		end
		SwordAttack = false
		cooldown = false
		Attack.Value = false
	elseif WeaponType.Value == "Pistol" and Attack.Value == false and cooldown == false and not RootPart:FindFirstChild("Heavy") then
		local Pistol = Character.RightHand:FindFirstChild("Pistol")
		local DmgMultiplier = Pistol:FindFirstChild("DMG")
		Attack.Value = true
		cooldown = true
		if Character.LeftHand:FindFirstChild("Pistol") then
			if GunAnimType == 1 then
				GunAnimType = 2 
				GunAnim:Play()
			elseif GunAnimType == 2 then
				GunAnimType = 1
				Gun2Anim:Play()
			end
		else
			Gun2Anim:Play()	
		end
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,1)
		local LookVector = pp.CFrame.lookVector
		wait(.1)
		local bullet = game.ServerStorage.Bullet:Clone()
		bullet.Parent = script
		bullet.CFrame = pp.CFrame*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		local ring = game.ServerStorage.RING:Clone()
		ring.Parent  = script
		ring.CFrame = RootPart.CFrame
		game.Debris:AddItem(bullet,1.5)
		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*250
		local hitted = false
		bullet.HB.Touched:Connect(function(hit)
			if hitted == false and not hit:IsDescendantOf(Character) then
				hitted = true
				game.Debris:AddItem(bullet,0.5)
				bullet.Trail.Enabled = false
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					bullet:Destroy()
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if HRT:FindFirstChild("Light") == nil then
						DmgFunction:Fire(Character,hum,30*Strength.Value/2*DmgMultiplier.Value)
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector * 50
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.1)
						local ring2 = game.ServerStorage.RING:Clone()
						ring2.Parent  = script
						ring2.CFrame = HRT.CFrame
						game.Debris:AddItem(ring2,0.5)
						TweenService:Create(ring2, TweenInfo.new(0.5),{Transparency = 1}):Play()
						TweenService:Create(ring2.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
						if hum.Health < 1 then
							if game.Players:GetPlayerFromCharacter(hum.Parent) then
								local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
								local enemyplrFame = enemyplrf.Fame
								if enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
								elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
								end
							end
						end
						wait()
						Velocity:Destroy()
					end
				end
			end
		end)
		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		wait(0.5)
		Humanoid.AutoRotate = true
		Attack.Value = false
		ring:Destroy()
		if Character.LeftHand:FindFirstChild("Pistol") then
			wait(.25)
			cooldown = false
		else
			wait(1)
			cooldown = false
		end
	elseif WeaponType.Value == "PumpkinPistol" and Attack.Value == false and cooldown == false and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		cooldown = true
		if GunAnimType == 1 then
			GunAnimType = 2 
			GunAnim:Play()
		elseif GunAnimType == 2 then
			GunAnimType = 1
			Gun2Anim:Play()
		end
		Humanoid.AutoRotate = false
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,1)
		local LookVector = pp.CFrame.lookVector
		local cframe = pp.CFrame
		wait(.1)
		local bullet = game.ServerStorage.Weapons.WeaponEffects.PumpkinPistolBullet:Clone()
		bullet.Parent = script
		bullet.CFrame = pp.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		game.Debris:AddItem(bullet,2)
		local ring = game.ServerStorage.RING:Clone()
		ring.Parent  = script
		ring.CFrame = RootPart.CFrame
		ring.BrickColor = BrickColor.new("Br. yellowish orange")
		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*200
		bullet.Anchored = false
		local hitted = false
		local PlayersHitted = {} 
		bullet.Touched:Connect(function(hitto)
			if hitted == false and not hitto:IsDescendantOf(Character) then
				hitted = true
				bullet.Anchored = true
				local bulletcframe = bullet.CFrame
				bullet:Destroy()
				local ExplodeModel = game.ServerStorage.Weapons.WeaponEffects.PumpkinPistolExplosion:Clone()
				ExplodeModel.Parent = script
				ExplodeModel:SetPrimaryPartCFrame(bulletcframe*CFrame.new(0,0,0))
				local coo = coroutine.wrap(function()
					repeat wait()
						ExplodeModel.Effect.CFrame =  ExplodeModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect2.CFrame =  ExplodeModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect3.CFrame =  ExplodeModel.Effect3.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect4.CFrame =  ExplodeModel.Effect4.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect5.CFrame =  ExplodeModel.Effect5.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
						ExplodeModel.Effect6.CFrame = ExplodeModel.Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
					until ExplodeModel.HB == nil 
				end)
				coo()
				game.Debris:AddItem(ExplodeModel,0.75)
				local coo = coroutine.wrap(function()
					wait(.3)
					TweenService:Create(ExplodeModel.Effect, TweenInfo.new(.4), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.4), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.4), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.4), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.4), {Transparency = 1}):Play()
					TweenService:Create(ExplodeModel.Effect6, TweenInfo.new(.4), {Transparency = 1}):Play()
				end)
				coo()
				ExplodeModel.HB.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and not hit:IsDescendantOf(Character) then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						if HRT:FindFirstChild("Light") == nil then
							DmgFunction:Fire(Character,hum,40*Strength.Value/2)
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
							Velocity.Velocity = RootPart.CFrame.lookVector * 50
							Velocity.Name = "Light"
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.1)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
							wait()
							Velocity:Destroy()
						end
					end
				end)
			end
		end)
		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		wait(0.5)
		ring:Destroy()
		Humanoid.AutoRotate = true
		Attack.Value = false
		wait(.25)
		cooldown = false
	elseif WeaponType.Value == "CandyCaneGun" and Attack.Value == false and cooldown == false and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		cooldown = true
		if GunAnimType == 1 then
			GunAnimType = 2 
			GunAnim:Play()
		elseif GunAnimType == 2 then
			GunAnimType = 1
			Gun2Anim:Play()
		end
		local CandyCaneGun = Character.RightHand:FindFirstChild("CandyCaneGun")
		local DmgMultiplier = CandyCaneGun:FindFirstChild("DMG")
		Humanoid.AutoRotate = false
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,1)
		local LookVector = pp.CFrame.lookVector
		wait(.1)
		local bullet = game.ServerStorage.SnowExplosion:Clone()
		bullet.Parent = script
		bullet.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
		local HB = Instance.new("Part", bullet)
		HB.Anchored = false
		HB.CanCollide = false
		HB.Name = "HB"
		HB.Massless = true
		HB.Size = Vector3.new(.5,.5,.5)
		HB.CFrame = bullet.CFrame
		HB.Transparency = 1
		local Weld = Instance.new("Weld", bullet)
		Weld.Part0 = bullet
		Weld.Part1 = HB
		game.Debris:AddItem(bullet,2)
		local ring = game.ServerStorage.RING:Clone()
		ring.Parent  = script
		ring.CFrame = RootPart.CFrame
		local rad = math.random(1,2)
		if GunAnimType == 1  then
			ring.BrickColor = BrickColor.new("Lime green")
		elseif GunAnimType == 2 then
			ring.BrickColor = BrickColor.new("Dusty Rose")
		end
		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*200
		bullet.Anchored = false
		local hitted = false
		local PlayersHitted = {} 
		HB.Touched:Connect(function(hitto)
			if hitted == false and not hitto:IsDescendantOf(Character) then
				hitted = true
				velo:Destroy()
				bullet.Anchored = true
				HB.Anchored = true
				game.Debris:AddItem(bullet,0.5)
				bullet.Trail.Enabled = false
				TweenService:Create(bullet, TweenInfo.new(0.5),{Size = Vector3.new(30,30,30), Transparency = 1}):Play()
				TweenService:Create(HB, TweenInfo.new(0.5),{Size = Vector3.new(40,40,40), Transparency = 1}):Play()
				HB.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and not hit:IsDescendantOf(Character) then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						if DmgMultiplier.Value > 1 then
							FreezeHumanoid(hum, HRT, .5)
						end
						if HRT:FindFirstChild("Light") == nil then
							DmgFunction:Fire(Character,hum,40*Strength.Value/2*DmgMultiplier.Value)
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
							Velocity.Velocity = RootPart.CFrame.lookVector * 50
							Velocity.Name = "Light"
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.1)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
							wait()
							Velocity:Destroy()
						end
					end
				end)
			end
		end)
		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		game.Debris:AddItem(ring,.5)
		wait(0.5)
		Humanoid.AutoRotate = true
		Attack.Value = false
		wait(.25)
		cooldown = false
	elseif WeaponType.Value == "EasterStaff" and Attack.Value == false and cooldown == false and not RootPart:FindFirstChild("Heavy") and Character.RightHand:FindFirstChild("EasterStaff") then
		Attack.Value = true
		cooldown = true
		local DmgMultiplier = Character.RightHand:FindFirstChild("EasterStaff"):FindFirstChild("DMG")
		for i,v in pairs(Character.RightHand:FindFirstChild("EasterStaff"):GetDescendants()) do
			if v:IsA("Trail") then
				v.Enabled = true
			end
		end
		local colors = {Color3.fromRGB(253, 234, 141),Color3.fromRGB(204, 255, 204),Color3.fromRGB(175, 221, 255),Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 255, 204),
			Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 201, 201),Color3.fromRGB(204, 255, 204)}
		if GunAnimType == 1 then
			GunAnimType = 2 
			Staff_1:Play()
		elseif GunAnimType == 2 then
			GunAnimType = 1
			Staff_2:Play()
		end
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,.5)
		local LookVector = pp.CFrame.lookVector
		wait(.1)
		local EasterEgg = game.ServerStorage.EasterEgg:Clone()
		EasterEgg.Parent = script
		EasterEgg.CFrame = RootPart.CFrame
		local RandomColor = math.random(1,8)
		EasterEgg.Color = colors[RandomColor]
		EasterEgg.Trail.Color = ColorSequence.new(colors[RandomColor],colors[RandomColor])
		if DmgMultiplier.Value > 1 then
			game.ServerStorage.Weapons.WeaponEffects.EasterStaffPE:Clone().Parent = EasterEgg
		end
		local BV = Instance.new("BodyVelocity", EasterEgg)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = LookVector*150
		game.Debris:AddItem(EasterEgg, 2.5)
		local PlayersHitted = {}
		local Exploded = false
		EasterEgg.Touched:Connect(function(hitto)
			if not hitto:IsDescendantOf(Character) and Exploded == false then
				Exploded = true
				local EggExplosion = game.ServerStorage.EggExplosion:Clone()
				EggExplosion.Parent = script
				EggExplosion.CFrame = EasterEgg.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
				EasterEgg:Destroy()
				EggExplosion.Color = colors[RandomColor]
				game.Debris:AddItem(EggExplosion,1)
				TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(50,50,50)}):Play()
				if DmgMultiplier.Value > 1 then
					local PE = game.ServerStorage.Weapons.WeaponEffects.EasterStaffPE:Clone()
					PE.Speed = NumberRange.new(50,50)
					PE.Size = NumberSequence.new(10,10)
					PE.Parent = EggExplosion
					game.Debris:AddItem(PE, 1)
					local coo = coroutine.wrap(function()
						wait(.5)
						PE.Enabled = false
					end)
					coo()
				end
				EggExplosion.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and not hit:IsDescendantOf(Character)then
						for i,tableValue in pairs(PlayersHitted) do
							if tableValue == hit.Parent then return end
						end
						table.insert(PlayersHitted, hit.Parent)
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						if HRT:FindFirstChild("Light") == nil then
							if DmgMultiplier.Value > 1 then
								local PE = game.ServerStorage.Weapons.WeaponEffects.EasterStaffPE:Clone()
								PE.Speed = NumberRange.new(4,5)
								PE.Size = NumberSequence.new(1,1)
								PE.Parent = HRT
								game.Debris:AddItem(PE, 1)
								local coo = coroutine.wrap(function()
									for i=1, 2 do wait(.25)
										DmgFunction:Fire(Character,hum,2*Strength.Value/2*DmgMultiplier.Value)
									end
									PE.Enabled = false
									for i=1, 2 do wait(.2)
										DmgFunction:Fire(Character,hum,2*Strength.Value/2*DmgMultiplier.Value)
									end
								end)
								coo()
							end
							DmgFunction:Fire(Character,hum,40*Strength.Value/2*DmgMultiplier.Value)
							Exp.Value = Exp.Value + 50
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
							Velocity.Velocity = RootPart.CFrame.lookVector * 50
							Velocity.Name = "Light"
							local ObjectVal = Instance.new("ObjectValue",Velocity)
							ObjectVal.Value = RootPart
							ObjectVal.Name = "Hitist"
							game.Debris:AddItem(Velocity,.1)
							if hum.Health < 1 then
								if game.Players:GetPlayerFromCharacter(hum.Parent) then
									local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
									local enemyplrFame = enemyplrf.Fame
									if enemyplrFame.Value > -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
										PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									end
								end
							end
						end
					end
				end)
			end
		end)
		wait(0.5)
		Attack.Value = false
		for i,v in pairs(Character.RightHand:FindFirstChild("EasterStaff"):GetDescendants()) do
			if v:IsA("Trail") then
				v.Enabled = false
			end
		end
		wait(.25)
		cooldown = false
	elseif WeaponType.Value == "BanHammer" and Attack.Value == false and cooldown == false and not RootPart:FindFirstChild("Heavy") then
		Attack.Value = true
		SwordAttack = true
		cooldown = true
		Stamina.Value = Stamina.Value - 10
		if Anim == 1 then
			Hammer_1:Play()
			Anim = 2
		elseif Anim == 2 then
			Hammer_2:Play()
			Anim = 1
		end
		wait(.7)
		SwordAttack = false
		cooldown = false
		Attack.Value = false		
	end
end)


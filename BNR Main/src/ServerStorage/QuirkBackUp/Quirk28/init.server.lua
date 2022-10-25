local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 28 then
	script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
wait()
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block) 
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local HammerSlamAnim = Humanoid:LoadAnimation(AnimationsFolder.HammerSlam)
local BarrageBombAnim = Humanoid:LoadAnimation(AnimationsFolder.BarrageBomb)
local ThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.Throw)
local BlockShieldAnim = Humanoid:LoadAnimation(AnimationsFolder.BlockShield)
local GrabBagAnim = Humanoid:LoadAnimation(AnimationsFolder.GrabBag)
local NormalCannonAnim = Humanoid:LoadAnimation(AnimationsFolder.NormalCannon)
local CannonUltAnim = Humanoid:LoadAnimation(AnimationsFolder.CannonUlt)
local SpearLungeAnim = Humanoid:LoadAnimation(AnimationsFolder.SpearLunge)
local BodyVelocity = Instance.new("BodyVelocity")
local Smoke = script.Smoke
BodyVelocity.Parent = nil
BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
local HitSound = Instance.new("Sound", RootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
local Block = false
local LeftKick = false
local RightKick = false
local LeftPunch = false
local RightPunch = false
local Training = false
local Run = false
local cantrun = false
local Shift = false
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerFolder = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Level = PlayerFolder.Level
local Exp = PlayerFolder.Experience
local Strength = PlayerFolder.Strength
local Agility = PlayerFolder.Agility
local Durability = PlayerFolder.Durability
local Quirk = PlayerFolder.Quirk
local stunned = false
local Defense = Instance.new("NumberValue",Character) 
Defense.Name = "Defense"
Defense.Value = 1
local Stamina = Instance.new("NumberValue",Character)
Stamina.Name = "Stamina"
Stamina.Value = 100+(Agility.Value*1)
local MaxStamina = Instance.new("NumberValue",Character)
MaxStamina.Name = "MaxStamina"
MaxStamina.Value = Stamina.Value
Humanoid.MaxHealth = 75+50*Level.Value
Humanoid.Health = Humanoid.MaxHealth
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
local TweenService = game:GetService("TweenService")
local Corotot = coroutine.wrap(function()
	local REGEN_RATE = 5/100
	local REGEN_STEP = .1
	
	while true do
		while Stamina.Value < MaxStamina.Value do
			local dt = wait(REGEN_STEP)
			local dh = dt*REGEN_RATE*MaxStamina.Value
			Stamina.Value = math.min(Stamina.Value + dh, MaxStamina.Value)
		end
		if Stamina.Value > MaxStamina.Value then
			Stamina.Value = MaxStamina.Value
		end
		Stamina.Changed:Wait()
	end
end)
Corotot()

local IronShield = false
local Coro = coroutine.wrap(function()
	while wait() do
		if not Character:FindFirstChild("Safezone") and Block == false then
		if RootPart:FindFirstChild("Light") and stunned == false and cantrun == false then
		elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false then
			stunned = true
			if IronShield == true then
			BlockShieldAnim:Play()
			wait(.5)
			BlockShieldAnim:Stop()
			stunned = false
			if RootPart:FindFirstChild("Heavy") then
				RootPart:FindFirstChild("Heavy"):Destroy()
			end
			else
			local asdfg = false
			Attack.Value = true
			HvyStunnedAnim:Play()
			Humanoid.WalkSpeed = 0
			Humanoid.JumpPower = 0
			for i = 1,3 do
				if asdfg == true or not RootPart:FindFirstChild("Heavy") then
					break
					else
					wait(.75)
				end
			end
			if RootPart:FindFirstChild("Heavy") then
				RootPart:FindFirstChild("Heavy"):Destroy()
			end
			HvyStunnedAnim:Stop()
			asdfg = true
			Humanoid.WalkSpeed = 18
			Humanoid.JumpPower = 50
			stunned = false
			Attack.Value = false
			end
		end
		end
	end
end)
Coro()

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")
local BombThrowEvent = script:WaitForChild("BombThrow")
local CannonBlastEvent = script:WaitForChild("CannonBlast")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")

local LuckyBag = false
local BagMedKit = false
local BagSpear = false
local BagHammer = false
local BagBombs = false
local RussianBomb = false
local SuperCannonBlast = false
local MultiThrow = false
qq.OnServerEvent:Connect(function(play,direction)
	if Attack.Value == false and stunned == false and LuckyBag == true and BagBombs == false then
		BagBombs = true
		Attack.Value = true
		BarrageBombAnim:Play()
		for i=1, 8 do
		MultiThrow = true
		BombThrowEvent:FireClient(Player)
		wait(0.11)
		end
		Attack.Value = false
	elseif Attack.Value == false and stunned == false and Stamina.Value >= 25 and RussianBomb == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 25
		RussianBomb = true
		ThrowAnim:Play()
		local CreationDoll = game.ServerStorage.CreationDoll:Clone()
		CreationDoll.Parent = script
		local Weld = Instance.new("Motor6D",CreationDoll)
		Weld.Part0 = CreationDoll
		Weld.Part1 = Character.LeftHand
		for i,v in pairs(CreationDoll:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		game.Debris:AddItem(CreationDoll, 5)
		wait(.5)
		Weld:Destroy()
		for i,v in pairs(CreationDoll:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,0.1)
		local BV = Instance.new("BodyVelocity", CreationDoll)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = pp.CFrame.lookVector*150
		game.Debris:AddItem(BV, 0.25)
		local Hitted = false
		local PlayersHitted = {}
		CreationDoll.Touched:Connect(function(hit)
			if Hitted == false and not hit:IsDescendantOf(Character) then
				Hitted = true
				local cframe = CreationDoll.CFrame
				CreationDoll:Destroy()
				local CreationExplosion = game.ServerStorage.CreationExplosion:Clone()
				CreationExplosion.Parent = script
				CreationExplosion.CFrame = cframe 
				local HB = Instance.new("Part", script)
				HB.Anchored = true
				HB.Shape = "Ball"
				HB.Transparency = 1
				HB.CanCollide = false
				HB.CFrame = cframe
				game.Debris:AddItem(CreationExplosion,1)
				game.Debris:AddItem(HB,1)
				TweenService:Create(HB, TweenInfo.new(1),{Size = Vector3.new(100,100,100)}):Play()
				TweenService:Create(CreationExplosion, TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(100,100,100)}):Play()
				local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if HB == nil then
					break
				end
				connection = HB.Touched:Connect(function() end)
				results = HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(20000,20000,20000)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,0.2)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.2)
			end
		end)
		expermentaltouch()
			end
		end)
		wait(.5)
		Attack.Value = false
		wait()
		RussianBomb = false
	end
end)

local SteelSword = false
zz.OnServerEvent:Connect(function()
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and LuckyBag == true and BagSpear == false then
		Attack.Value = true
		BagSpear = true
		GrabBagAnim:Play()
		wait(.3)
		local CreationSpear = game.ServerStorage.CreationSpear:Clone()
		CreationSpear.Parent = script
		local Weld = Instance.new("Weld", CreationSpear)
		Weld.Part0 = CreationSpear
		Weld.Part1 = Character.LeftHand
		Weld.C0 = Weld.C0 * CFrame.new(0,0,2.5)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		wait(.5)
		SpearLungeAnim:Play()
		wait(.8)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if CreationSpear == nil then
					break
				end
				connection = CreationSpear.Touched:Connect(function() end)
				results = CreationSpear:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
								local SwordEffect = game.ServerStorage.Weapons.WeaponEffects.KatanaEffect:Clone()
								SwordEffect.Parent = script
								SwordEffect.CFrame = HRT.CFrame
								TweenService:Create(SwordEffect, TweenInfo.new(0.5),{Transparency = 1}):Play()
								game.Debris:AddItem(SwordEffect,0.5)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,0.5)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
									end
								end
							end 
					end
				lastresult = results
				end
				wait(0.01)
			end
		end)
		expermentaltouch()
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.Velocity = RootPart.CFrame.lookVector * 175
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		game.Debris:AddItem(BV, 1)
		wait(1.5)
		Attack.Value = false
		CreationSpear:Destroy()
	elseif Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and SteelSword == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		SteelSword = true
		local WeaponType = Character:FindFirstChild("WeaponType")
		if WeaponType.Value == "Pistol" then
				Character.RightHand:FindFirstChild("Pistol"):Destroy()
				if Character.LeftHand:FindFirstChild("Pistol") then
				Character.LeftHand:FindFirstChild("Pistol"):Destroy()
				end
		elseif WeaponType.Value == "Katana" then
				Character.RightHand:FindFirstChild("Katana"):Destroy()
		elseif WeaponType.Value == "Dagger" then
				Character.RightHand:FindFirstChild("Dagger"):Destroy()
		elseif WeaponType.Value == "HalloweenScythe" then
				Character.RightHand:FindFirstChild("HalloweenScythe"):Destroy()
		elseif WeaponType.Value == "CandyCaneGun" then
				Character.RightHand:FindFirstChild("CandyCaneGun"):Destroy()
				Character.LeftHand:FindFirstChild("CandyCaneGun"):Destroy()
		elseif WeaponType.Value == "BanHammer" then
				Character.RightHand:FindFirstChild("BanHammer"):Destroy()
		end
		WeaponType.Value = "N/A"
		wait(.1)
		WeaponType.Value = "Katana"
		local CreationSword = game.ServerStorage.CreationSword:Clone()
		CreationSword.Parent = Character.RightHand
		CreationSword.Transparency = 1
		CreationSword.Name = "Katana"
		local Weld = Instance.new("Motor6D",CreationSword)
		Weld.Part0 = CreationSword
		Weld.Part1 = Character.RightHand
		Weld.C0 = Weld.C0 * CFrame.new(0,0,3.6) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(90))
		TweenService:Create(CreationSword, TweenInfo.new(1), {Transparency = 0}):Play()
		for i,v in pairs(CreationSword:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		wait(1)
		Attack.Value = false
		for i,v in pairs(CreationSword:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
	elseif SteelSword == true then
		SteelSword = false
		local WeaponType = Character:FindFirstChild("WeaponType")
		if WeaponType.Value == "Pistol" then
				Character.RightHand:FindFirstChild("Pistol"):Destroy()
				if Character.LeftHand:FindFirstChild("Pistol") then
				Character.LeftHand:FindFirstChild("Pistol"):Destroy()
				end
		elseif WeaponType.Value == "Katana" then
				Character.RightHand:FindFirstChild("Katana"):Destroy()
		elseif WeaponType.Value == "Dagger" then
				Character.RightHand:FindFirstChild("Dagger"):Destroy()
		elseif WeaponType.Value == "HalloweenScythe" then
				Character.RightHand:FindFirstChild("HalloweenScythe"):Destroy()
		elseif WeaponType.Value == "CandyCaneGun" then
				Character.RightHand:FindFirstChild("CandyCaneGun"):Destroy()
				Character.LeftHand:FindFirstChild("CandyCaneGun"):Destroy()
		elseif WeaponType.Value == "BanHammer" then
				Character.RightHand:FindFirstChild("BanHammer"):Destroy()
		end
		WeaponType.Value = "N/A"
	end
end)

xx.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and LuckyBag == true and BagMedKit == false then
		Attack.Value = true
		BagMedKit = true
		GrabBagAnim:Play()
		wait(.3)
		local CreationMedKit = game.ServerStorage.CreationMedKit:Clone()
		CreationMedKit.Parent = script
		local Weld = Instance.new("Weld", CreationMedKit)
		Weld.Part0 = CreationMedKit
		Weld.Part1 = Character.LeftHand
		wait(1)
		CreationMedKit:Destroy()
		Humanoid.Health = Humanoid.Health + Humanoid.MaxHealth/2
		Attack.Value = false
	elseif Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and IronShield == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		IronShield = true
		local CreationShield = game.ServerStorage.CreationShield:Clone()
		CreationShield.Parent = script
		CreationShield.Transparency = 1
		local Weld = Instance.new("Motor6D",CreationShield)
		Weld.Part0 = CreationShield
		Weld.Part1 = Character.LeftLowerArm
		Weld.C0 = Weld.C0 * CFrame.new(0,-.2,-.4) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		TweenService:Create(CreationShield, TweenInfo.new(1), {Transparency = 0}):Play()
		for i,v in pairs(CreationShield:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		wait(1)
		for i,v in pairs(CreationShield:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		Attack.Value = false
		Defense.Value = 1.25
	elseif IronShield == true then
		IronShield = false
		Defense.Value = 1
		script:FindFirstChild("CreationShield"):Destroy()
	end
end)

local NetTrap = false
cc.OnServerEvent:Connect(function(play, Direction)
	if Strength.Value >= 150 and Attack.Value == false and stunned == false and LuckyBag == true and BagHammer == false then
		Attack.Value = true
		BagHammer = true
		GrabBagAnim:Play()
		wait(.3)
		local CreationHammer = game.ServerStorage.CreationHammer:Clone()
		CreationHammer.Parent = script
		wait(.5)
		HammerSlamAnim:Play()
		local Weld = Instance.new("Weld", CreationHammer)
		Weld.Part0 = CreationHammer
		Weld.Part1 = Character.LeftHand
		Weld.C0 = Weld.C0 * CFrame.new(0,0,4) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(90))
		wait(0.8)
		local Clone =  game.ServerStorage.Shockwave2:Clone()
		Clone.Size = Vector3.new(10,2,10)
		Clone.CFrame = RootPart.CFrame
		Clone.Parent = script
		local HB = Instance.new("Part", script)
		HB.Anchored = true
		HB.Shape = "Ball"
		HB.Transparency = 1
		HB.CanCollide = false
		HB.CFrame = RootPart.CFrame * CFrame.new(0,-3,0)
		game.Debris:AddItem(HB,1)
		TweenService:Create(HB, TweenInfo.new(1),{Size = Vector3.new(125,125,125)}):Play()
		game.Debris:AddItem(Clone,1)
		TweenService:Create(Clone,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(150,30,150)}):Play()
		local PlayersHitted = {}
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if HB == nil then
					break
				end
				connection = HB.Touched:Connect(function() end)
				results = HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 55*Strength.Value/2)
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
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.01)
			end
		end)
		expermentaltouch()
		wait(1.5)
		Attack.Value = false
		CreationHammer:Destroy()
	elseif Strength.Value >= 150 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and NetTrap == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		NetTrap = true
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,Direction.p)
		wait(.1)
		local CreationNet = game.ServerStorage.CreationNet:Clone()
		CreationNet.Parent = script
		CreationNet.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))
		for i,v in pairs(CreationNet:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		local BV = Instance.new("BodyVelocity", CreationNet)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 150
		game.Debris:AddItem(BV,3)
		local hitted = false
		local coo = coroutine.wrap(function()
			wait(.5)
			for i,v in pairs(CreationNet:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
				end
			end
			wait(2.5)
			if hitted == false then
			CreationNet:Destroy()
			end
		end)
		coo()
		local contecto
		contecto = CreationNet.Touched:Connect(function(hit)
			if hitted == false and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					hitted = true
					contecto:Disconnect()
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					CreationNet.Anchored = true
					local Weld = Instance.new("Motor6D", CreationNet)
					Weld.Part0 = HRT
					Weld.Part1 = CreationNet
					Weld.C0 = Weld.C0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
					game.Debris:AddItem(CreationNet, 5)
					DmgFunction:Fire(Character, hum, 45*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.2)
						Velocity.Velocity = RootPart.CFrame.lookVector * 100
					end
				end
		end)
		wait(.5)
		Attack.Value = false
		wait(5)
		NetTrap = false
		end
end)

local CannonBlast = false
local MultiCannonBlast = false
vv.OnServerEvent:Connect(function(play,direction)
	if Strength.Value >= 200 and Attack.Value == false and stunned == false and LuckyBag == true and SuperCannonBlast == false then
		SuperCannonBlast = true
		Attack.Value = true
		CannonUltAnim:Play()
		wait(.1)
		local CreationSuperCannon = game.ServerStorage.CreationSuperCannon:Clone()
		CreationSuperCannon.Parent = script
		CreationSuperCannon:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0))
		RootPart.Anchored = true
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		cantrun = true
		for i,v in pairs(CreationSuperCannon:GetChildren()) do
			v.Transparency = 1
		end
		wait(.25)
		for i,v in pairs(CreationSuperCannon:GetChildren()) do
			TweenService:Create(v, TweenInfo.new(1), {Transparency = 0}):Play()
		end
		for i,v in pairs(CreationSuperCannon:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		wait(1)
		for i,v in pairs(CreationSuperCannon:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		for i=1, 2 do wait(.25)
		for i,v in pairs(CreationSuperCannon:GetChildren()) do
			if v.Name == "Cannon" then
				v.CFrame = CFrame.new(v.CFrame.p,direction.p)
				local CreationCannonBall = game.ServerStorage.CreationCannonBall:Clone()
		CreationCannonBall.CFrame = v.CFrame
		CreationCannonBall.Parent = script
		game.Debris:AddItem(CreationCannonBall, 3)
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,0.1)
		local BV = Instance.new("BodyVelocity", CreationCannonBall)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = pp.CFrame.lookVector*150
		local Hitted = false
		local PlayersHitted = {}
		CreationCannonBall.Touched:Connect(function(hit)
			if Hitted == false and not hit:IsDescendantOf(Character) then
				Hitted = true
				local cframe = CreationCannonBall.CFrame
				CreationCannonBall:Destroy()
				local CreationExplosion = game.ServerStorage.CreationExplosion:Clone()
				CreationExplosion.Parent = script
				CreationExplosion.CFrame = cframe 
				game.Debris:AddItem(CreationExplosion,1)
				TweenService:Create(CreationExplosion, TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(100,100,100)}):Play()
				CreationExplosion.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.2)
						Velocity.Velocity = RootPart.CFrame.lookVector * 100
						if hum.Health < 1 then
							if game.Players:GetPlayerFromCharacter(hum.Parent) then
								local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
								local enemyplrFame = enemyplrf.Fame
								if enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
								end
								elseif hum.Parent:FindFirstChild("Fame") then
								local enemyplrFame = hum.Parent.Fame
								if hum.Parent.Name == "All Might" then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 150
									Exp.Value = Exp.Value + 100000
									PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + 10000
									local reward = game.ReplicatedStorage.Remotes.RewardPane
									reward:FireClient(Player, 100000, 10000)		
									elseif enemyplrFame.Value > -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
									PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + math.random(20,50)
									elseif enemyplrFame.Value <= -1 then
									PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
									PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + math.random(20,50)
								end
							end
						end
					end
				end
				end)
			end
		end)
			end
		end
		end
		wait(1)
		Attack.Value = false
		CreationSuperCannon:Destroy()
		RootPart.Anchored = false
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		cantrun = false
	elseif Strength.Value >= 200 and Attack.Value == false and stunned == false and Stamina.Value >= 250 and CannonBlast == false then
		CannonBlast = true
		Attack.Value = true
		NormalCannonAnim:Play()
		local CreationCannon = game.ServerStorage.CreationCannon:Clone()
		CreationCannon.Parent = script
		CreationCannon:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,2.5,-10))
		CreationCannon.Cannon.Transparency = 1
		CreationCannon.Bottom.Transparency = 1
		TweenService:Create(CreationCannon.Cannon, TweenInfo.new(1), {Transparency = 0}):Play()
		TweenService:Create(CreationCannon.Bottom, TweenInfo.new(1), {Transparency = 0}):Play()
		for i,v in pairs(CreationCannon:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		wait(1)
		for i,v in pairs(CreationCannon:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		local coo = coroutine.wrap(function()
		for i=1, 8 do
		MultiCannonBlast = true
		CannonBlastEvent:FireClient(Player)
		wait(0.4)
		end
		end)
		coo()
		wait(4)
		Attack.Value = false
		CreationCannon:Destroy()
		NormalCannonAnim:Stop()
		wait(8)
		CannonBlast = false
	end
end)

CannonBlastEvent.OnServerEvent:Connect(function(play,direction)
	if MultiCannonBlast == true and CannonBlast == true then
	local CreationCannon = script:FindFirstChild("CreationCannon")
	local CannonPart = CreationCannon.Cannon
	local CreationCannonBall = game.ServerStorage.CreationCannonBall:Clone()
		CreationCannonBall.CFrame = CannonPart.CFrame
		CreationCannonBall.Parent = script
		game.Debris:AddItem(CreationCannonBall, 3)
		CannonPart.CFrame = CFrame.new(CannonPart.CFrame.p,direction.p)
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,0.1)
		local BV = Instance.new("BodyVelocity", CreationCannonBall)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = pp.CFrame.lookVector*150
		local Hitted = false
		local PlayersHitted = {}
		CreationCannonBall.Touched:Connect(function(hit)
			if Hitted == false and not hit:IsDescendantOf(Character) then
				Hitted = true
				local cframe = CreationCannonBall.CFrame
				CreationCannonBall:Destroy()
				local CreationExplosion = game.ServerStorage.CreationExplosion:Clone()
				CreationExplosion.Parent = script
				CreationExplosion.CFrame = cframe 
				local HB = Instance.new("Part", script)
				HB.Anchored = true
				HB.Shape = "Ball"
				HB.Transparency = 1
				HB.CanCollide = false
				HB.CFrame = cframe
				game.Debris:AddItem(CreationExplosion,1)
				game.Debris:AddItem(HB,1)
				TweenService:Create(HB, TweenInfo.new(1),{Size = Vector3.new(100,100,100)}):Play()
				TweenService:Create(CreationExplosion, TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(100,100,100)}):Play()
				local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if HB == nil then
					break
				end
				connection = HB.Touched:Connect(function() end)
				results = HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(20000,20000,20000)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,0.2)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
			end
		end)
		MultiCannonBlast = false
		end
end)

BombThrowEvent.OnServerEvent:Connect(function(play,direction)
	if MultiThrow == true then
	local CreationDoll = game.ServerStorage.CreationDoll:Clone()
		CreationDoll.CFrame = RootPart.CFrame
		CreationDoll.Parent = script
		game.Debris:AddItem(CreationDoll, 5)
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direction.p)
		game.Debris:AddItem(pp,0.1)
		local BV = Instance.new("BodyVelocity", CreationDoll)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = pp.CFrame.lookVector*150
		game.Debris:AddItem(BV, 0.25)
		local Hitted = false
		local PlayersHitted = {}
		CreationDoll.Touched:Connect(function(hit)
			if Hitted == false and not hit:IsDescendantOf(Character) then
				Hitted = true
				local cframe = CreationDoll.CFrame
				CreationDoll:Destroy()
				local CreationExplosion = game.ServerStorage.CreationExplosion:Clone()
				CreationExplosion.Parent = script
				CreationExplosion.CFrame = cframe 
				local HB = Instance.new("Part", script)
				HB.Anchored = true
				HB.Shape = "Ball"
				HB.Transparency = 1
				HB.CanCollide = false
				HB.CFrame = cframe
				game.Debris:AddItem(CreationExplosion,1)
				game.Debris:AddItem(HB,1)
				TweenService:Create(HB, TweenInfo.new(1),{Size = Vector3.new(100,100,100)}):Play()
				TweenService:Create(CreationExplosion, TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(100,100,100)}):Play()
			local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if HB == nil then
					break
				end
				connection = HB.Touched:Connect(function() end)
				results = HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(20000,20000,20000)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,0.2)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
			end
		end)
		MultiThrow = false
		end
end)

ff.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 500 and LuckyBag == false and not script:FindFirstChild("CreationBag") then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 500
		LuckyBag = true
		BagMedKit = false
		BagSpear = false 
		BagHammer = false 
		BagBombs = false
		SuperCannonBlast = false
		local CreationBag = game.ServerStorage.CreationBag:Clone()
		CreationBag.Parent = script
		CreationBag.Bag.Transparency = 1
		local Weld = Instance.new("Motor6D",CreationBag.Bag)
		Weld.Part0 = CreationBag.Bag
		Weld.Part1 = Character.UpperTorso
		Weld.C0 = Weld.C0 * CFrame.new(-.5,-.2,1.8) * CFrame.Angles(math.rad(0),math.rad(160),math.rad(0))
		TweenService:Create(CreationBag.Bag, TweenInfo.new(1), {Transparency = 0}):Play()
		for i,v in pairs(CreationBag.Bag:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		wait(1)
		for i,v in pairs(CreationBag.Bag:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		Attack.Value = false
		local coo = coroutine.wrap(function()
			repeat wait(.5)
			until BagMedKit == true and BagSpear == true and BagHammer == true and BagBombs == true and SuperCannonBlast == true
			CreationBag:Destroy()
			wait(10)
			LuckyBag = false
		end)
		coo()
	elseif LuckyBag == true and script:FindFirstChild("CreationBag") then
	BagMedKit = true
	BagSpear = true
	BagHammer = true
	BagBombs = true
	SuperCannonBlast = true
	end
end)

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	if IronShield == false then
	BlockAnim:Play()
	elseif IronShield == true then
	BlockShieldAnim:Play()
	end
	repeat wait()
	if IronShield == false then
	Defense.Value = 3
	elseif IronShield == true then
	Defense.Value = 4
	end
	Stamina.Value = Stamina.Value - 3
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	end)
	coo()
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	BlockShieldAnim:Stop()
	if IronShield == false then
	Defense.Value = 1
	elseif IronShield == true then
	Defense.Value = 1.25
	end
	Attack.Value = false
	end
end)

rup.OnServerEvent:Connect(function()
	if Block == true then
	Block = false
	end
end)

sd.OnServerEvent:Connect(function()
	Shift = true
	if stunned == false and Stamina.Value > 1 and cantrun == false then
			local Corot = coroutine.wrap(function()
				while wait(0.1) do
					Stamina.Value = Stamina.Value - 2
					if Stamina.Value < 2 or Run == false then
						break
					end
				end
			end)
			Corot()
			Run = true
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 140
			else
			Humanoid.WalkSpeed = 40 + 0.05 * Agility.Value	
			end
		end
end)
su.OnServerEvent:Connect(function()
	if cantrun == false then
	Shift = false
	Run = false
	BodyVelocity.Parent = nil
	Humanoid.WalkSpeed = 18
	end
end)

tt.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 10 and Training == false then 
		Attack.Value = true
		Training = true
		local random = math.random(1,2)
		if random == 1 then
		SitUpAnim:Play()
		elseif random == 2 then
			PushUpAnim:Play()
			end
	    Exp.Value = Exp.Value + 50
		Humanoid.WalkSpeed = 0
		cantrun = true
		Humanoid.JumpPower = 0
		wait(1.8)
		Training = false
		Attack.Value = false
	    Humanoid.WalkSpeed = 18
		cantrun = false
		Humanoid.JumpPower = 50
	end
end)

local picked = 1
ee.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 10 then
	Stamina.Value = Stamina.Value - 10
	local animation = Instance.new("Animation")
	animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[picked]
	local animTrack = Humanoid:LoadAnimation(animation)
	animTrack:Play()
	if picked == 1 then
	RightPunch = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if RightPunch == false then
				break
			end
			local connection = Character.RightHand.Touched:Connect(function()end)
			results = Character.RightHand:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							RightPunch = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end 
		end
	end)	
	touchedy()
	wait(0.7)
	Attack.Value = false
	RightPunch = false
	elseif picked == 2 then
	LeftPunch = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if LeftPunch == false then
				break
			end
			local connection = Character.LeftHand.Touched:Connect(function()end)
			results = Character.LeftHand:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
        	 			else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							LeftPunch = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end 
		end
	end)	
	touchedy()
	wait(0.7)
	Attack.Value = false
	LeftPunch = false
	elseif picked == 3 then
	RightKick = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if RightKick == false then
				break
			end
			local connection = Character.RightFoot.Touched:Connect(function()end)
			results = Character.RightFoot:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							RightKick = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end 
		end
	end)	
	touchedy()
	wait(0.7)
	Attack.Value = false
	RightKick = false
	elseif picked == 4 then
	LeftKick = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if LeftKick == false then
				break
			end
			local connection = Character.LeftFoot.Touched:Connect(function()end)
			results = Character.LeftFoot:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
        					LeftKick = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end
		end
	end)
	wait(0.7)
	Attack.Value = false
	LeftKick = false
	end
	if picked <= 3 then
	picked = picked + 1
	elseif picked == 4 then
	picked = 1
		end
	end
end)
			


while wait() do
	if Humanoid.Health == Humanoid.MaxHealth then
		Humanoid.MaxHealth = 150+150*Durability.Value
		Humanoid.Health = Humanoid.MaxHealth
		else
		Humanoid.MaxHealth = 150+150*Durability.Value
end
if Run == true then
		if Stamina.Value < 2 then
			Run = false
			Humanoid.WalkSpeed = 18
		end
	end
end

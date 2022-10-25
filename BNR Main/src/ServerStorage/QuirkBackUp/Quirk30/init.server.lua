local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 30 then
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
local ImpactRecoilAnim = Humanoid:LoadAnimation(AnimationsFolder.ImpactRecoil) 
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local AirBlastAnim = Humanoid:LoadAnimation(AnimationsFolder.AirBlast)
local FingerStrikeAnim = Humanoid:LoadAnimation(AnimationsFolder.FingerStrike)
local SuperBlastAnim = Humanoid:LoadAnimation(AnimationsFolder.SuperBlast)
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
local Coro = coroutine.wrap(function()
	while wait() do
		if not Character:FindFirstChild("Safezone") and Block == false then
		if RootPart:FindFirstChild("Light") and stunned == false and cantrun == false then
			elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false then
			stunned = true
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
end)
Coro()

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")
local rup = script:WaitForChild("RUP")
local cup = script:WaitForChild("CUP")

local SuperModeLight = script.PointLight
SuperModeLight.Parent = Character.UpperTorso
local SuperModeMultiplier = 1
local SuperMode = false
local SuperModeCD = false
ff.OnServerEvent:Connect(function()
	if Agility.Value >= 1000 and Durability.Value >= 1000 and Strength.Value >= 1000 and SuperMode == false and SuperModeCD == false then
		SuperModeLight.Enabled = true
		SuperMode = true
		SuperModeCD = true
		SuperModeMultiplier = 1.2
		Defense.Value = 1.2
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
				local lightning = script.Lightning:Clone()
				lightning.Parent = v
			end
		end
		local coro = coroutine.wrap(function()
			repeat wait(.5) 
			Stamina.Value = Stamina.Value - 25
			until SuperMode == false or Stamina.Value < 25
			SuperMode = false
			SuperModeMultiplier = 1
			SuperModeLight.Enabled = false
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
				v:FindFirstChild("Lightning"):Destroy()
			end
		end
		SuperModeCD = true
		wait(10)
		SuperModeCD = false
		end)
		coro()
	elseif SuperMode == true then
			SuperMode = false
		SuperModeMultiplier = 1
		Defense.Value = 1
		SuperModeLight.Enabled = false
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
				v:FindFirstChild("Lightning"):Destroy()
			end
		end
		SuperModeCD = true
		wait(10)
		SuperModeCD = false
	end
end)

local FingerStrike = false
qq.OnServerEvent:Connect(function(play,Target)
	if Attack.Value == false and stunned == false and Stamina.Value > 50 and FingerStrike == false then
		local hum = Target:FindFirstChild("Humanoid")
		local HRT = Target:FindFirstChild("HumanoidRootPart")
		if (HRT.Position - RootPart.Position).Magnitude > 150 or HRT.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, HRT.Parent) then return end
		Stamina.Value = Stamina.Value - 50
		FingerStrike = true
		FingerStrikeAnim:Play()
	local FingerStrikeModel = game.ServerStorage.FingerStrike:Clone()
	FingerStrikeModel.Parent = script
	for i,v in pairs(FingerStrikeModel:GetDescendants()) do
		if v.Name == "Start" then
		local Weld = Instance.new("Weld", v)
		Weld.Part0 = v
		Weld.Part1 = Character.RightHand
		elseif v.Name == "End" then
		v.CFrame = HRT.CFrame
		v.CanCollide = true
		local Weld = Instance.new("Weld", v)
		Weld.Part0 = v
		Weld.Part1 = HRT
		end
	end
	game.Debris:AddItem(FingerStrikeModel, 1)
	DmgFunction:Fire(Character, hum, 40*Strength.Value/2*SuperModeMultiplier)
	local Velocity = Instance.new("BodyVelocity",HRT)
	Velocity.Name = "Heavy"
	local ObjectVal = Instance.new("ObjectValue",Velocity)
	ObjectVal.Value = RootPart
	ObjectVal.Name = "Hitist"
	game.Debris:AddItem(Velocity,1)
	wait(1)
	FingerStrikeAnim:Stop()
	wait(5)
	FingerStrike = false
	end
end)

local AirBlast = false
zz.OnServerEvent:Connect(function()
		if Strength.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value >= 25 and AirBlast == false then
		AirBlast = true
		Attack.Value = true
		Stamina.Value = Stamina.Value - 25
		AirBlastAnim:Play()
		local PE = script.Lightning:Clone()
		PE.Parent = Character.LeftUpperArm
		wait(1)
		PE:Destroy()
		local AirBlastModel = game.ServerStorage.AfoAirBlast:Clone()
		AirBlastModel.Parent = script
		AirBlastModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)))
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if AirBlastModel == nil or AirBlastModel:FindFirstChild("HB") == nil then
					break
				end
				connection = AirBlastModel.HB.Touched:Connect(function() end)
				results = AirBlastModel.HB:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2*SuperModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,1)
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
	local coo = coroutine.wrap(function()
			repeat wait()
				AirBlastModel.Main.CFrame = AirBlastModel.Main.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
				AirBlastModel.Effect.CFrame = AirBlastModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
				AirBlastModel.Effect2.CFrame = AirBlastModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			until AirBlastModel == nil
	end)
	coo()
	AirBlastModel.Main.Particle.Enabled = true  
	TweenService:Create(AirBlastModel.Main, TweenInfo.new(2),{Size = Vector3.new(26, 120, 120),CFrame = AirBlastModel.Main.CFrame * CFrame.new(0,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.Effect, TweenInfo.new(2),{Size = Vector3.new(228,228,228),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-80,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.Effect2, TweenInfo.new(2),{Size = Vector3.new(180,106,106),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-100,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.HB, TweenInfo.new(2),{Size = Vector3.new(300, 106, 106),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-110,0,0),Transparency = 1}):Play()
	wait(1)
	AirBlastModel.Main.Particle.Enabled = false
	wait(1)
	AirBlastModel:Destroy()
	AirBlastAnim:Stop()
	Attack.Value = false
	wait(3)
	AirBlast = false
	end
end)

local Warp = false
xx.OnServerEvent:Connect(function(play, pos)
	if Agility.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value >= 25 and Warp == false and (RootPart.Position-pos).Magnitude < 500 then
		Warp = true
		Stamina.Value = Stamina.Value - 25
		Attack.Value = true
		local WarpModel = game.ServerStorage.AfoWarp:Clone()
		WarpModel.Parent= script
		WarpModel.CFrame = RootPart.CFrame
		WarpModel.Anchored = true
		game.Debris:AddItem(WarpModel,5)
		local WarpModel2 = game.ServerStorage.AfoWarp:Clone()
		WarpModel2.Parent= script
		WarpModel2.Anchored = true
		WarpModel2.CFrame = RootPart.CFrame
		game.Debris:AddItem(WarpModel2,5)
		local Weld = Instance.new("Weld", WarpModel)
		Weld.Part0 = RootPart
		Weld.Part1 = WarpModel
		wait(1)
		for i,v in pairs(WarpModel2:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		wait(.5)
		for i,v in pairs(WarpModel:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		local SafeTp = Instance.new("NumberValue",Character)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,.5)
		RootPart.CFrame = CFrame.new(pos)*CFrame.new(0,2.5,0)
		Weld:Destroy()
		Attack.Value = false
		wait(3)
		Warp = false
	end
end)

local ImpactRecoil = false
local ImpactRecoilCD = false
cc.OnServerEvent:Connect(function()
	if Durability.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value > 5 and ImpactRecoil == false and ImpactRecoilCD == false then
	ImpactRecoil = true
	ImpactRecoilCD = true
	Attack.Value = true
	ImpactRecoilAnim:Play()
	local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	UpDashEf.Parent = script
	UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
	local ImpactRecoilM = Instance.new("Model",Defense)
	ImpactRecoilM.Name = "ImpactRecoil"
	repeat wait()
	Defense.Value = 2*SuperModeMultiplier
	Stamina.Value = Stamina.Value - 5
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .1)
	end
	end)
	coo()
	until ImpactRecoil == false or Stamina.Value < 5 or not Defense:FindFirstChild("ImpactRecoil")
	ImpactRecoilAnim:Stop()
	ImpactRecoilM:Destroy()
	Defense.Value = 1*SuperModeMultiplier
	Attack.Value = false
	ImpactRecoil = false
	wait(3)
	ImpactRecoilCD = false
	end
end)

cup.OnServerEvent:Connect(function()
	if ImpactRecoil == true then
	ImpactRecoil = false
	end
end)

local SuperBlast = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 1000 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and SuperBlast == false then
		SuperBlast = true
		Attack.Value = true 
		Stamina.Value = Stamina.Value - 50
		SuperBlastAnim:Play()
		local AfoArm = game.ServerStorage.AfoArm:Clone()
		AfoArm.Parent = script
		local Weld = Instance.new("Motor6D", AfoArm.Main)
		Weld.Part0 = AfoArm.Main
		Weld.Part1 = Character.RightUpperArm
		Weld.C0 = Weld.C0*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		game.Debris:AddItem(AfoArm,1.7)
		wait(.7)
		local SuperBlastModel = game.ServerStorage.AfoSuperBlast:Clone()
		SuperBlastModel.Parent = script
		SuperBlastModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)))
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if SuperBlastModel == nil or SuperBlastModel:FindFirstChild("HB") == nil then
					break
				end
				connection = SuperBlastModel.HB.Touched:Connect(function() end)
				results = SuperBlastModel.HB:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 90*Strength.Value/2*SuperModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,1)
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
	local coo = coroutine.wrap(function()
			repeat wait()
				SuperBlastModel.Effect.CFrame = SuperBlastModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			until SuperBlastModel == nil
	end)
	coo() 
	TweenService:Create(SuperBlastModel.Effect, TweenInfo.new(2),{Size = Vector3.new(390, 495, 495),Transparency = 1}):Play()
	TweenService:Create(SuperBlastModel.HB, TweenInfo.new(2),{Size = Vector3.new(300, 250, 250),Transparency = 1}):Play()
	wait(2)
	SuperBlastModel:Destroy()
	AirBlastAnim:Stop()
	Attack.Value = false
	wait(15)
	SuperBlast = false
	end
end)

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	Defense.Value = 3*SuperModeMultiplier
	Stamina.Value = Stamina.Value - 3
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	end)
	coo()
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	Defense.Value = 1*SuperModeMultiplier
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

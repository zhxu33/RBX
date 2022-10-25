local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 21 then
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
local SuperPunchAnim = Humanoid:LoadAnimation(AnimationsFolder.SuperPunch)
local GroundSlamAnim = Humanoid:LoadAnimation(AnimationsFolder.GroundSlam)
local ChargeAttackAnim = Humanoid:LoadAnimation(AnimationsFolder.ChargeAttack)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
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

local MuscleModel = script:WaitForChild("MuscleModel")
local Weld2 = Instance.new("Weld", script.BigArm)
Weld2.Part0 = script.BigArm
Weld2.Part1 = Character.RightLowerArm
local Weld3 = Instance.new("Weld", MuscleModel.UpperTorso)
Weld3.Part0 = MuscleModel.UpperTorso
Weld3.Part1 = Character.UpperTorso
local Weld4 = Instance.new("Weld", MuscleModel.LeftUpperArm)
Weld4.Part0 = MuscleModel.LeftUpperArm
Weld4.Part1 = Character.LeftUpperArm
local Weld5 = Instance.new("Weld", MuscleModel.LeftLowerArm)
Weld5.Part0 = MuscleModel.LeftLowerArm
Weld5.Part1 = Character.LeftLowerArm
local Weld6 = Instance.new("Weld", MuscleModel.RightUpperArm)
Weld6.Part0 = MuscleModel.RightUpperArm
Weld6.Part1 = Character.RightUpperArm
local Weld7 = Instance.new("Weld", MuscleModel.RightLowerArm)
Weld7.Part0 = MuscleModel.RightLowerArm
Weld7.Part1 = Character.RightLowerArm
local Weld8 = Instance.new("Weld", MuscleModel.LowerTorso)
Weld8.Part0 = MuscleModel.LowerTorso
Weld8.Part1 = Character.LowerTorso
local Weld9 = Instance.new("Weld", MuscleModel.LeftUpperLeg)
Weld9.Part0 = MuscleModel.LeftUpperLeg
Weld9.Part1 = Character.LeftUpperLeg
local Weld10 = Instance.new("Weld", MuscleModel.LeftLowerLeg)
Weld10.Part0 = MuscleModel.LeftLowerLeg
Weld10.Part1 = Character.LeftLowerLeg
local Weld11 = Instance.new("Weld", MuscleModel.RightUpperLeg)
Weld11.Part0 = MuscleModel.RightUpperLeg
Weld11.Part1 = Character.RightUpperLeg
local Weld12 = Instance.new("Weld", MuscleModel.RightLowerLeg)
Weld12.Part0 = MuscleModel.RightLowerLeg
Weld12.Part1 = Character.RightLowerLeg
for i,v in pairs(MuscleModel:GetChildren()) do 
	v:FindFirstChild(v.Name).Transparency = 1
end
script.BigArm.Transparency = 1

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")

local ThickArms = false
local ThickLegs = false
local ThickChest = false
local MuslceMultiplier = 1
local GroundSlam = false 
local SuperPunch = false
local SuperPunchCD = false
local ChargeAttack = false

function unequipmuscle()
	ThickArms = false
	ThickLegs = false
	ThickChest = false
	cantrun = false
	MuslceMultiplier = 1
	Defense.Value = 1
	Humanoid.WalkSpeed = 18
	Humanoid.JumpPower = 50
	for i,v in pairs(MuscleModel:GetChildren()) do 
	v:FindFirstChild(v.Name).Transparency = 1
	end
end

local coro = coroutine.wrap(function()
	while wait(.5) do
		if ThickArms == true  and Stamina.Value >= 5 then
			Stamina.Value = Stamina.Value - 5
		elseif ThickArms == true and Stamina.Value < 5 then
			unequipmuscle()
		end
		if ThickLegs == true and Stamina.Value >= 10 then
			Stamina.Value = Stamina.Value - 10
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 160
			else
			Humanoid.WalkSpeed = 60 + 0.05 * Agility.Value	
			end
			Humanoid.JumpPower = 150
		elseif ThickArms == true and Stamina.Value < 10 then
			unequipmuscle()
		end
		if ThickChest == true and Stamina.Value >= 15 then
			Stamina.Value = Stamina.Value - 15
		elseif ThickArms == true and Stamina.Value < 15 then
			unequipmuscle()
		end
	end
end)
coro()

cc.OnServerEvent:Connect(function(play, direc)
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 40 and ChargeAttack == false and ThickArms == true then
		Attack.Value = true
		ChargeAttack = true
		Stamina.Value = Stamina.Value - 40
		Humanoid.AutoRotate = false
		ChargeAttackAnim:Play()
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direc.p)
		wait(.3)
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direc.p)
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.Name = "ChargeAttack"
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 250
		game.Debris:AddItem(BV, 1)
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(20,20,20)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = RootPart
		local Ef = game.ServerStorage.MuscleShock:Clone()
		Ef.Parent = script
		Ef.CFrame = RootPart.CFrame *CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		game.Debris:AddItem(Ef,0.5)
		TweenService:Create(Ef,TweenInfo.new(0.5),{Transparency = 1, Size = Vector3.new(55,50,55)}):Play()
		game.Debris:AddItem(HitPart,1.5)
		local PlayersHitted = {}
		HitPart.Touched:Connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
					local MuscleExplosion = game.ServerStorage.MuscleExplosion:Clone()
					MuscleExplosion.CFrame = HRT.CFrame
					MuscleExplosion.Parent = script
					game.Debris:AddItem(MuscleExplosion,0.5)
					TweenService:Create(MuscleExplosion,TweenInfo.new(0.5),{Transparency = 1, Size = Vector3.new(65,65,65)}):Play()
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = RootPart.CFrame.lookVector * 150
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
		wait(1)
		Attack.Value = false
		Humanoid.AutoRotate = true
		ChargeAttackAnim:Stop()
		wait(5)
		ChargeAttack = false
	end
end)

vv.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 60 and GroundSlam == false and ThickArms == true then
		Attack.Value = true
		GroundSlam = true
		Stamina.Value = Stamina.Value - 60
		GroundSlamAnim:Play()
		wait(.25)
		local MuscleGroundSlamModel = game.ServerStorage.MuscleGroundSlam2:Clone()
		MuscleGroundSlamModel.Parent = script
		MuscleGroundSlamModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0))
		local PlayersHitted = {}
		MuscleGroundSlamModel.Main.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 80*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Heavy"
						Velocity.Velocity = Vector3.new(0,75,0)
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
		local coo = coroutine.wrap(function()
		repeat wait()
		MuscleGroundSlamModel.Effect.CFrame = MuscleGroundSlamModel.Effect.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MuscleGroundSlamModel.Effect2.CFrame = MuscleGroundSlamModel.Effect2.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		until Attack.Value == false or MuscleGroundSlamModel == nil
		end)
		coo()
		TweenService:Create(MuscleGroundSlamModel.Effect,TweenInfo.new(1),{Size = Vector3.new(300, 39, 300),Position = MuscleGroundSlamModel.Effect.Position + Vector3.new(0,15,0)}):Play()
		TweenService:Create(MuscleGroundSlamModel.Effect2,TweenInfo.new(1),{Size = Vector3.new(180, 44, 180),Position = MuscleGroundSlamModel.Effect2.Position  + Vector3.new(0,15,0)}):Play()
		TweenService:Create(MuscleGroundSlamModel.Main,TweenInfo.new(1),{Size = Vector3.new(300, 39, 300),Position = MuscleGroundSlamModel.Main.Position  + Vector3.new(0,15,0)}):Play()
		wait(1.5)
		TweenService:Create(MuscleGroundSlamModel.Effect,TweenInfo.new(.5),{Transparency = 1}):Play()
		TweenService:Create(MuscleGroundSlamModel.Effect2,TweenInfo.new(.5),{Transparency = 1}):Play()
		wait(.5)
		MuscleGroundSlamModel:Destroy()
		Attack.Value = false
		wait(6)
		GroundSlam = false
	end
end)

qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value >= 20 and SuperPunch == false and SuperPunchCD == false and ThickArms == true then
		Attack.Value = true
		SuperPunchCD = true
		Stamina.Value = Stamina.Value - 20
		script.BigArm.Transparency = 0
		SuperPunchAnim:Play()
		wait(.5)
		local MuscleSmashModel = game.ServerStorage.MuscleSmash:Clone()
		MuscleSmashModel.Parent = script
		game.Debris:AddItem(MuscleSmashModel,.75)
		MuscleSmashModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-5)*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0)))
		TweenService:Create(MuscleSmashModel.Effect,TweenInfo.new(.75),{Size = Vector3.new(100,145,100),Transparency = 1}):Play()
		TweenService:Create(MuscleSmashModel.Effect2,TweenInfo.new(.75),{Size = Vector3.new(190,130,190),Transparency = 1}):Play()
		TweenService:Create(MuscleSmashModel.Effect3,TweenInfo.new(.75),{Size = Vector3.new(150,150,150),Transparency = 1}):Play()
		TweenService:Create(MuscleSmashModel.Main,TweenInfo.new(.75),{Size = Vector3.new(190,130,190),Transparency = 1}):Play()
		local PlayersHitted = {}
		MuscleSmashModel.Main.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
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
		SuperPunch = true
		wait(0.5)
		SuperPunch = false
		Attack.Value = false
		wait(0.5)
		script.BigArm.Transparency = 1
		wait(3)
		SuperPunchCD = false
	end
end)

zz.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and ThickArms == false then
	ThickArms = true
	for i,v in pairs(MuscleModel:GetChildren()) do 
	if v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "LeftUpperArm" or v.Name  == "LeftLowerArm" then
	v:FindFirstChild(v.Name).Transparency = 0
	end
	end
	MuslceMultiplier = 2
	elseif ThickArms == true then
	ThickArms = false
	for i,v in pairs(MuscleModel:GetChildren()) do 
	if v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "LeftUpperArm" or v.Name  == "LeftLowerArm" then
	v:FindFirstChild(v.Name).Transparency = 1
	end
	end
	MuslceMultiplier = 1
	end
end)

xx.OnServerEvent:Connect(function()
	if Agility.Value >= 250 and Attack.Value == false and stunned == false and ThickLegs == false then
	ThickLegs = true
	cantrun = true
	for i,v in pairs(MuscleModel:GetChildren()) do 
	if v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "LeftUpperLeg" or v.Name  == "LeftLowerLeg" then
	v:FindFirstChild(v.Name).Transparency = 0
	end
	end
	elseif ThickLegs == true then
	ThickLegs = false
	cantrun = false
	for i,v in pairs(MuscleModel:GetChildren()) do 
	if v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "LeftUpperLeg" or v.Name  == "LeftLowerLeg" then
	v:FindFirstChild(v.Name).Transparency = 1
	end
	end
	Humanoid.WalkSpeed = 18
	Humanoid.JumpPower = 50
	end
end)

ff.OnServerEvent:Connect(function()
	if Durability.Value >= 250 and Attack.Value == false and stunned == false and ThickChest == false then
	ThickChest = true
	for i,v in pairs(MuscleModel:GetChildren()) do 
	if v.Name == "UpperTorso" or v.Name == "LowerTorso" then
	v:FindFirstChild(v.Name).Transparency = 0
	end
	end
	Defense.Value = 2
	elseif ThickChest == true then
	ThickChest = false
	for i,v in pairs(MuscleModel:GetChildren()) do 
	if v.Name == "UpperTorso" or v.Name == "LowerTorso" then
	v:FindFirstChild(v.Name).Transparency = 1
	end
	end
	Defense.Value = 1
	end
end)
rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	if ThickChest == true then
	Defense.Value = 6
	elseif ThickChest == false then
	Defense.Value = 3
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
	if ThickChest == true then
	Defense.Value = 2
	elseif ThickChest == false then
	Defense.Value = 1
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
	wait(0.7)
	Attack.Value = false
	RightPunch = false
	elseif picked == 2 then
	LeftPunch = true
	Attack.Value = true
	wait(0.7)
	Attack.Value = false
	LeftPunch = false
	elseif picked == 3 then
	RightKick = true
	Attack.Value = true
	wait(0.7)
	Attack.Value = false
	RightKick = false
	elseif picked == 4 then
	LeftKick = true
	Attack.Value = true
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
			
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightPunch == true then
RightPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*MuslceMultiplier)
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
				wait(0.1)
				Velocity:Destroy()
end
		end
					end)
				
Character.LeftHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftPunch == true then
LeftPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*MuslceMultiplier)
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
				wait(0.1)
				Velocity:Destroy()
end
		end
					end)

Character.RightFoot.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightKick == true then
RightKick = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*MuslceMultiplier)
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
				wait(0.1)
				Velocity:Destroy()
end
		end
					end)
				

Character.LeftFoot.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftKick == true then
LeftKick = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*MuslceMultiplier)
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
				wait(0.1)
				Velocity:Destroy()
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
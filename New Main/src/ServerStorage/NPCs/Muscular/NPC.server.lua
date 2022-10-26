local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target     = nil
local Damage     = 15000
local Stunned    = false
local HitSound   = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim   = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim   = Humanoid:LoadAnimation(script.heavystunned)
local Stun             = Humanoid:LoadAnimation(script.stunned)
local ChargeAttackAnim = Humanoid:LoadAnimation(script.ChargeAttack)
local GroundSlamAnim   = Humanoid:LoadAnimation(script.GroundSlam)
local SuperPunchAnim   = Humanoid:LoadAnimation(script.SuperPunch) 
local TweenService     = game:GetService("TweenService")
local Supa1 = false
local Supa2 = false
local Supa3 = false
local supapoo   = false
local SupaType  = 1
local Assets    = game:GetService("ServerStorage").QuirkAssets.MuscleAugmentation
local UniAssets = game:GetService("ServerStorage").UniversalAssets

local function ComplicatedMistake()
	local newBind = Instance.new("BindableEvent")
	newBind.Name  = "Aggro"
	newBind.Event:Connect(function(newTarget)
		Target = newTarget.PrimaryPart or Target
	end)
	newBind.Parent = Character
end
ComplicatedMistake()

HumanoidRootPart.ChildAdded:Connect(function(Child)
	if Child == "Light" or Child == "Heavy" then
		Child:Destroy()
	end
end)

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
	v:FindFirstChild(v.Name).Transparency = 0
end
script.BigArm.Transparency = 1

local function CreateSupa1()
	GroundSlamAnim:Play()
	wait(.25)
	local MuscleGroundSlamModel  = Assets.MuscleGroundSlam2:Clone()
	MuscleGroundSlamModel.Parent = script
	MuscleGroundSlamModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	local PlayersHitted = {}
	MuscleGroundSlamModel.Main.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity    = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name     = "Heavy"
			Velocity.Velocity = Vector3.new(0,75,0)
			game.Debris:AddItem(Velocity,.75)
		end
	end)
	task.spawn(function()
		while wait() and MuscleGroundSlamModel.Parent do
			MuscleGroundSlamModel.Effect.CFrame  = MuscleGroundSlamModel.Effect.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MuscleGroundSlamModel.Effect2.CFrame = MuscleGroundSlamModel.Effect2.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		end
	end)
	TweenService:Create(MuscleGroundSlamModel.Effect,TweenInfo.new(1),{Size = Vector3.new(300, 39, 300),Position = MuscleGroundSlamModel.Effect.Position + Vector3.new(0,15,0)}):Play()
	TweenService:Create(MuscleGroundSlamModel.Effect2,TweenInfo.new(1),{Size = Vector3.new(180, 44, 180),Position = MuscleGroundSlamModel.Effect2.Position  + Vector3.new(0,15,0)}):Play()
	TweenService:Create(MuscleGroundSlamModel.Main,TweenInfo.new(1),{Size = Vector3.new(300, 39, 300),Position = MuscleGroundSlamModel.Main.Position  + Vector3.new(0,15,0)}):Play()
	wait(1.5)
	TweenService:Create(MuscleGroundSlamModel.Effect,TweenInfo.new(.5),{Transparency = 1}):Play()
	TweenService:Create(MuscleGroundSlamModel.Effect2,TweenInfo.new(.5),{Transparency = 1}):Play()
	wait(.5)
	MuscleGroundSlamModel:Destroy()
end

local function CreateSupa2()
	script.BigArm.Transparency = 0
	SuperPunchAnim:Play()
	wait(.5)
	local MuscleSmashModel = Assets.MuscleSmash:Clone()
	MuscleSmashModel.Parent = script
	game.Debris:AddItem(MuscleSmashModel,.75)
	MuscleSmashModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,0,-5)*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0)))
	TweenService:Create(MuscleSmashModel.Effect,TweenInfo.new(.75),{Size = Vector3.new(100,145,100),Transparency = 1}):Play()
	TweenService:Create(MuscleSmashModel.Effect2,TweenInfo.new(.75),{Size = Vector3.new(190,130,190),Transparency = 1}):Play()
	TweenService:Create(MuscleSmashModel.Effect3,TweenInfo.new(.75),{Size = Vector3.new(150,150,150),Transparency = 1}):Play()
	TweenService:Create(MuscleSmashModel.Main,TweenInfo.new(.75),{Size = Vector3.new(190,130,190),Transparency = 1}):Play()
	local PlayersHitted = {}
	MuscleSmashModel.Main.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name = "Heavy"
			Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 75
			game.Debris:AddItem(Velocity,.5)
		end
	end)
	wait(1)
	script.BigArm.Transparency = 1
end

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 then
			if supapoo == false then
				supapoo = true
				if SupaType == 1 then
					SupaType = 2
					CreateSupa1()
				elseif SupaType == 2 then
					SupaType = 1
					CreateSupa2()
				end
				local coo = coroutine.wrap(function()
					wait(3)
					supapoo = false
				end)
				coo()
			else
				local animation = Instance.new("Animation")
				animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
				DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
				local animTrack = Humanoid:LoadAnimation(animation)
				animTrack:Play()
				if CombatType == 1 then
					CombatType = 2
				elseif CombatType == 2 then
					CombatType = 3
				elseif CombatType == 3 then
					CombatType = 4
				elseif CombatType == 4 then
					CombatType = 1
				end
			end
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 75 and Humanoid.Health > 0 then
			if supapoo == false then
				supapoo = true
				if SupaType == 1 then
					SupaType = 2
					CreateSupa1()
				elseif SupaType == 2 then
					SupaType = 1
					CreateSupa2()
				end
				local coo = coroutine.wrap(function()
					wait(3)
					supapoo = false
				end)
				coo()	
			end
		end
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		local coro = coroutine.wrap(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,Character.Name)
			end
		end)
		coro()
	end
end)

local Walking = false
while wait(.5) do
	pcall(function()
		if (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		end
		if Target == nil then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, OriginalCFrame.p)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						break
					end
					Humanoid:MoveTo(Point.Position)
					Humanoid.MoveToFinished:wait()
					if Point.Action == Enum.PathWaypointAction.Jump  then
						Humanoid.Jump = true
					end
				end
			elseif Path.Status == Enum.PathStatus.NoPath then
				Humanoid:MoveTo(OriginalCFrame.p)
			end
		elseif Target.Parent == nil then 
			Target = nil
		elseif (Target.Position - OriginalCFrame.p).magnitude > 500 then
			Character:SetAttribute("Target", 0)
			Target = nil
		elseif (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, Target.Position)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						return
					end
					Humanoid:MoveTo(Point.Position)
					if Point.Action == Enum.PathWaypointAction.Jump  then
						Humanoid.Jump = true
					end
				end
			elseif Path.Status == Enum.PathStatus.NoPath then
				Humanoid:MoveTo(Target.Position)
			end
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 then
			Target = nil
		end
	end)
end
local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target  = nil
local Damage  = 45000
local Stunned = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim      = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun           = Humanoid:LoadAnimation(script.stunned)
local TweenService   = game:GetService("TweenService")
local Assets         = game:GetService("ServerStorage").UniversalAssets

local Shield    = false
local Players   = game:GetService("Players")
local NewTarget = nil

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
	if Child == "Light" then
		Child:Destroy()
	elseif Child == "Heavy" and not Shield then
		Stunned = true
		local asdfg = false
		HvyStunnedAnim:Play()
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		for i = 1,3 do
			if asdfg == true or not HumanoidRootPart:FindFirstChild("Heavy") then
				break
			else
				wait(0.25) -- stuntime
			end
		end			
		if HumanoidRootPart:FindFirstChild("Heavy") then
			HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
		end

		HvyStunnedAnim:Stop()
		asdfg = true
		Humanoid.WalkSpeed = 100
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 100 then
		Humanoid.WalkSpeed = 100
	end
end)


local AnimationFolder = script.Parent.Animations
local ShieldThrowAnim = Humanoid:LoadAnimation(AnimationFolder.ShieldThrow)
local ShieldPoundAnim = Humanoid:LoadAnimation(AnimationFolder.ShieldPound)

local MoveUsage = false
local UsingMove = false
local Multiplier = 1

local ShieldCooldown = false

local function DefenseUp()
	task.spawn(function()
		Shield = true
		script.Parent.Defense.Value = 1.35
		Multiplier = 1.35
		local ShieldPart      = Assets.CrustModels.SmallShield:Clone()
		ShieldPart.Parent     = script.Parent.RightLowerArm
		ShieldPart.CFrame     = script.Parent.RightLowerArm.CFrame*CFrame.new(0.6, 0, 0)*CFrame.Angles(math.rad(180), 0, math.rad(90))
		ShieldPart.Weld.Part1 = script.Parent.RightLowerArm
		local ShieldPart2  = Assets.CrustModels.SmallShield:Clone()
		ShieldPart2.Parent = script.Parent.LeftLowerArm
		ShieldPart2.CFrame = script.Parent.LeftLowerArm.CFrame*CFrame.new(-0.6, 0, 0)*CFrame.Angles(0, 0, math.rad(90))
		ShieldPart2.Weld.Part1 = script.Parent.LeftLowerArm
		local UpDashEf = game.ServerStorage.UniversalAssets.UpDashEffect:Clone()
		UpDashEf.Parent = script
		UpDashEf.CFrame = HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		UpDashEf.Decal.Color3 = Color3.new(112, 112, 112)
		UpDashEf.Decal1.Color3 = Color3.new(112, 112, 112)
		game.Debris:AddItem(UpDashEf,0.5)
		TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
		TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
		
		task.wait(4)
		Shield = false
		script.Parent.Defense.Value = 1
		Multiplier = 1
		ShieldPart:Destroy()
		ShieldPart2:Destroy()
	end)
end

local function ShieldPound()
	local ShieldPart  = Assets.CrustModels.BladeShield:Clone()
	ShieldPart.Parent = script.Parent.RightLowerArm
	ShieldPart.CFrame = script.Parent.RightLowerArm.CFrame*CFrame.new(0.6, 0, 0)*CFrame.Angles(math.rad(180), 0, math.rad(90))
	ShieldPart.Weld.Part1 = script.Parent.RightLowerArm
	local ShieldPart2  = Assets.CrustModels.BladeShield:Clone()
	ShieldPart2.Parent = script.Parent.LeftLowerArm
	ShieldPart2.CFrame = script.Parent.LeftLowerArm.CFrame*CFrame.new(-0.6, 0, 0)*CFrame.Angles(0, 0, math.rad(90))
	ShieldPart2.Weld.Part1 = script.Parent.LeftLowerArm
	local UpDashEf = game.ServerStorage.UniversalAssets.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	UpDashEf.Decal.Color3 = Color3.new(112, 112, 112)
	UpDashEf.Decal1.Color3 = Color3.new(112, 112, 112)
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
	ShieldPoundAnim:Play()
	ShieldPoundAnim:AdjustSpeed(1.33)
	wait(0.2)
	local Shockwave = game.ServerStorage.QuirkAssets.MuscleAugmentation.MuscleGroundSlam2:Clone()
	Shockwave.Parent = script
	Shockwave:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,0,0))
	local PlayersHit = {}
	Shockwave.Main.Touched:Connect(function(hit)
		if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHit, hit.Parent) then return end
			table.insert(PlayersHit, hit.Parent)

			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1)
		end
	end)
	task.spawn(function()
		while task.wait() and Shockwave.Parent do
			Shockwave.Effect.CFrame = Shockwave.Effect.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			Shockwave.Effect2.CFrame = Shockwave.Effect2.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		end
	end)
	
	TweenService:Create(Shockwave.Effect,  TweenInfo.new(.4),{Size = Vector3.new(200, 19.5, 200), Position = Shockwave.Effect.Position  + Vector3.new(0,7.5,0)}):Play()
	TweenService:Create(Shockwave.Effect2, TweenInfo.new(.4),{Size = Vector3.new(90, 22, 90),     Position = Shockwave.Effect2.Position + Vector3.new(0,7.5,0)}):Play()
	TweenService:Create(Shockwave.Main,    TweenInfo.new(.4),{Size = Vector3.new(200, 19.5, 200), Position = Shockwave.Main.Position    + Vector3.new(0,7.5,0)}):Play()
	wait(0.6)
	TweenService:Create(Shockwave.Effect,  TweenInfo.new(.2),{Transparency = 1}):Play()
	TweenService:Create(Shockwave.Effect2, TweenInfo.new(.2),{Transparency = 1}):Play()
	wait(0.4)
	ShieldPart:Destroy()
	ShieldPart2:Destroy()
end

local function ShieldThrow()
	local Hitted = false
	ShieldThrowAnim:Play()
	ShieldThrowAnim:AdjustSpeed(0.3)
	local ShieldPart = Assets.CrustModels.BladeShield:Clone()
	ShieldPart.Parent = script.Parent.RightLowerArm
	ShieldPart.CFrame = script.Parent.RightLowerArm.CFrame*CFrame.new(0.6, 0, 0)*CFrame.Angles(math.rad(180), 0, math.rad(90))
	ShieldPart.Weld.Part1 = script.Parent.RightLowerArm
	local UpDashEf  = Assets.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = ShieldPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	UpDashEf.Decal.Color3  = Color3.new(112, 112, 112)
	UpDashEf.Decal1.Color3 = Color3.new(112, 112, 112)
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(10,0.05,10)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.3),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.3),{Transparency = 1}):Play()
	wait(0.5)
	ShieldPart:Destroy()
	local ShieldThrow  = Assets.CrustModels.ShieldThrow:Clone()
	ShieldThrow.Parent = script
	ShieldThrow.CFrame = CFrame.new(HumanoidRootPart.CFrame.p, Target.CFrame.p)
	game.Debris:AddItem(ShieldThrow, 1)
	TweenService:Create(ShieldThrow.ShieldShockwave, TweenInfo.new(1), {Transparency = 1}):Play()
	local BV    = Instance.new("BodyVelocity") BV.Parent = ShieldThrow
	BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	BV.Velocity = CFrame.new(HumanoidRootPart.Position, Target.Position).lookVector*300
	local PlayersHit = {}
	ShieldThrow.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHit, hit.Parent) then return end
			table.insert(PlayersHit, hit.Parent)

			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2.5)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name  = "Heavy"
			game.Debris:AddItem(Velocity,1.5)
		end
	end)
end

local Moveset = {ShieldPound, ShieldThrow}
local MoveCycle = 1
task.spawn(function()
	while task.wait(.5) do
		if Target and Humanoid.Health > 0 and Stunned == false and not ShieldCooldown and not UsingMove then
			ShieldCooldown = true
			DefenseUp()
			coroutine.wrap(function() wait(10) ShieldCooldown = false end)()
		elseif Target and (((Target.Position - HumanoidRootPart.Position).magnitude < 125 and MoveCycle == 1) or ((Target.Position - HumanoidRootPart.Position).magnitude < 200 and MoveCycle == 2)) and Humanoid.Health > 0 and Stunned == false and not MoveUsage then
			MoveUsage = true
			UsingMove = true
			task.delay(5, function() MoveUsage = false end)
			Moveset[MoveCycle]()
			wait(.5)
			UsingMove = false
			if MoveCycle < #Moveset then
				MoveCycle = MoveCycle + 1
			else
				MoveCycle = 1
			end
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false and not UsingMove then
			local animation = script.Punch
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage*Multiplier)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			CombatType += 1
			if CombatType > 4 then CombatType = 1 end
		end
	end
end)


Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,"Pro Hero")
end)

while task.wait(.5) do
	pcall(function()
		if Target == nil then
			Humanoid:MoveTo(OriginalCFrame.p)
		elseif Target.Parent == nil then 
			Target = nil
		elseif (Target.Position - OriginalCFrame.p).magnitude > 500 then
			Character:SetAttribute("Target", 0)
			Humanoid:MoveTo(OriginalCFrame.p)
			Target = nil
		elseif (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
			Humanoid:MoveTo(Target.Position)
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 then
			Target = nil
		else
			Target = nil
		end
	end)
end
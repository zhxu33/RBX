local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Smash = Humanoid:LoadAnimation(script.Smash)
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local FastSmashAnim = Humanoid:LoadAnimation(script.QuickSmash)
local USSmashAnim = Humanoid:LoadAnimation(script.USSmash)
local Attack = false
local AttackDB = false
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 80000
local HitSound = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://450719019"
HitSound.Volume = 0.2
local Stunned = false
local Angeryierest = false
local USASmash = false
local AttackCoolDown = 3
local WalkSpeed = 100
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local TweenService = game:GetService("TweenService")
local Assets = game:GetService("ServerStorage").QuirkAssets.OFA
local UniAssets = game:GetService("ServerStorage").UniversalAssets
local Players = game:GetService("Players")

Smash.Stopped:Connect(function()
	Attack = false
	AttackDB = false
	Humanoid.WalkSpeed = WalkSpeed
end)

FastSmashAnim.Stopped:Connect(function()
	Attack = false
	AttackDB = false
	Humanoid.WalkSpeed = WalkSpeed
end)

function DetroitEffect()
	local sound1 = Instance.new("Sound")
	sound1.SoundId = "rbxassetid://138137702"
	sound1.MaxDistance = 300
	sound1.EmitterSize = 20
	sound1.Volume = 1
	sound1.Pitch = 0.95
	sound1.Parent = HumanoidRootPart 
	sound1:Play()
	game.Debris:AddItem(sound1, 5)
	local shok = UniAssets.NpcTexasSmash2:Clone()
	shok:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,5,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
	shok.Parent = script
	local Effect = shok.ShockEffect
	Effect.Anchored = true
	local Effect3 = shok.Effect3
	Effect3.Anchored = true
	local Effect4 = shok.Effect4
	Effect4.Anchored = true
	local Effect2 = UniAssets.Shockwave3:Clone()
	Effect2.Parent = script
	Effect2.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	Effect2.Anchored = true
	Effect2.Size = Vector3.new(60,8,60)
	local bv = Instance.new("BodyVelocity", shok.HB)
	bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = HumanoidRootPart.CFrame.lookVector * 125
	shok.HB.Anchored = false
	local PlayersHitted = {}
	shok.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent ~= Character and hit.Parent.Parent.Name ~= "NPCs" then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,.7)
			Velocity.Velocity = bv.Velocity
		end
	end)
	
	task.spawn(function()
		while wait() and shok.Parent do
			shok.HB.CFrame = shok.HB.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			Effect.CFrame = Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			Effect2.CFrame = Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			Effect3.CFrame = Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect4.CFrame = Effect4.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		end
	end)
	
	TweenService:Create(Effect,TweenInfo.new(3), {Size = Vector3.new(100,240,240)}):Play()
	TweenService:Create(Effect2,TweenInfo.new(3), {Size = Vector3.new(166,27,166)}):Play()
	TweenService:Create(Effect3,TweenInfo.new(3), {Size = Vector3.new(190, 53, 190)}):Play()
	TweenService:Create(Effect4,TweenInfo.new(3), {Size = Vector3.new(250, 83, 250)}):Play()
	task.delay(1.5, function()
		TweenService:Create(Effect,TweenInfo.new(1.5), {Transparency = 1}):Play()
		TweenService:Create(Effect2,TweenInfo.new(1.5), {Transparency = 1}):Play()
		TweenService:Create(Effect3,TweenInfo.new(1.5), {Transparency = 1}):Play()
		TweenService:Create(Effect4,TweenInfo.new(1.5), {Transparency = 1}):Play()
		for i,v in pairs(shok:GetChildren()) do
			TweenService:Create(v,TweenInfo.new(1.5), {Transparency = 1}):Play()
		end
		wait(1.5)
		shok:Destroy()
		Effect2:Destroy()
	end)
end

function UnitedSmash()
	local USSClone = Assets.NewUSS:Clone()
	USSClone.Parent = script
	USSClone:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,2.5,0))
	game.Debris:AddItem(USSClone, 6)
	local sound2 = Instance.new("Sound")
	sound2.SoundId = "rbxassetid://157878578"
	sound2.MaxDistance = 300
	sound2.EmitterSize = 20
	sound2.Volume = 1.5
	sound2.Pitch = 0.9
	sound2.Parent = HumanoidRootPart
	sound2:Play()
	game.Debris:AddItem(sound2, 5)
	local PlayersHitted = {}
	USSClone.HB.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= Character and hit.Parent.Parent.Name ~= "NPCs" and USSClone.Shockwave.Transparency < 1 then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
			local humanoidrootpart = hit.Parent:FindFirstChild("HumanoidRootPart")
			local Heavy = Instance.new("BodyVelocity",humanoidrootpart)
			Heavy.Name = "Heavy"
			Heavy.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Heavy.Velocity = Vector3.new(0,75,0)
			game.Debris:AddItem(Heavy,1)
			DmgFunction:Fire(Character, humanoid, Damage*4)
		end
	end)

	task.spawn(function()
		while wait() and USSClone and USSClone.Parent do
			USSClone.Coil.CFrame = USSClone.Coil.CFrame*CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			USSClone.Shockwave.CFrame = USSClone.Shockwave.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
		end
	end)

	wait(1.5)
	TweenService:Create(USSClone.Coil, TweenInfo.new(2), {Transparency = 1}):Play()
	TweenService:Create(USSClone.Shockwave, TweenInfo.new(2), {Transparency = 1}):Play()
	task.delay(20, function()
		USASmash = false
	end)
end

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

task.spawn(function()
	while task.wait(.1) do
		if Attack == false and Target ~= nil and (HumanoidRootPart.Position - Target.Position).magnitude < 200 and Humanoid.Health > 0 then
			if Angeryierest == true and USASmash == true then
				FastSmashAnim:Play()
			elseif Angeryierest == false and USASmash == true then		
				Smash:Play()
			elseif USASmash == false then
				USSmashAnim:Play()
			end
			Attack = true
			if Angeryierest == true and USASmash == true then
				wait(.6)
			elseif Angeryierest == false and USASmash == true then
				wait(1.1)
			elseif USASmash == false then
				wait(.8)
			end
			if USASmash == true then
				DetroitEffect()
				Attack = false
				wait(AttackCoolDown)
			elseif USASmash == false then
				USASmash = true
				UnitedSmash()
				Attack = false
				wait(AttackCoolDown)
			end
		end
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		task.spawn(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,Character.Name)
			end
		end)
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
			task.wait()
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
			task.wait()
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
		if Humanoid.Health <= Humanoid.MaxHealth/2 and Angeryierest == false then
			Angeryierest = true
			AttackCoolDown = 2.5
			Damage = Damage * 1.5
			WalkSpeed = WalkSpeed * 1.5
			for i,v in pairs(Character:GetChildren()) do
				if v.Name == "RightLowerArm" or v.Name == "UpperTorso" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
					local lightning = script.Lightning:Clone()
					lightning.Parent = v
				end
			end
			script.PointLight.Parent = HumanoidRootPart
			local SW = UniAssets.Shockwave:Clone()
			SW.Parent = HumanoidRootPart
			SW.CFrame = HumanoidRootPart.CFrame
			task.spawn(function()
				for i = 1,10 do
					SW.Size = SW.Size + Vector3.new(2.5,0,2.5)
					SW.Orientation = SW.Orientation + Vector3.new(0,10,0)
					SW.Transparency = SW.Transparency + .1
					task.wait()
				end
				SW:Destroy()
			end)
		end
	end)
end

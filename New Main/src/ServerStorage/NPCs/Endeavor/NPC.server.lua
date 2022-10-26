local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target     = nil
local Damage     = 45000
local Stunned    = false
local HitSound   = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume  = 0.2
local CombatType = 1
local RespawnNPC        = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward         = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction       = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward            = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim         = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim    = Humanoid:LoadAnimation(script.heavystunned)
local Stun              = Humanoid:LoadAnimation(script.stunned)
local FireBallThrowAnim = Humanoid:LoadAnimation(script.FireBallThrow)
local HellSpiderAnim    = Humanoid:LoadAnimation(script.HellSpider)
local HellBeamAnim      = Humanoid:LoadAnimation(script.HellBeam)
local TweenService      = game:GetService("TweenService")
local HellFlameMode     = false
local Supa1     = false
local Supa2     = false
local Supa3     = false
local Supapoo   = false
local SupaType  = 1
local WalkSpeed = 100
local Assets    = game:GetService("ServerStorage").QuirkAssets.HellFlame
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
	if Child == "Light" then
		Child:Destroy()
	elseif HellFlameMode == true then
		Child:Destroy()
	elseif Child == "Heavy" then
		Stunned = true
		local asdfg = false
		HvyStunnedAnim:Play()
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		for i = 1,3 do
			if asdfg == true or not HumanoidRootPart:FindFirstChild("Heavy") then
				break
			else
				task.wait(0.25) -- stuntime
			end
		end
		if HumanoidRootPart:FindFirstChild("Heavy") then
			HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
		end
		HvyStunnedAnim:Stop()
		asdfg = true
		Humanoid.WalkSpeed = WalkSpeed
		Humanoid.JumpPower = 150
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= WalkSpeed then
		Humanoid.WalkSpeed = WalkSpeed
		Humanoid.JumpPower = 150
	end
end)

local function CreateSupa1()
	FireBallThrowAnim:Play()
	local fire = UniAssets.HellFireBall:Clone()
	fire.Parent = script
	game.Debris:AddItem(fire, 2)
	local DirecPart = Instance.new("Part", script)
	DirecPart.Anchored = true
	DirecPart.CanCollide = false
	DirecPart.Transparency = 1
	if Target ~= nil and Target.Parent then
		DirecPart.CFrame =  CFrame.new(HumanoidRootPart.CFrame.p,Target.CFrame.p)
	else
		DirecPart.CFrame =  HumanoidRootPart.CFrame
	end
	fire.HB.CFrame = DirecPart.CFrame*CFrame.new(0,4,0)
	local bv = Instance.new("BodyVelocity", fire.HB)
	bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = DirecPart.CFrame.lookVector * 250
	fire.HB.Anchored = false
	DirecPart:Destroy()
	local Exploded = false
	local PlayersHitted = {}
	fire.HB.Touched:Connect(function(hitto)
		if hitto.Parent.Name ~= Character.Name and not hitto:IsDescendantOf(Character) and Exploded == false then
			Exploded = true
			for i,v in pairs(fire:GetChildren()) do
				v.Anchored = true
			end
			local ExplodeModel = Assets.HellFlameExplosion2:Clone()
			ExplodeModel.Parent = script
			ExplodeModel:SetPrimaryPartCFrame(fire.HB.CFrame)
			fire:Destroy()
			ExplodeModel.HB.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
					if table.find(PlayersHitted, hit.Parent) then return end
					table.insert(PlayersHitted, hit.Parent)
					
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, Damage*3)
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					Velocity.Velocity = bv.Velocity
					Velocity.Name = "Heavy"
					game.Debris:AddItem(Velocity,.7)
				end
			end)
			task.spawn(function()
				while task.wait() and ExplodeModel.Parent do
					ExplodeModel.Effect.CFrame = ExplodeModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(-29), math.rad(29))
					ExplodeModel.Effect2.CFrame = ExplodeModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
					ExplodeModel.Effect3.CFrame = ExplodeModel.Effect3.CFrame * CFrame.Angles(math.rad(-29), math.rad(29), math.rad(20))
				end
			end)
			
			TweenService:Create(ExplodeModel.HB,      TweenInfo.new(1.5), {Size = Vector3.new(180,180,180),Transparency = 1}):Play()
			TweenService:Create(ExplodeModel.Effect,  TweenInfo.new(1.5),{Size = Vector3.new(180,180,180),Transparency = 1}):Play()
			TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1.5), {Size = Vector3.new(180,180,180),Transparency = 1}):Play()
			TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1.5), {Size = Vector3.new(180,180,180),Transparency = 1}):Play()
			game.Debris:AddItem(ExplodeModel,1.5)
			wait(0.7)
			
			for i,v in pairs(ExplodeModel:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v.Enabled = false
				end
			end
		end
	end)
	task.wait(1)
end

local function CreateSupa2()
	local HellSpiderModel = Assets.HellSpider:Clone()
	HellSpiderAnim:Play()
	wait(.3)
	HellSpiderModel.Parent = script
	HellSpiderModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)))
	TweenService:Create(HellSpiderModel.Effect,TweenInfo.new(.3),{Size = HellSpiderModel.Effect.Size*4, CFrame = HellSpiderModel.Effect.CFrame * CFrame.new(57,0,0)}):Play()
	task.spawn(function()
		while task.wait() and HellSpiderModel.Parent do
			HellSpiderModel.Effect.CFrame  = HellSpiderModel.Effect.CFrame * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0))
			HellSpiderModel.Effect2.CFrame = HellSpiderModel.Effect2.CFrame * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0))
			HellSpiderModel.Effect3.CFrame = HellSpiderModel.Effect3.CFrame * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0))
		end
	end)
	
	local PlayersHit = {}
	HellSpiderModel.HB.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHit) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHit, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,.7)
		end
	end)
	wait(1)
	for i,v in pairs(HellSpiderModel:GetChildren()) do
		if v.Name ~= "Main" and v.Name ~= "HB" then
			TweenService:Create(v,TweenInfo.new(.75),{Transparency = 1}):Play()
		end
	end
	HellSpiderAnim:Stop()
	wait(1)
	HellSpiderModel:Destroy()
	wait(1)
end


local function CreateSupa3()
	for i,v in pairs(Character:GetChildren()) do
		if v.Name == "LeftFoot" or v.name == "LeftHand" or v.Name == "LeftUpperArm" or v.Name == " LeftUpperLeg" or v.Name == "RightFoot" or v.Name == "RightUpperLeg"
			or v.Name == "RightUpperArm" or v.Name == "UpperTorso" or v.Name == "Head" then
			local Pe1 = Assets.HellFlameULT:Clone()
			Pe1.Parent = v
			local Pe2 = Assets.HellFlameULT2:Clone()
			Pe2.Parent = v
			game.Debris:AddItem(Pe1, 3)
			game.Debris:AddItem(Pe2, 3)
		end
	end
	wait(.3)
	local PModel = Assets.HellFlameBeam:Clone()
	PModel.Parent = script
	if Target ~= nil and Target.Parent then
		PModel:SetPrimaryPartCFrame(CFrame.new(HumanoidRootPart.CFrame.p,Target.CFrame.p))
	else
		PModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	end
	
	local HB = Instance.new("Part", PModel)
	HB.Anchored     = true
	HB.CanCollide   = false
	HB.Transparency = 1
	local PBeam  = PModel.PBBeam
	local PBeam2 = PModel.PBBeam2
	local PBeam3 = PModel.PBBeam3
	HB.Size   = PBeam.Size
	HB.CFrame = PBeam.CFrame
	local PlayersHitted = {}
	HB.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart") 
			local ExplodeModel = Assets.HellFlameExplosion:Clone()
			ExplodeModel.Parent = script
			ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)
			game.Debris:AddItem(ExplodeModel,1.25)
			TweenService:Create(ExplodeModel.DMG,   TweenInfo.new(1.25), {Size = ExplodeModel.DMG.Size + Vector3.new(40,40,40)}):Play()
			TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(100,100,100)}):Play()
			TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(60,60,60)}):Play()
			DmgFunction:Fire(Character, hum, Damage*5)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 100
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1)
		end
	end)
	
	TweenService:Create(PBeam,  TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(12,240,12)}):Play()
	TweenService:Create(PBeam2, TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(24,240,24)}):Play()
	TweenService:Create(PBeam3, TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(18,240,18)}):Play()
	TweenService:Create(HB,     TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(24,240,24)}):Play()
	task.spawn(function()
		while wait() and PModel and PModel.Parent do
			PModel.PBstart.CFrame= PModel.PBstart.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(15))
			PModel.PBstart2.CFrame= PModel.PBstart2.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(15))
		end 
	end)
	
	task.wait(1.5)
	for i,v in pairs(PBeam:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	
	TweenService:Create(PBeam,  TweenInfo.new(1), {Transparency = 1}):Play()
	TweenService:Create(PBeam2, TweenInfo.new(1), {Transparency = 1}):Play()
	TweenService:Create(PBeam3, TweenInfo.new(1), {Transparency = 1}):Play()
	wait(1)
	HellBeamAnim:Stop()
	PModel:Destroy()
	wait(1)
end

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and Stunned == false then
			if SupaType == 1 then
				SupaType = 2
				CreateSupa1()
			elseif SupaType == 2 then
				SupaType = 3
				CreateSupa2()
			elseif SupaType == 3 then
				SupaType = 1
				CreateSupa3()
			end
		end
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
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
		if Humanoid.Health <= Humanoid.MaxHealth/2 and HellFlameMode == false then
			HellFlameMode = true
			Damage = Damage * 1.5
			WalkSpeed = WalkSpeed * 1.5
			local Light = Assets.HellFlameLight:Clone()
			Light.Parent = HumanoidRootPart
			for i,v in pairs(Character:GetChildren()) do
				if v:IsA("MeshPart") or v.Name == "Head" then
					local PE = Assets.HellFlameFire:Clone()
					PE.Parent = v
					local PE2 = Assets.HellFlameFire2:Clone()
					PE2.Parent = v
					local PE3 = Assets.HellFlameFire3:Clone()
					PE3.Parent = v
				end
			end
		end
	end)
end
local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina = script.Parent.Stamina
local MaxStamina            = script.Parent.MaxStamina
local Target                = nil
local Damage                = 7500
local Stunned               = false
local HitSound              = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId            = "rbxassetid://232210146"
HitSound.Volume             = 0.2
local CombatType            = 1
local RespawnNPC            = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward             = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction           = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward                = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim             = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim        = Humanoid:LoadAnimation(script.heavystunned)
local Stun                  = Humanoid:LoadAnimation(script.stunned)
local IncineratingBlastAnim = Humanoid:LoadAnimation(script.IncineratingBlast)
local BurstingInfernoAnim   = Humanoid:LoadAnimation(script.BurstingInferno)
local PyreWallAnim          = Humanoid:LoadAnimation(script.PyreWall) 
local TweenService          = game:GetService("TweenService")
local Supa1     = false
local Supa2     = false
local Supa3     = false
local Supapoo   = false
local SupaType  = 1
local Assets    = game:GetService("ServerStorage").QuirkAssets.Cremation
local UniAssets = game:GetService("ServerStorage")

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
	elseif Child == "Heavy"  then
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
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 75 then
		Humanoid.WalkSpeed = 75
	end
end)

local function CreateSupa1()
	BurstingInfernoAnim:Play()
	wait(.25)
	local BurstingInfernoModel = Assets.BurstingInferno:Clone()
	BurstingInfernoModel.Parent = script
	BurstingInfernoModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)))
	game.Debris:AddItem(BurstingInfernoModel, 1.5)
	TweenService:Create(BurstingInfernoModel.HB, TweenInfo.new(1), {Size = Vector3.new(53, 53, 162), Transparency = 1, CFrame = BurstingInfernoModel.HB.CFrame * CFrame.new(0,0,-60)}):Play()
	TweenService:Create(BurstingInfernoModel.Effect1, TweenInfo.new(1), {Size = Vector3.new(60, 72, 60), Transparency = 1}):Play()
	TweenService:Create(BurstingInfernoModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(75, 7.5, 75), Transparency = 1}):Play()
	TweenService:Create(BurstingInfernoModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(120, 18, 120), Transparency = 1}):Play()
	TweenService:Create(BurstingInfernoModel.Inside, TweenInfo.new(1), {Size = Vector3.new(49, 49, 154), Transparency = 1,CFrame = BurstingInfernoModel.Inside.CFrame * CFrame.new(0,0,-60)}):Play()
	
	task.spawn(function()
		local Effect = BurstingInfernoModel.Effect1
		while task.wait() and Effect.Parent do
			BurstingInfernoModel.Effect1.CFrame = BurstingInfernoModel.Effect1.CFrame * CFrame.Angles(math.rad(2), math.rad(29), math.rad(0))
			BurstingInfernoModel.Effect2.CFrame = BurstingInfernoModel.Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			BurstingInfernoModel.Effect3.CFrame = BurstingInfernoModel.Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		end
	end)

	local PlayersHitted = {}
	BurstingInfernoModel.HB.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Heavy"
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 100
			game.Debris:AddItem(Velocity,1)
		end
	end)

	task.wait(1)
	task.spawn(function()
		if BurstingInfernoModel:FindFirstChild("Effect3") then
			BurstingInfernoModel.Effect3.Particle.Enabled = false
		end
	end)
end

local function CreateSupa2()
	PyreWallAnim:Play()
	task.wait(.4)
	local CremationTornado = Assets.CremationTornado:Clone()
	CremationTornado.Parent = script
	CremationTornado.CFrame = HumanoidRootPart.CFrame
	TweenService:Create(CremationTornado, TweenInfo.new(1),{Size = Vector3.new(300,80,300), Transparency = 1}):Play()
	game.Debris:AddItem(CremationTornado,1)
	local EruptingFlamesModel = Assets.EruptingFlames:Clone()
	EruptingFlamesModel.Parent = script
	EruptingFlamesModel.Spiky:Destroy()
	EruptingFlamesModel.Round.Size      = Vector3.new(25,25,25)
	EruptingFlamesModel.HB.Size         = Vector3.new(18,18,18)
	EruptingFlamesModel.InsideBall.Size = Vector3.new(10,10,10)
	EruptingFlamesModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	game.Debris:AddItem(EruptingFlamesModel,1)
	TweenService:Create(EruptingFlamesModel.Round, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(200,200,200)}):Play()
	TweenService:Create(EruptingFlamesModel.HB, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(130,130,130)}):Play()
	TweenService:Create(EruptingFlamesModel.InsideBall, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(80,80,80)}):Play()
	for i,v in pairs(EruptingFlamesModel.InsideBall:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Rate = NumberSequence.new(15)
		end
	end

	task.spawn(function()
		local Round = EruptingFlamesModel.Round
		while task.wait() and Round.Parent do
			EruptingFlamesModel.Round.CFrame = EruptingFlamesModel.Round.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(29))
		end
	end)

	wait(.3)
	for i,v in pairs(CremationTornado:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	
	for i,v in pairs(EruptingFlamesModel.InsideBall:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	local PyreWallModel = Assets.PyreWall:Clone()
	PyreWallModel.Parent = script
	PyreWallModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,45,0))
	game.Debris:AddItem(PyreWallModel,6)
	task.spawn(function()
		while wait() and PyreWallModel.Parent do
			PyreWallModel.Effect.CFrame  = PyreWallModel.Effect.CFrame  * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
			PyreWallModel.Effect2.CFrame = PyreWallModel.Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
			PyreWallModel.Effect3.CFrame = PyreWallModel.Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
			PyreWallModel.HB.CFrame      = PyreWallModel.HB.CFrame      * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
		end
	end)
	
	task.spawn(function()
		wait(5)
		if PyreWallModel then
			for i,v in pairs(PyreWallModel:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v.Enabled = false
				end
			end
			TweenService:Create(PyreWallModel.Effect,  TweenInfo.new(1), {Transparency = 1}):Play()
			TweenService:Create(PyreWallModel.Effect2, TweenInfo.new(1), {Transparency = 1}):Play()
			TweenService:Create(PyreWallModel.Effect3, TweenInfo.new(1), {Transparency = 1}):Play()
		end
	end)
	
	local PlayersHit = {}
	PyreWallModel.HB.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHit) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHit, hit.Parent)
			task.delay(.25, function()
				table.remove(PlayersHit, 1, hit.Parent)	
			end)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Light"
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			game.Debris:AddItem(Velocity,.1)
		end
	end)
end

local function CreateSupa3()
	IncineratingBlastAnim:Play()
	task.wait(.5)
	local IncineratingBlast = true
	local IncineratingBlastModel = Assets.IncineratingBlast:Clone()
	IncineratingBlastModel.Parent = script
	local Weld = Instance.new("Motor6D", IncineratingBlastModel.Main)
	Weld.Part0 = HumanoidRootPart
	Weld.Part1 = IncineratingBlastModel.Main
	Weld.C0 = Weld.C0 * CFrame.new(0,0,-2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	local PlayersHit = {}
	IncineratingBlastModel.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name and IncineratingBlast == true then
			for i,tableValue in pairs(PlayersHit) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHit, hit.Parent)
			
			task.delay(.2, function()
				table.remove(PlayersHit, 1, hit.Parent)	
			end)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Light"
			game.Debris:AddItem(Velocity,.1)
			DmgFunction:Fire(Character, hum, Damage)
		end
	end)
	task.delay(6, function()
		IncineratingBlast = false
		for i,v in pairs(IncineratingBlastModel:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		game:GetService("Debris"):AddItem(IncineratingBlastModel, 1)
		game:GetService("Debris"):AddItem(IncineratingBlastAnim, 1)
	end)
end


task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and Humanoid.Health > 0 and Stunned == false then
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
			task.wait(2)
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
while task.wait(.5) do
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
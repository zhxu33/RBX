local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina      = script.Parent.Stamina
local MaxStamina   = script.Parent.MaxStamina
local Target       = nil
local Damage       = 75000
local Stunned      = false
local HitSound     = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId   = "rbxassetid://232210146"
HitSound.Volume    = 0.2
local CombatType   = 1
local AirBlast     = false
local SuperBlast   = false
local SuperForm    = false
local FingerStrike = false
local Attack       = false
local RespawnNPC       = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward        = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction      = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward           = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim        = {2313015622,2313016464,2313017174,2313014821}
local TweenService     = game:GetService("TweenService")
local FingerStrikeAnim = Humanoid:LoadAnimation(script.FingerStrike)
local AirBlastAnim     = Humanoid:LoadAnimation(script.AirBlast)
local SuperBlastAnim   = Humanoid:LoadAnimation(script.SuperBlast)
local WalkSpeed = 100
local Assets    = game:GetService("ServerStorage").QuirkAssets.AFO
local UniAssets = game:GetService("ServerStorage").UniversalAssets

local function CreateFingerStrike()
	if not Target.Parent or not Target.Parent:FindFirstChild("Humanoid") then return end
	FingerStrike = true
	FingerStrikeAnim:Play()
	local FingerStrikeModel = Assets.FingerStrike:Clone()
	FingerStrikeModel.Parent = script
	for i,v in pairs(FingerStrikeModel:GetDescendants()) do
		if v.Name == "Start" then
			local Weld = Instance.new("Weld", v)
			Weld.Part0 = v
			Weld.Part1 = Character.RightHand
		elseif v.Name == "End" then
			v.CFrame = Target.CFrame
			v.CanCollide = true
			local Weld = Instance.new("Weld", v)
			Weld.Part0 = v
			Weld.Part1 = Target
		end
	end
	game.Debris:AddItem(FingerStrikeModel, 1)
	local hum = Target.Parent:FindFirstChildOfClass("Humanoid")
	local HRT = Target.Parent:FindFirstChild("HumanoidRootPart")
	DmgFunction:Fire(Character, hum, Damage)
	local Velocity = Instance.new("BodyVelocity",HRT)
	Velocity.Name = "Heavy"
	game.Debris:AddItem(Velocity,1)
	task.delay(1, function()
		FingerStrikeAnim:Stop()
		wait(5)
		FingerStrike = false
	end)
end

local function CreateAirBlast()
	AirBlast = true
	Attack   = true
	AirBlastAnim:Play()
	local PE  = script.Lightning:Clone()
	PE.Parent = Character.LeftUpperArm
	task.wait(1)
	PE:Destroy()
	local AirBlastModel  = Assets.AfoAirBlast:Clone()
	AirBlastModel.Parent = script
	AirBlastModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)))
	local PlayersHitted = {}
	AirBlastModel.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,.75)
			Velocity.Velocity = HumanoidRootPart.CFrame.lookVector*100
		end
	end)
	task.spawn(function()
		while task.wait() and AirBlastModel.Parent do
			AirBlastModel.Main.CFrame    = AirBlastModel.Main.CFrame    * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			AirBlastModel.Effect.CFrame  = AirBlastModel.Effect.CFrame  * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			AirBlastModel.Effect2.CFrame = AirBlastModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
		end
	end)
	AirBlastModel.Main.Particle.Enabled = true  
	TweenService:Create(AirBlastModel.Main,    TweenInfo.new(2),{Size = Vector3.new(26, 120, 120),CFrame = AirBlastModel.Main.CFrame * CFrame.new(0,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.Effect,  TweenInfo.new(2),{Size = Vector3.new(228,228,228),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-80,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.Effect2, TweenInfo.new(2),{Size = Vector3.new(180,106,106),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-100,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.HB,      TweenInfo.new(2),{Size = Vector3.new(300, 106, 106),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-110,0,0),Transparency = 1}):Play()
	task.delay(1, function()
		AirBlastModel.Main.Particle.Enabled = false
		wait(1)
		AirBlastModel:Destroy()
		AirBlastAnim:Stop()
		Attack = false
		wait(1)
		AirBlast = false
	end)
end

local function CreateSuperBlast()
	SuperBlast = true
	Attack     = true
	SuperBlastAnim:Play()
	local AfoArm = Assets.AfoArm:Clone()
	AfoArm.Parent = script
	local Weld = Instance.new("Motor6D", AfoArm.Main)
	Weld.Part0 = AfoArm.Main
	Weld.Part1 = Character.RightUpperArm
	Weld.C0 = Weld.C0*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	game.Debris:AddItem(AfoArm, 1.7)
	task.wait(.7)
	local SuperBlastModel  = Assets.AfoSuperBlast:Clone()
	SuperBlastModel.Parent = script
	SuperBlastModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)))
	local PlayersHitted = {}
	SuperBlastModel.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,.75)
			Velocity.Velocity = HumanoidRootPart.CFrame.lookVector*150
		end
	end)
	task.spawn(function()
		while task.wait() and SuperBlastModel.Parent do
			SuperBlastModel.Effect.CFrame = SuperBlastModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
		end
	end)
	
	task.spawn(function()
		TweenService:Create(SuperBlastModel.Effect, TweenInfo.new(2),{Size = Vector3.new(390, 495, 495),Transparency = 1}):Play()
		TweenService:Create(SuperBlastModel.HB, TweenInfo.new(2),{Size = Vector3.new(300, 250, 250),Transparency = 1}):Play()
		wait(2)
		SuperBlastModel:Destroy()
		AirBlastAnim:Stop()
		Attack = false
		wait(20)
		SuperBlast = false
	end)
end

task.spawn(function()
	while wait(.1) do
		if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 125 or Humanoid.JumpPower ~= 0 and Humanoid.JumpPower ~= WalkSpeed then
			Humanoid.WalkSpeed = WalkSpeed
			Humanoid.JumpPower = 125
		end
	end
end)

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and FingerStrike == false and Attack == false then
			CreateFingerStrike()
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and SuperBlast == false and Attack == false then
			CreateSuperBlast()
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and AirBlast == false and Attack == false then
			CreateAirBlast()
		end
	end
end)

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

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		task.spawn(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,"All For One")
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
			wait()
			Walking = true
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
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, Target.Position)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						break
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
		else
			Target = nil
		end
		if Humanoid.Health <= Humanoid.MaxHealth/2 and SuperForm == false then
			SuperForm = true
			Damage = Damage * 1.5
			WalkSpeed = WalkSpeed * 1.5
			for i,v in pairs(Character:GetChildren()) do
				if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
					local lightning = script.Lightning:Clone()
					lightning.Parent = v
				end
			end
			script.PointLight.Parent = Character.UpperTorso
			local SW = Assets.Shockwave:Clone()
			SW.BrickColor = BrickColor.new("Really red")
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
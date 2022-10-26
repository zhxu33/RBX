local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina          = script.Parent.Stamina
local MaxStamina       = script.Parent.MaxStamina
local Target   = nil
local Damage   = 50000
local Stunned  = false
local HitSound = Instance.new("Sound", HumanoidRootPart)
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
local DeathTouchAnim = Humanoid:LoadAnimation(script.DeathTouch)
local FloorTouchAnim = Humanoid:LoadAnimation(script.FloorTouch)
local TweenService   = game:GetService("TweenService")
local Supa1     = false
local Supa2     = false
local Supa3     = false
local Supapoo   = false
local SupaType  = 1
local WalkSpeed = 100
local Assets    = game:GetService("ServerStorage").QuirkAssets.Overhaul
local UniAssets = game:GetService("ServerStorage").UniversalAssets

local OverMode = false
local OverForm = script:WaitForChild("OverForm")
for i,v in pairs(OverForm:GetChildren()) do
	v.Transparency = 1
	if Character:FindFirstChild(v.Name) then
		local Weld = Instance.new("Weld", Character:FindFirstChild(v.Name))
		Weld.Part0 = Character:FindFirstChild(v.Name)
		Weld.Part1 = v
	end
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
	if Child == "Light" then
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
				wait(0.25) -- stuntime
			end
		end			
		if HumanoidRootPart:FindFirstChild("Heavy") then
			HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
		end

		HvyStunnedAnim:Stop()
		asdfg = true
		Humanoid.WalkSpeed = WalkSpeed
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= WalkSpeed then
		Humanoid.WalkSpeed = WalkSpeed
	end
end)

local function CreateSupa1()
	FloorTouchAnim:Play()
	task.wait(.3)
	local Spikes  = Assets.OverhaulSpikes:Clone()
	Spikes.Parent = script
	Spikes.CFrame = HumanoidRootPart.CFrame * CFrame.new(0,-5,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
	local ef  = Assets.OverHaulSpikeEffect:Clone()
	ef.Parent = script
	ef.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,-2,0)
	local PlayersHitted = {}
	Spikes.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name  = "Heavy"
			game.Debris:AddItem(Velocity,1)
		end
	end)
	
	TweenService:Create(ef,     TweenInfo.new(1),{Transparency = 1}):Play()
	TweenService:Create(ef,     TweenInfo.new(1),{Size = Vector3.new(200,10,200)}):Play()
	TweenService:Create(Spikes, TweenInfo.new(1.5),{Size = Vector3.new(150,200,150), CFrame = Spikes.CFrame * CFrame.new(75,50,0)}):Play()
	task.wait(1)
	ef:Destroy()
	FloorTouchAnim:Stop()
	task.wait(2)
	TweenService:Create(Spikes, TweenInfo.new(1.5),{Transparency = 1}):Play()
	game.Debris:AddItem(Spikes,1)
end

local function CreateSupa2()
	FloorTouchAnim:Play()
	wait(.3)
	local Spikes  = Assets.OverhaulSpike2:Clone()
	Spikes.Parent = script
	Spikes.CFrame = HumanoidRootPart.CFrame * CFrame.new(0,-5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	local ef  = Assets.OverHaulSpikeEffect:Clone()
	ef.Parent = script
	ef.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,0,0)
	local PlayersHitted = {}
	Spikes.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1)
		end
	end)
	TweenService:Create(ef, TweenInfo.new(1),{Transparency = 1}):Play()
	TweenService:Create(ef, TweenInfo.new(1),{Size = Vector3.new(400,20,400),CFrame = Spikes.CFrame * CFrame.new(0,10,0)}):Play()
	TweenService:Create(Spikes, TweenInfo.new(1.5),{Size = Vector3.new(240, 150, 240), CFrame = Spikes.CFrame * CFrame.new(0,50,0)}):Play()
	task.wait(1)
	ef:Destroy()
	FloorTouchAnim:Stop()
	task.wait(3)
	TweenService:Create(Spikes, TweenInfo.new(1.5),{Transparency = 1}):Play()
	game.Debris:AddItem(Spikes,1)
end

local function CreateSupa3()
	DeathTouchAnim:Play()
	local HitPart      = Instance.new("Part",script)
	HitPart.Anchored   = false
	HitPart.CanCollide = false
	HitPart.Size       = Vector3.new(1.5, 3, 1.5)
	HitPart.Transparency = 1
	HitPart.CFrame       = HumanoidRootPart.CFrame
	HitPart.Massless     = true
	local Weld    = Instance.new("Weld", HitPart)
	Weld.Part0    = HitPart
	Weld.Part1    = Character.LeftUpperArm
	local touched = true
	HitPart.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name and touched == false then
			touched = true
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			for i,vv in pairs(hit.Parent:GetChildren()) do
				if vv:IsA("MeshPart") then
					local pe = Assets.OverhaulLightning:Clone()
					pe.Rate = 15
					pe.Parent = vv
					game.Debris:AddItem(pe, 5)
				end
			end
			local UpDashEf = UniAssets.UpDashEffect:Clone()
			UpDashEf.Parent = script
			UpDashEf.CFrame = HRT.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
			UpDashEf.Decal.Color3 = Color3.new(255,0,0)
			UpDashEf.Decal1.Color3 = Color3.new(255,0,0)
			game.Debris:AddItem(UpDashEf, 0.75)
			TweenService:Create(UpDashEf,        TweenInfo.new(0.75),{Size = Vector3.new(35,0.05,35)}):Play()
			TweenService:Create(UpDashEf.Decal,  TweenInfo.new(0.75),{Transparency = 1}):Play()
			TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.75),{Transparency = 1}):Play()
			
			local Velocity    = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(10000,10000,10000)
			Velocity.Name     = "Light"
			game.Debris:AddItem(Velocity,.1)
			DmgFunction:Fire(Character, hum, Damage*5)
		end	
	end)
	local Over = false
	if OverMode == false then
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
				local clone      = v:Clone()
				clone.Name       = "DeathTouch"
				clone.Parent     = v
				clone.Material   = "Neon"
				clone.BrickColor = BrickColor.new("Really red")
				clone.Size       = clone.Size + Vector3.new(.1,.1,.1)
				clone.Transparency = .25
				clone.TextureID    = ""
				local pe   = Assets.OverhaulLightning:Clone()
				pe.Rate    = 10
				pe.Parent  = clone
				local Weld = Instance.new("Motor6D",clone)
				Weld.Part0 = clone
				Weld.Part1 = v
				if v.Name == "LeftUpperArm" then
					clone:FindFirstChild("LeftShoulder"):Destroy()
				end
			end
		end
	elseif OverMode == true then
		Over = true
		for i,v in pairs(OverForm:GetChildren()) do
			if v.Name == "LeftUpperArm2" or v.Name == "LeftLowerArm2" or v.Name == "LeftHand2" then
				local clone      = v:Clone()
				clone.Name       = "DeathTouch"
				clone.Parent     = v
				clone.Material   = "Neon"
				clone.BrickColor = BrickColor.new("Really red")
				clone.Size         = clone.Size + Vector3.new(.1,.1,.1)
				clone.Transparency = .8
				local pe   = Assets.OverhaulLightning:Clone()
				pe.Rate    = 10
				pe.Parent  = clone
				local Weld = Instance.new("Motor6D",clone)
				Weld.Part0 = clone
				Weld.Part1 = v
			end
		end
	end
	task.wait(.3)
	touched   = false
	task.delay(.25, function()
		game.Debris:AddItem(HitPart,0.75)
		if Over == false then
			for i,v in pairs(Character:GetChildren()) do
				if v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
					local clone = v:FindFirstChild("DeathTouch")
					game.Debris:AddItem(clone, 0.75)
					TweenService:Create(clone,TweenInfo.new(0.75), {Transparency = 1}):Play()
				end
			end
		elseif Over == true then
			for i,v in pairs(OverForm:GetChildren()) do
				if v.Name == "LeftUpperArm2" or v.Name == "LeftLowerArm2" or v.Name == "LeftHand2" then
					local clone = v:FindFirstChild("DeathTouch")
					game.Debris:AddItem(clone, 0.75)
					TweenService:Create(clone,TweenInfo.new(0.75), {Transparency = 1}):Play()
				end
			end
		end
	end)
end

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
			CreateSupa3()
			task.wait(2)
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and Stunned == false then
			if SupaType == 1 then
				SupaType = 2
				CreateSupa1()
			elseif SupaType == 2 then
				SupaType = 1
				CreateSupa2()
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
		
		if Humanoid.Health <= Humanoid.MaxHealth/2 and OverMode == false then
			OverMode        = true
			Damage          = Damage * 1.5
			WalkSpeed       = WalkSpeed * 1.5
			local UpDashEf  = UniAssets.UpDashEffect:Clone()
			UpDashEf.Parent = script
			UpDashEf.CFrame = HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
			UpDashEf.Decal.Color3  = Color3.new(255, 0, 0)
			UpDashEf.Decal1.Color3 = Color3.new(255, 0, 0)
			game.Debris:AddItem(UpDashEf,0.5)
			TweenService:Create(UpDashEf,        TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
			TweenService:Create(UpDashEf.Decal,  TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
			
			for i,v in pairs(OverForm:GetChildren()) do
				if not Character:FindFirstChild(v.Name) then
					v.Transparency = 0
					local pe = Assets.OverhaulLightning:Clone()
					pe.Rate = 10
					pe.Parent = v
					game.Debris:AddItem(pe,2)
				end
			end
		end
	end)
end
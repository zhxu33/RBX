local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina        = script.Parent.Stamina
local MaxStamina     = script.Parent.MaxStamina
local Target         = nil
local Damage         = 30000
local Stunned        = false
local HitSound       = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId     = "rbxassetid://232210146"
HitSound.Volume      = 0.2
local CombatType     = 1
local RespawnNPC     = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward      = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction    = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward         = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim      = {2313017174,2313014821}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun         = Humanoid:LoadAnimation(script.stunned)
local StompAnim    = Humanoid:LoadAnimation(script.Stomp)
local UltAnim      = Humanoid:LoadAnimation(script.Ult)
local TweenService = game:GetService("TweenService")
local Supa1     = false
local Supa2     = false
local Supapoo   = false
local SupaType  = 1
local Assets    = game:GetService("ServerStorage").QuirkAssets.Gigantification
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
		Humanoid.WalkSpeed = 100
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 100 then
		Humanoid.WalkSpeed = 100
		Humanoid.JumpPower = 125
	end
end)

local function CreateSupa1()
	StompAnim:Play()
	task.wait(.5)
	local ef = Assets.Shockwave:Clone()
	ef.Parent = script
	ef.CFrame = Character.RightFoot.CFrame
	local clone = Assets.Stomp:Clone()
	clone.Parent = script
	clone.CFrame = Character.RightFoot.CFrame
	clone.Orientation = Vector3.new(0,0,90)
	local hb = Assets.Stomp:Clone()
	hb.Parent = script
	hb.CFrame = Character.RightFoot.CFrame
	hb.Orientation = Vector3.new(0,0,90)
	hb.Transparency = 1
	local PlayersHitted = {}
	hb.Touched:connect(function(hit)
		if hit.Parent.Name ~= Character.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1)
			Velocity.Velocity = Vector3.new(0,50,0)
		end
	end)
	task.spawn(function()
		while wait() and ef.Parent do
			ef.CFrame = ef.CFrame * CFrame.Angles(math.rad(0), math.rad(100), math.rad(0))
		end
	end)
	ef.Transparency = .1
	TweenService:Create(clone, TweenInfo.new(0.5+(0.05*13*1.5)), {Transparency = 1, Size = clone.Size + Vector3.new(0.4*(10+13*1.5), 4*(10+13*1.5),4*(10+13*1.5))}):Play()
	TweenService:Create(hb,    TweenInfo.new(0.5+(0.05*13*1.5)), {Transparency = 1, Size = hb.Size    + Vector3.new(4*(10+13*1.5),   4*(10+13*1.5),4*(10+13*1.5))}):Play()
	TweenService:Create(ef,    TweenInfo.new(0.5+(0.05*13*1.5)), {Transparency = 1, Size = ef.Size    + Vector3.new(5.5*(10+13*1.5), 5.5*(10+13*1.5),5.5*(10+13*1.5))}):Play()
	
	game:GetService("Debris"):AddItem(clone, 1.5)
	game:GetService("Debris"):AddItem(hb, 1.5)
	game:GetService("Debris"):AddItem(ef, 1.5)
	task.wait(1.5) -- // I have no idea why this should be here
end

local function CreateSupa2()
	UltAnim:Play()
	task.wait(1.2)
	local UltModel = Assets.GiantUltimate:Clone()
	UltModel.Parent = script
	UltModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(45),math.rad(0),math.rad(0)))
	local PlayersHitted = {}
	UltModel.HB.Touched:connect(function(hit)
		if hit.Parent.Name ~= Character.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1)
			Velocity.Velocity = Vector3.new(0,50,0)
		end
	end)
	task.spawn(function()
		while wait() and UltModel.Parent do
			for i,v in pairs(UltModel:GetChildren()) do
				v.CFrame = v.CFrame * CFrame.Angles(math.rad(0), math.rad(100), math.rad(0))
			end
		end
	end)
	for _, part in pairs(UltModel:GetChildren()) do if part.Name ~= "HB" then part.Transparency = .1 end end
	
	TweenService:Create(UltModel.Shockwave,  TweenInfo.new(1.5), {Transparency = 1, Size = UltModel.Shockwave.Size  + Vector3.new(7.5*(10+13*1.5),  6*(10+13*1.5),7.5*(10+13*1.5))}):Play()
	TweenService:Create(UltModel.Shockwave2, TweenInfo.new(1.5), {Transparency = 1, Size = UltModel.Shockwave2.Size + Vector3.new(3.75*(10+13*1.5), 6.4*(10+13*1.5),3.75*(10+13*1.5))}):Play()
	TweenService:Create(UltModel.Shockwave3, TweenInfo.new(1.5), {Transparency = 1, Size = UltModel.Shockwave3.Size + Vector3.new(9.6*(10+13*1.5),  9.6*(10+13*1.5),9.6*(10+13*1.5))}):Play()
	TweenService:Create(UltModel.HB,         TweenInfo.new(1.5), {Transparency = 1, Size = UltModel.HB.Size         + Vector3.new(7.5*(10+13*1.5),  7.5*(10+13*1.5),7.5*(10+13*1.5))}):Play()
	game:GetService("Debris"):AddItem(UltModel, 1.5)
	task.wait(1.5) -- // Maybe ??
end

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 250 and Humanoid.Health > 0 and Stunned == false then
			if Supapoo == false then
				Supapoo = true
				if SupaType == 1 then
					SupaType = 2
					CreateSupa1()
				elseif SupaType == 2 then
					SupaType = 1
					CreateSupa2()
				end
				task.delay(3, function()
					Supapoo = false
				end)
			end
		end
		if Target and Target.Parent and (Target.Position - HumanoidRootPart.Position).magnitude < 50 and Humanoid.Health > 0 and Stunned == false then 
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			CombatType = CombatType == 1 and 2 or 1
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
	end)
end
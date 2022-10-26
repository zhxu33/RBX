local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target  = nil
local Damage  = 7500
local Stunned = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim   = {3400190230,3400194168}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun           = Humanoid:LoadAnimation(script.stunned)
local GasFieldAnim   = Humanoid:LoadAnimation(script.GasField)
local GasThrowAnim   = Humanoid:LoadAnimation(script.GasThrow)
local ThrowAnim      = Humanoid:LoadAnimation(script.Throw) 
local IdleAnim       = Humanoid:LoadAnimation(script.Idle)
IdleAnim:Play() 
local TweenService = game:GetService("TweenService")
local Supa1     = false
local Supa2     = false
local Supa3     = false
local Supapoo   = false
local SupaType  = 1
local Assets    = game:GetService("ServerStorage").QuirkAssets.Somnambulist
local UniAssets = game:GetService("ServerStorage").UniversalAssets

for i,v in pairs(Character:GetChildren()) do
	if v:IsA("BasePart") then
		local Clone = Assets.SomnaMode:Clone()
		Clone.Parent = v
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
		Humanoid.WalkSpeed = 75
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 75 then
		Humanoid.WalkSpeed = 75
	end
end)

local CanFreeze = true
function FreezeHumanoid(hum, HRT, amount)
	if CanFreeze == true and HRT.Parent.Parent.Name ~= "InteractionNPCS" then
		task.spawn(function()
			local stopfreeze = false
			hum:LoadAnimation(script.Stun):Play()
			local Clone = Assets.SomnaMode:Clone()
			Clone.Parent = HRT.Parent.Head
			task.spawn(function()
				local prevW = hum.WalkSpeed
				local prevJ = hum.JumpPower
				while wait(.1) and stopfreeze and CanFreeze do
					hum.WalkSpeed = 0
					hum.JumpPower = 0 
				end
				Clone:Destroy()
				hum.WalkSpeed = prevW
				hum.JumpPower = prevJ
			end)
			wait(amount)
			stopfreeze = true
		end)
	end
end

local function CreateSupa1()
	ThrowAnim:Play()
	wait(0.4)
	local Ball = Assets.SomnaBall:Clone()
	Ball.Parent = script
	Ball.CFrame = HumanoidRootPart.CFrame
	game.Debris:AddItem(Ball,3)
	local bv = Instance.new("BodyVelocity", Ball)
	bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	if Target and Target.Parent then
		bv.Velocity = CFrame.new(HumanoidRootPart.CFrame.p,Target.CFrame.p).lookVector * 100
	else
		bv.Velocity = HumanoidRootPart.CFrame.lookVector * 100	
	end
	local PlayersHitted = {}
	Ball.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Character.Name and hit.Parent.Parent.Name ~= "NPCs" then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			FreezeHumanoid(hum, HRT, 3)
			task.delay(.5, function()
				Ball.Particle.Speed   = NumberRange.new(10)
				Ball.Particle.Enabled = false
				game.Debris:AddItem(Ball,0.5)
			end)
		end
	end)
end

local function CreateSupa2()
	GasFieldAnim:Play()
	wait(1)
	local GasFloor = Assets.SomnaFloor:Clone()
	GasFloor.Parent = script
	GasFloor.CFrame = HumanoidRootPart.CFrame
	game.Debris:AddItem(GasFloor,6)
	TweenService:Create(GasFloor,TweenInfo.new(1.5), {Size = Vector3.new(100,6.9,100)}):Play()
	local PlayersHitted = {}
	GasFloor.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Character.Name and hit.Parent.Parent.Name ~= "NPCs" then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			FreezeHumanoid(hum, HRT, 3)
		end
	end)
end

task.spawn(function()
	while wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and Humanoid.Health > 0 and Stunned == false then
			if Supapoo == false then 
				Supapoo = true
				if SupaType == 1 then
					SupaType = 2
					CreateSupa1()
				elseif SupaType == 2 then
					SupaType = 1
					CreateSupa2()
				elseif SupaType == 3 then
					SupaType = 1
				end
				task.delay(8, function()
					Supapoo = false
				end)
			end
		end
		if Target and Target.Parent and (Target.Position - HumanoidRootPart.Position).magnitude < 25 and Humanoid.Health > 0 and Stunned == false then 
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage*1.5)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			if CombatType == 1 then
				CombatType = 2
			elseif CombatType == 2 then
				CombatType = 1
			end
			wait(.2)
		end
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	CanFreeze = false
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
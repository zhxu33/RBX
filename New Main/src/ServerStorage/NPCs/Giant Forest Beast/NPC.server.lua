local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 20000
local Stunned = false
local HitSound = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local CombatType = 1
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim = {2960539055,2960538203}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local BeastSlamAnim = Humanoid:LoadAnimation(script.BeastSlam)
local TweenService = game:GetService("TweenService")

local Corotot = coroutine.wrap(function()
	while wait() do
		if HumanoidRootPart:FindFirstChild("Light") then
			local part = HumanoidRootPart:FindFirstChild("Light")
			if part:FindFirstChild("Hitist") then
				Target = nil
				Target = part.Hitist.Value
				part:Destroy()
			end
		elseif HumanoidRootPart:FindFirstChild("Heavy") then
			local part = HumanoidRootPart:FindFirstChild("Heavy")
			if part:FindFirstChild("Hitist") then
				Target = nil
				Target = part.Hitist.Value
				part:Destroy()
			end
		end
	end
end)
Corotot()

local Corot = coroutine.wrap(function()
	while wait(.5) do
		if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 100 then
			Humanoid.WalkSpeed = 100
			Humanoid.JumpPower = 150
		end
	end
end)

local BeastSlam = false
function CreateSlam()
	BeastSlam = true
	BeastSlamAnim:Play()
	wait(.75)
		local Clone = game.ServerStorage.HardeningRocks:Clone()
		Clone.Parent = script
		Clone:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,0,-30)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(270)))
		local PlayersHitted = {}
			Clone.PrimaryPart.Touched:connect(function(hit)
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
									game.Debris:AddItem(Velocity,1)
									Velocity.Velocity = Vector3.new(0,50,0)
							end
					end)
			for i,v in pairs(Clone:GetChildren()) do
				TweenService:Create(v, TweenInfo.new(1.5), {Transparency = 1, CFrame = v.CFrame * CFrame.new(68,0,0), Size = v.Size + Vector3.new(200,160,200)}):Play()
			end
			game.Debris:AddItem(Clone, 1.5)
end

local coro = coroutine.wrap(function()
while wait(.5) do
	if Target and Humanoid.Health > 0 and Stunned == false then
	if BeastSlam == false and (Target.Position - HumanoidRootPart.Position).magnitude < 200  then
	BeastSlam = true
	wait(.5)
	CreateSlam()
	local coo = coroutine.wrap(function()
	wait(8)
	BeastSlam = false
	end)
	coo()
	elseif BeastSlam == true and (Target.Position - HumanoidRootPart.Position).magnitude < 30 then
	local animation = Instance.new("Animation")
	animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
	DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
	local animTrack = Humanoid:LoadAnimation(animation)
	animTrack:Play()
	if CombatType == 1 then
	CombatType = 2
	elseif CombatType == 2 then
	CombatType = 1
	end
	end
	end
	end
end)
coro()


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
	elseif (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
		HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
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
	end)
end
local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 30000
local Stunned = false
local HitSound = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local CombatType = 1
local supa = false
local supapoo = false
local supapoo2 = false
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local SmashAnim = Humanoid:LoadAnimation(script.Smash)
local UpDashAnim = Humanoid:LoadAnimation(script.UpDash)
local TweenService = game:GetService("TweenService")


local function CreateSupa()
	local ef = script.Shockwave:Clone()
	ef.Parent = script
	ef.Transparency = 0.25
	ef.CFrame = HumanoidRootPart.CFrame
	local hb = script.Stomp:Clone()
	hb.Parent = script
	hb.CFrame = Character.RightFoot.CFrame
	hb.Orientation = Vector3.new(0,0,90)
	hb.Transparency = 1
	local PlayersHitted = {}
	hb.Touched:connect(function(hit)
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
	TweenService:Create(ef, TweenInfo.new(0.75), {Transparency = 1, Size = ef.Size + Vector3.new(112.5,82.5,112.5)}):Play()
	TweenService:Create(hb, TweenInfo.new(0.75), {Size = hb.Size + Vector3.new(90,90,90)}):Play()
	local pp = true
	local coo = coroutine.wrap(function()
		while wait() and pp do
			ef.CFrame = ef.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		end
	end)
	coo()
	wait(0.75)
	pp = false
	hb:Destroy()
	ef:Destroy()
end

local coro = coroutine.wrap(function()
	while wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 then
			if supapoo == false then
				supapoo = true
				SmashAnim:Play()
				wait(.5)
				CreateSupa()
				local coo = coroutine.wrap(function()
					wait(5)
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
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude > 50 and Humanoid.Health > 0 and supapoo2 == false then
			supapoo2 = true
			Humanoid.Jump = true
			UpDashAnim:Play()
			wait(.5)
			SmashAnim:Play()
			supa = true
			repeat wait() until
			supa == false 
			local coo = coroutine.wrap(function()
				wait(2.5)
				supapoo2 = false
			end)
			coo()
		end
	end
end)
coro()

Humanoid.Touched:Connect(function()
	if supa == true then
		supa = false
		CreateSupa()
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
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 125 then
		Humanoid.WalkSpeed = 125
		Humanoid.JumpPower = 125
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
		end
	end)
end
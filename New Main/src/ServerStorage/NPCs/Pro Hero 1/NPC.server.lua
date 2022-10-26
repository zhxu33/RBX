local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target     = nil
local Damage     = 45000
local Stunned    = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim       = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim  = Humanoid:LoadAnimation(script.heavystunned)
local Stun            = Humanoid:LoadAnimation(script.stunned)
local AnimationFolder = script.Parent.Animations
local SlideKickAnim   = Humanoid:LoadAnimation(AnimationFolder.SlideKick)
local SlideAnim       = Humanoid:LoadAnimation(AnimationFolder.Slide)
local ServerStorage   = game:GetService("ServerStorage")
local Assets          = ServerStorage.UniversalAssets

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
	end
end)

local SlideMove = false
local Sliding = false
local function Slide()
	local Hitted = false
	task.delay(2, function()
		Sliding = false
	end)
	
	SlideAnim:Play()
	local BV = Instance.new("BodyVelocity")
	BV.Parent = HumanoidRootPart
	BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	local GyroZeppeli = Instance.new("BodyGyro")
	GyroZeppeli.Parent = HumanoidRootPart
	
	task.spawn(function()
		while Hitted == false do
			pcall(function() 
				BV.Velocity        = CFrame.new(HumanoidRootPart.Position, Target.Position).lookVector*200
				GyroZeppeli.CFrame = CFrame.new(HumanoidRootPart.Position, Target.Position) 
			end)
			wait()
		end
	end)
	
	local Hitbox  = Assets.SlidinAttacks.SlideHB:Clone()
	Hitbox.Parent = HumanoidRootPart
	local M6 = Instance.new("Motor6D", Hitbox)
	M6.Part0 = Hitbox
	M6.Part1 = HumanoidRootPart
	local PlayersHit = {}
	Hitbox.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHit, hit.Parent) then return end
			table.insert(PlayersHit, hit.Parent)

			SlideKickAnim:Play()
			Hitted = true
			
			task.delay(.5, function()
				table.remove(PlayersHit, 1, hit.Parent)	
			end)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)
			task.delay(.3, function()
				Sliding = false
			end)
			
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name  = "Heavy"
			game.Debris:AddItem(Velocity,1.5)
		end
	end)
	repeat task.wait() until Sliding == false
	SlideAnim:Stop()
	BV:Destroy()
	GyroZeppeli:Destroy()
	Hitbox:Destroy()
end

task.spawn(function()
	while task.wait() do
		if Humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
end)

task.spawn(function()
	while task.wait(.5) do
		if Target and SlideMove == false and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and (Target.Position - HumanoidRootPart.Position).magnitude > 20 and Humanoid.Health > 0 and Stunned == false then
			Sliding = true
			SlideMove = true
			Slide()
			task.delay(5, function()
				SlideMove = false
			end)
		elseif Target and Sliding == false and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
			local animation = script.Parent.Animations.Punch
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage*2)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			CombatType += 1
			if CombatType > 4 then 
				CombatType = 1
			end
		end
	end
end)

Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat game:GetService("RunService").Heartbeat:Wait() until Target
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
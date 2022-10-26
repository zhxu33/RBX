local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina     = script.Parent.Stamina
local MaxStamina  = script.Parent.MaxStamina
local Target      = nil
local Damage      = 40000
local Stunned     = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward         = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim      = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun   = Humanoid:LoadAnimation(script.stunned)
local Assets = game:GetService("ServerStorage").UniversalAssets

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

local TweenService = game:GetService("TweenService")
local supacd       = false
function supa()
	supacd = true
	local animation = Instance.new("Animation")
	animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[1]
	local animTrack = Humanoid:LoadAnimation(animation)
	animTrack:Play()
	wait(.2)
	local Clone  = Assets.KickSmashModel:Clone()
	Clone.Parent = script
	Clone:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,0,30)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90)))
	
	for i,v in pairs(Clone:GetChildren()) do
		local velocity    = Instance.new("BodyVelocity",v)
		velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 150
	end
	
	local PlayersHitted = {}
	Clone.Smash.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" then
			if table.find(PlayersHitted, hit.Parent) then return end
			table.insert(PlayersHitted, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*3)	
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(20000,20000,20000)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,.5)
			Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 100
		end
	end)
	
	TweenService:Create(Clone.Smash,    TweenInfo.new(1.5), {Transparency = 1}):Play()
	TweenService:Create(Clone.MeshPart, TweenInfo.new(1.5), {Transparency = 1}):Play()
	TweenService:Create(Clone.ew,       TweenInfo.new(1.5), {Transparency = 1}):Play()
	task.spawn(function()
		while wait() and Clone and Clone.Parent do
			--Clone.MeshPart.CFrame = Clone.MeshPart.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
			Clone.Smash.CFrame = Clone.Smash.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
			Clone.ew.CFrame = Clone.ew.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		end
	end)
	
	wait(1.5)
	Clone:Destroy()
	task.delay(3, function()
		supacd = false
	end)
end

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false and supacd == true then
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			CombatType += 1
			if CombatType > 4 then CombatType = 1 end
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and Stunned == false and supacd == false then
			supa()
		end
	end
end)

Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,"High End")
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
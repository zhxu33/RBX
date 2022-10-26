local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 15000
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

local coro = coroutine.wrap(function()
	while wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
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
end)
coro()


Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,Character.Name)
end)

while wait(.5) do
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
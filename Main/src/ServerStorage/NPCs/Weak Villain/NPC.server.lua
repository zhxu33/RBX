local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 500
local Stunned = false
local HitSound = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local CombatType = 1
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local GunAnim = Humanoid:LoadAnimation(script.Gun)
local GunAnim2 = Humanoid:LoadAnimation(script.Gun2)
local TweenService = game:GetService("TweenService")

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
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 18 then
		Humanoid.WalkSpeed = 18
	end
end)

local picked = 1
function shootgun()
	if picked == 1 then
		picked = 2
		GunAnim:Play()
	elseif picked == 2 then
		picked = 1
		GunAnim2:Play()
	end
	wait(.1)
	local DirecPart = Instance.new("Part",script)
	DirecPart.Anchored = true
	DirecPart.CanCollide = false
	DirecPart.Transparency = 1
	local bullet = game.ServerStorage.ItemAssets.Bullet:Clone()
	bullet.Parent = script
	if Target ~= nil and Target.Parent then
		DirecPart.CFrame =  CFrame.new(HumanoidRootPart.CFrame.p,Target.CFrame.p)
	else
		DirecPart.CFrame =  HumanoidRootPart.CFrame
	end
	bullet.CFrame = DirecPart.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	local ring = game.ServerStorage.UniversalAssets.RING:Clone()
	ring.Parent  = script
	ring.CFrame = HumanoidRootPart.CFrame
	game.Debris:AddItem(bullet,2)
	local velo = Instance.new("BodyVelocity", bullet)
	velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	velo.Velocity = DirecPart.CFrame.lookVector*200
	DirecPart:Destroy()
	bullet.Anchored = false
	bullet.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" then
			bullet:Destroy()
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character,hum,Damage*2)
			local ring2 = game.ServerStorage.UniversalAssets.RING:Clone()
			ring2.Parent  = script
			ring2.CFrame = HRT.CFrame
			game.Debris:AddItem(ring2,0.5)
			TweenService:Create(ring2, TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(ring2.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		end
	end)
	TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
	TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
	game.Debris:AddItem(ring, 0.5)
end

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
				CombatType = 3
			elseif CombatType == 3 then
				CombatType = 4
			elseif CombatType == 4 then
				CombatType = 1
			end
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude > 10 and Humanoid.Health > 0 and Stunned == false then
			shootgun()
			wait(.5)
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
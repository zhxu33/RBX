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
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim = {2524190003,2524190627,2524191157}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local ScytheIdle = Humanoid:LoadAnimation(script.ScytheIdle)
local ExplosionAnim = Humanoid:LoadAnimation(script.Explosion)
local Scythe = Character:WaitForChild("Scythe")
local Blade = Scythe:WaitForChild("Blade")
local Trail1 = Blade:WaitForChild("Trail1")
local Trail2 = Blade:WaitForChild("Trail2")
local Trail3 = Blade:WaitForChild("Trail3")
ScytheIdle:Play()
local TweenService = game:GetService("TweenService")

local Corotot = coroutine.wrap(function()
	while wait() do
		if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 100 then
			Humanoid.WalkSpeed = 100
		end
		if HumanoidRootPart:FindFirstChild("Light") then
			local part = HumanoidRootPart:FindFirstChild("Light")
			if part:FindFirstChild("Hitist") then
				Target = part.Hitist.Value
			end
		elseif HumanoidRootPart:FindFirstChild("Heavy") then
			local part = HumanoidRootPart:FindFirstChild("Heavy")
			if part:FindFirstChild("Hitist") then
				Target = part.Hitist.Value
				if HumanoidRootPart:FindFirstChild("Heavy") then
					HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
				end
			end
		end
	end
end)
Corotot()

local ScytheAtk = false
local ExplosionAtk = false
local coro = coroutine.wrap(function()
	while wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and Humanoid.Health > 0 and Stunned == false and ScytheAtk == false then
			ScytheAtk = true
			local Clone = game.ServerStorage.Weapons.WeaponEffects.HalloweenBossEffect:Clone()
			Clone.CFrame = HumanoidRootPart.CFrame*CFrame.Angles(math.rad(90),math.rad(90),math.rad(90))
			local BV = Instance.new("BodyVelocity", Clone)
			BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			BV.Velocity = HumanoidRootPart.CFrame.lookVector * 200
			Clone.Parent = script
			game.Debris:AddItem(Clone,2)
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			Trail1.Enabled = true
			Trail2.Enabled = true
			Trail3.Enabled = true
			if CombatType == 1 then
				CombatType = 2
			elseif CombatType == 2 then
				CombatType = 3
			elseif CombatType == 3 then
				CombatType = 1
			end
			local cooo = coroutine.wrap(function()
				wait(0.5)
				Trail1.Enabled = false
				Trail2.Enabled = false
				Trail3.Enabled = false
			end)
			cooo()
			local PlayersHitted = {}
			Clone.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, Damage*2)
				end
			end)
			local coo = coroutine.wrap(function()
				wait(2.5)
				ScytheAtk = false
			end)
			coo()
		end
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 50 and Humanoid.Health > 0 and Stunned == false and ExplosionAtk == false then
			ExplosionAnim:Play()
			ExplosionAtk = true
			wait(0.4)
			local Clone =  game.ServerStorage.MuscleExplosion:Clone()
			Clone.CFrame = HumanoidRootPart.CFrame
			Clone.Parent = script
			Clone.BrickColor = BrickColor.new("CGA brown")
			Clone.Transparency = 0.25
			game.Debris:AddItem(Clone,2)
			TweenService:Create(Clone,TweenInfo.new(2),{Transparency = 1, Size = Vector3.new(150,150,150)}):Play()
			local PlayersHitted = {}
			Clone.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, Damage*3)
				end
			end)
			local coo = coroutine.wrap(function()
				wait(8)
				ExplosionAtk = false
			end)
			coo()
		end
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			Trail1.Enabled = true
			Trail2.Enabled = true
			Trail3.Enabled = true
			if CombatType == 1 then
				CombatType = 2
			elseif CombatType == 2 then
				CombatType = 3
			elseif CombatType == 3 then
				CombatType = 1
			end
			local cooo = coroutine.wrap(function()
				wait(0.5)
				Trail1.Enabled = false
				Trail2.Enabled = false
				Trail3.Enabled = false
			end)
			cooo()
		end
	end
end)
coro()


Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,"HalloweenBoss")
end)

while wait(.5) do
	if Target == nil then
		Humanoid:MoveTo(OriginalCFrame.p)
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
end
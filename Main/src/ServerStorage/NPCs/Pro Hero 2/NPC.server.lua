local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina     = script.Parent.Stamina
local MaxStamina  = script.Parent.MaxStamina
local Target      = nil
local Damage      = 45000
local Stunned     = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim        = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim   = Humanoid:LoadAnimation(script.heavystunned)
local Stun             = Humanoid:LoadAnimation(script.stunned)
local AnimationsFolder = script.Parent.Animations
local Assets           = game:GetService("ServerStorage").QuirkAssets.Electrification
local UniAssets        = game:GetService("ServerStorage").UniversalAssets
local TweenService     = game:GetService("TweenService")

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

local Shocked = game.ReplicatedStorage:WaitForChild("Shock")

local ElectricStompAnim = Humanoid:LoadAnimation(AnimationsFolder.ElectricStomp)
local ElectricFloorAnim = Humanoid:LoadAnimation(AnimationsFolder.ElectricFloor)

local ElectricityActive = false
local ElectricCooldown  = false
local MoveCycle         = 1

local function Electrify(Part, Delay)
	task.spawn(function()
		local ElePart    = Instance.new("Part", Part)
		ElePart.Material = "Neon"
		ElePart.Size     = Part.Size + Vector3.new(0.01, 0.01, 0.01)
		ElePart.Color    = Color3.fromRGB(255, 175, 0)
		ElePart.CFrame   = Part.CFrame
		ElePart.CanCollide = false
		ElePart.Massless   = true
		local Weld1 = Instance.new("WeldConstraint", ElePart)
		Weld1.Part0 = Part
		Weld1.Part1 = ElePart
		game.Debris:AddItem(ElePart, 1)
		local Particles  = Assets.Electrification.Z.Particles.LimbElectricity:Clone()
		Particles.Parent = ElePart
		wait(Delay)
		TweenService:Create(ElePart, TweenInfo.new(0.2), {Transparency = 1}):Play()
		wait()
		Particles:Destroy()
	end)
end

local function ElectricStomp()
	ElectricStompAnim:Play()
	Electrify(Character.RightUpperLeg, 0.8)
	Electrify(Character.RightLowerLeg, 0.8)
	Electrify(Character.RightFoot,     0.8)
	wait(0.75)
	
	local ElectricityCone  = Assets.Electrification.Z.ElectricityPart:Clone()
	ElectricityCone.Parent = script
	ElectricityCone.CFrame = Character.HumanoidRootPart.CFrame*CFrame.new(0, -2.5, -2)
	TweenService:Create(ElectricityCone, TweenInfo.new(0.75), {Size = Vector3.new(200, 10, 5), CFrame = ElectricityCone.CFrame*CFrame.new(0, 0, -120)}):Play()
	local PlayersHit = {}
	ElectricityCone.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHit, hit.Parent) then return end
			table.insert(PlayersHit, hit.Parent)

			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2)
			Shocked:Fire(HRT.Parent, 2)
		end
	end)
	
	game.Debris:AddItem(ElectricityCone, 0.95)
end

local function ElectricDash()
	local function Vanish(Part, Head)
		task.spawn(function()
			local ElePart = Part:Clone()
			ElePart:ClearAllChildren()
			ElePart.Name     = ("Effect" .. Part.Name)
			ElePart.Parent   = Character
			ElePart.Material = "Neon"
			ElePart.Size     = Part.Size
			ElePart.Color    = Color3.fromRGB(255, 175, 0)
			ElePart.CFrame   = Part.CFrame
			ElePart.CanCollide   = false
			ElePart.Massless     = true
			ElePart.Transparency = 0.6
			ElePart.Anchored     = true
			if Head then
				ElePart.Size = Vector3.new(1, 1, 1)
			end
			game.Debris:AddItem(ElePart, 0.65)
			wait(0.55)
			TweenService:Create(ElePart, TweenInfo.new(0.1), {Transparency = 1}):Play()
		end)
	end
	Electrify(Character.RightUpperLeg, .55)
	Electrify(Character.RightLowerLeg, .55)
	Electrify(Character.RightFoot, .55)
	Electrify(Character.LeftUpperLeg, .55)
	Electrify(Character.LeftLowerLeg, .55)
	Electrify(Character.LeftFoot, .55)
	for v,parts in pairs(Character:GetChildren()) do
		if parts:IsA("BasePart") then
			if parts.Name ~= "Head" then
				Vanish(parts)
			else
				Vanish(parts, true)
			end
		end
	end
	local DashHitbox = Assets.Electrification.X.Hitbox:Clone() 
	game.Debris:AddItem(DashHitbox, 0.1)
	local newDistance = (Target.Position - Character.HumanoidRootPart.CFrame.p).magnitude+50
	local DashSizeZ = (Target.Position - Character.HumanoidRootPart.CFrame.p).magnitude+50
	DashHitbox.Parent = script
	DashHitbox.CFrame = CFrame.new(Character.HumanoidRootPart.CFrame.p, Target.Position)*CFrame.new(0, 0, -newDistance/2)
	DashHitbox.Size = Vector3.new(19.05, 19.05, DashSizeZ)
	DashHitbox.Anchored = true
	local ParticleBox1 = Assets.Electrification.X.BeamPart:Clone()
	game.Debris:AddItem(ParticleBox1, 0.1)
	ParticleBox1.Parent = script
	ParticleBox1.CFrame = Character.HumanoidRootPart.CFrame
	ParticleBox1.Anchored = true
	local TweenPart = Assets.Electrification.X.EffectPart:Clone()
	TweenPart.Parent = script
	TweenPart.CFrame = Character.HumanoidRootPart.CFrame
	TweenPart.CFrame = CFrame.new(Character.HumanoidRootPart.CFrame.p, Target.Position)
	HumanoidRootPart.CFrame = CFrame.new(Target.CFrame.p)
	HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Target.CFrame.lookVector)
	task.spawn(function()
		TweenService:Create(TweenPart, TweenInfo.new(0.25), {Position = Target.Position}):Play()
		wait(0.2)
		TweenPart.Electricity.Enabled = false
		wait(0.25)
		TweenPart:Destroy()
	end)
	
	local ParticleBox2 = Assets.Electrification.X.BeamPart:Clone()
	game.Debris:AddItem(ParticleBox2, 0.1)
	ParticleBox2.Parent = script
	ParticleBox2.CFrame = Character.HumanoidRootPart.CFrame
	ParticleBox2.Anchored = true
	local Beam  = Assets.Electrification.X.Particles.Beam:Clone()
	Beam.Parent = ParticleBox1
	Beam.Attachment0 = ParticleBox1.Attachment
	Beam.Attachment1 = ParticleBox2.Attachment
	local PlayersHit = {}
	DashHitbox.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHit, hit.Parent) then return end
			table.insert(PlayersHit, hit.Parent)

			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*1.75)
			Shocked:Fire(HRT.Parent, 2)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1.5)
		end
	end)
end

local function ElectricFloor()
	ElectricFloorAnim:Play()
	Electrify(Character.RightUpperArm, .85)
	Electrify(Character.RightLowerArm, .85)
	Electrify(Character.LeftUpperArm, .85)
	Electrify(Character.LeftLowerArm, .85)
	Electrify(Character.RightHand, .85)
	Electrify(Character.LeftHand, .85)
	wait(0.8)
	local ElectricFloor = Assets.Electrification.C.ElectricFloor:Clone()
	ElectricFloor.Parent = script
	ElectricFloor.CFrame = Character.HumanoidRootPart.CFrame*CFrame.new(0, -1.2, 0)
	task.spawn(function()
		TweenService:Create(ElectricFloor, TweenInfo.new(1), {Size = ElectricFloor.Size*Vector3.new(60, 1.5, 60)}):Play()
		wait(1)
		ElectricFloor.Electricity1.Enabled = false
		ElectricFloor.Electricity2.Enabled = false
		ElectricFloor.Electricity3.Enabled = false
		ElectricFloor.Electricity4.Enabled = false
		ElectricFloor.Electricity5.Enabled = false
		ElectricFloor.Electricity6.Enabled = false
		wait(ElectricFloor.Electricity1.Lifetime.Max + .25)
		ElectricFloor:Destroy()
	end)
	
	local PlayersHit = {}
	ElectricFloor.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			if table.find(PlayersHit, hit.Parent) then return end
			table.insert(PlayersHit, hit.Parent)
			
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2.5)
			Shocked:Fire(HRT.Parent, 3)
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.Name = "Heavy"
			game.Debris:AddItem(Velocity,1.5)
		end
	end)
end
local Moveset = {ElectricStomp,ElectricDash,ElectricFloor}

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 200 and Humanoid.Health > 0 and Stunned == false and not ElectricCooldown then
			ElectricCooldown = true
			ElectricityActive = true
			task.delay(5, function() ElectricCooldown = false end)
			Moveset[MoveCycle]()
			wait(.5)
			ElectricityActive = false
			if MoveCycle < 3 then
				MoveCycle = MoveCycle + 1
			else
				MoveCycle = 1
			end
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false and not ElectricityActive then
			local animation = script.Punch
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			CombatType += 1
			if CombatType > 4 then CombatType = 1 end
		end
	end
end)

Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,"Pro Hero")
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
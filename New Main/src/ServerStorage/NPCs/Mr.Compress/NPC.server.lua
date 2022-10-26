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
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local ThrowAnim = Humanoid:LoadAnimation(script.Throw)
local TweenService = game:GetService("TweenService")

local Corotot = coroutine.wrap(function()
	while wait() do
		if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 75 then
			Humanoid.WalkSpeed = 75
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

local BunnySpawned = 0
local colors = {Color3.fromRGB(253, 234, 141),Color3.fromRGB(204, 255, 204),Color3.fromRGB(175, 221, 255),Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 255, 204),
Color3.fromRGB(204, 188, 255),Color3.fromRGB(255, 201, 201),Color3.fromRGB(204, 255, 204)}
local coro = coroutine.wrap(function()
while wait(.5) do
	if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 250 and Humanoid.Health > 0 and BunnySpawned < 5 then
		BunnySpawned = BunnySpawned + 1
		ThrowAnim:Play()
		wait(.5)
		local CompressBall = game.ServerStorage.CompressBall:Clone()
		CompressBall.CFrame = HumanoidRootPart.CFrame
		CompressBall.Parent = script.NPCs
		local BV = Instance.new("BodyVelocity", CompressBall)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = HumanoidRootPart.CFrame.lookVector*150
		game.Debris:AddItem(BV, 0.25)
		wait(.25)
		game.Debris:AddItem(CompressBall, .25)
		local NewBunny = game.ServerStorage.NPCs.EasterBunny:Clone()
		NewBunny.Name = "Bunny"..BunnySpawned
		local BunnyRootPart = NewBunny.HumanoidRootPart
		local BunnyHumanoid = NewBunny.Humanoid
		BunnyRootPart.CFrame = CompressBall.CFrame * CFrame.new(0,2,0)
		local BunnyCombat = 1
		NewBunny.Parent = script.NPCs
		for i,v in pairs(NewBunny:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		wait(1)
		for i,v in pairs(NewBunny:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		local EggThrow = false
		local EggThrowAnim = BunnyHumanoid:LoadAnimation(script.EggThrow)
		local coro = coroutine.wrap(function()
		repeat wait(.5)
		if Target then
		BunnyHumanoid.WalkSpeed = 80
		BunnyHumanoid:MoveTo(Target.Position)
		if (BunnyRootPart.Position - Target.Position).Magnitude < 5 then
 local animation = Instance.new("Animation")
	animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[BunnyCombat]
	DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
	local animTrack = BunnyHumanoid:LoadAnimation(animation)
	animTrack:Play()
	if BunnyCombat == 1 then
	BunnyCombat = 2
	elseif BunnyCombat == 2 then
	BunnyCombat = 3
	elseif BunnyCombat == 3 then
	BunnyCombat = 4
	elseif BunnyCombat == 4 then
	BunnyCombat = 1
	end
	elseif (BunnyRootPart.Position - Target.Position).Magnitude < 250 and EggThrow == false then
		EggThrow = true
		EggThrowAnim:Play()
		wait(.75)
		local EasterEgg = game.ServerStorage.EasterEgg:Clone()
		EasterEgg.Parent = script
		EasterEgg.CFrame = BunnyRootPart.CFrame
		local RandomColor = math.random(1,8)
		EasterEgg.Color = colors[RandomColor]
		EasterEgg.Trail.Color = ColorSequence.new(colors[RandomColor],colors[RandomColor])
		local BV = Instance.new("BodyVelocity", EasterEgg)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = BunnyRootPart.CFrame.lookVector*150
		game.Debris:AddItem(EasterEgg, 2.5)
		local PlayersHitted = {}
		local Exploded = false
		EasterEgg.Touched:Connect(function(hitto)
if not hitto:IsDescendantOf(Character) and Exploded == false then
	Exploded = true
	local EggExplosion = game.ServerStorage.EggExplosion:Clone()
	EggExplosion.Parent = script
	EggExplosion.CFrame = EasterEgg.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
	EggExplosion.Color = colors[RandomColor]
	game.Debris:AddItem(EggExplosion,1)
	TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(100,100,100)}):Play()
	EggExplosion.Touched:Connect(function(hit)
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
end
		end)
		local coq = coroutine.wrap(function()
		wait(1.5)
		if Exploded == false then
	EasterEgg:Destroy()
	local EggExplosion = game.ServerStorage.EggExplosion:Clone()
	EggExplosion.Parent = script
	EggExplosion.CFrame = EasterEgg.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
	EggExplosion.Color = colors[RandomColor]
	game.Debris:AddItem(EggExplosion,1)
	TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(100,100,100)}):Play()
	EggExplosion.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name and hit.Parent.Name ~= "Elf" then
for i,tableValue in pairs(PlayersHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayersHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
DmgFunction:Fire(Character, hum, Damage*2)
		end
	end)
		end
		wait(3.5)
		EggThrow = false
		end)
		coq()
		end
		end
		until Target == nil or BunnyHumanoid.Health <= 0 or BunnyHumanoid == nil
		wait(5)
		NewBunny:Destroy()
		BunnySpawned = BunnySpawned - 1
		end)
		coro()
	end
	if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 then
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
			NPCReward.Reward(PlayersHitted.Name,"Mr. Compress")
		end
		end)
		coro()
	end
end)


local Walking = false
while wait(.5) do
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
end
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
local ElfSpawned = 0 
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

local coro = coroutine.wrap(function()
while wait(.5) do
	if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 250 and Humanoid.Health > 0 and ElfSpawned <= 5 then
		ElfSpawned = ElfSpawned + 1
		local Exploded = false
		local NewElf = game.ServerStorage.NPCs.Elf:Clone()
		NewElf.Name = "Elf"..ElfSpawned
		local ElfRootPart = NewElf.HumanoidRootPart
		local ElfHumanoid = NewElf.Humanoid
		ElfRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.random(-10,10), 0, math.random(-10,10))
		NewElf.Parent = script.NPCs
		wait(0.5)
		NewElf.UpperTorso.Effect.Enabled = false
		for i,v in pairs(NewElf:GetChildren()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
			end
		end
		local coro = coroutine.wrap(function()
		repeat
		if Target then
		ElfHumanoid.WalkSpeed = 80
		ElfHumanoid:MoveTo(Target.Position)
		if (ElfRootPart.Position - Target.Position).Magnitude < 25 and Exploded == false then
		Exploded = true
		ElfHumanoid.Health = 0
		local Clone =  game.ServerStorage.SnowExplosion:Clone()
		Clone.CFrame = ElfRootPart.CFrame
		Clone.Anchored = true
		Clone.Parent = script
		game.Debris:AddItem(Clone,2)
		TweenService:Create(Clone,TweenInfo.new(2),{Transparency = 1, Size = Vector3.new(150,150,150)}):Play()
		local PlayersHitted = {}
		Clone.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name and hit.Parent.Name ~= "Elf" then
for i,tableValue in pairs(PlayersHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayersHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
DmgFunction:Fire(Character, hum, Damage*3)
	end
		end)	
		end
		end
		wait(.5)
		until Target == nil or ElfHumanoid.Health <= 0 or ElfHumanoid == nil
		wait(4)
		if NewElf.UpperTorso then
		NewElf.UpperTorso.Effect.Enabled = true
		end
		wait(1)
		NewElf:Destroy()
		ElfSpawned = ElfSpawned - 1
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


Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,"EvilSanta")
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
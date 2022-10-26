local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Shoot = Humanoid:LoadAnimation(script.WaterShoot)
local Stun = Humanoid:LoadAnimation(script.stunned)
local Attack = false
local AttackDB = false
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Stunned = false
local Water = script.Parent:WaitForChild("Water")
local WaterHB = script.DamagePart
local WaterPE = Water.Handle.PE
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local CombatType = 1
local Damage = 500

local PlayersHit = {}
WaterHB.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and Target and Stunned == false and hit.Parent.Parent.Name ~= "NPCs" and Humanoid.Health > 0 then
		for i,tableValue in pairs(PlayersHit) do
			if tableValue == hit.Parent then return end
		end
		table.insert(PlayersHit, hit.Parent)
		DmgFunction:Fire(Character, hit.Parent.Humanoid, Damage)
		wait(.1)
		table.remove(PlayersHit, 1, hit.Parent)	
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
		Humanoid.WalkSpeed = 50
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 50 then
		Humanoid.WalkSpeed = 50
	end
end)

Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	repeat wait() until Target
	NPCReward.Reward(Target.Parent.Name,"UA Student")
end)

while wait(.5) do
	pcall(function()
		if Target == nil then
			Humanoid:MoveTo(OriginalCFrame.p)
			WaterPE.Enabled = false
			Shoot:Stop()
		elseif Target.Parent == nil then 
			Target = nil
		elseif (Target.Position - OriginalCFrame.p).magnitude > 500 then
			Character:SetAttribute("Target", 0)
			Humanoid:MoveTo(OriginalCFrame.p)
			Target = nil
		elseif (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 and Stunned == false then
			Humanoid:MoveTo(Target.Position)
			WaterPE.Enabled = true
			WaterHB.CFrame = HumanoidRootPart.CFrame * CFrame.new(0,0,-50)
			Shoot:Play()
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 then
			Target = nil
		end
	end)
end
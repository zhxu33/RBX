local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local Attack = false
local AttackDB = false
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 500
local Stunned = false
local HitSound = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local KickType = 1
local Electric = script:WaitForChild("Electric")
local supa = false
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local CombatType = 1
local TweenService = game:GetService("TweenService")

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
			if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 50 and supa == false and Humanoid.Health > 0 and Stunned == false then
				local coo = coroutine.wrap(function()
					supa = true
					local clone = Electric:Clone()
					clone.Parent = script
					clone.CFrame = HumanoidRootPart.CFrame
					clone.Orientation = Vector3.new(0,0,90)
					game.Debris:AddItem(clone,3)
					TweenService:Create(clone,TweenInfo.new(1.25), {Size = clone.Size + Vector3.new(0,100,100)}):Play()
					local PlayersHitted = {}
					clone.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" then
							for i,tableValue in pairs(PlayersHitted) do
								if tableValue == hit.Parent then return end
							end
							table.insert(PlayersHitted, hit.Parent)
							local EnemyHum = hit.Parent:FindFirstChildOfClass("Humanoid")
							DmgFunction:Fire(Character, EnemyHum, Damage)
							local aaa = script.Parent.UpperTorso.ParticleEmitter:Clone()
							aaa.Parent = hit.Parent.UpperTorso
							local Electrified2 = true
							local anim = EnemyHum:LoadAnimation(script.Electrified)
							anim:Play()
							local Corotot = coroutine.wrap(function()
								repeat wait()
									EnemyHum.WalkSpeed = 0
									EnemyHum.JumpPower = 0
								until Electrified2 == false
							end)
							Corotot()
							wait(2)
							Electrified2 = false
							wait()
							EnemyHum.WalkSpeed = 18
							anim:Stop()
							EnemyHum.JumpPower = 50
							aaa:Destroy()
						end
					end)
					wait(7)
					supa = false
				end)
				coo()
			end
		end
	end
end)
coro()

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
		end
	end)
end
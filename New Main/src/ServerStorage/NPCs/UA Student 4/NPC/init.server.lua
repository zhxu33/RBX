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
local supa = false
local supatype = 1
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local CombatType = 1

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
			if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and supa == false and Stunned == false and Humanoid.Health > 0 then
				supa = true
				if supatype == 1 then
					supatype = 2
					local rock = script.Part:Clone()
					rock.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,0,-5)
					rock.Parent = script
					rock.Anchored = false
					rock.Transparency = 0 
					game.Debris:AddItem(rock,5)
					local Velocity = Instance.new("BodyVelocity",rock)
					Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 75
					local PlayersHitted = {}
					rock.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						else if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
								for i,tableValue in pairs(PlayersHitted) do
									if tableValue == hit.Parent then return end
								end
								table.insert(PlayersHitted, hit.Parent)
								local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
								local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, Damage*2)
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								Velocity.Velocity = rock.Velocity*1.5
								local Model = Instance.new("Model",hit.Parent.HumanoidRootPart)
								Model.Name = "Heavy"
								game.Debris:AddItem(Model,1)
								game.Debris:AddItem(Velocity,1)
								hum.Sit = true
							end
						end
					end)
					local coo = coroutine.wrap(function()
						wait(5)
						supa = false
					end)
					coo()
				elseif supatype == 2 then
					supatype = 1
					local spike = script.Spike:Clone()
					local spike2 = script.Spike:Clone()
					local spike3 = script.Spike:Clone()
					local spike4 = script.Spike:Clone()
					local spike5 = script.Spike:Clone()
					local spike6 = script.Spike:Clone()
					local spike7 = script.Spike:Clone()
					local spike8 = script.Spike:Clone()
					local spike9 = script.Spike:Clone()
					local spike10 = script.Spike:Clone()
					wait(.1)
					spike.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,5,-7)
					spike.Parent = script
					spike.Transparency = 0
					wait(.1)
					spike2.CFrame = spike.CFrame*CFrame.new(0,0,-10)
					spike2.Parent = script
					spike2.Transparency = 0
					wait(.1)
					spike3.CFrame = spike2.CFrame*CFrame.new(0,0,-10)
					spike3.Parent = script
					spike3.Transparency = 0
					wait(.1)
					spike4.CFrame = spike3.CFrame*CFrame.new(0,0,-10)
					spike4.Parent = script
					spike4.Transparency = 0
					wait(.1)
					spike5.CFrame = spike4.CFrame*CFrame.new(0,0,-10)
					spike5.Parent = script
					spike5.Transparency = 0
					wait(.1)
					spike6.CFrame = spike5.CFrame*CFrame.new(0,0,-10)
					spike6.Parent = script
					spike6.Transparency = 0
					wait(.1)
					spike7.CFrame = spike6.CFrame*CFrame.new(0,0,-10)
					spike7.Parent = script
					spike7.Transparency = 0
					wait(.1)
					spike8.CFrame = spike7.CFrame*CFrame.new(0,0,-10)
					spike8.Parent = script
					spike8.Transparency = 0
					wait(.1)
					spike9.CFrame = spike8.CFrame*CFrame.new(0,0,-10)
					spike9.Parent = script
					spike9.Transparency = 0
					wait(.1)
					spike10.CFrame = spike9.CFrame*CFrame.new(0,0,-10)
					spike10.Parent = script
					spike10.Transparency = 0
					local coo = coroutine.wrap(function()
						wait(2)
						wait(.1) 
						spike:Destroy()
						wait(.1) 
						spike2:Destroy()
						wait(.1) 
						spike3:Destroy()
						wait(.1) 
						spike4:Destroy()
						wait(.1) 
						spike5:Destroy()
						wait(.1) 
						spike6:Destroy()
						wait(.1) 
						spike7:Destroy()
						wait(.1) 
						spike8:Destroy()
						wait(.1) 
						spike9:Destroy()
						wait(.1) 
						spike10:Destroy()
						wait(2)
						supa = false
					end)
					coo()
				end
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
			supatype = 1
		elseif (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
			Humanoid:MoveTo(Target.Position)
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 then
			Target = nil
			supatype = 1
		end
	end)
end
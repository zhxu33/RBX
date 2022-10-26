local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local HvyStunnedAnim   = Humanoid:LoadAnimation(script.heavystunned)
local Stun   = Humanoid:LoadAnimation(script.stunned)
local Step   = Humanoid:LoadAnimation(script.Step)
local Attack = false
local AttackDB   = false
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target     = nil
local Damage     = 500
local Stunned    = false
local HitSound   = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume  = 0.2
local supa          = false
local supatype      = 1
local RespawnNPC    = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward     = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction   = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PunchAnim     = {2313015622,2313016464,2313017174,2313014821}
local CombatType    = 1
local TweenService  = game:GetService("TweenService")
local ServerStorage = game:GetService("ServerStorage")
local Assets        = ServerStorage.UniversalAssets

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()

			CombatType += 1
			if CombatType < 4 then CombatType = 1 end

			if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 40 and supa == false and Humanoid.Health > 0 then
				supa = true
				if supatype == 1 then
					supatype = 2
					Step:Play()
					wait(0.3)
					local ice = Instance.new("Part")
					ice.BrickColor = BrickColor.new("Pastel blue-green")
					ice.Material = "Ice"
					ice.Shape = "Cylinder"
					ice.Size = Vector3.new (1,3,3)
					ice.CanCollide = false
					ice.Transparency = 0.05
					ice.Anchored = true

					local cold = Instance.new("ParticleEmitter",ice)
					cold.Texture = "rbxassetid://241712591"
					cold.LightEmission = 1
					cold.Size = NumberSequence.new(5)
					cold.Rate = 50
					cold.Lifetime = NumberRange.new(5,10)
					cold.Speed = NumberRange.new(0, 0)
					cold.Transparency = NumberSequence.new(0.95)

					local ice2 = Instance.new("Part")
					ice2.Shape = "Cylinder"
					ice2.Size = Vector3.new (10,3,3)
					ice2.CanCollide = false
					ice2.Transparency = 1
					ice2.Anchored = true

					local PlayersHitted = {}
					ice2.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						elseif hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
							for i,tableValue in pairs(PlayersHitted) do
								if tableValue == hit.Parent then return end
							end
							table.insert(PlayersHitted, hit.Parent)
							local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
							local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*3)
							hum.Jump = true
							HRT.Anchored = true
							local froze = Instance.new("ParticleEmitter", hit.parent.UpperTorso)
							froze.Texture = "rbxassetid://241712591"
							froze.LightEmission = 1
							froze.Size = NumberSequence.new(1, 1)
							froze.Rate = 50
							froze.Speed = NumberRange.new(0, 0)
							froze.Transparency = NumberSequence.new(0.9)

							local Frozen  = Assets.Frozen:Clone()
							Frozen.Parent = script
							Frozen.CFrame = HRT.CFrame
							
							wait(3)
							HRT.Anchored = false
							froze:Destroy()
							Frozen:Destroy()
						end
					end)

					ice.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,-2,0)
					ice.Orientation = Vector3.new(0, 0, 90)
					ice.Parent = script
					ice2.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,-2,0)
					ice2.Orientation = Vector3.new(0, 0, 90)
					ice2.Parent = script
					TweenService:Create(ice,  TweenInfo.new(1), {Size = ice.Size + Vector3.new(0,80,80)}):Play()
					TweenService:Create(ice2, TweenInfo.new(1), {Size = ice.Size + Vector3.new(0,80,80)}):Play()
					wait(1)
					task.delay(.3, function()
						wait(0.3)
						TweenService:Create(ice, TweenInfo.new(1), {Transparency = 1}):Play()
						wait(1)
						ice:Destroy()
						ice2:Destroy()
						wait(5)
						supa = false
					end)
				elseif supatype == 2 then
					supatype = 1
					Humanoid.WalkSpeed = 0
					Humanoid.JumpPower = 0
					HumanoidRootPart.Anchored = true
					Step:Play()
					wait(0.3)
					local Crystal  = Assets.Crystal:Clone()
					local Crystal2 = Assets.Crystal:Clone()
					local Crystal3 = Assets.Crystal:Clone()
					local Crystal4 = Assets.Crystal:Clone()
					local Crystal5 = Assets.Crystal:Clone()
					local PlayersHitted = {}
					Crystal.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						elseif hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
							if table.find(PlayersHitted, hit.Parent) then return end
							table.insert(PlayersHitted, hit.Parent)
							
							local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
							local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*2)
							hum.Jump      = true
							HRT.Anchored  = true
							local froze   = Instance.new("ParticleEmitter", hit.parent.UpperTorso)
							froze.Texture = "rbxassetid://241712591"
							froze.LightEmission = 1
							froze.Size          = NumberSequence.new(1, 1)
							froze.Rate          = 50
							froze.Speed         = NumberRange.new(0, 0)
							froze.Transparency  = NumberSequence.new(0.3)
							local Frozen        = Assets.Frozen:Clone()
							Frozen.Parent       = script
							Frozen.CFrame       = HRT.CFrame
							task.wait(3)
							HRT.Anchored = false
							froze:Destroy()
							Frozen:Destroy()
						end
					end)
					Crystal2.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						elseif hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
							if table.find(PlayersHitted, hit.Parent) then return end
							table.insert(PlayersHitted, hit.Parent)

							local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
							local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*2)
							hum.Jump            = true
							HRT.Anchored        = true
							local froze         = Instance.new("ParticleEmitter", hit.parent.UpperTorso)
							froze.Texture       = "rbxassetid://241712591"
							froze.LightEmission = 1
							froze.Size  = NumberSequence.new(1, 1)
							froze.Rate  = 50
							froze.Speed = NumberRange.new(0, 0)
							froze.Transparency = NumberSequence.new(0.3)
							local Frozen       = Assets.Frozen:Clone()
							Frozen.Parent      = script
							Frozen.CFrame      = HRT.CFrame
							task.wait(3)
							HRT.Anchored = false
							froze:Destroy()
							Frozen:Destroy()
						end
					end)
					Crystal3.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						elseif hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
							if table.find(PlayersHitted, hit.Parent) then return end
							table.insert(PlayersHitted, hit.Parent)
							
							local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
							local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*2)
							hum.Jump      = true
							HRT.Anchored  = true
							local froze   = Instance.new("ParticleEmitter", hit.parent.UpperTorso)
							froze.Texture = "rbxassetid://241712591"
							froze.LightEmission = 1
							froze.Size  = NumberSequence.new(1, 1)
							froze.Rate  = 50
							froze.Speed = NumberRange.new(0, 0)
							froze.Transparency = NumberSequence.new(0.3)
							local Frozen       = Assets.Frozen:Clone()
							Frozen.Parent      = script
							Frozen.CFrame      = HRT.CFrame
							task.wait(3)
							HRT.Anchored = false
							froze:Destroy()
							Frozen:Destroy()
						end
					end)
					Crystal4.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						elseif hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
							if table.find(PlayersHitted, hit.Parent) then return end
							table.insert(PlayersHitted, hit.Parent)

							local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
							local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*2)
							hum.Jump      = true
							HRT.Anchored  = true
							local froze   = Instance.new("ParticleEmitter", hit.parent.UpperTorso)
							froze.Texture = "rbxassetid://241712591"
							froze.LightEmission = 1
							froze.Size          = NumberSequence.new(1, 1)
							froze.Rate          = 50
							froze.Speed         = NumberRange.new(0, 0)
							froze.Transparency  = NumberSequence.new(0.3)
							local Frozen  = Assets.Frozen:Clone()
							Frozen.Parent = script
							Frozen.CFrame = HRT.CFrame
							task.wait(3)
							HRT.Anchored = false
							froze:Destroy()
							Frozen:Destroy()
						end
					end)
					Crystal5.Touched:connect(function(hit)
						if hit.Parent.Parent.Name == "NPCs" then
						elseif hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
							if table.find(PlayersHitted, hit.Parent) then return end
							table.insert(PlayersHitted, hit.Parent)

							local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
							local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*2)
							hum.Jump      = true
							HRT.Anchored  = true
							local froze   = Instance.new("ParticleEmitter", hit.parent.UpperTorso)
							froze.Texture = "rbxassetid://241712591"
							froze.LightEmission = 1
							froze.Size  = NumberSequence.new(1, 1)
							froze.Rate  = 50
							froze.Speed = NumberRange.new(0, 0)
							froze.Transparency = NumberSequence.new(0.3)
							local Frozen  = Assets.Frozen:Clone()
							Frozen.Parent = script
							Frozen.CFrame = HRT.CFrame
							task.wait(3)
							HRT.Anchored = false
							froze:Destroy()
							Frozen:Destroy()
						end
					end)
					wait(0.1)
					Crystal.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,5,-7)
					Crystal.Parent = script
					wait(0.1)
					Crystal2.CFrame = Crystal.CFrame*CFrame.new(0,0,-10)
					Crystal2.Parent = script
					wait(0.1)
					Crystal3.CFrame = Crystal2.CFrame*CFrame.new(0,0,-10)
					Crystal3.Parent = script
					wait(0.1)
					Crystal4.CFrame = Crystal3.CFrame*CFrame.new(0,0,-10)
					Crystal4.Parent = script
					wait(0.1)
					Crystal5.CFrame = Crystal4.CFrame*CFrame.new(0,0,-10)
					Crystal5.Parent = script
					Humanoid.WalkSpeed = 50 
					Humanoid.JumpPower = 50
					HumanoidRootPart.Anchored = false
					task.delay(1, function()
						Crystal:Destroy()
						wait(0.2)
						Crystal2:Destroy()
						wait(0.2)
						Crystal3:Destroy()
						wait(0.2)
						Crystal4:Destroy()
						wait(0.2)
						Crystal5:Destroy()
						task.wait(5)
						supa = false
					end)
				end
			end
		end
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
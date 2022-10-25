local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 29 then
	script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
wait()
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block) 
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local BreathAnim = Humanoid:LoadAnimation(AnimationsFolder.Breath)
local GiantBiteAnim = Humanoid:LoadAnimation(AnimationsFolder.GiantBite)
local BreathLaunchAnim = Humanoid:LoadAnimation(AnimationsFolder.BreathLaunch)
local BodyVelocity = Instance.new("BodyVelocity")
local Smoke = script.Smoke
BodyVelocity.Parent = nil
BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
local HitSound = Instance.new("Sound", RootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
local Block = false
local LeftKick = false
local RightKick = false
local LeftPunch = false
local RightPunch = false
local Training = false
local Run = false
local cantrun = false
local Shift = false
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerFolder = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Level = PlayerFolder.Level
local Exp = PlayerFolder.Experience
local Strength = PlayerFolder.Strength
local Agility = PlayerFolder.Agility
local Durability = PlayerFolder.Durability
local Quirk = PlayerFolder.Quirk
local stunned = false
local Defense = Instance.new("NumberValue",Character) 
Defense.Name = "Defense"
Defense.Value = 1
local Stamina = Instance.new("NumberValue",Character)
Stamina.Name = "Stamina"
Stamina.Value = 100+(Agility.Value*1)
local MaxStamina = Instance.new("NumberValue",Character)
MaxStamina.Name = "MaxStamina"
MaxStamina.Value = Stamina.Value
Humanoid.MaxHealth = 75+50*Level.Value
Humanoid.Health = Humanoid.MaxHealth
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
local TweenService = game:GetService("TweenService")
local Corotot = coroutine.wrap(function()
	local REGEN_RATE = 5/100
	local REGEN_STEP = .1
	
	while true do
		while Stamina.Value < MaxStamina.Value do
			local dt = wait(REGEN_STEP)
			local dh = dt*REGEN_RATE*MaxStamina.Value
			Stamina.Value = math.min(Stamina.Value + dh, MaxStamina.Value)
		end
		if Stamina.Value > MaxStamina.Value then
			Stamina.Value = MaxStamina.Value
		end
		Stamina.Changed:Wait()
	end
end)
Corotot()
local Coro = coroutine.wrap(function()
	while wait() do
		if not Character:FindFirstChild("Safezone") and Block == false then
		if RootPart:FindFirstChild("Light") and stunned == false and cantrun == false then
			elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false then
			stunned = true
			local asdfg = false
			Attack.Value = true
			HvyStunnedAnim:Play()
			Humanoid.WalkSpeed = 0
			Humanoid.JumpPower = 0
			for i = 1,3 do
				if asdfg == true or not RootPart:FindFirstChild("Heavy") then
					break
					else
					wait(.75)
				end
			end
			if RootPart:FindFirstChild("Heavy") then
				RootPart:FindFirstChild("Heavy"):Destroy()
			end
			HvyStunnedAnim:Stop()
			asdfg = true
			Humanoid.WalkSpeed = 18
			Humanoid.JumpPower = 50
			stunned = false
			Attack.Value = false
		end
		end
	end
end)
Coro()

local CanFreeze = true
function FreezeHumanoid(hum, HRT, amount)
    if CanFreeze == true and not PartyFinder:Invoke(Player, hum.Parent) and not HRT.Parent:FindFirstChild("ForceField") then -- Don't freeze party members
        local coo = coroutine.wrap(function()
            hum.PlatformStand = true
            HRT.Anchored = true
			if not HRT:FindFirstChild("FrozenScript") then
			local FrozenScript = game.ServerStorage.FrozenScript:Clone()
			local FrozenTime = game.ServerStorage.FrozenTime:Clone()
			FrozenTime.Name = 'FrozenTime'
			FrozenTime.Parent = HRT
			FrozenTime.Value = amount
			FrozenScript.Parent = HRT
			else
			HRT.FrozenScript:Destroy()
			HRT.FrozenTime:Destroy()
			local FrozenScript = game.ServerStorage.FrozenScript:Clone()
			local FrozenTime = game.ServerStorage.FrozenTime:Clone()
			FrozenTime.Name = 'FrozenTime'
			FrozenTime.Parent = HRT
			FrozenTime.Value = amount
			FrozenScript.Parent = HRT
			end
--            wait(amount)
--            hum.PlatformStand = false
--            HRT.Anchored = false
        end)
        coo()
    end
end

Humanoid.Died:Connect(function()
	CanFreeze = false
end)

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")

local CloneTargeting = nil
local CloneAmount = 0
local Cloning = false

local CloneBreath = script:WaitForChild("CloneBreath")
local Weld = Instance.new("Motor6D", CloneBreath)
Weld.Part0 = Character.Head
Weld.Part1 = CloneBreath
Character.Archivable = true

qq.OnServerEvent:Connect(function(play, CloneTarget)
	if CloneTarget.Parent.Name == "NPCs" or game.Players:FindFirstChild(CloneTarget.Name)  and not (CloneTarget:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, CloneTarget.Parent)) then
		CloneTargeting = CloneTarget
	end
end)

zz.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 50 and Cloning == false and CloneAmount ~= 4 then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		Cloning = true
		CloneAmount = CloneAmount + 1
		BreathAnim:Play()
		wait(.8)
		CloneBreath.Particle.Enabled = true
		wait(1)
		local CharacterClone = Character:Clone()
		CharacterClone.HumanoidRootPart.CFrame = RootPart.CFrame*CFrame.new(0,0,-10)
		for i,v in pairs(CharacterClone:GetDescendants()) do
			if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("NumberValue") or v:IsA("BoolValue") or v:IsA("ForceField") or v:IsA("StringValue") or v:IsA("ParticleEmitter") or v:IsA("BillboardGui") or v:IsA("BodyVelocity") then
			v:Destroy()
			end
		end
		CharacterClone.Parent = script
		local FameValue = Instance.new("NumberValue", CharacterClone)
		FameValue.Value = PlayerFolder.Fame.Value 
		FameValue.Name = "Fame"
		local StaminaValue = Instance.new("NumberValue",CharacterClone)
		StaminaValue.Value = 100
		StaminaValue.Name = "Stamina"
		local MaxStaminaValue = Instance.new("NumberValue",CharacterClone)
		MaxStaminaValue.Value = 100
		MaxStaminaValue.Name = "MaxStamina"
		local CloneParticle1 = game.ServerStorage.CloneParticle:Clone()
		CloneParticle1.Parent = CharacterClone.HumanoidRootPart
		local CloneParticle2 = game.ServerStorage.CloneParticle2:Clone()
		CloneParticle2.Parent = CharacterClone.HumanoidRootPart
		local CloneOverHeadScript = game.ServerStorage.CloneOverHead:Clone()
		CloneOverHeadScript.Parent = CharacterClone
		local CloneAnimateScript = game.ServerStorage.CloneAnimate:Clone()
		CloneAnimateScript.Parent = CharacterClone
		local CloneHumanoid = CharacterClone.Humanoid
		CloneHumanoid.MaxHealth = CloneHumanoid.MaxHealth/4
		CloneHumanoid.Health = CloneHumanoid.MaxHealth 
		local CloneWalkSpeed = 18
		if Agility.Value >= 2000 then
		CloneWalkSpeed = 140
		else
		CloneWalkSpeed = 40 + 0.05 * Agility.Value	
		end
		CloneHumanoid.WalkSpeed = CloneWalkSpeed
		wait(.5)
		BreathAnim:Stop()
		CloneParticle1.Enabled = false
		CloneParticle2.Enabled = false
		local CloneCombatPick = 1
		local coro = coroutine.wrap(function()
			while wait(.5) do
				if CloneHumanoid.Health <= 0 then
				break end
				if CloneHumanoid.WalkSpeed ~= CloneWalkSpeed and CloneHumanoid.WalkSpeed ~= 0 then
					CloneHumanoid.WalkSpeed = CloneWalkSpeed
				end
				if CloneTargeting ~= nil and workspace.NPCs:FindFirstChild(CloneTargeting.Name) and CloneTargeting:FindFirstChild("Humanoid") and CloneTargeting:FindFirstChild("HumanoidRootPart") 
				or CloneTargeting ~= nil and game.Players:FindFirstChild(CloneTargeting.Name) and CloneTargeting:FindFirstChild("Humanoid") and CloneTargeting:FindFirstChild("HumanoidRootPart") and not (CloneTargeting:FindFirstChild("PVPOFF") or CloneTargeting:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, CloneTargeting)) then
					if CloneTargeting:FindFirstChild("Humanoid").Health > 0 then
					CloneHumanoid:MoveTo(CloneTargeting.HumanoidRootPart.Position)
					if (CloneTargeting.HumanoidRootPart.Position - CharacterClone.HumanoidRootPart.Position).Magnitude < 10 then
						local animation = Instance.new("Animation")
						animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CloneCombatPick]
						local animTrack = CloneHumanoid:LoadAnimation(animation)
						animTrack:Play()
						if CloneCombatPick <= 3 then
						CloneCombatPick = CloneCombatPick + 1
						elseif CloneCombatPick == 4 then
						CloneCombatPick = 1
						end
						local hum = CloneTargeting.Humanoid
						local HRT = CloneTargeting.HumanoidRootPart
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 50
			HitSound:Play()
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(10000,10000,10000)
			Velocity.Velocity = CharacterClone.HumanoidRootPart.CFrame.lookVector * 40
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = CharacterClone.HumanoidRootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,.5)
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
				if hum.Health < 1 then
					if game.Players:GetPlayerFromCharacter(hum.Parent) then
						local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(hum.Parent.Name)
						local enemyplrFame = enemyplrf.Fame
						if enemyplrFame.Value > -1 then
							PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
						elseif enemyplrFame.Value <= -1 then
							PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
						end
					elseif hum.Parent:FindFirstChild("Fame") then
						local enemyplrFame = hum.Parent.Fame
						if hum.Parent.Name == "All Might" then
							PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 150
							Exp.Value = Exp.Value + 100000
							PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + 10000
							local reward = game.ReplicatedStorage.Remotes.RewardPane
							reward:FireClient(Player, 100000, 10000)		
						elseif enemyplrFame.Value > -1 then
							PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
							PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + math.random(20,50)
						elseif enemyplrFame.Value <= -1 then
							PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
							PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + math.random(20,50)
						end
					end
				end
				wait(0.1)
				Velocity:Destroy()
				end
			end
				end
				end
				end
		end)
		coro()
		CloneHumanoid.BreakJointsOnDeath = false
		CloneHumanoid.Died:Connect(function()
			CloneParticle1.Enabled = true
			CloneParticle2.Enabled = true
			wait(2)
			CloneParticle1.Enabled = false
			CloneParticle2.Enabled = false
			wait(1.5)
			CharacterClone:Destroy()
			CloneAmount = CloneAmount - 1
		end)
		CloneBreath.Particle.Enabled = false
		Attack.Value = false
		wait(3)
		Cloning = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value > 50 and script:FindFirstChild(Player.Name) and script:FindFirstChild(Player.Name).Humanoid.Health > 0 then
		local NearestDistance = nil
		local CloneTarget = nil
		for i,v in pairs(script:GetChildren()) do
		if v.Name == Player.Name and v.Humanoid.Health > 0 then
			local Distance = (v.HumanoidRootPart.Position - RootPart.Position).Magnitude
			if NearestDistance == nil or Distance < NearestDistance then
				CloneTarget = v
				NearestDistance = Distance
			end
		end
		end
		if NearestDistance > 500 then return end
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		local SafeTp = Instance.new("NumberValue", Character)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,2)
		RootPart.CFrame = CloneTarget.HumanoidRootPart.CFrame
		CloneTarget.Humanoid.Health = 0
		local CloneExplosion = game.ServerStorage.CloneExplosion:Clone()
		CloneExplosion.Parent = script
		CloneExplosion:SetPrimaryPartCFrame(RootPart.CFrame)
		TweenService:Create(CloneExplosion.HB, TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(50,50,50)}):Play()
		TweenService:Create(CloneExplosion.Effect, TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(45,45,45)}):Play()
		game.Debris:AddItem(CloneExplosion, 3)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if CloneExplosion == nil or CloneExplosion:FindFirstChild("HB") == nil then
					break
				end
				connection = CloneExplosion.HB.Touched:Connect(function() end)
				results = CloneExplosion.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil or not (results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent)) then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 55*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									Velocity.Velocity = Vector3.new(0,50,0)
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,0.5)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
		wait(.5)
		Attack.Value = false
		wait(1)
		CloneExplosion.HB.CloneParticle.Enabled = false
		CloneExplosion.HB.CloneParticle2.Enabled = false
	end
end)

local CloneLaunch = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value > 50 and CloneLaunch == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		CloneLaunch = true
		BreathLaunchAnim:Play()
		wait(.75)
		local CloneShot = game.ServerStorage.CloneLaunch:Clone()
		CloneShot.Parent = script
		CloneShot.CFrame = RootPart.CFrame
		local BV = Instance.new("BodyVelocity",CloneShot)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 150
		game.Debris:AddItem(CloneShot, 3)
		local Hitted = false
		local CloneShotTarget = nil
		local contect 
		contect = CloneShot.HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name and Hitted == false and hit.Parent.Parent.Name ~= "InteractionNPCS" and not(hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent)) then
				Hitted = true
				contect:Disconnect()
				CloneShotTarget = hit.Parent
				CloneShot.Particle.Enabled = false
				CloneShot.Anchored = true
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = Vector3.new(0,50,0)
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.5)
					end
						local CharacterClone = Character:Clone()
		CharacterClone.HumanoidRootPart.CFrame = HRT.CFrame*CFrame.new(0,0,-10)
		for i,v in pairs(CharacterClone:GetDescendants()) do
			if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("NumberValue") or v:IsA("BoolValue") or v:IsA("ForceField") or v:IsA("StringValue") or v:IsA("ParticleEmitter") or v:IsA("BillboardGui") or v:IsA("BodyVelocity") then
			v:Destroy()
			end
		end
		CharacterClone.Parent = script
		local FameValue = Instance.new("NumberValue", CharacterClone)
		FameValue.Value = PlayerFolder.Fame.Value 
		FameValue.Name = "Fame"
		local StaminaValue = Instance.new("NumberValue",CharacterClone)
		StaminaValue.Value = 100
		StaminaValue.Name = "Stamina"
		local MaxStaminaValue = Instance.new("NumberValue",CharacterClone)
		MaxStaminaValue.Value = 100
		MaxStaminaValue.Name = "MaxStamina"
		local CloneParticle1 = game.ServerStorage.CloneParticle:Clone()
		CloneParticle1.Parent = CharacterClone.HumanoidRootPart
		local CloneParticle2 = game.ServerStorage.CloneParticle2:Clone()
		CloneParticle2.Parent = CharacterClone.HumanoidRootPart
		local CloneOverHeadScript = game.ServerStorage.CloneOverHead:Clone()
		CloneOverHeadScript.Parent = CharacterClone
		local CloneAnimateScript = game.ServerStorage.CloneAnimate:Clone()
		CloneAnimateScript.Parent = CharacterClone
		local CloneHumanoid = CharacterClone.Humanoid
		CloneHumanoid.MaxHealth = CloneHumanoid.MaxHealth/4
		CloneHumanoid.Health = CloneHumanoid.MaxHealth 
		local CloneWalkSpeed = 18
		if Agility.Value >= 2000 then
		CloneWalkSpeed = 140
		else
		CloneWalkSpeed = 40 + 0.05 * Agility.Value	
		end
		CloneHumanoid.WalkSpeed = CloneWalkSpeed
		local coo = coroutine.wrap(function()
		wait(.5)
		CloneParticle1.Enabled = false
		CloneParticle2.Enabled = false
		end)
		coo()
		local CloneCombatPick = 1
		local coro = coroutine.wrap(function()
			while wait(.5) do
				if CloneHumanoid.Health <= 0 then
				break end
				if CloneHumanoid.WalkSpeed ~= CloneWalkSpeed and CloneHumanoid.WalkSpeed ~= 0 then
					CloneHumanoid.WalkSpeed = CloneWalkSpeed
				end
				if CloneShotTarget ~= nil and workspace.NPCs:FindFirstChild(CloneShotTarget.Name) and CloneShotTarget:FindFirstChild("Humanoid") and CloneShotTarget:FindFirstChild("HumanoidRootPart") 
				or CloneShotTarget ~= nil and game.Players:FindFirstChild(CloneShotTarget.Name) and CloneShotTarget:FindFirstChild("Humanoid") and CloneShotTarget:FindFirstChild("HumanoidRootPart") and not (CloneShotTarget.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, CloneShotTarget.Parent))  then
					if CloneShotTarget:FindFirstChild("Humanoid").Health > 0 then
					CloneHumanoid:MoveTo(CloneShotTarget.HumanoidRootPart.Position)
					if (CloneShotTarget.HumanoidRootPart.Position - CharacterClone.HumanoidRootPart.Position).Magnitude < 10 then
						local animation = Instance.new("Animation")
						animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CloneCombatPick]
						local animTrack = CloneHumanoid:LoadAnimation(animation)
						animTrack:Play()
						if CloneCombatPick <= 3 then
						CloneCombatPick = CloneCombatPick + 1
						elseif CloneCombatPick == 4 then
						CloneCombatPick = 1
						end
						local hum = CloneShotTarget.Humanoid
						local HRT = CloneShotTarget.HumanoidRootPart
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 50
			HitSound:Play()
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(10000,10000,10000)
			Velocity.Velocity = CharacterClone.HumanoidRootPart.CFrame.lookVector * 40
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = CharacterClone.HumanoidRootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,.5)
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
				wait(0.1)
				Velocity:Destroy()
				end
			end
					end
				else
			CloneParticle1.Enabled = true
			CloneParticle2.Enabled = true
			wait(2)
			CloneParticle1.Enabled = false
			CloneParticle2.Enabled = false
			wait(1.5)
			CharacterClone:Destroy()
				end
				end
		end)
		coro()
		CloneHumanoid.BreakJointsOnDeath = false
		CloneHumanoid.Died:Connect(function()
			CloneParticle1.Enabled = true
			CloneParticle2.Enabled = true
			wait(2)
			CloneParticle1.Enabled = false
			CloneParticle2.Enabled = false
			wait(1.5)
			CharacterClone:Destroy()
		end)	
		wait(6)
		if CharacterClone and CloneHumanoid and CloneHumanoid.Health > 0 then
		CloneHumanoid.Health = 0
		CloneParticle1.Enabled = true
		CloneParticle2.Enabled = true
		wait(2)
		CloneParticle1.Enabled = false
		CloneParticle2.Enabled = false
		wait(1.5)
		CharacterClone:Destroy()
		end
		end
		end)
		Attack.Value = false
		wait(6)
		CloneLaunch = false
	end
end)

local GiantBite = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 200 and Attack.Value == false and stunned == false and Stamina.Value > 100 and GiantBite == false then
		Stamina.Value = Stamina.Value - 100
		Attack.Value = true
		GiantBite = true
		GiantBiteAnim:Play()
		wait(.5)
		local GiantBiteEffect = game.ServerStorage.CloneGiantBite:Clone()
		GiantBiteEffect.Parent = script
		GiantBiteEffect:SetPrimaryPartCFrame(RootPart.CFrame)
		wait(1)
		local CharacterClone = Character:Clone()
		CharacterClone.HumanoidRootPart.CFrame = GiantBiteEffect.Effect.CFrame*CFrame.new(0,0,0)
		CharacterClone.HumanoidRootPart.Anchored = true
		game.Debris:AddItem(CharacterClone,8)
		for i,v in pairs(CharacterClone:GetDescendants()) do
			if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ForceField") or v:IsA("StringValue") or v:IsA("ParticleEmitter") or v:IsA("BillboardGui") or v:IsA("BodyVelocity") then
			v:Destroy()
			end
			if v.Name == "Shirt" or v.Name == "Pant" then
			end
			if v:IsA("BasePart") then
				local coo = coroutine.wrap(function()
				wait(5)
				v.BrickColor = Character.Head.BrickColor
				TweenService:Create(v, TweenInfo.new(3),{Transparency = 1}):Play()
				end)
				coo()
			end
		end
		CharacterClone.Parent = script.NotClone
		local CloneParticle1 = game.ServerStorage.CloneParticle:Clone()
		CloneParticle1.Size = NumberSequence.new(10,10)
		CloneParticle1.Parent = CharacterClone.HumanoidRootPart
		local CloneParticle2 = game.ServerStorage.CloneParticle2:Clone()
		CloneParticle2.Size = NumberSequence.new(10,10)
		CloneParticle2.Parent = CharacterClone.HumanoidRootPart
		local BreathBiteAnim = CharacterClone.Humanoid:LoadAnimation(AnimationsFolder.BreathBite)
		BreathBiteAnim:Play()
		wait(.2)
		TweenService:Create(CharacterClone.Humanoid.BodyHeightScale, TweenInfo.new(1),{Value = Humanoid.BodyHeightScale.Value + 12}):Play()
		TweenService:Create(CharacterClone.Humanoid.BodyWidthScale, TweenInfo.new(1),{Value = Humanoid.BodyWidthScale.Value + 12}):Play()
		TweenService:Create(CharacterClone.Humanoid.BodyDepthScale, TweenInfo.new(1),{Value = Humanoid.BodyDepthScale.Value + 12}):Play()
		TweenService:Create(CharacterClone.Humanoid.HeadScale, TweenInfo.new(1),{Value = Humanoid.HeadScale.Value + 12}):Play()
		TweenService:Create(CharacterClone.HumanoidRootPart, TweenInfo.new(1),{CFrame = CharacterClone.HumanoidRootPart.CFrame*CFrame.new(0,25,0)}):Play()
		wait(1)
		CloneParticle1.Enabled = false
		CloneParticle2.Enabled = false
		local coo = coroutine.wrap(function()
			repeat wait(.1)
			GiantBiteEffect.HB.CFrame = GiantBiteEffect.HB.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
			until Attack.Value == false or GiantBiteEffect == nil or GiantBiteEffect.HB == nil
		end)
		coo()
		local PlayersHitted = {}
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if GiantBiteEffect == nil or GiantBiteEffect:FindFirstChild("HB") == nil then
					break
				end
				connection = GiantBiteEffect.HB.Touched:Connect(function() end)
				results = GiantBiteEffect.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil  or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 75*Strength.Value/2)
								local coo = coroutine.wrap(function()
									FreezeHumanoid(hum, HRT, 5)
									end)
								coo()
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									Velocity.Velocity = Vector3.new(0,0,0)
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,1)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
		wait(5)
		GiantBiteAnim:Stop()
		GiantBiteEffect.Effect.Particle.Enabled = false
		GiantBiteEffect.Effect.Particle2.Enabled = false
		game.Debris:AddItem(GiantBiteEffect,2)
		Attack.Value = false
		wait(10)
		GiantBite = false
	end
end)

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	Defense.Value = 3
	Stamina.Value = Stamina.Value - 3
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	end)
	coo()
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	Defense.Value = 1
	Attack.Value = false
	end
end)

rup.OnServerEvent:Connect(function()
	if Block == true then
	Block = false
	end
end)

sd.OnServerEvent:Connect(function()
	Shift = true
	if stunned == false and Stamina.Value > 1 and cantrun == false then
			local Corot = coroutine.wrap(function()
				while wait(0.1) do
					Stamina.Value = Stamina.Value - 2
					if Stamina.Value < 2 or Run == false then
						break
					end
				end
			end)
			Corot()
			Run = true
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 140
			else
			Humanoid.WalkSpeed = 40 + 0.05 * Agility.Value	
			end
		end
end)
su.OnServerEvent:Connect(function()
	if cantrun == false then
	Shift = false
	Run = false
	BodyVelocity.Parent = nil
	Humanoid.WalkSpeed = 18
	end
end)

tt.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 10 and Training == false then 
		Attack.Value = true
		Training = true
		local random = math.random(1,2)
		if random == 1 then
		SitUpAnim:Play()
		elseif random == 2 then
			PushUpAnim:Play()
			end
	    Exp.Value = Exp.Value + 50
		Humanoid.WalkSpeed = 0
		cantrun = true
		Humanoid.JumpPower = 0
		wait(1.8)
		Training = false
		Attack.Value = false
	    Humanoid.WalkSpeed = 18
		cantrun = false
		Humanoid.JumpPower = 50
	end
end)

local picked = 1
ee.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 10 then
	Stamina.Value = Stamina.Value - 10
	local animation = Instance.new("Animation")
	animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[picked]
	local animTrack = Humanoid:LoadAnimation(animation)
	animTrack:Play()
	if picked == 1 then
	RightPunch = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if RightPunch == false then
				break
			end
			local connection = Character.RightHand.Touched:Connect(function()end)
			results = Character.RightHand:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							RightPunch = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end 
		end
	end)	
	touchedy()
	wait(0.7)
	Attack.Value = false
	RightPunch = false
	elseif picked == 2 then
	LeftPunch = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if LeftPunch == false then
				break
			end
			local connection = Character.LeftHand.Touched:Connect(function()end)
			results = Character.LeftHand:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
        	 			else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							LeftPunch = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end 
		end
	end)	
	touchedy()
	wait(0.7)
	Attack.Value = false
	LeftPunch = false
	elseif picked == 3 then
	RightKick = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if RightKick == false then
				break
			end
			local connection = Character.RightFoot.Touched:Connect(function()end)
			results = Character.RightFoot:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							RightKick = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end 
		end
	end)	
	touchedy()
	wait(0.7)
	Attack.Value = false
	RightKick = false
	elseif picked == 4 then
	LeftKick = true
	Attack.Value = true
	local results = nil
	local lastresult = nil
	local PlayersHitted = {}
	local touchedy = coroutine.wrap(function()
		while wait(0.01) do
			if LeftKick == false then
				break
			end
			local connection = Character.LeftFoot.Touched:Connect(function()end)
			results = Character.LeftFoot:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
						if PlayersHitted[results[i].Parent] ~= nil then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
        					LeftKick = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(10000,10000,10000)
								Velocity.Velocity = RootPart.CFrame.lookVector * 40
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.5)
								DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
								wait(0.1)
								Velocity:Destroy()
								end
							end
						end
					end 
				end
			lastresult = results
			end
		end
	end)
	wait(0.7)
	Attack.Value = false
	LeftKick = false
	end
	if picked <= 3 then
	picked = picked + 1
	elseif picked == 4 then
	picked = 1
		end
	end
end)
			

while wait() do
	if Humanoid.Health == Humanoid.MaxHealth then
		Humanoid.MaxHealth = 150+150*Durability.Value
		Humanoid.Health = Humanoid.MaxHealth
		else
		Humanoid.MaxHealth = 150+150*Durability.Value
end
if Run == true then
		if Stamina.Value < 2 then
			Run = false
			Humanoid.WalkSpeed = 18
		end
	end
end

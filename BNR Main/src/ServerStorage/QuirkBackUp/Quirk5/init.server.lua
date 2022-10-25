local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 5 then
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
local HealTouchAnim = Humanoid:LoadAnimation(AnimationsFolder.HealTouch)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local InstaHealAnim = Humanoid:LoadAnimation(AnimationsFolder.RegenExplode)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
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
local heal = false
local healtouch = false
local instaheal = false
local draintouch = false
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

local pe1 = Instance.new("ParticleEmitter",Character.UpperTorso)
pe1.Speed = NumberRange.new(0)
pe1.Rate = 500
pe1.Lifetime = NumberRange.new(0.2)
pe1.Texture = "rbxassetid://243728104"
pe1.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
pe1.LightEmission = 1
pe1.Transparency = NumberSequence.new(0.5,1)
pe1.Enabled = false


				
local coroto = coroutine.wrap(function()
	while wait(.5) do
		if Humanoid.Health < Humanoid.MaxHealth and heal == false then
		Humanoid.Health = Humanoid.Health + (150+150*Durability.Value)/60
		Exp.Value = Exp.Value + 25
		pe1.Enabled = true
		elseif Humanoid.Health < Humanoid.MaxHealth and heal == true and Stamina.Value > 5 then 
			Humanoid.Health = Humanoid.Health + (150+150*Durability.Value)/20
			Stamina.Value = Stamina.Value - 5
			Exp.Value = Exp.Value + 50
			pe1.Enabled = true
			pe1.Size = NumberSequence.new(3)
			else
			pe1.Enabled = false
			pe1.Size = NumberSequence.new(1.5)
		end
	end
end)
coroto()

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local vv = script:WaitForChild("V")
local rup = script:WaitForChild("RUP")

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
	wait(0.7)
	Attack.Value = false
	RightPunch = false
	elseif picked == 2 then
	LeftPunch = true
	Attack.Value = true
	wait(0.7)
	Attack.Value = false
	LeftPunch = false
	elseif picked == 3 then
	RightKick = true
	Attack.Value = true
	wait(0.7)
	Attack.Value = false
	RightKick = false
	elseif picked == 4 then
	LeftKick = true
	Attack.Value = true
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
			
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightPunch == true then
RightPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				if draintouch == true then
				Humanoid.Health = Humanoid.Health + 10*Strength.Value/2
				end
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
					end)
				
Character.LeftHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftPunch == true then
LeftPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
			if draintouch == true then
				Humanoid.Health = Humanoid.Health + 10*Strength.Value/2
				end
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
					end)

Character.RightFoot.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightKick == true then
RightKick = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				if draintouch == true then
				Humanoid.Health = Humanoid.Health + 10*Strength.Value/2
				end
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
					end)
				

Character.LeftFoot.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftKick == true then
LeftKick = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
			if draintouch == true then
				Humanoid.Health = Humanoid.Health + 10*Strength.Value/2
			end
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
				end)

local healing = false
zz.OnServerEvent:Connect(function()
	if Durability.Value >= 10 and Attack.Value == false and stunned == false and draintouch == false then
		draintouch = true
		local pe2 = Instance.new("ParticleEmitter",Character.RightHand)
		pe2.Speed = NumberRange.new(0)
		pe2.Rate = 500
		pe2.Lifetime = NumberRange.new(0.2)
		pe2.Texture = "rbxassetid://243728104"
		pe2.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
		pe2.LightEmission = 1
		pe2.Transparency = NumberSequence.new(0.5,1)
		local pe = Instance.new("ParticleEmitter",Character.LeftHand)
		pe.Speed = NumberRange.new(0)
		pe.Rate = 500
		pe.Lifetime = NumberRange.new(0.2)
		pe.Texture = "rbxassetid://243728104"
		pe.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
		pe.LightEmission = 1
		pe.Transparency = NumberSequence.new(0.5,1)
		repeat wait(0.5) until draintouch == false 
		pe:Destroy()
		pe2:Destroy()
		elseif draintouch == true then
		draintouch = false
	end
end)

local healing = false
cc.OnServerEvent:Connect(function()
if Durability.Value >= 50 and Attack.Value == false and stunned == false and heal == false and Stamina.Value > 10 and healing == false and Humanoid.Health < Humanoid.MaxHealth then
healing = true
local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	UpDashEf.Decal.Color3 = Color3.new(0,255,0)
	UpDashEf.Decal1.Color3 = Color3.new(0,255,0)
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.75),{Size = Vector3.new(35,0.05,35)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.75),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.75),{Transparency = 1}):Play()
repeat wait() 
heal = true
until Stamina.Value <= 5 or Humanoid.Health == Humanoid.MaxHealth or heal == false
heal = false
wait(8)
healing = false
elseif heal == true then
heal = false
end
end)

local healltouch = false
xx.OnServerEvent:Connect(function()
if Durability.Value >= 25 and Attack.Value == false and stunned == false and healtouch == false and Stamina.Value > 50 and healltouch == false then
Stamina.Value = Stamina.Value - 50
healtouch = true 
healltouch = true 
local pe2 = Instance.new("ParticleEmitter",Character.RightHand)
pe2.Speed = NumberRange.new(0)
pe2.Rate = 500
pe2.Lifetime = NumberRange.new(0.2)
pe2.Texture = "rbxassetid://243728104"
pe2.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
pe2.LightEmission = 1
pe2.Transparency = NumberSequence.new(0.5,1)
HealTouchAnim:Play()
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and healtouch == true then
		healtouch = false
		pe2:Destroy()
		Exp.Value = Exp.Value + 150
		local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
		local Name = hum.Parent.Name
		local pe2 = Instance.new("ParticleEmitter",hum.Parent.UpperTorso)
pe2.Speed = NumberRange.new(0)
pe2.Rate = 500
pe2.Size = NumberSequence.new(2)
pe2.Lifetime = NumberRange.new(0.2)
pe2.Texture = "rbxassetid://243728104"
pe2.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
pe2.LightEmission = 1
pe2.Transparency = NumberSequence.new(0.5,1)
game.Debris:AddItem(pe2,2)
hum.Health = hum.Health + Durability.Value*25
	end
end)
wait(0.7)
healtouch = false
pe2:Destroy()
wait(2)
healltouch = false
end
end)

vv.OnServerEvent:Connect(function()
	if Durability.Value >= 100 and instaheal == false and Attack.Value == false and stunned == false and Stamina.Value > 150 and Humanoid.Health < Humanoid.MaxHealth then
		instaheal = true
		Stamina.Value = Stamina.Value - 150
		Humanoid.Health = Humanoid.MaxHealth
		InstaHealAnim:Play()
		local ball2 = Instance.new("Part", script)
ball2.Shape = "Ball"
ball2.Size = Vector3.new(3,3,3)
ball2.CFrame = RootPart.CFrame
ball2.BrickColor = BrickColor.new("Lime green")
ball2.Material = "Neon"
ball2.TopSurface = "Smooth"
ball2.BottomSurface = "Smooth"
ball2.CanCollide = false
ball2.Transparency = 0.05
ball2.Anchored = true
local pe2 = Instance.new("ParticleEmitter",ball2)
pe2.Speed = NumberRange.new(0)
pe2.Rate = 500
pe2.Size = NumberSequence.new(5)
pe2.Lifetime = NumberRange.new(0.2)
pe2.Texture = "rbxassetid://243728104"
pe2.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
pe2.LightEmission = 1
pe2.Transparency = NumberSequence.new(0.5,1)
TweenService:Create(ball2, TweenInfo.new(1), {Transparency = 1, Size = ball2.Size + Vector3.new(14,14,14)}):Play()
wait(1)
ball2:Destroy()
		wait(30)
		instaheal = false
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

local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 6 then
	script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
wait()
local PointLight = script.PointLight:Clone()
PointLight.Parent = Character.RightHand
local PointLight2 = script.PointLight:Clone()
PointLight.Parent = Character.LeftHand
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local APShotAnim = Humanoid:LoadAnimation(AnimationsFolder.APShot)
local Fired2Anim = Humanoid:LoadAnimation(AnimationsFolder.Fired2)
local DashAnim = Humanoid:LoadAnimation(AnimationsFolder.Dash)
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block)
local SmallExplodeAnim = Humanoid:LoadAnimation(AnimationsFolder.SmallExplode)
local GroundBlastAnim = Humanoid:LoadAnimation(AnimationsFolder.GroundBlast)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local ChargeAnim = Humanoid:LoadAnimation(AnimationsFolder.Charge)
local FiredAnim = Humanoid:LoadAnimation(AnimationsFolder.Fired)
local HowitAnim = Humanoid:LoadAnimation(AnimationsFolder.Howit)
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Parent = nil
BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
local HitSound = Instance.new("Sound", RootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local ExplosionSound = Instance.new("Sound", RootPart)
ExplosionSound.SoundId = "rbxassetid://514867425"
ExplosionSound.Volume = 0.5
ExplosionSound.MaxDistance = 300
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
local Block = false
local LeftKick = false
local RightKick = false
local LeftPunch = false
local RightPunch = false
local SupaBlast = false
local SmallExplode = false
local APShot = false
local Howitzer = false
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
local ToolType = Character:WaitForChild("ToolType")
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
		end
		end
	end
end)
Coro()

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local zz = script:WaitForChild("Z")
local qq = script:WaitForChild("Q")
local cc = script:WaitForChild("C")
local xx = script:WaitForChild("X")
local xup = script:WaitForChild("Xup")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")
local cup = script:WaitForChild("Cup")
local space = script:WaitForChild("Space")
local spaceup = script:WaitForChild("SpaceUp")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
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

local ExplosionMode = false
local ExplosionModeCD = false
local ExplosionModeMultiplier = 1
local SuperModeLight = script.ExplosionLight
SuperModeLight.Parent = Character.UpperTorso
ff.OnServerEvent:Connect(function()
	if Agility.Value >= 1000 and ExplosionMode == false and ExplosionModeCD == false then
	ExplosionMode = true
	ExplosionModeCD = true
	ExplosionModeMultiplier = 1.2
	SuperModeLight.Enabled = true
	local ExplosionHand = game.ServerStorage.ExplosionHand:Clone()
	local ExplosionHand2 = game.ServerStorage.ExplosionHand:Clone()
	ExplosionHand.Parent = Character.LeftHand
	ExplosionHand2.Parent = Character.RightHand
	local ww = Instance.new("Weld", ExplosionHand)
	ww.Part0 = Character.LeftHand
	ww.Part1 = ExplosionHand
	local ww2 = Instance.new("Weld", ExplosionHand2)
	ww2.Part0 = Character.RightHand
	ww2.Part1 = ExplosionHand2
	repeat wait(.5) 
	Stamina.Value = Stamina.Value - 25
	until ExplosionMode == false or Stamina.Value < 25
	ExplosionModeMultiplier = 1
	for i,v in pairs(ExplosionHand:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	for i,v in pairs(ExplosionHand2:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	game.Debris:AddItem(ExplosionHand,.5)
	game.Debris:AddItem(ExplosionHand2,.5)
	SuperModeLight.Enabled = false
	wait(5)
	ExplosionModeCD = false
	elseif ExplosionMode == true then
		ExplosionMode = false
	end
end)


local charging2 = false

xup.OnServerEvent:Connect(function()
	if charging2 == true then
		charging2 = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Strength.Value >= 500 and Attack.Value == false and stunned == false and APShot == false and Stamina.Value >= 75 then
		Stamina.Value = Stamina.Value - 75
		APShot = true
		Attack.Value = true
		APShotAnim:Play()
		local ChargePart = script.ExplosionCharge:Clone()
		ChargePart.Parent = script
		ChargePart.CFrame = Character.LeftHand.CFrame
		ChargePart.Anchored = false
		local ww = Instance.new("Weld", ChargePart)
		ww.Part0 = ChargePart
		ww.Part1 = Character.LeftHand
		wait(.5)
		ChargePart:Destroy()
		ExplosionSound.Volume = 2
		ExplosionSound:Play()
		local APModel = game.ServerStorage.NewAPShot:Clone()
		APModel.Parent = script
		APModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-10)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		APModel.Effect3.Transparency = 1
		TweenService:Create(APModel.Effect,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(111, 272, 110),CFrame = APModel.Effect.CFrame * CFrame.new(0,-100,0)}):Play()
		TweenService:Create(APModel.Effect2,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(152, 316, 150),CFrame = APModel.Effect2.CFrame * CFrame.new(0,-117,0)}):Play()
		TweenService:Create(APModel.Effect3,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(354, 98, 354)}):Play()
		TweenService:Create(APModel.Effect4,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(190, 110.753, 190)}):Play()
		TweenService:Create(APModel.Effect5,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(295, 124.672, 300)}):Play()
		TweenService:Create(APModel.Effect6,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(295, 173, 300)}):Play()
		TweenService:Create(APModel.Main,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(152, 316, 150),CFrame = APModel.Main.CFrame * CFrame.new(0,-117,0)}):Play()
		local coo = coroutine.wrap(function()
		repeat wait()
			APModel.Effect3.CFrame = APModel.Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			APModel.Effect4.CFrame = APModel.Effect4.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			APModel.Effect5.CFrame = APModel.Effect5.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			APModel.Effect6.CFrame = APModel.Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until APModel == nil
		end)
		coo()
		local PlayersHitted = {}
		APModel.Main.Touched:connect(function(hit)
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "Gauntlet" then
					DmgFunction:Fire(Character, hum, 65*Strength.Value/2*ExplosionModeMultiplier)
					else 
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2*ExplosionModeMultiplier)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 150
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
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
					end
				end
			end)
		wait(1)
		for i,v in pairs(APModel:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		wait(.5)
		APModel:Destroy()
		Attack.Value = false
        wait(6)
		APShot = false
	end
end)

local ExplosionFlight = false
local ExplosionFlightCD = false
local DirectionRemote = script:WaitForChild("Direction")
space.OnServerEvent:Connect(function(play,direction,cframe)
if Attack.Value == false and  Stamina.Value >= 25 and stunned == false and ExplosionFlight == false and ExplosionFlightCD == false  then
	Attack.Value = true
	ExplosionFlight = true
	ExplosionFlightCD = true
	Stamina.Value = Stamina.Value - 25
	Humanoid.AutoRotate = false
	--Humanoid.PlatformStand = true
	PointLight.Enabled = true
	PointLight2.Enabled = true
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
	DashAnim:Play()
	local velocity = Instance.new("BodyVelocity", RootPart)
	velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	velocity.Velocity = direction.lookVector * 150*ExplosionModeMultiplier
	velocity.Name = "ExplosionFlight"
	local ExplosionHand = game.ServerStorage.ExplosionFlightHand:Clone()
	local ExplosionHand2 = game.ServerStorage.ExplosionFlightHand:Clone()
	ExplosionHand.Parent = Character.LeftHand
	ExplosionHand2.Parent = Character.RightHand
	local ww = Instance.new("Weld", ExplosionHand)
	ww.Part0 = Character.LeftHand
	ww.Part1 = ExplosionHand
	local ww2 = Instance.new("Weld", ExplosionHand2)
	ww2.Part0 = Character.RightHand
	ww2.Part1 = ExplosionHand2
	local coo = coroutine.wrap(function()
	local ExplosionShockwave = game.ServerStorage.ExplosionShockwave:Clone()
	ExplosionShockwave.Parent = script
	ExplosionShockwave:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-5)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	game.Debris:AddItem(ExplosionShockwave,1)
	TweenService:Create(ExplosionShockwave.Effect1, TweenInfo.new(.8),{Size = Vector3.new(50,18,50),Transparency = 1}):Play()
	TweenService:Create(ExplosionShockwave.Effect2, TweenInfo.new(.8),{Size = Vector3.new(60,44,60),Transparency = 1}):Play()
	local SmallExplosion = game.ServerStorage.SmallExplosion:Clone()
	SmallExplosion.Parent = script
	SmallExplosion.CFrame = RootPart.CFrame*CFrame.new(-5,0,-5)*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	game.Debris:AddItem(SmallExplosion,1)
	TweenService:Create(SmallExplosion, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
	local SmallExplosion2 = game.ServerStorage.SmallExplosion:Clone()
	SmallExplosion2.Parent = script
	SmallExplosion2.CFrame = RootPart.CFrame*CFrame.new(5,0,-5)*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	game.Debris:AddItem(SmallExplosion2,1)
	TweenService:Create(SmallExplosion2, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
	wait(.3)
	if SmallExplosion and SmallExplosion:FindFirstChild("Attachment") then
		for i,v in pairs(SmallExplosion.Attachment:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
	end
	if SmallExplosion2 and SmallExplosion2:FindFirstChild("Attachment") then
		for i,v in pairs(SmallExplosion2.Attachment:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
	end
	end)
	coo()
	repeat wait(.2) 
	DirectionRemote:FireClient(Player)
	Stamina.Value = Stamina.Value - 10
	ExplosionSound.Volume = 0.5
	ExplosionSound:Play()
	until ExplosionFlight == false or Stamina.Value < 10
	DashAnim:Stop()
	velocity:Destroy()
	Attack.Value = false
	PointLight.Enabled = false
	PointLight2.Enabled = false
	Humanoid.AutoRotate = true
	Humanoid.PlatformStand = false
	for i,v in pairs(ExplosionHand:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	for i,v in pairs(ExplosionHand2:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	game.Debris:AddItem(ExplosionHand,.5)
	game.Debris:AddItem(ExplosionHand2,.5)
	wait(1)
	ExplosionFlightCD = false
elseif ExplosionFlight == true then
	RootPart:FindFirstChild("ExplosionFlight").Velocity = direction.lookVector * 150*ExplosionModeMultiplier
	local coo = coroutine.wrap(function()
	local ExplosionShockwave = game.ServerStorage.ExplosionShockwave:Clone()
	ExplosionShockwave.Parent = script
	ExplosionShockwave:SetPrimaryPartCFrame(cframe*CFrame.new(0,0,-5)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	game.Debris:AddItem(ExplosionShockwave,1)
	TweenService:Create(ExplosionShockwave.Effect1, TweenInfo.new(.8),{Size = Vector3.new(50,18,50),Transparency = 1}):Play()
	TweenService:Create(ExplosionShockwave.Effect2, TweenInfo.new(.8),{Size = Vector3.new(60,44,60),Transparency = 1}):Play()
	local SmallExplosion = game.ServerStorage.SmallExplosion:Clone()
	SmallExplosion.Parent = script
	SmallExplosion.CFrame = cframe*CFrame.new(-5,0,-5)*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	game.Debris:AddItem(SmallExplosion,1)
	TweenService:Create(SmallExplosion, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
	local SmallExplosion2 = game.ServerStorage.SmallExplosion:Clone()
	SmallExplosion2.Parent = script
	SmallExplosion2.CFrame = cframe*CFrame.new(5,0,-5)*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	game.Debris:AddItem(SmallExplosion2,1)
	TweenService:Create(SmallExplosion2, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
	wait(.3)
	if SmallExplosion and SmallExplosion:FindFirstChild("Attachment") then
		for i,v in pairs(SmallExplosion.Attachment:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
	end
	if SmallExplosion2 and SmallExplosion2:FindFirstChild("Attachment") then
		for i,v in pairs(SmallExplosion2.Attachment:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
	end
	end)
	coo()
	end
end)

spaceup.OnServerEvent:Connect(function(play, direction)
	if ExplosionFlight == true then
		ExplosionFlight = false
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
	end
	if picked == 1 then
	picked = 2
	elseif picked == 2 then
	picked = 1
		end
	end
end)
	
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightPunch == true and ExplosionMode == false then
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
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftPunch == true and ExplosionMode == false then
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
					end)

Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightPunch == true and ExplosionMode == true then
RightPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 50
			HitSound:Play()
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velocity.Velocity = RootPart.CFrame.lookVector * 100
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,.5)
			local coo = coroutine.wrap(function()
			local SmallExplosion = game.ServerStorage.SmallExplosion:Clone()
			SmallExplosion.Parent = script
			SmallExplosion.CFrame = HRT.CFrame*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
			game.Debris:AddItem(SmallExplosion,1)
			TweenService:Create(SmallExplosion, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
			wait(.3)
			if SmallExplosion and SmallExplosion:FindFirstChild("Attachment") then
				for i,v in pairs(SmallExplosion.Attachment:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v.Enabled = false
					end
				end
			end
		end)
		coo()
			if ToolType.Value == "Gauntlet" then
				DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
			else
				DmgFunction:Fire(Character, hum, 25*Strength.Value/2)
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
			end
		end
end)


Character.LeftHand.Touched:Connect(function(hit)
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftPunch == true and ExplosionMode == true then
LeftPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 50
			HitSound:Play()
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(10000,10000,10000)
			Velocity.Velocity = RootPart.CFrame.lookVector * 100
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,.5)
			local coo = coroutine.wrap(function()
			local SmallExplosion = game.ServerStorage.SmallExplosion:Clone()
			SmallExplosion.Parent = script
			SmallExplosion.CFrame = HRT.CFrame*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
			game.Debris:AddItem(SmallExplosion,1)
			TweenService:Create(SmallExplosion, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
			wait(.3)
			if SmallExplosion and SmallExplosion:FindFirstChild("Attachment") then
				for i,v in pairs(SmallExplosion.Attachment:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v.Enabled = false
					end
				end
			end
		end)
		coo()
				if ToolType.Value == "Gauntlet" then
				DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
			else
				DmgFunction:Fire(Character, hum, 25*Strength.Value/2)
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
			end
		end
end)

local GroundBlast = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 750 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and GroundBlast == false then
		GroundBlast = true
		Stamina.Value = Stamina.Value - 100
		Attack.Value = true
		GroundBlastAnim:Play()
		local ChargePart = script.ExplosionCharge:Clone()
		ChargePart.Parent = script
		ChargePart.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
		ChargePart.Anchored = false
		local ww = Instance.new("Weld", ChargePart)
		ww.Part0 = ChargePart
		ww.Part1 = Character.LeftHand
		local ChargePart2 = script.ExplosionCharge:Clone()
		ChargePart2.Parent = script
		ChargePart2.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
		ChargePart2.Anchored = false
		local ww2 = Instance.new("Weld", ChargePart2)
		ww2.Part0 = ChargePart2
		ww2.Part1 = Character.RightHand
		wait(.5)
		ChargePart:Destroy()
		ChargePart2:Destroy()
		local PlayerHitted = {}
		ExplosionSound.Volume = 2.5
		ExplosionSound:Play()
		local coo = coroutine.wrap(function()
		local ExplodeModel = game.ServerStorage.NewExplosionModel:Clone()
		ExplodeModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,7.5,0)*CFrame.Angles(math.random(0,0),math.random(-360,360),math.random(0,0)))
		ExplodeModel.Parent = script
				ExplodeModel.Main.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
		for i,tableValue in pairs(PlayerHitted) do
		if tableValue == hit.Parent then return end
		end
		table.insert(PlayerHitted, hit.Parent)
		table.insert(PlayerHitted, hit.Parent)
		local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
		local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if HRT:FindFirstChild("Light") == nil then
					Exp.Value = Exp.Value + 50
					HitSound:Play()
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					Velocity.Velocity = Vector3.new(0,100,0)
					Velocity.Name = "Heavy"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.5)
						if ToolType.Value == "Gauntlet" then
						DmgFunction:Fire(Character, hum, 70*Strength.Value/2*ExplosionModeMultiplier)
					else
						DmgFunction:Fire(Character, hum, 65*Strength.Value/2*ExplosionModeMultiplier)
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
					end
				end
			end)
		ExplodeModel.Effect.Transparency = 1
		ExplodeModel.Effect.Attachment.Smoke.Enabled = true
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Color = Color3.fromRGB(80,80,80),Size = Vector3.new(191, 177, 198),Transparency = .5}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(199,167,185),Transparency = .6}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Size = Vector3.new(184,152,168),Transparency = .6}):Play()
		local tween = TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Size = Vector3.new(182,166,185),Transparency = .6})
		tween:Play()
		TweenService:Create(ExplodeModel.Main, TweenInfo.new(1.75), {Size = Vector3.new(250,250,250)}):Play()
		tween.Completed:Connect(function()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1.5), {Size = Vector3.new(255, 236, 264),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1.5), {Size = Vector3.new(265, 223, 246)}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1.5), {Size = Vector3.new(245, 202, 224)}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1.5), {Size = Vector3.new(242, 221, 247)}):Play()
		end)
		wait(.5)
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		--TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Transparency = 1}):Play()
		wait(1.5)
		ExplodeModel.Main:Destroy()
		wait(1)
		ExplodeModel:Destroy()
		end)
		coo()
		wait(1)
		Attack.Value = false
		wait(8)
		GroundBlast = false
	end
end)

local Charging = false
zz.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and SupaBlast == false then
		SupaBlast = true
		Stamina.Value = Stamina.Value - 50
		Attack.Value = true 
		wait()
		local ChargePart = script.ExplosionCharge:Clone()
		ChargePart.Parent = script
		ChargePart.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
		ChargePart.Anchored = false
		local ww = Instance.new("Weld", ChargePart)
		ww.Part0 = ChargePart
		ww.Part1 = Character.LeftHand
		ChargeAnim:Play()
		wait(.4)
		ChargeAnim:Stop()
		ChargePart:Destroy()
		FiredAnim:Play()
		local cframe = RootPart.CFrame
		local coo = coroutine.wrap(function()
		ExplosionSound.Volume = 1
		ExplosionSound:Play()
		local PlayersHitted = {}
		local ExplodeModel = game.ServerStorage.NewExplosionModel:Clone()
		ExplodeModel.Parent = script
		ExplodeModel:SetPrimaryPartCFrame(cframe*CFrame.new(0,7.5,-50)*CFrame.Angles(math.random(-360,360),math.random(0,0),math.random(0,0)))
			ExplodeModel.Main.Touched:connect(function(hit)
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "Gauntlet" then
				DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ExplosionModeMultiplier)
			else
				DmgFunction:Fire(Character, hum, 35*Strength.Value/2*ExplosionModeMultiplier)
				end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 150
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
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
					end
				end
		end)
		TweenService:Create(ExplodeModel.Effect, TweenInfo.new(1), {Size = Vector3.new(228, 160, 209),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(171, 158, 177),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(178, 150, 165),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Size = Vector3.new(162, 136, 151),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Size = Vector3.new(163, 148, 166),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Main, TweenInfo.new(1), {Size = Vector3.new(200,200,200)}):Play()
		wait(.4)
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		for i,v in pairs(ChargePart:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		wait(.6)
		ChargePart:Destroy()
		ExplodeModel:Destroy()
		end)
		coo()
		wait(0.1)
		local coo = coroutine.wrap(function()
		ExplosionSound.Volume = 1
		ExplosionSound:Play()
		local PlayersHitted = {}
		local ExplodeModel = game.ServerStorage.NewExplosionModel:Clone()
		ExplodeModel.Parent = script
		ExplodeModel:SetPrimaryPartCFrame(cframe*CFrame.new(0,7.5,-100)*CFrame.Angles(math.random(-360,360),math.random(0,0),math.random(0,0)))
			ExplodeModel.Main.Touched:connect(function(hit)
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "Gauntlet" then
				DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ExplosionModeMultiplier)
			else
				DmgFunction:Fire(Character, hum, 35*Strength.Value/2*ExplosionModeMultiplier)
				end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 150
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
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
					end
				end
		end)
		TweenService:Create(ExplodeModel.Effect, TweenInfo.new(1), {Size = Vector3.new(228, 160, 209),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(171, 158, 177),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(178, 150, 165),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Size = Vector3.new(162, 136, 151),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Size = Vector3.new(163, 148, 166),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Main, TweenInfo.new(1), {Size = Vector3.new(200,200,200)}):Play()
		wait(.4)
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		for i,v in pairs(ChargePart:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		wait(.6)
		ChargePart:Destroy()
		ExplodeModel:Destroy()
		end)
		coo()
		wait(0.1)
		local coo = coroutine.wrap(function()
		ExplosionSound.Volume = 1
		ExplosionSound:Play()
		local PlayersHitted = {}
		local ExplodeModel = game.ServerStorage.NewExplosionModel:Clone()
		ExplodeModel.Parent = script
		ExplodeModel:SetPrimaryPartCFrame(cframe*CFrame.new(0,7.5,-150)*CFrame.Angles(math.random(-360,360),math.random(0,0),math.random(0,0)))
			ExplodeModel.Main.Touched:connect(function(hit)
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "Gauntlet" then
				DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ExplosionModeMultiplier)
			else
				DmgFunction:Fire(Character, hum, 35*Strength.Value/2*ExplosionModeMultiplier)
				end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 150
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
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
					end
				end
		end)
		TweenService:Create(ExplodeModel.Effect, TweenInfo.new(1), {Size = Vector3.new(228, 160, 209),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(171, 158, 177),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(178, 150, 165),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Size = Vector3.new(162, 136, 151),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Size = Vector3.new(163, 148, 166),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Main, TweenInfo.new(1), {Size = Vector3.new(200,200,200)}):Play()
		wait(.4)
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		for i,v in pairs(ChargePart:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		wait(.6)
		ChargePart:Destroy()
		ExplodeModel:Destroy()
		end)
		coo()
		wait(1)
		Attack.Value = false
		FiredAnim:Stop()
		wait(6)
		SupaBlast = false
	end
end)

cup.OnServerEvent:Connect(function()
	if Charging == true then
		Charging = false
	end
end)
	
local col = false
local hitted = false
local plr = game.Players:FindFirstChild(Player.Name)
vv.OnServerEvent:Connect(function(play, direc)
	if hitted == false and Howitzer == true then
	hitted = true
	end
	if Strength.Value >= 1000 and Attack.Value == false and stunned == false and Stamina.Value >= 200 and Howitzer == false and col == false then
	Howitzer = true
	hitted = false
	Attack.Value = true
	col = true
	Stamina.Value = Stamina.Value - 200
	HowitAnim:Play()  
	Humanoid.AutoRotate = false
	Humanoid.PlatformStand = true
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p, direc)
	local velocity = Instance.new("BodyVelocity",RootPart)
	velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	velocity.Name = "Fly"
	velocity.velocity = RootPart.CFrame.lookVector * 25
	TweenService:Create(velocity,TweenInfo.new(2),{Velocity =  RootPart.CFrame.lookVector * 150}):Play()
	local Howitzerclone = game.ServerStorage.Howitzer:Clone()
	Howitzerclone.Parent = Character
	for i,v in pairs(Howitzerclone:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("UnionOperation") then
				v.Transparency = 1
			elseif v:IsA("Beam") then
				v.Transparency = NumberSequence.new(1,1)
			elseif v:IsA("ParticleEmitter") and v.Name ~= "Explosion" and v.Name ~= "Smoke2"  then
				v.Enabled = false
			end
	end
	local rootblast = Howitzerclone.bro
	Humanoid.Jump = true
	rootblast.CFrame = RootPart.CFrame*CFrame.new(0,2.5,0)
	local Weld = Instance.new("Weld",rootblast)
	Weld.Part0 = rootblast
	Weld.Part1 = RootPart
	game.Chat:Chat(Character,"Howitzer..","White")
	local HitPart = Instance.new("Part",script)
	HitPart.Anchored = false
	HitPart.CanCollide = false
	HitPart.Size = Vector3.new(5,5,5)
	HitPart.Transparency = 1
	HitPart.CFrame = RootPart.CFrame
	local Weld2 = Instance.new("Weld", HitPart)
	Weld2.Part0 = HitPart
	Weld2.Part1 = RootPart
	local coo = coroutine.wrap(function()
	wait(.1)
	HitPart.Touched:Connect(function(hit)
		if hitted == false and hit.Transparency == 0 and RootPart:FindFirstChild("Fly") and not hit:IsDescendantOf(Character) then
		RootPart:FindFirstChild("Fly"):Destroy()
		hitted = true
		RootPart.Anchored = true
		end 
	end)
	end)
	coo()
	for i=1, 10 do wait(.1)
	local coo = coroutine.wrap(function()
	local SmallExplosion = game.ServerStorage.SmallExplosion:Clone()
	SmallExplosion.Parent = script
	if hitted == false then 
	SmallExplosion.CFrame = RootPart.CFrame*CFrame.new(math.random(-5,5),math.random(-5,5),-20)*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	elseif hitted == true then
	SmallExplosion.CFrame = RootPart.CFrame*CFrame.new(math.random(-5,5),math.random(-5,5),0)*CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	end
	game.Debris:AddItem(SmallExplosion,1)
	TweenService:Create(SmallExplosion, TweenInfo.new(.6),{Size = Vector3.new(13, 9, 12),Transparency = 1}):Play()
	wait(.3)
	if SmallExplosion and SmallExplosion:FindFirstChild("Attachment") then
		for i,v in pairs(SmallExplosion.Attachment:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
	end
	end)
	coo()
	end
		for i,v in pairs(Howitzerclone:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("UnionOperation") then
				v.Transparency = 1
				TweenService:Create(v,TweenInfo.new(1),{Transparency = 0}):Play()
			elseif v:IsA("Beam") then
				local coo = coroutine.wrap(function()
				v.Transparency = NumberSequence.new(1,1)
				wait(.6)
				v.Transparency = NumberSequence.new(0,0)
				end)
				coo()
			elseif v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		local coro = coroutine.wrap(function()
		repeat wait(.4) 
		Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
		local HowitzerEffect = game.ServerStorage.HowitzerEffect:Clone()
		HowitzerEffect.Parent = script
		if hitted == false then
		HowitzerEffect.Ring.CFrame = RootPart.CFrame*CFrame.new(0,0,-40)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		HowitzerEffect.Ring2.CFrame = RootPart.CFrame*CFrame.new(0,0,-40)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		HowitzerEffect.Body.CFrame = RootPart.CFrame*CFrame.new(0,0,-40)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		elseif hitted == true then
		HowitzerEffect.Ring.CFrame = RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		HowitzerEffect.Ring2.CFrame = RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		HowitzerEffect.Body.CFrame = RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		end
		game.Debris:AddItem(HowitzerEffect,1)
		TweenService:Create(HowitzerEffect.Ring, TweenInfo.new(1),{Size = Vector3.new(130, 80, 130),Transparency = 1}):Play()
		TweenService:Create(HowitzerEffect.Ring2, TweenInfo.new(1),{Size = Vector3.new(200, 200, 30),Transparency = 1}):Play()
		TweenService:Create(HowitzerEffect.Body, TweenInfo.new(1),{Size = Vector3.new(64, 94, 64),Transparency = 1}):Play()
		until hitted == true
		HitPart:Destroy()
		HowitAnim:Stop()
		velocity:Destroy()
		Howitzer = false
		game.Debris:AddItem(Howitzerclone,.1)
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
		RootPart.Anchored = false
		ExplosionSound.Volume = 5
		ExplosionSound:Play()
		game.Chat:Chat(Character,"...Impact!","White")
		local part = Instance.new("Part", script)
		part.Anchored = true
		part.CanCollide = false
		part.Transparency = 1
		part.Position = RootPart.Position
		local cframe = part.CFrame
		part:Destroy()
		local PlayerHitted = {}
		local coo = coroutine.wrap(function()
		local ExplodeModel = game.ServerStorage.NewExplosionModel:Clone()
		ExplodeModel:SetPrimaryPartCFrame(cframe*CFrame.new(0,7.5,0)*CFrame.Angles(math.random(0,0),math.random(-360,360),math.random(0,0)))
		ExplodeModel.Parent = script
		ExplodeModel.Main.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
		for i,tableValue in pairs(PlayerHitted) do
		if tableValue == hit.Parent then return end
		end
		table.insert(PlayerHitted, hit.Parent)
		table.insert(PlayerHitted, hit.Parent)
		local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
		local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if HRT:FindFirstChild("Light") == nil then
					Exp.Value = Exp.Value + 50
					HitSound:Play()
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					Velocity.Velocity = Vector3.new(0,100,0)
					Velocity.Name = "Heavy"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.5)
						if ToolType.Value == "Gauntlet" then
						DmgFunction:Fire(Character, hum, 90*Strength.Value/2*ExplosionModeMultiplier)
					else
						DmgFunction:Fire(Character, hum, 80*Strength.Value/2*ExplosionModeMultiplier)
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
					end
				end
		end)
		ExplodeModel.Effect.Transparency = 1
		ExplodeModel.Effect.Attachment.Smoke.Enabled = true
		ExplodeModel.Effect.Attachment.Smoke.Rate = 150 
		ExplodeModel.Effect.Attachment.Smoke.Speed = NumberRange.new(450,450) 
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") and v.Name == "Explosion" then
			v.Size = NumberSequence.new(120,120)
			v.Speed = NumberRange.new(450,450) 
			end
		end
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(251, 232, 259),Transparency = .2}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(2), {Color = Color3.fromRGB(80,80,80)}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(260, 220, 242),Transparency = .5}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Size = Vector3.new(238, 199, 221),Transparency = .5}):Play()
		local tween = TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Size = Vector3.new(239, 217, 242),Transparency = .5})
		tween:Play()
		TweenService:Create(ExplodeModel.Main, TweenInfo.new(2), {Size = Vector3.new(350,350,350)}):Play()
		tween.Completed:Connect(function()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(2), {Size = Vector3.new(359, 331, 370),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(2), {Size = Vector3.new(372, 314, 346)}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(2), {Size = Vector3.new(340, 284, 315)}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(2), {Size = Vector3.new(341, 310, 346)}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Transparency = 1}):Play()
		end)
		wait(.5)
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		--TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1.5), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1,5), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1.5), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1.5), {Color = Color3.fromRGB(80,80,80)}):Play()
		wait(2)
		ExplodeModel.Main:Destroy()
		wait(1)
		ExplodeModel:Destroy()
		end)
		coo()
		Attack.Value = false
		hitted = false
		wait(25)
		col = false
		end)
		coro()
wait(3)
hitted = true
	end
end)

qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and SmallExplode == false and Stamina.Value >= 25 then  
		Attack.Value = true
		Stamina.Value = Stamina.Value - 25
		SmallExplode = true
		SmallExplodeAnim:Play()
		local ChargePart = script.ExplosionCharge:Clone()
		ChargePart.Parent = script
		ChargePart.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
		ChargePart.Anchored = false
		local ww = Instance.new("Weld", ChargePart)
		ww.Part0 = ChargePart
		ww.Part1 = Character.RightHand
		wait(.4)
		ExplosionSound.Volume = 1
		ExplosionSound:Play()
		local ExplodeModel = game.ServerStorage.NewExplosionModel:Clone()
		ExplodeModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,7.5,-50)*CFrame.Angles(math.random(-360,360),math.random(0,0),math.random(0,0)))
		ExplodeModel.Parent = script
		local PlayerHitted = {}
			ExplodeModel.Main.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= script.Parent.Name then
for i,tableValue in pairs(PlayerHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayerHitted, hit.Parent)
table.insert(PlayerHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 75
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Velocity = RootPart.CFrame.lookVector * 100
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,.5)
				if ToolType.Value == "Gauntlet" then
				DmgFunction:Fire(Character, hum, 45*Strength.Value/2*ExplosionModeMultiplier)
			else
				DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ExplosionModeMultiplier)
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
			end
		end
			end)
		TweenService:Create(ExplodeModel.Effect, TweenInfo.new(1), {Size = Vector3.new(228, 160, 209),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		--TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(.75), {Color = Color3.fromRGB(80,80,80)}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(171, 158, 177),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(178, 150, 165),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect4, TweenInfo.new(1), {Size = Vector3.new(162, 136, 151),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect5, TweenInfo.new(1), {Size = Vector3.new(163, 148, 166),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Main, TweenInfo.new(1), {Size = Vector3.new(200,200,200)}):Play()
		wait(.4)
		for i,v in pairs(ExplodeModel.Effect.Attachment:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		for i,v in pairs(ChargePart:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		wait(.6)
		ChargePart:Destroy()
		ExplodeModel:Destroy()
		Attack.Value = false
		wait(3)
		SmallExplode = false
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

local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 0 then
	script:Destroy()
end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
wait()
local DashSnd = Instance.new("Sound",RootPart)
DashSnd.SoundId = "rbxassetid://178452221"
DashSnd.Volume = .5
local ChargeSound = Instance.new("Sound",RootPart)
ChargeSound.SoundId = "rbxassetid://163619849"
ChargeSound.Volume = .4
local HitSound = Instance.new("Sound", RootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local EngineLeg = script.EngineLeg
local Shockwave = script.Shockwave
local AnimationsFolder = script.Animations
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block)
local RunAnim = Humanoid:LoadAnimation(AnimationsFolder.Running)
local ChargeAnim = Humanoid:LoadAnimation(AnimationsFolder.Charging)
local ExtendAnim = Humanoid:LoadAnimation(AnimationsFolder.Recipro)
local Kick1Anim = Humanoid:LoadAnimation(AnimationsFolder.kick_1)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local Kick2Anim = Humanoid:LoadAnimation(AnimationsFolder.kick_2)
local HeavyKickAnim = Humanoid:LoadAnimation(AnimationsFolder.HeavyKick)
local LeftLowerLeg = Character:WaitForChild("LeftLowerLeg")
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local EngineDashAnim = Humanoid:LoadAnimation(AnimationsFolder.EngineDash)
local RightLowerLeg = Character:WaitForChild("RightLowerLeg")
local LeftEngine = EngineLeg:Clone()
local Smoke = script.Smoke
local Shift = false
local cantrun = false
local E = false
LeftEngine.Parent = LeftLowerLeg
LeftEngine.Anchored = false
local LeftWeld = Instance.new("Motor6D",LeftEngine)
LeftWeld.Part0 = LeftEngine
LeftWeld.Part1 = LeftLowerLeg
local RightEngine = EngineLeg:Clone()
RightEngine.Parent = RightLowerLeg
RightEngine.Anchored = false
local RightWeld = Instance.new("Motor6D",LeftEngine)
RightWeld.Part0 = RightEngine
RightWeld.Part1 = RightLowerLeg
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
local Run = false
local KickDB = false
local kick = 1
local Charged = false
local Training = false
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Parent = nil
BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerFolder = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Level = PlayerFolder.Level
local Exp = PlayerFolder.Experience
local Strength = PlayerFolder.Strength
local Agility = PlayerFolder.Agility
local Durability = PlayerFolder.Durability
local HeavyChargeBBG = script:WaitForChild("HeavyCharge")
local Recipro = false
local ReciproKick = false
local ReciproBurst = false
local ReciproExtend = false
local Block = false
local HeavyAttack = false
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

local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local ee = script:WaitForChild("E")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local tt = script:WaitForChild("T")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")

local color1 = Color3.new(0, 255, 255)
local color2 = Color3.new(0, 255, 255)
local color3 = Color3.new(255, 255, 255)
local color4 = Color3.new(255, 255, 255)

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

local ReciproMultiplier = 1
ReciproBurstCD = false
vv.OnServerEvent:Connect(function()
	if Agility.Value >= 100 and ReciproBurst == false and ReciproBurstCD == false then
		ReciproBurst = true
		ReciproBurstCD = true
		ReciproMultiplier = 1.2
		cantrun = true
		LeftEngine.Recipro3.Enabled = true
		RightEngine.Recipro3.Enabled = true
		RightEngine.PointLight.Enabled = true
		LeftEngine.PointLight.Enabled = true
		LeftEngine.Trail.Color = ColorSequence.new(color1, color2)
		RightEngine.Trail.Color = ColorSequence.new(color1, color2)
		LeftEngine.ParticleEmitter.Color = ColorSequence.new(color1, color2)
		RightEngine.ParticleEmitter.Color = ColorSequence.new(color1, color2)
		game.Chat:Chat(Character,"RECIPRO".." BURST!","White")
		Shift = false
	RunAnim:Stop()
	Run = false
	BodyVelocity.Parent = nil
	Charged = false
	Humanoid.WalkSpeed = 18
	RightEngine.Smoke.Enabled = false
	LeftEngine.Smoke.Enabled = false
	RightEngine.ParticleEmitter.Enabled = false
	LeftEngine.ParticleEmitter.Enabled = false
	RightEngine.PointLight.Enabled = false
	LeftEngine.PointLight.Enabled = false
	RightEngine.Trail.Enabled = false
	LeftEngine.Trail.Enabled = false
	RightEngine.Recipro.Enabled = false
	LeftEngine.Recipro.Enabled = false
	RightEngine.Glow.Transparency = 1
	LeftEngine.Glow.Transparency = 1
	Recipro = false
	Charged = true
		ChargeAnim:Play()
		RightEngine.Smoke.Enabled = true
		LeftEngine.Smoke.Enabled = true
		Humanoid.WalkSpeed = 6
		ChargeSound:Play()
		for i = 1,20 do
			RightEngine.Glow.Transparency = RightEngine.Glow.Transparency - .04
			LeftEngine.Glow.Transparency = LeftEngine.Glow.Transparency - .04
			if Charged == false then
				break
			end
			wait()
		end
		ChargeAnim:Stop()
		RightEngine.Glow.Transparency = 1
		LeftEngine.Glow.Transparency = 1
		if Charged == true then
			local SW = Shockwave:Clone()
			SW.Parent = RootPart
			SW.CFrame = RootPart.CFrame
			SW.BrickColor = BrickColor.new("Toothpaste")
			DashSnd:Play()
		TweenService:Create(SW,TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(SW,TweenInfo.new(0.5),{Size = Vector3.new(35,10,35)}):Play()
		TweenService:Create(SW,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 10, false, wait()),{Orientation = SW.Orientation + Vector3.new(0,10,0)}):Play()
		game.Debris:AddItem(SW,.5)
			Run = true
			RunAnim:Play()
			local cor = coroutine.wrap(function()
			repeat wait()
			if Humanoid.WalkSpeed ~= 0 then
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 400
			else
			Humanoid.WalkSpeed = 80 + 0.16 * Agility.Value
			end
			end
			until ReciproBurst == false
			end)
			cor()
			RightEngine.Smoke.Enabled = true
			LeftEngine.Smoke.Enabled = true
			RightEngine.Recipro3.Enabled = true
			LeftEngine.Recipro3.Enabled = true
			RightEngine.ParticleEmitter.Enabled = true
			LeftEngine.ParticleEmitter.Enabled = true
			RightEngine.Trail.Enabled = true
			LeftEngine.Trail.Enabled = true
			end
		wait(10)
		ReciproBurst = false
		LeftEngine.Recipro3.Enabled = false
		RightEngine.Recipro3.Enabled = false
		LeftEngine.ParticleEmitter.Color = ColorSequence.new(color3, color4)
		RightEngine.ParticleEmitter.Color = ColorSequence.new(color3, color4)
		Shift = false
	RunAnim:Stop()
	Run = false
	BodyVelocity.Parent = nil
	Charged = false
	RightEngine.Smoke.Enabled = false
	LeftEngine.Smoke.Enabled = false
	RightEngine.ParticleEmitter.Enabled = false
	LeftEngine.ParticleEmitter.Enabled = false
	RightEngine.Trail.Enabled = false
	LeftEngine.Trail.Enabled = false
	RightEngine.Recipro.Enabled = false
	LeftEngine.Recipro.Enabled = false
	RightEngine.Glow.Transparency = 1
	LeftEngine.Glow.Transparency = 1
	Recipro = false
	cantrun = false
		ReciproMultiplier = 1
		LeftEngine.Trail.Color = ColorSequence.new(color3, color4)
		RightEngine.Trail.Color = ColorSequence.new(color3, color4)
		wait()
		Humanoid.WalkSpeed = 18
		wait(15)
		ReciproBurstCD = false
	end
end)

local EngineDash = false
local EngineDashCD = false
cc.OnServerEvent:Connect(function(play,direc)
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and EngineDash == false and Stamina.Value > 30 and EngineDashCD == false then
		Attack.Value = true
		EngineDash = true
		EngineDashCD = true
		Humanoid.AutoRotate = false
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direc.p)
		EngineDashAnim:Play()
		DashSnd:Play()
		local Ef = game.ServerStorage.MuscleShock:Clone()
		Ef.Parent = script
		Ef.CFrame = RootPart.CFrame *CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		game.Debris:AddItem(Ef,0.5)
		TweenService:Create(Ef,TweenInfo.new(0.5),{Transparency = 1, Size = Vector3.new(55,50,55)}):Play()
		local bv = Instance.new("BodyVelocity",RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Name = "EngineDash"
		bv.Velocity = RootPart.CFrame.lookVector * 250
		game.Debris:AddItem(bv, 1)
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(20,20,20)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		game.Debris:AddItem(HitPart,1.5)
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = RootPart
		RightEngine.Smoke.Enabled = true
		LeftEngine.Smoke.Enabled = true
		RightEngine.ParticleEmitter.Enabled = true
		LeftEngine.ParticleEmitter.Enabled = true
		RightEngine.Trail.Enabled = true
		LeftEngine.Trail.Enabled = true
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while wait(0.01) do
				connection = HitPart.Touched:Connect(function() end)
				results = HitPart:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
        						PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									HitSound:Play()
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.7)
									Velocity.Velocity = Vector3.new(0,100,0)
									DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ReciproMultiplier)
									end
								end
							end
							lastresult = results
						end
				end
			end
		end)
		expermentaltouch()
		local coro = coroutine.wrap(function()
		repeat wait() until EngineDash == false
		bv:Destroy()
		EngineDashAnim:Stop()
		Attack.Value = false
		Humanoid.AutoRotate = true
		if ReciproBurst == false then
		Shift = false
	RunAnim:Stop()
	Run = false
	BodyVelocity.Parent = nil
	Charged = false
	Humanoid.WalkSpeed = 18
	RightEngine.Smoke.Enabled = false
	LeftEngine.Smoke.Enabled = false
	RightEngine.ParticleEmitter.Enabled = false
	LeftEngine.ParticleEmitter.Enabled = false
	RightEngine.Trail.Enabled = false
	LeftEngine.Trail.Enabled = false
	RightEngine.Recipro.Enabled = false
	LeftEngine.Recipro.Enabled = false
	RightEngine.Glow.Transparency = 1
	LeftEngine.Glow.Transparency = 1
	Recipro = false
	end
		wait(5)
		EngineDashCD = false
		end)
		coro()
		wait(1)
		if EngineDash == true then
		EngineDash = false
		end
	end
		end)
		
local ReciproExtendCD = false
xx.OnServerEvent:Connect(function()
	if Strength.Value >= 50 and Stamina.Value >= 50 and Attack.Value == false and stunned == false and ReciproExtend == false and ReciproExtendCD == false then
		ReciproExtend = true
		ReciproExtendCD = true
		ExtendAnim:Play()
		wait(0.3)
		local Target 
	local connection	
	connection = LeftEngine.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and ReciproExtend == true then
	connection:Disconnect()
	ReciproExtend = false
	local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
	local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
	Target = hit.Parent
	local ring = Instance.new("Part",script)
	ring.BrickColor = BrickColor.new("Institutional white")
	ring.CanCollide = false
	ring.Transparency = 0
	ring.Anchored = true
    local mesh = Instance.new("SpecialMesh", ring)
    mesh.MeshType = "FileMesh"
    mesh.MeshId = "rbxassetid://3270017"
    mesh.Scale = Vector3.new(1,1,1)
	game.Debris:AddItem(ring,0.5)
	ring.CFrame = HRT.CFrame
	ring.Orientation = Vector3.new(-45,0,0)
	local ring2 = Instance.new("Part",script)
	ring2.BrickColor = BrickColor.new("Institutional white")
	ring2.CanCollide = false
	ring2.Transparency = 0
	ring2.Anchored = true
	game.Debris:AddItem(ring2,0.5)
    local mesh2 = Instance.new("SpecialMesh", ring2)
    mesh2.MeshType = "FileMesh"
    mesh2.MeshId = "rbxassetid://3270017"
    mesh2.Scale = Vector3.new(1,1,1)
	ring2.CFrame = HRT.CFrame
	ring2.Orientation = Vector3.new(45,0,0)
	if HRT:FindFirstChild("Light") == nil then
		Exp.Value = Exp.Value + 100
		HitSound:Play()
		local Velocity = Instance.new("BodyVelocity",HRT)
		Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		Velocity.Name = "Heavy"
		local ObjectVal = Instance.new("ObjectValue",Velocity)
		ObjectVal.Value = RootPart
		ObjectVal.Name = "Hitist"
		game.Debris:AddItem(Velocity,.7)
		Velocity.Velocity = Vector3.new(0,100,0)
		DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ReciproMultiplier)
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
			TweenService:Create(mesh,TweenInfo.new(0.5),{Scale = Vector3.new(21,21,21)}):Play()
			TweenService:Create(mesh2,TweenInfo.new(0.5),{Scale = Vector3.new(21,21,21)}):Play()
			TweenService:Create(ring,TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(ring2,TweenInfo.new(0.5),{Transparency = 1}):Play()
			wait(0.5)
			Humanoid.WalkSpeed = 0
			Humanoid.JumpPower = 0
			ChargeAnim:Play()
			ChargeSound:Play()
			game.Chat:Chat(Character,"Recipro...","White")
			local hum = Target:FindFirstChild("Humanoid")
			local HRT = Target:FindFirstChild("HumanoidRootPart")
			RightEngine.Smoke.Enabled = true
			LeftEngine.Smoke.Enabled = true
			RightEngine.Trail.Enabled = true
			LeftEngine.Trail.Enabled = true
			LeftEngine.Recipro2.Enabled = true
			RightEngine.Recipro2.Enabled = true
			RightEngine.PointLight.Enabled = true
		    LeftEngine.PointLight.Enabled = true
			LeftEngine.Trail.Color = ColorSequence.new(color1, color2)
			RightEngine.Trail.Color = ColorSequence.new(color1, color2)
			wait(.7)
			DashSnd:Play()
			local SW = Shockwave:Clone()
			SW.Parent = RootPart
			SW.CFrame = RootPart.CFrame
			SW.BrickColor = BrickColor.new("Toothpaste")
			local TriRing = game.ServerStorage.TriRing:Clone()
			TriRing.CFrame = RootPart.CFrame*CFrame.new(0,5,0)
			TriRing.Parent = script
			TriRing.BrickColor = BrickColor.new("Toothpaste")
			TriRing.Orientation = Vector3.new(90,0,0)
			DashSnd:Play()
			TweenService:Create(TriRing,TweenInfo.new(1),{Transparency = 1}):Play()
			TweenService:Create(TriRing.Mesh,TweenInfo.new(1),{Scale = Vector3.new(7.5,7.5,7.5)}):Play()
			TweenService:Create(SW,TweenInfo.new(1),{Transparency = 1}):Play()
			TweenService:Create(SW,TweenInfo.new(1),{Size = Vector3.new(75,10,75)}):Play()
			TweenService:Create(SW,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 25, false, wait()),{Orientation = SW.Orientation + Vector3.new(0,10,0)}):Play()
			game.Debris:AddItem(SW,1)
			game.Debris:AddItem(TriRing,1)
			wait()
			HRT.Anchored = true
			RootPart.Anchored = true
			local SafeTp = Instance.new("NumberValue",Character)
			SafeTp.Name = "SafeTp"
			game.Debris:AddItem(SafeTp,.5)
			RootPart.CFrame = HRT.CFrame * CFrame.new(0,0,3)
			wait(.1)
			ChargeAnim:Stop()
			Kick1Anim:Play()
			game.Chat:Chat(Character,"EXTEND!","White")
			wait(.5)
			if HRT:FindFirstChild("Light") == nil then
				Exp.Value = Exp.Value + 150
				DmgFunction:Fire(Character, hum, 30*Strength.Value/2*ReciproMultiplier)
				HitSound:Play()
				HRT.Anchored = false
				RootPart.Anchored = false
        		local Velocity = Instance.new("BodyVelocity",HRT)
				Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				Velocity.Velocity = RootPart.CFrame.lookVector * 120
				game.Debris:AddItem(Velocity,2)
				Velocity.Name = "Heavy"
				local ObjectVal = Instance.new("ObjectValue",Velocity)
				ObjectVal.Value = RootPart
				ObjectVal.Name = "Hitist"
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
			RightEngine.Smoke.Enabled = false
			LeftEngine.Smoke.Enabled = false
			RightEngine.Trail.Enabled = false
			LeftEngine.Trail.Enabled = false
			LeftEngine.Recipro2.Enabled = false
			RightEngine.Recipro2.Enabled = false
		 	RightEngine.PointLight.Enabled = false
		    LeftEngine.PointLight.Enabled = false
			LeftEngine.Trail.Color = ColorSequence.new(color3, color4)
			RightEngine.Trail.Color = ColorSequence.new(color3, color4)
			HRT.Anchored = false
			RootPart.Anchored = false 
			wait(1.1)
			Humanoid.WalkSpeed = 18
			Humanoid.JumpPower = 50
			cantrun = false
			end
		end
	end)
wait(0.7)
ReciproExtend = false
wait(5)
ReciproExtendCD = false
end
end)

zz.OnServerEvent:Connect(function(player,part)
	if Strength.Value >= 25 and Stamina.Value >= 50 and Attack.Value == false and stunned == false and ReciproKick == false and (RootPart.CFrame.p-part.Position).Magnitude <= 200 and part.Parent.Humanoid.Health > 0 then
		Stamina.Value = Stamina.Value - 50 
		cantrun = true
		Attack.Value = true
		ReciproKick = true
		local Target = part.Parent
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		ChargeAnim:Play()
		ChargeSound:Play()
		game.Chat:Chat(Character,"Recipro...","White")
		local hum = Target:FindFirstChild("Humanoid")
		local HRT = Target:FindFirstChild("HumanoidRootPart")
			RightEngine.Smoke.Enabled = true
			LeftEngine.Smoke.Enabled = true
			RightEngine.Trail.Enabled = true
			LeftEngine.Trail.Enabled = true
			LeftEngine.Recipro2.Enabled = true
			RightEngine.Recipro2.Enabled = true
			RightEngine.PointLight.Enabled = true
		    LeftEngine.PointLight.Enabled = true
			LeftEngine.Trail.Color = ColorSequence.new(color1, color2)
		RightEngine.Trail.Color = ColorSequence.new(color1, color2)
		wait(.7)
		DashSnd:Play()
		local SW = Shockwave:Clone()
			SW.Parent = RootPart
			SW.CFrame = RootPart.CFrame
			SW.BrickColor = BrickColor.new("Toothpaste")
			DashSnd:Play()
		TweenService:Create(SW,TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(SW,TweenInfo.new(0.5),{Size = Vector3.new(35,10,35)}):Play()
		TweenService:Create(SW,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 10, false, wait()),{Orientation = SW.Orientation + Vector3.new(0,10,0)}):Play()
		game.Debris:AddItem(SW,0.5)   
		wait()
		local SafeTp = Instance.new("NumberValue",Character)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,.5)
		RootPart.CFrame = HRT.CFrame * CFrame.new(0,0,3)
				wait(.1)
				ChargeAnim:Stop()
				Kick1Anim:Play()
		game.Chat:Chat(Character,"Kick!","White")
		wait(.5)
		if HRT:FindFirstChild("Light") == nil then
		Exp.Value = Exp.Value + 150
		DmgFunction:Fire(Character, hum, 60*Strength.Value/2*ReciproMultiplier)
		HitSound:Play()
        local Velocity = Instance.new("BodyVelocity",HRT)
				Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				Velocity.Velocity = RootPart.CFrame.lookVector * 120
				game.Debris:AddItem(Velocity,2)
				Velocity.Name = "Heavy"
				local ObjectVal = Instance.new("ObjectValue",Velocity)
				ObjectVal.Value = RootPart
				ObjectVal.Name = "Hitist"
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
		RightEngine.Smoke.Enabled = false
			LeftEngine.Smoke.Enabled = false
			RightEngine.Trail.Enabled = false
			LeftEngine.Trail.Enabled = false
			LeftEngine.Recipro2.Enabled = false
			RightEngine.Recipro2.Enabled = false
		 	RightEngine.PointLight.Enabled = false
		    LeftEngine.PointLight.Enabled = false
			LeftEngine.Trail.Color = ColorSequence.new(color3, color4)
		RightEngine.Trail.Color = ColorSequence.new(color3, color4)
		wait(1.1)
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		cantrun = false
		wait(10)
		ReciproKick = false
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

qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 20 then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 20
		HeavyKickAnim:Play()
		local BBG = HeavyChargeBBG:Clone()
		BBG.Parent = RootPart
		TweenService:Create(BBG,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 20, false, wait()),{Size = BBG.Size - UDim2.new(1,0,1,0)}):Play()
		game.Debris:AddItem(BBG,0.75)
		HeavyAttack = true
		local PlayersHitted = {}
		local expermentaltouch1 = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while wait(0.01) do
				if LeftEngine == nil then
					break
				end
				connection = LeftEngine.Touched:Connect(function() end)
				results = LeftEngine:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								if HRT:FindFirstChild("Heavy") == nil then
									HeavyAttack = false
									Exp.Value = Exp.Value + 130
									HitSound:Play()
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(20000,20000,20000)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,2)
									DmgFunction:Fire(Character, hum, 40*Strength.Value/2*ReciproMultiplier)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
									end
								end 
							end
						end 
					end
				lastresult = results
				end
			end
		end)
		expermentaltouch1()
		wait(0.75)
		if ReciproBurst == false then
		Shift = false
	RunAnim:Stop()
	Run = false
	BodyVelocity.Parent = nil
	Charged = false
	Humanoid.WalkSpeed = 18
	RightEngine.Smoke.Enabled = false
	LeftEngine.Smoke.Enabled = false
	RightEngine.ParticleEmitter.Enabled = false
	LeftEngine.ParticleEmitter.Enabled = false
	RightEngine.Trail.Enabled = false
	LeftEngine.Trail.Enabled = false
	RightEngine.Recipro.Enabled = false
	LeftEngine.Recipro.Enabled = false
	RightEngine.Glow.Transparency = 1
	LeftEngine.Glow.Transparency = 1
	Recipro = false
	end
	end
end)

sd.OnServerEvent:Connect(function()
	Shift = true
	if Charged == false and stunned == false and Stamina.Value > 1 and cantrun == false and ReciproBurst == false then
		Charged = true
		ChargeAnim:Play()
		RightEngine.Smoke.Enabled = true
		LeftEngine.Smoke.Enabled = true
		Humanoid.WalkSpeed = 6
		ChargeSound:Play()
		for i = 1,20 do
			RightEngine.Glow.Transparency = RightEngine.Glow.Transparency - .04
			LeftEngine.Glow.Transparency = LeftEngine.Glow.Transparency - .04
			if Charged == false then
				break
			end
			wait()
		end
		ChargeAnim:Stop()
		RightEngine.Glow.Transparency = 1
		LeftEngine.Glow.Transparency = 1
		if Charged == true then
			local SW = Shockwave:Clone()
			SW.Parent = RootPart
			SW.CFrame = RootPart.CFrame
			DashSnd:Play()
			local Corot = coroutine.wrap(function()
				while wait(0.1) do
					Stamina.Value = Stamina.Value - 2
					if Stamina.Value < 2 or Run == false then
						break
					end
				end
			end)
			Corot()
			TweenService:Create(SW,TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(SW,TweenInfo.new(0.5),{Size = Vector3.new(35,10,35)}):Play()
			TweenService:Create(SW,TweenInfo.new(0,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 10, false, wait()),{Orientation = SW.Orientation + Vector3.new(0,10,0)}):Play()
			game.Debris:AddItem(SW,0.5)
			Run = true
			RunAnim:Play()
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 240
			else
			Humanoid.WalkSpeed = 80 + 0.08 * Agility.Value
			end
			RightEngine.Smoke.Enabled = true
			LeftEngine.Smoke.Enabled = true
			RightEngine.ParticleEmitter.Enabled = true
			LeftEngine.ParticleEmitter.Enabled = true
			RightEngine.Trail.Enabled = true
			LeftEngine.Trail.Enabled = true
		end
	end
end)

su.OnServerEvent:Connect(function()
	if cantrun == false and ReciproBurst == false then
	Shift = false
	RunAnim:Stop()
	Run = false
	BodyVelocity.Parent = nil
	Charged = false
	Humanoid.WalkSpeed = 18
	RightEngine.Smoke.Enabled = false
	LeftEngine.Smoke.Enabled = false
	RightEngine.ParticleEmitter.Enabled = false
	LeftEngine.ParticleEmitter.Enabled = false
	RightEngine.Trail.Enabled = false
	LeftEngine.Trail.Enabled = false
	RightEngine.Recipro.Enabled = false
	LeftEngine.Recipro.Enabled = false
	RightEngine.Glow.Transparency = 1
	LeftEngine.Glow.Transparency = 1
	Recipro = false
	end
end)


ee.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 10 then
		local PlayersHitted = {}
		local expermentaltouch1 = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while wait(0.01) do
				if LeftEngine == nil then
					break
				end
				connection = LeftEngine.Touched:Connect(function() end)
				results = LeftEngine:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
									if HRT:FindFirstChild("Light") == nil and hum.Health > 0 then
										KickDB = false
										Exp.Value = Exp.Value + 50
										HitSound:Play()
										local Velocity = Instance.new("BodyVelocity",HRT)
										Velocity.MaxForce = Vector3.new(10000,10000,10000)
										Velocity.Name = "Light"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,.5)
										if Run == false then
										DmgFunction:Fire(Character, hum, 20*Strength.Value/2*ReciproMultiplier)
										end
									end
								end 
							end
						end 
					end
				lastresult = results
				end
			end
		end)
		expermentaltouch1()
		Attack.Value = true
		Stamina.Value = Stamina.Value - 10
		KickDB = true
		if kick == 1 then
			Kick1Anim:Play()
			kick = 2
		elseif kick == 2 then
			Kick2Anim:Play()
			kick = 1
		end
		LeftEngine.Trail.Enabled = true
	end
end)


Kick1Anim.Stopped:Connect(function()
	Attack.Value = false
	KickDB = false
	if Run == false then
		LeftEngine.Trail.Enabled = false
	end
end)

Kick2Anim.Stopped:Connect(function()
	Attack.Value = false
	KickDB = false
	if Run == false then
		LeftEngine.Trail.Enabled = false
	end
end)

HeavyKickAnim.Stopped:Connect(function()
	Attack.Value = false
	Humanoid.WalkSpeed = 18
	Humanoid.JumpPower = 50
	HeavyAttack = false
end)

		
		
local Coro = coroutine.wrap(function()
	while wait() do
		if not Character:FindFirstChild("Safezone") and Block == false then
		if RootPart:FindFirstChild("Light") and stunned == false then
		elseif RootPart:FindFirstChild("Heavy") and stunned == false and ReciproBurst == false then
			stunned = true
			local asdfg = false
			Attack.Value = true
			KickDB = false
			HeavyAttack = false
			Kick1Anim:Stop()
			Kick2Anim:Stop()
			if Charged == true then
				RunAnim:Stop()
				Run = false
				BodyVelocity.Parent = nil
				Charged = false
				RightEngine.Smoke.Enabled = false
				LeftEngine.Smoke.Enabled = false
				RightEngine.ParticleEmitter.Enabled = false
				LeftEngine.ParticleEmitter.Enabled = false
				RightEngine.Trail.Enabled = false
				LeftEngine.Trail.Enabled = false
			end
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

while wait() do
	Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
	if Humanoid.Health == Humanoid.MaxHealth then
		Humanoid.MaxHealth = 150+150*Durability.Value
		Humanoid.Health = Humanoid.MaxHealth
	else
		Humanoid.MaxHealth = 150+150*Durability.Value
	end
	if Run == true then
		if Torsovelocity < 1 and ReciproBurst == false or Stamina.Value < 2 and ReciproBurst == false then
			Run = false
			RunAnim:Stop()
			Charged = false
			Humanoid.WalkSpeed = 18
			RightEngine.Smoke.Enabled = false
			LeftEngine.Smoke.Enabled = false
			RightEngine.ParticleEmitter.Enabled = false
			LeftEngine.ParticleEmitter.Enabled = false
			RightEngine.Trail.Enabled = false
			LeftEngine.Trail.Enabled = false
		end
	end
end

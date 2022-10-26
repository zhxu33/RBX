local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina     = script.Parent.Stamina
local MaxStamina  = script.Parent.MaxStamina
local Target      = nil
local Damage      = 75000
local Stunned     = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim   = {2313015622,2313016464,2313017174,2313014821}
local AnimationsFolder      = Character.Animations
local WingIdleAnim          = Humanoid:LoadAnimation(AnimationsFolder.WingIdle)
local FeatherFlurryAnim     = Humanoid:LoadAnimation(AnimationsFolder.FeatherFlurry)
local FeatherAttackAnim     = Humanoid:LoadAnimation(AnimationsFolder.FeatherAttack)
local WingFeatherAttackAnim = Humanoid:LoadAnimation(AnimationsFolder.WingFeatherAttack)
local FeatherRainAnim       = Humanoid:LoadAnimation(AnimationsFolder.FeatherRain)
local WingFeatherRainAnim   = Humanoid:LoadAnimation(AnimationsFolder.WingFeatherRain)
local FeatherBladeAnim      = Humanoid:LoadAnimation(AnimationsFolder.FeatherBlade)
local WingFeatherBladeAnim   = Humanoid:LoadAnimation(AnimationsFolder.WingFeatherBlade)
local TrackingFeatherAnim    = Humanoid:LoadAnimation(AnimationsFolder.TrackingFeather)
local ForwardFlightAnim      = Humanoid:LoadAnimation(AnimationsFolder.ForwardFlight)
local ForwardFlightWingAnim  = Humanoid:LoadAnimation(AnimationsFolder.ForwardFlightWing)
local BackwardFlightAnim     = Humanoid:LoadAnimation(AnimationsFolder.BackwardFlight)
local BackwardFlightWingAnim = Humanoid:LoadAnimation(AnimationsFolder.BackwardFlightWing)
local RightFlightAnim        = Humanoid:LoadAnimation(AnimationsFolder.RightFlight)
local RightFlightWingAnim    = Humanoid:LoadAnimation(AnimationsFolder.RightFlightWing)
local LeftFlightAnim         = Humanoid:LoadAnimation(AnimationsFolder.LeftFlight)
local LeftFlightWingAnim     = Humanoid:LoadAnimation(AnimationsFolder.LeftFlightWing)
local FlightIdleAnim         = Humanoid:LoadAnimation(AnimationsFolder.FlightIdle)
local FlightIdleWingAnim     = Humanoid:LoadAnimation(AnimationsFolder.FlightIdleWing)
local HvyStunnedAnim         = Humanoid:LoadAnimation(script.heavystunned)
local Stun          = Humanoid:LoadAnimation(script.stunned)
local TweenService  = game:GetService("TweenService")
local HellFlameMode = false
local Supa1     = false
local Supa2     = false
local Supa3     = false
local Supapoo   = false
local SupaType  = 1
local WalkSpeed = 125
local Assets    = game:GetService("ServerStorage").QuirkAssets.FierceWings

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
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 50 then
		Humanoid.WalkSpeed = 50
	end
end)

local FierceWing = script:WaitForChild("FierceWing")
FierceWing.weld.UpperTorso.Part0 = Character.UpperTorso
WingIdleAnim:Play()
local FeatherBlades = script:WaitForChild("FeatherBlades")
FeatherBlades.Left.handle.LeftHand.Part0   = Character.LeftHand
FeatherBlades.Right.handle.RightHand.Part0 = Character.RightHand

for i,v in pairs(FeatherBlades.Left:GetChildren()) do
	v.Transparency = 1
end
for i,v in pairs(FeatherBlades.Right:GetChildren()) do
	v.Transparency = 1
end

local function CreateSupa1()
	local BV = Instance.new("BodyVelocity", HumanoidRootPart)
	BV.MaxForce = Vector3.new(0,math.huge,0)
	BV.Velocity = Vector3.new(0,100,0)
	game.Debris:AddItem(BV, .5)
	FeatherRainAnim:Play()
	WingFeatherRainAnim:Play()
	task.delay(.2, function()
		for i=1, 4 do 
			wait(0.1)
			local FeatherBladeShock = Assets.FeatherBladeShock:Clone()
			FeatherBladeShock.Position = HumanoidRootPart.Position + Vector3.new(0,25,0) 
			FeatherBladeShock.CFrame = FeatherBladeShock.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			FeatherBladeShock.Parent = script
			TweenService:Create(FeatherBladeShock, TweenInfo.new(0.5), {Size = Vector3.new(350,75,350), Transparency = 1}):Play()
			game.Debris:AddItem(FeatherBladeShock, .5)
		end
	end)

	wait(.5)
	local PlayersHitted = {}
	local RealHB = Instance.new("Part", script)
	RealHB.Name = "Feather"
	RealHB.Anchored = true
	RealHB.CanCollide = false
	RealHB.Transparency = 1
	RealHB.Size = Vector3.new(50,50,50)
	RealHB.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,25,0)
	TweenService:Create(RealHB,TweenInfo.new(.75),{Size = Vector3.new(350,50,350)}):Play()
	game.Debris:AddItem(RealHB,2)

	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while wait(0.1) and RealHB.Parent do
			connection = RealHB.Touched:Connect(function() end)
			results    = RealHB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" then
						if PlayersHitted[results[i].Parent] ~= nil then
						else
							PlayersHitted[results[i].Parent] = results[i].Parent
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if HRT:FindFirstChild("Light") == nil and hum.Health > 0 then
								local FeatherBladeShock = Assets.FeatherBladeShock:Clone()
								FeatherBladeShock.CFrame = HRT.CFrame*CFrame.new(0,10,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
								FeatherBladeShock.Parent = script
								TweenService:Create(FeatherBladeShock, TweenInfo.new(0.5), {Size = Vector3.new(100,50,100), Transparency = 1}):Play()
								game.Debris:AddItem(FeatherBladeShock, .5)
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.Name = "Heavy"
								Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								game.Debris:AddItem(Velocity,1)
								DmgFunction:Fire(Character, hum, Damage*2)
							end
						end
					end
					lastresult = results
				end
			end
		end
	end)

	for amt = 1, 3 do
		for i = 1,8 do
			local HB = Assets.FeatherModel3:Clone()
			HB.CFrame = CFrame.new(HumanoidRootPart.Position)*CFrame.Angles(math.rad(0),math.rad((i-1)*math.random(45,55)),math.rad(0))*CFrame.new(0,math.random(10,30),-(amt*15))
			local Velo = Instance.new("BodyVelocity", HB)
			Velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			if amt == 1 then
				Velo.Velocity = HB.CFrame.lookVector *math.random(250,375)
			elseif amt == 2 then
				Velo.Velocity = HB.CFrame.lookVector *math.random(125,250)
			elseif amt == 3 then
				Velo.Velocity = HB.CFrame.lookVector *math.random(1,125)
			end
			game.Debris:AddItem(HB, 2)
			game.Debris:AddItem(Velo, 1.5)
			task.spawn(function()
				wait(.75)
				if HB then
					HB.CFrame = HB.CFrame*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
					Velo.Velocity = HB.CFrame.lookVector * 250
				end
			end)
			HB.Parent = script
		end
	end
	wait(.75)
	TweenService:Create(RealHB,TweenInfo.new(1.25),{Position =  RealHB.Position - Vector3.new(0,250,0)}):Play()
	wait(2)
end

local function CreateSupa2()
	FeatherFlurryAnim:Play()
	wait(.15)
	task.spawn(function()
		for i=1 , 4 do 
			wait(.1)
			local FeatherBladeShock = Assets.FeatherBladeShock:Clone()
			FeatherBladeShock.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			FeatherBladeShock.Parent = script
			TweenService:Create(FeatherBladeShock, TweenInfo.new(0.5), {CFrame = FeatherBladeShock.CFrame*CFrame.new(0,25,0), Size = Vector3.new(300,75,300), Transparency = 1}):Play()
			game.Debris:AddItem(FeatherBladeShock, .5)
		end
	end)

	local PlayersHitted = {}
	local RealHB = Instance.new("Part", script)
	RealHB.Name = "Feather"
	RealHB.Anchored = true
	RealHB.CanCollide = false
	RealHB.Transparency = 1
	RealHB.Size = Vector3.new(50,75,50)
	RealHB.CFrame = HumanoidRootPart.CFrame
	TweenService:Create(RealHB,TweenInfo.new(.75),{Size = Vector3.new(200,75,200)}):Play()
	game.Debris:AddItem(RealHB,.75)

	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while wait(0.1) and RealHB.Parent do
			connection = RealHB.Touched:Connect(function() end)
			results    = RealHB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" then
						if PlayersHitted[results[i].Parent] ~= nil then
						else
							PlayersHitted[results[i].Parent] = results[i].Parent
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if HRT:FindFirstChild("Light") == nil and hum.Health > 0 then
								local FeatherBladeShock = Assets.FeatherBladeShock:Clone()
								FeatherBladeShock.CFrame = HRT.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
								FeatherBladeShock.Parent = script
								TweenService:Create(FeatherBladeShock, TweenInfo.new(0.5), {Size = Vector3.new(100,50,100), Transparency = 1}):Play()
								game.Debris:AddItem(FeatherBladeShock, .5)
								HitSound:Play()
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.Name = "Heavy"
								Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								game.Debris:AddItem(Velocity,.75)
								DmgFunction:Fire(Character, hum, Damage*1.5)
							end
						end
					end
					lastresult = results
				end
			end
		end
	end)

	for i = 1,17 do
		local HB      = Assets.FeatherModel:Clone()
		HB.CFrame     = HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad((i-1)*22.5),math.rad(0))*CFrame.new(0,0,-10)
		local Velo    = Instance.new("BodyVelocity", HB)
		Velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		Velo.Velocity = HB.CFrame.lookVector*200
		HB.Parent     = script
		game.Debris:AddItem(HB,.75)
	end
	wait(1.5)
end

local function CreateSupa3()
	FeatherAttackAnim:Play()
	WingFeatherAttackAnim:Play()
	local Gyro = Instance.new("BodyGyro",HumanoidRootPart)
	Gyro.MaxTorque = Vector3.new(0,0,0)
	Gyro.D = 100
	Gyro.P = 100000
	wait(.25)
	for i = 1, 8 do
		if not Target or not Target.Parent then break end
		wait(.1)
		Gyro.CFrame = CFrame.new(HumanoidRootPart.Position, Target.Position)
		Gyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		local FeatherBladeShock = Assets.FeatherBladeShock:Clone()
		FeatherBladeShock.CFrame = CFrame.new(HumanoidRootPart.Position, Target.Position)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		FeatherBladeShock.Parent = script
		TweenService:Create(FeatherBladeShock, TweenInfo.new(0.5), {Size = Vector3.new(200,75,200), Transparency = 1}):Play()
		game.Debris:AddItem(FeatherBladeShock, .5)
		local HB = Assets.FeatherModel2:Clone()
		HB.CFrame = CFrame.new(HumanoidRootPart.Position, Target.Position)
		local Velo = Instance.new("BodyVelocity", HB)
		Velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		Velo.Velocity = HB.CFrame.lookVector*300
		game.Debris:AddItem(HB, 1.5)
		HB.Parent = script
		local PlayersHitted = {}
		
		task.spawn(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while wait() and HB.Parent do
				
				connection = HB.Touched:Connect(function() end)
				results = HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" then
							if PlayersHitted[results[i].Parent] ~= nil then
							else
								PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								if HRT:FindFirstChild("Light") == nil and hum.Health > 0 then
									local FeatherBladeShock = Assets.FeatherBladeShock:Clone()
									FeatherBladeShock.CFrame = HB.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
									FeatherBladeShock.Parent = script
									TweenService:Create(FeatherBladeShock, TweenInfo.new(0.5), {Size = Vector3.new(100,50,100), Transparency = 1}):Play()
									game.Debris:AddItem(FeatherBladeShock, .5)
									HitSound:Play()
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Heavy"
									Velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
									Velocity.Velocity = HB.CFrame.lookVector*100	
									game.Debris:AddItem(Velocity,.2)
									DmgFunction:Fire(Character, hum, Damage/4)
								end
							end
						end
						lastresult = results
					end
				end
			end
		end)
	end
	Gyro:Destroy()
	wait(1.5)
end

task.spawn(function()
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and Stunned == false then
			if SupaType == 1 then
				SupaType = 2
				CreateSupa1()
			elseif SupaType == 2 then
				SupaType = 3
				CreateSupa2()
			elseif SupaType == 3 then
				SupaType = 1
				CreateSupa3()
			end
		end
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			CombatType += 1
			if CombatType > 4 then CombatType = 1 end
		end
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		task.spawn(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,Character.Name)
			end
		end)
	end
end)

local Walking = false
while task.wait(.5) do
	pcall(function()
		if (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		end
		if Target == nil then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
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
		elseif Target.Parent == nil then 
			Target = nil
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
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, Target.Position)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						return
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
		end
	end)
end
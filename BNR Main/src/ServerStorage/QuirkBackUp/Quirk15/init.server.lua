local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 15 then
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
local FireBallChargeAnim = Humanoid:LoadAnimation(AnimationsFolder.FireBallCharge)
local FireBallThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.FireBallThrow)
local FlameThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.FlameThrow) 
local HellBeamAnim = Humanoid:LoadAnimation(AnimationsFolder.HellBeam) 
local FlamePunchAnim = Humanoid:LoadAnimation(AnimationsFolder.FlamePunch) 
local JetBurnAnim = Humanoid:LoadAnimation(AnimationsFolder.JetBurn)
local HellSpiderAnim = Humanoid:LoadAnimation(AnimationsFolder.HellSpider)
local ThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.Throw) 
local FlightAnim = Humanoid:LoadAnimation(AnimationsFolder.Flight) 
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
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
local FlameSpear = false
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
local DmgFunction = game.ReplicatedStorage:FindFirstChild("DamageFunction")
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

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local xup = script:WaitForChild("XUP")
local cc = script:WaitForChild("C")
local cup = script:WaitForChild("CUP")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")
local qq = script:WaitForChild("Q")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local Space = script:WaitForChild("Space")

local HellFlameMode = false
local HellFlameModeCD = false
local HellFlameModeMultiplier = 1
ff.OnServerEvent:Connect(function()
	if Agility.Value >= 250 and HellFlameMode == false and HellFlameModeCD == false then
	HellFlameMode = true
	HellFlameModeCD = true
	HellFlameModeMultiplier = 1.2
	local Light = game.ServerStorage.HellFlameLight:Clone()
	Light.Parent = Character.UpperTorso
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("MeshPart") or v.Name == "Head" then
			local PE = game.ServerStorage.HellFlameFire:Clone()
			PE.Parent = v
			local PE2 = game.ServerStorage.HellFlameFire2:Clone()
			PE2.Parent = v
			local PE3 = game.ServerStorage.HellFlameFire3:Clone()
			PE3.Parent = v
		end
	end
	repeat wait(.1) 
	Stamina.Value = Stamina.Value - 2.5
	until HellFlameMode == false or Stamina.Value < 2.5
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("MeshPart") or v.Name == "Head" then
			v:FindFirstChild("HellFlameFire"):Destroy()
			v:FindFirstChild("HellFlameFire2"):Destroy()
			v:FindFirstChild("HellFlameFire3"):Destroy()
		end
	end
	HellFlameModeMultiplier = 1
	Character.UpperTorso:FindFirstChild("HellFlameLight"):Destroy()
	wait(5)
	HellFlameModeCD = false
	elseif HellFlameMode == true then
		HellFlameMode = false
	end
end)

local ult = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and ult == false then
	HellBeamAnim:Play()
	Attack.Value = true
	Stamina.Value = Stamina.Value - 60
	ult = true
	RootPart.Anchored = true
	cantrun = true
	Humanoid.AutoRotate = false
	Humanoid.WalkSpeed = 0
	Humanoid.JumpPower = 0
	for i,v in pairs(Character:GetChildren()) do
	if v.Name == "LeftFoot" or v.name == "LeftHand" or v.Name == "LeftUpperArm" or v.Name == " LeftUpperLeg" or v.Name == "RightFoot" or v.Name == "RightUpperLeg"
	or v.Name == "RightUpperArm" or v.Name == "UpperTorso" or v.Name == "Head" then
	local Pe1 = game.ServerStorage.HellFlameULT:Clone()
	Pe1.Parent = v
	local Pe2 = game.ServerStorage.HellFlameULT2:Clone()
	Pe2.Parent = v
	game.Debris:AddItem(Pe1, 3)
	game.Debris:AddItem(Pe2, 3)
	end
	end
	wait(.3)
	local PModel = game.ServerStorage.HellFlameBeam:Clone()
	PModel.Parent = script
	PModel:SetPrimaryPartCFrame(RootPart.CFrame)
	local PBeam = PModel.PBBeam
	local PBeam2 = PModel.PBBeam2
	local PBeam3 = PModel.PBBeam3
	local newhit = Instance.new("Part", PModel)
	newhit.Anchored = true
	newhit.CanCollide = false
	newhit.Transparency = 1
	newhit.Size = PBeam.Size
	newhit.CFrame = PBeam.CFrame
	local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if newhit == nil then
					break
				end
				connection = newhit.Touched:Connect(function() end)
				results = newhit:GetTouchingParts()
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
								local ExplodeModel = game.ServerStorage.HellFlameExplosion:Clone()
								ExplodeModel.Parent = script
								ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)
								game.Debris:AddItem(ExplodeModel,1.25)
								TweenService:Create(ExplodeModel.DMG, TweenInfo.new(1.25), {Size = ExplodeModel.DMG.Size + Vector3.new(40,40,40)}):Play()
								TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(100,100,100)}):Play()
								TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(60,60,60)}):Play()
		    					DmgFunction:Fire(Character, hum, 75*Strength.Value/2*HellFlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 150
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
									Velocity.Name = "Heavy"
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
				wait(0.01)
			end
		end)
		expermentaltouch()
	TweenService:Create(newhit, TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(12,240,12)}):Play()	
TweenService:Create(PBeam, TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(12,240,12)}):Play()
TweenService:Create(PBeam2, TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(24,240,24)}):Play()
TweenService:Create(PBeam3, TweenInfo.new(1.5), {CFrame = PBeam.CFrame * CFrame.new(0,120,0), Size = PBeam.Size + Vector3.new(18,240,18)}):Play()
	local coo = coroutine.wrap(function()
	repeat wait()
	PModel.PBstart.CFrame= PModel.PBstart.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(15))
	PModel.PBstart2.CFrame= PModel.PBstart2.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(15))
	until Attack.Value == false or PModel == nil 
	end)
	coo()
	wait(1.5)
	for i,v in pairs(PBeam:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	TweenService:Create(PBeam, TweenInfo.new(1), {Transparency = 1}):Play()
	TweenService:Create(PBeam2, TweenInfo.new(1), {Transparency = 1}):Play()
	TweenService:Create(PBeam3, TweenInfo.new(1), {Transparency = 1}):Play()
	wait(1)
	HellBeamAnim:Stop()
	Humanoid.AutoRotate = true
	Attack.Value = false
	PModel:Destroy()
	RootPart.Anchored = false
	cantrun = false
	Humanoid.WalkSpeed = 18
	Humanoid.JumpPower = 50
	wait(5)
	ult = false
	end
end)

zz.OnServerEvent:Connect(function(play,direction)
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and FlameSpear == false and Stamina.Value > 75 then
		RootPart.Anchored = true
		cantrun = true
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		FlameSpear = true
		Attack.Value = true
		Stamina.Value = Stamina.Value - 75
		Humanoid.AutoRotate = false
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		local Clone = game.ServerStorage.FlameSpear:Clone()
		Clone.Parent = script
		game.Debris:AddItem(Clone, 3.5)
		local Weld = Instance.new("Weld",Clone)
		Weld.Part0 = Clone
		Weld.Part1 = Character.RightHand
		ThrowAnim:Play()
	 	wait(.5)
		RootPart.Anchored = false
		cantrun = false
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		for i,v in pairs(Clone:GetChildren()) do
			if v:IsA("Trail") then
				v.Enabled = true
			end
		end
		Attack.Value = false
		Weld:Destroy()
		Clone.CFrame = CFrame.new(RootPart.Position,Vector3.new(direction.p.X, direction.p.Y, direction.p.Z))
		Humanoid.AutoRotate = true
		local bv = Instance.new("BodyVelocity", Clone)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = direction.lookVector * 150
wait(.25)
			local PlayersHitted = {}
Clone.Touched:connect(function(hitto)
if hitto.Parent.Name ~= Player.Name then
Clone.Anchored = true
local cframe = Clone.CFrame
Clone:Destroy()
local ExplodeModel = game.ServerStorage.HellFlameExplosion:Clone()
ExplodeModel.Parent = script
ExplodeModel:SetPrimaryPartCFrame(cframe)
game.Debris:AddItem(ExplodeModel,1.25)
TweenService:Create(ExplodeModel.DMG, TweenInfo.new(1.25), {Size = ExplodeModel.DMG.Size + Vector3.new(40,40,40)}):Play()
TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(100,100,100)}):Play()
TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(60,60,60)}):Play()
local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if ExplodeModel == nil or ExplodeModel:FindFirstChild("DMG") == nil then
					break
				end
				connection = ExplodeModel.DMG.Touched:Connect(function() end)
				results = ExplodeModel.DMG:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil then
         					else
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, 55*Strength.Value/2*HellFlameModeMultiplier)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 100
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								Velocity.Name = "Heavy"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,1)
								Velocity.Velocity = RootPart.CFrame.lookVector * 100
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
						end
			end)
		wait(4)
		FlameSpear = false
	end
end)

local HellFireBall = false
local HellFireBallCD = false
xx.OnServerEvent:Connect(function(play,direction)
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value > 100 and HellFireBall == false and HellFireBallCD == false then
		HellFireBall = true
		HellFireBallCD = true
		Stamina.Value = Stamina.Value - 100
		FireBallChargeAnim:Play()
		local HellFlameHandPE = game.ServerStorage.HellFlameHand:Clone()
		HellFlameHandPE.Parent = Character.RightHand
		game.Debris:AddItem(HellFlameHandPE, 6)
		for i=1, 30 do wait(.1)
			if HellFireBall == false then break end
		end
		FireBallChargeAnim:Stop()
		FireBallThrowAnim:Play()
		HellFlameHandPE.Enabled = false
		local fire = game.ServerStorage.HellFireBall:Clone()
		fire.Parent = script
		fire.HB.CFrame = RootPart.CFrame * CFrame.new(0,4,0)
		RootPart.Anchored = false
		game.Debris:AddItem(fire,2)
		local bv = Instance.new("BodyVelocity", fire.HB)
		bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 250
		local Exploded = false
		local PlayersHitted = {}
		fire.HB.Touched:Connect(function(hitto)
			if hitto.Parent.Name ~= Player.Name and not hitto:IsDescendantOf(Character) and Exploded == false then
				Exploded = true
				for i,v in pairs(fire:GetChildren()) do
					v.Anchored = true
				end
				local ExplodeModel = game.ServerStorage.HellFlameExplosion2:Clone()
				ExplodeModel.Parent = script
				ExplodeModel:SetPrimaryPartCFrame(fire.HB.CFrame)
				fire:Destroy()
			local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if ExplodeModel == nil or ExplodeModel:FindFirstChild("HB") == nil then
					break
				end
				connection = ExplodeModel.HB.Touched:Connect(function() end)
				results = ExplodeModel.HB:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2*HellFlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = HRT.CFrame.lookVector * - 100
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
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
		local coo = coroutine.wrap(function()
		repeat wait()
			ExplodeModel.Effect.CFrame = ExplodeModel.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(-29), math.rad(29))
			ExplodeModel.Effect2.CFrame = ExplodeModel.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
			ExplodeModel.Effect3.CFrame = ExplodeModel.Effect3.CFrame * CFrame.Angles(math.rad(-29), math.rad(29), math.rad(20))
		until ExplodeModel.HB == nil 
		end)
		coo()
		TweenService:Create(ExplodeModel.HB, TweenInfo.new(1.5), {Size = Vector3.new(180,180,180),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect, TweenInfo.new(1.5),{Size = Vector3.new(180,180,180),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect2, TweenInfo.new(1.5), {Size = Vector3.new(180,180,180),Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.Effect3, TweenInfo.new(1.5), {Size = Vector3.new(180,180,180),Transparency = 1}):Play()
		game.Debris:AddItem(ExplodeModel,1.5)
		wait(0.7)
		for i,v in pairs(ExplodeModel:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
			end
		end)
		wait(8)
		HellFireBallCD = false
	end
end)

local FlameFlightCD = false
local FlameFlight = false
local FlightLight = script.SpotLight
local FlightParticle = script.ParticleEmitter
FlightLight.Parent = Character.RightHand
FlightParticle.Parent= Character.RightHand
local FlightLight2 = FlightLight:Clone()
local FlightParticle2 = FlightParticle:Clone()
FlightLight2.Parent = Character.LeftHand
FlightParticle2.Parent= Character.LeftHand
local DirectionRemote = script:WaitForChild("Direction")
Space.OnServerEvent:Connect(function(play, direction)
	if Attack.Value == false and stunned == false and FlameFlight == false and FlameFlightCD == false then
		FlameFlight = true
		FlameFlightCD = true
		Attack.Value = true
		Humanoid.AutoRotate = false
		Humanoid.PlatformStand = true
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		FlightAnim:Play()
		FlightLight.Enabled = true
		FlightParticle.Enabled = true
		FlightLight2.Enabled = true
		FlightParticle2.Enabled = true
		local bv = Instance.new("BodyVelocity", RootPart)
		bv.Name = "FlameFlight"
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = direction.lookVector * 100
		repeat wait(.1) 
		DirectionRemote:FireClient(Player)
		Stamina.Value = Stamina.Value - 2.5
		until FlameFlight == false or Stamina.Value < 2.5
		bv:Destroy()
		Attack.Value = false
		FlightLight.Enabled = false
		FlightParticle.Enabled = false
		FlightLight2.Enabled = false
		FlightParticle2.Enabled = false
		FlightAnim:Stop()
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
		wait(1)
		FlameFlightCD = false
	elseif FlameFlight == true then
		RootPart:FindFirstChild("FlameFlight").Velocity = direction.lookVector * 100*HellFlameModeMultiplier
	end
end)

xup.OnServerEvent:Connect(function(play, direction)
	if FlameFlight == true then
		FlameFlight = false
	elseif HellFireBall == true then
		HellFireBall = false
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
	end
end)

local JetBurn = false
qq.OnServerEvent:Connect(function()
	if Stamina.Value >= 40 and Attack.Value == false and stunned == false and JetBurn == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 40 
		JetBurn = true
		JetBurnAnim:Play()
		local HellFlameHandPE = game.ServerStorage.HellFlameHand:Clone()
		HellFlameHandPE.Parent = Character.LeftHand
		game.Debris:AddItem(HellFlameHandPE, 2)
		wait(1)
		HellFlameHandPE.Enabled = false
		local JetBurnModel = game.ServerStorage.HellJetBurn:Clone()
		JetBurnModel.Parent = script
		JetBurnModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0)))
		game.Debris:AddItem(JetBurnModel, 2)
		for i,v in pairs(JetBurnModel:GetChildren()) do
				TweenService:Create(v,TweenInfo.new(1.5),{Size = v.Size * 15, CFrame = v.CFrame * CFrame.new(0,2,75), Transparency = 1}):Play()
		end
		local PlayersHitted = {}
	local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if JetBurnModel == nil or JetBurnModel:FindFirstChild("HB") == nil then
					break
				end
				connection = JetBurnModel.HB.Touched:Connect(function() end)
				results = JetBurnModel.HB:GetTouchingParts()
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
								local ExplodeModel = game.ServerStorage.HellFlameExplosion:Clone()
								ExplodeModel.Parent = script
								ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)
								game.Debris:AddItem(ExplodeModel,1.25)
								TweenService:Create(ExplodeModel.DMG, TweenInfo.new(1.25), {Size = ExplodeModel.DMG.Size + Vector3.new(40,40,40)}):Play()
								TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(100,100,100)}):Play()
								TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.25), {Transparency = 1, Size = ExplodeModel.DMG.Size + Vector3.new(60,60,60)}):Play()
		    					DmgFunction:Fire(Character, hum, 50*Strength.Value/2*HellFlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 150
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
									Velocity.Name = "Heavy"
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
				wait(0.1)
			end
		end)
		expermentaltouch()
	wait(1)
	Attack.Value = false
	for i,v in pairs(JetBurnModel:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	wait(3)
	JetBurn = false	
	end
end)

local HellSpider = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 150 and Stamina.Value >= 50 and Attack.Value == false and stunned == false and HellSpider == false then
		Attack.Value = true
		HellSpider = true
		Stamina.Value = Stamina.Value - 50
		RootPart.Anchored = true
		Humanoid.WalkSpeed = 0 
		Humanoid.JumpPower = 0 
		cantrun = true
		wait(.25)
		local HellSpiderModel = game.ServerStorage.HellSpider:Clone()
		HellSpiderAnim:Play()
		wait(.3)
		HellSpiderModel.Parent = script
		HellSpiderModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		for i,v in pairs(HellSpiderModel:GetChildren()) do
			if v.Name ~= "Main" and v.Name ~= "HB" then
				TweenService:Create(v,TweenInfo.new(1),{Size = v.Size*4, CFrame = v.CFrame * CFrame.new(0,10,70)}):Play()
			end
		end
		local coo = coroutine.wrap(function()
		repeat wait()
			HellSpiderModel.HB.CFrame = HellSpiderModel.HB.CFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(15))
		until HellSpiderModel.HB == nil 
		end)
		coo()
		local PlayersHit = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if HellSpiderModel == nil or HellSpiderModel:FindFirstChild("HB") == nil then
					break
				end
				connection = HellSpiderModel.HB.Touched:Connect(function() end)
				results = HellSpiderModel.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHit[results[i].Parent] ~= nil then
         						else
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 6*Strength.Value/2*HellFlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Heavy"
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Velocity = Vector3.new(0,0,0)
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,5)
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
		wait(4)
		for i,v in pairs(HellSpiderModel:GetChildren()) do
			if v.Name ~= "Main" and v.Name ~= "HB" then
				TweenService:Create(v,TweenInfo.new(.75),{Transparency = 1}):Play()
			end
		end
		wait(1)
		HellSpiderModel:Destroy()
		RootPart.Anchored = false
		Humanoid.WalkSpeed = 18 
		Humanoid.JumpPower = 50 
		cantrun = false
		Attack.Value = false
		wait(6)
		HellSpider = false
	end	
end)


cup.OnServerEvent:Connect(function()
end)

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	Defense.Value = 3
	Stamina.Value = Stamina.Value - 3
	if RootPart:FindFirstChild("Heavy") then
		wait(.3)
		RootPart:FindFirstChild("Heavy"):Destroy()
	end
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

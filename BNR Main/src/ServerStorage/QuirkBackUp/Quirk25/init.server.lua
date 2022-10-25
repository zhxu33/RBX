local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 25 then
	script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Plr = game.Players:FindFirstChild(Player.Name)
wait()
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block) 
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local LaserShotAnim = Humanoid:LoadAnimation(AnimationsFolder.LaserShot)
local ReverseLaserAnim = Humanoid:LoadAnimation(AnimationsFolder.ReverseLaser)
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

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local xup = script:WaitForChild("XUP")
local cup = script:WaitForChild("CUP")
local ccfire = script:WaitForChild("CCFire")
local vv = script:WaitForChild("V")
local tturn = script:WaitForChild("Turn")

local LaserShot = false
zz.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value >= 40 and  LaserShot == false then
		LaserShot = true
		Attack.Value = true
		Stamina.Value = Stamina.Value - 40
		LaserShotAnim:Play()
		wait(0.1)
		local Ef = game.ServerStorage.MuscleShock:Clone()
		Ef.Size = Vector3.new(5,3.5,5)
		Ef.BrickColor = BrickColor.new("Cyan")
		Ef.Parent = script
		Ef.CFrame = RootPart.CFrame *CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		game.Debris:AddItem(Ef,1)
		TweenService:Create(Ef,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(27.5,25,27.5)}):Play()
		local Laser = game.ServerStorage.NavelLaser:Clone()
		Laser.Parent = script
		Laser:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		TweenService:Create(Laser.Inside, TweenInfo.new(1.5), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,-150)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(3.753, 300, 3.753)}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(1.5), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,-150)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(4.792, 300, 4.792)}):Play()
		TweenService:Create(Laser.HB, TweenInfo.new(1.5), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,-150)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(4.792, 300, 4.792)}):Play()
		game.Debris:AddItem(Laser , 1.5)
		local PlayersHitted = {}
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if Laser == nil or Laser:FindFirstChild("HB") == nil then
					break
				end
				connection = Laser.HB.Touched:Connect(function() end)
				results = Laser.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil then
         					else
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							local ExplodeModel = game.ServerStorage.NavelExplosion:Clone()
							ExplodeModel.Parent = script
							ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)
							TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(40,40,40)}):Play()
							TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(11,11,11)}):Play()
							game.Debris:AddItem(ExplodeModel,1.5)
							DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Heavy"
								Velocity.Velocity = RootPart.CFrame.lookVector * 75
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.7)
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
		wait(1.5)
		LaserShotAnim:Stop()
		Attack.Value = false
		wait(2)
		LaserShot = false
	end
end)
		
local LaserFlight = false
local LaserFlightCD = false
xx.OnServerEvent:Connect(function(play, direc)
	if Agility.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 10 and LaserFlight == false and LaserFlightCD == false then
		Attack.Value = true
		LaserFlight = true
		LaserFlightCD = true
		Humanoid.AutoRotate = false
		Humanoid.PlatformStand = true
		ReverseLaserAnim:Play()
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p, direc.p)
		wait(0.1)
		local Ef = game.ServerStorage.MuscleShock:Clone()
		Ef.Size = Vector3.new(5,3.5,5)
		Ef.BrickColor = BrickColor.new("Cyan")
		Ef.Parent = script
		Ef.CFrame = RootPart.CFrame *CFrame.Angles(math.rad(90),math.rad(0),math.rad(180))
		game.Debris:AddItem(Ef,1)
		TweenService:Create(Ef,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(27.5,25,27.5)}):Play()
		local Laser = game.ServerStorage.NavelLaser:Clone()
		Laser.Parent = script
		Laser:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		TweenService:Create(Laser.Inside, TweenInfo.new(1), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(3.753, 150, 3.753)}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(1), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(4.792, 150, 4.792)}):Play()
		TweenService:Create(Laser.HB, TweenInfo.new(1), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(4.792, 150, 4.792)}):Play()
		game.Debris:AddItem(Laser , 1)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if Laser == nil or Laser:FindFirstChild("HB") == nil then
					break
				end
				connection = Laser.HB.Touched:Connect(function() end)
				results = Laser.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil then
         					else
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							local ExplodeModel = game.ServerStorage.NavelExplosion:Clone()
							ExplodeModel.Parent = script
							ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)
							TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(40,40,40)}):Play()
							TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(11,11,11)}):Play()
							game.Debris:AddItem(ExplodeModel,1.5)
							DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Heavy"
								Velocity.Velocity = RootPart.CFrame.lookVector * 75
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.7)
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
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = direc.lookVector * 100
		game.Debris:AddItem(BV, 1)
		wait(1)
		ReverseLaserAnim:Stop()
		LaserFlight = false
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
		Attack.Value = false
		wait(0.1)
		LaserFlightCD = false
	end
end)

xup.OnServerEvent:Connect(function()
	if LaserFlight == true then
	LaserFlight = false
	end
end)

local RapidLaser = false
local RapidLaserCD = false
local shooting = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 10 and RapidLaser == false and RapidLaserCD == false then
		RapidLaser = true
		RapidLaserCD = true
		Attack.Value = true
		RootPart.Anchored = true
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		cantrun = true
		LaserShotAnim:Play()
		local coo = coroutine.wrap(function()
		wait(8)
		if RapidLaser == true then
		RapidLaser = false
		end
		end)
		coo()
		repeat 
		ccfire:FireClient(Plr)
		Stamina.Value = Stamina.Value - 5
		wait(0.5)
		shooting = false
		until Stamina.Value <= 6 or RapidLaser == false
		RapidLaser = false
		LaserShotAnim:Stop()
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		RootPart.Anchored = false
		cantrun = false
		Attack.Value = false
		wait(8)
		RapidLaserCD = false
	end
end)

cup.OnServerEvent:Connect(function()
	if RapidLaser == true then
		RapidLaser = false
	end
end)

ccfire.OnServerEvent:Connect(function(play,direction)
	if RapidLaser == true and shooting == false then
		shooting = true
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		local Laser = game.ServerStorage.NavelLaser:Clone()
		Laser.Parent = script
		Laser:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		local BV = Instance.new("BodyVelocity", Laser.Inside)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 150
		local BV = Instance.new("BodyVelocity", Laser.Outside)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 150
		Laser.Inside.Anchored = false
		Laser.Outside.Anchored = false
		local Exploded = false
		wait(0.1)
		TweenService:Create(Laser.Inside, TweenInfo.new(0.5), {Size = Vector3.new(0.591, 14.031, 0.591)}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(0.5), {Size = Vector3.new(0.755, 14.031, 0.755)}):Play()
		TweenService:Create(Laser.Inside, TweenInfo.new(2), {Transparency = 1}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(2), {Transparency = 1}):Play()
		game.Debris:AddItem(Laser , 2)
		local PlayersHitted = {}
		Laser.Outside.Touched:Connect(function(hitto)
			if Exploded == false and hitto.Parent ~= Character and hitto.Parent.Parent ~= Character and hitto.Parent.Parent.Parent ~= Character then
				Exploded = true
				Laser.Outside.Anchored = true
				game.Debris:AddItem(Laser,0.1)
				local ExplodeModel = game.ServerStorage.NavelExplosion:Clone()
					ExplodeModel.Parent = script
					ExplodeModel:SetPrimaryPartCFrame(Laser.Outside.CFrame)
					TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(60,60,60)}):Play()
					TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(16,16,16)}):Play()
					TweenService:Create(ExplodeModel.HB, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(60,60,60)}):Play()
					game.Debris:AddItem(ExplodeModel,1)
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
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         					else
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil or not (results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent)) then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.25)
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
			end
		end)
	end
end)

		

local LaserUlt = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 80 and LaserUlt == false then
		LaserUlt = true
		Attack.Value = true
		Stamina.Value = Stamina.Value - 40
		LaserShotAnim:Play()
		wait(0.1)
		local Ef = game.ServerStorage.MuscleShock:Clone()
		Ef.Size = Vector3.new(5,3.5,5)
		Ef.BrickColor = BrickColor.new("Cyan")
		Ef.Parent = script
		Ef.CFrame = RootPart.CFrame *CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		game.Debris:AddItem(Ef,1)
		TweenService:Create(Ef,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(50,50,50)}):Play()
		local Laser = game.ServerStorage.NavelLaser:Clone()
		Laser.Parent = script
		Laser:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		TweenService:Create(Laser.Inside, TweenInfo.new(2.5), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,-250)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(15.012, 500, 15.012)}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(2.5), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,-250)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 500, 19.168)}):Play()
		TweenService:Create(Laser.HB, TweenInfo.new(2.5), {Transparency = 1, CFrame = RootPart.CFrame * CFrame.new(0,0,-250)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 500, 19.168)}):Play()
		game.Debris:AddItem(Laser , 2.5)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if Laser == nil or Laser:FindFirstChild("HB") == nil then
					break
				end
				connection = Laser.HB.Touched:Connect(function() end)
				results = Laser.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         					else
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							local ExplodeModel = game.ServerStorage.NavelExplosion:Clone()
							ExplodeModel.Parent = script
							ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)
							TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.5), {Transparency = 1, Size = Vector3.new(80,80,80)}):Play()
							TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.5), {Transparency = 1, Size = Vector3.new(22,22,22)}):Play()
							game.Debris:AddItem(ExplodeModel,1.5)
							DmgFunction:Fire(Character, hum, 80*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Heavy"
								Velocity.Velocity = RootPart.CFrame.lookVector * 150
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,1.5)
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
		wait(2.5)
		LaserShotAnim:Stop()
		Attack.Value = false
		wait(8)
		LaserUlt = false
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

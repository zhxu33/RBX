local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 19 then
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
local EruptingFlamesAnim = Humanoid:LoadAnimation(AnimationsFolder.EruptingFlames)
local AblazingWorldAnim = Humanoid:LoadAnimation(AnimationsFolder.AblazingWorld)
local IncineratingBlastAnim = Humanoid:LoadAnimation(AnimationsFolder.IncineratingBlast)
local PyreWallAnim = Humanoid:LoadAnimation(AnimationsFolder.PyreWall) 
local BurstingInfernoAnim = Humanoid:LoadAnimation(AnimationsFolder.BurstingInferno)
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block) 
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
local vv = script:WaitForChild("V")
local rup = script:WaitForChild("RUP")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local ff = script:WaitForChild("F")
local qq = script:WaitForChild("Q")
local zup = script:WaitForChild("Zup")

local FlameMode = false
local FlameModeCD = false
local FlameModeMultiplier = 1
ff.OnServerEvent:Connect(function()
	if Agility.Value >= 250 and FlameMode == false and FlameModeCD == false then
	FlameMode = true
	FlameModeCD = true
	FlameModeMultiplier = 1.2
	local Light = script.FlameMode.ModeLight:Clone()
	Light.Parent = RootPart
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("MeshPart") or v.Name == "Head" then
			local PE = script.FlameMode.ModePE:Clone()
			PE.Parent = v
			local PE2 = script.FlameMode.ModePE2:Clone()
			PE2.Parent = v
		end
	end
	repeat wait(.1) 
	Stamina.Value = Stamina.Value - 2.5
	until FlameMode == false or Stamina.Value < 2.5
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("MeshPart") or v.Name == "Head" then
			v:FindFirstChild("ModePE"):Destroy()
			v:FindFirstChild("ModePE2"):Destroy()
		end
	end
	FlameModeMultiplier = 1
	RootPart:FindFirstChild("ModeLight"):Destroy()
	wait(5)
	FlameModeCD = false
	elseif FlameMode == true then
		FlameMode = false
	end
end)

local BurstingInferno = false
qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value >= 25 and BurstingInferno == false then
		Attack.Value = true
		BurstingInferno = true
		BurstingInfernoAnim:Play()
		wait(.25)
		local BurstingInfernoModel = game.ServerStorage.BurstingInferno:Clone()
		BurstingInfernoModel.Parent = script
		BurstingInfernoModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)))
		game.Debris:AddItem(BurstingInfernoModel, 1.5)
		TweenService:Create(BurstingInfernoModel.HB, TweenInfo.new(1), {Size = Vector3.new(53, 53, 162), Transparency = 1, CFrame = BurstingInfernoModel.HB.CFrame * CFrame.new(0,0,-60)}):Play()
		TweenService:Create(BurstingInfernoModel.Effect1, TweenInfo.new(1), {Size = Vector3.new(60, 72, 60), Transparency = 1}):Play()
		TweenService:Create(BurstingInfernoModel.Effect2, TweenInfo.new(1), {Size = Vector3.new(75, 7.5, 75), Transparency = 1}):Play()
		TweenService:Create(BurstingInfernoModel.Effect3, TweenInfo.new(1), {Size = Vector3.new(120, 18, 120), Transparency = 1}):Play()
		TweenService:Create(BurstingInfernoModel.Inside, TweenInfo.new(1), {Size = Vector3.new(49, 49, 154), Transparency = 1,CFrame = BurstingInfernoModel.Inside.CFrame * CFrame.new(0,0,-60)}):Play()
		local coo = coroutine.wrap(function()
		repeat wait()
			if BurstingInfernoModel == nil or BurstingInfernoModel:FindFirstChild("Effect1") or BurstingInfernoModel:FindFirstChild("Effect2") or BurstingInfernoModel:FindFirstChild("Effect3") == nil then
				
			end
			BurstingInfernoModel.Effect1.CFrame = BurstingInfernoModel.Effect1.CFrame * CFrame.Angles(math.rad(2), math.rad(29), math.rad(0))
			BurstingInfernoModel.Effect2.CFrame = BurstingInfernoModel.Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			BurstingInfernoModel.Effect3.CFrame = BurstingInfernoModel.Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until BurstingInfernoModel.Effect1 == nil 
		end)
		coo()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if BurstingInfernoModel == nil or BurstingInfernoModel:FindFirstChild("HB") == nil then
					break
				end
				connection = BurstingInfernoModel.HB.Touched:Connect(function() end)
				results = BurstingInfernoModel.HB:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 40*Strength.Value/2*FlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Heavy"
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Velocity = RootPart.CFrame.lookVector * 100
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
		wait(1)
		local coo = coroutine.wrap(function()
		if BurstingInfernoModel:FindFirstChild("Effect3") then
		BurstingInfernoModel.Effect3.Particle.Enabled = false
		end
		end)
		coo()
		Attack.Value = false
		wait(5)
		BurstingInferno = false
	end
end)
			
local IncineratingBlast = false
local IncineratingBlastCD = false
local plr = game.Players:FindFirstChild(Player.Name)
zz.OnServerEvent:Connect(function(play,pos)
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value > 25 and IncineratingBlast == false and IncineratingBlastCD == false then
		Attack.Value = true
		IncineratingBlastCD = true 
		IncineratingBlast = true 
		IncineratingBlastAnim:Play()
		wait(.5)
		local IncineratingBlastModel = game.ServerStorage.IncineratingBlast:Clone()
		IncineratingBlastModel.Parent = script
		local Weld = Instance.new("Motor6D", IncineratingBlastModel.Main)
		Weld.Part0 = RootPart
		Weld.Part1 = IncineratingBlastModel.Main
		Weld.C0 = Weld.C0 * CFrame.new(0,0,-2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		local PlayersHit = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if IncineratingBlastModel == nil or IncineratingBlastModel:FindFirstChild("HB") == nil then
					break
				end
				connection = IncineratingBlastModel.HB.Touched:Connect(function() end)
				results = IncineratingBlastModel.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 and results[i].Parent ~= Character then
								if PlayersHit[results[i].Parent] ~= nil then
         						else
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
								DmgFunction:Fire(Character, hum, 5*Strength.Value/2*FlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.1)
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
		local coro = coroutine.wrap(function()
		repeat wait(.05)
		Stamina.Value = Stamina.Value - .75
		until Stamina.Value < 1 or IncineratingBlast == false
		Attack.Value = false
		IncineratingBlast = false
		for i,v in pairs(IncineratingBlastModel:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		wait(1)
		IncineratingBlastModel:Destroy()
		IncineratingBlastAnim:Stop()
		wait(6)
		IncineratingBlastCD = false
		end)
		coro()
		wait(6)
		if IncineratingBlast == true then
		IncineratingBlast = false
		end
	end
end)

zup.OnServerEvent:Connect(function()
	if IncineratingBlast == true then
		IncineratingBlast = false
	end
end)

local EruptingFlames = false
xx.OnServerEvent:Connect(function(play, direction)
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 40 and EruptingFlames == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 40
		EruptingFlames = true
		EruptingFlamesAnim:Play()
		wait(1)
		local EruptingFlamesModel = game.ServerStorage.EruptingFlames:Clone()
		EruptingFlamesModel.Parent = script
		EruptingFlamesModel:SetPrimaryPartCFrame(RootPart.CFrame)
		game.Debris:AddItem(EruptingFlamesModel,5)
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 150
		game.Debris:AddItem(BV, 1)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if EruptingFlamesModel == nil or EruptingFlamesModel:FindFirstChild("HB") == nil then
					break
				end
				connection = EruptingFlamesModel.HB.Touched:Connect(function() end)
				results = EruptingFlamesModel.HB:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2*FlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Heavy"
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Velocity = Vector3.new(0,100,0)
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
		TweenService:Create(EruptingFlamesModel.Round, TweenInfo.new(4), {Transparency = 1, Size = Vector3.new(300,300,300)}):Play()
		TweenService:Create(EruptingFlamesModel.Spiky, TweenInfo.new(4), {Transparency = 1, Size = Vector3.new(300,300,300)}):Play()
		TweenService:Create(EruptingFlamesModel.HB, TweenInfo.new(4), {Transparency = 1, Size = Vector3.new(200,200,200)}):Play()
		TweenService:Create(EruptingFlamesModel.InsideBall, TweenInfo.new(4), {Transparency = 1, Size = Vector3.new(110,110,110)}):Play()
		local coo = coroutine.wrap(function()
		repeat wait()
			if EruptingFlamesModel == nil or EruptingFlamesModel:FindFirstChild("Round") == nil then
				break
			end
			EruptingFlamesModel.Round.CFrame = EruptingFlamesModel.Round.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(29))
		until EruptingFlamesModel.Round == nil 
		end)
		coo()
		wait(1.5)
		Attack.Value = false
		wait(1)
		for i,v in pairs(EruptingFlamesModel.InsideBall:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		wait(8)
		EruptingFlames = false
	end
end)

local PyreWall = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 150 and Attack.Value == false and stunned == false and PyreWall == false and Stamina.Value >= 100 then
		Attack.Value = true
		PyreWall = true
		Stamina.Value = Stamina.Value - 100
		PyreWallAnim:Play()
		wait(.4)
		local CremationTornado = game.ServerStorage.CremationTornado:Clone()
		CremationTornado.Parent = script
		CremationTornado.CFrame = RootPart.CFrame
		TweenService:Create(CremationTornado, TweenInfo.new(1),{Size = Vector3.new(300,80,300), Transparency = 1}):Play()
		game.Debris:AddItem(CremationTornado,1)
		local EruptingFlamesModel = game.ServerStorage.EruptingFlames:Clone()
		EruptingFlamesModel.Parent = script
		EruptingFlamesModel.Spiky:Destroy()
		EruptingFlamesModel.Round.Size = Vector3.new(25,25,25)
		EruptingFlamesModel.HB.Size = Vector3.new(18,18,18)
		EruptingFlamesModel.InsideBall.Size = Vector3.new(10,10,10)
		EruptingFlamesModel:SetPrimaryPartCFrame(RootPart.CFrame)
		game.Debris:AddItem(EruptingFlamesModel,1)
		TweenService:Create(EruptingFlamesModel.Round, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(200,200,200)}):Play()
		TweenService:Create(EruptingFlamesModel.HB, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(130,130,130)}):Play()
		TweenService:Create(EruptingFlamesModel.InsideBall, TweenInfo.new(1), {Transparency = 1, Size = Vector3.new(80,80,80)}):Play()
		for i,v in pairs(EruptingFlamesModel.InsideBall:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Rate = NumberSequence.new(15)
			end
		end
		local coo = coroutine.wrap(function()
		repeat wait()
			if EruptingFlamesModel == nil or EruptingFlamesModel:FindFirstChild("Round") == nil then
				break
			end
			EruptingFlamesModel.Round.CFrame = EruptingFlamesModel.Round.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(29))
		until EruptingFlamesModel.Round == nil 
		end)
		coo()
		wait(.3)
		for i,v in pairs(CremationTornado:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		for i,v in pairs(EruptingFlamesModel.InsideBall:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		local PyreWallModel = game.ServerStorage.PyreWall:Clone()
		PyreWallModel.Parent = script
		PyreWallModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,45,0))
		game.Debris:AddItem(PyreWallModel,6)
		local coo = coroutine.wrap(function()
		repeat wait()
			if PyreWallModel == nil or PyreWallModel:FindFirstChild("Effect") == nil or PyreWallModel:FindFirstChild("Effect2") == nil or PyreWallModel:FindFirstChild("Effect3") == nil or PyreWallModel:FindFirstChild("HB") == nil then
				break
			end
			PyreWallModel.Effect.CFrame = PyreWallModel.Effect.CFrame * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
			PyreWallModel.Effect2.CFrame = PyreWallModel.Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
			PyreWallModel.Effect3.CFrame = PyreWallModel.Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
			PyreWallModel.HB.CFrame = PyreWallModel.HB.CFrame * CFrame.Angles(math.rad(0), math.rad(15), math.rad(0))
		until PyreWallModel.Effect == nil 
		end)
		coo()
		local coro = coroutine.wrap(function()
		wait(5)
		for i,v in pairs(PyreWallModel:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		TweenService:Create(PyreWallModel.Effect, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(PyreWallModel.Effect2, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(PyreWallModel.Effect3, TweenInfo.new(1), {Transparency = 1}):Play()
		end)
		coro()
		local PlayersHit = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if PyreWallModel == nil or PyreWallModel:FindFirstChild("HB") == nil then
					break
				end
				connection = PyreWallModel.HB.Touched:Connect(function() end)
				results = PyreWallModel.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character  and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
								if PlayersHit[results[i].Parent] ~= nil then
         						else
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
								DmgFunction:Fire(Character, hum, 6*Strength.Value/2*FlameModeMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Light"
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.1)
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
		wait(1)
		Attack.Value = false
		wait(8)
		PyreWall = false
	end
end)

local AblazingWorld = false
local AblazingWorldCD = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value > 75 and AblazingWorld == false and AblazingWorldCD == false then
		Attack.Value = true
		AblazingWorld = true
		AblazingWorldCD = true
		Stamina.Value = Stamina.Value - 150
		RootPart.Anchored = true
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		cantrun = true
		AblazingWorldAnim:Play()
		local AblazingWorldModel = game.ServerStorage.AblazingWorld:Clone()
		AblazingWorldModel.Parent = script
		AblazingWorldModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0))
		game.Debris:AddItem(AblazingWorldModel,6)
		TweenService:Create(AblazingWorldModel.Tornado, TweenInfo.new(2), {Size = Vector3.new(300,300,300), Position = AblazingWorldModel.PullSpot.Position}):Play()
		TweenService:Create(AblazingWorldModel.Tornado2, TweenInfo.new(2), {Size = Vector3.new(300,300,300), Position = AblazingWorldModel.PullSpot.Position}):Play()
		TweenService:Create(AblazingWorldModel.Tornado3, TweenInfo.new(2), {Size = Vector3.new(300,300,300), Position = AblazingWorldModel.PullSpot.Position}):Play()
		local coro = coroutine.wrap(function()
			repeat wait()
				if AblazingWorldModel == nil or AblazingWorldModel:FindFirstChild("Tornado") == nil or AblazingWorldModel:FindFirstChild("Tornado2") == nil or AblazingWorldModel:FindFirstChild("Tornado3") == nil then
					break
				end
			AblazingWorldModel.Tornado.CFrame = AblazingWorldModel.Tornado.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			AblazingWorldModel.Tornado2.CFrame = AblazingWorldModel.Tornado2.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			AblazingWorldModel.Tornado3.CFrame = AblazingWorldModel.Tornado3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			until AblazingWorld == false
		end)
		coro()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if AblazingWorldModel == nil or AblazingWorldModel:FindFirstChild("HB") == nil then
					break
				end
				connection = AblazingWorldModel.HB.Touched:Connect(function() end)
				results = AblazingWorldModel.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character  and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
								if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent)  then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local SafeTp = Instance.new("NumberValue",HRT.Parent)
								SafeTp.Name = "SafeTp"
								game.Debris:AddItem(SafeTp,10)
								DmgFunction:Fire(Character, hum, 6*Strength.Value/2*FlameModeMultiplier)
								local BP = Instance.new("BodyPosition",HRT)
								BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								BP.Position = AblazingWorldModel.PullSpot.Position
								game.Debris:AddItem(BP, 10)
								local dontgoingstop = coroutine.wrap(function()
								repeat wait(.5)
								DmgFunction:Fire(Character, hum, 6*Strength.Value/2*FlameModeMultiplier)
									Exp.Value = Exp.Value + 5
									if not HRT:FindFirstChild("Heavy") then
										local Velocity = Instance.new("Model",HRT)
										Velocity.Name = "Heavy"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,1)
									end
									until AblazingWorld == false or Humanoid.Health == 0
									BP:Destroy()
								end)
								dontgoingstop()
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
		for i,v in pairs(AblazingWorldModel.Main:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		TweenService:Create(AblazingWorldModel.Tornado, TweenInfo.new(2), {Transparency = 1}):Play()
		TweenService:Create(AblazingWorldModel.Tornado2, TweenInfo.new(2), {Transparency = 1}):Play()
		TweenService:Create(AblazingWorldModel.Tornado3, TweenInfo.new(2), {Transparency = 1}):Play()
		wait(2)
		Attack.Value = false
		RootPart.Anchored = false
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		cantrun = false
		AblazingWorld = false
		wait(18)
		AblazingWorldCD = false
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

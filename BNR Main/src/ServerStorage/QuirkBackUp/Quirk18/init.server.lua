local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 18 then
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
local SuckAnim = Humanoid:LoadAnimation(AnimationsFolder.Suck) 
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
local TweenService = game:GetService("TweenService")
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
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

local corot = coroutine.wrap(function()
	while wait(.1) do
		if Humanoid.Health <= 0 then
			Attack.Value = true
			break
		end
	end
end)
corot()

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local zup = script:WaitForChild("Zup")
local rup = script:WaitForChild("RUP")

local HoleBody = false
local HoleBodyCD = false 
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 150 and Attack.Value == false and stunned == false and HoleBody == false and HoleBodyCD == false and Stamina.Value >= 100 then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		HoleBody = true
		HoleBodyCD = true
		Humanoid.WalkSpeed = 0 
		Humanoid.JumpPower = 0 
		RootPart.Anchored = true
		cantrun = true
		local ff = Instance.new("ForceField",Character)
		ff.Visible = false
		ff.Name = "Hole"
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") then
				v.Transparency = 1
			end
		end
		local BlackHole = game.ServerStorage.BlackHoleTrap:Clone()
		BlackHole.Parent = script
		BlackHole:SetPrimaryPartCFrame(RootPart.CFrame)
		BlackHole.HB.PointLight.Range = 60
		BlackHole.HB.Size = Vector3.new(100,100,100)
		local Pos = BlackHole.HB.Position
		local PlayersHitted = {}
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if BlackHole == nil or BlackHole:FindFirstChild("HB") == nil then
					break
				end
				connection = BlackHole.HB.Touched:Connect(function() end)
				results = BlackHole.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         							else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local SafeTp = Instance.new("NumberValue",HRT.Parent)
								SafeTp.Name = "SafeTp"
								game.Debris:AddItem(SafeTp,10)
								local BP = Instance.new("BodyPosition",HRT)
								BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								BP.Position = Pos
								game.Debris:AddItem(BP, 10)
								local keepigoing = coroutine.wrap(function()
								repeat wait(.1)
								BP.Position = Pos
								DmgFunction:Fire(Character, hum, 1.5*Strength.Value/2)
								Exp.Value = Exp.Value + 5
								if not HRT:FindFirstChild("Heavy") then
									local Velocity = Instance.new("Model",HRT)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,1)	
								end
								until HoleBody == false or Humanoid.Health == 0
								BP:Destroy()
								local BV = Instance.new("BodyVelocity",HRT)
								BV.Name = "Heavy"
								BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								BV.Velocity = HRT.CFrame.lookVector * -150
								game.Debris:AddItem(BV,1.5)
								DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
								end)
								keepigoing()
							end end 
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
		wait(2.5)
		HoleBody = false
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50 
		RootPart.Anchored = false
		Attack.Value = false
		BlackHole:Destroy()
		cantrun = false
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") then
				v.Transparency = 0
			end
		end
		local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
		UpDashEf.Parent = script
		UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(135))
		UpDashEf.Decal.Color3 = Color3.new(0,0,0)
		UpDashEf.Decal1.Color3 = Color3.new(0,0,0)
		local UpDashEf2 = game.ServerStorage.UpDashEffect:Clone()
		UpDashEf2.Parent = script
		UpDashEf2.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(-135))
		UpDashEf2.Decal.Color3 = Color3.new(0,0,0)
		UpDashEf2.Decal1.Color3 = Color3.new(0,0,0)
		local Ball = script.Ball:Clone()
		Ball.Parent = script
		Ball.CFrame = RootPart.CFrame
		TweenService:Create(Ball,TweenInfo.new(1.5), {Transparency =1, Size = Ball.Size + Vector3.new(125,125,125)}):Play()
		TweenService:Create(UpDashEf,TweenInfo.new(1.5), {Size = UpDashEf.Size + Vector3.new(150,0,150)}):Play()
		TweenService:Create(UpDashEf2,TweenInfo.new(1.5), {Size = UpDashEf2.Size + Vector3.new(150,0,150)}):Play()
		TweenService:Create(UpDashEf.Decal,TweenInfo.new(1.5), {Transparency =1}):Play()
		TweenService:Create(UpDashEf.Decal1,TweenInfo.new(1.5), {Transparency =1}):Play()
		TweenService:Create(UpDashEf2.Decal,TweenInfo.new(1.5), {Transparency =1}):Play()
		TweenService:Create(UpDashEf2.Decal1,TweenInfo.new(1.5), {Transparency =1}):Play()
		game.Debris:AddItem(Ball, 1.5)
		game.Debris:AddItem(UpDashEf, 1.5)
		game.Debris:AddItem(UpDashEf2, 1.5)
	ff:Destroy()
		wait(8)
		HoleBodyCD = false
	end
end)

local Trap = false
xx.OnServerEvent:Connect(function()
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and Trap == false and Stamina.Value >= 50 then
		Trap = true 
		Stamina.Value = Stamina.Value - 50
		local BlackHole = game.ServerStorage.BlackHoleTrap:Clone()
		BlackHole.Parent = script
		BlackHole:SetPrimaryPartCFrame(RootPart.CFrame)
		BlackHole.HB.Sparks.Enabled = true
		BlackHole.HB.Sparks.Parent = BlackHole.Hole
		local pos = BlackHole.HB.Position
		game.Debris:AddItem(BlackHole,6)
		local sucking = true
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if BlackHole == nil or BlackHole:FindFirstChild("HB") == nil then
					break
				end
				connection = BlackHole.HB.Touched:Connect(function() end)
				results = BlackHole.HB:GetTouchingParts()
				connection:Disconnect()
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
									else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local SafeTp = Instance.new("NumberValue",HRT.Parent)
								SafeTp.Name = "SafeTp"
								game.Debris:AddItem(SafeTp,10)
								local BP = Instance.new("BodyPosition",HRT)
								BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								BP.Position = pos
								game.Debris:AddItem(BP, 10)
								local keepgoing = coroutine.wrap(function()
								repeat wait(.1)
								if hum.Health > 0 and results[i].Parent then
									BP.Position = pos
									DmgFunction:Fire(Character, hum, 1.75*Strength.Value/2)
									Exp.Value = Exp.Value + 5
									if not HRT:FindFirstChild("Heavy") then
										local Velocity = Instance.new("Model",HRT)
										Velocity.Name = "Heavy"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,1)	
									end
								end
								until BlackHole == nil or Humanoid.Health == 0 or sucking == false
								BP:Destroy()
								end)
								keepgoing()
							end
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
		wait(6)
		sucking = false
		wait(6)
		Trap = false
	end
end)

local Suck = false
local SuckCD = false
zz.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Suck == false and SuckCD == false then
		Suck = true
		SuckCD = true
		SuckAnim:Play()
		Attack.Value = true
		wait()
		local BlackHole = game.ServerStorage.BlackHole:Clone()
		BlackHole.Parent = Character
		local Weld = Instance.new("Weld", Character.LeftHand)
		Weld.Part0 = Character.LeftHand
		Weld.Part1 = BlackHole.BlackHole1
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if BlackHole == nil or BlackHole:FindFirstChild("HB") == nil then
					break
				end
				connection = BlackHole.HB.Touched:Connect(function() end)
				results = BlackHole.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         							else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local SafeTp = Instance.new("NumberValue",HRT.Parent)
								SafeTp.Name = "SafeTp"
								game.Debris:AddItem(SafeTp,10)
								local BP = Instance.new("BodyPosition",HRT)
								BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
								BP.Position = Character.LeftHand.Position
								game.Debris:AddItem(BP,10)
								local keepgoings = coroutine.wrap(function()
								repeat wait(.1)
								if hum.Health > 0 and results[i].Parent then
								BP.Position = Character.LeftHand.Position
								DmgFunction:Fire(Character, hum, 1.5*Strength.Value/2)
								Exp.Value = Exp.Value + 5
								if not HRT:FindFirstChild("Heavy") then
								local Velocity = Instance.new("Model",HRT)
								Velocity.Name = "Heavy"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,1)		
								end
								end
								until Suck == false or Humanoid.Health == 0
								BP:Destroy()
								end)
								keepgoings()
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
		local coro = coroutine.wrap(function()
		repeat wait(.1)
			BlackHole.HB.CFrame = RootPart.CFrame * CFrame.new(0,0,-30)
			Stamina.Value = Stamina.Value - 2
		until Suck == false or Stamina.Value <= 2
		Suck = false
		BlackHole:Destroy()
		Weld:Destroy()
		wait(.25)
		Attack.Value = false
		SuckAnim:Stop()
		wait(5)
		SuckCD = false
		end)
		coro()
		wait(5)
		if Suck == true then
			Suck = false
		end
	end
end)

zup.OnServerEvent:Connect(function()
	if Suck == true then
		Suck = false
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

local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 27 then
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
local AcidSlideAnim = Humanoid:LoadAnimation(AnimationsFolder.AcidSlide)
local AcidThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.AcidThrow)
local AcidLeakAnim = Humanoid:LoadAnimation(AnimationsFolder.AcidLeak)
local AcidWallAnim = Humanoid:LoadAnimation(AnimationsFolder.AcidWall)
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
local vv = script:WaitForChild("V")
local cup = script:WaitForChild("Cup")

function acidburn(hum, dmg, amt)
	local coro = coroutine.wrap(function()
	for i=1, amt do
		wait(.1)
		DmgFunction:Fire(Character, hum, dmg)
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
							end)
							coro()
end

local AcidBall = false
zz.OnServerEvent:Connect(function(play,direc)
	if Stamina.Value >= 25 and AcidBall == false and Attack.Value == false and stunned == false then
		Stamina.Value = Stamina.Value - 25
		AcidBall = true
		Attack.Value = true
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direc.p)
		AcidThrowAnim:Play()
		local AcidPE = script.AcidDmg:Clone()
		AcidPE.Parent = Character.RightHand
		wait(.4)
		AcidPE:Destroy()
		Attack.Value = false
		local Ball = game.ServerStorage.AcidBall:Clone()
		Ball.Parent = script
		Ball.CFrame = RootPart.CFrame
		local bv = Instance.new("BodyVelocity", Ball)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 100
		game.Debris:AddItem(Ball,3)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if Ball == nil then
					break
				end
				connection = Ball.Touched:Connect(function() end)
				results = Ball:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         						return
							end
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							acidburn(hum, 5*Strength.Value/2, 10)
							local coo = coroutine.wrap(function()
								TweenService:Create(Ball,TweenInfo.new(.5), {Transparency = 1}):Play()
								game.Debris:AddItem(Ball,0.5)
								wait(.3)
								Ball.Pe1.Enabled = false
								Ball.Pe2.Enabled = false
							end)
							coo()
							local AcidPe = script.AcidDmg:Clone()
							AcidPe.Parent = HRT
							local coo = coroutine.wrap(function()
								wait(1)
								AcidPe.Enabled = false
								wait(.4)
								AcidPe:Destroy()
							end)
							coo()
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Light"
								Velocity.Velocity = bv.Velocity
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.25)
							end
						end
					end
				lastresult = results
				end
				wait(0.01)
			end
		end)
		expermentaltouch()
					wait(4)
					AcidBall = false
	end
end)
		
local AcidWall = false
xx.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and Stamina.Value >= 40 and AcidWall == false and stunned == false then
		Stamina.Value = Stamina.Value - 40
		Attack.Value = true
		AcidWall = true
		AcidWallAnim:Play()
		wait(.2)
		local AcidWallPart = game.ServerStorage.AcidWall:Clone()
		AcidWallPart.Parent = script
		AcidWallPart.CFrame = RootPart.CFrame * CFrame.new(0,5,-5) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		AcidWallPart.Name = Player.Name
		local PlayersHitted = {}
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				PlayersHitted = {}
				if AcidWallPart == nil then
					break
				end
				connection = AcidWallPart.Touched:Connect(function() end)
				results = AcidWallPart:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i] ~= AcidWallPart:FindFirstChild("HumanoidRootPart") then
							if PlayersHitted[results[i].Parent] ~= nil then
         					else
							PlayersHitted[results[i].Parent] = results[i].Parent
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, 3*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
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
		Attack.Value = false
		wait(5)
		TweenService:Create(AcidWallPart, TweenInfo.new(1), {Transparency = 1}):Play()
		AcidWallPart.Pe1.Enabled = false
		AcidWallPart.Pe2.Enabled = false
		AcidWallPart.Pe3.Enabled = false
		AcidWallPart.Pe4.Enabled = false
		wait(1)
		AcidWallPart:Destroy()
		wait(5)
		AcidWall = false
	end
end)

local AcidLeak = false
local AcidLeakCD = false
vv.OnServerEvent:Connect(function(play,pos)
	if Strength.Value >= 200 and AcidLeak == false and Attack.Value == false and stunned == false and Stamina.Value >= 25 and AcidLeakCD == false and (RootPart.Position-pos).magnitude <= 75 then
		AcidLeak = true
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		Humanoid.AutoRotate = false
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,pos)
		local AcidPart = game.ServerStorage.AcidLeak:Clone()
		AcidPart.Parent = script
		local Weld = Instance.new("Weld", AcidPart.RightHand)
		Weld.Part0 = AcidPart.RightHand
		Weld.Part1 = Character.RightHand
		local Weld2 = Instance.new("Weld", AcidPart.LeftHand)
		Weld2.Part0 = AcidPart.LeftHand
		Weld2.Part1 = Character.LeftHand
		AcidPart.HB.Position = pos
		game.Debris:AddItem(AcidPart.RightHand, 1.5)
		game.Debris:AddItem(AcidPart.LeftHand, 1.5)
		TweenService:Create(AcidPart.HB, TweenInfo.new(1.5), {Size = Vector3.new(100,4,100)}):Play()
		AcidLeakAnim:Play()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				PlayersHitted = {}
				if AcidPart == nil or AcidPart:FindFirstChild("HB") == nil then
					break
				end
				connection = AcidPart.HB.Touched:Connect(function() end)
				results = AcidPart.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i].Name == "HumanoidRootPart"  then
							if PlayersHitted[results[i].Parent] ~= nil then
         					else
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, 5*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
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
		wait(1.5)
		AcidLeakAnim:Stop()
		Attack.Value = false
		Humanoid.AutoRotate = true
		wait(2.5)
		AcidPart.HB.Main.Enabled = false
		AcidPart.HB.Main2.Enabled = false
		AcidPart.HB.Main3.Enabled = false
		TweenService:Create(AcidPart.HB, TweenInfo.new(.5), {Transparency = 1}):Play()
		game.Debris:AddItem(AcidPart,.5)
		wait(1)
		AcidLeak = false
	end
end)

local AcidSlide = false
local AcidSlideCD = false
cc.OnServerEvent:Connect(function()
	if Agility.Value >= 100 and Stamina.Value >= 10 and Attack.Value == false and stunned == false and AcidSlide == false and AcidSlideCD == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 10
		AcidSlide = true
		AcidSlideCD = true
		AcidSlideAnim:Play()
		local AcidSlidePart = game.ServerStorage.AcidSlide:Clone()
		AcidSlidePart.Parent = script
		local Weld = Instance.new("Weld", AcidSlidePart)
		Weld.Part0 = AcidSlidePart
		Weld.Part1 = Character.RightFoot
		Weld.C0 = Weld.C0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(90))
		local bv = Instance.new("BodyVelocity", RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 100
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if AcidSlidePart == nil then
					break
				end
				connection = AcidSlidePart.Touched:Connect(function() end)
				results = AcidSlidePart:GetTouchingParts()
				connection:Disconnect()
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 and results[i].Parent.Name ~= Player.Name then
							for i,tableValue in pairs(PlayersHitted) do
								if tableValue == results[i].Parent then return end
							end
							table.insert(PlayersHitted, results[i].Parent)
							local coo = coroutine.wrap(function()
								wait(0.5)
								table.remove(PlayersHitted, 1, results[i].Parent)
							end)
							coo()
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
							if HRT:FindFirstChild("Light") == nil then
								Exp.Value = Exp.Value + 50
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
							end
						end 
					end
				wait(0.01)
			end
		end)
		expermentaltouch()
		repeat wait(.1) 
			Stamina.Value = Stamina.Value - 2
			bv.Velocity = RootPart.CFrame.lookVector * 100
		until Stamina.Value <= 5 or AcidSlide == false
		if AcidSlide == true then
			AcidSlide = false
		end
		bv:Destroy()
		AcidSlidePart.PE1.Enabled = false
		AcidSlidePart.PE2.Enabled = false
		AcidSlidePart.Trail.Enabled = false
		TweenService:Create(AcidSlidePart,TweenInfo.new(.5), {Transparency = 1}):Play()
		wait(.4)
		AcidSlidePart:Destroy()
		wait(.1)
		AcidSlideAnim:Stop()
		Attack.Value = false
		wait()
		AcidSlideCD = false
	end
end)

cup.OnServerEvent:Connect(function()
	if AcidSlide == true then
		AcidSlide = false
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

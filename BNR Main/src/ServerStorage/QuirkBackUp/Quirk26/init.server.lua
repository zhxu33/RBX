local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 26 then
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
local DecayThrowStartAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayThrowStart)
local DecayThrowMidAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayThrowMid)
local DecayThrowFinishAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayThrowFinish)
local DecayFloorAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayFloor)
local DecayTouchStartAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayTouchStart)
local DecayTouchLoopAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayTouchLoop)
local DecayTouchStopAnim = Humanoid:LoadAnimation(AnimationsFolder.DecalyTouchStop)
local DecayChargeAnim = Humanoid:LoadAnimation(AnimationsFolder.DecayCharge)
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
local DecayThrowCD = false 
local DecayChargeCD = false
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
local qq = script:WaitForChild("Q")
local ff = script:WaitForChild("F")
local zup = script:WaitForChild("Zup")

local DecayMode = false
local DecayModeCD = false
local DecayMultiplier = 1
ff.OnServerEvent:Connect(function()
	if Agility.Value >= 250 and Attack.Value == false and stunned == false and DecayMode == false and DecayModeCD == false then
		local conected
		if conected ~= nil then
			conected:Disconnect()
		end 
		DecayMode = true
		DecayModeCD = true
		local DecayModeHit = {}
		local conected = Humanoid.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and DecayMode == true and hit.Parent.Name ~= Player.Name and DecayThrowCD == false and DecayChargeCD == false then
					for i,tableValue in pairs(DecayModeHit) do
						if tableValue == hit.Parent then return end
						end
					table.insert(DecayModeHit, hit.Parent)
					local coo = coroutine.wrap(function()
						wait(.1)
						table.remove(DecayModeHit, 1, hit.Parent)
					end)
					coo()
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 2*Strength.Value/2*DecayMultiplier)
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
				end)
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("BasePart") then
				for i,vv in pairs(script.ModeParticles:GetChildren()) do
					if vv.Name ~= "Damage" then
					local clone = vv:Clone()
					clone.Parent = v
					end
				end
			end
		end
		DecayMultiplier = 1.2
		repeat wait(.1)
		Stamina.Value = Stamina.Value - 5
		until DecayMode == false or Stamina.Value <= 5
		if DecayMode == true then
			DecayMode = false
		end
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("BasePart") then
				for i,vv in pairs(v:GetChildren()) do
					if vv.Name == "Decay" then
						vv:Destroy()
					end
				end
			end
		end
		DecayMultiplier = 1
		wait(10)
		DecayModeCD = false
		conected:Disconnect()
	elseif DecayMode == true then
		DecayMode = false
	end
end)

local DecayTouch = false
local DecayTouchCD = false
zz.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value >= 25 and DecayTouch == false and DecayTouchCD == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		DecayTouch = true
		DecayTouchCD = true
		local DecayTouchHit = {}
		local ctect
		ctect = Character.LeftHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name and DecayTouch == true then
					for i,tableValue in pairs(DecayTouchHit) do
						if tableValue == hit.Parent then return end
					end
					table.insert(DecayTouchHit, hit.Parent)
					local coo = coroutine.wrap(function()
						wait(.1)
						table.remove(DecayTouchHit, 1, hit.Parent)
					end)
					coo()
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 3*Strength.Value/2*DecayMultiplier)
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
				end)
		local PE = script.ModeParticles.Damage:Clone()
		PE.Parent = Character.LeftHand
		local coro = coroutine.wrap(function()
		wait(6)
		DecayTouch = false
		end)
		coro()
		DecayTouchStartAnim:Play()
		wait(0.4)
		DecayTouchLoopAnim:Play()
		repeat wait(.1)
			Stamina.Value = Stamina.Value - 1 
		until Stamina.Value < 5 or DecayTouch == false
		if DecayTouch == true then
			DecayTouch = false
		end
		PE.Enabled = false
		DecayTouchLoopAnim:Stop()
		DecayTouchStopAnim:Play()
		wait(0.4)
		Attack.Value = false
		DecayTouch = false
		ctect:Disconnect()
		PE:Destroy()
		wait(5)
		DecayTouchCD = false
	end
end)

zup.OnServerEvent:Connect(function()
	if DecayTouch == true then
		DecayTouch = false
	end
end)


local DecayCharge = false
local DecayChargeCD = false
xx.OnServerEvent:Connect(function()
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and DecayCharge == false and DecayChargeCD == false then
	Attack.Value = true
	Stamina.Value = Stamina.Value - 50	
	DecayCharge = true
	DecayChargeCD = true
	local conact
	conact = Humanoid.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and DecayCharge == true and hit.Parent.Name ~= Player.Name then
		if hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent) then
			else
						DecayCharge = false
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")

						local coro = coroutine.wrap(function()
							for i=1, 10 do wait(.1)
								DmgFunction:Fire(Character, hum, 6*Strength.Value/2*DecayMultiplier)	
							end
						end)
						coro()
						local PE = script.ModeParticles.Damage:Clone()
						PE.Parent = hit.Parent.UpperTorso
						game.Debris:AddItem(PE, 1)
						Exp.Value = Exp.Value + 150
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = RootPart.CFrame.lookVector * 250
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
	DecayChargeAnim:Play()
	local PE1 = script.ModeParticles.Damage:Clone()
	PE1.Parent = Character.RightHand
	local PE2 = script.ModeParticles.Damage:Clone()
	PE2.Parent = Character.LeftHand
	wait(.3)
	local BV = Instance.new("BodyVelocity", RootPart)
	BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	BV.Velocity = RootPart.CFrame.lookVector * 250
	wait(1.2)
	conact:Disconnect()
	DecayCharge = false
	BV:Destroy()
	PE1:Destroy()
	PE2:Destroy()
	Attack.Value = false
	wait(1)
	DecayChargeCD = false
	end
end)



local DecayThrow = false
local DecayThrowCD = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and DecayThrow == false and DecayThrowCD == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		DecayThrow = true
		DecayThrowCD = true
		local conectote
		conectote = Humanoid.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and DecayThrow == true and hit.Parent.Name ~= Player.Name  then
						DecayThrow = false
						DecayThrowMidAnim:Play()
						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
						local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
						hum.WalkSpeed = 0
						hum.JumpPower = 0
						Humanoid.WalkSpeed = 0
						Humanoid.JumpPower = 0
						RootPart.Anchored = true
						cantrun = true
						local PE = script.ModeParticles.Damage:Clone()
						PE.Parent = hit.Parent.UpperTorso
						game.Debris:AddItem(PE, 2)
						local coro = coroutine.wrap(function()
							for i=1, 10 do wait(.1)
								DmgFunction:Fire(Character, hum, 3*Strength.Value/2*DecayMultiplier)	
							end
						end)
						coro()
						wait(1)
						DecayThrowFinishAnim:Play()
						wait(.1)
						cantrun = false
						RootPart.Anchored = false
						Humanoid.WalkSpeed = 18
						Humanoid.JumpPower = 50
						hum.WalkSpeed = 18
						hum.JumpPower = 50
						DmgFunction:Fire(Character, hum, 40*Strength.Value/2*DecayMultiplier)
						Exp.Value = Exp.Value + 150
						local Velocity2 = Instance.new("BodyVelocity",HRT)
						Velocity2.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity2.Name = "Heavy"
						Velocity2.Velocity = RootPart.CFrame.lookVector * -100
						local ObjectVal = Instance.new("ObjectValue",Velocity2)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity2,1.5)
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
		DecayThrowStartAnim:Play()
		local PE = script.ModeParticles.Damage:Clone()
		PE.Parent = Character.RightHand
		game.Debris:AddItem(PE,1)
		wait(1)
		DecayThrow = false
		conectote:Disconnect()
		wait(0.5)
		Attack.Value = false
		wait(1)
		DecayThrowCD = false
		end
end)


local DecayFloor = false					
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 75 and DecayFloor == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 75
		DecayFloor = true
		DecayFloorAnim:Play()
		wait(0.3)
		local Floor = game.ServerStorage.DecayFloor:Clone()
		Floor.Parent = script
		Floor:SetPrimaryPartCFrame(RootPart.CFrame)
		game.Debris:AddItem(Floor, 5)
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				PlayersHitted = {}
				if Floor == nil or Floor:FindFirstChild("HB") == nil then
					break
				end
				connection = Floor.HB.Touched:Connect(function() end)
				results = Floor.HB:GetTouchingParts()
				connection:Disconnect()
				if true then
					for i=1,#results do
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i].Name == "HumanoidRootPart"  then
							if PlayersHitted[results[i].Parent] ~= nil then
         						return
							end
        					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, 25*Strength.Value/2*DecayMultiplier)
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
				lastresult = results
				end	
				wait(0.2)
			end
		end)
		expermentaltouch()			
		Attack.Value = false
		wait(4)
		for i,v in pairs(Floor.Effects:GetChildren()) do
			if v:IsA("Beam") or v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		wait(5)
		DecayFloor = false			
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
         					return
						end
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
        	 				return
						end
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
         					return
						end
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
         					return
						end
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
			lastresult = results
			end
		end
	end)
	touchedy()
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

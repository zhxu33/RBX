local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 7 then
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
local ElectricTouchAnim = Humanoid:LoadAnimation(AnimationsFolder.ElectricTouch)
local FullDischargeAnim = Humanoid:LoadAnimation(AnimationsFolder.FullDIscharge)
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
local ElectricCombat = false
local Block = false
local ElectricFloor = false
local ElectricTouch = false
local EleTeleport = false
local FullDischarge = false
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
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
local Left = script.oof:Clone()
Left.Parent = Character.LeftLowerLeg
Left.Anchored = false
local Right = script.oof:Clone()
Right.Parent = Character.RightLowerLeg
Right.Anchored = false
local LeftWeld = Instance.new("Motor6D",Left)
LeftWeld.Part0 = Left
LeftWeld.Part1 = Character.LeftLowerLeg
local RightWeld = Instance.new("Motor6D",Right)
RightWeld.Part0 = Right
RightWeld.Part1 = Character.RightLowerLeg
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
local zz = script:WaitForChild("Z")
local cc = script:WaitForChild("C")
local qq = script:WaitForChild("Q")
local xx = script:WaitForChild("X")
local vv = script:WaitForChild("V")
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							RightPunch = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
								if ElectricCombat == true then
									if HRT:FindFirstChild("Light") == nil then
										Exp.Value = Exp.Value + 50
										HitSound:Play()
										local Velocity = Instance.new("BodyVelocity",HRT)
										Velocity.MaxForce = Vector3.new(10000,10000,10000)
										Velocity.Name = "Light"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,.5)
									end
									local aaa = script.Particle:Clone()
									aaa.Parent = results[i].Parent.UpperTorso
									local Electrified = true
									local anim = hum:LoadAnimation(script.Electrified)
									anim:Play()
									local Corotot = coroutine.wrap(function()
									repeat wait()
									hum.WalkSpeed = 0
									hum.JumpPower = 0
									until Electrified == false
								end)
								Corotot()
								DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
								local dontstop = coroutine.wrap(function()
									wait(2)
									Electrified = false
									wait()
									hum.WalkSpeed = 18
									anim:Stop()
									hum.JumpPower = 50
									aaa:Destroy()
								end)
								dontstop()
							else
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
        	 			else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							LeftPunch = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if ElectricCombat == true then
									if HRT:FindFirstChild("Light") == nil then
										Exp.Value = Exp.Value + 50
										HitSound:Play()
										local Velocity = Instance.new("BodyVelocity",HRT)
										Velocity.MaxForce = Vector3.new(10000,10000,10000)
										Velocity.Name = "Light"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,.5)
									end
									local aaa = script.Particle:Clone()
									aaa.Parent = results[i].Parent.UpperTorso
									local Electrified = true
									local anim = hum:LoadAnimation(script.Electrified)
									anim:Play()
									local Corotot = coroutine.wrap(function()
									repeat wait()
									hum.WalkSpeed = 0
									hum.JumpPower = 0
									until Electrified == false
								end)
								Corotot()
								DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
								local dontstop = coroutine.wrap(function()
									wait(2)
									Electrified = false
									wait()
									hum.WalkSpeed = 18
									anim:Stop()
									hum.JumpPower = 50
									aaa:Destroy()
								end)
								dontstop()
							else
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
							RightKick = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if ElectricCombat == true then
									if HRT:FindFirstChild("Light") == nil then
										Exp.Value = Exp.Value + 50
										HitSound:Play()
										local Velocity = Instance.new("BodyVelocity",HRT)
										Velocity.MaxForce = Vector3.new(10000,10000,10000)
										Velocity.Name = "Light"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,.5)
									end
									local aaa = script.Particle:Clone()
									aaa.Parent = results[i].Parent.UpperTorso
									local Electrified = true
									local anim = hum:LoadAnimation(script.Electrified)
									anim:Play()
									local Corotot = coroutine.wrap(function()
									repeat wait()
									hum.WalkSpeed = 0
									hum.JumpPower = 0
									until Electrified == false
								end)
								Corotot()
								DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
								local dontstop = coroutine.wrap(function()
									wait(2)
									Electrified = false
									wait()
									hum.WalkSpeed = 18
									anim:Stop()
									hum.JumpPower = 50
									aaa:Destroy()
								end)
								dontstop()
							else
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         				else
						PlayersHitted[results[i].Parent] = results[i].Parent
        				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
        					LeftKick = false
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
							if ElectricCombat == true then
									if HRT:FindFirstChild("Light") == nil then
										Exp.Value = Exp.Value + 50
										HitSound:Play()
										local Velocity = Instance.new("BodyVelocity",HRT)
										Velocity.MaxForce = Vector3.new(10000,10000,10000)
										Velocity.Name = "Light"
										local ObjectVal = Instance.new("ObjectValue",Velocity)
										ObjectVal.Value = RootPart
										ObjectVal.Name = "Hitist"
										game.Debris:AddItem(Velocity,.5)
									end
									local aaa = script.Particle:Clone()
									aaa.Parent = results[i].Parent.UpperTorso
									local Electrified = true
									local anim = hum:LoadAnimation(script.Electrified)
									anim:Play()
									local Corotot = coroutine.wrap(function()
									repeat wait()
									hum.WalkSpeed = 0
									hum.JumpPower = 0
									until Electrified == false
								end)
								Corotot()
								DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
								local dontstop = coroutine.wrap(function()
									wait(2)
									Electrified = false
									wait()
									hum.WalkSpeed = 18
									anim:Stop()
									hum.JumpPower = 50
									aaa:Destroy()
								end)
								dontstop()
							else
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

	


local cool = false
zz.OnServerEvent:Connect(function()
	if ElectricCombat == false and cool == false then  
		ElectricCombat = true
		cool = true 
		local Light = script.ElecBall.PointLight:Clone()
		Light.Parent = Character.UpperTorso
		game.Debris:AddItem(Light,10)
		for i,v in pairs(Character:GetChildren()) do
				if v.ClassName == "MeshPart" then
					local elec = script.Particle:Clone()
					elec.Parent = v
					game.Debris:AddItem(elec,10)
				end
			end
		wait(10)
		ElectricCombat = false
		wait(10)
		cool = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Strength.Value >= 25 and Attack.Value == false and stunned == false and ElectricFloor == false and Stamina.Value >= 40 then
		Stamina.Value = Stamina.Value - 40
	    ElectricFloor = true
		local clone = script.Electric:Clone()
		clone.Parent = script
		clone.CFrame = RootPart.CFrame
		clone.Orientation = Vector3.new(0,0,90)
		game.Debris:AddItem(clone,3)
		TweenService:Create(clone, TweenInfo.new(1.25),{Size = clone.Size + Vector3.new(0,100,100)}):Play()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if clone == nil then
					break
				end
				connection = clone.Touched:Connect(function() end)
				results = clone:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
        						local Electrified2 = true
        						local aaa = script.Particle:Clone()
        						aaa.Parent = results[i].Parent.UpperTorso
        						local anim = hum:LoadAnimation(script.Electrified)
        						anim:Play()
        						local Corotot = coroutine.wrap(function()
        							repeat wait()
        							hum.WalkSpeed = 0
        							hum.JumpPower = 0
        							until Electrified2 == false
        						end)

        						Corotot()
        						if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = results[i].Parent.Head.CFrame.lookVector * -40
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
        						end
								local gunnyvaluename = coroutine.wrap(function()
        							wait(3)
        							Electrified2 = false
        							aaa:Destroy()
        							anim:Stop()
        							wait()
        							hum.WalkSpeed = 18
        							hum.JumpPower = 50
								end)
								gunnyvaluename()
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
wait(8)
ElectricFloor = false
	end
end)

local shootelectric = false
qq.OnServerEvent:Connect(function(play,position)
	if Attack.Value == false and stunned == false and Stamina.Value >= 20 and (RootPart.CFrame.p-position).Magnitude <= 200 and shootelectric == false then
		Attack.Value = true
		shootelectric = true
		Stamina.Value = Stamina.Value - 20
		local clone = script.ElecBall:Clone()
		local ringy = script.ringy:Clone()
		local clone2 = script.oof:Clone()
		clone2.Parent = script
		clone2.Trail.Enabled = true
		clone2.CFrame = RootPart.CFrame
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if clone == nil then
					break
				end
				connection = clone.Touched:Connect(function() end)
				results = clone:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
        						local Electrified2 = true
        						local aaa = script.Particle:Clone()
        						aaa.Parent = results[i].Parent.UpperTorso
        						local anim = hum:LoadAnimation(script.Electrified)
        						anim:Play()
        						local Corotot = coroutine.wrap(function()
        							repeat wait()
        							hum.WalkSpeed = 0
        							hum.JumpPower = 0
        							until Electrified2 == false
        						end)
        						Corotot()
        						if HRT:FindFirstChild("Light") == nil then
		 							Exp.Value = Exp.Value + 75
		 							local Velocity = Instance.new("BodyVelocity",HRT)
		 							Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		 							Velocity.Velocity = Vector3.new(0,50,0)
		 							Velocity.Name = "Light"
		 							local ObjectVal = Instance.new("ObjectValue",Velocity)
		 							ObjectVal.Value = RootPart
		 							ObjectVal.Name = "Hitist"
		 							game.Debris:AddItem(Velocity,.25)
        						end
								local zzzz = coroutine.wrap(function()
        							wait(2)
        							Electrified2 = false
        							aaa:Destroy()
        							anim:Stop()
        							wait()
        							hum.WalkSpeed = 18
        							hum.JumpPower = 50
								end)
								zzzz()
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
		wait(0.1)
		clone.Parent = script
		clone.CFrame = CFrame.new(position)
		ringy.Parent = script
		ringy.CFrame = CFrame.new(position)
		ringy.Orientation = Vector3.new(-90,0,0)
		clone2.CFrame = CFrame.new(position)
		TweenService:Create(clone, TweenInfo.new(0.5),{Transparency = 1, Size = clone.Size + Vector3.new(10,10,10)}):Play()
		TweenService:Create(ringy, TweenInfo.new(0.5),{Transparency = 1, Size = ringy.Size + Vector3.new(13,13,0)}):Play()
		wait(0.5)
		clone:Destroy()
		ringy:Destroy()
		clone2:Destroy()
		Attack.Value = false
		wait(2)
		shootelectric = false
	end
end)

cc.OnServerEvent:Connect(function(player,position)
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and (RootPart.CFrame.p-position).Magnitude <= 200 and EleTeleport == false then
		Attack.Value = true
		EleTeleport = true
		Stamina.Value = Stamina.Value - 50
		Right.Trail.Enabled = true
		Left.Trail.Enabled = true
		wait()
		local SafeTp = Instance.new("NumberValue",Character)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,.5)
		RootPart.CFrame = CFrame.new(position)*CFrame.new(0,5,0)
		local clone = script.ElecBall:Clone()
		local ringy = script.ringy:Clone()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if clone == nil then
					break
				end
				connection = clone.Touched:Connect(function() end)
				results = clone:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
        						local Electrified2 = true
        						local aaa = script.Particle:Clone()
        						aaa.Parent = results[i].Parent.UpperTorso
        						local anim = hum:LoadAnimation(script.Electrified)
        						anim:Play()
        						local Corotot = coroutine.wrap(function()
        							repeat wait()
        							hum.WalkSpeed = 0
        							hum.JumpPower = 0
        							until Electrified2 == false
        						end)
        						Corotot()
        						if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 75
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = Vector3.new(0,50,0)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
        						end
        						local sotired = coroutine.wrap(function()
        						wait(2)
        						Electrified2 = false
        						aaa:Destroy()
        						anim:Stop()
        						wait()
        						hum.WalkSpeed = 18
        						hum.JumpPower = 50
        						end)
        						sotired()
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
		clone.Parent = script
		clone.CFrame = RootPart.CFrame
		ringy.Parent = script
		ringy.CFrame = RootPart.CFrame
		ringy.Orientation = Vector3.new(-90,0,0)
		TweenService:Create(clone, TweenInfo.new(0.5),{Transparency = 1, Size = clone.Size + Vector3.new(10,10,10)}):Play()
		TweenService:Create(ringy, TweenInfo.new(0.5),{Transparency = 1, Size = ringy.Size + Vector3.new(13,13,0)}):Play()
		wait(0.5)
		Right.Trail.Enabled = false
		Left.Trail.Enabled = false
		clone:Destroy()
		ringy:Destroy()
		Attack.Value = false
		wait(2.5)
		EleTeleport = false
	end
end)

local FullCD = false 
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 150 and Attack.Value == false and stunned == false and Stamina.Value >= 75 and FullDischarge == false and FullCD == false then
		Stamina.Value = Stamina.Value - 75
		Attack.Value = true
		FullCD = true
		FullDischarge = true
		for i,v in pairs(Character:GetChildren()) do
				if v.ClassName == "MeshPart" then
					local elec = script.Particle:Clone()
					elec.Parent = v
					game.Debris:AddItem(elec,6)
				end
			end
		FullDischargeAnim:Play()
		wait(.1)
		local ef = script.ElectricEF:Clone()
		ef.Parent = script 
		ef.CFrame = RootPart.CFrame * CFrame.new(0,-2,0)
		local ef2 = script.ElectricEF2:Clone()
		ef2.Parent = script 
		ef2.CFrame = RootPart.CFrame * CFrame.new(0,-2,0)
		local eleball = script.ElecBall:Clone()
		eleball.Parent = script
		eleball.CFrame = RootPart.CFrame
		eleball.Transparency = 1
			local corot = coroutine.wrap(function()
	repeat wait()
			Humanoid.WalkSpeed = 0
			Humanoid.JumpPower = 0
			RootPart.Anchored = true
		until FullDischarge == false
end)
corot()
local corot = coroutine.wrap(function()
	while wait() do
		TweenService:Create(ef2, TweenInfo.new(0.75),{Transparency = 1}):Play()
		TweenService:Create(ef2.Mesh, TweenInfo.new(0.75),{Scale = ef2.Mesh.Scale + Vector3.new(15,15,15)}):Play()
		wait(0.75)
		ef2.Mesh.Scale = Vector3.new(1,3,1)
		ef2.Transparency = 0
	end
end)
corot()
		wait(2.5)
		eleball:Destroy()
		ef:Destroy()
		ef2:Destroy()
		local clone = script.ElecBall:Clone()
		local ringy = script.ringy:Clone()
		clone.Transparency = 0
		clone.Parent = script
		clone.PointLight.Range = 100
		clone.PointLight.Brightness = 10
		clone.CFrame = RootPart.CFrame*CFrame.new(0,-5,0)
		ringy.Parent = script
		ringy.CFrame = RootPart.CFrame
		ringy.Orientation = Vector3.new(-90,0,0)
		local PlayersHitted = {}
			local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if clone == nil then
					break
				end
				connection = clone.Touched:Connect(function() end)
				results = clone:GetTouchingParts()
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
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
        						local Electrified2 = true
        						local aaa = script.Particle:Clone()
        						aaa.Parent = results[i].Parent.UpperTorso
        						local anim = hum:LoadAnimation(script.Electrified)
        						anim:Play()
        						local Corotot = coroutine.wrap(function()
        							repeat wait()
        							hum.WalkSpeed = 0
        							hum.JumpPower = 0
        							until Electrified2 == false
        						end)
        						Corotot()
        						if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 200
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = Vector3.new(0,100,0)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.5)
        						end
        						local sleepsoundsnice = coroutine.wrap(function()
        						wait(5)
        						Electrified2 = false
        						aaa:Destroy()
        						anim:Stop()
        						wait()
        						hum.WalkSpeed = 18
        						hum.JumpPower = 50
        						end)
        						sleepsoundsnice()
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
		TweenService:Create(clone, TweenInfo.new(2),{Transparency = 1, Size = clone.Size + Vector3.new(200,200,200)}):Play()
		TweenService:Create(ringy, TweenInfo.new(2),{Transparency = 1, Size = ringy.Size + Vector3.new(250,250,20)}):Play()
		wait(2)
		ringy:Destroy()
		clone:Destroy()
		Attack.Value = false
		FullDischarge = false
		wait()
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		RootPart.Anchored = false
		    wait(15)
		    FullCD = false
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

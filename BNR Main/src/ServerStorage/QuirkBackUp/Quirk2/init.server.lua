local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 2 then
		script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
wait()
local AnimationsFolder = script.Animations
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block)
local TexasSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.TexasSmash)
local DetroitSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.DetroitSmash)
local CarolinaSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.CarolinaSmash)
local NewHampshireSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.NewHampshireSmash)
local USSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.USSmash)
local PunchAnim = {2313015622,2313016464,2313017174,2313014821} 
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
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
local NewHampshireSmash = false
local DetroitSmash = false
local TexasSmash = false
local USSmash = false
local CarolinaSmash = false
local Run = false
local Training = false
local cantrun = false
local Shift = false
local PlusUltra = false
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

local cc = script:WaitForChild("C")
local ee = script:WaitForChild("E")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local vv = script:WaitForChild("V")
local qq = script:WaitForChild("Q")
local tt = script:WaitForChild("T")
local ff = script:WaitForChild("F")
local space = script:WaitForChild("Space")
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

local PlusUltraLight = script.PointLight
PlusUltraLight.Parent = Character.UpperTorso
local PlusUltraMultipler = 1
local PlusUltraCD = false
ff.OnServerEvent:Connect(function()
	if Agility.Value >= 1000 and Strength.Value >= 1000 and Durability.Value >= 1000 and PlusUltra == false and Stamina.Value >= 100 and PlusUltraCD == false then
		PlusUltraCD = true
		PlusUltraLight.Enabled = true
		PlusUltra = true
		PlusUltraMultipler = 1.2
		cantrun = true
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
				local lightning = script.Lightning:Clone()
				lightning.Parent = v
			end
		end
		Humanoid.BodyHeightScale.Value = 1.5
		Humanoid.BodyWidthScale.Value = 1.5
		Humanoid.BodyDepthScale.Value = 1.5
		Humanoid.HeadScale.Value = 1.5
		local coro = coroutine.wrap(function()
			repeat wait(.5) 
			Stamina.Value = Stamina.Value - 25
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 160
			else
			Humanoid.WalkSpeed = 40 + 0.06 * Agility.Value	
			end
			Humanoid.JumpPower = 150
			until PlusUltra == false or Stamina.Value < 25
			PlusUltra = false
			PlusUltraMultipler = 1
			PlusUltraLight.Enabled = false
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
				v:FindFirstChild("Lightning"):Destroy()
			end
		end
		cantrun = false
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		Humanoid.BodyHeightScale.Value = 1
		Humanoid.BodyWidthScale.Value = 1
		Humanoid.BodyDepthScale.Value = 1
		Humanoid.HeadScale.Value = 1
		PlusUltraCD = true
		wait(10)
		PlusUltraCD = false
		end)
		coro()
	elseif PlusUltra == true then
		PlusUltra = false
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
	elseif picked == 3 then
	RightKick = true
	Attack.Value = true
	wait(0.7)
	Attack.Value = false
	RightKick = false
	elseif picked == 4 then
	LeftKick = true
	Attack.Value = true
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
			
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightPunch == true then
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*PlusUltraMultipler)
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
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftPunch == true then
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
			game.Debris:AddItem(Velocity,.5)
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*PlusUltraMultipler)
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

Character.RightFoot.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightKick == true then
RightKick = false
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*PlusUltraMultipler)
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
				

Character.LeftFoot.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftKick == true then
LeftKick = false
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*PlusUltraMultipler)
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

xx.OnServerEvent:Connect(function(play,direc)
	if Durability.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value > 50 and NewHampshireSmash == false then
		Stamina.Value = Stamina.Value - 50
		Attack.Value = true
		NewHampshireSmash = true
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direc.p)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Humanoid.AutoRotate = false
		NewHampshireSmashAnim:Play()
		wait(.5)
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = .7
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local bv = Instance.new("BodyVelocity",RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Name = "NewHampshireSmash"
		bv.Velocity = direc.lookVector * 250
		game.Debris:AddItem(bv, 1)
		local NewHampShireModel = game.ServerStorage.NewHampshireSmash:Clone()
		NewHampShireModel.Parent = script
		NewHampShireModel.CFrame = RootPart.CFrame * CFrame.Angles(math.rad(0),math.rad(90),math.rad(180))
		local bv2 = Instance.new("BodyVelocity", NewHampShireModel)
		bv2.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv2.Velocity = RootPart.CFrame.lookVector * -125
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
		local PlayersHitted = {}
		NewHampShireModel.Touched:connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 45*Strength.Value/2*PlusUltraMultipler)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.7)
						Velocity.Velocity = bv2.Velocity
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
		HitPart.Touched:Connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2*PlusUltraMultipler)
					local MuscleExplosion = game.ServerStorage.MuscleExplosion:Clone()
					MuscleExplosion.CFrame = HRT.CFrame
					MuscleExplosion.Parent = script
					game.Debris:AddItem(MuscleExplosion,0.5)
					TweenService:Create(MuscleExplosion,TweenInfo.new(0.5),{Transparency = 1, Size = Vector3.new(65,65,65)}):Play()
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = RootPart.CFrame.lookVector * -150
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.5)
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
		local coo = coroutine.wrap(function()
		repeat wait()
			NewHampShireModel.CFrame = NewHampShireModel.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
		until NewHampShireModel == nil
		end)
		coo()
		wait(1)
		Attack.Value = false
		TweenService:Create(NewHampShireModel,TweenInfo.new(1), {Transparency = 1}):Play()
		Humanoid.AutoRotate = true
		wait(1)
		NewHampShireModel:Destroy()
		wait(5)
		NewHampshireSmash = false
	end
end)

cc.OnServerEvent:Connect(function()
	if Strength.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value > 100 and DetroitSmash == false then
		Attack.Value = true
		DetroitSmashAnim:Play()
		Stamina.Value = Stamina.Value-100
		DetroitSmash = true
		Attack.Value = true
		wait(0.4)
		local detroit = game.ServerStorage.NewDetroit:Clone()
		detroit.Parent = script
		detroit:SetPrimaryPartCFrame(RootPart.CFrame)
		local sound2 = Instance.new("Sound")
		sound2.SoundId = "rbxassetid://157878578"
		sound2.MaxDistance = 300
		sound2.EmitterSize = 20
		sound2.Volume = .5
		sound2.Pitch = 0.9
		sound2.Parent = RootPart
		sound2:Play()
		game.Debris:AddItem(sound2, 5)
		local PlayersHitted = {}
		detroit.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 70*Strength.Value/2*PlusUltraMultipler)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
						Velocity.Velocity = Vector3.new(0,50,0)
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
		TweenService:Create(detroit.Effect,TweenInfo.new(1.5), {Size = Vector3.new(340, 300, 350),Position = detroit.Effect.Position + Vector3.new(0,120,0)}):Play()
		TweenService:Create(detroit.Tornado,TweenInfo.new(1.5), {Size = Vector3.new(400, 250, 400),Position = detroit.HB.Position + Vector3.new(0,100,0)}):Play()
		TweenService:Create(detroit.HB,TweenInfo.new(1.5), {Size = Vector3.new(250, 250, 250),Position = detroit.HB.Position + Vector3.new(0,100,0)}):Play()
		local coo = coroutine.wrap(function()
		repeat wait()
			detroit.Effect.CFrame = detroit.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			detroit.Tornado.CFrame = detroit.Tornado.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until Attack.value == false or detroit == nil
		end)
		coo()
		wait(3)
		TweenService:Create(detroit.Effect,TweenInfo.new(0.5), {Transparency = 1}):Play()
		TweenService:Create(detroit.Tornado,TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		detroit:Destroy()
		Attack.Value = false
		wait(8)
		DetroitSmash = false
	end
end)

qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 50 and TexasSmash == false then
		TexasSmashAnim:Play()
		Stamina.Value = Stamina.Value-50
		TexasSmash = true
		Attack.Value = true
		wait(1)
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 1
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local shok = game.ServerStorage.TexasSmash2:Clone()
		shok:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,5,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
		shok.Parent = script
		local Effect = shok.ShockEffect
		Effect.Anchored = true
		local Effect3 = shok.Effect3
		Effect3.Anchored = true
		local Effect4 = shok.Effect4
		Effect4.Anchored = true
		local Effect2 = game.ServerStorage.Shockwave3:Clone()
		Effect2.Parent = script
		Effect2.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Effect2.Anchored = true
		Effect2.Size = Vector3.new(60,8,60)
		local bv = Instance.new("BodyVelocity", shok.HB)
		bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 125
		local PlayersHitted = {}
		shok.HB.Touched:connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2*PlusUltraMultipler)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.7)
						Velocity.Velocity = bv.Velocity
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
		local pp = true
		local coo = coroutine.wrap(function()
		repeat wait()
			shok.HB.CFrame = shok.HB.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			Effect.CFrame = Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			Effect2.CFrame = Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			Effect3.CFrame = Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect4.CFrame = Effect4.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until pp == false and shok == nil
		end)
		coo()
		TweenService:Create(Effect,TweenInfo.new(3), {Size = Vector3.new(100,240,240)}):Play()
		TweenService:Create(Effect2,TweenInfo.new(3), {Size = Vector3.new(166,27,166)}):Play()
		TweenService:Create(Effect3,TweenInfo.new(3), {Size = Vector3.new(190, 53, 190)}):Play()
		TweenService:Create(Effect4,TweenInfo.new(3), {Size = Vector3.new(250, 83, 250)}):Play()
		wait(1.5)
		Attack.Value = false
		TweenService:Create(Effect,TweenInfo.new(1.5), {Transparency = 1}):Play()
		TweenService:Create(Effect2,TweenInfo.new(1.5), {Transparency = 1}):Play()
		TweenService:Create(Effect3,TweenInfo.new(1.5), {Transparency = 1}):Play()
		TweenService:Create(Effect4,TweenInfo.new(1.5), {Transparency = 1}):Play()
		for i,v in pairs(shok:GetChildren()) do
			TweenService:Create(v,TweenInfo.new(1.5), {Transparency = 1}):Play()
		end
		wait(1.5)
		shok:Destroy()
		Effect2:Destroy()
		pp = false
		wait(5)
		TexasSmash = false
	end
end)


vv.OnServerEvent:Connect(function()
	if Strength.Value >= 1000 and Attack.Value == false and stunned == false and Stamina.Value > 200 and USSmash == false then
		Attack.Value = true
		USSmashAnim:Play()
		Stamina.Value = Stamina.Value-200
		USSmash = true
		Attack.Value = true
		wait(.8)
		local USSClone = game.ServerStorage.NewUSS:Clone()
		USSClone.Parent = script
		if PlusUltra == false then
		USSClone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,2.5,0))
		elseif PlusUltra == true then
		USSClone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,1,0))
		end
		game.Debris:AddItem(USSClone, 6)
		local sound2 = Instance.new("Sound")
		sound2.SoundId = "rbxassetid://157878578"
		sound2.MaxDistance = 300
		sound2.EmitterSize = 20
		sound2.Volume = 1.5
		sound2.Pitch = 0.9
		sound2.Parent = RootPart
		sound2:Play()
		game.Debris:AddItem(sound2, 5)
		local PlayersHitted = {}
		USSClone.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name and USSClone.Shockwave.Transparency < 1 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 90*Strength.Value/2*PlusUltraMultipler)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
						Velocity.Velocity = Vector3.new(0,75,0)
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
		local coo = coroutine.wrap(function()
		repeat wait()
		USSClone.Coil.CFrame = USSClone.Coil.CFrame*CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		USSClone.Shockwave.CFrame = USSClone.Shockwave.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
		until USSClone == nil
		end)
		coo()
		wait(1.5)
		TweenService:Create(USSClone.Coil, TweenInfo.new(2), {Transparency = 1}):Play()
		TweenService:Create(USSClone.Shockwave, TweenInfo.new(2), {Transparency = 1}):Play()
		Attack.Value = false
		wait(25)
		USSmash = false
	end
end)

zz.OnServerEvent:Connect(function()
	if Agility.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value > 75 and CarolinaSmash == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value-75
		CarolinaSmash = true
		CarolinaSmashAnim:Play()
		Humanoid.AutoRotate = false
		wait(.2)
		local bv = Instance.new("BodyVelocity",RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Name = "CarolinaDash"
		bv.Velocity = RootPart.CFrame.lookVector * 300
		game.Debris:AddItem(bv, .5)
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 0.5
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local CarolinaModel = game.ServerStorage.CarolinaSmash:Clone()
		CarolinaModel.Parent = script
		CarolinaModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0)))
		local Effect2 = game.ServerStorage.Shockwave3:Clone()
		Effect2.Parent = script
		Effect2.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Effect2.Transparency = .4
		Effect2.Anchored = true
		local PlayersHitted = {}
		CarolinaModel.HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				for i,tableValue in pairs(PlayersHitted) do
					if tableValue == hit.Parent then return end
				end
				table.insert(PlayersHitted, hit.Parent)
				local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
				if HRT:FindFirstChild("Light") == nil then
					Exp.Value = Exp.Value + 100
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					Velocity.Name = "Heavy"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.5)
					Velocity.Velocity = RootPart.CFrame.lookVector*100
					DmgFunction:Fire(Character, hum, 55*Strength.Value/2*PlusUltraMultipler)
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
		TweenService:Create(CarolinaModel.Effect,TweenInfo.new(2), {Size = Vector3.new(200, 200, 100),CFrame = CarolinaModel.Effect.CFrame*CFrame.new(0,0,250)}):Play()
		TweenService:Create(CarolinaModel.HB,TweenInfo.new(2), {Size = Vector3.new(200, 200, 100),CFrame = CarolinaModel.HB.CFrame*CFrame.new(0,0,250)}):Play()
		TweenService:Create(Effect2,TweenInfo.new(1.5), {Size = Vector3.new(200,30,200),Transparency = 1}):Play()
		game.Debris:AddItem(Effect2,1.5)
		wait(1.5)
		TweenService:Create(CarolinaModel.Effect,TweenInfo.new(0.5), {Transparency = 1}):Play()
		game.Debris:AddItem(CarolinaModel,0.5)
		Attack.Value = false
		Humanoid.AutoRotate = true
		wait(5)
		CarolinaSmash = false
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


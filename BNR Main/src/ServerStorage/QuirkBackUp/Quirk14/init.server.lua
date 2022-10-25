local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 14 then
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
local HardenDashAnim = Humanoid:LoadAnimation(AnimationsFolder.HardeningDash)
local QuakeAnim = Humanoid:LoadAnimation(AnimationsFolder.HardenQuake)
local RedCounterAnim = Humanoid:LoadAnimation(AnimationsFolder.RedCounter)
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
local HardenQuake = false
local Run = false
local cantrun = false
local Shift = false
local HardenDash = false
local HardenMode = false
local Unbreakable = false
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
		if RootPart:FindFirstChild("Light") and stunned == false and cantrun == false and HardenMode == false then
		elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false then
			stunned = true
			local asdfg = false
			Attack.Value = true
			HvyStunnedAnim:Play()
			Humanoid.WalkSpeed = 0
			Humanoid.JumpPower = 0
			if HardenMode == true then 
				for i = 1,3 do
				if asdfg == true or not RootPart:FindFirstChild("Heavy") then
					break
				else
					wait(.2)
				end
				end
			elseif Unbreakable == true then 
			else 
				for i = 1,3 do
				if asdfg == true or not RootPart:FindFirstChild("Heavy") then
					break
				else
					wait(.75)
				end
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
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local qq = script:WaitForChild("Q")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")

local HardeningMultiplier = 1
zz.OnServerEvent:Connect(function()
	if HardenMode == false and Unbreakable == false and Attack.Value == false and stunned == false then
		Attack.Value = true
		HardeningMultiplier = 1.3
		HardenMode = true
		Defense.Value = 1.5
			local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
	local HardeningModel = game.ServerStorage.HardeningFirstMode:Clone()
	HardeningModel.Parent = script
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") and v.Name ~= "Head" then 
				local clone = HardeningModel:FindFirstChild(v.Name)
				clone.Parent = v
				clone.BrickColor = v.BrickColor
				local Weld = Instance.new("Weld", clone)
				Weld.Part0 = clone
				Weld.Part1 = v
			end
		end
	HardeningModel:Destroy()
	wait(1)
	Attack.Value = false
	elseif HardenMode == true and Attack.Value == false and stunned == false then
		HardeningMultiplier = 1
		Defense.Value = 1
		HardenMode = false
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") and v.Name ~= "Head" then 
				v:FindFirstChild(v.Name):Destroy()
			end
		end
	end
end)

local UnBreakableCD = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 200 and Unbreakable == false and UnBreakableCD == false and Attack.Value == false and stunned == false then
		Unbreakable = true
		Defense.Value = 2
		UnBreakableCD = true
		HardeningMultiplier = 1.6
		local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
		if HardenMode == true then
		HardenMode = false
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") and v.Name ~= "Head" then 
				v:FindFirstChild(v.Name):Destroy()
			end
		end
		end
	local HardeningModel = game.ServerStorage.HardeningSecondMode:Clone()
	HardeningModel.Parent = script
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") and v.Name ~= "Head" then 
				local clone = HardeningModel:FindFirstChild(v.Name)
				clone.Parent = v
				clone.BrickColor = v.BrickColor
				local Weld = Instance.new("Motor6D", clone)
				Weld.Part0 = v
				Weld.Part1 = clone
				if clone:FindFirstChildOfClass("UnionOperation") then
					clone:FindFirstChildOfClass("UnionOperation").BrickColor = v.BrickColor
				end
			end
		end
	HardeningModel:Destroy()
repeat wait(.1) 
Stamina.Value = Stamina.Value - 3
until Unbreakable == false or Stamina.Value < 3
HardeningMultiplier = 1
		Defense.Value = 1
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") and v.Name ~= "Head" then 
				v:FindFirstChild(v.Name):Destroy()
			end
		end
		wait(10)
		UnBreakableCD = false
	elseif Unbreakable == true and Attack.Value == false and stunned == false then
		Unbreakable = false
	end
end)

local RedCounter = false
qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and RedCounter == false and Stamina.Value >= 25 then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 25
		RedCounter = true
		RedCounterAnim:Play()
		if Unbreakable == false and HardenMode == false then
		local HardeningModel = game.ServerStorage.HardeningFirstMode:Clone()
		HardeningModel.Parent = script
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightHand" or v.Name == "RightUpperArm" or v.Name == "RightLowerArm" then 
				local clone = HardeningModel:FindFirstChild(v.Name)
				clone.Parent = v
				clone.BrickColor = v.BrickColor
				local Weld = Instance.new("Weld", clone)
				Weld.Part0 = clone
				Weld.Part1 = v
				game.Debris:AddItem(clone,1.5)
			end
		end
	HardeningModel:Destroy()
	end
	wait(.2)
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(1.5, 3, 1.5)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		HitPart.Massless = true
		game.Debris:AddItem(HitPart,.6)
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = Character.RightUpperArm
		local PlayersHitted = {}
		HitPart.Touched:Connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 45*Strength.Value/2*HardeningMultiplier)
					local MuscleExplosion = game.ServerStorage.HardeningRock:Clone()
					MuscleExplosion.CFrame = HRT.CFrame
					MuscleExplosion.Parent = script
					game.Debris:AddItem(MuscleExplosion,0.5)
					TweenService:Create(MuscleExplosion, TweenInfo.new(0.7), {Transparency = 1, CFrame = MuscleExplosion.CFrame * CFrame.new(0,0,0), Size = MuscleExplosion.Size + Vector3.new(60,60,60)}):Play()
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = RootPart.CFrame.lookVector * 50
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
		wait(1)
		Attack.Value = false
		wait(2)
		RedCounter = false
	end
end)

cc.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and HardenQuake == false and Stamina.Value > 40  and HardenMode == true
	or Strength.Value >= 100 and Attack.Value == false and stunned == false and HardenQuake == false and Stamina.Value > 40  and Unbreakable == true then
		Attack.Value = true
		HardenQuake = true
		Stamina.Value = Stamina.Value - 40
		QuakeAnim:Play()
		wait(.4)
		local Clone = game.ServerStorage.HardeningRocks:Clone()
		Clone.Parent = script
		Clone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-15)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(270)))
		local PlayersHitted = {}
			Clone.PrimaryPart.Touched:connect(function(hit)
						if hit.Parent.Name == Player.Name then
							else if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
								for i,tableValue in pairs(PlayersHitted) do
									if tableValue == hit.Parent then return end
								end
								table.insert(PlayersHitted, hit.Parent)
								local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
								local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 55*Strength.Value/2*HardeningMultiplier)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,2)
									Velocity.Velocity = RootPart.CFrame.lookVector * 60
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
						end
					end)
			for i,v in pairs(Clone:GetChildren()) do
				TweenService:Create(v, TweenInfo.new(1.5), {Transparency = 1, CFrame = v.CFrame * CFrame.new(34,0,0), Size = v.Size + Vector3.new(100,80,100)}):Play()
			end
		wait(1.5)
		Clone:Destroy()
		Attack.Value = false
		wait(6)
		HardenQuake = false
	end
end)

xx.OnServerEvent:Connect(function(play,direc)
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and HardenDash == false and Stamina.Value > 30  and HardenMode == true
	or Strength.Value >= 50 and Attack.Value == false and stunned == false and HardenDash == false and Stamina.Value > 30  and Unbreakable == true then
		Attack.Value = true
		HardenDash = true
		Humanoid.AutoRotate = false
		HardenDashAnim:Play()
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direc.p)
		wait(.2)
		Humanoid.Jump = true
		wait()
		local bv = Instance.new("BodyVelocity",RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Name = "HardenDash"
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
		local PlayersHitted = {}
		HitPart.Touched:Connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2*HardeningMultiplier)
					local MuscleExplosion = game.ServerStorage.HardeningRock:Clone()
					MuscleExplosion.CFrame = HRT.CFrame
					MuscleExplosion.Parent = script
					game.Debris:AddItem(MuscleExplosion,0.5)
					TweenService:Create(MuscleExplosion, TweenInfo.new(0.7), {Transparency = 1, CFrame = MuscleExplosion.CFrame * CFrame.new(0,0,0), Size = MuscleExplosion.Size + Vector3.new(60,60,60)}):Play()
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						Velocity.Velocity = RootPart.CFrame.lookVector * 150
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
		wait(1.5)
		HardenDashAnim:Stop()
		Attack.Value = false
		Humanoid.AutoRotate = true
		Humanoid.JumpPower = 50
		wait(5)
		HardenDash = false
	end
end)

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	if HardenMode == true then
	Defense.Value = 4.5
	elseif Unbreakable == true then
	Defense.Value = 6
	else
	Defense.Value = 3
	end
	Stamina.Value = Stamina.Value - 2
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	end)
	coo()
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	if HardenMode == true then
	Defense.Value = 1.5
	elseif Unbreakable == true then
	Defense.Value = 2
	else
	Defense.Value = 1
	end
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
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
			DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
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

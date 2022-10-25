local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 13 then
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
local MillSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.MillSmash)
local StLouisAnim = Humanoid:LoadAnimation(AnimationsFolder.StLouis) 
local KickSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.KickSmash) 
local BigSmashAnim = Humanoid:LoadAnimation(AnimationsFolder.BIgSmash) 
local StompAnim = Humanoid:LoadAnimation(AnimationsFolder.Stomp) 
local SmashAnim = Humanoid:LoadAnimation(AnimationsFolder.Smash) 
local DelawareAnim = Humanoid:LoadAnimation(AnimationsFolder.Delaware) 
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
local FullCowl = false
local MillionSmash = false
local PercentSmash = false
local Detroit = false
local Delaware = false
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
local space = script:WaitForChild("Space")

local FingersBroken = 0
local LegBroken = false
local ArmBroken = false
local corot = coroutine.wrap(function()
	while wait(.5) do
		if FingersBroken == 5 then
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightHand" or v.Name == "LeftHand" then
				local clone = v:Clone()
				clone.Parent = v
				clone.Size = clone.Size + Vector3.new(.05,.05,.05)
				clone.BrickColor = BrickColor.new("Maroon")
				clone.TextureID = ""
				local Weld = Instance.new("Weld", clone)
				Weld.Part0 = Character:FindFirstChild(v.Name)
				Weld.Part1 = clone 
				game.Debris:AddItem(clone, 10)
				game.Debris:AddItem(Weld, 10)
			end
		end
		wait(10)
		FingersBroken = 0
		end
	end
end)
corot()

local FullCowlLight = script.PointLight
local FullCowlCD = false
FullCowlLight.Parent = Character.UpperTorso
local FullCowlPercent = 0
ff.OnServerEvent:Connect(function()
	if Attack.Value == false and Strength.Value >= 500 and Agility.Value >= 500 and Durability.Value >= 500 and FullCowl == false and FullCowlCD == false then
		FullCowlLight.Enabled = true
		FullCowl = true
		FullCowlCD = true
		cantrun = true
		if LegBroken == true then
			LegBroken = false
			cantrun = false
			for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "RightFoot" or v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "LeftFoot" then
				v:FindFirstChild(v.Name):Destroy()
			end
			end
		end
		if FingersBroken == 5 then
			FingersBroken = 0 
			for i,v in pairs(Character:GetChildren()) do
			if v.Name == "LeftHand" or v.Name == "RightHand" then
				v:FindFirstChild(v.Name):Destroy()
				end
			end
		end
		if ArmBroken == true then
			ArmBroken = false
			for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "RightHand" then
				v:FindFirstChild(v.Name):Destroy()
				end
			end
		end
		if Strength.Value >= 2000 and Durability.Value >= 2000 and Agility.Value >= 2000 then
		FullCowlPercent = 100
		game.Chat:Chat(Character,"One For All...Full Cowling 100%!","White")
		--local coo = coroutine.wrap(function()
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("BasePart")then
				local lightning = script.Lightning2:Clone()
				lightning.Parent = v
				lightning.Enabled = true
				lightning.Rate = 20
				wait()
			end
		end
		--end)
		--coo()
		--for i,v in pairs(Character:GetChildren()) do
		--	if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
		--		local lightning = script.Lightning:Clone()
		--		lightning.Parent = v
		--		lightning.Enabled = true
		--		lightning.Rate = 40
		--	end
		--end
		local FullCowlEyes = game.ServerStorage.FullCowlEyes:Clone()
		for i,v in pairs(FullCowlEyes:GetChildren()) do
			v.Parent = Character.Head
		end
		elseif Strength.Value >= 1000 and Durability.Value >= 1000 and Agility.Value >= 1000 then
		FullCowlPercent = 50
		game.Chat:Chat(Character,"One For All...Full Cowling 50%!","White")
		--local coo = coroutine.wrap(function()
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("BasePart")then
				local lightning = script.Lightning2:Clone()
				lightning.Parent = v
				lightning.Enabled = true
				lightning.Rate = 12
				wait()
			end
		end
		--end)
		--coo()
		--for i,v in pairs(Character:GetChildren()) do
		--	if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
		--		local lightning = script.Lightning:Clone()
		--		lightning.Parent = v
		--		lightning.Enabled = true
		--		lightning.Rate = 30
		--	end
		--end
		else
		FullCowlPercent = 20
		game.Chat:Chat(Character,"One For All...Full Cowling 20%!","White")
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightLowerArm" or v.Name == "Head" or  v.Name == "RightLowerLeg" or  v.Name == "LeftLowerArm" or  v.Name == "LeftLowerLeg" then
				local lightning = script.Lightning:Clone()
				lightning.Parent = v
				lightning.Enabled = true
			end
		end
		end
		local coro = coroutine.wrap(function()
			repeat wait(.5) 
			if FullCowlPercent == 20 then
			Stamina.Value = Stamina.Value - 10
			Humanoid.JumpPower = 100
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 140
			else
			Humanoid.WalkSpeed = 40 + 0.05 * Agility.Value	
			end
			elseif FullCowlPercent == 50 then
			Stamina.Value = Stamina.Value - 20
			Humanoid.JumpPower = 130
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 160
			else
			Humanoid.WalkSpeed = 40 + 0.06 * Agility.Value	
			end
			elseif FullCowlPercent == 100 then
			Stamina.Value = Stamina.Value - 40
			Humanoid.JumpPower = 160
			if Agility.Value >= 2000 then
			Humanoid.WalkSpeed = 180
			else
			Humanoid.WalkSpeed = 40 + 0.07 * Agility.Value	
			end
			end
			until FullCowl == false or Stamina.Value < 25
			FullCowl = false
			FullCowlPercent = 0
			cantrun = false
			Humanoid.WalkSpeed = 18
			Humanoid.JumpPower = 50
		FullCowlLight.Enabled = false
		for i,v in pairs(Character:GetDescendants()) do
			if v:IsA("ParticleEmitter") and v.Name == "Lightning" and v.Enabled == true
			or v:IsA("ParticleEmitter") and v.Name == "Lightning2" and v.Enabled == true
			or v:IsA("Attachment") and v.Name == "FullCowlAttachment" then
				v:Destroy()
			end
		end
		FullCowlCD = true
		wait(10)
		FullCowlCD = false
		end)
		coro()
	elseif FullCowl == true then
		FullCowl = false
	end
end)

function BreakLeg()
	local coro = coroutine.wrap(function()
	cantrun = true
	Humanoid.WalkSpeed = 18
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "RightFoot" or v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "LeftFoot" then
				local clone = v:Clone()
				clone.Parent = v
				clone.Size = clone.Size + Vector3.new(.05,.05,.05)
				clone.BrickColor = BrickColor.new("Maroon")
				clone.TextureID = ""
				local Weld = Instance.new("Weld", clone)
				Weld.Part0 = Character:FindFirstChild(v.Name)
				Weld.Part1 = clone 
				game.Debris:AddItem(clone, 10)
				game.Debris:AddItem(Weld, 10)
			end
		end
	wait(10)
	LegBroken = false
	cantrun = false
	end)
	coro()
end

function BreakArm()
	local coro = coroutine.wrap(function()
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "RightHand" then
				local clone = v:Clone()
				clone.Parent = v
				clone.Size = clone.Size + Vector3.new(.05,.05,.05)
				clone.BrickColor = BrickColor.new("Maroon")
				clone.TextureID = ""
				local Weld = Instance.new("Weld", clone)
				Weld.Part0 = Character:FindFirstChild(v.Name)
				Weld.Part1 = clone 
				game.Debris:AddItem(clone, 10)
				game.Debris:AddItem(Weld, 10)
			end
		end
	wait(10)
	ArmBroken = false
	end)
	coro()
end

local StLouisSmash = false
qq.OnServerEvent:Connect(function()
	if Attack.Value == false and StLouisSmash == false and stunned == false and Stamina.Value >= 50 and LegBroken == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		StLouisSmash = true
		StLouisAnim:Play()
		wait(0.2)
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 0.5
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local Clone = game.ServerStorage.StLouisSmash:Clone()
		Clone.Parent = script
		Clone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
		local Effect2 = game.ServerStorage.Shockwave3:Clone()
		Effect2.Parent = script
		Effect2.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Effect2.Transparency = 1
		Effect2.Anchored = true
		local PlayersHitted = {}
			Clone.HB.Touched:Connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if Character:FindFirstChild("IronSole") then
					DmgFunction:Fire(Character, hum, 54*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 45*Strength.Value/2)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.5)
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
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
		TweenService:Create(Clone.Shock,TweenInfo.new(1), {Size = Vector3.new(15.6, 69.482, 151.906),Position = (Clone.HB.CFrame*CFrame.new(100,27,0)).p+Vector3.new(0,-12,0)}):Play()
		TweenService:Create(Clone.HB,TweenInfo.new(1), {Size = Vector3.new(98.76, 69.484, 131.348),CFrame = Clone.HB.CFrame*CFrame.new(100,27,0)}):Play()
		TweenService:Create(Effect2,TweenInfo.new(1), {Size = Vector3.new(200,27,200),Transparency = 1}):Play()
		TweenService:Create(Clone.Effect,TweenInfo.new(1), {Size = Vector3.new(22.524, 7.516, 54.491)}):Play()
		TweenService:Create(Clone.Effect2,TweenInfo.new(1), {Size = Vector3.new(85.168, 6.875, 141.308)}):Play()
		TweenService:Create(Clone.Effect3,TweenInfo.new(1), {Size = Vector3.new(11.825, 15.541, 63.118)}):Play()
		wait(.5)
		TweenService:Create(Clone.Shock,TweenInfo.new(0.5), {Transparency = 1}):Play()
		TweenService:Create(Clone.Effect,TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(Clone.Effect2,TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(Clone.Effect3,TweenInfo.new(.5), {Transparency = 1}):Play()
		wait(.5)
		Clone:Destroy()
		Effect2:Destroy()
		Attack.Value = false
		wait(3)
		StLouisSmash = false
	end
end)

vv.OnServerEvent:Connect(function()
	if Strength.Value >= 1000 and Attack.Value == false and MillionSmash == false and stunned == false and Stamina.Value >= 200 and ArmBroken == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 200
		MillionSmash = true
		MillSmashAnim:Play()
		wait(.8)
		local cd = 0
		if FullCowlPercent ~= 100 then
		ArmBroken = true
		BreakArm()
		cd = 10
		end
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 1.5
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local MillSmash = game.ServerStorage.MillSmash:Clone()
		MillSmash.Parent = script
		MillSmash:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
		local Effect2 = game.ServerStorage.Shockwave3:Clone()
		Effect2.Parent = script
		Effect2.CFrame = RootPart.CFrame*CFrame.new(0,2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Effect2.Anchored = true
		Effect2.Size = Vector3.new(270,36,270)
		Effect2.Transparency = 1
		local bv = Instance.new("BodyVelocity", MillSmash.HB)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 100
		local PlayersHitted = {}
		MillSmash.HB.Touched:connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if Character:FindFirstChild("AirForceGlove") then
					DmgFunction:Fire(Character, hum, 108*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 90*Strength.Value/2)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,1)
						Velocity.Velocity = RootPart.CFrame.lookVector * 150
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
		MillSmash.HB.CFrame = MillSmash.HB.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect3.CFrame = MillSmash.Effect3.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect5.CFrame = MillSmash.Effect5.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect6.CFrame = MillSmash.Effect6.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect7.CFrame = MillSmash.Effect7.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect8.CFrame = MillSmash.Effect8.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect9.CFrame = MillSmash.Effect9.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect10.CFrame = MillSmash.Effect10.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect11.CFrame = MillSmash.Effect11.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		MillSmash.Effect12.CFrame = MillSmash.Effect12.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		until MillSmash == false or MillSmash == nil
		end)
		coo()
		for i,v in pairs(MillSmash:GetChildren()) do
			if string.find(v.Name,"Effect") then
				if string.find(v.Name, "3") or string.find(v.Name, "5") or string.find(v.Name, "6") 
				or string.find(v.Name, "7") or string.find(v.Name, "8") or string.find(v.Name, "9") then
				TweenService:Create(v,TweenInfo.new(3),{Size = Vector3.new(v.Size.x*1.9,v.Size.y*1.3,v.Size.z*1.9)}):Play()	
				else
				TweenService:Create(v,TweenInfo.new(3),{Size = v.Size*1.9}):Play()
				end
			end
		end
		TweenService:Create(MillSmash.Effect,TweenInfo.new(3),{CFrame = MillSmash.Effect.CFrame*CFrame.new(0,0,50)}):Play()
		TweenService:Create(MillSmash.Effect2,TweenInfo.new(3),{CFrame = MillSmash.Effect2.CFrame*CFrame.new(0,0,50)}):Play()
		TweenService:Create(Effect2,TweenInfo.new(3), {Size = Vector3.new(450,70,450),CFrame = Effect2.CFrame*CFrame.new(0,5,0)}):Play()
		wait(1.5)
		Attack.Value = false
		for i,v in pairs(MillSmash:GetChildren()) do
			TweenService:Create(v, TweenInfo.new(1.5),{Transparency = 1}):Play()
		end
		TweenService:Create(Effect2,TweenInfo.new(1.5), {Transparency = 1}):Play()
		wait(1.5)
		Effect2:Destroy()
		MillSmash:Destroy()
		wait(25+cd)
		MillionSmash = false 
	end
end)

cc.OnServerEvent:Connect(function()
	if Strength.Value >= 750 and Attack.Value == false and Detroit == false and stunned == false and Stamina.Value >= 100 and LegBroken == false then
		if FullCowl == false then
		LegBroken = true
		end
		Stamina.Value = Stamina.Value - 100
		Detroit = true
		Attack.Value = true
		StompAnim:Play()
		wait(.4)
		local cd = 0
		if FullCowlPercent ~= 50 and FullCowlPercent ~= 100 then
		BreakLeg()
		cd = 10
		end
		local sound2 = Instance.new("Sound")
		sound2.SoundId = "rbxassetid://157878578"
		sound2.MaxDistance = 300
		sound2.EmitterSize = 20
		sound2.Volume = 0.4
		sound2.Pitch = 0.9
		sound2.Parent = RootPart
		sound2:Play()
		game.Debris:AddItem(sound2, 5)
		local Clone = game.ServerStorage.ManchesterSmash:Clone()
		Clone.Parent = script
		Clone:SetPrimaryPartCFrame(RootPart.CFrame)
		Clone.Effect6.Transparency = 1
		local PlayersHitted = {}
		Clone.HB.Touched:connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if Character:FindFirstChild("IronSole") then
					DmgFunction:Fire(Character, hum, 84*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 70*Strength.Value/2)
					end
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
		TweenService:Create(Clone.Effect, TweenInfo.new(.75),{Size = Vector3.new(13, 103, 88),Position = Clone.Effect.Position + Vector3.new(0,15,0)}):Play()
		TweenService:Create(Clone.Effect2, TweenInfo.new(.75),{Size = Vector3.new(25, 77, 43),Position = Clone.Effect2.Position + Vector3.new(0,12.5,0)}):Play()
		TweenService:Create(Clone.Effect3, TweenInfo.new(.75),{Size = Vector3.new(87, 59, 56),Position = Clone.Effect3.Position + Vector3.new(0,10,0)}):Play()
		TweenService:Create(Clone.Effect4, TweenInfo.new(.75),{Size = Vector3.new(51, 87, 75),Position = Clone.Effect4.Position + Vector3.new(0,15,0)}):Play()
		TweenService:Create(Clone.Effect5, TweenInfo.new(.75),{Size = Vector3.new(52, 6, 148),Position = Clone.Effect5.Position + Vector3.new(0,1.5,0)}):Play()
		TweenService:Create(Clone.Effect6, TweenInfo.new(.75),{Size = Vector3.new(125, 23, 109),Position = Clone.Effect6.Position + Vector3.new(0,3.5,0)}):Play()
		TweenService:Create(Clone.Tornado, TweenInfo.new(1.5),{Size = Vector3.new(280, 80, 280),Position = Clone.Tornado.Position + Vector3.new(0,15,0)}):Play()
		TweenService:Create(Clone.Tornado2, TweenInfo.new(1.5),{Size = Vector3.new(200, 150, 200),Position = Clone.Tornado2.Position + Vector3.new(0,40,0)}):Play()
		TweenService:Create(Clone.HB, TweenInfo.new(1.5),{Size = Vector3.new(200, 150, 200),Position = Clone.HB.Position + Vector3.new(0,25,0)}):Play()
		local coo = coroutine.wrap(function()
		repeat wait()
		Clone.Tornado.CFrame = Clone.Tornado.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		Clone.Tornado2.CFrame = Clone.Tornado2.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until Attack.Value == false or Clone == nil
		end)
		coo()
		wait(.5)
		TweenService:Create(Clone.Effect, TweenInfo.new(.5),{Transparency = 1}):Play()
		TweenService:Create(Clone.Effect2, TweenInfo.new(.5),{Transparency = 1}):Play()
		TweenService:Create(Clone.Effect3, TweenInfo.new(.5),{Transparency = 1}):Play()
		TweenService:Create(Clone.Effect4, TweenInfo.new(.5),{Transparency = 1}):Play()
		TweenService:Create(Clone.Effect5, TweenInfo.new(.5),{Transparency = 1}):Play()
		TweenService:Create(Clone.Effect6, TweenInfo.new(.5),{Transparency = 1}):Play()
		wait(1.5)
		TweenService:Create(Clone.Tornado,TweenInfo.new(0.5), {Transparency = 1}):Play()
		TweenService:Create(Clone.Tornado2,TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(.5)
		Clone:Destroy()
		Attack.Value = false
		wait(8+cd)
		Detroit = false
	end
end)

local SmashAmount = 0
zz.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and PercentSmash == false and stunned == false and Stamina.Value >= 75 and ArmBroken == false then
		Attack.Value = true
		PercentSmash = true
		Stamina.Value = Stamina.Value - 75
		SmashAnim:Play()
		wait(1)
		local cd = 0
		if SmashAmount < 2 and FullCowlPercent == 0 then
			SmashAmount = SmashAmount + 1
			if SmashAmount == 2 then
				SmashAmount = 0
				ArmBroken = true
				BreakArm()
				cd = 10
			end
		end
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 1
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local shok = game.ServerStorage.TexasSmash3:Clone()
		shok:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,5,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
		shok.Parent = script
		shok.Effect3.Transparency = 1
		shok.Effect4.Transparency = 1
		local Effect = shok.Effect5
		Effect.Anchored = true
		local Effect3 = shok.Effect6
		Effect3.Anchored = true
		local Effect4 = shok.Effect7
		Effect4.Anchored = true
		local Effect5 = shok.Effect8
		Effect5.Anchored = true
		local Effect6 = shok.Effect9
		Effect6.Anchored = true
		local Effect7 = shok.Effect10
		Effect7.Anchored = true
		local Effect8 = shok.Effect11
		Effect8.Anchored = true
		local Effect2 = game.ServerStorage.Shockwave3:Clone()
		Effect2.Parent = script
		Effect2.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Effect2.Anchored = true
		Effect2.Size = Vector3.new(60,8,60)
		Effect2.Transparency = 1
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
					if Character:FindFirstChild("AirForceGlove") then
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
					end
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
		local coo = coroutine.wrap(function()
		repeat wait()
			shok.HB.CFrame = shok.HB.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			Effect.CFrame = Effect.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect2.CFrame = Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			Effect3.CFrame = Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect4.CFrame = Effect4.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect5.CFrame = Effect5.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect6.CFrame = Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until shok == nil
		end)
		coo()
		TweenService:Create(Effect,TweenInfo.new(3), {Size = Vector3.new(300, 30, 300)}):Play()
		TweenService:Create(Effect2,TweenInfo.new(3), {Size = Vector3.new(166,27,166)}):Play()
		TweenService:Create(Effect3,TweenInfo.new(3), {Size = Vector3.new(200, 30, 200)}):Play()
		TweenService:Create(Effect4,TweenInfo.new(3), {Size = Vector3.new(189, 15, 189)}):Play()
		TweenService:Create(Effect5,TweenInfo.new(3), {Size = Vector3.new(220, 20, 220)}):Play()
		TweenService:Create(Effect6,TweenInfo.new(3), {Size = Vector3.new(225, 30, 225)}):Play()
		TweenService:Create(Effect7,TweenInfo.new(3), {Size = Vector3.new(106, 16, 126)}):Play()
		TweenService:Create(Effect8,TweenInfo.new(3), {Size = Vector3.new(54, 31, 215)}):Play()
		wait(1.5)
		Attack.Value = false
		TweenService:Create(Effect2,TweenInfo.new(1.5), {Transparency = 1}):Play()
		for i,v in pairs(shok:GetChildren()) do
			TweenService:Create(v,TweenInfo.new(1.5), {Transparency = 1}):Play()
		end
		wait(1.5)
		shok:Destroy()
		Effect2:Destroy()
		wait(5+cd)
		PercentSmash = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Strength.Value >= 500 and Strength.Value >= 50 and Attack.Value == false and Delaware == false and stunned == false and Stamina.Value >= 50 and FingersBroken < 5 and ArmBroken == false then
		Attack.Value = true
		Delaware = true
		DelawareAnim:Play()
		Stamina.Value = Stamina.Value - 50
		if FullCowlPercent ~= 100 and FullCowlPercent ~= 50 then
		FingersBroken = FingersBroken + 1
		elseif FullCowlPercent == 50 then
		FingersBroken = FingersBroken + .5
		end
		wait(.4)
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 0.5
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, 5)
		local DelawareModel = game.ServerStorage.NewDelaware:Clone()
		DelawareModel.Parent = script
		DelawareModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
		local Effect2 = game.ServerStorage.Shockwave3:Clone()
		Effect2.Parent = script
		Effect2.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Effect2.Transparency = 1
		Effect2.Anchored = true
		Effect2.Size = Vector3.new(75,10,75)
		local bv = Instance.new("BodyVelocity", DelawareModel.HB)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 100
		local PlayersHitted = {}
		DelawareModel.HB.Touched:connect(function(hit)
				if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if Character:FindFirstChild("AirForceGlove") then
					DmgFunction:Fire(Character, hum, 48*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						Velocity.Name = "Heavy"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.75)
						Velocity.Velocity = RootPart.CFrame.lookVector * 75
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
		DelawareModel.HB.CFrame = DelawareModel.HB.CFrame *CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		DelawareModel.Effect.CFrame = DelawareModel.Effect.CFrame *CFrame.Angles(math.rad(29),math.rad(0),math.rad(0))
		until Delaware == false or DelawareModel == nil
		end)
		coo()
		TweenService:Create(DelawareModel.Effect, TweenInfo.new(2),{Size = Vector3.new(176, 170, 170)}):Play()
		TweenService:Create(DelawareModel.Effect2, TweenInfo.new(2),{Size = Vector3.new(62, 9, 72)}):Play()
		TweenService:Create(DelawareModel.Effect3, TweenInfo.new(2),{Size = Vector3.new(30, 17, 125)}):Play()
		TweenService:Create(Effect2,TweenInfo.new(2), {Size = Vector3.new(200,27,200)}):Play()
		wait(1)
		Attack.Value = false
		TweenService:Create(DelawareModel.Effect, TweenInfo.new(1),{Transparency = 1}):Play()
		TweenService:Create(DelawareModel.Effect2, TweenInfo.new(1),{Transparency = 1}):Play()
		TweenService:Create(DelawareModel.Effect3, TweenInfo.new(1),{Transparency = 1}):Play()
		TweenService:Create(DelawareModel.Shock, TweenInfo.new(1),{Transparency = 1}):Play()
		TweenService:Create(Effect2,TweenInfo.new(1), {Transparency = 1}):Play()
		wait(1)
		DelawareModel:Destroy()
		Effect2:Destroy()
		Delaware = false 
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

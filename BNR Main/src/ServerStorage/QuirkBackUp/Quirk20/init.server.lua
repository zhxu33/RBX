local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 20 then
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
local ToolType = Character:WaitForChild("ToolType")
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

local DarkShadowEnable = false
local DarkBody = false
local DarkShadowModel = script:WaitForChild("DarkShadow")
local DarkMultiplier = 1
local DarkShadowSmoke = DarkShadowModel:WaitForChild("Torso"):WaitForChild("mist")
local ShadowRootPart = DarkShadowModel:WaitForChild("Lowertorso")
local Weld = Instance.new("Motor6D", ShadowRootPart)
Weld.Part0 = RootPart
Weld.Part1 = ShadowRootPart
Weld.C0 = Weld.C0*CFrame.new(0,0,-1.5)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
DarkShadowModel.Parent = Character
local DarkShadowAnim = Humanoid:LoadAnimation(AnimationsFolder.SummonShadow)
local IdleShadowAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowIdle)
local ShadowSlamAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowSlam)
local ShadowSlam2Anim = Humanoid:LoadAnimation(AnimationsFolder.ShadowSlam2)
local ShadowBarrageAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowBarrage)
local ShadowBarrage2Anim = Humanoid:LoadAnimation(AnimationsFolder.ShadowBarrage2)
local ShadowGrabAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowGrab)
local ShadowGrabFinishAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowGrabFinish)
local ShadowGrab2Anim = Humanoid:LoadAnimation(AnimationsFolder.ShadowGrab2)
local ShadowGrabFinish2Anim = Humanoid:LoadAnimation(AnimationsFolder.ShadowGrabFinish2)
local ShadowSlamAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowSlam)
local DarkSlash_1Anim = Humanoid:LoadAnimation(AnimationsFolder.DarkSlash_1)
local DarkSlash_2Anim = Humanoid:LoadAnimation(AnimationsFolder.DarkSlash_2)
local DarkSlash2_1Anim = Humanoid:LoadAnimation(AnimationsFolder.DarkSlash2_1)
local DarkSlash2_2Anim = Humanoid:LoadAnimation(AnimationsFolder.DarkSlash2_2)
local SuperSlashAnim = Humanoid:LoadAnimation(AnimationsFolder.SuperSlash)
local SuperSlash2Anim = Humanoid:LoadAnimation(AnimationsFolder.SuperSlash2)
local ShadowBlockAnim = Humanoid:LoadAnimation(AnimationsFolder.ShadowBlock)
local FlightAnim = Humanoid:LoadAnimation(AnimationsFolder.Flight)
local Flight2Anim = Humanoid:LoadAnimation(AnimationsFolder.Flight2)
IdleShadowAnim:Play()
for i,v in pairs(DarkShadowModel["Hand left"]:GetChildren()) do
	if v:IsA("Trail") then
		v.Enabled = false
	end
end
for i,v in pairs(DarkShadowModel["Hand right"]:GetChildren()) do
	if v:IsA("Trail") then
		v.Enabled = false
	end
end

local AbysalBody = script:WaitForChild("AbysalBody")
local BodyMist = AbysalBody:WaitForChild("UpperTorso"):WaitForChild("mist")
local Weld2 = Instance.new("Weld", AbysalBody.Head)
Weld2.Part0 = AbysalBody.Head
Weld2.Part1 = Character.Head
Weld2.C0 = Weld2.C0 * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
local Weld3 = Instance.new("Weld", AbysalBody.UpperTorso)
Weld3.Part0 = AbysalBody.UpperTorso
Weld3.Part1 = Character.UpperTorso
Weld3.C0 = Weld3.C0 * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
local Weld4 = Instance.new("Weld", AbysalBody.LeftUpperArm)
Weld4.Part0 = AbysalBody.LeftUpperArm
Weld4.Part1 = Character.LeftUpperArm
Weld4.C0 = Weld4.C0 * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
local Weld5 = Instance.new("Weld", AbysalBody.LeftLowerArm)
Weld5.Part0 = AbysalBody.LeftLowerArm
Weld5.Part1 = Character.LeftLowerArm
Weld5.C0 = Weld5.C0 * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
local Weld6 = Instance.new("Weld", AbysalBody.RightUpperArm)
Weld6.Part0 = AbysalBody.RightUpperArm
Weld6.Part1 = Character.RightUpperArm
Weld6.C0 = Weld6.C0 * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
local Weld7 = Instance.new("Weld", AbysalBody.RightLowerArm)
Weld7.Part0 = AbysalBody.RightLowerArm
Weld7.Part1 = Character.RightLowerArm
Weld7.C0 = Weld7.C0 * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
local Weld8 = Instance.new("Weld", AbysalBody.LeftFinger1)
Weld8.Part0 = AbysalBody.LeftFinger1
Weld8.Part1 = Character.LeftHand
Weld8.C0 = Weld8.C0 * CFrame.new(0,0,.5)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
local Weld9 = Instance.new("Weld", AbysalBody.RightFinger1)
Weld9.Part0 = AbysalBody.RightFinger1
Weld9.Part1 = Character.RightHand
Weld9.C0 = Weld9.C0 * CFrame.new(0,0,-.5) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
for i,v in pairs(DarkShadowModel:GetChildren()) do
		v.Transparency = 1 
end
for i,v in pairs(AbysalBody:GetChildren()) do
	if v:IsA("BasePart") then
		v.Transparency = 1 
	end
end
for i,v in pairs(DarkShadowModel["Hand right"]:GetChildren()) do
	if v:IsA("Trail") then
		v.Enabled = false
	end
end
for i,v in pairs(DarkShadowModel["Hand left"]:GetChildren()) do
	if v:IsA("Trail") then
		v.Enabled = false
	end
end
for i,v in pairs(AbysalBody["RightLowerArm"]:GetChildren()) do
	if v:IsA("Trail") then
		v.Enabled = false
	end
end
for i,v in pairs(AbysalBody["LeftLowerArm"]:GetChildren()) do
	if v:IsA("Trail") then
		v.Enabled = false
	end
end

local Coro = coroutine.wrap(function()
	while wait() do
		if not Character:FindFirstChild("Safezone") and Block == false then
		if RootPart:FindFirstChild("Light") and stunned == false and cantrun == false then
		elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false then
		if DarkBody == false then
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
		elseif DarkBody == true then
			wait(0.25)
			if RootPart:FindFirstChild("Heavy") then
				RootPart:FindFirstChild("Heavy"):Destroy()
			end
			end
		end
		end
	end
end)
Coro()

Humanoid.Died:Connect(function()
	DarkShadowModel:Destroy()
end)

local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local zz = script:WaitForChild("Z")
local xx =  script:WaitForChild("X")
local cc = script:WaitForChild("C")
local qq = script:WaitForChild("Q")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")
local Space = script:WaitForChild("Space")
local SpaceOn = script:WaitForChild("SpaceOn")
local plr = game.Players:FindFirstChild(Player.Name)

zz.OnServerEvent:Connect(function()
	if Attack.Value == false and DarkShadowEnable == false and DarkBody == false then
		DarkShadowEnable = true
		DarkShadowSmoke.Enabled = true
		DarkShadowAnim:Play()
		for i,v in pairs(DarkShadowModel:GetChildren()) do
		v.Transparency = 0
		end
	elseif Attack.Value == false and DarkShadowEnable == true then
		DarkShadowEnable = false
		DarkShadowSmoke.Enabled = false
		for i,v in pairs(DarkShadowModel:GetChildren()) do
		v.Transparency = 1
		end
	elseif Attack.Value == false and DarkBody == true then
		DarkBody = false
	end
end)

local SlashType = 1
local LeftSlash = false
local RightSlash = false
local ShadowStrike = false
qq.OnServerEvent:Connect(function()
	if DarkShadowEnable == true and ShadowStrike == false and Attack.Value == false and stunned == false and Stamina.Value >= 10 then 
		Attack.Value = true
		Stamina.Value = Stamina.Value - 10
		ShadowStrike = true
		SuperSlashAnim:Play()
		wait(.5)
		local ShadowSmashModel = game.ServerStorage.ShadowSmash:Clone()
		ShadowSmashModel.Parent = script
		ShadowSmashModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		local PlayersHitted = {}
			ShadowSmashModel.HB.Touched:Connect(function(hit)
				if hit.Parent.Name ~=  Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 42*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2*DarkMultiplier)
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
		TweenService:Create(ShadowSmashModel.Effect, TweenInfo.new(1),{Transparency = 1, Size = ShadowSmashModel.Effect.Size*5}):Play()
		TweenService:Create(ShadowSmashModel.Effect2, TweenInfo.new(1),{Transparency = 1, Size = ShadowSmashModel.Effect2.Size*5}):Play()
		TweenService:Create(ShadowSmashModel.HB, TweenInfo.new(1),{Transparency = 1, Size = ShadowSmashModel.HB.Size*5}):Play()
		game.Debris:AddItem(ShadowSmashModel,1)
		wait(1)
		for i,v in pairs(DarkShadowModel["Hand right"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
		end
		for i,v in pairs(DarkShadowModel["Hand left"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
		end
		Attack.Value = false
		wait(2)
		ShadowStrike = false
		elseif DarkBody == true and ShadowStrike == false and Attack.Value == false and stunned == false and Stamina.Value >= 10 then 
		Attack.Value = true
		Stamina.Value = Stamina.Value - 10
		ShadowStrike = true
		SuperSlash2Anim:Play()
		wait(.5)
		local ShadowSmashModel = game.ServerStorage.ShadowSmash:Clone()
		ShadowSmashModel.Parent = script
		ShadowSmashModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		local PlayersHitted = {}
			ShadowSmashModel.HB.Touched:Connect(function(hit)
				if hit.Parent.Name ~=  Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 42*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2*DarkMultiplier)
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
		TweenService:Create(ShadowSmashModel.Effect, TweenInfo.new(1),{Transparency = 1, Size = ShadowSmashModel.Effect.Size*5}):Play()
		TweenService:Create(ShadowSmashModel.Effect2, TweenInfo.new(1),{Transparency = 1, Size = ShadowSmashModel.Effect2.Size*5}):Play()
		TweenService:Create(ShadowSmashModel.HB, TweenInfo.new(1),{Transparency = 1, Size = ShadowSmashModel.HB.Size*5}):Play()
		game.Debris:AddItem(ShadowSmashModel,1)
		wait(1)
		for i,v in pairs(DarkShadowModel["Hand right"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
		end
		for i,v in pairs(DarkShadowModel["Hand left"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
		end
		Attack.Value = false
		wait(2)
		ShadowStrike = false
	end
end)


local ShadowBarrage = false
xx.OnServerEvent:Connect(function(play,direction)
	if Strength.Value >= 50 and Stamina.Value >= 50 and Attack.Value == false and stunned == false and ShadowBarrage == false and DarkShadowEnable == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		ShadowBarrage = true
		ShadowBarrageAnim:Play()
		for i=1, 8 do wait(.275)
		local ShadowSmashModel = game.ServerStorage.ShadowSmash:Clone()
		ShadowSmashModel.Parent = script
		ShadowSmashModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		local PlayersHitted = {}
			ShadowSmashModel.HB.Touched:Connect(function(hit)
				if hit.Parent.Name ~=  Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 12*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 10*Strength.Value/2*DarkMultiplier)
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
		TweenService:Create(ShadowSmashModel.Effect, TweenInfo.new(0.75),{Transparency = 1, Size = ShadowSmashModel.Effect.Size*4}):Play()
		TweenService:Create(ShadowSmashModel.Effect2, TweenInfo.new(0.75),{Transparency = 1, Size = ShadowSmashModel.Effect2.Size*4}):Play()
		TweenService:Create(ShadowSmashModel.HB, TweenInfo.new(0.75),{Transparency = 1, Size = ShadowSmashModel.HB.Size*4}):Play()
		game.Debris:AddItem(ShadowSmashModel,.75)
		end
		wait(1)
		Attack.Value = false
		wait(6)
		ShadowBarrage = false
		elseif Strength.Value >= 50 and Stamina.Value >= 50 and Attack.Value == false and stunned == false and ShadowBarrage == false and DarkBody == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		ShadowBarrage = true
		ShadowBarrage2Anim:Play()
		for i=1, 8 do wait(.275)
		local ShadowSmashModel = game.ServerStorage.ShadowSmash:Clone()
		ShadowSmashModel.Parent = script
		ShadowSmashModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		local PlayersHitted = {}
			ShadowSmashModel.HB.Touched:Connect(function(hit)
				if hit.Parent.Name ~=  Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 12*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 10*Strength.Value/2*DarkMultiplier)
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
		TweenService:Create(ShadowSmashModel.Effect, TweenInfo.new(0.75),{Transparency = 1, Size = ShadowSmashModel.Effect.Size*4}):Play()
		TweenService:Create(ShadowSmashModel.Effect2, TweenInfo.new(0.75),{Transparency = 1, Size = ShadowSmashModel.Effect2.Size*4}):Play()
		TweenService:Create(ShadowSmashModel.HB, TweenInfo.new(0.75),{Transparency = 1, Size = ShadowSmashModel.HB.Size*4}):Play()
		game.Debris:AddItem(ShadowSmashModel,.75)
		end
		wait(1)
		Attack.Value = false
		wait(6)
		ShadowBarrage = false
	end
end)

local ShadowSlam = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 75 and ShadowSlam == false and DarkShadowEnable == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 75
		ShadowSlam = true
		ShadowSlamAnim:Play()
		wait(.5)
		local SlamModel = game.ServerStorage.DarkShadowSlam2:Clone()
		SlamModel.Parent = script
		SlamModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0))
		local PlayersHitted = {}
		SlamModel.HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2*DarkMultiplier)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = Vector3.new(0,50,0)
						Velocity.Name = "Heavy"
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
		SlamModel.Effect.CFrame = SlamModel.Effect.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		SlamModel.Effect2.CFrame = SlamModel.Effect2.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		SlamModel.Effect3.CFrame = SlamModel.Effect3.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		until Attack.Value == false or SlamModel == nil
		end)
		coo()
		TweenService:Create(SlamModel.Effect, TweenInfo.new(1), {Size = SlamModel.Effect.Size*5, Position = SlamModel.Effect.Position + Vector3.new(0,18,0)}):Play()
		TweenService:Create(SlamModel.Effect2, TweenInfo.new(1), {Size = SlamModel.Effect2.Size*5, Position = SlamModel.Effect2.Position + Vector3.new(0,18,0)}):Play()
		TweenService:Create(SlamModel.Effect3, TweenInfo.new(1), {Size = SlamModel.Effect3.Size*5, Position = SlamModel.Effect3.Position + Vector3.new(0,18,0)}):Play()
		TweenService:Create(SlamModel.HB, TweenInfo.new(1), {Size = SlamModel.HB.Size*5, Position = SlamModel.HB.Position + Vector3.new(0,18,0)}):Play()
		wait(.5)
		TweenService:Create(SlamModel.Effect, TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(SlamModel.Effect2, TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(SlamModel.Effect3, TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(SlamModel.HB, TweenInfo.new(.5), {Transparency = 1}):Play()
		wait(.5)
		SlamModel:Destroy()
		Attack.Value = false
		wait(6)
		ShadowSlam = false
		elseif Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 75 and ShadowSlam == false and DarkBody == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 75
		ShadowSlam = true
		ShadowSlam2Anim:Play()
		wait(.5)
		local SlamModel = game.ServerStorage.DarkShadowSlam2:Clone()
		SlamModel.Parent = script
		SlamModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0))
		local PlayersHitted = {}
		SlamModel.HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 50*Strength.Value/2*DarkMultiplier)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = Vector3.new(0,50,0)
						Velocity.Name = "Heavy"
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
		SlamModel.Effect.CFrame = SlamModel.Effect.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		SlamModel.Effect2.CFrame = SlamModel.Effect2.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		SlamModel.Effect3.CFrame = SlamModel.Effect3.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		until Attack.Value == false or SlamModel == nil
		end)
		coo()
		TweenService:Create(SlamModel.Effect, TweenInfo.new(1), {Size = SlamModel.Effect.Size*5, Position = SlamModel.Effect.Position + Vector3.new(0,18,0)}):Play()
		TweenService:Create(SlamModel.Effect2, TweenInfo.new(1), {Size = SlamModel.Effect2.Size*5, Position = SlamModel.Effect2.Position + Vector3.new(0,18,0)}):Play()
		TweenService:Create(SlamModel.Effect3, TweenInfo.new(1), {Size = SlamModel.Effect3.Size*5, Position = SlamModel.Effect3.Position + Vector3.new(0,18,0)}):Play()
		TweenService:Create(SlamModel.HB, TweenInfo.new(1), {Size = SlamModel.HB.Size*5, Position = SlamModel.HB.Position + Vector3.new(0,18,0)}):Play()
		wait(.5)
		TweenService:Create(SlamModel.Effect, TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(SlamModel.Effect2, TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(SlamModel.Effect3, TweenInfo.new(.5), {Transparency = 1}):Play()
		TweenService:Create(SlamModel.HB, TweenInfo.new(.5), {Transparency = 1}):Play()
		wait(.5)
		SlamModel:Destroy()
		Attack.Value = false
		wait(6)
		ShadowSlam = false
	end
end)

local ShadowGrab = false
local ShadowExplodeStart = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and ShadowGrab == false and DarkShadowEnable == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		ShadowGrab = true
		ShadowGrabAnim:Play()
		Humanoid.AutoRotate = false
		ShadowExplodeStart = false
		wait(.3)
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 250
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(10,2,10)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		HitPart.Massless = true
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = RootPart
		game.Debris:AddItem(HitPart,1.5)
		local Hitted = false
		HitPart.Touched:Connect(function(hitto)
				if not hitto:IsDescendantOf(Character) and Hitted == false then
					if not hitto.Parent:FindFirstChild("Humanoid") and hitto.CanCollide == false then return end
					Hitted = true
					if hitto.Parent.Name ~= Player.Name and hitto.Parent:FindFirstChild("Humanoid") and hitto.Parent:FindFirstChild("Humanoid").Health > 0 then
					game.Debris:AddItem(BV,.4)
					local hum2 = hitto.Parent:FindFirstChildOfClass("Humanoid")
					local HRT2 = hitto.Parent:FindFirstChild("HumanoidRootPart")
					local Velocity = Instance.new("BodyVelocity",HRT2)
					Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					Velocity.Name = "Heavy"
					Velocity.Velocity = BV.Velocity
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.5)
					end
			end
		end)
		local coroo = coroutine.wrap(function()
		repeat wait() until Hitted == true or ShadowExplodeStart == true
		Hitted = true
		ShadowExplodeStart = true
		HitPart:Destroy()
		if ShadowExplodeStart == true then
			BV:Destroy()
		else
			game.Debris:AddItem(BV,.4)
		end
		ShadowGrabAnim:Stop()
		ShadowGrabFinishAnim:Play()
		wait(.8)
		local ShadowExplosion = game.ServerStorage.DarkShadowExplosion2:Clone()
		ShadowExplosion.Parent = script
		ShadowExplosion:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-40))
		local coo = coroutine.wrap(function()
		repeat wait()
		ShadowExplosion.Effect.CFrame =  ShadowExplosion.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect2.CFrame =  ShadowExplosion.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect3.CFrame =  ShadowExplosion.Effect3.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect4.CFrame =  ShadowExplosion.Effect4.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect5.CFrame =  ShadowExplosion.Effect5.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect6.CFrame = ShadowExplosion.Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until ShadowExplosion.HB == nil 
		end)
		coo()
		local PlayersHitted = {}
		ShadowExplosion.HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 70*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 65*Strength.Value/2*DarkMultiplier)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector*75
						Velocity.Name = "Heavy"
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
		TweenService:Create(ShadowExplosion.Effect, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect2, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect2.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect3, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect3.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect4, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect4.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect5, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect5.Size*8,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect6, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect6.Size*8,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.HB, TweenInfo.new(1.5), {Size = ShadowExplosion.HB.Size*8}):Play()
		game.Debris:AddItem(ShadowExplosion,1.5)
		end)
		coroo()
		wait(1.2)
		if Hitted == false then
			Hitted = true
		end
		wait(1)
		Attack.Value = false
		Humanoid.AutoRotate = true
		wait(8)
		ShadowGrab = false
		elseif Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 100 and ShadowGrab == false and DarkBody == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		ShadowGrab = true
		ShadowGrab2Anim:Play()
		Humanoid.AutoRotate = false
		ShadowExplodeStart = false
		wait(.3)
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 250
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(10,2,10)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		HitPart.Massless = true
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = RootPart
		game.Debris:AddItem(HitPart,1.5)
		local Hitted = false
		HitPart.Touched:Connect(function(hitto)
				if not hitto:IsDescendantOf(Character) and Hitted == false then
					if not hitto.Parent:FindFirstChild("Humanoid") and hitto.CanCollide == false then return end
					Hitted = true
					if hitto.Parent.Name ~= Player.Name and hitto.Parent:FindFirstChild("Humanoid") and hitto.Parent:FindFirstChild("Humanoid").Health > 0 then
					game.Debris:AddItem(BV,.4)
					local hum2 = hitto.Parent:FindFirstChildOfClass("Humanoid")
					local HRT2 = hitto.Parent:FindFirstChild("HumanoidRootPart")
					local Velocity = Instance.new("BodyVelocity",HRT2)
					Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					Velocity.Name = "Heavy"
					Velocity.Velocity = BV.Velocity
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.5)
					end
			end
		end)
		local coroo = coroutine.wrap(function()
		repeat wait() until Hitted == true or ShadowExplodeStart == true
		Hitted = true
		ShadowExplodeStart = true
		HitPart:Destroy()
		if ShadowExplodeStart == true then
			BV:Destroy()
		else
			game.Debris:AddItem(BV,.4)
		end
		ShadowGrab2Anim:Stop()
		ShadowGrabFinish2Anim:Play()
		wait(.8)
		local ShadowExplosion = game.ServerStorage.DarkShadowExplosion2:Clone()
		ShadowExplosion.Parent = script
		ShadowExplosion:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-40))
		local coo = coroutine.wrap(function()
		repeat wait()
		ShadowExplosion.Effect.CFrame =  ShadowExplosion.Effect.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect2.CFrame =  ShadowExplosion.Effect2.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect3.CFrame =  ShadowExplosion.Effect3.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect4.CFrame =  ShadowExplosion.Effect4.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect5.CFrame =  ShadowExplosion.Effect5.CFrame * CFrame.Angles(math.rad(29), math.rad(29), math.rad(-29))
		ShadowExplosion.Effect6.CFrame = ShadowExplosion.Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until ShadowExplosion.HB == nil 
		end)
		coo()
		local PlayersHitted = {}
		ShadowExplosion.HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 70*Strength.Value/2*DarkMultiplier)
					else
					DmgFunction:Fire(Character, hum, 65*Strength.Value/2*DarkMultiplier)
					end
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Velocity = RootPart.CFrame.lookVector*75
						Velocity.Name = "Heavy"
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
		TweenService:Create(ShadowExplosion.Effect, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect2, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect2.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect3, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect3.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect4, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect4.Size*12,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect5, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect5.Size*8,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.Effect6, TweenInfo.new(1.5), {Size = ShadowExplosion.Effect6.Size*8,Transparency = 1}):Play()
		TweenService:Create(ShadowExplosion.HB, TweenInfo.new(1.5), {Size = ShadowExplosion.HB.Size*8}):Play()
		game.Debris:AddItem(ShadowExplosion,1.5)
		end)
		coroo()
		wait(1.2)
		if Hitted == false then
			Hitted = true
		end
		wait(1)
		Attack.Value = false
		Humanoid.AutoRotate = true
		wait(8)
		ShadowGrab = false
	elseif ShadowGrab == true and ShadowExplodeStart == false then
		ShadowExplodeStart = true
	end
end)

ff.OnServerEvent:Connect(function()
	if Agility.Value >= 250 and Attack.Value == false and stunned == false and DarkShadowEnable == true and DarkBody == false then
		DarkBody = true
		DarkShadowEnable = false
		DarkShadowSmoke.Enabled = false
		BodyMist.Enabled = true
	for i,v in pairs(DarkShadowModel:GetChildren()) do
		v.Transparency = 1
	end
		for i,v in pairs(AbysalBody:GetChildren()) do
			v.Transparency = 0
		end
		Defense.Value = 1.5
		DarkMultiplier = 1.2
	repeat wait(.1)
		Stamina.Value = Stamina.Value - 2
		Humanoid.JumpPower = 150
		if Agility.Value >= 2000 then
		Humanoid.WalkSpeed = 160
		else
		Humanoid.WalkSpeed = 60 + 0.05 * Agility.Value
		end
		cantrun = true
	until DarkBody == false or Stamina.Value <= 2
		Humanoid.JumpPower = 50
		Humanoid.WalkSpeed = 18
		cantrun = false
		DarkBody = false
		for i,v in pairs(AbysalBody:GetChildren()) do
			v.Transparency = 1
		end
		BodyMist.Enabled = false
		Defense.Value = 1
		DarkMultiplier = 1
	elseif Attack.Value == false and DarkBody == true then
		DarkBody = false
		DarkShadowEnable = true
		DarkShadowSmoke.Enabled = true
		for i,v in pairs(DarkShadowModel:GetChildren()) do
		v.Transparency = 0
		end
	end
end)

local ShadowFlightCD = false
local ShadowFlight = false
local DirectionRemote = script:WaitForChild("Direction")
Space.OnServerEvent:Connect(function(play, direction,cframe)
	if DarkShadowEnable == true and Attack.Value == false and stunned == false and ShadowFlight == false and ShadowFlightCD == false and DarkBody == false then
		ShadowFlight = true
		ShadowFlightCD = true
		Attack.Value = true
		Humanoid.AutoRotate = false
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		FlightAnim:Play()
		local bv = Instance.new("BodyVelocity", RootPart)
		bv.Name = "ShadowFlight"
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = direction.lookVector * 150*DarkMultiplier
		repeat wait(.2) 
		DirectionRemote:FireClient(Player)
		Stamina.Value = Stamina.Value - 5
		until ShadowFlight == false or Stamina.Value < 5
		bv:Destroy()
		Attack.Value = false
		FlightAnim:Stop()
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
		wait(1)
		ShadowFlightCD = false
	elseif DarkShadowEnable == false and DarkBody == true and Attack.Value == false and stunned == false and ShadowFlight == false and ShadowFlightCD == false then
		ShadowFlight = true
		ShadowFlightCD = true
		Attack.Value = true
		Humanoid.AutoRotate = false
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		Flight2Anim:Play()
		local bv = Instance.new("BodyVelocity", RootPart)
		bv.Name = "ShadowFlight"
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = direction.lookVector * 150*DarkMultiplier
		repeat wait(.2) 
		DirectionRemote:FireClient(Player)
		Stamina.Value = Stamina.Value - 5
		until ShadowFlight == false or Stamina.Value < 5
		bv:Destroy()
		Attack.Value = false
		Flight2Anim:Stop()
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
		wait(1)
		ShadowFlightCD = false
	elseif ShadowFlight == true then
		RootPart:FindFirstChild("ShadowFlight").Velocity = direction.lookVector * 150*DarkMultiplier
		local ShadowShockwave = game.ServerStorage.ShadowShockwave:Clone()
		ShadowShockwave.Parent = script
		ShadowShockwave:SetPrimaryPartCFrame(cframe*CFrame.new(0,0,-10)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		game.Debris:AddItem(ShadowShockwave,1)
		TweenService:Create(ShadowShockwave.Effect1, TweenInfo.new(.8),{Size = Vector3.new(50,18,50),Transparency = 1}):Play()
		TweenService:Create(ShadowShockwave.Effect2, TweenInfo.new(.8),{Size = Vector3.new(60,44,60),Transparency = 1}):Play()
	end
end)

SpaceOn.OnServerEvent:Connect(function(play, direction)
	if ShadowFlight == true then
		ShadowFlight = false
	end
end)


rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	ShadowBlockAnim:Play()
	repeat wait()
	if DarkBody == false then
	Defense.Value = 3
	elseif DarkBody == true then
	Defense.Value = 5
	end
	Stamina.Value = Stamina.Value - 3
	if RootPart:FindFirstChild("Heavy") then
	game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	ShadowBlockAnim:Stop()
	if DarkBody == false then
	Defense.Value = 1
	elseif DarkBody == true then
	Defense.Value = 2.5
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
	if Attack.Value == false and stunned == false and Stamina.Value > 10 and DarkShadowEnable == false and DarkBody == false then
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
	elseif Attack.Value == false and stunned == false and Stamina.Value > 10 and DarkShadowEnable == true then
	Stamina.Value = Stamina.Value - 10
	Attack.Value = true
	if SlashType == 1 then
			for i,v in pairs(DarkShadowModel["Hand right"]:GetChildren()) do
				if v:IsA("Trail") then
					v.Enabled = true
				end
			end
			RightSlash = true
			SlashType = 2
			DarkSlash_1Anim:Play()
			local HB = Instance.new("Part", script)
			HB.Anchored = false
			HB.CanCollide = false
			HB.Transparency = 1
			HB.Size = Vector3.new(5,5,5)
			HB.Massless = true
			local Weld = Instance.new("Weld",HB)
			Weld.Part0 = HB
			Weld.Part1 = DarkShadowModel["Hand right"]
			game.Debris:AddItem(HB,.8)
			HB.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightSlash == true then
			RightSlash = false
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
					end
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
	elseif SlashType == 2 then
			for i,v in pairs(DarkShadowModel["Hand left"]:GetChildren()) do
				if v:IsA("Trail") then
					v.Enabled = true
				end
			end
			LeftSlash = true
			SlashType = 1
			DarkSlash_2Anim:Play()
			local HB = Instance.new("Part", script)
			HB.Anchored = false
			HB.CanCollide = false
			HB.Transparency = 1
			HB.Size = Vector3.new(5,5,5)
			HB.Massless = true
			local Weld = Instance.new("Weld",HB)
			Weld.Part0 = HB
			Weld.Part1 = DarkShadowModel["Hand left"]
			game.Debris:AddItem(HB,.8)
			HB.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftSlash == true then
			LeftSlash = false
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
					end
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
	end
	wait(0.6)
	Attack.Value = false
	RightSlash = false
	LeftSlash = false
	for i,v in pairs(DarkShadowModel["Hand right"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
	end
	for i,v in pairs(DarkShadowModel["Hand left"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
	end
	elseif Attack.Value == false and stunned == false and Stamina.Value > 10 and DarkBody == true then
	Stamina.Value = Stamina.Value - 10
	Attack.Value = true
	if SlashType == 1 then
			for i,v in pairs(AbysalBody["RightLowerArm"]:GetChildren()) do
				if v:IsA("Trail") then
					v.Enabled = true
				end
			end
			RightSlash = true
			SlashType = 2
			DarkSlash2_1Anim:Play()
			local HB = Instance.new("Part", script)
			HB.Anchored = false
			HB.CanCollide = false
			HB.Transparency = 1
			HB.Size = Vector3.new(2,2,2)
			HB.Massless = true
			local Weld = Instance.new("Weld",HB)
			Weld.Part0 = HB
			Weld.Part1 = Character.RightHand
			game.Debris:AddItem(HB,.8)
			HB.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightSlash == true then
			RightSlash = false
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
					end
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
	elseif SlashType == 2 then
			for i,v in pairs(AbysalBody["LeftLowerArm"]:GetChildren()) do
				if v:IsA("Trail") then
					v.Enabled = true
				end
			end
			LeftSlash = true
			SlashType = 1
			DarkSlash2_2Anim:Play()
			local HB = Instance.new("Part", script)
			HB.Anchored = false
			HB.CanCollide = false
			HB.Transparency = 1
			HB.Size = Vector3.new(2,2,2)
			HB.Massless = true
			local Weld = Instance.new("Weld",HB)
			Weld.Part0 = HB
			Weld.Part1 = Character.LeftHand
			game.Debris:AddItem(HB,.8)
			HB.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and LeftSlash == true then
			LeftSlash = false
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
					if ToolType.Value == "ShadowCape" then
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2)
					else
					DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
					end
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
	end
	wait(0.6)
	Attack.Value = false
	RightSlash = false
	LeftSlash = false
	for i,v in pairs(AbysalBody["RightLowerArm"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
	end
	for i,v in pairs(AbysalBody["LeftLowerArm"]:GetChildren()) do
		if v:IsA("Trail") then
			v.Enabled = false
		end
	end
	end
end)
			
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and RightPunch == true then
RightPunch = false
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*DarkMultiplier)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*DarkMultiplier)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*DarkMultiplier)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*DarkMultiplier)
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

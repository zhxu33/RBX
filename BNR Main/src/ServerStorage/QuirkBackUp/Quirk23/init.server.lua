local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 23 then
	script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local plr = game.Players:FindFirstChild(Player.Name)
wait()
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block) 
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local ThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.Throw)
local GrapeRushAnim = Humanoid:LoadAnimation(AnimationsFolder.GrapeRush)
local GrapeWhipAnim = Humanoid:LoadAnimation(AnimationsFolder.GrapeWhip)
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
local Mineta = script:WaitForChild("Mineta")
local Wel = Instance.new("Weld", Mineta)
Wel.Part0 = Mineta
Wel.Part1 = Character.Head
Wel.C0 = Wel.C0 * CFrame.new(0,-0.5,0) * CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
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
local MultiThrow = script:WaitForChild("MultiThrow")

local CanFreeze = true
function FreezeHumanoid(hum, HRT, amount)
	if CanFreeze == true and not (HRT.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, HRT.Parent)) then
	local coo = coroutine.wrap(function()
	hum.PlatformStand = true
	HRT.Anchored = true
			if not HRT:FindFirstChild("FrozenScript") then
			local FrozenScript = game.ServerStorage.FrozenScript:Clone()
			local FrozenTime = game.ServerStorage.FrozenTime:Clone()
			FrozenTime.Name = 'FrozenTime'
			FrozenTime.Parent = HRT
			FrozenTime.Value = amount
			FrozenScript.Parent = HRT
			else
			HRT.FrozenScript:Destroy()
			HRT.FrozenTime:Destroy()
			local FrozenScript = game.ServerStorage.FrozenScript:Clone()
			local FrozenTime = game.ServerStorage.FrozenTime:Clone()
			FrozenTime.Name = 'FrozenTime'
			FrozenTime.Parent = HRT
			FrozenTime.Value = amount
			FrozenScript.Parent = HRT
			end
--	wait(amount)
--	hum.PlatformStand = false
--	HRT.Anchored = false
	end)
	coo()
	end
end

Humanoid.Died:Connect(function()
	CanFreeze = false
end)

local GrapeAmount = 10
local coo = coroutine.wrap(function()
	while wait(2.5) do
		if GrapeAmount < 10 then
			GrapeAmount = GrapeAmount + 1
		end
	end
end)
coo()

local GrapeThrow = false
local GrapeRush = false
zz.OnServerEvent:Connect(function(play,direc)
	if Attack.Value == false and Stamina.Value >= 10 and stunned == false and GrapeThrow == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 10
		GrapeThrow = true
		ThrowAnim:Play()
		if GrapeAmount > -1 then
		GrapeAmount = GrapeAmount - 1
		end
		if GrapeAmount < 0 then
			Humanoid:TakeDamage(Humanoid.MaxHealth/15)
		end
		wait(0.15)
		local Grape = game.ServerStorage.PopOffBall:Clone()
		Grape.CFrame = RootPart.CFrame
		Grape.Parent = script
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direc.p)
		game.Debris:AddItem(pp,0.1)
		game.Debris:AddItem(Grape, 5)
		local BV = Instance.new("BodyVelocity", Grape)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = pp.CFrame.lookVector*150
		game.Debris:AddItem(BV, 0.25)
		local Stuck = false
		local PlayersHitted = {}
		Grape.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent or hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent) then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2)
					FreezeHumanoid(hum, HRT, 2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.2)
						Velocity.Velocity = RootPart.CFrame.lookVector * 100
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
		Grape.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent.Parent.Name ~= Player.Name and Stuck == false and hit.Transparency ~= 1 and not (hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent)) then
				Stuck = true
				Grape.Transparency = 1
				Grape.Trail.Enabled = false
				game.Debris:AddItem(Grape, 0.5)
				local Ball = Instance.new("Part", script)
				Ball.Shape = "Ball"
				Ball.Material = "Neon"
				Ball.BrickColor = BrickColor.new("Institutional white") 
				Ball.Anchored = true
				Ball.CanCollide = false
				Ball.CFrame = Grape.CFrame
				Ball.Size = Vector3.new(1.5,1.5,1.5)
				Ball.Transparency = 0.25
				local NewGrape = game.ServerStorage.PopOffBall:Clone()
				NewGrape.Anchored = true
				NewGrape.CFrame = Ball.CFrame
				NewGrape.Parent = script
				game.Debris:AddItem(NewGrape, 3)
				game.Debris:AddItem(Ball, 0.5)
				TweenService:Create(Ball, TweenInfo.new(0.5),{Transparency = 1, Size = Vector3.new(6,6,6)}):Play()
		NewGrape.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent or hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent) then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 35*Strength.Value/2)
					FreezeHumanoid(hum, HRT, 2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.2)
						Velocity.Velocity = RootPart.CFrame.lookVector * 100
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
				elseif hit.Parent.Name == Player.Name and Stuck == true then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
				Humanoid.JumpPower = 150
				Humanoid.Jump = true
				wait(0.1)
				Humanoid.JumpPower = 50
			end
							end)
						end
			end)
		wait(0.75)
		Attack.Value = false
		GrapeThrow = false
	end
end)

local MultiThrowBall = false
xx.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and Stamina.Value >= 50 and stunned == false and GrapeRush == false then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		GrapeRush = true
		GrapeRushAnim:Play()
		for i=1, 8 do
		MultiThrowBall = true
		MultiThrow:FireClient(plr)
		wait(0.11)
		end
		Attack.Value = false
		wait(5)
		GrapeRush = false	
	end
end)

MultiThrow.OnServerEvent:Connect(function(play,direc)
	if MultiThrowBall == true then
		if GrapeAmount > -1 then
		GrapeAmount = GrapeAmount - 0.5
		end
		if GrapeAmount < 0 then
			Humanoid:TakeDamage(Humanoid.MaxHealth/30)
		end
		local Grape = game.ServerStorage.PopOffBall:Clone()
		Grape.CFrame = RootPart.CFrame
		Grape.Parent = script
		local pp = Instance.new("Part", script)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.CFrame = CFrame.new(pp.CFrame.p, direc.p)
		game.Debris:AddItem(pp,0.2)
		game.Debris:AddItem(Grape, 5)
		local BV = Instance.new("BodyVelocity", Grape)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = pp.CFrame.lookVector * 150
		game.Debris:AddItem(BV, 0.25)
		local Stuck = false
		local PlayersHitted = {}
		Grape.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent or hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent) then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 25*Strength.Value/2)
					FreezeHumanoid(hum, HRT, 2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.2)
						Velocity.Velocity = RootPart.CFrame.lookVector * 100
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
		Grape.Touched:Connect(function(hit)
			if hit.Parent.Name ~= Player.Name and hit.Parent.Parent.Name ~= Player.Name and Stuck == false and hit.Transparency == 0 then
				Stuck = true
				Grape.Transparency = 1
				Grape.Trail.Enabled = false
				game.Debris:AddItem(Grape, 0.5)
				local Ball = Instance.new("Part", script)
				Ball.Shape = "Ball"
				Ball.Material = "Neon"
				Ball.BrickColor = BrickColor.new("Institutional white") 
				Ball.Anchored = true
				Ball.CanCollide = false
				Ball.CFrame = Grape.CFrame
				Ball.Size = Vector3.new(1.5,1.5,1.5)
				Ball.Transparency = 0.25
				local NewGrape = game.ServerStorage.PopOffBall:Clone()
				NewGrape.Anchored = true
				NewGrape.CFrame = Ball.CFrame
				NewGrape.Parent = script
				game.Debris:AddItem(NewGrape, 3)
				game.Debris:AddItem(Ball, 0.5)
				TweenService:Create(Ball, TweenInfo.new(0.5),{Transparency = 1, Size = Vector3.new(6,6,6)}):Play()
		NewGrape.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent or hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent)then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 25*Strength.Value/2)
					FreezeHumanoid(hum, HRT, 2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 100
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(20000,20000,20000)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,0.2)
						Velocity.Velocity = RootPart.CFrame.lookVector * 100
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
				elseif hit.Parent.Name == Player.Name and Stuck == true then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
				Humanoid.JumpPower = 150
				Humanoid.Jump = true
				wait(0.1)
				Humanoid.JumpPower = 50
			end
							end)
			end
		end)
			MultiThrowBall = false
		end
			end)
			
local GrapeWhip = false
cc.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and GrapeWhip == false then
	Attack.Value = true
	GrapeWhip = true
	Stamina.Value = Stamina.Value - 50
	local MinetaRope = game.ServerStorage.MinetaRope:Clone()
	MinetaRope.Parent = script
	local PlayersHit = {}
	for i,v in pairs(MinetaRope:GetChildren()) do
	v.Parent = Character
	game.Debris:AddItem(v,2)
	if v:IsA("BasePart") then
	local PlayersHit = {}
		v.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name and GrapeWhip == true then
		for i,tableValue in pairs(PlayersHit) do
						if tableValue == hit.Parent or hit.Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, hit.Parent) then return end
					end
					table.insert(PlayersHit, hit.Parent)
					local coro = coroutine.wrap(function()
					wait(.5)
					table.remove(PlayersHit, 1, hit.Parent)	
					end)
					coro()
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					local Velocity = Instance.new("BodyVelocity",HRT)
					Velocity.Name = "Light"
					local ObjectVal = Instance.new("ObjectValue",Velocity)
					ObjectVal.Value = RootPart
					ObjectVal.Name = "Hitist"
					game.Debris:AddItem(Velocity,.1)
					DmgFunction:Fire(Character, hum, 15*Strength.Value/2)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.1)
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
	end
	end
local Wel2 = Instance.new("Motor6D", Character.RightHand)
Wel2.Part0 = Character.RightHand
Wel2.Part1 = Character.ball1
Wel2.C0 = Wel2.C0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
MinetaRope:Destroy()
	GrapeWhipAnim:Play()
	wait(2)
	Attack.Value = false
	wait(1)
	GrapeWhip = false
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
							end end
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

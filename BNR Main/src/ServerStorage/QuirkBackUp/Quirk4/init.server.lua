local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 4 then
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
local ZeroGravMode = Humanoid:LoadAnimation(AnimationsFolder.ZeroGravMode)
local RockThrowAnim = Humanoid:LoadAnimation(AnimationsFolder.RockThrow)
local ZeroGravPunch = Humanoid:LoadAnimation(AnimationsFolder.ZeroGravPunch)
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
local ZeroPunch = false
local Training = false
local float = false
local mode = false
local RockThrow = false
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
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local vv = script:WaitForChild("V")
local ff = script:WaitForChild("F")
local cc = script:WaitForChild("C")
local qq = script:WaitForChild("Q")
local Cup = script:WaitForChild("Cup")
local Vup = script:WaitForChild("Vup")
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

local BigRockThrow = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value >= 50 and BigRockThrow == false then
		Attack.Value = true
		BigRockThrow = true
		Stamina.Value = Stamina.Value - 50
		RockThrowAnim:Play()
		local rock = game.ServerStorage.ZeroGravRock:Clone()
		rock.Anchored = true
		rock.CanCollide = false
		rock.Size = Vector3.new(40,40,40)
		rock.Parent = script
		local pe = Instance.new("ParticleEmitter",rock)
		pe.Speed = NumberRange.new(0)
		pe.Size = NumberSequence.new(10)
		pe.Rate = 500
		pe.Lifetime = NumberRange.new(0.2)
		pe.Texture = "rbxassetid://243728104"
		pe.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
		pe.LightEmission = 1
		pe.Transparency = NumberSequence.new(0.5,1)
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		cantrun = true
		RootPart.Anchored = true
		local thrown = true
	wait(.1)
		rock.CFrame = RootPart.CFrame *CFrame.new(0,-25,0)
		for i=1, 10 do 
            wait()
			rock.Position = rock.Position + Vector3.new(0, 5, 0)
			end
			Humanoid.WalkSpeed = 18
			Humanoid.JumpPower = 50
			RootPart.Anchored = false
	        cantrun = false
			thrown = false
local corot = coroutine.wrap(function()
	while thrown == false do
		wait()
		rock.CFrame = RootPart.CFrame*CFrame.new(0,25,0)
	end
		end)
corot()
Vup.OnServerEvent:Connect(function(play,direction)
				if thrown == false then
					thrown = true
					pe:Destroy()
rock.Anchored = false
local bv = Instance.new("BodyVelocity", rock)
bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
bv.Velocity = direction * 200
game.Debris:AddItem(rock,2)
local touched = false
			local PlayersHitted = {}
rock.Touched:connect(function(hit)
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
for i,tableValue in pairs(PlayersHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayersHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 150
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velocity.Velocity = bv.Velocity/2
			Velocity.Name = "Heavy"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,1)
			DmgFunction:Fire(Character, hum, 75*Strength.Value/2)
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
Attack.Value = false
wait(6)
BigRockThrow = false
end
		end)
	end
end)

qq.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value >=  20 and ZeroPunch == false then
	Stamina.Value = Stamina.Value - 20
	Attack.Value = true
	ZeroPunch = true
	ZeroGravPunch:Play()
	wait(0.2)
local PlayersHitted = {}
Character.RightHand.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and ZeroPunch == true then
for i,tableValue in pairs(PlayersHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayersHitted, hit.Parent)
table.insert(PlayersHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
for i,v in pairs(hit.Parent:GetChildren()) do
				if v:IsA("Part") then
					local pe = Instance.new("ParticleEmitter",v)
					pe.Speed = NumberRange.new(0)
					pe.Rate = 500
					pe.Lifetime = NumberRange.new(0.2)
					pe.Texture = "rbxassetid://243728104"
					pe.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe.LightEmission = 1
					pe.Transparency = NumberSequence.new(0.5,1)
					game.Debris:AddItem(pe,2)
				end
			end
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 100
			HitSound:Play()
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			Velocity.Velocity = RootPart.CFrame.lookVector * Vector3.new(0,100,400)
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,1)
					DmgFunction:Fire(Character, hum, 30*Strength.Value/2)
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
wait(0.5)
ZeroPunch = false
Attack.Value = false
	end
	end)
	

ff.OnServerEvent:Connect(function()
	if Agility.Value >= 100 and Attack.Value == false and stunned == false and mode == false then 
		mode = true
		ZeroGravMode:Play()
		wait(0.5)
		local enabled = true
			for i,v in pairs(Character:GetChildren()) do
				if v:IsA("MeshPart") then
					local pe = Instance.new("ParticleEmitter",v)
					pe.Speed = NumberRange.new(0)
					pe.Rate = 500
					pe.Lifetime = NumberRange.new(0.2)
					pe.Texture = "rbxassetid://243728104"
					pe.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe.LightEmission = 1
					pe.Transparency = NumberSequence.new(0.5,1)
					game.Debris:AddItem(pe,10)
				end
			end
		local corot = coroutine.wrap(function()
	while enabled == true do
		wait()
		Humanoid.JumpPower = 200
		if Agility.Value >= 2000 then
		Humanoid.WalkSpeed = 280
		else
		Humanoid.WalkSpeed = 80 + 0.1 * Agility.Value
		end
		end
		end)
corot()
wait(10)
enabled = false
wait(0.1)
Humanoid.JumpPower = 50
Humanoid.WalkSpeed = 18
wait(10)
mode = false
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

local fling = false
local flingdirection = nil
local hasflingtarget = false
zz.OnServerEvent:Connect(function()
	if Strength.Value >= 10 and Attack.Value == false and stunned == false and Stamina.Value > 25 and float == false then
	Stamina.Value = Stamina.Value - 25
	float = true
	local canfling = true
	fling = false
	local touchededy
	touchededy = RootPart.Touched:Connect(function(hit)
		    local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
            local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
	        if not hit.Parent:FindFirstChild("Tag") and hit.Parent:FindFirstChildOfClass("Humanoid") and hit.Parent:FindFirstChild("tagged") == nil and float == true then
        	local tag = Instance.new("Model",hit.Parent)
			touchededy:Disconnect()
			tag.Name = "tagged"
			Exp.Value = Exp.Value + 50
			game.Debris:AddItem(tag,10)
			local BodyVelocity = Instance.new("BodyVelocity",HRT)
			BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
			BodyVelocity.P = BodyVelocity.Parent.Position + Vector3.new(0,50,0)
			game.Debris:AddItem(BodyVelocity,10)
			for i,v in pairs(hit.Parent:GetChildren()) do
				if v:IsA("Part") then
					local pe = Instance.new("ParticleEmitter",v)
					pe.Speed = NumberRange.new(0)
					pe.Rate = 500
					pe.Lifetime = NumberRange.new(0.2)
					pe.Texture = "rbxassetid://243728104"
					pe.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe.LightEmission = 1
					pe.Transparency = NumberSequence.new(0.5,1)
					game.Debris:AddItem(pe,10)
				end
			end
	repeat wait(.1)
	hasflingtarget = true
	if fling == true then
	if HRT:FindFirstChild("BodyVelocity") then
	Stamina.Value = Stamina.Value - 40
	fling = true
	DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
	HRT.BodyVelocity:Destroy()
	local Velocity = Instance.new("BodyVelocity",HRT)
	Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	Velocity.Velocity = flingdirection * 250
	Velocity.Name = "Heavy"
	local ObjectVal = Instance.new("ObjectValue",Velocity)
	ObjectVal.Value = RootPart
	ObjectVal.Name = "Hitist"
    game.Debris:AddItem(Velocity,1)
	end
	end
	until canfling == false or fling == true
	hasflingtarget = false
	end
	end)
	local coo = coroutine.wrap(function()
	wait(0.5)
	float = false
	wait(9.5)
	canfling = false
	end)
	coo()
	end
end)

xx.OnServerEvent:Connect(function(play, direction)
if Strength.Value >= 25 and Attack.Value == false and stunned == false and Stamina.Value > 40 and fling == false and hasflingtarget == true then
	flingdirection = direction
	fling = true
end
end)

cc.OnServerEvent:Connect(function()
	if Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value > 50 and Training == false and RockThrow == false then 
		RockThrow = true
		RockThrowAnim:Play()
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		cantrun = true
		RootPart.Anchored = true
		local thrown = true
		wait(0.1)
		local rock = game.ServerStorage.ZeroGravRock:Clone()
		rock.Parent = script
		local rock2 = game.ServerStorage.ZeroGravRock:Clone()
		rock2.Parent = script
		local rock3 = game.ServerStorage.ZeroGravRock:Clone()
		rock3.Parent = script
		local rock4 = game.ServerStorage.ZeroGravRock:Clone()
		rock4.Parent = script
		local hb = Instance.new("Part", script)
		hb.Parent = script
		hb.Size = Vector3.new(11,11,11)
		hb.CanCollide = false
		hb.Name = Player.Name
		hb.Anchored = true
		hb.Transparency = 1
		rock.CFrame = RootPart.CFrame*CFrame.new(0,-5,5)
		rock2.CFrame = RootPart.CFrame*CFrame.new(0,-5,-5)
		rock3.CFrame = RootPart.CFrame*CFrame.new(5,-5,0)
		rock4.CFrame = RootPart.CFrame*CFrame.new(-5,-5,0)
		local pe = Instance.new("ParticleEmitter",rock)
					pe.Speed = NumberRange.new(0)
					pe.Rate = 500
					pe.Lifetime = NumberRange.new(0.2)
					pe.Texture = "rbxassetid://243728104"
					pe.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe.LightEmission = 1
					pe.Transparency = NumberSequence.new(0.5,1)
		local pe1 = Instance.new("ParticleEmitter",rock2)
					pe1.Speed = NumberRange.new(0)
					pe1.Rate = 500
					pe1.Lifetime = NumberRange.new(0.2)
					pe1.Texture = "rbxassetid://243728104"
					pe1.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe1.LightEmission = 1
					pe1.Transparency = NumberSequence.new(0.5,1)
	     local pe2 = Instance.new("ParticleEmitter",rock3)
					pe2.Speed = NumberRange.new(0)
					pe2.Rate = 500
					pe2.Lifetime = NumberRange.new(0.2)
					pe2.Texture = "rbxassetid://243728104"
					pe2.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe2.LightEmission = 1
					pe2.Transparency = NumberSequence.new(0.5,1)
		local pe3 = Instance.new("ParticleEmitter",rock4)
					pe3.Speed = NumberRange.new(0)
					pe3.Rate = 500
					pe3.Lifetime = NumberRange.new(0.2)
					pe3.Texture = "rbxassetid://243728104"
					pe3.Color = ColorSequence.new(Color3.fromRGB(255, 102, 204))
					pe3.LightEmission = 1
					pe3.Transparency = NumberSequence.new(0.5,1)
					rock.Anchored = true
			rock2.Anchored = true
			rock3.Anchored = true
			rock4.Anchored = true
			for i=1, 10 do 
            wait()
			rock.Position = rock.Position + Vector3.new(0, 0.5, 0)
			rock2.Position = rock2.Position + Vector3.new(0, 0.5, 0)
			rock3.Position = rock3.Position + Vector3.new(0, 0.5, 0)
			rock4.Position = rock4.Position + Vector3.new(0, 0.5, 0)	
			end
			Humanoid.WalkSpeed = 18
			Humanoid.JumpPower = 50
			RootPart.Anchored = false
	        cantrun = false
			thrown = false
local corot = coroutine.wrap(function()
	while thrown == false do
		wait()
		rock.CFrame = RootPart.CFrame*CFrame.new(0,0,5)
		rock2.CFrame = RootPart.CFrame*CFrame.new(0,0,-5)
		rock3.CFrame = RootPart.CFrame*CFrame.new(5,0,0)
		rock4.CFrame = RootPart.CFrame*CFrame.new(-5,0,0)
		hb.CFrame = RootPart.CFrame
	end
		end)
corot()
			Cup.OnServerEvent:Connect(function()
				if thrown == false then
			local PlayersHitted = {}
hb.Touched:connect(function(hit)
if hit.Parent.Name == Player.Name then
else if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
for i,tableValue in pairs(PlayersHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayersHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 150
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velocity.Velocity = hb.Velocity
			Velocity.Name = "Heavy"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,1)
				DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
			rock:FindFirstChild("BodyVelocity"):Destroy()
			rock2:FindFirstChild("BodyVelocity"):Destroy()
			rock3:FindFirstChild("BodyVelocity"):Destroy()
			rock4:FindFirstChild("BodyVelocity"):Destroy()
			hb:FindFirstChild("BodyVelocity"):Destroy()
			local velocity = Instance.new("BodyVelocity", rock)
				velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				velocity.Velocity = Vector3.new(0,50,50)
				game:GetService("Debris"):AddItem(velocity, 0.5)
				local velocity = Instance.new("BodyVelocity", rock2)
				velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				velocity.Velocity = Vector3.new(0,50.-50)
				game:GetService("Debris"):AddItem(velocity, 0.5)
				local velocity = Instance.new("BodyVelocity", rock3)
				velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				velocity.Velocity = Vector3.new(50,50,0)
				game:GetService("Debris"):AddItem(velocity, 0.5)
				local velocity = Instance.new("BodyVelocity", rock4)
				velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				velocity.Velocity = Vector3.new(-50,50,0)
				game:GetService("Debris"):AddItem(velocity, 0.5)
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
			thrown = true
			rock.Anchored = false
			rock2.Anchored = false
			rock3.Anchored = false
			rock4.Anchored = false
			pe:Destroy()
			pe2:Destroy()
			pe3:Destroy()
			pe1:Destroy()
			hb.Anchored = false
			local Velocity = Instance.new("BodyVelocity", hb)
		Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        Velocity.Velocity = RootPart.CFrame.lookVector *100
			local Velocity = Instance.new("BodyVelocity",hb)
			Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			game.Debris:AddItem(Velocity,5)
			Velocity.Velocity = RootPart.CFrame.lookVector*100
			local Velocity = Instance.new("BodyVelocity",rock)
			Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			game.Debris:AddItem(Velocity,5)
			Velocity.Velocity = RootPart.CFrame.lookVector*100
						local Velocity = Instance.new("BodyVelocity",rock2)
			Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			game.Debris:AddItem(Velocity,5)
			Velocity.Velocity = RootPart.CFrame.lookVector*100
						local Velocity = Instance.new("BodyVelocity",rock3)
			Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			game.Debris:AddItem(Velocity,5)
			Velocity.Velocity = RootPart.CFrame.lookVector *100
						local Velocity = Instance.new("BodyVelocity",rock4)
			Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			game.Debris:AddItem(Velocity,5)
			Velocity.Velocity = RootPart.CFrame.lookVector *100
			wait(5)
			rock:Destroy()
			rock2:Destroy()
			rock3:Destroy()
			rock4:Destroy()
			hb:Destroy()
			RockThrow = false
			end
			end)
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
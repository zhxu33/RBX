local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 16 then
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
local ReconstructAnim = Humanoid:LoadAnimation(AnimationsFolder.Reconstruct) 
local DeathTouchAnim = Humanoid:LoadAnimation(AnimationsFolder.DeathTouch) 
local FloorTouchAnim = Humanoid:LoadAnimation(AnimationsFolder.FloorTouch) 
local HoldTouchAnim = Humanoid:LoadAnimation(AnimationsFolder.HoldTouch)
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
local OverMode = false
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
			elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false and OverMode == false then
			stunned = true
			local asdfg = false
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
			elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false and OverMode == true then
			stunned = true
			wait(.3)
			if RootPart:FindFirstChild("Heavy") then
				RootPart:FindFirstChild("Heavy"):Destroy()
			end
			stunned = false
		end
		end
	end
end)
Coro()


local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local ff = script:WaitForChild("F")
local rup = script:WaitForChild("RUP")
local vup = script:WaitForChild("Vup")
local qup = script:WaitForChild("Qup")

local OverModeCD = false
local Reconstruct = false
local ReconstructCD = false
local OverMultiplier = 1
local OverForm = script:WaitForChild("OverForm")
for i,v in pairs(OverForm:GetChildren()) do
	v.Transparency = 1
	if Character:FindFirstChild(v.Name) then
		local Weld = Instance.new("Weld", Character:FindFirstChild(v.Name))
		Weld.Part0 = Character:FindFirstChild(v.Name)
		Weld.Part1 = v
	end
end
ff.OnServerEvent:Connect(function()
	if Strength.Value >= 2000 and OverMode == false and OverModeCD == false and Reconstruct == false and Stamina.Value >= 100 and Attack.Value == false then 
	OverMode = true
	OverModeCD = true
	Defense.Value = 1.2
	OverMultiplier = 1.2
	local touched = false
	local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	UpDashEf.Decal.Color3 = Color3.new(255,0,0)
	UpDashEf.Decal1.Color3 = Color3.new(255,0,0)
	game.Debris:AddItem(UpDashEf,0.5)
	TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
for i,v in pairs(OverForm:GetChildren()) do
	if not Character:FindFirstChild(v.Name) then
		v.Transparency = 0
		local pe = game.ServerStorage.OverhaulLightning:Clone()
		pe.Rate = 10
		pe.Parent = v
		game.Debris:AddItem(pe,2)
	end
end
			local coro = coroutine.wrap(function()
			repeat wait(.5) 
			Stamina.Value = Stamina.Value - 25
			until OverMode == false or Stamina.Value < 25
			cantrun = false
			OverMultiplier = 1
			Defense.Value = 1
			for i,v in pairs(OverForm:GetChildren()) do
				if not Character:FindFirstChild(v.Name) then
					v.Transparency = 1
				end
			end
			end)
			coro()
	elseif OverMode == true and Attack.Value == false then
		OverMode = false
		wait(10)
		OverModeCD = false
	end
end)

local HealTouch = false
local HealTouchCD = false
qq.OnServerEvent:Connect(function()
	if Attack.Value == false and Stamina.Value >= 50 and stunned == false and HealTouch == false and HealTouchCD == false then
		HoldTouchAnim:Play()
		Attack.Value = true
		Stamina.Value = Stamina.Value - 50
		HealTouch = true
		HealTouchCD = true
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(1.5, 3, 1.5)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		HitPart.Massless = true
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = Character.LeftUpperArm
		local touched = true
		HitPart.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health < hit.Parent:FindFirstChild("Humanoid").MaxHealth and touched == false and hit.Parent.Name ~= Player.Name and hit.Parent.Parent.Name ~= "NPCs" then
			touched = true
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			hum:TakeDamage(-hum.MaxHealth/5)
				if hum.Health > hum.MaxHealth then
				hum.Health = hum.MaxHealth
			end
			local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
			UpDashEf.Parent = script
			UpDashEf.CFrame = HRT.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
			UpDashEf.Decal.Color3 = Color3.new(0,255,0)
			UpDashEf.Decal1.Color3 = Color3.new(0,255,0)
			game.Debris:AddItem(UpDashEf,0.75)
			TweenService:Create(UpDashEf, TweenInfo.new(0.75),{Size = Vector3.new(35,0.05,35)}):Play()
			TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.75),{Transparency = 1}):Play()
			TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.75),{Transparency = 1}):Play()
			for i,v in pairs(HRT.Parent:GetChildren()) do
				if v:IsA("MeshPart") then
				local clone = v:Clone()
				clone.Parent = v
				clone.Material = "Neon"
				clone.BrickColor = BrickColor.new("Lime green")
				clone.Size = clone.Size + Vector3.new(.2,.2,.2)
				clone.Transparency = 0
				TweenService:Create(clone,TweenInfo.new(.5),{Transparency = 1}):Play()
				game.Debris:AddItem(clone,.5)
					end
				end
			end	
		end)
		local Over = false
		if OverMode == false then
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
				local clone = v:Clone()
				clone.Massless = true
				clone.Name = "HealTouch"
				clone.Parent = v
				clone.Material = "Neon"
				clone.BrickColor = BrickColor.new("Lime green")
				clone.Size = clone.Size + Vector3.new(.1,.1,.1)
				clone.Transparency = .25
				clone.TextureID = ""
				local Weld = Instance.new("Motor6D",clone)
				Weld.Part0 = clone
				Weld.Part1 = v
				if v.Name == "LeftUpperArm" then
					clone:FindFirstChild("LeftShoulder"):Destroy()
				end
			end
		end
		elseif OverMode == true then
			Over = true
			for i,v in pairs(OverForm:GetChildren()) do
			if v.Name == "LeftUpperArm2" or v.Name == "LeftLowerArm2" or v.Name == "LeftHand2" then
				local clone = v:Clone()
				clone.Name = "HealTouch"
				clone.Parent = v
				clone.Material = "Neon"
				clone.BrickColor = BrickColor.new("Lime green")
				clone.Size = clone.Size + Vector3.new(.1,.1,.1)
				clone.Transparency = .8
				local Weld = Instance.new("Motor6D",clone)
				Weld.Part0 = clone
				Weld.Part1 = v
			end
		end
		end
		repeat wait() 
		until HealTouch == false
		touched = false
		DeathTouchAnim:Play()
		HoldTouchAnim:Stop()
		local coo = coroutine.wrap(function()
		wait(0.25)
		game.Debris:AddItem(HitPart,0.75)
		if Over == false then
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
				local clone = v:FindFirstChild("HealTouch")
				game.Debris:AddItem(clone, 0.75)
				TweenService:Create(clone,TweenInfo.new(0.75), {Transparency = 1}):Play()
			end
		end
		elseif Over == true then
		for i,v in pairs(OverForm:GetChildren()) do
			if v.Name == "LeftUpperArm2" or v.Name == "LeftLowerArm2" or v.Name == "LeftHand2" then
				local clone = v:FindFirstChild("HealTouch")
				game.Debris:AddItem(clone, 0.75)
				TweenService:Create(clone,TweenInfo.new(0.75), {Transparency = 1}):Play()
			end
		end
		end
		end)
		coo()
		wait(.5)
		if touched == false then
			touched = true
			local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
			UpDashEf.Parent = script
			UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
			UpDashEf.Decal.Color3 = Color3.new(0,255,0)
			UpDashEf.Decal1.Color3 = Color3.new(0,255,0)
			game.Debris:AddItem(UpDashEf,0.75)
			TweenService:Create(UpDashEf, TweenInfo.new(0.75),{Size = Vector3.new(35,0.05,35)}):Play()
			TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.75),{Transparency = 1}):Play()
			TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.75),{Transparency = 1}):Play()
			Humanoid:TakeDamage(-Humanoid.MaxHealth/5)
			if Humanoid.Health > Humanoid.MaxHealth then
				Humanoid.Health = Humanoid.MaxHealth
			end
			for i,v in pairs(Character:GetChildren()) do
				if v:IsA("MeshPart") then
				local clone = v:Clone()
				clone.Parent = v
				clone.Material = "Neon"
				clone.BrickColor = BrickColor.new("Lime green")
				clone.Size = clone.Size + Vector3.new(.2,.2,.2)
				clone.Transparency = 0
				clone.TextureID = ""
				TweenService:Create(clone,TweenInfo.new(.5),{Transparency = 1}):Play()
				game.Debris:AddItem(clone,.5)
			end
			end
		end
		wait(1)
		Attack.Value = false
		wait(5)
		HealTouchCD = false
		end
end)

qup.OnServerEvent:Connect(function()
	if HealTouch == true then
		HealTouch = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Durability.Value >= 500 and Attack.Value == false and Stamina.Value >= 100 and stunned == false and Reconstruct == false and ReconstructCD == false then
		ReconstructCD = true
		ReconstructAnim:Play()
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		Reconstruct = true
		Humanoid.WalkSpeed = 0
		Humanoid.AutoRotate = false
		cantrun = true
		Humanoid.JumpPower = 0 
		RootPart.Anchored = true
		wait(.5)
		ReconstructAnim:Stop()
		local ff= Instance.new("ForceField", Character)
		ff.Visible = false
		ff.Name = "Reconstruct"
		for i,v in pairs(Character:GetChildren()) do
			if v:IsA("MeshPart") then
				local clone = v:Clone()
				clone:ClearAllChildren()
				clone.TextureID = ""
				local bv = Instance.new("BodyVelocity", clone)
				bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				bv.Velocity = Vector3.new(math.random(-25,25),0,math.random(-25,25))
				game.Debris:AddItem(bv,.25)
				clone.Anchored = false
				clone.CanCollide = true
				clone.Parent = script
				v.Transparency = 1
			end
		end
		local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
for _,v in pairs(ActiveTracks) do
    v:Stop()
end
		wait(1)
		for i,v in pairs(script:GetChildren()) do
			local coro = coroutine.wrap(function()
			if v:IsA("MeshPart") and v.Name ~= "Smoke" and v.Name ~= "OverhaulSpikes" and v.Name ~= "OverHaulSpikeEffect" and v.Name ~= "OverhaulSpike2" and Character:FindFirstChild(v.Name)then 
				v.Material = "Neon"
				v.CanCollide = false
				local pe = game.ServerStorage.OverhaulLightning:Clone()
		pe.Rate = 10
		pe.Parent = v
		local BP = Instance.new("BodyPosition", v)
		BP.MaxForce = Vector3.new(2000,2000,2000)
		BP.Position = Character:FindFirstChild(v.Name).Position
		wait(0.75)
		v:Destroy()
		Character:FindFirstChild(v.Name).Transparency = 0
			end
			end)
			coro()
		end
		wait(.75)
		Humanoid.Health = Humanoid.MaxHealth
		Humanoid.WalkSpeed = 18
		cantrun = false
		Humanoid.JumpPower = 50
		Humanoid.AutoRotate = true
		RootPart.Anchored = false
		Attack.Value = false
		ff:Destroy()
		Reconstruct = false
		wait(20)
		ReconstructCD = false
	end
end)

local SpikeJutsu = false
zz.OnServerEvent:Connect(function()
	 if Strength.Value >= 500 and Attack.Value == false and Stamina.Value >= 50 and stunned == false and SpikeJutsu == false then
		Stamina.Value = Stamina.Value - 50
		Attack.Value = true
		SpikeJutsu = true
		FloorTouchAnim:Play()
		wait(.3)
		local Spikes = game.ServerStorage.OverhaulSpikes:Clone()
		Spikes.Parent = script
		Spikes.CFrame = RootPart.CFrame * CFrame.new(0,-5,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		local ef = game.ServerStorage.OverHaulSpikeEffect:Clone()
		ef.Parent = script
		ef.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)
		local PlayersHitted = {}
Spikes.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 60*Strength.Value/2*OverMultiplier)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 125
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.Name = "Heavy"
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
		TweenService:Create(ef, TweenInfo.new(1),{Transparency = 1}):Play()
		TweenService:Create(ef, TweenInfo.new(1),{Size = Vector3.new(200,10,200)}):Play()
		TweenService:Create(Spikes, TweenInfo.new(1.5),{Size = Vector3.new(150,200,150), CFrame = Spikes.CFrame * CFrame.new(75,50,0)}):Play()
		wait(1)
		ef:Destroy()
		Attack.Value = false
		FloorTouchAnim:Stop()
		wait(2)
		TweenService:Create(Spikes, TweenInfo.new(1.5),{Transparency = 1}):Play()
		game.Debris:AddItem(Spikes,1)
		wait(5)
		SpikeJutsu = false
	end
end)

local SpikeJutsu2 = false
cc.OnServerEvent:Connect(function()
	 if Strength.Value >= 1000 and Attack.Value == false and Stamina.Value >= 150 and stunned == false and SpikeJutsu2 == false then
		Stamina.Value = Stamina.Value - 150
		Attack.Value = true
		SpikeJutsu2 = true
		FloorTouchAnim:Play()
		wait(.3)
		local Spikes = game.ServerStorage.OverhaulSpike2:Clone()
		Spikes.Parent = script
		Spikes.CFrame = RootPart.CFrame * CFrame.new(0,-5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		local ef = game.ServerStorage.OverHaulSpikeEffect:Clone()
		ef.Parent = script
		ef.CFrame = RootPart.CFrame*CFrame.new(0,0,0)
		local PlayersHitted = {}
Spikes.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
				for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 70*Strength.Value/2*OverMultiplier)
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 125
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.Name = "Heavy"
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
		TweenService:Create(ef, TweenInfo.new(1),{Transparency = 1}):Play()
		TweenService:Create(ef, TweenInfo.new(1),{Size = Vector3.new(400,20,400),CFrame = Spikes.CFrame * CFrame.new(0,10,0)}):Play()
		TweenService:Create(Spikes, TweenInfo.new(1.5),{Size = Vector3.new(240, 150, 240), CFrame = Spikes.CFrame * CFrame.new(0,50,0)}):Play()
		wait(1)
		ef:Destroy()
		Attack.Value = false
		FloorTouchAnim:Stop()
		wait(3)
		TweenService:Create(Spikes, TweenInfo.new(1.5),{Transparency = 1}):Play()
		game.Debris:AddItem(Spikes,1)
		wait(10)
		SpikeJutsu2 = false
	end
end)

local DeathTouch = false
local DeathTouchCD = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 1500 and Attack.Value == false and Stamina.Value >= 100 and stunned == false and DeathTouch == false and DeathTouchCD == false then
		HoldTouchAnim:Play()
		Attack.Value = true
		Stamina.Value = Stamina.Value - 100
		DeathTouch = true
		DeathTouchCD = true
		local HitPart = Instance.new("Part",script)
		HitPart.Anchored = false
		HitPart.CanCollide = false
		HitPart.Size = Vector3.new(1.5, 3, 1.5)
		HitPart.Transparency = 1
		HitPart.CFrame = RootPart.CFrame
		HitPart.Massless = true
		local Weld = Instance.new("Weld", HitPart)
		Weld.Part0 = HitPart
		Weld.Part1 = Character.LeftUpperArm
		local touched = true
			HitPart.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and touched == false and hit.Parent.Name ~= Player.Name then
					touched = true
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
		if HRT:FindFirstChild("Light") == nil then
			Exp.Value = Exp.Value + 150
			for i,vv in pairs(hit.Parent:GetChildren()) do
				if vv:IsA("MeshPart") then
					local pe = game.ServerStorage.OverhaulLightning:Clone()
					pe.Rate = 15
					pe.Parent = vv
					game.Debris:AddItem(pe,5)
				end
			end
			local UpDashEf = game.ServerStorage.UpDashEffect:Clone()
	UpDashEf.Parent = script
	UpDashEf.CFrame = HRT.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	UpDashEf.Decal.Color3 = Color3.new(255,0,0)
	UpDashEf.Decal1.Color3 = Color3.new(255,0,0)
	game.Debris:AddItem(UpDashEf,0.75)
	TweenService:Create(UpDashEf, TweenInfo.new(0.75),{Size = Vector3.new(35,0.05,35)}):Play()
	TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.75),{Transparency = 1}):Play()
	TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.75),{Transparency = 1}):Play()
			local Velocity = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(10000,10000,10000)
			Velocity.Name = "Light"
			local ObjectVal = Instance.new("ObjectValue",Velocity)
			ObjectVal.Value = RootPart
			ObjectVal.Name = "Hitist"
			game.Debris:AddItem(Velocity,.1)
				DmgFunction:Fire(Character, hum, 160*Strength.Value/2*OverMultiplier)
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
		local Over = false
		if OverMode == false then
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
				local clone = v:Clone()
				clone.Name = "DeathTouch"
				clone.Parent = v
				clone.Material = "Neon"
				clone.BrickColor = BrickColor.new("Really red")
				clone.Size = clone.Size + Vector3.new(.1,.1,.1)
				clone.Transparency = .25
				clone.TextureID = ""
				local pe = game.ServerStorage.OverhaulLightning:Clone()
				pe.Rate = 10
				pe.Parent = clone
				local Weld = Instance.new("Motor6D",clone)
				Weld.Part0 = clone
				Weld.Part1 = v
				if v.Name == "LeftUpperArm" then
					clone:FindFirstChild("LeftShoulder"):Destroy()
				end
			end
		end
		elseif OverMode == true then
			Over = true
			for i,v in pairs(OverForm:GetChildren()) do
			if v.Name == "LeftUpperArm2" or v.Name == "LeftLowerArm2" or v.Name == "LeftHand2" then
				local clone = v:Clone()
				clone.Name = "DeathTouch"
				clone.Parent = v
				clone.Material = "Neon"
				clone.BrickColor = BrickColor.new("Really red")
				clone.Size = clone.Size + Vector3.new(.1,.1,.1)
				clone.Transparency = .8
				local pe = game.ServerStorage.OverhaulLightning:Clone()
				pe.Rate = 10
				pe.Parent = clone
				local Weld = Instance.new("Motor6D",clone)
				Weld.Part0 = clone
				Weld.Part1 = v
			end
			end
		end
		repeat wait() 
		until DeathTouch == false
		touched = false
		DeathTouchAnim:Play()
		HoldTouchAnim:Stop()
		local coo = coroutine.wrap(function()
			wait(0.25)
			game.Debris:AddItem(HitPart,0.75)
		if Over == false then
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
				local clone = v:FindFirstChild("DeathTouch")
				game.Debris:AddItem(clone, 0.75)
				TweenService:Create(clone,TweenInfo.new(0.75), {Transparency = 1}):Play()
			end
		end
		elseif Over == true then
		for i,v in pairs(OverForm:GetChildren()) do
			if v.Name == "LeftUpperArm2" or v.Name == "LeftLowerArm2" or v.Name == "LeftHand2" then
				local clone = v:FindFirstChild("DeathTouch")
				game.Debris:AddItem(clone, 0.75)
				TweenService:Create(clone,TweenInfo.new(0.75), {Transparency = 1}):Play()
			end
		end
		end
		end)
		coo()
		wait(1.5)
		Attack.Value = false
		wait(6)
		DeathTouchCD = false
	end
end)

vup.OnServerEvent:Connect(function()
	if DeathTouch == true then
		DeathTouch = false
	end
end)

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	Defense.Value = 3*OverMultiplier
	Stamina.Value = Stamina.Value - 3
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	end)
	coo()
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	Defense.Value = 1*OverMultiplier
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*OverMultiplier)
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
			DmgFunction:Fire(Character, hum, 20*Strength.Value/2*OverMultiplier)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*OverMultiplier)
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
				DmgFunction:Fire(Character, hum, 20*Strength.Value/2*OverMultiplier)
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

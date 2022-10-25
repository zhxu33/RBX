local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 1 then
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
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block)
local ULTAnim = Humanoid:LoadAnimation(AnimationsFolder.ULT)
local ULT2Anim = Humanoid:LoadAnimation(AnimationsFolder.ULT2)
local FireBallAnim = Humanoid:LoadAnimation(AnimationsFolder.FireBall)
local FireBombAnim = Humanoid:LoadAnimation(AnimationsFolder.FireBomb)
local FireFloorAnim = Humanoid:LoadAnimation(AnimationsFolder.FireFloor)
local GlacierAnim = Humanoid:LoadAnimation(AnimationsFolder.Glacier)
local IceSlideStartAnim = Humanoid:LoadAnimation(AnimationsFolder.IceSlideStart)
local IceSlideAnim = Humanoid:LoadAnimation(AnimationsFolder.IceSlide)
local IceFloorAnim = Humanoid:LoadAnimation(AnimationsFolder.IceFloor)
local FlameThrowerAnim = Humanoid:LoadAnimation(AnimationsFolder.FlameThrower)
local RangedIceAnim = Humanoid:LoadAnimation(AnimationsFolder.RangedIce)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BodyVelocity = Instance.new("BodyVelocity")
local Smoke = script.Smoke
BodyVelocity.Parent = nil
BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
local HitSound = Instance.new("Sound", RootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local FireSound = Instance.new("Sound", RootPart)
FireSound.SoundId = "rbxassetid://1544022435"
FireSound.Volume = 0.5
local IceSound = Instance.new("Sound", RootPart)
IceSound.SoundId = "rbxassetid://976606790"  
IceSound.Volume = 0.5
local GlacierSound = Instance.new("Sound", RootPart)
GlacierSound.SoundId = "rbxassetid://2011915907"
GlacierSound.Volume = 0.4
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
local Block = false
local FireMode = false
local IceMode = false
local BothMode = false
local FireBall = false
local FireBomb = false
local FireStep = false
local FireBlast = false
local FireBlastCD = false
local Freeze = false
local IceSlideCD = false
local RangedFireIce = false
local FireIceFloor = false
local IceStep = false
local Glacier = false
local IceSlide = false
local IcyFire = false
local ULT = false
local ULT2 = false
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
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
local Level = PlayerFolder.Level
local Exp = PlayerFolder.Experience
local Strength = PlayerFolder.Strength
local Agility = PlayerFolder.Agility
local Durability = PlayerFolder.Durability
local Quirk = PlayerFolder.Quirk
local stunned = false
local Chill = script.Chill:Clone()
Chill.Parent = Character.RightUpperArm
local Chill2 = script.Chill:Clone()
Chill2.Parent = Character.RightLowerArm
local Chill3 = script.Chill:Clone()
Chill3.Parent = Character.RightHand
local Chill4 = script.Chill:Clone()
Chill4.Parent = Character.RightLowerLeg
local Chill5 = script.Chill:Clone()
Chill5.Parent = Character.RightUpperLeg
local Chill6 = script.Chill:Clone()
Chill6.Parent = Character.RightFoot
local Fire = script.Fire:Clone()
Fire.Parent = Character.RightUpperArm
local Fire2 = script.Fire:Clone()
Fire2.Parent = Character.RightLowerArm
local Fire3 = script.Fire:Clone()
Fire3.Parent = Character.RightHand
local Fire4 = script.Fire:Clone()
Fire4.Parent = Character.RightLowerLeg
local Fire5 = script.Fire:Clone()
Fire5.Parent = Character.RightUpperLeg
local Fire6 = script.Fire:Clone()
Fire6.Parent = Character.RightFoot
local Primary = script.Primary:Clone()
Primary.Parent = Character.LeftUpperArm
local Primary2 = script.Primary:Clone()
Primary2.Parent = Character.LeftLowerArm
local Primary3 = script.Primary:Clone()
Primary3.Parent = Character.LeftHand
local Primary4 = script.Primary:Clone()
Primary4.Parent = Character.LeftLowerLeg
local Primary5 = script.Primary:Clone()
Primary5.Parent = Character.LeftUpperLeg
local Primary6 = script.Primary:Clone()
Primary6.Parent = Character.LeftFoot
local Secondary = script.Secondary:Clone()
Secondary.Parent = Character.LeftUpperArm
local Secondary2 = script.Secondary:Clone()
Secondary2.Parent = Character.LeftLowerArm
local Secondary3 = script.Secondary:Clone()
Secondary3.Parent = Character.LeftHand
local Secondary4 = script.Secondary:Clone()
Secondary4.Parent = Character.LeftLowerLeg
local Secondary5 = script.Secondary:Clone()
Secondary5.Parent = Character.LeftUpperLeg
local Secondary6 = script.Secondary:Clone()
Secondary6.Parent = Character.LeftFoot
local Sparks = script.Sparks:Clone()
Sparks.Parent = Character.LeftUpperArm
local Sparks2 = script.Sparks:Clone()
Sparks2.Parent = Character.LeftLowerArm
local Sparks3 = script.Sparks:Clone()
Sparks3.Parent = Character.LeftHand
local Sparks4 = script.Sparks:Clone()
Sparks4.Parent = Character.LeftLowerLeg
local Sparks5 = script.Sparks:Clone()
Sparks5.Parent = Character.LeftUpperLeg
local Sparks6 = script.Sparks:Clone()
Sparks6.Parent = Character.LeftFoot
local FlamePE = script.FlameThrower
FlamePE.Parent = Character.LeftHand
local Weldd = Instance.new("Weld", FlamePE)
Weldd.Part0 = FlamePE
Weldd.Part1 = Character.LeftHand
Weldd.C0 = Weldd.C0 * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(-90))
local IceSideModel = script:WaitForChild("IceSide")
local Weld2 = Instance.new("Weld", IceSideModel.UpperTorso)
Weld2.Part0 = IceSideModel.UpperTorso
Weld2.Part1 = Character.UpperTorso
Weld2.C0 = Weld2.C0*CFrame.new(-0.5,0,0)
local Weld3 = Instance.new("Weld", IceSideModel.LowerTorso)
Weld3.Part0 = IceSideModel.LowerTorso
Weld3.Part1 = Character.LowerTorso
Weld3.C0 = Weld3.C0*CFrame.new(-0.5,0,0)
local Weld4 = Instance.new("Weld", IceSideModel.RightFoot)
Weld4.Part0 = IceSideModel.RightFoot
Weld4.Part1 = Character.RightFoot
local Weld5 = Instance.new("Weld", IceSideModel.RightHand)
Weld5.Part0 = IceSideModel.RightHand
Weld5.Part1 = Character.RightHand
local Weld6 = Instance.new("Weld", IceSideModel.RightUpperArm)
Weld6.Part0 = IceSideModel.RightUpperArm
Weld6.Part1 = Character.RightUpperArm
local Weld7 = Instance.new("Weld", IceSideModel.RightLowerArm)
Weld7.Part0 = IceSideModel.RightLowerArm
Weld7.Part1 = Character.RightLowerArm
local Weld8 = Instance.new("Weld", IceSideModel.RightLowerLeg)
Weld8.Part0 = IceSideModel.RightLowerLeg
Weld8.Part1 = Character.RightLowerLeg
local Weld9 = Instance.new("Weld", IceSideModel.RightUpperLeg)
Weld9.Part0 = IceSideModel.RightUpperLeg
Weld9.Part1 = Character.RightUpperLeg
local Stamina = Instance.new("NumberValue",Character)
Stamina.Name = "Stamina"
Stamina.Value = 100+(Agility.Value*1)
local Defense = Instance.new("NumberValue",Character) 
Defense.Name = "Defense"
Defense.Value = 1
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

local ff = script:WaitForChild("F")
local qq = script:WaitForChild("Q")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local cup = script:WaitForChild("CUP")
local qup = script:WaitForChild("QUP")
local ee = script:WaitForChild("E")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local Direction = script:WaitForChild("Direction")

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

local CanFreeze = true
function FreezeHumanoid(hum, HRT, amount)
    if CanFreeze == true and not PartyFinder:Invoke(Player, hum.Parent) and not HRT.Parent:FindFirstChild("ForceField") then -- Don't freeze party members
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
            wait(.1)
            local Frozen = game.ServerStorage.Frozen:Clone()
            Frozen.Parent = script
            Frozen.Name = Player.Name
            Frozen.CFrame = HRT.CFrame
			game.Debris:AddItem(Frozen, amount)
--            wait(amount)
--            Frozen:Destroy()
--            hum.PlatformStand = false
--            HRT.Anchored = false
        end)
        coo()
    end
end

Humanoid.Died:Connect(function()
	CanFreeze = false
end)

local FreezeHit = {}
function CreateIce(cframe)
		local IcePart = game.ServerStorage.IceSlide:Clone()
		IcePart.Parent = script
		IcePart.CFrame = RootPart.CFrame * CFrame.new(0,-4,-60) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		TweenService:Create(IcePart,TweenInfo.new(.7),{Size = Vector3.new(90,10,90)}):Play()
		local HB = game.ServerStorage.IceSlideDmg:Clone()
		HB.Parent = script
		HB.CFrame = RootPart.CFrame * CFrame.new(0,-9,-60) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		HB.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					for i,tableValue in pairs(FreezeHit) do
						if tableValue == hit.Parent then return end
					end
					table.insert(FreezeHit, hit.Parent)
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
					FreezeHumanoid(hum, HRT, 3)
					local coo = coroutine.wrap(function()
						wait(5)
						table.remove(FreezeHit,1,hit.Parent)
					end)
					coo()
					if HRT:FindFirstChild("Light") == nil then
						Exp.Value = Exp.Value + 50
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Name = "Light"
						local ObjectVal = Instance.new("ObjectValue",Velocity)
						ObjectVal.Value = RootPart
						ObjectVal.Name = "Hitist"
						game.Debris:AddItem(Velocity,.25)
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
		local coro = coroutine.wrap(function()
			wait(0.7)
			TweenService:Create(IcePart,TweenInfo.new(.3),{Transparency = 1}):Play()
		end)
		coro()
		game.Debris:AddItem(IcePart,1)
		game.Debris:AddItem(HB,1)
end

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

ff.OnServerEvent:Connect(function()
	if IceMode == false and FireMode == false and BothMode == false then
		FireMode = true
		Primary.Enabled = true
		Primary2.Enabled = true
		Primary3.Enabled = true
		Primary4.Enabled = true
		Primary5.Enabled = true
		Primary6.Enabled = true
		Secondary.Enabled = true
		Secondary2.Enabled = true
		Secondary3.Enabled = true
		Secondary4.Enabled = true
		Secondary5.Enabled = true
		Secondary6.Enabled = true
		Sparks.Enabled = true
		Sparks2.Enabled = true
		Sparks3.Enabled = true
		Sparks4.Enabled = true
		Sparks5.Enabled = true
		Sparks6.Enabled = true
		elseif IceMode == false and FireMode == true and BothMode == false then
		IceMode = true
		FireMode = false
		Primary.Enabled = false
		Primary2.Enabled = false
		Primary3.Enabled = false
		Primary4.Enabled = false
		Primary5.Enabled = false
		Primary6.Enabled = false
		Secondary.Enabled = false
		Secondary2.Enabled = false
		Secondary3.Enabled = false
		Secondary4.Enabled = false
		Secondary5.Enabled = false
		Secondary6.Enabled = false
		Sparks.Enabled = false
		Sparks2.Enabled = false
		Sparks3.Enabled = false
		Sparks4.Enabled = false
		Sparks5.Enabled = false
		Sparks6.Enabled = false
		Chill.Enabled = true
		Chill2.Enabled = true
		Chill3.Enabled = true
		Chill4.Enabled = true
		Chill5.Enabled = true
		Chill6.Enabled = true
		Fire.Enabled = true
		Fire2.Enabled = true
		Fire3.Enabled = true
		Fire4.Enabled = true
		Fire5.Enabled = true
		Fire6.Enabled = true
		for i,v in pairs(IceSideModel:GetChildren()) do
			v.Transparency = 0
		end
		elseif IceMode == true and FireMode == false and BothMode == false then
		BothMode = true
		IceMode = false
		Primary.Enabled = true
		Primary2.Enabled = true
		Primary3.Enabled = true
		Primary4.Enabled = true
		Primary5.Enabled = true
		Primary6.Enabled = true
		Secondary.Enabled = true
		Secondary2.Enabled = true
		Secondary3.Enabled = true
		Secondary4.Enabled = true
		Secondary5.Enabled = true
		Secondary6.Enabled = true
		Sparks.Enabled = true
		Sparks2.Enabled = true
		Sparks3.Enabled = true
		Sparks4.Enabled = true
		Sparks5.Enabled = true
		Sparks6.Enabled = true
		for i,v in pairs(IceSideModel:GetChildren()) do
			v.Transparency = 1
		end
		elseif IceMode == false and FireMode == false and BothMode == true then
			BothMode = false
			Primary.Enabled = false
			Primary2.Enabled = false
			Primary3.Enabled = false
			Primary4.Enabled = false
			Primary5.Enabled = false
			Primary6.Enabled = false
			Secondary.Enabled = false
			Secondary2.Enabled = false
			Secondary3.Enabled = false
			Secondary4.Enabled = false
			Secondary5.Enabled = false
			Secondary6.Enabled = false
			Sparks.Enabled = false
			Sparks2.Enabled = false
			Sparks3.Enabled = false
			Sparks4.Enabled = false
			Sparks5.Enabled = false
			Sparks6.Enabled = false
			Chill.Enabled = false
			Chill2.Enabled = false
			Chill3.Enabled = false
			Chill4.Enabled = false
			Chill5.Enabled = false
			Chill6.Enabled = false
			Fire.Enabled = false
			Fire2.Enabled = false
			Fire3.Enabled = false
			Fire4.Enabled = false
			Fire5.Enabled = false
			Fire6.Enabled = false
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
			
qq.OnServerEvent:Connect(function(play,direction)
	if Attack.Value == false and stunned == false and Stamina.Value > 20 and FireBall == false and FireMode == true then
		FireBall = true
		Stamina.Value = Stamina.Value -20
		FireBallAnim:Play()
		RootPart.Anchored = true
		RootPart.CFrame = CFrame.new(RootPart.CFrame.p,direction.p)
		wait(0.4)
		local fire = game.ServerStorage.FireBall:Clone()
		fire.Parent = script
		fire.CFrame = RootPart.CFrame*CFrame.new(0,5,0)
		RootPart.Anchored = false
		FireSound:Play()
		game.Debris:AddItem(fire,3)
		local bv = Instance.new("BodyVelocity", fire)
		bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 250
		local Exploded = false
		local PlayersHitted = {}
		fire.Touched:Connect(function(hitto)
			if not hitto:IsDescendantOf(Character) and Exploded == false then
				Exploded = true
				fire.Anchored = true
				local ExplodeModel = game.ServerStorage.HellFlameExplosion:Clone()
				ExplodeModel.Parent = script
				ExplodeModel:SetPrimaryPartCFrame(fire.CFrame)
				fire:Destroy()
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if ExplodeModel == nil or ExplodeModel:FindFirstChild("DMG") == nil then
					break
				end
				connection = ExplodeModel.DMG.Touched:Connect(function() end)
				results = ExplodeModel.DMG:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
								FireSound:Play()
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = HRT.CFrame.lookVector * - 100
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.4)
			end
		end)
		expermentaltouch()
		TweenService:Create(ExplodeModel.DMG, TweenInfo.new(1), {Size = Vector3.new(140,140,140)}):Play()
		TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Size = Vector3.new(270,270,270)}):Play()
		TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Transparency = 1}):Play()
		TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Size = Vector3.new(140,140,140)}):Play()
		TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Transparency = 1}):Play()
		game.Debris:AddItem(ExplodeModel,1)
			end
		end)
		wait(5)
		FireBall = false
		elseif Attack.Value == false and stunned == false and Stamina.Value > 20 and Freeze == false and IceMode == true then
		Freeze = true
		IceSound:Play()
		IceFloorAnim:Play()
		Attack.Value = true
		wait(0.3)
		local ice = game.ServerStorage.IceField:Clone()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if ice == nil then
					break
				end
				connection = ice.Touched:Connect(function() end)
				results = ice:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 45*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.4)
			end
		end)
		expermentaltouch()
		ice.CFrame = RootPart.CFrame*CFrame.new(0,-1,0)
		ice.Parent = script
		TweenService:Create(ice, TweenInfo.new(1), {Size = Vector3.new(250,48,250),CFrame = ice.CFrame * CFrame.new(0,12,0)}):Play()
		wait(2)
		TweenService:Create(ice, TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		ice:Destroy()
		Attack.Value = false
		wait(4)
		Freeze = false
		elseif Strength.Value>= 100 and Attack.Value == false and stunned == false and Stamina.Value > 60 and FireIceFloor == false and BothMode == true then
		Stamina.Value = Stamina.Value - 60
		FireIceFloor = true
		Attack.Value = true
		IceFloorAnim:Play()
		wait(0.5)
		local ice = game.ServerStorage.IceField:Clone()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if ice == nil then
					break
				end
				connection = ice.Touched:Connect(function() end)
				results = ice:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.4)
			end
		end)
		expermentaltouch()
		ice.CFrame = RootPart.CFrame*CFrame.new(0,-1,0)
		ice.Parent = script
		ice.Fire.Enabled = true
		ice.Fire1.Enabled = true
		TweenService:Create(ice, TweenInfo.new(1), {Size = Vector3.new(250,48,250),CFrame = ice.CFrame * CFrame.new(0,12,0)}):Play()
		wait(1.25)
		ice.Fire.Enabled = false
		ice.Fire1.Enabled = false
		wait(0.75)
		TweenService:Create(ice, TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		ice:Destroy()
		Attack.Value = false
		wait(6)
		FireIceFloor = false
	end
end)

zz.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and Attack.Value == false and stunned == false and Stamina.Value > 20 and FireBomb == false and FireMode == true then
		FireBomb = true
		Stamina.Value = Stamina.Value -50
		FireSound:Play()
		FireFloorAnim:Play()
		wait(0.3)
		local FirePart = game.ServerStorage.FireFloor2:Clone()
		FirePart.CFrame = RootPart.CFrame * CFrame.new(0,-2,0)
		FirePart.Parent = script
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if FirePart == nil then
					break
				end
				connection = FirePart.Touched:Connect(function() end)
				results = FirePart:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 55*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.4)
			end
		end)
		expermentaltouch()
		TweenService:Create(FirePart, TweenInfo.new(1), {Size = Vector3.new(200,10,200)}):Play()
		wait(1)		
		for i,v in pairs(FirePart:GetChildren())do
			if v:IsA("ParticleEmitter") then
			v.Enabled = false
			end
		end
		wait(1)
		FirePart:Destroy()
		wait(5)
		FireBomb = false
		elseif Strength.Value>= 100 and Attack.Value == false and stunned == false and Stamina.Value > 40 and IceStep == false and IceMode == true then
		Attack.Value = true
		Stamina.Value = Stamina.Value - 40
		IceStep = true
		RangedIceAnim:Play()
		IceSound:Play()
		wait(0.3)
		local IcePart = game.ServerStorage.RangedIce:Clone()
		IcePart.CFrame = RootPart.CFrame * CFrame.new(0,-2,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		IcePart.Parent = script
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if IcePart == nil then
					break
				end
				connection = IcePart.Touched:Connect(function() end)
				results = IcePart:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.4)
			end
		end)
		expermentaltouch()
		TweenService:Create(IcePart, TweenInfo.new(1), {Size = Vector3.new(300,60,100),CFrame = IcePart.CFrame * CFrame.new(140,18,0)}):Play()
		wait(2)
		TweenService:Create(IcePart, TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		IcePart:Destroy()
		wait(0.3)
		Attack.Value = false
		wait(5)
		IceStep = false
		elseif Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value > 50 and IcyFire == false and BothMode == true then
		Stamina.Value = Stamina.Value - 50
		IcyFire = true
	   	RangedIceAnim:Play()
		Attack.Value = true
	    wait(0.3)
		local IcePart = game.ServerStorage.RangedIce:Clone()
		IcePart.CFrame = RootPart.CFrame * CFrame.new(0,-2,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		IcePart.Parent = script
		IcePart.Fire.Enabled = true
		IcePart.Fire1.Enabled = true
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if IcePart == nil then
					break
				end
				connection = IcePart.Touched:Connect(function() end)
				results = IcePart:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 65*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.4)
			end
		end)
		expermentaltouch()
		TweenService:Create(IcePart, TweenInfo.new(1), {Size = Vector3.new(300,60,100),CFrame = IcePart.CFrame * CFrame.new(140,18,0)}):Play()
		wait(1.25)
		IcePart.Fire.Enabled = false
		IcePart.Fire1.Enabled = false
		wait(0.75)
		TweenService:Create(IcePart, TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		IcePart:Destroy()
		wait(0.3)
		Attack.Value = false
		wait(8)
		IcyFire = false
	end
end)

cc.OnServerEvent:Connect(function()
		if Strength.Value >= 1000 and Attack.Value == false and stunned == false and Stamina.Value > 250 and ULT2 == false and BothMode == true then
		ULT2 = true
		Stamina.Value = Stamina.Value - 250
		cantrun = true
		Attack.Value = true
		Humanoid.AutoRotate = false
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		RootPart.Anchored = true
		ULT2Anim:Play()
		IceSound:Play()
		wait(.1)
		local IceFloor = game.ServerStorage.IceFloor:Clone()
		IceFloor.Parent = script
		IceFloor:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		TweenService:Create(IceFloor.Slide, TweenInfo.new(1),{Size = Vector3.new(100, 1, 100)}):Play()
		TweenService:Create(IceFloor.Slide2, TweenInfo.new(1),{Size = Vector3.new(100, 1, 100)}):Play()
		TweenService:Create(IceFloor.Slide3, TweenInfo.new(1),{Size = Vector3.new(100,1,100)}):Play()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if IceFloor == nil or IceFloor:FindFirstChild("Slide2") == nil then
					break
				end
				connection = IceFloor.Slide2.Touched:Connect(function() end)
				results = IceFloor.Slide2:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 45*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 4)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.15)
			end
		end)
		expermentaltouch()
		wait(1)
		local IcePart = game.ServerStorage.RangedIce2:Clone()
		IcePart.CFrame = RootPart.CFrame * CFrame.new(0,-2,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		IcePart.Parent = script
		local PlayersHitted1 = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if IcePart == nil then
					break
				end
				connection = IcePart.Touched:Connect(function() end)
				results = IcePart:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted1[results[i].Parent] ~= nil then
         						else
								PlayersHitted1[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 45*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 50
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.15)
			end
		end)
		expermentaltouch()
		TweenService:Create(IcePart, TweenInfo.new(1), {Size = Vector3.new(406, 100, 152),CFrame = IcePart.CFrame * CFrame.new(200,42,0)}):Play()
		wait(2)
		TweenService:Create(IcePart, TweenInfo.new(1), {Transparency = 1}):Play()
		game.Debris:AddItem(IcePart,1)
		IceFloor.Slide.Chill.Enabled = false
		for i,v in pairs(IceFloor:GetChildren()) do
			if v:IsA("BasePart") then
			TweenService:Create(v, TweenInfo.new(1), {Transparency = 1}):Play()
			end
		end
		game.Debris:AddItem(IceFloor,1)
		local FireFloor = game.ServerStorage.FireFloor3:Clone()
		FireFloor.Parent = script
		FireFloor:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		TweenService:Create(FireFloor.Slide, TweenInfo.new(1),{Size = Vector3.new(60, 1, 60)}):Play()
		TweenService:Create(FireFloor.Slide2, TweenInfo.new(1),{Size = Vector3.new(102, 1, 102)}):Play()
		TweenService:Create(FireFloor.Slide3, TweenInfo.new(1),{Size = Vector3.new(72, 1, 72)}):Play()
		TweenService:Create(FireFloor.Slide4, TweenInfo.new(1),{Size = Vector3.new(95, 1, 95)}):Play()
		TweenService:Create(FireFloor.Slide5, TweenInfo.new(1),{Size = Vector3.new(85, 1, 85)}):Play()
		wait(1)
		local FlameBlast = game.ServerStorage.FlameBlast:Clone()
		FlameBlast.Parent = script
		FlameBlast:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0)))
		local PlayersHitted2 = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if FlameBlast == nil or FlameBlast:FindFirstChild("HB") == nil then
					break
				end
				connection = FlameBlast.HB.Touched:Connect(function() end)
				results = FlameBlast.HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 and results[i].Parent.Name ~= Player.Name then
								if PlayersHitted2[results[i].Parent] ~= nil then
         						else
								PlayersHitted2[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 150
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Velocity = RootPart.CFrame.lookVector * 75
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,1)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.15)
			end
		end)
		expermentaltouch()
		TweenService:Create(FlameBlast.Effect,TweenInfo.new(1.5), {Size = Vector3.new(154, 150, 398),CFrame = FlameBlast.Effect.CFrame*CFrame.new(0,0,-144),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Effect2,TweenInfo.new(1.5), {Size = Vector3.new(164, 150, 399),CFrame = FlameBlast.Effect2.CFrame*CFrame.new(0,0,-144),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Effect3,TweenInfo.new(1.5), {Size = Vector3.new(158, 158, 402),CFrame = FlameBlast.Effect3.CFrame*CFrame.new(0,0,144),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Effect4,TweenInfo.new(1.5), {Size = Vector3.new(164, 164, 412),CFrame = FlameBlast.Effect4.CFrame*CFrame.new(0,0,144),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Effect5,TweenInfo.new(1.5), {Size = Vector3.new(198, 198, 424),CFrame = FlameBlast.Effect5.CFrame*CFrame.new(0,0,144),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.HB,TweenInfo.new(1.5), {Size = Vector3.new(200, 200, 424),CFrame = FlameBlast.HB.CFrame*CFrame.new(0,0,144),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Shock,TweenInfo.new(1.5), {Size = Vector3.new(225, 81, 225),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Shock2,TweenInfo.new(1.5), {Size = Vector3.new(336, 66, 336),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Shock3,TweenInfo.new(1.5), {Size = Vector3.new(500, 127, 500),Transparency = 1}):Play()
		TweenService:Create(FlameBlast.Shock4,TweenInfo.new(1.5), {Size = Vector3.new(225, 45, 225),Transparency = 1}):Play()
		local coo = coroutine.wrap(function()
		repeat wait()
			if FlameBlast == nil or FlameBlast:FindFirstChild("Shock") == nil or FlameBlast:FindFirstChild("Shock2") == nil or FlameBlast:FindFirstChild("Shock3") == nil or FlameBlast:FindFirstChild("Shock4") == nil then
				break
			end
			FlameBlast.Shock.CFrame = FlameBlast.Shock.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			FlameBlast.Shock2.CFrame = FlameBlast.Shock2.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			FlameBlast.Shock3.CFrame = FlameBlast.Shock3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			FlameBlast.Shock4.CFrame = FlameBlast.Shock4.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		until FlameBlast == nil
		end)
		coo()
		local coo = coroutine.wrap(function()
		wait(.5)
		FireFloor.Slide2.Particle.Enabled = false
		FireFloor.Slide2.Particle2.Enabled = false
		game.Debris:AddItem(FireFloor,.5)
		end)
		coo()
		for i,v in pairs(FireFloor:GetChildren()) do
			if v:IsA("BasePart") then
			TweenService:Create(v, TweenInfo.new(1), {Transparency = 1}):Play()
			end
		end
		wait(1)
		for i,v in pairs(FlameBlast:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		wait(.5)
		FlameBlast:Destroy()
		cantrun = false
		Attack.Value = false
		Humanoid.AutoRotate = true
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		RootPart.Anchored = false
		wait(25)
		ULT2 = false
		elseif Agility.Value >= 250 and Attack.Value == false and stunned == false and FireBlast == false and FireMode == true and FireBlastCD == false then
		Attack.Value = true
		FireBlast = true
		FireBlastCD = true
		FlameThrowerAnim:Play()
		wait(0.3)
		FlamePE.Fire1.Enabled = true
		FlamePE.Fire2.Enabled = true
		local clone = script.FireHB:Clone()
		clone.Parent = script 
		local corot = coroutine.wrap(function()
		repeat wait(0.1)
			clone.CFrame = RootPart.CFrame * CFrame.new(0,0,-82)
			Stamina.Value = Stamina.Value - 2
		until FireBlast == false or Stamina.Value <= 2
		FlamePE.Fire1.Enabled = false
		FlamePE.Fire2.Enabled = false
		wait(.1)
		Attack.Value = false
		FlameThrowerAnim:Stop()
		clone:Destroy()
		wait(6)
		FireBlastCD = false
		end)
		corot()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.25)
				PlayersHitted = {}
				if clone == nil then
					break
				end
				connection = clone.Touched:Connect(function() end)
				results = clone:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 5*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.1)
									end
								end
							end
						end 
					end
				end
			end
		end)
		expermentaltouch()
		wait(5)
		if FireBlast == true then
			FireBlast = false
		end
	elseif Agility.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value > 20 and IceSlide == false and IceMode == true and IceSlideCD == false then
		Stamina.Value = Stamina.Value - 20
		Attack.Value = true
		IceSlide = true
		IceSlideStartAnim:Play()
		wait(0.3)
		local Velocity = Instance.new("BodyVelocity", RootPart)
		Velocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		if Agility.Value >= 2000 then
		Velocity.Velocity = RootPart.CFrame.lookVector * 200
		else
		Velocity.Velocity = RootPart.CFrame.lookVector * (100 + Agility.Value * 0.05)
		end
		IceSlideAnim:Play()
		local corot = coroutine.wrap(function()
	repeat wait(0.15) 
		if Agility.Value >= 2000 then
		Velocity.Velocity = RootPart.CFrame.lookVector * 200
		else
		Velocity.Velocity = RootPart.CFrame.lookVector * (100 + Agility.Value * 0.05)
		end
		Stamina.Value = Stamina.Value - 0.5
		CreateIce()
	until IceSlide == false or Stamina.Value < 5
	Velocity:Destroy()
	IceSlideAnim:Stop()
	IceSlide = false
	Attack.Value = false
	IceSlideCD = true
	wait(5)
	IceSlideCD = false
end)
corot()
		wait(5)
		if IceSlide == true then
			IceSlide = false
		end
	end
end)
			
cup.OnServerEvent:Connect(function()
	if IceSlide == true then
		IceSlide = false
	elseif FireBlast == true then
		FireBlast = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value > 60 and FireStep == false and FireMode == true then
			FireStep = true
		Stamina.Value = Stamina.Value - 60
		FireBombAnim:Play()
		wait(0.3)
		FireSound:Play()
		local ExplodeModel = game.ServerStorage.HellFlameExplosion:Clone()
		ExplodeModel.Parent = script
		ExplodeModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,-100))
		local fire2 = game.ServerStorage.FireFloor:Clone()
		fire2.Size = Vector3.new(200,10,200)
		game.Debris:AddItem(fire2,5)
		local coo = coroutine.wrap(function()
		wait(3)
		fire2.Fire1.Enabled = false
		fire2.Fire2.Enabled = false
		fire2.Fire3.Enabled = false
		fire2.Fire4.Enabled = false
		end)
		coo()
		fire2.CFrame = ExplodeModel.DMG.CFrame*CFrame.new(0,-2,0)
		fire2.Parent = script
		local PlayersHit = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if fire2 == nil then
					break
				end
				connection = fire2.Touched:Connect(function() end)
				results = fire2:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
								DmgFunction:Fire(Character, hum, 5*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
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
				wait(0.33)
			end
		end)
		expermentaltouch()
TweenService:Create(ExplodeModel.DMG, TweenInfo.new(1.5), {Size = Vector3.new(260,260,260)}):Play()
TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.5), {Size = Vector3.new(470,470,470)}):Play()
TweenService:Create(ExplodeModel.Union, TweenInfo.new(1.5), {Transparency = 1}):Play()
TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.5), {Size = Vector3.new(260,260,260)}):Play()
TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1.5), {Transparency = 1}):Play()
game.Debris:AddItem(ExplodeModel,1.5)
local PlayersHitted = {}
local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if ExplodeModel == nil or ExplodeModel:FindFirstChild("DMG") == nil then
					break
				end
				connection = ExplodeModel.DMG.Touched:Connect(function() end)
				results = ExplodeModel.DMG:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHit[results[i].Parent] ~= nil then
         						else
								PlayersHit[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 70*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.15)
			end
		end)
		expermentaltouch()
		wait(8)
		FireStep = false
	elseif Strength.Value >= 250 and Attack.Value == false and stunned == false and Stamina.Value > 60 and Glacier == false and IceMode == true then
		Attack.Value = true
		Glacier = true
		Stamina.Value = Stamina.Value - 60
		GlacierAnim:Play()
		wait(0.3)
		IceSound:Play()
		local Ice = game.ServerStorage.Glacier:Clone()
		Ice.Parent = script
		Ice:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,-225,450)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
		for i=1, 10 do wait()
			Ice:SetPrimaryPartCFrame(Ice.PrimaryPart.CFrame*CFrame.new(-45,22.5,0))
		end
		local HB = Ice.HB:Clone()
		HB.Parent = script
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do	
				if HB == nil then
					break
				end
				connection = HB.Touched:Connect(function() end)
				results = HB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 65*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 4)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
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
		wait(2)
		for i,v in pairs(Ice:GetChildren()) do
			TweenService:Create(v, TweenInfo.new(0.5), {Transparency = 1}):Play()
		end
		wait(0.5)
		HB:Destroy()
		Ice:Destroy()
		wait(8)
		Glacier = false
		elseif Strength.Value >= 500 and Attack.Value == false and stunned == false and Stamina.Value > 200 and ULT == false and BothMode == true then
		Stamina.Value = Stamina.Value-200
		ULT = true
		cantrun = true
		Attack.Value = true
		Humanoid.AutoRotate = false
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		RootPart.Anchored = true
		ULTAnim:Play()
		IceSound:Play()
		local ice = game.ServerStorage.IceField:Clone()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if ice == nil then
					break
				end
				connection = ice.Touched:Connect(function() end)
				results = ice:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
								FreezeHumanoid(hum, HRT, 3)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.01)
			end
		end)
		expermentaltouch()
		ice.CFrame = RootPart.CFrame*CFrame.new(0,-1,0)
		ice.Parent = script
		ice.Fire2.Enabled = true
		TweenService:Create(ice,TweenInfo.new(1), {Size = Vector3.new(300,60,300)}):Play()
		TweenService:Create(ice,TweenInfo.new(1), {CFrame = ice.CFrame* CFrame.new(0,15,0)}):Play()
		wait(1)
		local Val = 1
		repeat wait()
		local Ring = game.ServerStorage.FireRing:Clone()
		Ring.CFrame = RootPart.CFrame*CFrame.new(0,5,0)
		Ring.Parent = script
		game.Debris:AddItem(Ring,1.5)
		TweenService:Create(Ring,TweenInfo.new(1), {Size = Vector3.new(370,30,370)}):Play()
		wait(.5)
		TweenService:Create(Ring,TweenInfo.new(1), {Transparency = 1}):Play()
		Val = Val + 1
		until Val == 4
		local FireExplosion = game.ServerStorage.FireExplosion:Clone()
		FireExplosion.CFrame = RootPart.CFrame
		FireExplosion.Parent = script
		FireExplosion.Transparency = 1
		TweenService:Create(ice,TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		ice:Destroy()
		FireExplosion.Transparency = 0
		local ExplosionHB = Instance.new("Part")
		ExplosionHB.Transparency = 1
		ExplosionHB.Anchored = true
		ExplosionHB.CanCollide = false
		ExplosionHB.CFrame = RootPart.CFrame
		ExplosionHB.Size = Vector3.new(40,40,40)
		ExplosionHB.Parent = script
		TweenService:Create(FireExplosion,TweenInfo.new(1), {Size = Vector3.new(370,370,370)}):Play()
		TweenService:Create(ExplosionHB,TweenInfo.new(1), {Size = Vector3.new(370,370,370)}):Play()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if ExplosionHB == nil then
					break
				end
				connection = ExplosionHB.Touched:Connect(function() end)
				results = ExplosionHB:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
								if PlayersHitted[results[i].Parent] ~= nil then
         						else
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, 50*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
									Velocity.Name = "Light"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = RootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,.25)
									end
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
		local fire2 = game.ServerStorage.FireFloor:Clone()
		fire2.Size = Vector3.new(300,10,300)
		fire2.Fire3.Enabled = true
		fire2.Fire4.Enabled = true
		game.Debris:AddItem(fire2,5)
		fire2.CFrame = RootPart.CFrame*CFrame.new(0,-2,0)
		fire2.Parent = script
		local coo = coroutine.wrap(function()
		wait(3)
		fire2.Fire1.Enabled = false
		fire2.Fire2.Enabled = false
		fire2.Fire3.Enabled = false
		fire2.Fire4.Enabled = false
		end)
		coo()
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if fire2 == nil then
					break
				end
				connection = fire2.Touched:Connect(function() end)
				results = fire2:GetTouchingParts()
				connection:Disconnect()
				if results ~= lastresult then
					for i=1,#results do
						if results[i].Name == "HumanoidRootPart" then
							if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.Name = "Light"
								local ObjectVal = Instance.new("ObjectValue",Velocity)
								ObjectVal.Value = RootPart
								ObjectVal.Name = "Hitist"
								game.Debris:AddItem(Velocity,.1)
								DmgFunction:Fire(Character, hum, 5*Strength.Value/2)
								if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 10
									local Velocity = Instance.new("BodyVelocity",HRT)
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
				wait(0.5)
			end
		end)
		expermentaltouch()
		wait(0.6)
		TweenService:Create(FireExplosion,TweenInfo.new(0.5), {Transparency = 1}):Play()
		wait(0.5)
		FireExplosion:Destroy()
		ExplosionHB:Destroy()
		Attack.Value = false
		Humanoid.AutoRotate = true
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		RootPart.Anchored = false
		cantrun = false
		wait(20)
		ULT = false
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

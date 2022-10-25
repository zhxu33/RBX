local Player
script.Player.OnServerEvent:Connect(function(player)
	Player = player
	if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 9 then
	script:Destroy()
	end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local FakeRootPart = Instance.new("Part", Character)
FakeRootPart.Name = "FakeRootPart"
FakeRootPart.Anchored = false
FakeRootPart.CanCollide = false
FakeRootPart.Transparency = 1
FakeRootPart.Size = Vector3.new(2,2,1)
FakeRootPart.Massless = true
local Weld = Instance.new("Motor6D",FakeRootPart)
Weld.Part0 = FakeRootPart
Weld.Part1 = RootPart
local OriginalCO = Weld.C0
wait()
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block)
local GiantGrabAnim = Humanoid:LoadAnimation(AnimationsFolder.GiantGrab)
local StompAnim = Humanoid:LoadAnimation(AnimationsFolder.Stomp)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local UltAnim = Humanoid:LoadAnimation(AnimationsFolder.Ult)
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
local GiantGrab = false
local Run = false
local cantrun = false
local Shift = false
local GiantMode = false
local Stomp = false
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
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local vv = script:WaitForChild("V")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")

local GiantMultiplier = 1

rr.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
	Block = true
	Attack.Value = true
	BlockAnim:Play()
	repeat wait()
	Defense.Value = 3*GiantMultiplier
	Stamina.Value = Stamina.Value - 3
	local coo = coroutine.wrap(function()
	if RootPart:FindFirstChild("Heavy") then
		game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
	end
	end)
	coo()
	until Block == false or Stamina.Value < 3
	BlockAnim:Stop()
	Defense.Value = 1*GiantMultiplier
	Attack.Value = false
	end
end)

rup.OnServerEvent:Connect(function()
	if Block == true then
	Block = false
	end
end)

local OriginalBodyHeightScale = Humanoid.BodyHeightScale.Value
local OriginalBodyWidthScale = Humanoid.BodyWidthScale.Value
local OriginalBodyDepthScale = Humanoid.BodyDepthScale.Value
local OriginalHeadScale = Humanoid.HeadScale.Value
local OverHead = Character.Head:WaitForChild("OverHead")


local UltMove = false
vv.OnServerEvent:Connect(function()
	if Strength.Value >= 100 and GiantMode == true and Stamina.Value >= 75 and Attack.Value == false and stunned == false and UltMove == false then
		UltMove = true
		Attack.Value = true
		Stamina.Value = Stamina.Value - 75
		UltAnim:Play()
		Humanoid.AutoRotate = false
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		cantrun = true
		wait(0.6)
		local bv = Instance.new("BodyVelocity", RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = RootPart.CFrame.lookVector * 100
		wait(0.6)
		bv:Destroy()
		RootPart.Anchored = true
		local UltModel = game.ServerStorage.GiantUlt:Clone()
		UltModel.Parent = script
		UltModel:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.Angles(math.rad(45),math.rad(0),math.rad(0)))
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				if UltModel == nil or UltModel:FindFirstChild("HB") == nil then
					break
				end
				wait(0.1)
				connection = UltModel.HB.Touched:Connect(function() end)
				results = UltModel.HB:GetTouchingParts()
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
        						DmgFunction:Fire(Character, hum, 80*Strength.Value/2)
        						if HRT:FindFirstChild("Light") == nil then
									Exp.Value = Exp.Value + 100
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
									local ObjectVal = Instance.new("ObjectValue",Velocity)
									ObjectVal.Value = FakeRootPart
									ObjectVal.Name = "Hitist"
									game.Debris:AddItem(Velocity,1)
									Velocity.Velocity = Vector3.new(0,50,0)
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
local coo = coroutine.wrap(function()
	repeat wait()
	for i,v in pairs(UltModel:GetChildren()) do
	v.CFrame = v.CFrame * CFrame.Angles(math.rad(0), math.rad(100), math.rad(0))
	end
	until Attack.Value == false or UltModel == nil
end)
coo()
TweenService:Create(UltModel.Shockwave, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = UltModel.Shockwave.Size + Vector3.new(7.5*(10+Humanoid.HeadScale.Value*1.5),6*(10+Humanoid.HeadScale.Value*1.5),7.5*(10+Humanoid.HeadScale.Value*1.5))}):Play()
TweenService:Create(UltModel.Shockwave2, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = UltModel.Shockwave2.Size + Vector3.new(3.75*(10+Humanoid.HeadScale.Value*1.5),6.4*(10+Humanoid.HeadScale.Value*1.5),3.75*(10+Humanoid.HeadScale.Value*1.5))}):Play()
TweenService:Create(UltModel.Shockwave3, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = UltModel.Shockwave3.Size + Vector3.new(9.6*(10+Humanoid.HeadScale.Value*1.5),9.6*(10+Humanoid.HeadScale.Value*1.5),9.6*(10+Humanoid.HeadScale.Value*1.5))}):Play()
TweenService:Create(UltModel.HB, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = UltModel.HB.Size + Vector3.new(7.5*(10+Humanoid.HeadScale.Value*1.5),7.5*(10+Humanoid.HeadScale.Value*1.5),7.5*(10+Humanoid.HeadScale.Value*1.5))}):Play()
wait(0.5+(0.05*Humanoid.HeadScale.Value*1.5))
		Attack.Value = false
		UltModel:Destroy()
		Humanoid.AutoRotate = true
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		cantrun = false
		RootPart.Anchored = false
		wait(8)
		UltMove = false
	end
end)


local CD = false 

cc.OnServerEvent:Connect(function(play, part)
	if Strength.Value >= 50 and GiantMode == true and CD == false and Stamina.Value >= 40 and Attack.Value == false and stunned == false and (RootPart.CFrame.p-part.Position).Magnitude <= Humanoid.BodyHeightScale.Value*4 and part.Size == Vector3.new(2,2,1) and GiantGrab == false and part.Parent.Parent.Name ~= "InteractionNPCS" then
		GiantGrab = true
		CD = true
		Stamina.Value = Stamina.Value - 40
		GiantGrabAnim:Play()
		wait(.4)
		local Weld = Instance.new("Motor6D",Character.RightHand)
Weld.Part0 = Character.RightHand
Weld.Part1 = part
part.Parent.Humanoid.WalkSpeed = 0
part.Parent.Humanoid.JumpPower = 0
local corot = coroutine.wrap(function()
repeat wait() 
part.Parent.Humanoid.WalkSpeed = 0
part.Parent.Humanoid.JumpPower = 0
until CD == false
end)
corot()
local HRT = part
local hum = part.Parent.Humanoid
Attack.Value = true
wait(1)
Weld:Destroy()
if HRT:FindFirstChild("Light") == nil then
		Exp.Value = Exp.Value + 150
		DmgFunction:Fire(Character, hum, 60*Strength.Value/2)
        local Velocity = Instance.new("BodyVelocity",HRT)
				game.Debris:AddItem(Velocity,.1)
				Velocity.Name = "Heavy"
				local ObjectVal = Instance.new("ObjectValue",Velocity)
				ObjectVal.Value = FakeRootPart
				ObjectVal.Name = "Hitist"
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
part.Parent.Humanoid.WalkSpeed = 18
part.Parent.Humanoid.WalkSpeed = 50
Attack.Value = false
CD = false
wait(5)
GiantGrab = false
	end
end)

local picked = 1
zz.OnServerEvent:Connect(function()
	if GiantMode == false and stunned == false and CD == false and not Character:FindFirstChild("Safezone") then
		picked = 3
		GiantMode = true
		CD = true
		GiantMultiplier = 2
		Defense.Value = 2
		local SafeTp = Instance.new("NumberValue",Character)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,2)
		if Strength.Value >= 1000 then
			TweenService:Create(Humanoid.BodyHeightScale, TweenInfo.new(1.5),{Value = Humanoid.BodyHeightScale.Value + 12}):Play()
			TweenService:Create(Humanoid.BodyWidthScale, TweenInfo.new(1.5),{Value = Humanoid.BodyWidthScale.Value + 12}):Play()
			TweenService:Create(Humanoid.BodyDepthScale, TweenInfo.new(1.5),{Value = Humanoid.BodyDepthScale.Value + 12}):Play()
			TweenService:Create(Humanoid.HeadScale, TweenInfo.new(1.5),{Value = Humanoid.HeadScale.Value + 12}):Play()
			TweenService:Create(OverHead, TweenInfo.new(1.5),{Size = UDim2.new(2.1*13,0,1*13,0),StudsOffset = Vector3.new(-1*13,2*13,0)}):Play()
			wait(1.5)
			Humanoid.JumpPower = 150
			local corot = coroutine.wrap(function()
	repeat wait()
		if Humanoid.JumpPower ~= 0 or 150 then
			Humanoid.JumpPower = 150
			end
		until GiantMode == false
end)
corot()      
			CD = false
		elseif Strength.Value < 1000 then
			TweenService:Create(Humanoid.BodyHeightScale, TweenInfo.new(1.5),{Value = Humanoid.BodyHeightScale.Value + 0.2*((20+Strength.Value/10)/2)}):Play()
			TweenService:Create(Humanoid.BodyWidthScale, TweenInfo.new(1.5),{Value = Humanoid.BodyWidthScale.Value + 0.2*((20+Strength.Value/10)/2)}):Play()
			TweenService:Create(Humanoid.BodyDepthScale, TweenInfo.new(1.5),{Value = Humanoid.BodyDepthScale.Value + 0.2*((20+Strength.Value/10)/2)}):Play()
			TweenService:Create(Humanoid.HeadScale, TweenInfo.new(1.5),{Value = Humanoid.HeadScale.Value + 0.2*((20+Strength.Value/10)/2)}):Play()
			TweenService:Create(OverHead, TweenInfo.new(1.5),{Size = UDim2.new(2.1*(1+0.2*((20+Strength.Value/10)/2)),0,1*(1+0.2*((20+Strength.Value/10)/2)),0),StudsOffset = Vector3.new(-1*(1+0.2*((20+Strength.Value/10)/2)),2*(1+0.2*((20+Strength.Value/10)/2)),0)}):Play()
			wait(1.5)
		Humanoid.JumpPower = 50 + Strength.Value/10
		local corot = coroutine.wrap(function()
	repeat wait()
		if Humanoid.JumpPower ~= 0 or 50 + Strength.Value/10 then
			Humanoid.JumpPower = 50 + Strength.Value/10
			end
		until GiantMode == false
end)
corot()
		CD = false
		end
		Weld.C0 = Weld.C0 * CFrame.new(0,2.6*Humanoid.BodyHeightScale.Value,0)
		elseif GiantMode == true and stunned == false and CD == false then
		CD = true
		Defense.Value = 1
		GiantMode = false
		local SafeTp = Instance.new("NumberValue",Character)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,2)
		TweenService:Create(Humanoid.BodyHeightScale, TweenInfo.new(1.5),{Value = OriginalBodyHeightScale}):Play()
		TweenService:Create(Humanoid.BodyWidthScale, TweenInfo.new(1.5),{Value = OriginalBodyWidthScale}):Play()
		TweenService:Create(Humanoid.BodyDepthScale, TweenInfo.new(1.5),{Value = OriginalBodyDepthScale}):Play()
		TweenService:Create(Humanoid.HeadScale, TweenInfo.new(1.5),{Value = OriginalHeadScale}):Play()
		TweenService:Create(OverHead, TweenInfo.new(1.5),{Size = UDim2.new(2.1,0,1,0),StudsOffset = Vector3.new(-1,2,0)}):Play()
		wait(1.5)
		GiantMultiplier = 1
		Weld.C0 = OriginalCO
		wait()
		Humanoid.JumpPower = 50
		CD = false
	end
end)

xx.OnServerEvent:Connect(function()
	if Attack.Value == false and Strength.Value >= 25 and GiantMode == true and stunned == false and Stamina.Value >= 30 and Stomp == false and CD == false then 
		Stamina.Value = Stamina.Value - 30
		Stomp = true
		Attack.Value = true
		StompAnim:Play()
		wait(.5)
		local ef = script.Shockwave:Clone()
		ef.Parent = script
		ef.CFrame = Character.RightFoot.CFrame
		local clone = script.Stomp:Clone()
		clone.Parent = script
		clone.CFrame = Character.RightFoot.CFrame
		clone.Orientation = Vector3.new(0,0,90)
		local hb = script.Stomp:Clone()
		hb.Parent = script
		hb.CFrame = Character.RightFoot.CFrame
		hb.Orientation = Vector3.new(0,0,90)
		hb.Transparency = 1
		local PlayersHitted = {}
		local PlayersHitted = {}
		local expermentaltouch = coroutine.wrap(function()
			local connection = nil
			local results = nil
			local lastresult = {}
			while true do
				wait(0.1)
				if hb == nil then
					break
				end
				
				connection = hb.Touched:Connect(function() end)
				results = hb:GetTouchingParts()
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
        						if HRT:FindFirstChild("Light") == nil then
        							Exp.Value = Exp.Value + 100
        							local Velocity = Instance.new("BodyVelocity",HRT)
        							Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        							Velocity.Name = "Heavy"
        							local ObjectVal = Instance.new("ObjectValue",Velocity)
        							ObjectVal.Value = FakeRootPart
        							ObjectVal.Name = "Hitist"
        							game.Debris:AddItem(Velocity,1)
        							Velocity.Velocity = Vector3.new(0,50,0)
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
local coo = coroutine.wrap(function()
	repeat wait()
	ef.CFrame = ef.CFrame * CFrame.Angles(math.rad(0), math.rad(100), math.rad(0))
	until Attack.Value == false or ef == nil
end)
coo()
TweenService:Create(clone, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = clone.Size + Vector3.new(0.4*(10+Humanoid.HeadScale.Value*1.5),4*(10+Humanoid.HeadScale.Value*1.5),4*(10+Humanoid.HeadScale.Value*1.5))}):Play()
TweenService:Create(hb, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = hb.Size + Vector3.new(4*(10+Humanoid.HeadScale.Value*1.5),4*(10+Humanoid.HeadScale.Value*1.5),4*(10+Humanoid.HeadScale.Value*1.5))}):Play()
TweenService:Create(ef, TweenInfo.new(0.5+(0.05*Humanoid.HeadScale.Value*1.5)), {Transparency = 1, Size = ef.Size + Vector3.new(5.5*(10+Humanoid.HeadScale.Value*1.5),5.5*(10+Humanoid.HeadScale.Value*1.5),5.5*(10+Humanoid.HeadScale.Value*1.5))}):Play()
wait(0.5+(0.05*Humanoid.HeadScale.Value*1.5))
		Attack.Value = false
		clone:Destroy()
		hb:Destroy()
		ef:Destroy()
		wait(3)
		Stomp = false
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

ee.OnServerEvent:Connect(function()
	if Attack.Value == false and stunned == false and Stamina.Value > 10 then
	Stamina.Value = Stamina.Value - 10
	local animation = Instance.new("Animation")
	animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[picked]
	local animTrack = Humanoid:LoadAnimation(animation)
	animTrack:Play()
	if GiantMode == true then
	local Touched = true
	local HB = Instance.new("Part", script)
	HB.Anchored = false
	HB.CanCollide = false
	HB.Transparency = 1
	HB.Size = Vector3.new(5*Humanoid.BodyHeightScale.Value,6*Humanoid.BodyHeightScale.Value,5*Humanoid.BodyHeightScale.Value)
	HB.CFrame = RootPart.CFrame
	HB.Massless = true
	local Weld = Instance.new("Weld",HB)
	Weld.Part0 = HB
	Weld.Part1 = RootPart
	game.Debris:AddItem(HB,.8)
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
								if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
         							return
								end
								PlayersHitted[results[i].Parent] = results[i].Parent
        						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
	    						local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
	    						if HRT:FindFirstChild("Light") == nil then
	    							Exp.Value = Exp.Value + 50
	    							HitSound:Play()
	    							local Velocity = Instance.new("BodyVelocity",HRT)
	    							Velocity.MaxForce = Vector3.new(10000,10000,10000)
	    							Velocity.Velocity = RootPart.CFrame.lookVector * 40
	    							Velocity.Name = "Light"
	 								local ObjectVal = Instance.new("ObjectValue",Velocity)
	    							ObjectVal.Value = FakeRootPart
	    							ObjectVal.Name = "Hitist"
	    							game.Debris:AddItem(Velocity,.5)
								end
							end
						end 
					end
				lastresult = results
				end
				wait(0.25)
			end
		end)
		expermentaltouch()
	end
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
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
						if PlayersHitted[results[i].Parent] ~= nil or results[i].Parent:FindFirstChild("ForceField") or PartyFinder:Invoke(Player, results[i].Parent) then
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

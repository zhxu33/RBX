local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina          = script.Parent.Stamina
local MaxStamina       = script.Parent.MaxStamina
local Target  = nil
local Damage  = 15000
local Stunned = false
local HitSound    = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId  = "rbxassetid://232210146"
HitSound.Volume   = 0.2
local CombatType  = 1
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim   = {2313015622,2313016464,2313017174,2313014821}
local OrcaBurstAnim  = Humanoid:LoadAnimation(script.OrcaBurst) 
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun           = Humanoid:LoadAnimation(script.stunned)
local TweenService   = game:GetService("TweenService")
local OrcaForm  = false
local RedColor  = Color3.fromRGB(255, 0, 0)
local Assets    = game:GetService("ServerStorage").QuirkAssets.Orcinus
local UniAssets = game:GetService("ServerStorage").UniversalAssets

HumanoidRootPart.ChildAdded:Connect(function(Child)
	if Child == "Light" or Child == "Heavy" then
		Child:Destroy()
		Stunned = true
		local asdfg = false
		HvyStunnedAnim:Play()
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		for i = 1,3 do
			if asdfg == true or not HumanoidRootPart:FindFirstChild("Heavy") then
				break
			else
				wait(0.25) -- StunTime
			end
		end
		if HumanoidRootPart:FindFirstChild("Heavy") then			
			HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
		end
		HvyStunnedAnim:Stop()
		asdfg = true
		Humanoid.WalkSpeed = 100
		Humanoid.JumpPower = 100
		Stunned = false
	end
end)

HumanoidRootPart.ChildAdded:Connect(function(Child)
	if Child == "Light" or Child == "Heavy" then
		Child:Destroy()
	end
end)

local function ComplicatedMistake()
	local newBind = Instance.new("BindableEvent")
	newBind.Name  = "Aggro"
	newBind.Event:Connect(function(newTarget)
		Target = newTarget.PrimaryPart or Target
	end)
	newBind.Parent = Character
end
ComplicatedMistake()

local Supa1CD = false
local function CreateSupa1()
	Supa1CD = true
	OrcaBurstAnim:Play()
	task.wait(.5)
	local OrcaShock = Assets.OrcaShock:Clone()
	OrcaShock:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)))
	OrcaShock.Parent       = script
	local PlayersHitted    = {}
	local expermentaltouch = coroutine.wrap(function()
		local connection = nil
		local results    = nil
		local lastresult = {}
		while OrcaShock.Parent do
			connection = OrcaShock.HB.Touched:Connect(function() end)
			results    = OrcaShock.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i].Parent.Parent.Name ~= "NPCs" then
						if PlayersHitted[results[i].Parent] ~= nil then
						else
							PlayersHitted[results[i].Parent] = results[i].Parent
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*2)
							if HRT:FindFirstChild("Light") == nil then
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(20000,20000,20000)
								Velocity.Name = "Heavy"
								Velocity.Velocity = OrcaShock.HB.CFrame.lookVector * -150
								game.Debris:AddItem(Velocity,.5)
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
	TweenService:Create(OrcaShock.HB, TweenInfo.new(.5), {CFrame = OrcaShock.HB.CFrame*CFrame.new(0,0,45), Size = OrcaShock.HB.Size*3, Transparency = 1}):Play()
	for i=1, 7 do
		for i,v in pairs(OrcaShock[7-i]:GetChildren()) do
			v.Transparency = .925
			TweenService:Create(v, TweenInfo.new(.5), {CFrame = v.CFrame*CFrame.new(0,-75,0), Size = v.Size*7.5, Transparency = 1}):Play()
		end
		local BlueOrcaShock = Assets.BlueOrcaShock:Clone()
		BlueOrcaShock.Parent = script
		BlueOrcaShock.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(180),math.rad(90),math.rad(90))
		if OrcaForm == true then
			BlueOrcaShock.Color = RedColor
		end
		game.Debris:AddItem(BlueOrcaShock, .5)
		TweenService:Create(BlueOrcaShock,TweenInfo.new(.5), {Size = BlueOrcaShock.Size*6, Transparency = 1}):Play()
		wait(.05)
	end
	
	wait(.5)
	OrcaShock:Destroy()
	task.delay(5, function()
		Supa1CD = false
	end)
end

local Supa2CD = false
local function CreateSupa2()
	Supa2CD = true
	OrcaBurstAnim:Play()
	wait(.5)
	local OrcaShock = Assets.OrcaShock:Clone()
	OrcaShock:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,-10,0)*CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)))
	OrcaShock.Parent = script
	local PlayersHitted = {}
	local expermentaltouch = coroutine.wrap(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while OrcaShock.Parent do
			connection = OrcaShock.HB.Touched:Connect(function() end)
			results    = OrcaShock.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i].Parent.Parent.Name ~= "NPCs" then
						if PlayersHitted[results[i].Parent] ~= nil then
						else
							PlayersHitted[results[i].Parent] = results[i].Parent
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*3)
							if HRT:FindFirstChild("Light") == nil then
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(20000,20000,20000)
								Velocity.Name = "Heavy"
								Velocity.Velocity = OrcaShock.HB.CFrame.lookVector * 150
								game.Debris:AddItem(Velocity,.5)
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
	TweenService:Create(OrcaShock.HB, TweenInfo.new(1), {CFrame = OrcaShock.HB.CFrame*CFrame.new(0,0,200), Size = OrcaShock.HB.Size*12, Transparency = 1}):Play()
	for i=1, 7 do
		local BlueOrcaShock = Assets.BlueOrcaShock:Clone()
		BlueOrcaShock.Parent = script
		BlueOrcaShock.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(180),math.rad(0),math.rad(0))
		if OrcaForm == true then
			BlueOrcaShock.Color = RedColor
		end
		game.Debris:AddItem(BlueOrcaShock, .5)
		TweenService:Create(BlueOrcaShock,TweenInfo.new(.75), {Size = BlueOrcaShock.Size*20, Transparency = 1}):Play()
		for i,v in pairs(OrcaShock[7-i]:GetChildren()) do
			v.Transparency = .925
			TweenService:Create(v, TweenInfo.new(2), {CFrame = v.CFrame*CFrame.new(0,-150,0), Size = v.Size*30, Transparency = 1}):Play()
		end
		wait(.05)
	end
	wait(2)
	OrcaShock:Destroy()
	task.delay(8, function()
		Supa2CD = false
	end)
end

local Supa3CD = false
local function CreateSupa3()
	Supa3CD = true
	OrcaBurstAnim:Play()
	wait(.5)
	local OrcaExplode = Assets.OrcaExplode:Clone()
	OrcaExplode.Parent = script
	OrcaExplode:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	for i,v in pairs(OrcaExplode:GetChildren()) do
		TweenService:Create(v, TweenInfo.new(.75), {Size = v.Size*4}):Play()
	end
	local PlayersHitted = {}
	local expermentaltouch = coroutine.wrap(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while true do
			if OrcaExplode.HB == nil then
				break
			end
			for i,v in pairs(OrcaExplode:GetChildren()) do
				if OrcaForm == true and v.Name == "Ball" then
					v.Color = RedColor
				end
				if v.Name == "Diag" then
					v.CFrame = v.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
				elseif v.Name == "Horizontal" then
					v.CFrame = v.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
				end
			end
			connection = OrcaExplode.HB.Touched:Connect(function() end)
			results = OrcaExplode.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character and results[i].Parent.Parent.Name ~= "NPCs" then
						if PlayersHitted[results[i].Parent] ~= nil then
						else
							PlayersHitted[results[i].Parent] = results[i].Parent
							local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
							local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
							DmgFunction:Fire(Character, hum, Damage*3)
							if HRT:FindFirstChild("Light") == nil then
								local Velocity = Instance.new("BodyVelocity",HRT)
								Velocity.MaxForce = Vector3.new(20000,20000,20000)
								Velocity.Name = "Heavy"
								Velocity.Velocity = Vector3.new(0,50,0)
								game.Debris:AddItem(Velocity,.5)
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
	wait(1.5)
	for i,v in pairs(OrcaExplode:GetChildren()) do
		TweenService:Create(v, TweenInfo.new(.5), {Transparency = 1}):Play()
	end
	game.Debris:AddItem(OrcaExplode,.5)
	task.delay(12, function()
		Supa3CD = false
	end)
end

task.spawn(function()
	while task.wait(.5) do
		if Humanoid.Health < Humanoid.MaxHealth/2 and OrcaForm == false then
			OrcaForm = true
			Damage = Damage*1.5
			local OrcaEyes = Assets.OrcaEyes:Clone()
			Humanoid:AddAccessory(OrcaEyes)
			OrcaEyes.Parent = Character
		end
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and Stunned == false then
			if Supa3CD == false then
				CreateSupa3()
			elseif Supa2CD == false then
				CreateSupa2()
			elseif Supa1CD == false then
				CreateSupa1()
			end
		end
		if Target and Target.Parent and (Target.Position - HumanoidRootPart.Position).magnitude < 10 and Humanoid.Health > 0 and Stunned == false then 
			local animation = Instance.new("Animation")
			animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[CombatType]
			DmgFunction:Fire(Character,Target.Parent.Humanoid, Damage)
			local animTrack = Humanoid:LoadAnimation(animation)
			animTrack:Play()
			if CombatType == 1 then
				CombatType = 2
			elseif CombatType == 2 then
				CombatType = 3
			elseif CombatType == 3 then
				CombatType = 4
			elseif CombatType == 4 then
				CombatType = 1
			end
		end
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		local coro = coroutine.wrap(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,Character.Name)
			end
		end)
		coro()
	end
end)

local Walking = false
while task.wait(.5) do
	pcall(function()
		if (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		end
		if Target == nil then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, OriginalCFrame.p)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						break
					end
					Humanoid:MoveTo(Point.Position)
					Humanoid.MoveToFinished:wait()
					if Point.Action == Enum.PathWaypointAction.Jump  then
						Humanoid.Jump = true
					end
				end
			elseif Path.Status == Enum.PathStatus.NoPath then
				Humanoid:MoveTo(OriginalCFrame.p)
			end
		elseif Target.Parent == nil then 
			Target = nil
		elseif (Target.Position - OriginalCFrame.p).magnitude > 500 then
			Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, Target.Position)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						return
					end
					Humanoid:MoveTo(Point.Position)
					if Point.Action == Enum.PathWaypointAction.Jump  then
						Humanoid.Jump = true
					end
				end
			elseif Path.Status == Enum.PathStatus.NoPath then
				Humanoid:MoveTo(Target.Position)
			end
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 then
			Target = nil
		end
	end)
end
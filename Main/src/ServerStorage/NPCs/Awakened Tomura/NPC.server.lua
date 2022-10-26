local Humanoid  = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame   = CFrame.new(HumanoidRootPart.Position)
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target     = nil
local Damage     = 100000
local Stunned    = false
local HitSound   = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume  = 0.2
local CombatType = 1
local DecayFloor = false
local DecayCrack = false
local AirCannon  = false
local SuperForm  = false
local Attack     = false
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward      = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim   = {2313015622,2313016464,2313017174,2313014821}
local TweenService      = game:GetService("TweenService")
local WalkSpeed         = 100
local DecayFloorAnim    = Humanoid:LoadAnimation(script.DecayFloor) 
local DecayAirBlastAnim = Humanoid:LoadAnimation(script.DecayAirBlast) 
local Assets    = game:GetService("ServerStorage").QuirkAssets.TomuraAFO
local UniAssets = game:GetService("ServerStorage").UniversalAssets

local function CreateDecayFloor()
	Attack = true
	DecayFloor = true
	DecayFloorAnim:Play()
	wait(0.3)
	local Floor = Assets.BigDecayFloor:Clone()
	Floor.Parent = script
	Floor:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	game.Debris:AddItem(Floor, 6)
	local PlayersHitted = {}
	local expermentaltouch = coroutine.wrap(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while Floor.Parent do
			PlayersHitted = {}
			connection = Floor.HB.Touched:Connect(function() end)
			results    = Floor.HB:GetTouchingParts()
			connection:Disconnect()
			if true then
				for i=1,#results do
					if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" and results[i].Name == "HumanoidRootPart"  then
						if PlayersHitted[results[i].Parent] ~= nil then
							return
						end
						local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
						local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
						DmgFunction:Fire(Character, hum, Damage/2)
						if HRT:FindFirstChild("Light") == nil then
							local Velocity = Instance.new("BodyVelocity",HRT)
							Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							Velocity.Name = "Light"
							game.Debris:AddItem(Velocity,.1)
						end
					end 
				end
				lastresult = results
			end	
			wait(0.5)
		end
	end)
	expermentaltouch()			
	Attack = false
	wait(4)
	for i,v in pairs(Floor.Effect:GetChildren()) do
		if v:IsA("Beam") or v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	coroutine.wrap(function()
		wait(10)
		DecayFloor = false	
	end)()
end

local function CreateDecayCrack()
	Attack = true
	DecayCrack = true
	DecayFloorAnim:Play()
	wait(0.3)
	local Floor = Assets.DecayCrack:Clone()
	Floor.Parent = script
	Floor:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))*CFrame.new(0,1,0))
	game.Debris:AddItem(Floor, 3)
	local PlayersHitted = {}
	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while Floor.Parent do
			PlayersHitted = {}
			connection    = Floor.HB.Touched:Connect(function() end)
			results       = Floor.HB:GetTouchingParts()
			connection:Disconnect()
			for i=1,#results do
				if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" and results[i].Name == "HumanoidRootPart"  then
					if PlayersHitted[results[i].Parent] ~= nil then
						return
					end
					local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
					local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, Damage/3)
					if HRT:FindFirstChild("Light") == nil then
						local Velocity = Instance.new("BodyVelocity",HRT)
						Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Velocity.Name = "Light"
						game.Debris:AddItem(Velocity,.1)
					end
				end 
			end
			lastresult = results
			wait(0.5)
		end
	end)

	wait(2.5)
	for i,v in pairs(Floor:GetDescendants()) do
		if v:IsA("Beam") or v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	for i,v in pairs(Floor:GetChildren()) do
		TweenService:Create(v,TweenInfo.new(0.5),{Transparency = 1}):Play()
	end
	Attack = false
	task.delay(3, function()
		DecayCrack = false	
	end)
end

local function CreateAirCannon()
	Attack = true
	AirCannon = true
	DecayAirBlastAnim:Play()
	wait(0.6)
	local PE = Assets.TACParticles.TACAirCannon:Clone()
	PE.Parent = Character.LeftUpperArm
	wait(.7)
	PE:Destroy()
	local AirBlastModel = Assets.TomuraAirCannon:Clone()
	AirBlastModel.Parent = script
	AirBlastModel:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(-1.5, 1, -11)*CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)))
	AirBlastModel.Main.Pink.C0 = AirBlastModel.Main.Pink.C0*CFrame.new(15, 0, 0)*CFrame.Angles(0, math.rad(90), 0)
	AirBlastModel.Main.Black.C0 = AirBlastModel.Main.Black.C0*CFrame.new(15, 0, 0)*CFrame.Angles(0, math.rad(90), 0)
	game.Debris:AddItem(AirBlastModel, 1.2)
	local PlayersHitted = {}

	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while AirBlastModel.Parent do
			connection = AirBlastModel.HB.Touched:Connect(function() end)
			results    = AirBlastModel.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Name == "HumanoidRootPart" and  results[i].Parent.Parent.Name ~= "NPCs" then
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
							if PlayersHitted[results[i].Parent] ~= nil then
							else
								PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, Damage)
								if hum.Health ~= 0 then
									task.spawn(function()
										local Hurt = hum
										local Chary = results[i].Parent
										local Parts = {}
										for v,parts in pairs(Chary:GetChildren()) do
											if parts:IsA("BasePart") and (parts.Name == "LeftFoot" or parts.Name == "RightLowerLeg" or parts.Name == "LeftLowerArm" or parts.Name == "RightUpperArm") then
												local v = Assets.TACParticles.TACAfterEffect:Clone()
												v.Parent = parts
												table.insert(Parts, v)
											end
										end
										for i=1,7 do
											wait(0.3)
											if Hurt.Health == 0 then break end
											DmgFunction:Fire(Character, hum, Damage/10)
										end
										for i=1,#Parts do
											Parts[i]:Destroy()
										end
										Parts = nil
									end)
								end

								if HRT:FindFirstChild("Light") == nil then
									local Velocity    = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name     = "Heavy"
									game.Debris:AddItem(Velocity,1)
									Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 100
								end
							end
						end
					end 
				end
				lastresult = results
			end
			wait(0.25)
		end
	end)

	for v,effects in pairs(AirBlastModel.ParticleBox:GetChildren()) do
		if effects:IsA("ParticleEmitter") then
			task.spawn(function()
				effects.Enabled = true
				wait(.4)
				effects.Enabled = false
			end)
		end
	end
	
	task.spawn(function()
		while task.wait() and AirBlastModel.Parent do
			AirBlastModel.Main.Pink.C0  = AirBlastModel.Main.Pink.C0*CFrame.Angles(0, 0, math.rad(20))
			AirBlastModel.Main.Black.C0 = AirBlastModel.Main.Black.C0*CFrame.Angles(0, 0, math.rad(-20))
		end
	end)

	TweenService:Create(AirBlastModel.Main,        TweenInfo.new(1.2), {Size = AirBlastModel.Main.Size + Vector3.new(140,70,70),CFrame = AirBlastModel.Main.CFrame * CFrame.new(-70,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.HB,          TweenInfo.new(1.2), {Size = AirBlastModel.Main.Size + Vector3.new(140,70,70),CFrame = AirBlastModel.HB.CFrame * CFrame.new(-70,0,0),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.ParticleBox, TweenInfo.new(1.2), {Size = AirBlastModel.ParticleBox.Size + Vector3.new(190,160,160),CFrame = AirBlastModel.ParticleBox.CFrame * CFrame.new(-50,0,0)}):Play()
	TweenService:Create(AirBlastModel.Pink,        TweenInfo.new(1.2), {Size = AirBlastModel.Pink.Size + Vector3.new(170,170,200),CFrame = AirBlastModel.Pink.CFrame * CFrame.new(0,0,-40),Transparency = 1}):Play()
	TweenService:Create(AirBlastModel.Black,       TweenInfo.new(1.2), {Size = AirBlastModel.Black.Size + Vector3.new(170,170,200),CFrame = AirBlastModel.Black.CFrame * CFrame.new(0,0,-40),Transparency = 1}):Play()
	wait(1.2)
	Attack = false

	task.delay(3, function()
		AirCannon = false	
	end)
end

task.spawn(function()
	while wait(.1) do
		if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 125 or Humanoid.JumpPower ~= 0 and Humanoid.JumpPower ~= WalkSpeed then
			Humanoid.WalkSpeed = WalkSpeed
			Humanoid.JumpPower = 125
		end
	end
end)

task.spawn(function()
	while wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 200 and Humanoid.Health > 0 and DecayFloor == false and Attack == false then
			CreateDecayFloor()
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 200 and Humanoid.Health > 0 and DecayCrack == false and Attack == false then
			CreateDecayCrack()
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and AirCannon == false and Attack == false then
			CreateAirCannon()
		end
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

HumanoidRootPart.ChildAdded:Connect(function(Child)
	if Child == "Light" or Child == "Heavy" then
		Child:Destroy()
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		task.spawn(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,"Awakened Tomura")
			end
		end)
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
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, Target.Position)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						break
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
		else
			Target = nil
		end
		if Humanoid.Health <= Humanoid.MaxHealth/2 and SuperForm == false then
			SuperForm = true
			Damage    = Damage * 1.5
			for i,v in pairs(Character:GetChildren()) do
				if v:IsA("BasePart") then
					for i,vv in pairs(script.ModeParticles:GetChildren()) do
						if vv.Name ~= "Damage" then
							local clone = vv:Clone()
							clone.Parent = v
						end
					end
				end
			end
		end
	end)
end
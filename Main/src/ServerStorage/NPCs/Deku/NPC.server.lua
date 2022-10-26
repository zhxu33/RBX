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
local CombatType    = 1
local SuperSmash    = false
local DetroitKick   = false
local PercentSmash  = false
local SuperForm     = false
local Attack        = false
local RespawnNPC    = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward     = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction   = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward        = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim     = {2313015622,2313016464,2313017174,2313014821}
local TweenService  = game:GetService("TweenService")
local WalkSpeed     = 100
local MillSmashAnim = Humanoid:LoadAnimation(script.MillSmash) 
local StompAnim = Humanoid:LoadAnimation(script.Stomp) 
local SmashAnim = Humanoid:LoadAnimation(script.Smash) 
local Assets    = game:GetService("ServerStorage").QuirkAssets.DekuOFA
local UniAssets = game:GetService("ServerStorage").UniversalAssets

local function CreatePercentSmash()
	PercentSmash = true
	Attack = true
	SmashAnim:Play()
	wait(1)
	local sound1 = Instance.new("Sound")
	sound1.SoundId = "rbxassetid://138137702"
	sound1.MaxDistance = 300
	sound1.EmitterSize = 20
	sound1.Volume = 1
	sound1.Pitch = 0.95
	sound1.Parent = HumanoidRootPart 
	sound1:Play()
	game.Debris:AddItem(sound1, 5)
	local shok = UniAssets.TexasSmash3:Clone()
	shok:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.new(0,5,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
	shok.Parent               = script
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
	local Effect2    = UniAssets.Shockwave3:Clone()
	Effect2.Parent   = script
	Effect2.CFrame   = HumanoidRootPart.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	Effect2.Anchored = true
	Effect2.Size     = Vector3.new(60,8,60)
	
	Effect2.Transparency = 1
	local bv    = Instance.new("BodyVelocity", shok.HB)
	bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = HumanoidRootPart.CFrame.lookVector * 125
	shok.HB.Anchored = false
	
	local PlayersHitted = {}
	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while shok.Parent do
			connection = shok.HB.Touched:Connect(function() end)
			results    = shok.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Name == "HumanoidRootPart" then
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" then
							if PlayersHitted[results[i].Parent] ~= nil then
							else
								PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, Damage)
								if not HRT:FindFirstChild("Light") then
									local Velocity    = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name     = "Heavy"
									game.Debris:AddItem(Velocity,.7)
									Velocity.Velocity = bv.Velocity
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
	
	task.spawn(function()
		while wait() and shok and shok.Parent do
			shok.HB.CFrame = shok.HB.CFrame * CFrame.Angles(math.rad(29), math.rad(0), math.rad(0))
			Effect.CFrame = Effect.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect2.CFrame = Effect2.CFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			Effect3.CFrame = Effect3.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect4.CFrame = Effect4.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect5.CFrame = Effect5.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Effect6.CFrame = Effect6.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		end
	end)
	
	TweenService:Create(Effect, TweenInfo.new(3), {Size = Vector3.new(300, 30, 300)}):Play()
	TweenService:Create(Effect2,TweenInfo.new(3), {Size = Vector3.new(166,27,166)}):Play()
	TweenService:Create(Effect3,TweenInfo.new(3), {Size = Vector3.new(200, 30, 200)}):Play()
	TweenService:Create(Effect4,TweenInfo.new(3), {Size = Vector3.new(189, 15, 189)}):Play()
	TweenService:Create(Effect5,TweenInfo.new(3), {Size = Vector3.new(220, 20, 220)}):Play()
	TweenService:Create(Effect6,TweenInfo.new(3), {Size = Vector3.new(225, 30, 225)}):Play()
	TweenService:Create(Effect7,TweenInfo.new(3), {Size = Vector3.new(106, 16, 126)}):Play()
	TweenService:Create(Effect8,TweenInfo.new(3), {Size = Vector3.new(54, 31, 215)}):Play()
	wait(1.5)
	Attack = false
	TweenService:Create(Effect2,TweenInfo.new(1.5), {Transparency = 1}):Play()
	for i,v in pairs(shok:GetChildren()) do
		TweenService:Create(v,TweenInfo.new(1.5), {Transparency = 1}):Play()
	end
	wait(1.5)
	shok:Destroy()
	Effect2:Destroy()
	task.delay(1, function()
		PercentSmash = false
	end)
end

local function CreateDetroitKick()
	DetroitKick = true
	Attack = true
	StompAnim:Play()
	wait(.4)
	local sound2 = Instance.new("Sound")
	sound2.SoundId = "rbxassetid://157878578"
	sound2.MaxDistance = 300
	sound2.EmitterSize = 20
	sound2.Volume = 0.4
	sound2.Pitch = 0.9
	sound2.Parent = HumanoidRootPart
	sound2:Play()
	game.Debris:AddItem(sound2, 5)
	local Clone  = Assets.ManchesterSmash:Clone()
	Clone.Parent = script
	Clone:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	local PlayersHitted = {}
	
	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while Clone.Parent do
			connection = Clone.HB.Touched:Connect(function() end)
			results    = Clone.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Name == "HumanoidRootPart" then
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" then
							if PlayersHitted[results[i].Parent] ~= nil then
							else
								PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, Damage*1.5)
								if HRT:FindFirstChild("Light") == nil then
									local Velocity = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name = "Heavy"
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
	
	TweenService:Create(Clone.Tornado,  TweenInfo.new(1.5),{Size = Vector3.new(280, 80, 280),  Position = Clone.Tornado.Position + Vector3.new(0,15,0)}):Play()
	TweenService:Create(Clone.Tornado2, TweenInfo.new(1.5),{Size = Vector3.new(200, 150, 200), Position = Clone.Tornado2.Position + Vector3.new(0,40,0)}):Play()
	TweenService:Create(Clone.HB,       TweenInfo.new(1.5),{Size = Vector3.new(200, 150, 200), Position = Clone.HB.Position + Vector3.new(0,25,0)}):Play()
	
	task.spawn(function()
		while wait() and Attack and Clone do
			if Clone == nil or Clone:FindFirstChild("Tornado") == nil or Clone:FindFirstChild("Tornado2") == nil then
				break
			end
			Clone.Tornado.CFrame = Clone.Tornado.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
			Clone.Tornado2.CFrame = Clone.Tornado2.CFrame * CFrame.Angles(math.rad(0), math.rad(29), math.rad(0))
		end
	end)
	
	wait(2)
	TweenService:Create(Clone.Tornado,  TweenInfo.new(0.5), {Transparency = 1}):Play()
	TweenService:Create(Clone.Tornado2, TweenInfo.new(0.5), {Transparency = 1}):Play()
	wait(.5)
	Clone:Destroy()
	Attack = false
	task.delay(5, function()
		DetroitKick = false
	end)
end

local function CreateMillSmash()
	SuperSmash = true
	Attack = true
	MillSmashAnim:Play()
	wait(.8)
	local sound1       = Instance.new("Sound")
	sound1.SoundId     = "rbxassetid://138137702"
	sound1.MaxDistance = 300
	sound1.EmitterSize = 20
	sound1.Volume = 1.5
	sound1.Pitch  = 0.95
	sound1.Parent = HumanoidRootPart 
	sound1:Play()
	game.Debris:AddItem(sound1, 5)
	local MillSmash = UniAssets.MillSmash:Clone()
	MillSmash.Parent = script
	MillSmash:SetPrimaryPartCFrame(HumanoidRootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)))
	local Effect2  = UniAssets.Shockwave3:Clone()
	Effect2.Parent = script
	Effect2.CFrame = HumanoidRootPart.CFrame*CFrame.new(0,2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	Effect2.Anchored = true
	Effect2.Size = Vector3.new(270,36,270)
	Effect2.Transparency = 1
	local bv    = Instance.new("BodyVelocity", MillSmash.HB)
	bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	bv.Velocity = HumanoidRootPart.CFrame.lookVector * 100
	local PlayersHitted   = {}
	MillSmash.HB.Anchored = false
	
	task.spawn(function()
		local connection = nil
		local results = nil
		local lastresult = {}
		while MillSmash.Parent do
			connection = MillSmash.HB.Touched:Connect(function() end)
			results    = MillSmash.HB:GetTouchingParts()
			connection:Disconnect()
			if results ~= lastresult then
				for i=1,#results do
					if results[i].Name == "HumanoidRootPart" then
						if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent.Parent.Name ~= "NPCs" then
							if PlayersHitted[results[i].Parent] ~= nil then
							else
								PlayersHitted[results[i].Parent] = results[i].Parent
								local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
								local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
								DmgFunction:Fire(Character, hum, Damage*3)	
								if HRT:FindFirstChild("Light") == nil then
									local Velocity    = Instance.new("BodyVelocity",HRT)
									Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
									Velocity.Name     = "Heavy"
									game.Debris:AddItem(Velocity,1)
									Velocity.Velocity = HumanoidRootPart.CFrame.lookVector * 150
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
	
	task.spawn(function()
		while wait() and MillSmash and MillSmash.Parent do
			MillSmash.HB.CFrame       *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect3.CFrame  *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect5.CFrame  *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect6.CFrame  *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect7.CFrame  *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect8.CFrame  *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect9.CFrame  *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect10.CFrame *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect11.CFrame *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			MillSmash.Effect12.CFrame *=CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
		end
	end)
	
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
	TweenService:Create(MillSmash.Effect,TweenInfo.new(3),  {CFrame = MillSmash.Effect.CFrame*CFrame.new(0,0,50)}):Play()
	TweenService:Create(MillSmash.Effect2,TweenInfo.new(3), {CFrame = MillSmash.Effect2.CFrame*CFrame.new(0,0,50)}):Play()
	TweenService:Create(Effect2,TweenInfo.new(3), {Size = Vector3.new(450,70,450),CFrame = Effect2.CFrame*CFrame.new(0,5,0)}):Play()
	wait(1.5)
	Attack = false
	for i,v in pairs(MillSmash:GetChildren()) do
		TweenService:Create(v, TweenInfo.new(1.5),{Transparency = 1}):Play()
	end
	TweenService:Create(Effect2,TweenInfo.new(1.5), {Transparency = 1}):Play()
	wait(1.5)
	Effect2:Destroy()
	MillSmash:Destroy()
	task.delay(15, function()
		SuperSmash = false 
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
	while task.wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 200 and Humanoid.Health > 0 and SuperSmash == false and Attack == false then
			CreateMillSmash()
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and Humanoid.Health > 0 and DetroitKick == false and Attack == false then
			CreateDetroitKick()
		elseif Target and (Target.Position - HumanoidRootPart.Position).magnitude < 150 and Humanoid.Health > 0 and PercentSmash == false and Attack == false then
			CreatePercentSmash()
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
				NPCReward.Reward(PlayersHitted.Name,"Deku")
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
				if v:IsA("BasePart")then
					local lightning = script.Lightning2:Clone()
					lightning.Parent = v
					lightning.Enabled = true
					lightning.Rate = 10
					wait()
				end
			end
			local FullCowlEyes = Assets.FullCowlEyes:Clone()
			for i,v in pairs(FullCowlEyes:GetChildren()) do
				v.Parent = Character.Head
			end
		end
	end)
end
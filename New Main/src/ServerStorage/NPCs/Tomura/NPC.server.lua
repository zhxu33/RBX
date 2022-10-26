local Humanoid         = script.Parent.Humanoid
local Character        = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local RightHand        = Character.RightHand
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local TomuraAnim     = Humanoid:LoadAnimation(script.Tomura)
local DecayFloorAnim = Humanoid:LoadAnimation(script.DecayFloor)
local DecayThrowStartAnim  = Humanoid:LoadAnimation(script.DecayThrowStart)
local DecayThrowMidAnim    = Humanoid:LoadAnimation(script.DecayThrowMid)
local DecayThrowFinishAnim = Humanoid:LoadAnimation(script.DecayThrowFinish)
local DecayChargeAnim = Humanoid:LoadAnimation(script.DecayCharge)
local HvyStunnedAnim  = Humanoid:LoadAnimation(script.heavystunned)
local Stun       = Humanoid:LoadAnimation(script.stunned)
local Attack     = false
local AttackDB   = false
local Stamina    = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 2500
local supa   = 1
local supacharge = false
local supapoo    = false
local HitSound   = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume  = 0.2
local Stunned    = false
local Grabbed    = false
local RespawnNPC  = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward   = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local Assets      = game:GetService("ServerStorage").QuirkAssets.Decay
local UniAssets   = game:GetService("ServerStorage")

local DecayTouchHit = {}
RightHand.Touched:Connect(function(hit)
	if Target ~= nil and hit.Parent == Target.Parent and AttackDB == true and Stunned == false and Humanoid.Health > 0 and Grabbed == false then
		for i,tableValue in pairs(DecayTouchHit) do
			if tableValue == hit.Parent then return end
		end
		table.insert(DecayTouchHit, hit.Parent)
		task.delay(.1, function()
			table.remove(DecayTouchHit, table.find(hit.Parent))
		end)
		
		local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
		local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
		DmgFunction:Fire(Character, hum, Damage/2)
		local Velocity    = Instance.new("BodyVelocity",HRT)
		Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		Velocity.Name     = "Light"
		game.Debris:AddItem(Velocity, .1)
	end
end)

local function CreateSupa()
	DecayFloorAnim:Play()
	task.wait(0.3)
	local Floor = Assets.DecayFloor:Clone()
	Floor.Parent = script
	Floor:SetPrimaryPartCFrame(HumanoidRootPart.CFrame)
	game.Debris:AddItem(Floor, 5)
	local PlayersHitted = {}
	Floor.HB.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name then
			for i,tableValue in pairs(PlayersHitted) do
				if tableValue == hit.Parent then return end
			end
			table.insert(PlayersHitted, hit.Parent)
			task.delay(.3, function()
				table.remove(PlayersHitted, 1, hit.Parent)
			end)
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
			DmgFunction:Fire(Character, hum, Damage*2)
			local Velocity    = Instance.new("BodyVelocity",HRT)
			Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velocity.Name     = "Light"
			game.Debris:AddItem(Velocity,.1)
		end
	end)				
	task.delay(4, function()
		for i,v in pairs(Floor.Effects:GetChildren()) do
			if v:IsA("Beam") or v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end		
	end)
end

local function supa2()
	DecayChargeAnim:Play()
	task.wait(.3)
	supacharge  = true
	
	local BV    = Instance.new("BodyVelocity", HumanoidRootPart)
	BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	BV.Velocity = HumanoidRootPart.CFrame.lookVector * 250
	BV.Name     = "DecayDash"
	
	task.wait(1.2)
	BV:Destroy()
	supacharge = false
end

Humanoid.Touched:Connect(function(hit)
	if not hit.Parent then return end
	if not hit.Parent:FindFirstChild("Humanoid") then return end
	if hit.Parent.Humanoid.Health > 0 and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= Character.Name and supacharge == true then
		supacharge = false
		if HumanoidRootPart:FindFirstChild("DecayDash") then
			HumanoidRootPart:FindFirstChild("DecayDash"):Destroy()
		end
		local hum  = hit.Parent:FindFirstChildOfClass("Humanoid")
		local HRT  = hit.Parent:FindFirstChild("HumanoidRootPart")
		
		task.spawn(function()
			for i=1, 10 do wait(.1)
				DmgFunction:Fire(Character, hum, Damage/2)	
			end
		end)
		
		local Velocity = Instance.new("BodyVelocity",HRT)
		Velocity.Name  = "Heavy"
		game.Debris:AddItem(Velocity,1)
		if hum.Health > 0 then
			DecayThrowMidAnim:Play()
			task.spawn(function()
				for i=1, 10 do wait(.1)
					DmgFunction:Fire(Character, hum, Damage/3)	
				end
			end)
			
			wait(1)
			DecayThrowFinishAnim:Play()
			wait(.3)
			DmgFunction:Fire(Character, hum, Damage*3)
			local Velocity2    = Instance.new("BodyVelocity",HRT)
			Velocity2.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velocity2.Name     = "Heavy"
			Velocity2.Velocity = HumanoidRootPart.CFrame.lookVector * -100
			game.Debris:AddItem(Velocity2,1.5)
		end
	end
end)

task.spawn(function()
	while task.wait(.5) do
		if Attack == false and Stunned == false and Target and (Target.Position - HumanoidRootPart.Position).magnitude < 50 and Humanoid.Health > 0 then
			if supapoo == false then
				supapoo = true
				Attack = true
				TomuraAnim:Stop()
				if supa == 1 then
					supa = 2
					CreateSupa()
					Attack = false
					task.delay(8, function()
						supapoo = false
					end)
				elseif supa == 2 then
					supa = 1
					supa2()
					Attack = false
					task.delay(8, function()
						supapoo = false
					end)
				end
			end
		elseif Stunned == false and Attack == false and Target ~= nil then
			AttackDB = true
			TomuraAnim:Play()
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
	if Child == "Light" then
		Child:Destroy()
	elseif Child == "Heavy" then
		Stunned = true
		local asdfg = false
		HvyStunnedAnim:Play()
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		for i = 1,3 do
			if asdfg == true or not HumanoidRootPart:FindFirstChild("Heavy") then
				break
			else
				wait(0.25) -- stuntime
			end
		end	
		if HumanoidRootPart:FindFirstChild("Heavy") then
			HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
		end

		HvyStunnedAnim:Stop()
		asdfg = true
		Humanoid.WalkSpeed = 75
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 75 then
		Humanoid.WalkSpeed = 75
	end
end)

local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		task.spawn(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,Character.Name)
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
			TomuraAnim:Stop()
			Grabbed = false
		elseif Target.Parent == nil then 
			Target = nil
		elseif (Target.Position - OriginalCFrame.p).magnitude > 500 then
			Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 and Grabbed == false then
			Walking = false
			wait()
			Walking = true
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
			Humanoid.WalkSpeed = 75
			Target = nil
		end
	end)
end
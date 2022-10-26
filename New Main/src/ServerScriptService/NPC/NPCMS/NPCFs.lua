local module = {}
local Debris       = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DefaultAnimations = game:GetService("ServerScriptService").NPC.NPCMS.DefaultAnimations
local DmgFunction = ReplicatedStorage.DamageFunction
local Inf_        = math.huge
--------------------------------------------------------------------------------------------------------------------------------------------|
----------------------------------- Data collection based functions ------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|


function module.QuickRaycast(StartPosition, Direction, BlackList, Distance) -- Quickly call a raycast.
	local raycastParams = RaycastParams.new()                                                      
	raycastParams.FilterDescendantsInstances = BlackList or {}                                           
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist   
	local raycastresults = workspace:Raycast(StartPosition, Direction*(Distance or 10), raycastParams) 
	return raycastresults
end

function module.EnemyDirection(ERP, HumanoidRootPart, EHum, Speed) -- short cut to getting the direction from npc to enemy, varaible is enemy / play root part.
	if ERP and EHum then
		local Speed = Speed or 1
		local CDir = (ERP.Position + (EHum.MoveDirection * EHum.WalkSpeed)) - HumanoidRootPart.Position
		local Direction = Vector3.new(CDir.Unit.X, HumanoidRootPart.CFrame.LookVector.Y,CDir.Unit.Z)	
		return Direction
	end
end


function module.Punch(NPC, Target, Damage, AnimeCycle, Distance) -- This npc's first attack
	AnimeCycle = module.Cycle(4, AnimeCycle)
	NPC.Humanoid.Animator:LoadAnimation(DefaultAnimations["Punch"..AnimeCycle]):Play()
	if (Target.Position - NPC.HumanoidRootPart.Position).magnitude < (Distance or 8) then
		DmgFunction:Fire(NPC, Target.Parent.Humanoid, Damage)
	end
	return AnimeCycle
end

--------------------------------------------------------------------------------------------------------------------------------------------|
----------------------------------- Combat based functions ---------------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|


-----------
function module.ExecuteMove(HumanoidRootPart, EHumanoidRootPart, Variables)
	--ListExample =	local returnlist = {["Hitbox"] = {["Type"] = "RadiusHit",["Position"] =  HumanoidRootPart.Position, ["Range"] =  33, ["Reptition"] = 16}, ["Damage"] = {["DamageAmount"] = Damage*2, ["Quirk"] = "Decay"}, ["Effects"] = {}, ["Stun"] = Vector3.new(0,0,0)}
	coroutine.wrap(function()
		for i=1,Variables.Hitbox.Reptition do
			local PlayersHitted = {}
			local PlayersHitted = module.RadiusHit(Variables.Hitbox.Position, Variables.Hitbox.Range, PlayersHitted, {})
			for i=1,#PlayersHitted[1] do
				if not PlayersHitted[2][PlayersHitted[1]] then
					PlayersHitted[2][PlayersHitted[1]] = true
					local humanoid = PlayersHitted[1][i].Parent:FindFirstChildOfClass("Humanoid")
					local humanoidrootpart = PlayersHitted[1][i].Parent:FindFirstChild("HumanoidRootPart")		
					DmgFunction(HumanoidRootPart.Parent, humanoid, Variables.Damage[1])
				end
			end
			wait(0.3)
		end 
	end)()	
	--this will be the main function for calling in hit box, damamge, and ect. 
end
-----------

function module.Target(Variable, Target, Speed, Type, Variables)
	if Type == "Humanoid" then
		local EHumanoidRootPart = Target.Parent:FindFirstChild("HumanoidRootPart")
		local HumanoidRootPart  = Variable.HumanoidRootPart
		local EHum              = Target.Parent:FindFirstChild("Humanoid")
		if EHum and EHumanoidRootPart then
			local Distance = (EHumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
			local CDir     = (EHumanoidRootPart.Position + EHum.MoveDirection * (Variables.WalkSpeed or EHum.WalkSpeed) * (Distance/Speed)) - HumanoidRootPart.Position
			local Direction= Vector3.new(CDir.Unit.X, HumanoidRootPart.CFrame.LookVector.Y, CDir.Unit.Z)
			local heading  = math.atan2(-CDir.Z ,CDir.X)
			HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position)*CFrame.Angles(0,heading-math.rad(90),0)
		end	
	elseif Type == "Custom" and Target.Parent then
		Target = Target.Parent:FindFirstChild("HumanoidRootPart")
		if not Target then return end
		local Distance = (Target.Position - Variable.Position).magnitude
		local CDir     = Target.Position + (Variables.TargetVelocity or Vector3.new(0,0,0)) - Variable.Position
		local Direction= Vector3.new(CDir.Unit.X, Variable.CFrame.LookVector.Y, CDir.Unit.Z)
		local heading  = math.atan2(-CDir.Z ,CDir.X)
		if Variables.Animate then
			TweenService:Create(Variable, Variables.Animate.TweenInfo or TweenInfo.new(1), {CFrame = CFrame.new(Variable.Position)*CFrame.Angles(0,heading-math.rad(Variables.Angle or 90),0)}):Play()
		else
			Variable.CFrame = CFrame.new(Variable.Position)*CFrame.Angles(0,heading-math.rad(Variables.Angle or 90),0)
		end			
	end
end


function module.Pause() --pauses stuff for a short bit, makes more sense in the context on npc combat.
	wait(1)
end

function module.HalfPause() --pauses stuff for a short bit, makes more sense in the context on npc combat.
	wait(0.5)
end

function module.MiniPause() --pauses stuff for a short bit, makes more sense in the context on npc combat.
	wait(0.1)
end

function module.RadiusHit(StartPoint, Range, Hit, Blacklist) -- SRadiusStrike
	local PlayerHitlist = {}
	local Offset = Vector3.new(Range+4,Range+4,Range+4)
	local Region = Region3.new(StartPoint - Offset, StartPoint + Offset)
	local plrs = Players:GetPlayers()
	for i=1,#plrs do
		if plrs[i].Character then
			table.insert(PlayerHitlist, plrs[i].Character)
		end
	end
	local parts = game.Workspace:FindPartsInRegion3WithWhiteList(Region, PlayerHitlist, Inf_)
	for _,Part in pairs(parts) do
		if Part.Name == "HumanoidRootPart" and not Blacklist[Part] and (Part.Position - StartPoint).magnitude <= Range then
			table.insert(Hit, Part)
		end
	end
	return {Hit, Blacklist}
end

function module.RegionHitbox(Dimensions, Hit, Blacklist) -- SRadiusStrike
	local PlayerHitlist = {}
	local Region = Region3.new(Dimensions[1], Dimensions[2])
	local plrs = Players:GetPlayers()
	for i=1,#plrs do
		if plrs[i].Character then
			table.insert(PlayerHitlist, plrs[i].Character)
		end
	end
	local parts = game.Workspace:FindPartsInRegion3WithWhiteList(Region, PlayerHitlist, Inf_)
	for _,Part in pairs(parts) do
		if Part.Name == "HumanoidRootPart" and not Blacklist[Part]  then
			table.insert(Hit, Part)
		end
	end
	return {Hit, Blacklist}
end

function module.Face(HumanoidRootPart, EHumanoidRootPart, EHum)
	local Distance = (EHumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
	local CDir = (EHumanoidRootPart.Position + EHum.MoveDirection * EHum.WalkSpeed * (Distance/240)) - HumanoidRootPart.Position
	local Direction = Vector3.new(CDir.Unit.X, HumanoidRootPart.CFrame.LookVector.Y, CDir.Unit.Z)
	local heading = math.atan2(-CDir.Z ,CDir.X)
	HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position)*CFrame.Angles(0,heading-math.rad(90),0)
end

function module.FaceWhereGoing(HumanoidRootPart, EHumanoidRootPart, EHum, Power)
	local Distance = (EHumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
	local CDir = (EHumanoidRootPart.Position + EHum.MoveDirection * EHum.WalkSpeed * (Distance/(Power*4))) - HumanoidRootPart.Position
	local Direction = Vector3.new(CDir.Unit.X, HumanoidRootPart.CFrame.LookVector.Y, CDir.Unit.Z)
	local heading = math.atan2(-CDir.Z ,CDir.X)
	HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position)*CFrame.Angles(0,heading-math.rad(90),0)
	return Direction
end


function module.Dash(Direction, Core, Lifetime, Power, Animation) -- simple dash shortcut
	if Direction and Core then
		local Power = Power or 100
		local Lifetime = Lifetime or 0.5
		local movement = Instance.new("BodyVelocity")
		movement.MaxForce = Vector3.new(Inf_,Inf_,Inf_)
		movement.Velocity = (Direction + Vector3.new(0,0.01,0)) * Power
		movement.Name = "Heavy"
		movement.Parent = Core
		Debris:AddItem(movement, Lifetime)
		if Animation and Core.Parent:FindFirstChild("Humanoid") then
			Core.Parent.Humanoid:LoadAnimation(Animation):Play()
		end
	end
end

--The npc is trying to dodge the second variable / player. Rando is left incase the function fails in which it calls itself back for a different type fo dodge.
function module.Dodge(HumanoidRootPart, EHumanoidRootPart, EHum, Power, Rando, Animations)
	if EHumanoidRootPart then
		local Rando = Rando or math.random(1,2)
		local shok = game.ServerStorage.UniversalAssets.TexasSmash2:Clone() --game.ServerStorage.TexasSmash2:Clone()
		local Distance = (EHumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
		local CDir = (EHumanoidRootPart.Position + EHum.MoveDirection * EHum.WalkSpeed * (Distance/170/1.5)) - HumanoidRootPart.Position
		local Direction = Vector3.new(CDir.Unit.X, HumanoidRootPart.CFrame.LookVector.Y, CDir.Unit.Z)
		local heading = math.atan2(-CDir.Z ,CDir.X)
		if Rando == 1 then
			HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0,heading-math.rad(-215),0)			
			local Raycast = module.QuickRaycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector, HumanoidRootPart.Parent:GetChildren(), 350)
			if not Raycast then
				module.Dash(HumanoidRootPart.CFrame.LookVector, HumanoidRootPart, nil, Power, (Animations or {}).CustomWalk)
			else
				module.Dodge(HumanoidRootPart, EHumanoidRootPart, EHum, Power, 2, nil)
			end
		elseif Rando == 2 then
			HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0,heading-math.rad(-325),0)
			local Raycast = module.QuickRaycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector, HumanoidRootPart.Parent:GetChildren(), 350)
			if not Raycast then
				module.Dash(HumanoidRootPart.CFrame.LookVector, HumanoidRootPart, nil, Power, (Animations or {}).CustomWalk)
			else
				module.Dodge(HumanoidRootPart, EHumanoidRootPart, EHum, Power, 3, nil)
			end
		elseif Rando == 3 then
			module.Dash(Vector3.new(0,0.5,0), HumanoidRootPart, nil, Power, (Animations or {}).CustomJump)
		end
	end	
end


function module.Rush(HumanoidRootPart, EHumanoidRootPart, EHum, Power) -- Having a basic dash auto aimed towards the player.
	Power = Power or 100
	local Distance = (EHumanoidRootPart.Position + (EHum.MoveDirection * EHum.WalkSpeed) - HumanoidRootPart.Position).magnitude
	module.Dash(
		module.EnemyDirection(EHumanoidRootPart, HumanoidRootPart, EHum, Power), 
		HumanoidRootPart, 
		Distance/(Power*4),
		Power)
end

function module.PauseRush(HumanoidRootPart, EHumanoidRootPart, EHum, Power) -- Having a basic dash auto aimed towards the player.
	Power = Power or 100
	local Distance = (EHumanoidRootPart.Position + (EHum.MoveDirection * EHum.WalkSpeed) - HumanoidRootPart.Position).magnitude
	module.Dash(
		module.EnemyDirection(EHumanoidRootPart, HumanoidRootPart, EHum, Power), 
		HumanoidRootPart, 
		Distance/(Power*4),
		Power)
	wait(Distance/(Power*4))
end

function module.DoubleRush(HumanoidRootPart, EHumanoidRootPart, EHum, Power) -- Having a basic dash auto aimed towards the player.
	Power = Power or 100
	local Distance = (EHumanoidRootPart.Position + (EHum.MoveDirection * EHum.WalkSpeed) - HumanoidRootPart.Position).magnitude
	module.Dash(
		module.EnemyDirection(EHumanoidRootPart, HumanoidRootPart, EHum, Power), 
		HumanoidRootPart, 
		Distance/(Power*2),
		Power)
end

function module.Retreat(HumanoidRootPart, EHumanoidRootPart, EHum, Power)
	module.Dash(-module.EnemyDirection(EHumanoidRootPart, HumanoidRootPart, EHum, 1), HumanoidRootPart, nil, Power)
end

function module.PauseRetreat(HumanoidRootPart, EHumanoidRootPart, EHum, Power)
	module.Dash(-module.EnemyDirection(EHumanoidRootPart, HumanoidRootPart, EHum, 1), HumanoidRootPart, nil, Power)
	wait(0.5)
end

function module.Chase(HumanoidRootPart, EHumanoidRootPart, EHum)
	local Hum
	if HumanoidRootPart.Parent then
		Hum = HumanoidRootPart.Parent:FindFirstChild("Humanoid")
	else
		warn(HumanoidRootPart.Name.."'s Parent not found.")
	end
	if Hum and EHumanoidRootPart then
		Hum:MoveTo(EHumanoidRootPart.Position + EHum.MoveDirection * (EHum.WalkSpeed/10), EHumanoidRootPart)
	end	
end

function module.Charge(HumanoidRootPart, EHumanoidRootPart, EHum) -- moves the npc a bit closer.
	local Hum = HumanoidRootPart.Parent:FindFirstChild("Humanoid")
	if Hum then
		Hum:MoveTo(EHumanoidRootPart.Position+Vector3.new(0,0,EHum.WalkSpeed), EHumanoidRootPart)
		wait(1)
		Hum:MoveTo(HumanoidRootPart.Position)
	end	
end

--------------------------------------------------------------------------------------------------------------------------------------------|
----------------------------------- Other shortcuts ----------------------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|

function module.SafeWait(Time, HumanoidRootPart, EHumanoidRootPart)
	wait(Time)
	if HumanoidRootPart and EHumanoidRootPart then
		return false
	end
	return true
end

function module.Cycle(FullNumber, CurrentNumber)
	if CurrentNumber+1 < FullNumber then
		CurrentNumber+=1
		return CurrentNumber
	else
		return 1
	end
end

function module.SpawnSound(ID, LifeTime, Values, Core) --Spawns in a sound with option values. Volume, EmitterSize, MaxDistance, Pitch
	local Sound = Instance.new("Sound")
	Sound.SoundId = "http://www.roblox.com/asset/?id="..ID
	Sound.MaxDistance = Values.MaxDistance or 300
	Sound.EmitterSize = Values.EmitterSize or 20
	Sound.Volume = Values.Volume or 1
	Sound.Pitch = Values.Pitch or 1
	Sound.Parent = Core
	Sound:Play()
	game.Debris:AddItem(Sound, LifeTime or Sound.TimeLength)
	return Sound
end

return module
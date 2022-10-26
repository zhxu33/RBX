local Parts = {}

-- // Services \\ --
local ServerStorage       = game:GetService("ServerStorage")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DebrisService       = game:GetService("Debris")

-- // Modules \\ --
local modules = {}

for _, module in pairs(script:GetChildren()) do
	local reqMod = require(module)
	if not reqMod.Activated then continue end
	
	modules[module.Name] = reqMod
end

-- // Variables \\ --
Parts._OnHit    = nil :: BindableEvent | nil
Parts._Hitboxes = nil :: {} | nil

-- // Gets humanoid from ancestors that are of model class
function Parts:FindRootPartOfAncestors( Part : (Part | Model) ) : (Part | nil, Model | nil)
	if not Part then return end
	local RootPart    = nil
	local ModelParent = Part:FindFirstAncestorOfClass("Model")

	if ModelParent then
		if ModelParent:FindFirstChild("Humanoid") and ModelParent.PrimaryPart then
			if ModelParent.Humanoid.Health > 0 then 
				RootPart = (ModelParent.PrimaryPart or ModelParent:FindFirstChild("HumanoidRootPart"))
			end
		else
			RootPart = self:FindRootPartOfAncestors(ModelParent)
		end
	end

	return RootPart, ModelParent
end

-- // Returns root part if part is a model
function Parts:FindRootPartOfAncestor( Part : (Part | Model) ) : (Part | nil, Model | nil)
	if not (Part and Part.Parent) then return end
	if not (Part.Parent:IsA("Model")) then return end
	
	local Model    = Part.Parent
	local RootPart = (Model.PrimaryPart or Model:FindFirstChild("HumanoidRootPart"))
	
	return RootPart, Model
end

-- // Gets a DeepCopy of a table
function Parts:DeepCopy(oldVal : any) : any
	local isTable  = type(oldVal) == "table"
	local newTable = isTable and {} or oldVal

	if isTable then
		for Index, Value in pairs(oldVal) do
			newTable[Index] = self:DeepCopy(Value)
		end
	end

	return newTable
end

-- // Checks if it has an index
local function HasIndex(val) : boolean
	return (next(val) ~= nil)
end

-- // Plays hit processes when a user is hit
local function DamageProcess(Settings:table, Player:Model, HitChar:Model, ExtraInfo:any)
	if (Settings._isPaused) then return end
	if not (Settings._NotRemoved) then return end
	
	local newInfo = Parts:DeepCopy(Settings.HitInfo)
	if (newInfo and HasIndex(ExtraInfo)) then
		for index, value in pairs(ExtraInfo) do
			newInfo[index] = value
		end

		if ExtraInfo.DamageMod then
			newInfo.Damage *= ExtraInfo.DamageMod
		end
	end
	
	for _, module in pairs(modules) do
		task.spawn(function()
			local success, err = pcall(module.Fire, module, Player, HitChar, Settings, newInfo)
			if not success then warn(err) end
		end)
	end
	
	Parts._OnHit:Fire(Player, HitChar, Settings.AttackId, (newInfo or {}))
	
	if not Settings.OnHit then return end
	Settings.OnHit:Fire(Player, HitChar, Settings, newInfo)
end

-- // the process
function Parts:Process(HitParts:{}, Settings:table, ExtraInfo:any)
	if type(HitParts) ~= "table" or not Settings._NotRemoved or Settings._HasHit or not (Settings.Object and Settings.Object.Parent) then return end
	local Blacklist = Settings.Blacklist
	ExtraInfo = ExtraInfo or {}
	
	for _, PartHit in pairs(HitParts) do
		local RootPart       = Parts:FindRootPartOfAncestor(PartHit)
		local EnemyCharacter = (RootPart and RootPart.Parent)
		if not (EnemyCharacter) or table.find(Blacklist, EnemyCharacter) then continue end
		table.insert(Blacklist, EnemyCharacter)

		-- // Options per hit
		DamageProcess(Settings, Settings.Player, EnemyCharacter, ExtraInfo)

		-- // Makes it so this version of Damage Over Time works
		if (Settings.PerformOverTime and Settings.Threads) then
			local OTPlayersHit = Settings.OverTimePlayersHit
			local MaxHits      = (Settings.OverTimeMaxHits or 10000)
			local RateOfHits   = Settings.OverTimeRateOfHit
			
			-- // Removing player hit after hit rate is over
			table.insert(Settings.Threads, task.delay(RateOfHits, function()
				if not (OTPlayersHit and MaxHits and RateOfHits and EnemyCharacter.Parent) then return end

				local PrevVal = OTPlayersHit[EnemyCharacter] or 0

				if (MaxHits <= PrevVal) then return end
				table.remove(Blacklist, table.find(Blacklist, EnemyCharacter))

				OTPlayersHit[EnemyCharacter] = PrevVal + 1
			end))
		end

		-- // Deals extra hits upon hitting a player
		if Settings.PerformLinger then
			task.spawn(function()
				local Damage   = Settings.LingerDamage
				local Duration = Settings.LingerDuration + os.clock()
				local MaxHits  = Settings.LingerMaxHits or math.huge
				local Rate     = Settings.LingerRateOfHit

				for _ = 1, MaxHits do
					if Settings._HasHit or os.clock() > Duration then break end
					task.wait(Rate)
					ExtraInfo.DamageMod = Settings.LingerDamage
					DamageProcess(Settings, Settings.Player, EnemyCharacter, ExtraInfo)
				end
			end)
		end

		-- // Will play a sound when the character is hit
		if (Settings.HitSound) then
			local SoundClone = Settings.HitSound:Clone()

			SoundClone.Parent = EnemyCharacter.PrimaryPart or EnemyCharacter:FindFirstChild("HumanoidRootPart")
			SoundClone:Play()
			DebrisService:AddItem(SoundClone, SoundClone.TimeLength)
		end

		-- // Makes it so the move no longer is in hitbox tables
		if (Settings.ReturnTable or Settings.HitOneTarget) then
			Settings._HasHit = true
			self.DestroyPart(Settings)
			break
		end
	end
end

-- // disconnect
local function disposeInfo(Item : any) : nil
	local Type = typeof(Item)
	
	if Type == "table" then
		for index, child in pairs(Item) do
			Item[index] = disposeInfo(child)
			Item[index] = nil
		end
		
		table.clear(Item)
	elseif Type == "RBXScriptConnection" then
		Item:Disconnect()
	elseif Type == "thread" and coroutine.status(Item) == "suspended" then
		task.cancel(Item)
	elseif Type == "Instance" and Item:IsA("BindableEvent") then
		Item:Destroy()
	end
	
	return nil
end

-- // Disposing function | Removes table \\ --
function Parts.DestroyPart(Settings)
	if not (Settings and Settings._NotRemoved) then return end
	Settings._NotRemoved = false
	Settings._HasHit     = true

	-- // Remove hitbox
	local ID = Settings.ID
	if ID then Parts._Hitboxes[ID] = nil end
	
	-- // Fires so wait connections are removed
	if Settings.OnHit then
		Settings.OnHit:Fire(nil, nil, Settings, Parts:DeepCopy(Settings.HitInfo))
		Settings.OnHit:DisconnectAll()
	end
	
	-- // Removes connections [Touched]
	if Settings.Connection then
		Settings.Connection:Disconnect()
		Settings.Connection = nil
	end

	-- // Making sure it doesn't destroy hitbox when unwanted
	if Settings.DestroyHitbox then
		if Settings.Parent and typeof(Settings.Parent) == "Instance" then
			Settings.Parent:Destroy()
		end
		
		if (typeof(Settings.Object) == "Instance") then
			Settings.Object:Destroy()
		end
	end
	
	-- // Disposing contents of table
	task.delay(0.05, disposeInfo, Settings)
end

return Parts
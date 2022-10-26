local Settings = {}

-- // Services
local RunService = game:GetService("RunService")

-- // Variables
Settings.Settings = {
	-- // DEPRECATED STUFF \\ --
	-- // Knockback info
	["Knockback"]           = true,                -- Knockback, 
	["KnockbackType"]       = "From_Character",    -- Refer to Jeffery's StunModule // Module:Knockback
	["KnockbackDuration"]   = 0.5,                 -- Default Knockback duration
	["KnockbackPower"]      = 0,                   -- The power of knockback in any given direction if any
	["VelocityType"]        = "Heavy",             -- The name of the velocity (Refer to Jeffery's StunModule for more information)
	["ImpactOffSet"]        = CFrame.new(0, 0, 0), -- CFrame value will get the offset of the impact position

	-- // Freeze info
	["CanFreeze"]           = false,               -- Freezes the player instead of knockback
	["FreezeDuration"]      = 1,                   -- Duration of freeze if enabled, 
	["FreezeType"]          = "Freeze",            -- This should be a string, refer to Jeffy's StunModule [Module:Freeze]
	["FreezeImmunity"]      = nil,                 -- Duration in seconds till a user is able to be frozen again
	
	["Overwrite"]           = false,               -- Decides whether the attack's knockback should be prioritized
	-- \\ DEPRECATED STUFF // --
	
	-- // Required Variables
	["Player"]              = nil      ::{"[REQUIRED] The user who is using the attack"},
	["AttackId"]            = nil      ::{"[REQUIRED] The attack origin"},
	["HitboxType"]          = "inpart" ::{"[REQUIRED] The hitbox type it will be using: sphere, inpart, box, touched"},
	
	-- // Other important variables
	["MoveDuration"]        = 1        ::{"[OPTIONAL] The duration of the hitbox if it's turned on"},
	["Rate"]                = 30       ::{"[OPTIONAL] The rate per second the hitbox runs"},
	["Parent"]              = nil      ::{"[OPTIONAL] THIS IS FOR HITBOXES THAT ARE PARENTED TO AN OBJECT/MODEL, PLEASE VERIFY IF SO (HITBOX.PARENT = 'NOT WORKSPACE')"},
	
	-- // Applying effects after a user is hit
	["ApplyEffect"]         = nil      ::{"[OPTIONAL] This must be a function | recommended to use connection received from hitbox"},
	["HitSound"]            = nil      ::{"[OPTIONAL] Creates a sound and places it in the hit part's primary part and plays it"},
	
	-- // Damage Over Time
	["PerformOverTime"]     = false    ::{"[OPTIONAL] Does Damage Over Time if the move has this enabled, Different from linger damage"},
	["OverTimeDuration"]    = nil      ::{"[OPTIONAL] Duration of overtime is based on Move Duration, unless set specifically"},
	["OverTimeRateOfHit"]   = .5       ::{"[OPTIONAL] The rate at which the overtime damage is dealt at"},
	["OverTimeMaxHits"]     = nil      ::{"[OPTIONAL] Maximum amount of hits a overtime event can hit, Default math.Huge"},
	
	-- // Linger damage
	["PerformLinger"]       = false    ::{"[OPTIONAL/LEGACY] Performs extra damage over time (Ends with duration provided or move end)"},
	["LingerDamage"]        = .2       ::{"[OPTIONAL/LEGACY] Percentage of normal damage for lingering damage"},
	["LingerDuration"]      = 1        ::{"[OPTIONAL/LEGACY] Duration of lingering damage"},
	["LingerMaxHits"]       = nil      ::{"[OPTIONAL/LEGACY] Max amount of times the linger will hit a player"},
	["LingerRateOfHit"]     = .2       ::{"[OPTIONAL/LEGACY] Speed at which linger deals damage"},
	
	-- // Bools
	["UseMoveDuration"]     = true     ::{"[OPTIONAL] Moves have a given duration of time before they'll be destroyed]"},
	["DestroyHitbox"]       = true     ::{"[OPTIONAL] Will destroy the hitbox; having this toggled off will make it only destroyable using Hitbox:Remove(Hitbox, {Destroy = true})"},
	["GetFullBody"]         = true     ::{"[OPTIONAL] Gets all BaseParts within the users model"},
	["HitOneTarget"]        = nil      ::{"[OPTIONAL] Allows the attack to only hit one player, preferred use is for 'ReturnTable'"},
	
	-- // Raycasting
	["PassThroughObjects"]  = true     ::{"[OPTIONAL] Raycast only | Whether the raycasting will finish after hitting a wall or non humanoid object"},
	
	-- // Tables
	["PlayersHit"]          = {}       ::{"[DEPRECATED] A list of players that have been hit"},
	["Whitelist"]           = {}       ::{"[IGNORE] A list of whitelisted objects, if whitelist is being used"},
	["Blacklist"]           = {}       ::{"[IGNORE] Blacklist which ignores object & holds players hit"},
	["OverTimePlayersHit"]  = {}       ::{"[IGNORE] Using this list for a specific overtime type | Don't set it equal to anything"},
	["Threads"]             = {}       ::{"[IGNORE] Table of threads used for specific processes"},
	["Attachments"]         = {}       ::{"[IGNORE] Table full of attachments meant for raycasting hitbox"},
	["HitInfo"]             = {}       ::{"[OPTIONAL] Information that is passed through on hit, passes through raycast result object"},
	
	-- // Other Ignored
	["_HasHit"]             = nil      ::{"[IGNORE] This signifies if the attack has hit something or if by any reason, the attack is being destroyed"},
	["_NotRemoved"]         = true     ::{"[IGNORE] Value which is meant to tell if the hitbox is currently being removed"},
	["Connection"]          = nil      ::{"[IGNORE] Meant for disconnecting the event given by the metatable"},
	["DebuggingMode"]       = false    ::{"[IGNORE] Toggles debug mode, can use for specific debugging"},
}

-- // Gets a DeepCopy of a table
function Settings:CopyTable(oldVal)
	local isTable  = type(oldVal) == "table"
	local newTable = isTable and {} or oldVal

	if isTable then
		for TableIndex, Value in pairs(oldVal) do
			newTable[TableIndex] = self:CopyTable(Value)
		end
	end

	return newTable
end

-- // Getting the settings
function Settings:GetSettings()
	local newSettings = RunService:IsRunning() and self:CopyTable(Settings.Settings) or Settings.Settings
	return newSettings
end

function Settings.new(newSettings) 
	local newTable = Settings:GetSettings()
	
	if newSettings and type(newSettings) == "table" then
		-- // Sets the sent table to newTable so it can update the options
		
		for Index, Value in pairs(newSettings) do
			newTable[Index] = Value
		end
	end
	
	if not newSettings.HitboxType then warn("Unknown hitbox type, please provide info: Table.HitboxType = Hitbox") end
	
	newTable.Rate      = 1/newTable.Rate
	newTable.Knockback = newTable.Knockback and not newTable.CanFreeze
	
	-- // Other backwards compatibility
	if type(newTable.AttackId) == "table" then
		for index, value in pairs(newTable.AttackId) do
			newTable.HitInfo[index] = value
		end
	end
	
	-- // Turning hit players into blacklist
	if #newTable.PlayersHit > 0 then
		for _, val in pairs(newTable.PlayersHit) do
			table.insert(newTable.Blacklist, val)
		end
		table.clear(newTable.PlayersHit)
		newTable.PlayersHit = nil
	end
	
	return newTable
end

return Settings

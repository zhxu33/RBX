-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "When hit 15 times, the player will become invulnerable for 3 seconds. (5 second cooldown)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings         = {}
Perk.Settings.HitTick = 0
Perk.Settings.MaxHitTicks         = 15    -- // Amount of ticks it takes to activate ability
Perk.Settings.NotInvulnerable     = true  -- // Whether said player is invulnerable
Perk.Settings.OnCooldown          = false -- // Shows whether the cooldown is active
Perk.Settings.InvulnerabilityCD   = 5     -- // Time it takes till the counter resumes
Perk.Settings.InvulnerabilityTime = 3     -- // Seconds

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns
Perk.DamageFunctions  = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions = {} -- // Plays when a player dies
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions   = {} -- // Plays when the player is being hit

-- // Functions
-- // Initiates the perks functionality

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

-- // controls the invulnerability of the user
local function invulnerabilityInit(self, Profile, Damage, ...)
	if not (self.Settings.NotInvulnerable) then return end
	
	local Settings = self.Settings
	Settings.NotInvulnerable = false -- // Now invulnerable
	Profile:ShowMessage(self, "%s Activated.")
	Profile:SetCooldown(self.Name, Settings.InvulnerabilityTime, nil, true)
	
	task.delay(Settings.InvulnerabilityTime, function()
		Settings.NotInvulnerable = true
		Profile:ShowMessage(self, "%s Deactivated.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
		Profile:SetCooldown(self.Name, Settings.InvulnerabilityCD) -- // Setting the cooldown for the perk
		task.delay(Settings.InvulnerabilityCD, function()
			Settings.OnCooldown = false
		end)
	end)
end

-- // returns new damage from invulnerability
local function invulnerabilityHandler(self, Profile, Damage, ...)
	return 0
end

-- // counts the players 
local function countHits(self, Profile, Damage, ...)
	-- // Currently invulnerable, don't continue and return new damage
	if not (self.Settings.NotInvulnerable) then return invulnerabilityHandler(self, Profile, Damage, ...) end
	if (self.Settings.OnCooldown) then return end
	
	self.Settings.HitTick += 1
	Profile:SetCounter(self.Name, self.Settings.HitTick, self.Settings.MaxHitTicks) -- // Shows the client how many ticks they have counted
	
	if self.Settings.MaxHitTicks <= self.Settings.HitTick then
		self.Settings.OnCooldown = true
		self.Settings.HitTick    = 0
		invulnerabilityInit(self, Profile, Damage, ...)
		Damage = invulnerabilityHandler(self, Profile, Damage, ...)
	end
	
	return Damage
end

Perk.OnHitFunctions.countHits = countHits

return Perk
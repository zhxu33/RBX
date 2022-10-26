-- // Services
local PlayerService = game:GetService("Players")

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
When an ally is crucially damaged within 150 studs, grants them a 150% regen buff with 120% better defense buff till they reach 50% health. 
(User must be below 20% health, only 4 users can be buffed at a time (can buff the same person 4 times only if 4 different people have the perk).)
15 second cooldown per buff.
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings              = {}
Perk.Settings.Distance     = 150 -- // Distance from user who has the perk
Perk.Settings.Requirement  = .2  -- // Health required to activate
Perk.Settings.Regen_Buff   = 1.5 -- // 150%
Perk.Settings.Defense_Buff = 1.2 -- // 120%
Perk.Settings.Uses         = 4   -- // only one person can be buffed at a time
Perk.Settings.Duration     = .5  -- // 50% health
Perk.Settings.Cooldown     = 15  -- // Seconds
Perk.Settings._Connections = {}

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns
Perk.DamageFunctions  = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions = {} -- // Plays when a player dies
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions   = {} -- // Plays when the player is being hit

-- // custom type
type PerkProfile = {
	Perks            : {perkName : {"Perk info."}} | "Contains all the perks the player currently has, uses it's own naming system.",
	RespawnFunctions : {func : (any) -> any} | "Contains functions that occur during the players respawn.",
	DamageFunction   : {func : (any) -> any} | "Contains functions that occur when the player is dealing damage.",
	OnKillFunctions  : {func : (any) -> any} | "Contains functions that occur when the player has defeated an npc (Player if profile is owned by an npc).",
	OnDeathFunctions : {func : (any) -> any} | "Contains functions that occur when the player has died.",
	OnHitFunctions   : {func : (any) -> any} | "Contains functions that occur when the player has been hit (By either npc or player).",
	BlacklistedPerks : {string | "Perk names here in which the player cannot obtain."},
	Player           : Player | Model | "This contains the players game.Player instance, if owned by an NPC it's the npc's character.",
	Character        : Model  | nil   | "Assume it's nil contains the character.",
	PerkLimit        : number | "The players current limit in obtainable perks.",
	PerksHeld        : number | "The amount of perks the player currently has.",
	PerksPerPoll     : number | "The amount of perks that are shown to the player during a perk poll / intermission.",
	DeepCopy         : (self : {"The table that's being used."}, any) -> any,
	DisposeInfo      : (self : {"The table that's being used."}, any) -> nil,
	SetCounter       : (self : {"The table that's being used."}, Perk : string, Count : number) -> nil,
	SetCooldown      : (self : {"The table that's being used."}, Perk : string, Cooldown : number) -> nil,
	HasPerk          : (self : {"The table that's being used."}, Perk : string | {Name : string}) -> {any} | nil,
}

-- // Functions

-- // Compares the distances between two models
local function compareDistances(c1, c2) : boolean
	local newMagnitude = (c1:GetPivot().Position - c2:GetPivot().Position).Magnitude
	return (newMagnitude < Perk.Settings.Distance) -- // If the new magnitude is less than max distance required (Returns true)
end

-- // Buffs the character
local function buffChar(char, Profile)
	Perk.Settings.Uses -= 1 -- // This person is now taking up a use slot
	Profile:ShowMessage(Perk.Name, ("%s Activated for: " .. char.Name))

	char:SetAttribute("HealthRegen_Multiplier", char:GetAttribute("HealthRegen_Multiplier") * Perk.Settings.Regen_Buff)
	char:SetAttribute("Defense", char:GetAttribute("Defense") * Perk.Settings.Defense_Buff)

	-- // Sloppy :: Adds a new health connection till the player reaches 50% health
	local connection = nil
	connection = char.Humanoid.HealthChanged:Connect(function()
		local currentHealth = (char.Humanoid.Health / char.Humanoid.MaxHealth)
		if (currentHealth <= 0) then -- // You Died
			connection:Disconnect()
			Perk.Settings.Uses += 1
			return 
		end

		if (currentHealth < Perk.Settings.Duration) then return end
		connection:Disconnect()

		Profile:ShowMessage(Perk, "%s Deactivated for: " .. char.Name, ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))

		char:SetAttribute("HealthRegen_Multiplier", char:GetAttribute("HealthRegen_Multiplier") / Perk.Settings.Regen_Buff)
		char:SetAttribute("Defense", char:GetAttribute("Defense") / Perk.Settings.Defense_Buff)
		Perk.Settings.Uses += 1
	end)
end

-- // Adds a player to the list of users who are receiving a buff
local function addCharacter(self, Profile, char)
	local indexID    = char.Name
	local connection = nil
	local activatedDebounce = false

	-- // Checks if the humanoid's health matches the requirements for a buff
	connection = char.Humanoid.HealthChanged:Connect(function()
		local currentHealth = (char.Humanoid.Health / char.Humanoid.MaxHealth)

		if activatedDebounce then return end
		activatedDebounce = true
		if not (currentHealth <= self.Settings.Requirement) then
			task.wait(.5)
			activatedDebounce = false
			return 
		end

		if (Perk.Settings.Uses <= 0) then return end -- // Meaning all perk is buffing 4 people
		if not compareDistances(Profile.Character, char) then return end

		buffChar(char, Profile)
		task.wait(self.Settings.Cooldown)
		activatedDebounce = false
	end)

	-- // Adds it to the connection dictionary so that it can be disconnected on dispose
	self.Settings._Connections[indexID] = connection

	-- // By definition so I can disconnect when humanoid dies
	-- // removing the index if the ancestor was destroyed
	char.AncestryChanged:Connect(function(_, newParent)
		if (newParent) then return end 
		connection:Disconnect()
		self.Settings._Connections[indexID] = nil
	end)
end

-- // Adds a connection to players
local function addConnection(self, Profile, player)
	table.insert(self.Settings._Connections, player.CharacterAdded:Connect(function(char)
		addCharacter(self, Profile, char)
	end))

	addCharacter(self, Profile, player.Character)
end

-- // Initiates the perks functionality 
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	local players = PlayerService:GetPlayers()

	for _, player in ipairs(players) do
		if Profile.Player == player then continue end
		addConnection(self, Profile, player)
	end

end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

return Perk
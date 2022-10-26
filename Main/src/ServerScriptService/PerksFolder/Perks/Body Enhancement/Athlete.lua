-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Increases all physical attributes by 3% and increases damage by 3%."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings            = {}
Perk.Settings.Defense    = 1.03 -- // 3% increase
Perk.Settings.MaxHealth  = 1.03 -- // 3% increase
Perk.Settings.Damage     = 1.03 -- // 3% increase
Perk.Settings.WalkSpeed  = 1.03 -- // 3% increase
Perk.Settings.JumpPower  = 1.03 -- // 3% increase
Perk.Settings.MaxStamina = 1.03 -- // 3% increase

Perk.Settings.PerkSlot      = 1 -- // 1 extra slot
Perk.Settings.PerkSelection = 1 -- // 1 less to choose from

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
-- // Initiates the perks functionality
local function perkAbility(self, Profile : PerkProfile, Player, ...)
	local Character = Profile.Character
	local Settings  = self.Settings
	if not Character then return end

	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.MaxHealth *= Settings.MaxHealth
	Humanoid.WalkSpeed *= Settings.WalkSpeed
	Humanoid.JumpPower *= Settings.JumpPower

	local Attributes = Character:GetAttributes()
	Character:SetAttribute("Defense",     (Attributes.Defense * Settings.Defense))
	Character:SetAttribute("MaxStamina",  (Attributes.MaxStamina * Settings.MaxStamina))
	Character:SetAttribute("DamageBoost", (Attributes.DamageBoost * Settings.Damage))
end

function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	local Character = Profile.Character
	local Settings  = self.Settings
	
	Profile.PerksHeld    -= Settings.PerkSlot -- // May switch to decreasing total perks
	Profile.PerksPerPoll -= Settings.PerkSelection
	
	perkAbility(Profile, Player, ...)
end

-- // Deactivates initial functions
function Perk:Deactivate(Profile : PerkProfile, Player, ...)
	local Character = Profile.Character
	local Settings  = self.Settings
	if not Character then return end

	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.MaxHealth /= Settings.MaxHealth
	Humanoid.WalkSpeed /= Settings.WalkSpeed
	Humanoid.JumpPower /= Settings.JumpPower

	local Attributes = Character:GetAttributes()
	Character:SetAttribute("Defense", (Attributes.Defense / Settings.Defense))
	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina / Settings.MaxStamina))
	Character:SetAttribute("DamageBoost", (Attributes.DamageBoost / Settings.Damage))
	
	Profile.PerksHeld    += Settings.PerkSlot -- // May switch to decreasing total perks
	Profile.PerksPerPoll += Settings.PerkSelection
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------
Perk.RespawnFunctions.StartUp = perkAbility

return Perk
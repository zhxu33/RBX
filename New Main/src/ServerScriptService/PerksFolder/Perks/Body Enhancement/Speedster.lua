-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "The user gains 10% more stamina, 5% more jump height, and 15% more movement speed... at the cost of 15% reduced max health and 10% less defense."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.MaxStamina = 1.10 -- // 10% more
Perk.Settings.JumpPower  = 1.05 -- // 5%  more
Perk.Settings.MaxHealth  = 1.15 -- // 15% less
Perk.Settings.Defense    = 1.10 -- // 10% less
Perk.Settings.WalkSpeed  = 1.15 -- // 15% more

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
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	local Character = Profile.Character
	local Settings  = self.Settings
	if not Character then return end

	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.MaxHealth /= Settings.MaxHealth
	Humanoid.WalkSpeed *= Settings.WalkSpeed
	
	local Attributes = Character:GetAttributes()
	Character:SetAttribute("Defense", (Attributes.Defense / Settings.Defense))
	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina * Settings.MaxStamina))
end

-- // Deactivates initial functions
function Perk:Deactivate(Profile : PerkProfile, Player, ...)
	local Character = Profile.Character
	local Settings  = self.Settings
	if not Character then return end

	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.MaxHealth *= Settings.MaxHealth
	Humanoid.WalkSpeed /= Settings.WalkSpeed

	local Attributes = Character:GetAttributes()
	Character:SetAttribute("Defense", (Attributes.Defense * Settings.Defense))
	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina / Settings.MaxStamina))
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------
Perk.RespawnFunctions.perkInitialization = Perk.PerkInitiation

return Perk
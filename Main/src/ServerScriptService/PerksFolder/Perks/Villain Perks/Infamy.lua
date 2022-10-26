-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
- Does not take up an existing perk slot. Gain negative fame no matter what kind of enemies you kill. 
- The amount of infamy acquired will randomly double with a 50/50 chance upon gaining it.
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.DoubleInfamy = .5 -- // 50% chance to double it

-- // Function Dictionaries
Perk.OnRewardFunctions = {} -- // Plays when a player respawns

local newRandom = Random.new(math.randomseed(tick() + math.random(1, 238572)))

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

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

-- // EXAMPLES | Hopefully this helps | self is the deep copied version of the perk profile

function Perk.OnRewardFunctions:Change_Fame_Reward(Profile : PerkProfile, Extra)
	Extra.FameMultiplier = ((Extra.FameMultiplier or 1) * (Extra.Reward[2] > 0 and -1 or 1)) + ((newRandom:NextNumber(0, 1) < self.Settings.DoubleInfamy and 2) or 0)
	
	return Extra
end


return Perk
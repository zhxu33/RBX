-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Rare Quirk users can carry 2 more perks. (This perk will not take up a slot)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}

Perk.Settings.Perk_Up_Compensation		= 1
Perk.Settings.Perk_Up_Amount			= 2
Perk.Settings.Whitelisted_Quirks		= {28, 19, 20, 26, 32, 36, 21, 35, 3}

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

function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	
	Profile.PerkLimit += Perk.Settings.Perk_Up_Compensation
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return
	end
	
	Profile.PerkLimit += Perk.Settings.Perk_Up_Amount
	
end

return Perk
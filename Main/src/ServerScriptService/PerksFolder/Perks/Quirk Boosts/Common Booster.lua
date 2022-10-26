-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Common/Uncommon quirk users gain a 10% damage boost and 10% more stamina capacity."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Connections	= {}

Perk.Settings.Common_Booster_Damage = 1.1
Perk.Settings.Common_Booster_Stamina = 1.1
Perk.Settings.Whitelisted_Quirks = {27, 11, 37, 18, 29, 7, 0, 9, 14, 15, 17, 25, 22, 23, 12, 24, 31, 10, 8, 4}

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

function Perk:PerkInitiation(Profile : PerkProfile, Player)
	
	Profile:DisposeInfo(Perk.Connections)
	
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return
	end
	
	Profile.Character:SetAttribute("DamageBoost", Profile.Character:GetAttribute("DamageBoost")*Perk.Settings.Common_Booster_Damage)
	Profile.Character:SetAttribute("MaxStamina", Profile.Character:GetAttribute("MaxStamina")*Perk.Settings.Common_Booster_Stamina)
	
	Perk.Connections = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Profile.Player.Name).Agility:GetPropertyChangedSignal("Value"):Connect(function()
		game["Run Service"].Heartbeat:Wait()
		Profile.Character:SetAttribute("MaxStamina", Profile.Character:GetAttribute("MaxStamina")*Perk.Settings.Common_Booster_Stamina)
	end)
	
end

Perk.RespawnFunctions.RespawnBooster = Perk.PerkInitiation

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

return Perk
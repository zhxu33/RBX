-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
Gives the user the ability to track all NPCs within 800 studs.
NPCs within 200 studs deal 10% less damage to the perk user.
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings          = {}
Perk.Settings.Defense  = .90 -- // 10%?
Perk.Settings.Distance = 200

-- // Function Dictionaries
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
	if not (Profile.Player:IsA("Player")) then return end
	self.PerkScript = script.Indimidation:Clone()
	self.PerkScript.Parent = Profile.Player.Backpack
end

-- // Deactivates initial functions
function Perk:Deactivate(Profile : PerkProfile, Player, ...)
	if self.PerkScript then self.PerkScript:Destroy() end
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

function Perk.OnHitFunctions:CheckDistance(Profile : PerkProfile, Damage, EnemyChar)
	local Character = Profile.Character
	if not (Character and EnemyChar and Character.Parent and Character.PrimaryPart and EnemyChar.Parent and EnemyChar.PrimaryPart) then
		return Damage
	end
	
	local Position     = Character:GetPivot().Position
	local SelfPosition = EnemyChar:GetPivot().Position

	return ((Position - SelfPosition).Magnitude < self.Settings.Distance and Damage * self.Settings.Defense) or Damage
end

return Perk
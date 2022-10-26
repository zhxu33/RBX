-- // Services
local PlayerService     = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

-- // Variables
local NPCs = workspace:FindFirstChild("NPCs")

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
For each user that holds this perk out of all users in the raid bosses spawn with less max health. (Perk Holders / Total Players) * 25%
You deal extra damage to bosses. (10% more damage to bosses)
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.MaxHealthDrain = .25  -- // 25% less health
Perk.Settings.Owned          = 0    -- // The amount of players that own the perk
Perk.Settings.ExtraDamage    = 1.10 -- // 10% more damage

local activated = false

-- // Function Dictionaries
Perk.DamageFunctions  = {} -- // Plays when a player hits someone

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

-- // Get new health drain
local function GetHealthDrain()
	local totalPlayers = #PlayerService:GetPlayers()

	return (Perk.Settings.Owned / totalPlayers) * Perk.Settings.MaxHealthDrain
end

-- // Detects when a boss spawns to remove health
local function BossDetectionInit()
	if activated then return end
	activated = true 

	NPCs.ChildAdded:Connect(function(child)
		local hum = child:WaitForChild("Humanoid")
		if not hum then return end

		hum.MaxHealth = (hum.MaxHealth - (hum.MaxHealth * GetHealthDrain()))
		hum.Health    = hum.MaxHealth
	end)
end

-- // Initiates the perks functionality 
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file

	Perk.Settings.Owned += 1
	BossDetectionInit()
end

function Perk:Deactivate( ... )
	Perk.Settings.Owned -= 1
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

-- // Example on syntax call method (Uses '.' instead of ':')
function Perk.DamageFunctions.Detect_Boss(self, Profile : PerkProfile, Damage, Player, HitCharacter, ...)
	if not (HitCharacter and CollectionService:HasTag(HitCharacter, "Boss")) then return end

	return (self.Settings.ExtraDamage * Damage)
end

return Perk
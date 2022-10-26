-- // Services
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService       = game:GetService("Players")
local Replicated          = game:GetService("ReplicatedStorage")

-- // Variables
local RaidInfo           = Replicated:FindFirstChild("RaidInfo")
local PerkUpdate         = RaidInfo and RaidInfo.PerkUpdate
local SurvivalMainScript = ServerScriptService:FindFirstChild("SurvivalMainScript")
local RaidSettings       = (SurvivalMainScript and require(SurvivalMainScript.RaidSettings))
local playerdata = workspace.S1c2R5i66p5t5s51.PlayerData
local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "When the user falls, grants a morale boost to all present heroes for 180 seconds (25% boost to max health, defense and damage) with a cooldown of 2 waves."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings           = {}
Perk.Settings.Cooldown  = 2    -- // Waves
Perk.Settings.MaxHealth = 1.25 -- // 25%
Perk.Settings.Defense   = 1.25 -- // 25% 
Perk.Settings.Damage    = 1.25 -- // 25%
Perk.Settings.Duration  = 180  -- // Seconds
local globalDebounce    = false
local prevRaidActivated = -2

-- // Function Dictionaries
Perk.OnDeathFunctions = {} -- // Plays when a player dies

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
-- // Grabs the players information 
local function GetPlayerInfo(Player)
	return (playerdata:FindFirstChild(Player.Name))
end

-- // Checks if the player is a hero
local function isPlayerAHero(Stats)
	return (Stats.Fame.Value > 0)
end

-- // Check raid wave
local function CheckWave()
	if RaidSettings.Wave >= (prevRaidActivated + Perk.Settings.Cooldown) then
		globalDebounce = false
	else
		globalDebounce = true
	end
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

-- // Gives boost to all heroes
function Perk.OnDeathFunctions:Morale_Boost(Profile)
	CheckWave()
	if globalDebounce then 
		Profile:SetCooldown(self.Name, ((prevRaidActivated + Perk.Settings.Cooldown) - RaidSettings.Wave), 0)
		return 
	end
	
	prevRaidActivated = RaidSettings.Wave
	
	for _, player in ipairs(PlayerService:GetPlayers()) do
		task.spawn(function()
			local info = GetPlayerInfo(player)
			if not (info and isPlayerAHero(info)) then return end
			
			if PerkUpdate then
				PerkUpdate:FireClient(player, {Message = "Heroes Morale Activated."})
			end
			
			local character = player.Character
			if not (character and character.Parent) then return end
			local humanoid = character.Humanoid
			
			local attributes = character:GetAttributes()
			character:SetAttribute("DamageBoost", self.Settings.Damage * attributes.DamageBoost)
			character:SetAttribute("Defense", self.Settings.Defense * attributes.Defense)
			humanoid.MaxHealth *= self.Settings.MaxHealth
			
			task.delay(self.Settings.Duration, function()
				character:SetAttribute("DamageBoost", self.Settings.Damage / attributes.DamageBoost)
				character:SetAttribute("Defense", self.Settings.Defense / attributes.Defense)
				humanoid.MaxHealth /= self.Settings.MaxHealth
			end)
		end)
	end
end

return Perk
-- // Services
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService       = game:GetService("Players")
local Replicated          = game:GetService("ReplicatedStorage")

-- // Variables
local SurvivalMainScript = ServerScriptService:FindFirstChild("SurvivalMainScript")
local RaidSettings       = (SurvivalMainScript and require(SurvivalMainScript.RaidSettings))

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
If the perk user dies last during the wave, the wave restarts and everyone is respawned. 
Perk owner gains a 20% buff to health regen, defense and damage for 60 seconds after respawning. 
(5 wave cooldown)
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings          = {}
Perk.Settings.Cooldown = 5
Perk.Settings.Health_Buff  = 1.2 -- // 120%
Perk.Settings.Damage_Buff  = 1.2 -- // 120%
Perk.Settings.Defense_Buff = 1.2 -- // 120%
Perk.Settings.Respawn_Buff_Duration = 60 -- // Seconds
Perk._Connection = nil -- // The connection for the perk user's humanoid

local globalDebounce    = false
local prevRaidActivated = -5

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns

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

-- // Check raid wave
local function CheckWave()
	if RaidSettings.Wave >= (prevRaidActivated + Perk.Settings.Cooldown) then
		globalDebounce = false
	else
		globalDebounce = true
	end
end

-- // Checks if the player can restart the next wave
local function CanRestart(Profile)
	CheckWave()
	if globalDebounce then 
		Profile:SetCounter(Perk.Name, ((prevRaidActivated + Perk.Settings.Cooldown) - RaidSettings.Wave))
		return 
	end
	
	prevRaidActivated = RaidSettings.Wave

	Profile._RestartWave = true
	Profile:ShowMessage(Perk, "%s Activated, restarting wave.")
end

-- // Functions
-- // Initiates the perks functionality 
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	Profile:DisposeInfo(self._Connection)
	local Character = Profile.Character
	if not Character then return end

	self._Connection = Character.Humanoid.Died:Connect(function()
		local diedLast = true
		-- // Checking if the player is the last to die
		for _, player in ipairs(PlayerService:GetPlayers()) do
			-- // Checking the health
			if (player == Profile.Player) then continue end
			local char = player.Character
			if not (char and char.Parent) then continue end
			if char.Humanoid.Health > 0 then 
				diedLast = false
				break
			end
		end

		-- // If they died last, then check if they can restart the wave
		if diedLast then CanRestart(Profile) end
	end) 
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

function Perk.RespawnFunctions:Respawn_Buffs(Profile, Player)
	local Character = Profile.Character

	Profile:ShowMessage(self, "%s Respawn Buffs Activated.")
	Profile:SetCooldown(self.Name, self.Settings.Respawn_Buff_Duration, nil, true)
	
	Character:SetAttribute("DamageBoost",            Character:GetAttribute("DamageBoost") * self.Settings.Damage_Buff)
	Character:SetAttribute("HealthRegen_Multiplier", Character:GetAttribute("HealthRegen_Multiplier") * self.Settings.Health_Buff)
	Character:SetAttribute("Defense",                Character:GetAttribute("Defense") * self.Settings.Defense_Buff)
	
	task.delay(self.Settings.Respawn_Buff_Duration, function()
		-- // Checking if the character still exists
		if not (Character.Parent) then return end

		Profile:ShowMessage(self, "%s Respawn Buffs Deactivated.")

		Character:SetAttribute("DamageBoost",            Character:GetAttribute("DamageBoost") / self.Settings.Damage_Buff)
		Character:SetAttribute("HealthRegen_Multiplier", Character:GetAttribute("HealthRegen_Multiplier") / self.Settings.Health_Buff)
		Character:SetAttribute("Defense",                Character:GetAttribute("Defense") / self.Settings.Defense_Buff)
	end)
end           

Perk.RespawnFunctions.Initialize_Respawn = Perk.PerkInitiation

return Perk
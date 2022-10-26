-- // Services
local PlayerService = game:GetService("Players")

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
Once the perk owner defeats an NPC all current NPCs on the field lose 1% of their max MaxHealth (1 Second Cooldown between KOs)
All allies gain 1% more max health for 35 seconds (Stacks)
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.RemoveHealth   = .01  -- // 1%
Perk.Settings.PreviousUse    = 0
Perk.Settings.IncreaseHealth = 1.01 -- // 101%
Perk.Settings.Buff_Duration  = 35   -- // Seconds
Perk.Settings.Debounce_Time  = 1    -- // Seconds

-- // Function Dictionaries
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc

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

-- // Performs health decrease on npc
local function DecreaseHealth(self, profile, npc)
	if not (npc.Parent or npc:FindFirstChild("Humanoid")) then return end
	local Humanoid = npc.Humanoid

	local currentHealth = Humanoid.Health
	Humanoid.MaxHealth -= (Humanoid.MaxHealth * self.Settings.RemoveHealth)

	if currentHealth > Humanoid.MaxHealth then
		Humanoid.Health = Humanoid.MaxHealth
	end
end

-- // Performs the buff on the player
local function BuffPlayer(self, profile, player)
	local character = player.Character
	if not (character and character.Parent and character:FindFirstChild("Humanoid")) then return end
	local Humanoid = character.Humanoid
	
	Humanoid.MaxHealth *= self.Settings.IncreaseHealth

	task.delay(self.Settings.Buff_Duration, function()
		Humanoid.MaxHealth /= self.Settings.IncreaseHealth
	end)
end

-- // Gives players buff + removes health from npcs
function Perk.OnKillFunctions:Defeat_Function(Profile)
	if (self.Settings.PreviousUse > os.clock()) then return end
	self.Settings.PreviousUse = (os.clock() + self.Settings.Debounce_Time)

	Profile:ShowMessage(self, "%s Activated.")

	for _, player in ipairs(PlayerService:GetPlayers()) do
		BuffPlayer(self, Profile, player)
	end

	for _, npc in pairs(workspace.NPCs:GetChildren()) do
		DecreaseHealth(self, Profile, npc)
	end
end

return Perk
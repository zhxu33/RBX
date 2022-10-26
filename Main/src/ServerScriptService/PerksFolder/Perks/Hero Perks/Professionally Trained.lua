-- // Services
local ServerScriptService = game:GetService("ServerScriptService")

-- // Variables
local FormName       = "Professionally_Trained"
local CombatServices = ServerScriptService.CombatScripts
local Settings       = require(CombatServices.Settings)

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "When defeating an NPC, the user is granted 3 seconds of faster health regen (2.5x faster), you can chain this to keep the ability activated. (10 second cooldown)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings          = {}
Perk.Settings.Duration = 3
Perk.Settings.HealthRegenerationBoost = 2.5
Perk.Settings.Cooldown           = 10
Perk.Settings.isActivated        = false
Perk.Settings.onCooldown         = false
Settings.Forms.All[FormName] = {MoveType = "Form", HealthRegenerationBoost = Perk.Settings.HealthRegenerationBoost}

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
local function DurationHandler(self, Profile)
	if self.Settings.thread and coroutine.status(self.Settings.thread) == "suspended" then task.cancel(self.Settings.thread); end
	Profile:SetCooldown(self, self.Settings.Duration, nil, true)
	
	self.Settings.thread = task.delay(self.Settings.Duration, function()
		self.Settings.onCooldown  = true
		self.Settings.isActivated = false
		Profile.Character:SetAttribute(FormName, false)
		
		Profile:SetCooldown(self, self.Settings.Cooldown)
		Profile:ShowMessage(self, "%s Deactivated.", 
			ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), 
				ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), 
				ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))
			}))
		
		task.delay(self.Settings.Cooldown, function()
			self.Settings.onCooldown = false
			Profile:ShowMessage(self, "%s Ready.")
		end)
	end)
end

function Perk.OnKillFunctions:Professional_Endurance(Profile)
	if (self.Settings.isActivated) then DurationHandler(self, Profile); return end -- // Assume
	if (self.Settings.onCooldown) then return end
	self.Settings.isActivated = true
	
	Profile:ShowMessage(self, "%s Activated.")
	Profile.Character:SetAttribute(FormName, true)
	DurationHandler(self, Profile)
end

return Perk
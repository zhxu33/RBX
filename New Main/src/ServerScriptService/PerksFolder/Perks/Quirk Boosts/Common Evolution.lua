-- // Services

-- // Variables
local newRandom = Random.new(math.randomseed(tick()+ 325236))

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Refrains Common/Uncommon quirk moves from draining stamina. (2 seconds immunity for continuous-drain moves) (Cooldown: 2 seconds)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}

Perk.Settings.Anti_Drain_Chance = 100
Perk.Settings.Anti_Drain_Cooldown = 2
Perk.Settings.Anti_Drain_Last_Used = os.clock()

Perk.Settings.Whitelisted_Quirks = {27, 11, 37, 18, 29, 7, 0, 9, 14, 15, 17, 25, 22, 23, 12, 24, 31, 10, 8, 4}

Perk.Settings.Anti_Drain_Form_Duration = 2
Perk.Settings.Anti_Drain_Form_InUse = false

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

function Perk:Anti_Drain_Trigger(Profile, moveType)
	
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return false
	end
	
	if moveType == "Quirk_Move" then
		
		if self.Settings.Anti_Drain_Form_InUse then
			return false
		end
	
		if self.Settings.Anti_Drain_Last_Used + self.Settings.Anti_Drain_Cooldown <= os.clock() then
			if newRandom:NextInteger(1, 100) <= self.Settings.Anti_Drain_Chance then
				Profile:SetCooldown(self.Name, self.Settings.Anti_Drain_Cooldown)
				self.Settings.Anti_Drain_Last_Used = os.clock()
				
				Profile:ShowMessage(self, "%s Activated.")
				return true
			end
			return false
		end
		
	elseif moveType == "Quirk_Move2" then
		
		if self.Settings.Anti_Drain_Form_InUse then
			return true
		elseif self.Settings.Anti_Drain_Last_Used + self.Settings.Anti_Drain_Cooldown <= os.clock() then
			if newRandom:NextInteger(1, 100) <= self.Settings.Anti_Drain_Chance then
				self.Settings.Anti_Drain_Form_InUse = true
				task.delay(self.Settings.Anti_Drain_Form_Duration, function()
					self.Settings.Anti_Drain_Form_InUse = false
					self.Settings.Anti_Drain_Last_Used = os.clock()
					Profile:ShowMessage(self, "%s Deactivated.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
					Profile:SetCooldown(self.Name, self.Settings.Anti_Drain_Cooldown)
				end)
				
				Profile:ShowMessage(self, "%s Activated.")
				return true
			end
			return false
		end
		
	end
	
	return false
end

return Perk
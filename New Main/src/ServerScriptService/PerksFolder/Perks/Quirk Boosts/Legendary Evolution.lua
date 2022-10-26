-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Legendary/Mythical Quirk users gain +25% Damage/Defense below 50% health."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Connections	= {}

Perk.Settings.LE_Activated			= false
Perk.Settings.LE_Health_Activation 	= .5
Perk.Settings.LE_Damage_Increase 	= 1.25
Perk.Settings.LE_Defense_Increase 	= 1.25

Perk.Settings.Whitelisted_Quirks = {30, 13, 6, 33, 1, 2, 16, 34}

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

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

function Perk:PerkInitiation(Profile : PerkProfile, Player)
	Profile:DisposeInfo(Perk.Connections)
	
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return
	end
	
	Perk.Connections.LE_Activation = Profile.Character:WaitForChild("Humanoid").HealthChanged:Connect(function()
		
		if Profile.Character.Humanoid.Health < Profile.Character.Humanoid.MaxHealth * Perk.Settings.LE_Health_Activation then
			if Perk.Settings.LE_Activated then return end
			Perk.Settings.LE_Activated = true
			Profile:ShowMessage(self, "%s is active.")
			Profile.Character:SetAttribute("DamageBoost_Quirk", Profile.Character:GetAttribute("DamageBoost_Quirk")*Perk.Settings.LE_Damage_Increase)
			Profile.Character:SetAttribute("Defense", Profile.Character:GetAttribute("Defense")*Perk.Settings.LE_Defense_Increase)
		else
			if not Perk.Settings.LE_Activated then return end
			Perk.Settings.LE_Activated = false
			Profile:ShowMessage(self, "%s is inactive.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
			Profile.Character:SetAttribute("DamageBoost_Quirk", Profile.Character:GetAttribute("DamageBoost_Quirk")/Perk.Settings.LE_Damage_Increase)
			Profile.Character:SetAttribute("Defense", Profile.Character:GetAttribute("Defense")/Perk.Settings.LE_Defense_Increase)
		end
		
	end)
	
end

Perk.RespawnFunctions.LE_Respawn = Perk.PerkInitiation

return Perk
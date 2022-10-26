-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Charge up to 25% damage over the course of 15 seconds for your next quirk move while not attacking. (Legendary/Mythical Quirk Users Only)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       				= {}
Perk.Threads						= {}
Perk.Connections					= {}

Perk.Settings.Max_Damage			= .25
Perk.Settings.Increment_Time		= 15/100
Perk.Settings.Whitelisted_Quirks 	= {30, 13, 6, 33, 1, 2, 16, 34}

Perk.Settings.Recharge_Delay		= 0
Perk.Settings.Percentage			= 0

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

	Profile:DisposeInfo(Perk.Threads)
	Profile:DisposeInfo(Perk.Connections)
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return
	end
	
	local function BeginRecharge()
		if self.Settings.Percentage == 100 then
			return
		end
		if Profile.Character:GetAttribute("Attacking") and not Profile.Character:GetAttribute("Blocking") and not Profile.Character:GetAttribute("Dashing") and not Profile.Character:GetAttribute("UsingForm") and not Profile.Character:GetAttribute("Punching") then
			return
		end
		repeat
			self.Settings.Percentage += 1
			Profile:SetCounter(self.Name, math.round(self.Settings.Max_Damage * (self.Settings.Percentage)), 25)
			Profile.Character:SetAttribute("DamageBoost_Booster", 1+(self.Settings.Max_Damage*(self.Settings.Percentage/100)))
			task.wait(self.Settings.Increment_Time)
		until self.Settings.Percentage >= 100
	end
	
	self.Threads.BeginRecharge = task.spawn(BeginRecharge)
	self.Connections.StartRecharge = Profile.Character:GetAttributeChangedSignal("Attacking"):Connect(function()
		if Profile.Character:GetAttribute("Attacking") and not Profile.Character:GetAttribute("Blocking") and not Profile.Character:GetAttribute("Dashing") and not Profile.Character:GetAttribute("UsingForm") and not Profile.Character:GetAttribute("Punching") then
			if self.Threads.BeginRecharge then
				task.cancel(self.Threads.BeginRecharge)
			end
			self.Settings.Percentage = 0
	--		Profile:SetCounter("High Quality Quirk Booster", "+" .. tostring(math.round((self.Settings.Max_Damage*(self.Settings.Percentage)))) .. "%")
		elseif not Profile.Character:GetAttribute("Attacking") and coroutine.status(self.Threads.BeginRecharge) == "dead" then
			--if self.Threads.BeginRecharge then
			--	task.cancel(self.Threads.BeginRecharge)
			--end
			self.Threads.BeginRecharge = task.delay(self.Settings.Recharge_Delay, BeginRecharge)
		end
	end)
	
end

Perk.RespawnFunctions.ResetIncrement = Perk.PerkInitiation

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

return Perk
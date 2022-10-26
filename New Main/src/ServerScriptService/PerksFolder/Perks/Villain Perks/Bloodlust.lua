-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
- When dealing damage at all, gain a stack of *Bloodlust.* Receiving damage removes 1 stack. Stacks 200 times.

- When reaching 100 stacks of bloodlust, attacks ignore defense. 
- When Reaching 200 stacks of bloodlust, attacks heal for 5% of your Health every hit for 60 seconds and stacks stay the same. 

- After the time expires, all stacks of bloodlust slowly drain 1 by 1 every second and eventually both of the effects wear off. 
(You cannot gain stacks during this period. The moment the stacks wear off, you can begin accumulating stacks once again.)
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings        = {}
Perk.Settings.Stacks = 0 -- // Starting at 0 stacks
Perk.Settings.Stack_Gain_Rate = 1   -- // Per Hit
Perk.Settings.Stack_Loss_Rate = 1   -- // Per Hit
Perk.Settings.Health_Gain     = .05 -- // 5 % of max health | Second level buff
Perk.Settings.Buff_Duration   = 60  -- // Seconds | Second level buff duration
Perk.Settings.First_Level     = 100 -- // Stacks
Perk.Settings.Second_Level    = 200 -- // Stacks
Perk.Settings.Drain_Rate      = 1 -- // How many stacks drain per tick
Perk.Settings.Drain_Speed     = 1 -- // The amount of seconds it takes between ticks

Perk.Settings.OnCooldown = false -- // Activates on drain
Perk.Settings.IsActive   = false -- // Activates when second level is achieved

-- // Function Dictionaries
Perk.DamageFunctions = {} -- // Plays when a player hits someone
Perk.OnHitFunctions  = {} -- // Plays when the player is being hit

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
	self.Settings.Stacks = 0
	Profile:SetCounter(self.Name, self.Settings.Stacks, self.Settings.Second_Level)
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

-- // Calculates new damage based on level
local function calculateDamage(self, Damage, Char, EnemyChar) -- // Level is always going to be at least 1
	local Defense = EnemyChar:GetAttribute("Defense")      or 1 -- // Percent
	local Armor   = EnemyChar:GetAttribute("ArmorDefense") or 0 -- // Static

	-- // Reverse math
	Damage += Armor
	Damage *= Defense

	-- // Check if the player should be healed; Level 2

	if (self.Settings.IsActive) then -- // Is Active turns on when 200 stacks reached
		local Hum = Char:FindFirstChild("Humanoid")
		if Hum then
			Hum.Health += (Hum.MaxHealth * self.Settings.Health_Gain)
		end
	end

	return Damage
end

-- // Adds to current stacks | Also calculates new damage 
function Perk.DamageFunctions:Add_Stack(Profile : PerkProfile, Damage, Player, EnemyChar)
	-- // Needs to check what level the perk is at
	-- // If First level, calculate new damage and return new damage
	-- // If Second level, add health to player health + calculate new damage
	-- // Needs to then if the move is active | First check the stacks
	-- // Needs to then add a stack or activate new level

	if (self.Settings.Stacks > (self.Settings.First_Level)) and not (self.Settings.OnCooldown) then 
		-- // Before checking if the move is on debounce
		-- // Since it passed the first level, it can check for the second level in the function
		Damage = calculateDamage(self, Damage, Profile.Character, EnemyChar)
	end

	-- // if the move is activated or on cooldown, don't continue
	if (self.Settings.OnCooldown or self.Settings.IsActive) then return Damage end -- // Return damage incase

	self.Settings.Stacks += self.Settings.Stack_Gain_Rate
	Profile:SetCounter(self.Name, self.Settings.Stacks, self.Settings.Second_Level)

	if (self.Settings.Stacks > self.Settings.Second_Level) then
		self.Settings.IsActive = true
		Profile:SetCooldown(self.Name, self.Settings.Buff_Duration, nil, true)

		-- // Activation time -> cooldown time
		task.delay(self.Settings.Buff_Duration, function()
			self.Settings.OnCooldown = true
			self.Settings.IsActive   = false
			-- // Cooldown

			Profile:SetCooldown(self.Name, self.Settings.Second_Level / 2)
			task.wait(self.Settings.Second_Level)
			self.Settings.Stacks     = 0
			self.Settings.OnCooldown = false
		end)
	end

	return Damage
end

-- // Takes away from current stacks
function Perk.OnHitFunctions:Decrease_Stack(Profile : PerkProfile, Damage, Player, ...)
	-- // if the move is activated or on cooldown, don't continue
	if (self.Settings.OnCooldown or self.Settings.IsActive) then return Damage end -- // Return damage incase

	self.Settings.Stacks -= self.Settings.Stack_Loss_Rate
	if self.Settings.Stacks <= 0 then
		self.Settings.Stacks = 0
	end
	
	Profile:SetCounter(self.Name, self.Settings.Stacks, self.Settings.Second_Level)
end

return Perk
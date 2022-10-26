-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "User has a 25% chance of dodging each attack, however this consumes 15% of the user's stamina. (No cooldown)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.Dodge = .25 -- // 25% chance to dodge
Perk.Settings.StaminaConsumption = .15 -- // 30%

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns
Perk.DamageFunctions  = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions = {} -- // Plays when a player dies
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions   = {} -- // Plays when the player is being hit

local newRandom = Random.new(math.randomseed(tick()+ 325235))

-- // Functions

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

-- // goes through math to check if player dodged or not
local function didDodge()
	local outOf        = 1
	local probability  = outOf - Perk.Settings.Dodge -- // EX: (1 - .25) = 75% | random number = .823475; returns (0.75 < 0.823475) <- resulting in true
	local randomNumber = newRandom:NextNumber(0, 1)
	
	return (probability < randomNumber)
end

-- // Allowing the player to dodge based on a 25% chance
local function canDodge(self, Profile, Damage, ...)
	local Character = Profile.Character
	if not (Character and Character.Parent) then return end

	local Attributes = Character:GetAttributes()
	
	local Stamina     = Attributes.Stamina
	local MaxStamina  = Attributes.MaxStamina
	if not (Stamina and MaxStamina) then return end
	
	local Consumption = MaxStamina * self.Settings.StaminaConsumption
	
	if (Stamina < Consumption) then return end
	if not didDodge() then return end -- // didn't dodge
	Profile:ShowMessage(self, "%s Activated.")
	
	-- // Decreasing stamina consumption to dodge
	Character:SetAttribute("Stamina", (Attributes.Stamina - Consumption))
	return 0
end

Perk.OnHitFunctions.Dodge = canDodge

return Perk
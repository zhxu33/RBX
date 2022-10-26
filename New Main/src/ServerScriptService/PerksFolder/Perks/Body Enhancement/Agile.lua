-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Increases the players max stamina and jump power by 10%."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.JumpPowerIncrease  = 1.1
Perk.Settings.MaxStaminaIncrease = 1.1

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns
Perk.DamageFunctions  = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions = {} -- // Plays when a player dies
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions   = {} -- // Plays when the player is being hit

-- // Functions

-- // Increases the speed and jump power of the player
local function increaseSpeed(self, Profile, Player, ...)
	local Character = Profile.Character
	if not (Character and Character.Parent) then return end
	
	local Attributes = Character:GetAttributes()
	local JumpPowerIncrease  = self.Settings.JumpPowerIncrease  -- // 10 Percent higher
	local MaxStaminaIncrease = self.Settings.MaxStaminaIncrease -- // 10 Percent higher
	
	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.JumpPower *= JumpPowerIncrease 
	
	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina * MaxStaminaIncrease))
end

-- // Initiates the perks functionality
Perk.PerkInitiation = increaseSpeed

-- // Deactivates initial functions
-- // Decreases the speed and jump power of the player
function Perk:Deactivate(Profile, Player, ...)
	local Character = Profile.Character
	if not (Character and Character.Parent) then return end

	local Attributes = Character:GetAttributes()
	local JumpPowerIncrease  = self.Settings.JumpPowerIncrease  -- // 10 Percent higher
	local MaxStaminaIncrease = self.Settings.MaxStaminaIncrease -- // 10 Percent higher

	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.JumpPower /= JumpPowerIncrease 

	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina / MaxStaminaIncrease))
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------
Perk.RespawnFunctions.perkInitialization = Perk.PerkInitiation

return Perk
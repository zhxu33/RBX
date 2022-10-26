-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Increases all physical attributes by 5%."
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Settings.Defense    = 1.05 -- 5%
Perk.Settings.MaxHealth  = 1.05 -- 5%
Perk.Settings.MaxStamina = 1.05 -- 5%
Perk.Settings.JumpPower  = 1.05 -- 5%
Perk.Settings.WalkSpeed  = 1.05 -- 5%


-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns
Perk.DamageFunctions  = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions = {} -- // Plays when a player dies
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions   = {} -- // Plays when the player is being hit

-- // Functions
-- // Initiates the perks functionality
-- // Increases the physical attributes of the player
function Perk:PerkInitiation(Profile, Player, ...)
	local Character = Profile.Character
	if not (Character and Character.Parent) then return end
	
	local Attributes = Character:GetAttributes()
	Character:SetAttribute("Defense", (Attributes.Defense * self.Settings.Defense))
	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina * self.Settings.MaxStamina))
	
	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.JumpPower *= self.Settings.JumpPower
	Humanoid.MaxHealth *= self.Settings.MaxHealth
	Humanoid.WalkSpeed *= self.Settings.WalkSpeed
end

-- // Deactivates initial functions
-- // Deactivates the physical attributes of the player
function Perk:Deactivate(Profile, Player, ...)
	local Character = Profile.Character
	if not (Character and Character.Parent) then return end

	local Attributes = Character:GetAttributes()
	Character:SetAttribute("Defense", (Attributes.Defense / self.Settings.Defense))
	Character:SetAttribute("MaxStamina", (Attributes.MaxStamina / self.Settings.MaxStamina))

	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.JumpPower /= self.Settings.JumpPower
	Humanoid.MaxHealth /= self.Settings.MaxHealth
	Humanoid.WalkSpeed /= self.Settings.WalkSpeed
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------
Perk.RespawnFunctions.perkInitialization = Perk.PerkInitiation

return Perk
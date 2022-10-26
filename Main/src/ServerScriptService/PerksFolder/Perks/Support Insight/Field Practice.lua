-- // Services
local ServerScriptService = game:GetService("ServerScriptService")

-- // Variables
local ModulePackage  = ServerScriptService.ModulePackage
local CombatServices = ServerScriptService.CombatScripts
local InformationModule = require(CombatServices.Settings)

local HealCircle = script.HealCircle

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Activate a defensive bubble below 45% health. Any player that enters your zone will receive +10% defense and an increased health regeneration for 10 seconds. (Bubble lasts for until you heal back to 100% and lingers for 4 more seconds) (15 seconds cooldown)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings          = {}
Perk.Settings.Cooldown = 15  -- // Seconds
Perk.Settings.Defense  = 1.1 -- // 10%
Perk.Settings.Health   = 1.1 -- // 10%
Perk.Settings.RequiredHealth   = .45 -- // 45%
Perk.Settings.Duration         = 10  -- // Seconds
Perk.Settings.BuffDistance     = 25  -- // Distance each player has to be in order to receive buff
Perk.Settings.UserHealthBoost  = .1  -- // 10% | Adds 10% for every player being healed
Perk.Settings.HealthBoostStack = 0

Perk.Settings.isActivated  = false
Perk.Settings._connections = {}

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

-- // Functions
-- // Added health regen for x seconds
local function IncreaseHealthRegen(self, Profile, Target, Duration)
	local isFinished = false
	local thread
	local isUser = (Target == self.Character)
	
	local Humanoid = Target:FindFirstChild("Humanoid")
	if not Humanoid then return end
	
	-- // User of perk gets health stack bonuses
	if not isUser then
		self.Settings.HealthBoostStack += 1
	end
	
	-- // Sets the increase in defense
	Target:SetAttribute("Defense", Target:GetAttribute("Defense") * self.Settings.Defense)
	
	-- // Duration
	if Duration then
		thread = task.delay(Duration, function()
			isFinished = true
		end)
	end
	
	-- // Health increase
	repeat
		task.wait(InformationModule.Health_Regeneration_Delay)
		local HealthRegen = self.Settings.Health
		
		-- // Applying health stack to perk owner
		if isUser then
			HealthRegen += (self.Settings.HealthBoostStack * self.Settings.UserHealthBoost)
		end
		
		local Health     = Humanoid.MaxHealth * (InformationModule.Health_Regeneration_Rate * HealthRegen)
		Humanoid.Health += Health
		if (isUser and Humanoid.Health >= Humanoid.MaxHealth) then break end 
	until (Humanoid.Health <= 0) or (isFinished)
	
	-- // Removing buff and potential thread if user died
	Target:SetAttribute("Defense", Target:GetAttribute("Defense") / self.Settings.Defense)
	if (coroutine.status(thread) == "suspended") then task.cancel(thread) end
end

-- // Initiates the perks functionality 
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	local Settings     = self.Settings
	local HitboxModule = require(ModulePackage.SpatialHitbox)
	Profile:DisposeInfo(Settings._connections) -- // Removing previous connections in-case
	
	-- // Checking whether the perk has the ability to activate
	local Humanoid = Profile.Character.Humanoid
	table.insert(Settings._connections, Humanoid.HealthChanged:Connect(function()
		if Settings.isActivated then return end
		if ((Humanoid.Health / Humanoid.MaxHealth) > Settings.RequiredHealth or (Humanoid.Health == 0)) then return end
		Profile:ShowMessage(self, "%s Activated.")
		Settings.isActivated = true
		self.Settings.HealthBoostStack = 0
		
		-- // Setting up and showing the heal circle
		local newHeal  = HealCircle:Clone()
		local RootPart = (Profile.Character.PrimaryPart or Profile.Character:FindFirstChild("HumanoidRootPart"))
		newHeal:PivotTo(RootPart.CFrame)
		newHeal.WeldConstraint.Part0 = RootPart
		newHeal.Parent = workspace.Debris
		
		-- // Hitbox settings
		local hitboxSettings  = HitboxModule:GetSettings()
		hitboxSettings.Player = Profile.Character
		hitboxSettings.Rate   = 20
		hitboxSettings.UseMoveDuration = false
		hitboxSettings.AttackId        = {Damage = 0}
		hitboxSettings.Knockback       = false
		hitboxSettings.HitboxType      = "sphere"

		local HitboxInfo = HitboxModule:Add(newHeal, hitboxSettings)
		
		-- // When a player gets hit they're now being buffed
		HitboxInfo:Connect(function(Character, HitChar)
			if not (Character and HitChar) then return end
			
			-- // If both models are not of the same type, then don't proceed
			if (Character:GetAttribute("NPC") ~= HitChar:GetAttribute("NPC")) then return end
			
			IncreaseHealthRegen(self, Profile, HitChar, Settings.Duration)
		end)
		
		-- // This is going to be sloppy
		local connection
		local secondaryConnection
		connection = Humanoid.HealthChanged:Connect(function()
			if Humanoid.Health < Humanoid.MaxHealth then return end
			connection:Disconnect(); secondaryConnection:Disconnect()
			HitboxInfo:Remove(true)
			
			Profile:SetCooldown(self.Name, Settings.Cooldown)
			Profile:ShowMessage(self, "%s Deactivated.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
			Settings.Thread = task.delay(Settings.Cooldown, function()
				Settings.Thread      = nil
				Settings.isActivated = false
			end)
		end)
		
		-- // Just in case the player dies
		secondaryConnection = Humanoid.Died:Connect(function()
			connection:Disconnect(); secondaryConnection:Disconnect()
			HitboxInfo:Remove(true)
			Profile:ShowMessage(self, "%s Deactivated.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
		end)
		
		IncreaseHealthRegen(self, Profile, Profile.Character)
	end))
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------
Perk.RespawnFunctions.On_Respawn = Perk.PerkInitiation

return Perk
-- // Services

-- // Variables

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Within 2 seconds from blocking, user will teleport behind npc that hit them dealing 15% of their health. (10 second cooldown)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Connections	= {}

Perk.Settings.Initiation = tick()
Perk.Settings.High_Guarding = false
Perk.Settings.Guard_Duration = 2
Perk.Settings.Stamina_Consumption = .5
Perk.Settings.Damage = .15
Perk.Settings.Guard_Cooldown = 10

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

-- Needs effect
function Perk:HighGuardReady(Profile)
	Profile:ShowMessage(self, "High Guard Ready.")
end

function Perk:HighGuardUsage(Profile)
	Profile:SetCooldown(self.Name, Perk.Settings.Guard_Cooldown)
--	Profile:ShowMessage(self, "High Guard Used.")
end

function Perk:HighGuardDelete(Profile)
	Profile:ShowMessage(self, "High Guard Deactivated.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
end

-- // Functions
-- // Initiates the perks functionality
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	
	Profile:DisposeInfo(self.Connections)
	if not game.Players:GetPlayerFromCharacter(Profile.Character) then return end
	
	task.delay(Perk.Settings.Guard_Cooldown, function()
		if Profile.Character and Profile.Character.Parent then
			self:HighGuardReady(Profile)	
		end
	end)
	-- Connection
	self.Connections[Profile.Player] = Profile.Character:GetAttributeChangedSignal("Blocking"):Connect(function()
		if Profile.Character:GetAttribute("Blocking")
			and Profile.Character:GetAttribute("Stamina") >= Profile.Character:GetAttribute("MaxStamina")*self.Settings.Stamina_Consumption
			and self.Settings.Initiation + self.Settings.Guard_Cooldown <= tick() then
			self.Settings.High_Guarding = true
			self.Settings.Initiation = tick()
			self:HighGuardUsage(Profile)
			
			task.delay(self.Settings.Guard_Duration, function()
				if not self.Settings.High_Guarding then return end
				self.Settings.High_Guarding = false
				self:HighGuardDelete(Profile)
				task.wait(Perk.Settings.Guard_Cooldown)
				self:HighGuardReady(Profile)
			end)
		elseif self.Settings.High_Guarding and not Profile.Character:GetAttribute("Blocking") then 
			self.Settings.High_Guarding = false
			self:HighGuardDelete(Profile)
			task.wait(Perk.Settings.Guard_Cooldown)
			self:HighGuardReady(Profile)
		end
	end)
	
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------


Perk.RespawnFunctions.HighGuardInitialization = Perk.PerkInitiation

function Perk.OnHitFunctions:HighGuard(Profile : PerkProfile, Damage, Attacker)
	
	if Profile.Character:GetAttribute("Stamina") >= Profile.Character:GetAttribute("MaxStamina")*self.Settings.Stamina_Consumption
		and self.Settings.High_Guarding
		and Attacker:FindFirstChild("Humanoid") and Attacker.Humanoid.Health ~= 0 then

		self.Settings.High_Guarding = false
		self:HighGuardDelete(Profile)
		
		Profile.Character:SetAttribute("Stamina", Profile.Character:GetAttribute("MaxStamina")-(Profile.Character:GetAttribute("MaxStamina")*self.Settings.Stamina_Consumption))
		Profile.Character.PrimaryPart.CFrame = Attacker.PrimaryPart.CFrame*CFrame.new(0, 0, -5) -- <-- Makeshift dashing (Gotta think about this one still...)
		game.ReplicatedStorage.DamageFunction:Fire(Profile.Character, Attacker.Humanoid, ((Attacker.Humanoid.MaxHealth*self.Settings.Damage)/workspace.S1c2R5i66p5t5s51.PlayerData[Profile.Player.Name].Strength.Value)/10)
		
		task.wait(10)
		self:HighGuardReady(Profile)
		
	end
	
end

return Perk
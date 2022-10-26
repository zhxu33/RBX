-- // Services
local PlayerService = game:GetService("Players")

-- // Variables
local PlayerData = (workspace:FindFirstChild("S1c2R5i66p5t5s51") and workspace.S1c2R5i66p5t5s51.PlayerData)

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
- Any time a Hero receives damage, boost the damaged ones' morale. Grant them slightly increased health regeneration for 3 seconds. Build up 1 stack of One For All. (This morale buff stacks with other player One For All buffs) 
- At 50 Stacks, the morale buff will apply to you as well for triple the time (12 seconds). The buff will begin to increase in strength proportional to the amount of stacks you currently have.
- At 100 Stacks, increase the overall morale buffs length to 20 seconds for the team and you. Health regeneration for the buff increases the lower your health is. The stacks will drain by 1 every second, where all of the effects will then wear off and One For All will go into cooldown for 45 seconds.
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings                    = {}
Perk.Settings.Regen_Buff         = 1.2
Perk.Settings.Regen_Duration     = 3
Perk.Settings.Buff_Cooldown      = 5
Perk.Settings.Stacks_Per_Hit     = 1
Perk.Settings.Debounce_Time      = .5
Perk.Settings.Buff_Per_Stack     = 0.0025 -- // Since there's 100 | Makes the regen up to 1.45x?

Perk.Settings.PerkLevel2         = 50 -- // Stacks required
Perk.Settings.PerkUser_Duration  = 12

Perk.Settings.PerkLevel3         = 100 -- // Stacks required (Max)
Perk.Settings.Max_Regen_Duration = 20
Perk.Settings.Stack_Drain_Speed  = 1   -- // Per second
Perk.Settings.isDraining         = false
Perk.Settings.onCooldown         = false
Perk.Settings.Cooldown           = 45
Perk.Settings.Drain_Rate         = .1
Perk.Settings.Stacks = 0

-- // Initial regen buff
-- // Initial regen duration
-- // Stacks per hero* hit
-- // Stack debounce time (.5 seconds between hits)
-- // Increase of regen per stack
-- // Duration applied to self at xx stacks
-- // Max stacks Duration and Power
-- // Drain speed once it reaches max
-- // Cooldown

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

local function StackDrain(self, Profile)
	if self.Settings.isDraining then return end
	self.Settings.isDraining = true
	
	for stack = self.Settings.Stacks, 0, -1 do
		self.Settings.Stacks = stack
		Profile:SetCooldown(self.Name, stack, 0)
		task.wait(self.Settings.Drain_Rate)
	end
	
	Profile:ShowMessage(self, "%s Deactivated.")
	Profile:SetCooldown(self.Name, self.Settings.Cooldown)
	
	self.Settings.onCooldown = true
	self.Settings.isDraining = false
	self.Settings.Stacks = 0
	
	task.delay(self.Settings.Cooldown, function()
		self.Settings.onCooldown = false
	end)
end

-- // Connects the players character to one for all event (Only if they're a hero)
local function ConnectPlayer(self, Profile, Target)
	local isPerkOwner       = Profile.Player == Target
	local OFAProfile        = {}
	local connections       = {}
	OFAProfile._Connections = connections
	OFAProfile._HumaniodConnection = nil
	local Character = nil
	
	local function CharacterInit(Char)
		if not Char then return end
		if OFAProfile._HumaniodConnection and OFAProfile._HumaniodConnection.Connected then OFAProfile._HumaniodConnection:Disconnect() end
		Character = Char
		
		local Humanoid = Char:WaitForChild("Humanoid")
		
		local PrevHealth   = Humanoid.Health
		local Debounce     = false
		local isBuffed     = false
		local BuffCooldown = false
		
		OFAProfile._HumaniodConnection = Humanoid.HealthChanged:Connect(function()
			local previousHealth = PrevHealth
			local currentHealth  = Humanoid.Health
			
			PrevHealth = currentHealth
			if (previousHealth < currentHealth) then return end
			if (self.Settings.onCooldown) then return end
			
			-- // For the worse
			
			if Debounce then return end
			Debounce = true
			
			local addStack = self.Settings.Stacks_Per_Hit
			local maxLevel = self.Settings.Stacks >= self.Settings.PerkLevel3
			self.Settings.Stacks += maxLevel and 0 or addStack
			Profile:SetCounter(self.Name, self.Settings.Stacks, self.Settings.PerkLevel3)
			
			if (maxLevel and not self.Settings.isDraining) then
				task.spawn(StackDrain, self, Profile)
			end
			
			-- // Give player the buff if they can receive buff
			if not (isBuffed or BuffCooldown) and not (isPerkOwner and self.Settings.PerkLevel2 > self.Settings.Stacks) then
				isBuffed     = true
				BuffCooldown = true
				local ExtraBuff  = (self.Settings.Stacks > self.Settings.PerkLevel2) and (((not maxLevel and self.Settings.Stacks or self.Settings.PerkLevel3) - self.Settings.PerkLevel2)) or 0
				
				local Attributes = Character:GetAttributes()
				
				local Buff = (self.Settings.Regen_Buff + (ExtraBuff * self.Settings.Buff_Per_Stack))
				Character:SetAttribute("HealthRegen_Multiplier", (Attributes.HealthRegen_Multiplier or 1) * Buff)
				
				local RegenDuration = (maxLevel and self.Settings.Max_Regen_Duration) or (isPerkOwner and self.Settings.PerkUser_Duration) or self.Settings.Regen_Duration
				task.delay(RegenDuration, function()
					isBuffed = false
					Character:SetAttribute("HealthRegen_Multiplier", (Character:GetAttribute("HealthRegen_Multiplier")) / Buff)
					
					task.wait(self.Settings.Buff_Cooldown)
					BuffCooldown = false
				end)
			end
			
			task.wait(self.Settings.Debounce_Time)
			Debounce = false
		end)
	end
	CharacterInit(Target.Character)
	
	-- // Incase character dies or respawns
	table.insert(connections, Target.CharacterAdded:Connect(CharacterInit))
	
	table.insert(connections, Target.AncestryChanged:Connect(function(_, newParent)
		if newParent then return end
		-- // Dispose info
		Profile:DisposeInfo(OFAProfile)
	end))
	
	return OFAProfile
end

-- // Initiates the perks functionality 
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	Profile:DisposeInfo(self._used_cache)
	self._used_cache = {}
	
	local players = PlayerService:GetPlayers()
	
	for _, player in pairs(players) do
		task.spawn(function()
			local userData = PlayerData:FindFirstChild(player.Name)
			if not userData then return end
			if userData.Fame.Value <= 0 then return end -- // Villain or Civilian
			
			table.insert(self._used_cache, ConnectPlayer(self, Profile, player))
		end)
	end
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------

return Perk
-- // Services
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService       = game:GetService("Players")
local Replicated          = game:GetService("ReplicatedStorage")

-- // Variables
local SurvivalMainScript = ServerScriptService:FindFirstChild("SurvivalMainScript")
local RaidSettings       = (SurvivalMainScript and require(SurvivalMainScript.RaidSettings))
local NPCs               = workspace:FindFirstChild("NPCs")

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = [[
If the perk user is the last on the field, all NPCs will lose 25% of their max health. 
(2 wave cooldown)
]]
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings                 = {}
Perk.Settings.Cooldown        = 2
Perk.Settings.Health_Decrease = .75 -- // 25%
Perk._Connections = {} -- // The connection for the perk user's humanoid

local globalDebounce    = false
local prevRaidActivated = -5

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns

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

-- // Check raid wave
local function CheckWave()
	if RaidSettings.Wave >= (prevRaidActivated + Perk.Settings.Cooldown) then
		globalDebounce = false
	else
		globalDebounce = true
	end
end

-- // Checks if the player can restart the next wave
local function PerkActivation(Profile)
	CheckWave()
	if globalDebounce then 
		Profile:SetCounter(Perk.Name, ((prevRaidActivated + Perk.Settings.Cooldown) - RaidSettings.Wave), 0)
		return 
	end
	prevRaidActivated = RaidSettings.Wave

	Profile:ShowMessage(Perk, "%s Activated, Last Man Standing.")
	
	-- // reducing max health from npcs
	for _, child in ipairs(NPCs:GetChildren()) do
		if not (child:FindFirstChild("Humanoid")) then continue end
		local humanoid = child.Humanoid
		
		humanoid.MaxHealth *= Perk.Settings.Health_Decrease
		if humanoid.Health > humanoid.MaxHealth then 
			humanoid.Health = humanoid.MaxHealth
		end
	end
	
	-- // Removes spawned in npcs health
	local childAddedConnection = NPCs.ChildAdded:Connect(function(child)
		if not (child:FindFirstChild("Humanoid")) then return end
		local humanoid = child.Humanoid

		humanoid.MaxHealth *= Perk.Settings.Health_Decrease
		if humanoid.Health > humanoid.MaxHealth then 
			humanoid.Health = humanoid.MaxHealth
		end
	end)
	
	-- // Whenever the npcs die, remove all connections
	local waveConnection
	waveConnection = RaidSettings.WaveObj.Changed:Connect(function()
		waveConnection:Disconnect()
		childAddedConnection:Disconnect()
	end)
end

-- // Checks if the player is able to use the perk
local function CheckActivation(self, Profile)
	local finalUser = Profile.Player
	
	for _, player in ipairs(PlayerService:GetPlayers()) do
		if (player == finalUser) then continue end
		if not (player.Character and player.Character.Parent) then continue end
		local Hum = player.Character.Humanoid
		
		if (Hum.Health > 0) then return end
	end
	
	if finalUser == Profile.Player then
		PerkActivation(Profile)
	end
end

-- // Functions
-- // Initiates the perks functionality 
function Perk:PerkInitiation(Profile : PerkProfile, Player, ...) -- // self is the deep copied perk file
	Profile:DisposeInfo(self._Connection)
	local Character = Profile.Character
	if not Character then return end

	for _, player in ipairs(PlayerService:GetPlayers()) do
		if (player == Profile.Player) then continue end
		table.insert(self._Connections, player.CharacterRemoving:Connect(function()
			CheckActivation(self, Profile)
		end))
	end
	
	table.insert(self._Connections, RaidSettings.WaveObj.Changed:Connect(function()
		CheckActivation(self, Profile)
	end))
end

------------------------------------------[MAIN FUNCTIONS]------------------------------------------         

Perk.RespawnFunctions.Initialize_Respawn = Perk.PerkInitiation

return Perk
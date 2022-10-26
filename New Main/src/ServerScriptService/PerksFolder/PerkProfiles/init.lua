-- // Service
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService       = game:GetService("Players")
local Replicated          = game:GetService("ReplicatedStorage")
local RunService          = game:GetService("RunService")

-- // Variable
local Parent         = script.Parent
local SurvivalScript = ServerScriptService:FindFirstChild("SurvivalMainScript")
local PlayerData     = workspace.S1c2R5i66p5t5s51.PlayerData
local SettingsMod    = SurvivalScript and SurvivalScript.RaidSettings
local PerksFolder    = Parent:WaitForChild("Perks")
local Perks          = {}

Perks.PerkProfiles       = {} -- // All Perk Profiles that are enabled
Perks.NPCPerkProfiles    = {} -- // All Npc perk profiles that are enabled
Perks.PlayerPerkProfiles = {} -- // Player Perk Profiles; contains data about the perks a player has (Also npcs)
local newRandom = Random.new(tick() + math.random(1, 1000))

-- // Modules
local ProfileFunctions = require(script._profileFunctions)
local UtilModule       = require(script._utility)
local Settings         = SettingsMod and require(SettingsMod)

-- // Perk settings [Defaults]
Perks.Settings                   = {}
Perks.Settings.PerkWaves         = 15 -- // Perk waves occur every <- waves
Perks.Settings.PerksPerPoll      = 3  -- // However many random perks sent
Perks.Settings.MaxPerkLimit      = 10 -- // Total Perks possible to obtain (when buying a new perk slot, unless perk includes a new slot)
Perks.Settings.StartingPerkLimit = 3  -- // Total perks a user can have
Perks.Settings.PerkIntermission  = false
Perks.Settings.SlotCost          = 100000
Perks.Settings.RerollCost        = 100000

-- // Functions

-- // Gets a DeepCopy of a table
function DeepCopy(oldVal)
	local isTable  = type(oldVal) == "table"
	local newTable = isTable and {} or oldVal

	if isTable then
		for TableIndex, Value in pairs(oldVal) do
			newTable[TableIndex] = DeepCopy(Value)
		end
	end

	return newTable
end

-- // Disposes tables
local function DisposeInfo(info) : nil
	local Type = typeof(info)

	if Type == "table" then
		for index, value in pairs(info) do
			info[index] = DisposeInfo(value)
		end
		table.clear(info)
	elseif Type == "RBXScriptConnection" then
		info:Disconnect()
	elseif Type == "thread" and coroutine.status(info) == "suspended" then
		task.cancel(info)
	elseif Type == "Instance" and info:IsA("BindableEvent") then
		info:Destroy()
	end

	return nil
end

-- // Get Client view
function Perks:GetClientInfo(Perk)
	local Info = {}

	Info.Name        = Perk.Name
	Info.Category    = Perk.Category
	Info.Description = Perk.Description
	Info.IconImage   = Perk.IconImage

	return Info
end

-- // Gathers all the perk profiles in to the settings
function Perks:GetPerkProfiles()
	if #self.PerkProfiles > 0 then return self.PerkProfiles end

	for _, value in pairs(PerksFolder:GetDescendants()) do
		if value:IsA("ModuleScript") then
			local ReqMod = require(value)
			if not ReqMod.Enabled then continue end

			table.insert(self.PerkProfiles, ReqMod)

			if value:GetAttribute("NPC_Capable") then
				table.insert(self.NPCPerkProfiles, ReqMod)
			end
		end
	end

	return self.PerkProfiles
end

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
}

-- // Creates a new profile for the player
function Perks.newProfile(Player) : PerkProfile
	local Profile             = setmetatable({}, ProfileFunctions)
	Profile.Perks             = {} -- // Table that holds the profiles for quirks
	Profile.RespawnFunctions  = {} -- // Plays when a player respawns
	Profile.DamageFunctions   = {} -- // Plays when a player hits someone1
	Profile.OnKillFunctions   = {} -- // Plays when someone defeats an npc
	Profile.OnRewardFunctions = {} -- // Plays when someone is being rewarded
	Profile.OnDeathFunctions  = {} -- // Plays when a player dies
	Profile.OnHitFunctions    = {} -- // Plays when the player is being hit

	Profile.BlacklistedPerks  = {} -- // List full of names which make the player unable to choose it

	Profile._RestartWave      = false -- // Restarts the wave if true (Only if everyone is dead)
	Profile._RespawnPlayer    = false -- // Respawns the player (Immediately maybe)

	Profile.Player            = Player
	Profile.Character         = nil
	Profile.PerkLimit         = Perks.Settings.StartingPerkLimit
	Profile.PerksHeld         = 0  -- // Players current perks
	Profile.PerksPerPoll      = Perks.Settings.PerksPerPoll

	--for index, value in pairs(Perks.Settings) do
	--	Profile[index] = DeepCopy(value)
	--end

	-- // Deep copy function, convenient
	function Profile:DeepCopy(value:any) : any
		return DeepCopy(value)
	end

	-- // Dispose function, also convenient
	function Profile:DisposeInfo(value:any) : nil
		return DisposeInfo(value)
	end

	-- // Giving a way to get a clients view of info from any profile
	function Profile:GetClientInfo(perk)
		return Perks:GetClientInfo(perk)
	end

	-- // Adds a cooldown to the perk
	function Profile:SetCooldown(perk, cooldown, goal, toFill)
		if not (perk and cooldown) then return end
		if not (Player:IsA("Player")) then return end
		if (cooldown < os.time()) then cooldown += os.time() end
		local perk = self:HasPerk(perk)

		local clientInfo = Perks:GetClientInfo(perk)
		local updateInfo         = {}
		updateInfo.PerkToUpdate  = clientInfo
		updateInfo.SetCooldown   = true
		updateInfo.Cooldown      = cooldown
		updateInfo.CooldownGoal  = goal
		updateInfo.CooldownFill  = toFill
		updateInfo.CooldownStart = os.time()

		UtilModule:UpdatePlayerPerk(Player, updateInfo)
	end

	-- // Shows a counter to the player
	function Profile:SetCounter(perk, counter, goal)
		if not (perk and counter) then return end
		if not (Player:IsA("Player")) then return end
		local perk = self:HasPerk(perk)

		local clientInfo = Perks:GetClientInfo(perk)
		local updateInfo        = {}
		updateInfo.PerkToUpdate = clientInfo
		updateInfo.SetCounter   = true
		updateInfo.Counter      = counter
		updateInfo.CounterGoal  = goal

		UtilModule:UpdatePlayerPerk(Player, updateInfo)
	end

	-- // Shows a counter to the player
	function Profile:ShowMessage(perk, message, scheme)
		if not (perk and message) then return end
		if not (Player:IsA("Player")) then return end
		local perk = self:HasPerk(perk)

		local clientInfo = Perks:GetClientInfo(perk)
		local updateInfo        = {}
		updateInfo.PerkToUpdate = clientInfo
		updateInfo.Message      = message
		updateInfo.Scheme       = (typeof(scheme) == "ColorSequence" and scheme)

		UtilModule:UpdatePlayerPerk(Player, updateInfo)
	end

	-- // On death function
	local function DiedFunc(Char)
		Profile.Character = Char
		local Hum = Char:WaitForChild("Humanoid")
		Hum.Died:Wait()
		Profile:FireDeathFunctions()

		if not (Profile._RespawnPlayer) then return end
		if Profile.Player == Profile.Character then return end -- // Since npcs Player value is their character, this detects if it's an npc or player
		Profile.Player:LoadCharacter()
		Profile._RespawnPlayer = false
	end

	-- // Deals with the player respawn & death
	if PlayerService:FindFirstChild(Player.Name) then
		task.spawn(DiedFunc, Player.Character or Player.CharacterAdded:Wait())

		Player.CharacterAdded:Connect(function(Char:Model)
			task.spawn(DiedFunc, Char)

			-- // Check if the parent is workspace
			if not (Char:IsDescendantOf(workspace)) then Char.AncestryChanged:Wait() end

			Profile:FireRespawnFunctions(Player, Char) 
		end)

	else
		task.spawn(DiedFunc, Player)
	end

	-- // Disposing of info (Since player is the character of an npc, auto removes after npcs death)
	local removalConnection
	removalConnection = Player.AncestryChanged:Connect(function(obj, newParent)
		if (newParent) then return end
		removalConnection:Disconnect()
		Profile:DisposeInfo(Profile)
		Profile = nil
	end)

	if (RunService:IsStudio() and not Player:IsA("Model")) then
		--Profile:AddPerk()
	end

	return Profile
end

-- // Gets the profile of a player
function Perks:GetProfile(Player, ID) : PerkProfile
	if not ID then
		ID = Player.UserId
	end

	return (self.PlayerPerkProfiles[ID] or self.newProfile(Player))
end

-- // Removes a profile
function Perks:RemoveProfile(...)
	local Profile = self:GetProfile(...)
	DisposeInfo(Profile)

	return self
end

-- // Creates all the user's profiles
function Perks:CreatePlayerProfiles()
	for _, player in pairs(PlayerService:GetPlayers()) do
		local Success, err = pcall(function()
			Perks.PlayerPerkProfiles[player.UserId] = Perks:GetProfile(player)
		end)
	end

	return self
end

-- // Gets all the npc related perk profiles
function Perks:GetNPCPerkProfiles()
	local PerkProfiles = self:GetPerkProfiles()

	return (self.NPCPerkProfiles)
end

-- // Returns a perk that's only meant for npcs
function Perks:GetRandomNPCPerk()
	local NPCPerkProfiles = self:GetNPCPerkProfiles()
	return NPCPerkProfiles[newRandom:NextInteger(1, #NPCPerkProfiles)]
end

-- // Get Random perk
function Perks:GetRandomPerk()
	local PerkProfiles = self:GetPerkProfiles()
	return PerkProfiles[newRandom:NextInteger(1, #PerkProfiles)]
end

-- // Gets the perks profile given a name
function Perks:GetPerkProfile(PerkName)
	for _, value in pairs(self.PerkProfiles) do
		if value.Name == PerkName then
			return value
		end
	end
end

-- // Perk intermissions
local CurrentPicks = {}

function Perks:PerkIntermission()
	if not (Settings) then return end
	CurrentPicks = {}

	-- // Connection allows player to choose their next perk
	local PerkRemote = UtilModule:RequestPerkRoll()
	local Connection = PerkRemote.OnServerEvent:Connect(function(Player, Perk:string, ToReplace)
		if not Perks.Settings.PerkIntermission then return end
		if CurrentPicks[Player.UserId].Picked or not Perk or not CurrentPicks[Player.UserId].Picks[Perk] then return end

		local perkProfile = self:GetPerkProfile(Perk)
		if not perkProfile then return end -- // Perk doesn't exist?

		CurrentPicks[Player.UserId].Picked = Perk

		local Profile = self:GetProfile(Player)
		local Perk    = CurrentPicks[Player.UserId].Picks[Perk]

		-- // If the perk is obtainable or not (Includes villain / hero specific quirks)
		if (Perk.Obtainable ~= true) then
			UtilModule:Announce(Player, ("Cannot choose perk: Perk already owned or not elgible for use."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
			CurrentPicks[Player.UserId].Picked = nil
			return
		end

		-- // If the player hits their Perk limit
		if Profile.PerkLimit <= Profile.PerksHeld then
			UtilModule:Announce(Player, ("Cannot choose perk: Perk slots are full, total perks (%s)."):format(Profile.PerksHeld), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
			CurrentPicks[Player.UserId].Picked = nil
			return
		end

		UtilModule:Announce(Player, ("You have chosen the perk: %s"):format(Perk.Name), 18, Color3.fromRGB(0, 255, 170)) -- // (result, TextSize, Color, Font)
		Profile:AddPerk(self:GetPerkProfile(Perk.Name))
	end)

	-- // Purchasing a new perk slot *if possible*
	local PurchaseSlot = UtilModule:RequestSlotPurchase()
	local Purchase = PurchaseSlot.OnServerEvent:Connect(function(Player)
		self:IncreaseStartingPerkLimit(Player)
	end)

	-- // Purchasing a reroll
	local PurchaseRoll = UtilModule:RequestRollPurchase()
	local PurchaseCon2 = PurchaseRoll.OnServerEvent:Connect(function(Player)
		self:RerollPerks(Player)
	end)

	self.Settings.PerkIntermission = true
	Settings.Intermission.Value = true

	-- // Grabbing the perks for a player
	for _, player in pairs(PlayerService:GetPlayers()) do
		CurrentPicks[player.UserId] = {Picks = {}, PurchasedSlot = false}
		task.spawn(Perks.RollPerks, self, player)
	end

	local PlayersReady     = {}
	local SkipIntermission = false

	local ReadyUp = UtilModule:RequestReadyUp() -- // So the remote will always exist
	local ReadyUpConnection = ReadyUp.OnServerEvent:Connect(function(Player)
		if table.find(PlayersReady, Player.UserId) then return end
		table.insert(PlayersReady, Player.UserId)

		UtilModule:ReadyUp(#PlayersReady, #PlayerService:GetPlayers())

		if #PlayerService:GetPlayers() > #PlayersReady then return end
		SkipIntermission = true
	end)
	UtilModule:ReadyUp(#PlayersReady, #PlayerService:GetPlayers())
	ReadyUp.OnServerEvent:Wait()

	-- // The perk intermission
	for index = Settings.PerkIntermission, 1, -1 do
		Settings.TimeLeftObj.Value = index
		if SkipIntermission then break end

		task.wait(1)
	end

	Settings.Intermission.Value     = false
	Perks.Settings.PerkIntermission = false

	UtilModule:UpdateRolls()

	Purchase:Disconnect()
	PurchaseCon2:Disconnect()
	Connection:Disconnect()

	table.clear(PlayersReady)
	table.clear(CurrentPicks)

	return self
end

-- // Increases the max perks a player can hold, up to the max possible perks
function Perks:IncreaseStartingPerkLimit(Player, Robux) -- // Robux determines if they purchased with robux
	if not (Settings and Perks.Settings.PerkIntermission) then return end

	if (not CurrentPicks[Player.UserId] or CurrentPicks[Player.UserId].PurchasedSlot) and not Robux then
		UtilModule:Announce(Player, ("One slot purchase limit per perk intermission."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
		return 
	end

	local Profile = self:GetProfile(Player)
	if Profile.PerkLimit >= self.Settings.MaxPerkLimit then

		UtilModule:Announce(Player, ("Cannot purchase perk slot: Max perk slots obtained."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
		error("Cannot purchase perk slot: Max perk slots obtained.")
	end

	local Data = PlayerData:FindFirstChild(Player.Name)
	if not Data then 

		UtilModule:Announce(Player, ("Cannot purchase perk slot error finding player data."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
		error("Cannot purchase perk slot error finding player data.")
	end

	local Cost = self.Settings.SlotCost * (2^(Profile.PerkLimit - self.Settings.StartingPerkLimit))

	if not Robux then
		if Data.Cash.Value < Cost then

			UtilModule:Announce(Player, ("Cannot purchase perk slot, insufficient funds."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
			return
		end

		Data.Cash.Value -= Cost
	end
	UtilModule:PurchaseSlot(Player, Cost * 2)

	CurrentPicks[Player.UserId].PurchasedSlot = true

	UtilModule:Announce(Player, ("Successfully purchased perk slot."), 18, Color3.fromRGB(145, 255, 145)) -- // (result, TextSize, Color, Font)
	Profile.PerkLimit += 1
	self:RollPerks(Player)

	return self
end

-- // Re rolls the players current shown perks
function Perks:RerollPerks(Player, Robux) -- // Robux determines if they purchased with robux
	if not (Settings and Perks.Settings.PerkIntermission) then return end
	local Profile = self:GetProfile(Player)

	if Profile.PerksHeld >= self.Settings.MaxPerkLimit or not Perks.Settings.PerkIntermission then
		local Reason = "Cannot purchase perk reroll: Max perk obtained."
		if Robux then
			Reason = "Cannot purchase perk reroll: Max perk obtained. Refunding $100,000 Cash (Initial cost)."
		end
		UtilModule:Announce(Player, Reason, 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)

		error(Reason)
	end

	if not Robux then
		local Data = PlayerData:FindFirstChild(Player.Name)

		if not Data then
			UtilModule:Announce(Player, ("Cannot purchase reroll error finding player data."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
			error("Cannot purchase reroll error finding player data.")
		end

		if Data.Cash.Value < self.Settings.RerollCost then
			UtilModule:Announce(Player, ("Cannot purchase perk reroll, insufficient funds."), 18, Color3.fromRGB(255, 145, 145)) -- // (result, TextSize, Color, Font)
			return
		end

		Data.Cash.Value -= self.Settings.RerollCost
	end

	UtilModule:Announce(Player, ("Successfully purchased perk reroll."), 18, Color3.fromRGB(145, 255, 145)) -- // (result, TextSize, Color, Font)
	self:RollPerks(Player)

	return self
end

-- // Rolls the current perks a player has shown
function Perks:RollPerks(Player)
	if not (self.Settings.PerkIntermission) then return end

	local Profile = self:GetProfile(Player)

	local updateInfo        = {} -- // Don't provide perk
	updateInfo.Remove       = false
	updateInfo.PerkLimit    = Profile.PerkLimit
	updateInfo.PerkToUpdate = nil

	UtilModule:UpdatePlayerPerk(Player, updateInfo)

	local success, err = pcall(function()
		local RandomList = {}

		for index = 1, Profile.PerksPerPoll do
			local Perk = self:GetRandomPerk()

			-- // So there's no chance of getting duplicate perks to choose from
			while RandomList[Perk.Name] do 
				Perk = self:GetRandomPerk()
			end

			local ClientInfo      = self:GetClientInfo(Perk)

			local canObtain, reason = Profile:CanObtain(Perk)
			ClientInfo.Obtainable   = (not canObtain and (reason or "Unlisted Reason")) or true 
			RandomList[Perk.Name]   = ClientInfo
		end

		CurrentPicks[Player.UserId].Picks = RandomList

		UtilModule:UpdateRolls(Player, RandomList, true)
	end)

	if not success then warn(err) end

	return self
end

Perks:GetPerkProfiles()
return Perks
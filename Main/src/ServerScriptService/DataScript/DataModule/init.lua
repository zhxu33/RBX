--[[

DataModule.PlayerInformation[Player.UserId]            -- Player Cached Data
DataModule.PlayerInformation[Player.UserId].Items      -- Player Items
DataModule.PlayerInformation[Player.UserId].PlayerData -- PlayerData (Main Data)

]]

local DataModule = {}

 --================================= [ SERVICES ] =================================--
local DataStore     = game:GetService("DataStoreService")
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

 --================================= [ DATASTORES ] =================================--
local DataStoreList = {
	["PermBan"]          = DataStore:GetDataStore("PermBan"), -- // Ban Store
	["Player"]           = DataStore:GetDataStore("Player"),  -- // Ban Store
	["PlayerData"]       = DataStore:GetDataStore("PlayerData"),
	["PlayerDataBackUp"] = DataStore:GetDataStore("PlayerDataBackUp"),
	["Items"]            = DataStore:GetDataStore("Items"),
	["ItemsBackUp"]      = DataStore:GetDataStore("ItemsBackUp"),
}

local OrderedFameStore = DataStore:GetOrderedDataStore("Fame")
local ArenaDataStore   = DataStore:GetOrderedDataStore("ArenaWins")

 --================================= [ MODULES ] =================================--
local updateVars = require(script._updateVars)
local banMod     = require(script._banInfo)

 --================================= [ DIRECTORIES ] =================================--
local bindables = ServerStorage:FindFirstChild("Bindables")

 --================================= [ VARIABLES ] =================================--
local joinBind  = bindables and bindables:FindFirstChild("PlayerJoined")
local leaveBind = bindables and bindables:FindFirstChild("PlayerLeft")

local Shutdown = false

local StarterInformation = {
	["PlayerData"] = {
		-- // Player's main data
		["Level"]      = 1,
		["Strength"]   = 1,
		["Agility"]    = 1,
		["Quirk"]      = 3,
		["Durability"] = 1,
		["StatPoints"] = 3,
		["Experience"] = 0,
		["Fame"]       = 0,
		["Cash"]       = 25000,
		
		-- // Event currency
		["EventCurrency"] = 0,
		
		-- // Ban information
		["PermBan"]    = false,
		["Ban"] = {
			["Time2"]  = 0,
			["Reason"] = nil
		},
		
		-- // Moderations
		["Moderations"] = {},
	},
	
	-- // separate ban information
	["PermBan"] = false,
	["Player"]  = {
		["Ban"] = {
			["Time2"] = 0,
			["Reason"] = nil
		}
	},
}

local IgnoreDataString = { -- Ignoring these specific datastores, there's a reason trust me
	"PlayerData",
	"Items",
	"ItemsBackUp",
}

 --================================= [ MODULE INFORMATION ] =================================--

-- Literally going to make this stacked with every part of information about the player
DataModule.PlayerInformation = if DataModule.PlayerInformation and type(DataModule) == "table" then DataModule.PlayerInformation else {} 

 --================================= [ MODULE FUNCTIONS ] =================================--

-- // Retreiving Information Functions
-- // Requires the datastore without making the script 10000 lines
local function RequireInformation(DataToRequire, PlayerId)
	local Attempt = 1
	local Data
	local success, retVal
	
	-- // getting the user's data with interval checks if fails
	repeat
		success, retVal = pcall(function()
			Data = DataStoreList[DataToRequire]:GetAsync(PlayerId)
		end)
		
		if not Data and Attempt < 4 and not success then
			Attempt += 1
			task.wait(3)
		end
	until Attempt >= 4 or success
	
	DataToRequire = DataToRequire == "PlayerDataBackUp" and "PlayerData" or DataToRequire
	
	-- // tells whether it will go through the process again but with backup data
	local isNew = not Data
	Data = Data or {}
	
	-- // Deep copy of a value
	local function deepCopy(val)
		if type(val) ~= "table" then
			return val
		end

		local result = {}
		for key, value in pairs(val) do
			result[key] = deepCopy(value)
		end
		return result
	end
	
 	-- // Getting data if it's missing
	for index, value in pairs(StarterInformation[DataToRequire] or {}) do
		if not Data[index] then
			Data[index] = deepCopy(value)
		end
	end
	
	return Data, isNew
end

-- // self is the player, will require userid (This function will Get the Async of datastores)
function DataModule:SetPlayerDataToList()
	if not DataModule.PlayerInformation[self.UserId] then
		DataModule.PlayerInformation[self.UserId] = {}
		local List  = DataModule.PlayerInformation[self.UserId]
		List.Player = self
		
		-- // Getting PlayerData, not weapon / gadget data
		local function setValuesInTable(Table)
			for DataType, Value in pairs(Table) do
				List[DataType] = Value
			end
		end
		
		local Data, isNew = RequireInformation("PlayerData", self.UserId)
		
		-- // Getting back up if current data doesn't exist / creates new data
		if not Data or type(Data) ~= "table" or isNew then
			for DataStoreType, DataStore in pairs(DataStoreList) do
				if not table.find(IgnoreDataString, DataStoreType) then
					task.spawn(function()
						local otherData = RequireInformation(DataStoreType, self.UserId)
						if type(otherData) == "table" then
							setValuesInTable(otherData)
						else
							List[DataStoreType] = otherData
						end
					end)
				end
			end
		else
			setValuesInTable(Data)
		end
		
		-- // Create ban handler (Kicks user if they're banned / sets banned data if it doesn't exist)
		local isBanned = banMod:checkInfo(self, List)
		if isBanned then return end
		
		-- // Getting Weapon GadgetData
		local DataType  = "Items"
		local ItemsData, isNew = RequireInformation(DataType, self.UserId)
		if not ItemsData or type(ItemsData) ~= "table" or isNew then
			local otherData = RequireInformation(DataType.."BackUp", self.UserId)
			List[DataType] = otherData
		else
			List[DataType] = ItemsData
		end
		
		-- // data will be linked so it autoupdates with instance values
		updateVars.setUpdateVars(List)
		
		-- // let's other scripts know it's done loading
		if joinBind then joinBind:Fire(self) end
		DataModule.PlayerInformation[self.UserId] = List
	end
end

-- // Autosaving Functions / Variables
local AutoSaveInterval   = 300
local IgnoreAutoSave     = false    -- // makes it not save while this option is true [FOR STUDIO DISABLE FOR UPDATE]
local ManualSaveCooldown = {}       -- // Making this have the player omitted from next autosave
local SaveMeta = {
	__newindex = function(self, index, value)
		rawset(self, index, value)
		
		task.spawn(function()
			task.wait(AutoSaveInterval)
			rawset(self, index, nil)
		end)
	end,
}
setmetatable(ManualSaveCooldown, SaveMeta)

-- // List all event weapons and gadgets that can't be sold
local WeaponsThatCantBeDegraded = {
	"EasterKatana",
	"SnowSword",
	"EasterBow",
	"EasterGrimoire",
	"EasterFlintlock",
	"EasterStaff",
	"EasterSword",
	"EasterWand",
	"GhastSword",
	"HalloweenScythe",
	"IceSickle",
	"OrnamentBlaster",
	"PeppermintSaber",
	"PumpkinPistol",
	"CursedGlove",
	"CandyCaneGun",
	"SantaArmor",
	"PumpkinArmor",
	"GhastArmor",
	"FestiveLights",
	"EggPauldron",
	"BunnyEars",
}

if RunService:IsStudio() then IgnoreAutoSave = true end

-- // Going to use this for autosaving as well
local isSaving = {} -- // secondary debounce due to game:Bindtoclose()
function DataModule:SaveData()
	local List = DataModule.PlayerInformation[self.UserId]
	if IgnoreAutoSave or not List or type(List) ~= "table" or List.isKicked then return end
	
	-- // Saving to backup
	local DataSaved = true
	
	local function WriteToBackup(UpdateType, backup)
		local Success, err = pcall(function()
			if UpdateType == "PlayerData" then
				DataStoreList.PlayerDataBackUp:SetAsync(self.UserId, backup)
			elseif UpdateType == "Items" then
				DataStoreList.ItemsBackUp:SetAsync(self.UserId, List.Items)
			end
		end)
	end

	-- // saving player's data
	local SavingAttempt = 1
	local backup
	local Success, err
	repeat
		Success, err = pcall(function()
			DataStoreList.PlayerData:UpdateAsync(self.UserId, function(old)
				local newList = if old and type(old) == "table" then old else {}
				old = if old and type(old) == "table" then old else {}
				
				for value, _ in pairs(StarterInformation.PlayerData) do
					if newList[value] ~= List[value] then
						newList[value] = List[value] or old[value]
					end
				end
				
				if old.Level and List.Level and old.Level > List.Level then
					newList.Level = old.Level
				end
				
				backup = newList
				return newList
			end)
		end)

		if not Success then
			SavingAttempt += 1
			warn(err)
			task.wait(3)
		end
	until Success or SavingAttempt >= 4
	if Success then WriteToBackup("PlayerData", backup) else DataSaved = false end
	
	-- // saving player's items
	local SavingAttempt = 1
	repeat
		Success, err = pcall(function()
			DataStoreList.Items:UpdateAsync(self.UserId, function(old)
				local newList = List.Items
				old = if old and type(old) == "table" then old else {}
				
				for CheckIndex, Item in pairs(WeaponsThatCantBeDegraded) do
					if old[Item] then
						if not newList[Item] then
							newList[Item] = old[Item]
						elseif newList[Item] < old[Item] and table.find(WeaponsThatCantBeDegraded, Item) then
							newList[Item] = old[Item]
						end
					end
				end

				backup = newList
				return newList
			end)
		end)

		if not Success then
			SavingAttempt += 1
			warn(err)
			task.wait(3)
		end
	until Success or SavingAttempt >= 4
	if Success then WriteToBackup("Items", backup) else DataSaved = false end
	return DataSaved
end

-- // Event Functions

-- // Sets whether the server will set players data to a cache or not
if game.PrivateServerId == "" or game.PrivateServerOwnerId ~= 0 then
	Players.PlayerAdded:Connect(DataModule.SetPlayerDataToList)
	
	Players.PlayerRemoving:Connect(function(Player)
		DataModule.SaveData(Player)
		DataModule.RemoveFromTable(Player)
	end)
	
	game:BindToClose(function()
		Shutdown = true
		for PlayerIndex, Player in pairs(Players:GetPlayers()) do
			task.spawn(function()
				DataModule.SaveData(Player)
			end)
		end
		
		task.wait(9)
	end)
	
	task.spawn(function()
		while not Shutdown do
			task.wait(AutoSaveInterval)
			for PlayerIndex, Player in pairs(Players:GetPlayers()) do
				if not ManualSaveCooldown[Player.UserId] then
					DataModule.SaveData(Player)
					task.wait(6)
				end
			end
		end
	end)
end

-- // Players manual save
function DataModule:manualSave()
	if ManualSaveCooldown[self.UserId] then return end
	ManualSaveCooldown[self.UserId] = true
	
	DataModule.SaveData(self)
end

-- // Other Functions
-- // Gets a DeepCopy of a table
function DataModule.CopyTable(newTable)
	local new = newTable or {}
	
	for TableIndex, Value in pairs(newTable) do
		local newValue = Value
		
		if type(Value) == "table" then
			newValue = DataModule.CopyTable(Value)
		end
		
		new[TableIndex] = newValue
	end
	
	return new
end

-- // Self should be the player
function DataModule:GetCachedData()
	local newTable = DataModule.CopyTable(DataModule.PlayerInformation[self.UserId])
	return newTable
end

-- // Disposes the player's cached data
local function DisposeTableContents(Table)
	if type(Table) == "table" then
		for Index, Value in pairs(Table) do
			if typeof(Value) == "Instance" then
				if Value.Parent and not Players:FindFirstChild(Value.Name) then
					Value:Destroy()
				end
			elseif type(Value) == "table" then
				DisposeTableContents(Value)
			elseif typeof(Value) == "RBXScriptConnection" then
				Value:Disconnect()
			else
				Value = nil
			end
		end
	end
	Table = nil
end

-- // removes the player's cached data
function DataModule.RemoveFromTable(Player)
	local playerInfo = DataModule.PlayerInformation[Player.UserId] or {}
	DisposeTableContents(playerInfo)
end

return DataModule
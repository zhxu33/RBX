--[[

DataModule.PlayerInformation[Player.UserId]            -- Player Cached Data

]]


local DataModule = {}

 --================================= [ SERVICES ] =================================--
local DataStore  = game:GetService("DataStoreService")
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")

 --================================= [ DATASTORES ] =================================--
local DataStoreList = {
	["PermBan"]          = DataStore:GetDataStore("PermBan"),
	["Player"]           = DataStore:GetDataStore("Player"),
	["EasterEgg"]        = DataStore:GetDataStore("EasterEgg"),
	["PlayerData"]       = DataStore:GetDataStore("PlayerData"),
	["PlayerDataBackUp"] = DataStore:GetDataStore("PlayerDataBackUp"),
	["Items"]            = DataStore:GetDataStore("Items"),
	["ItemsBackUp"]      = DataStore:GetDataStore("ItemsBackUp"),
}

 --================================= [ VARIABLES ] =================================--
local Shutdown = false

local StarterInformation = {
	PlayerData = {
		Level      = 1,
		Strength   = 1,
		Agility    = 1,
		Quirk      = 3,
		Durability = 1,
		StatPoints = 3,
		Experience = 0,
		Fame       = 0,
		Cash       = 25000,
	},
}

local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData

 --================================= [ MODULE INFORMATION ] =================================--

DataModule.PlayerInformation = {} -- Literally going to make this stacked with every part of information about the player

 --================================= [ MODULE FUNCTIONS ] =================================--

 -- Retreiving Information Functions

function DataModule:SetPlayerDataToList() -- self is the player, will require userid (This function will Get the Async of datastores)
	if not DataModule.PlayerInformation[self.UserId] then
		DataModule.PlayerInformation[self.UserId] = {}
		local List  = DataModule.PlayerInformation[self.UserId]
		List.Player = self
		List._Connections = {}
		-- Getting PlayerData, not weapon / gadget data
		
		local Data = PlayerData:WaitForChild(self.Name)
		Data:WaitForChild("Loaded")
		
		for _, value in ipairs(Data:GetChildren()) do
			if not StarterInformation.PlayerData[value.Name] then continue end
			
			List[value.Name] = value.Value
			
			table.insert(List._Connections, value:GetPropertyChangedSignal("Value"):Connect(function()
				List[value.Name] = value.Value
			end))
		end
	end
end

 -- Other Functions

local function CopyTable(newTable, oldTable) -- Gets a DeepCopy of a table
	for TableIndex, Value in pairs(oldTable) do
		local newValue = Value
		if type(Value) == "table" then
			newValue = {}
			CopyTable(newValue, Value)
		end
		newTable[TableIndex] = newValue
	end
end

function DataModule:GetCachedData() -- Self should be the player
	local newTable = {}
	CopyTable(newTable, DataModule.PlayerInformation[self.UserId])
	return newTable
end

local function DisposeTableContents(Table) -- Disposes the player's cached data
	if type(Table) == "table" then
		for Index, Value in pairs(Table) do
			if typeof(Value) == "Instance" and Value.Parent then
				Value:Destroy()
			elseif type(Value) == "table" then
				DisposeTableContents(Value)
			elseif typeof(Value) == "RBXScriptConnection" and Value.Connected then
				Value:Disconnect()
			end
			
			Table[Index] = nil
		end
	end
	Table = nil
end

function DataModule.RemoveFromTable(Player) -- removes the player's cached data
	if not Players:FindFirstChild(Player.Name) and DataModule.PlayerInformation[Player.UserId] then
		DisposeTableContents(DataModule.PlayerInformation[Player.UserId])
	end
end

 -- Event Functions

 -- Sets whether the server will set players data to a cache or not
if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
else
	Players.PlayerAdded:Connect(DataModule.SetPlayerDataToList)
	Players.PlayerRemoving:Connect(DataModule.RemoveFromTable)
end

return DataModule
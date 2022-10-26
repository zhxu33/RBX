local BV = ""
if game.PlaceId == 7775211226 then
	BV = game:GetService("ServerScriptService").BetaScript:GetAttribute("BV")
end

local DataStore = game:GetService("DataStoreService")
local LevelStore = DataStore:GetDataStore("Level"..BV)
local StrengthStore = DataStore:GetDataStore("Strength"..BV)
local AgilityStore = DataStore:GetDataStore("Agility"..BV)
local QuirkStore = DataStore:GetDataStore("Quirk"..BV)
local DurabilityStore = DataStore:GetDataStore("Durability"..BV)
local StatPointsStore = DataStore:GetDataStore("StatPoints"..BV)
local FameStore = DataStore:GetDataStore("Fame"..BV)
local CashStore = DataStore:GetDataStore("Cash"..BV)
local PlayerDataStore = DataStore:GetDataStore("PlayerData"..BV)
local Event = game.ReplicatedStorage.GlobalStats

Event.OnServerEvent:Connect(function(plr, UserID)
	if plr:GetRankInGroup(3755220) > 12 then
		local PlrData = PlayerDataStore:GetAsync(UserID)
		local DataTable = {
			Level = PlrData.Level,
			Strength = PlrData.Strength,
			Agility = PlrData.Agility,
			Quirk = PlrData.Quirk,
			Durability = PlrData.Durability,
			StatPoints = PlrData.StatPoints,
			Fame = PlrData.Fame,
			Cash = PlrData.Cash,
		}
		local Username = game.Players:GetNameFromUserIdAsync(UserID)
		Event:FireClient(plr, DataTable)
	else
		game.ReplicatedStorage.SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to check statistics.")
	end
end)
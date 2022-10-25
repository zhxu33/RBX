local DataStore = game:GetService("DataStoreService")
local LevelStore = DataStore:GetDataStore("Level")
local StrengthStore = DataStore:GetDataStore("Strength")
local AgilityStore = DataStore:GetDataStore("Agility")
local QuirkStore = DataStore:GetDataStore("Quirk")
local DurabilityStore = DataStore:GetDataStore("Durability")
local StatPointsStore = DataStore:GetDataStore("StatPoints")
local FameStore = DataStore:GetDataStore("Fame")
local CashStore = DataStore:GetDataStore("Cash")
local PlayerDataStore = DataStore:GetDataStore("PlayerData")
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
local players = game:GetService("Players")

local Module = require(script.WeaponCache)

local DataStore = game:GetService("DataStoreService")
local ItemsStore = DataStore:GetDataStore("Items")
players.PlayerAdded:Connect(function(plr)	
	local success, err 
	local interval = 0

	repeat	
		success, err = pcall(function()
			Module.TemparyStorage[plr.UserId] = ItemsStore:GetAsync(plr.UserId)
		end)

		if not success then
			warn(err)
			interval += 1
			wait(6)
		end

		if interval >= 6 then
			plr:Kick("Failed to load player data.")
			break
		end
	until success

	if success then
		Module.Unrelatedlist[plr.UserId] = false
		if not Module.TemparyStorage[plr.UserId] then
			Module.TemparyStorage[plr.UserId] = {}
		end
	end
end)

players.PlayerRemoving:Connect(function(plr)
	local id = plr.UserId
	if Module.TemparyStorage[id] then
		ItemsStore:SetAsync(id, Module.TemparyStorage[id])
	end
end)

while task.wait(3) do
	local Players = game:GetService("Players"):GetChildren()
	for i=1,#Players do
		ID = Players[i].UserId
		if Module.Unrelatedlist[ID] then	
			ItemsStore:SetAsync(ID, Module.TemparyStorage[ID])
			Module.Unrelatedlist[ID] = false
			task.wait(3)
		end
		task.wait(0.1)
	end
end
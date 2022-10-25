local DataStore = game:GetService("DataStoreService")
local Cooldown = DataStore:GetDataStore("Cooldown")
local SaveCD = game.ReplicatedStorage.SaveCD
local Players = {}

local function SavingDelay(plr, Save)
	if not Players[plr] then
		Players[plr] = true
		local success, errormessage = pcall(function()		
			Cooldown:SetAsync(plr.UserId.."-Cd", Save)
		end)
		if not success then
			warn(errormessage)
		end
		local coro = coroutine.wrap(function()
			wait(7)
			Players[plr] = false
		end)
		coro()
	end
end

SaveCD.OnServerEvent:Connect(function(plr, Save)
	SavingDelay(plr, Save)
end)

game.Players.PlayerAdded:Connect(function(player)
	Players[player] = false
	local PlayerGui = player:WaitForChild("PlayerGui")
	local CooldownGui = PlayerGui:WaitForChild("CooldownGui")
	local MenuGui = PlayerGui:WaitForChild("Menu")
	local data
	local success, errormessage = pcall(function()
		data = Cooldown:GetAsync(player.UserId.."-Cd")
	end)
	if success then
		game.ReplicatedStorage.SaveCD:FireClient(player, data)
	else
		warn(errormessage)
	end
end)
local MessageService = game:GetService("MessagingService")
local DetectBan = game.ReplicatedStorage:WaitForChild("DetectBan")
local Players = game:GetService("Players")
local CommandService = game.ServerScriptService.CommandTab
local CommandModule = require(CommandService.GetInformation)

DetectBan.Event:Connect(function(name, reason)
	local success, errorMessage = pcall(function()
		MessageService:PublishAsync("Banned", {NN = name, RR = reason})
	end)
	if success then
		print("Successfully sent the message")
	else
		warn(errorMessage)
	end
end)

local function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end

game.Players.PlayerAdded:Connect(function(player)
	 -- Ban / pban
	local BanConnection = MessageService:SubscribeAsync("Banned", function(message)
		local Table = message.Data
		local Name = Table.NN
		local Reason = Table.RR
		local PLR = GetPlayer(Name)
		if PLR then
			PLR:Kick(Reason)
		end
	end)
	local StatResetConnection
	StatResetConnection = MessageService:SubscribeAsync("Stat Reset", function(message)
		local Data = message.Data
		local User = Data.UserId
		if User ~= player.UserId then return end
		if Players:GetPlayerByUserId(User) then
			CommandModule.SetDataToDataStore(User, Data.Data, false)
		end
	end)
	local RemovingConnection
	RemovingConnection = game.Players.PlayerRemoving:Connect(function(Player2)
		if Player2.UserId == player.UserId then
			if StatResetConnection then
				StatResetConnection:Disconnect()
			end
			if BanConnection then
				BanConnection:Disconnect()
			end
			if RemovingConnection then
				RemovingConnection:Disconnect()
			end
		end
	end)
end)
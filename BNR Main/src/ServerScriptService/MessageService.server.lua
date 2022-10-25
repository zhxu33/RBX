local MessageService = game:GetService("MessagingService")
local DetectBan = game.ReplicatedStorage:WaitForChild("DetectBan")

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

game.Players.PlayerAdded:Connect(function(player)
	local Success, Connection = pcall(function()
		return MessageService:SubscribeAsync("Banned", function(message)
			local Table = message.Data
			local Name = Table.NN
			local Reason = Table.RR
			local PLR = GetPlayer(Name)
			if PLR then
				PLR:Kick(Reason)
			end
		end)
	end)
	if not Success then
		print("Failure to load the subscription.")
	end
end)

function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end
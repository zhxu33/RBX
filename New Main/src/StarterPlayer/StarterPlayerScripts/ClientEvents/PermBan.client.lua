local player = game.Players.LocalPlayer
local Event = game.ReplicatedStorage.PermItems.UnPBan
local Event2 = game.ReplicatedStorage.PermItems.PBan
local Event3 = game.ReplicatedStorage.PermItems.SendPBanCon
local Event4 = game.ReplicatedStorage.PermItems.SendUnPBanCon

Event.OnClientEvent:connect(function(Name)
	Event:FireServer(Name)
end)

Event2.OnClientEvent:connect(function(Name)
	Event2:FireServer(Name)
end)

Event3.OnClientEvent:connect(function(Name)
	Event3:FireServer(Name)
end)

Event4.OnClientEvent:connect(function(Name)
	Event4:FireServer(Name)
end)
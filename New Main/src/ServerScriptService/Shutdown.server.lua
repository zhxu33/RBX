--[[
	SoftShutdown 1.2
	Author: Merely
	
	This system lets you shut down servers without losing a bunch of players.
	When game.OnClose is called, the script teleports everyone in the server
	into a reserved server.
	
	When the reserved servers start up, they wait a few seconds, and then
	send everyone back into the main place.
	
	I added wait() in a couple of places because if you don't, everyone will spawn into
	their own servers with only 1 player.
--]]

local TeleportService = game:GetService("TeleportService")
local Players         = game:GetService("Players")

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
	-- this is a reserved server without a VIP server owner
	local m = Instance.new("Message")
	m.Text = "This is a temporary lobby. Teleporting back in a moment."
	m.Parent = workspace
	
	local waitTime = 5

	Players.PlayerAdded:connect(function(player)
		wait(waitTime)
		waitTime = waitTime / 2
		TeleportService:Teleport(game.PlaceId, player)
	end)
	
	for _,player in pairs(Players:GetPlayers()) do
		TeleportService:Teleport(game.PlaceId, player)
		wait(waitTime)
		waitTime = waitTime / 2
	end
else
	game:BindToClose(function()
		if (#Players:GetPlayers() == 0) then
			return
		end
		
		if (game:GetService("RunService"):IsStudio()) then
			return
		end
		
		local m = Instance.new("Message")
		m.Text = "Rebooting servers. Please wait"
		m.Parent = workspace
		wait(2)
		local reservedServerCode = TeleportService:ReserveServer(game.PlaceId)
		
		for _,player in pairs(Players:GetPlayers()) do
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
		end
		Players.PlayerAdded:connect(function(player)
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
		end)
		while (#Players:GetPlayers() > 0) do
			wait(1)
		end	
		
		-- done
	end)
	
	task.spawn(function()
		task.wait(43200) -- // Restarting server in 12 hours
		Players.PlayerAdded:Connect(function(Player)
			local reservedServerCode = TeleportService:ReserveServer(game.PlaceId)
			
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { Player })
			task.wait(5) -- // Doesn't teleport player within time...
			Player:Kick("Server is rebooting.")
		end)
		
		local m  = Instance.new("Message")
		m.Text   = "This server is rebooting. Teleporting to temporary lobby."
		m.Parent = workspace

		local reservedServerCode = TeleportService:ReserveServer(game.PlaceId)
		TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, Players:GetPlayers())
		
		task.wait(15)
		
		for _, player in pairs(Players:GetPlayers()) do
			player:Kick("Server rebooting. . .")
		end
	end)
end

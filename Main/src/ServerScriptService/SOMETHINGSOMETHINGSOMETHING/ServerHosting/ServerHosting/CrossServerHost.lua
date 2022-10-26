local module = {}

 -- // Services
local PlayerService    = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")
local Replicated       = game:GetService("ReplicatedStorage")

-- // Directories \\ --
local Remotes   = Replicated.Remotes
local EventR    = Remotes.Event

 -- // Variables
module.ServersLobbies = {}
module.ForeignLobbies = {}

local ThatFile  = workspace.S1c2R5i66p5t5s51 
local JobId     = tostring(tick())

 -- // Bindable & Events
local LeaveBind   = script.Parent.Leave
local StartBind   = script.Parent.Start
local UpdateBind  = script.Parent.Update

local updateLobbyEvent = EventR.updateLobby

 -- // removing foreign lobby
local function removingLobby(lobby)
	task.spawn(function()
		if #lobby.PlayerCount == 0 or lobby.ServerType == "Starting" then
			module.ServersLobbies[lobby.ServerName] = nil
			module.ForeignLobbies[lobby.ServerName] = nil
		end
	end)
end

 -- // Linking the messaging service and lobby
local function linkService(Table)
	Table.Connection = MessagingService:SubscribeAsync(Table.LobbyOwner, function(information)
		local Data = information.Data
		
		if Data.PlayerCount and #Data.PlayerCount > 0 then
			if Data.ServerType == "Starting" then
				StartBind = StartBind:Invoke(Data)
			end
			
			if module.ForeignLobbies[Table.ServerName] then
				module.ForeignLobbies[Table.ServerName] = Data
			elseif module.ServersLobbies[Table.ServerName] then	
				module.ForeignLobbies[Table.ServerName] = Data
			end
			
			for index, child in pairs(Data.PlayerCount) do
				local user = PlayerService:FindFirstChild(child)
				if user then
					UpdateBind:Fire(user, Data)
				end
			end
		else
			for index, child in pairs(Table.PlayerCount) do
				LeaveBind:Fire(child)
			end
			
			module.ForeignLobbies[Table.ServerName] = nil
			module.ServersLobbies[Table.ServerName] = nil
		end
	end)
end

 -- // Get the lobbies that are in the messaging service
local function getReadyLobbies()
	 -- // requesting forien servers lobbies
	task.spawn(function()
		local success, err = pcall(function()
			local information = {}
			information.JobId = game.JobId

			local success, err
			local Interval    = 0

			repeat 
				success, err = pcall(function()
					MessagingService:PublishAsync("ServerLobbies", information)
				end)

				if not success then
					warn(err)
					Interval += 1
					task.wait(10)
				end
			until Interval >= 5 or success
		end)
	end)
end

 -- // Receiving other server lobbies
local function retrievingLobbies()
	local ServerSubscription = MessagingService:SubscribeAsync(JobId, function(information)
		local Data    = information.Data
		local Lobbies = Data.Lobbies
		
		if Lobbies and type(Lobbies) == "table" then
			for lobbyName, child in pairs(Lobbies) do
				if not module.ServersLobbies[lobbyName] and not module.ForeignLobbies[lobbyName] then
					module.ForeignLobbies[lobbyName] = child
				end
			end
		end
	end)
end

 -- // Setting lobby to other servers to see
function module:setPlayerLobby(lobbyInformation)
	local success, err
	local Interval = 0
	
	module.ServersLobbies[self.Name] = lobbyInformation
	
	repeat
		success, err = pcall(function()
			MessagingService:PublishAsync("newLobby", lobbyInformation)
		end)

		if not success then
			warn(err)
			Interval += 1
			task.wait(10)
		end
	until Interval >= 5 or success
end

 -- // Player asking if they can join the server
function module:canJoinLobby(Lobbyname)
	local canJoin      = false
	local currentLobby = nil
	
	local function sendMessage(lobby)
		local Data = ThatFile.PlayerData:FindFirstChild(self.Name)
		if #lobby.PlayersCount >= 12 or Data and lobby.LevelReq > Data.Level.Value then return end
		local success, err
		local Interval = 0
		
		repeat
			success, err = pcall(function()
				MessagingService:PublishAsync(lobby.LobbyOwner, lobby)
			end)

			if not success then
				warn(err)
				Interval += 1
				task.wait(10)
			end
		until Interval >= 5 or success
		
		if success then
			currentLobby = lobby
			canJoin      = true
		end
	end
	
	if module.ServersLobbies[Lobbyname] then
		sendMessage(module.ServersLobbies[Lobbyname])
	elseif module.ForeignLobbies[Lobbyname] then
		sendMessage(module.ForeignLobbies[Lobbyname])
	end
	
	return canJoin, currentLobby
end

 -- // Leaving a lobby
function module:leavingLobby(Lobbyname)
	local success, err
	local isOwner = false
	
	local function leaving(lobby)
		local found = table.find(lobby.PlayerCount, self.Name)
		if found then
			local Interval    = 0
			local information = {}
			information.PlayerCount = lobby.PlayerCount
			table.remove(information.PlayerCount, table.find(information.PlayerCount, self.Name))
			
			if self.UserId == lobby.LobbyOwner then
				isOwner = true
				table.clear(information)
				if lobby.Connection and lobby.Connection == Enum.ConnectionState.Connected then
					lobby.Connection:Disconnect()
					lobby.Connection = nil
				end
			end
			
			repeat
				success, err = pcall(function()
					MessagingService:PublishAsync(lobby.LobbyOwner, information)
				end)
				
				if not success then
					warn(err)
					Interval += 1
					task.wait(10)
				end
			until Interval >= 5 or success
			
			if success then
				table.remove(lobby.PlayerCount, found)
				removingLobby(lobby)
			end
			
			return success, isOwner
		else
			success = true
			return
		end
	end
	
	if module.ServersLobbies[Lobbyname] then
		local lobby = module.ServersLobbies[Lobbyname]
		leaving(lobby)
	elseif module.ForeignLobbies[Lobbyname] then
		local lobby = module.ForeignLobbies[Lobbyname]
		leaving(lobby)
	end
end

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
else
	task.spawn(function()
		retrievingLobbies()
		getReadyLobbies()
	end)
	 -- // getting lobbies requests
	task.spawn(function()
		task.wait(10)
		local ServerSubscription = MessagingService:SubscribeAsync(JobId, function(information)
			local Data       = information.Data
			local ServerName = Data.ServerName
			
			if ServerName and not module.ServersLobbies[ServerName] and not module.ForeignLobbies[ServerName] then
				module.ForeignLobbies[ServerName] = Data
				updateLobbyEvent:FireAllClients(information.ServerName, information)
				linkService(module.ForeignLobbies[ServerName])
			end
		end)
	end)
	
	 -- // getting new server
	task.spawn(function()
		task.wait(10)
		local ServerSubscription = MessagingService:SubscribeAsync("ServerLobbies", function(information)
			local Data        = information.Data
			local ServerJobID = Data.JobId

			if ServerJobID then
				if #module.ServersLobbies > 0 then
					local success, err
					local Interval    = 0
					local information = {}

					local function deepCopy(Table)
						local newTable = {}

						for index, child in pairs(Table) do
							if type(child) == "table" then
								newTable[index] = deepCopy(child)
							else
								newTable[index] = child
							end

							if index == "PlayerCount" then
								if #child == 0 then
									table.clear(newTable)
									newTable = nil
									break
								end
							end

							newTable.Connection = nil
						end

						return newTable
					end
					information.Lobbies = deepCopy()
					information.JobId   = game.JobId

					repeat 
						success, err = pcall(function()
							MessagingService:PublishAsync(ServerJobID, information)
						end)

						if not success then
							warn(err)
							Interval += 1
							task.wait(10)
						end
					until Interval >= 5 or success
				end
			end
		end)
	end)
end

return module
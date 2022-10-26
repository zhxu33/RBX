 -- // Services \\ --
local PlayerService   = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local Replicated      = game:GetService("ReplicatedStorage")
local ServerStorage   = game:GetService("ServerStorage")

 -- // Directories \\ --
local Remotes   = Replicated.Remotes
local EventR    = Remotes.Event
local Bindables = ServerStorage.Bindables

 -- // Events \\ --
local getListEvent     = EventR.getList
local joinLobbyEvent   = EventR.joinLobby
local createLobbyEvent = EventR.createLobby
local leaveLobbyEvent  = EventR.leaveLobby
local startLobbyEvent  = EventR.startLobby
local updateLobbyEvent = EventR.updateLobby

local PlayerJoinedEvent = Bindables.PlayerJoined
local PlayerLeftEvent   = Bindables.PlayerLeft

 -- // Variables \\ --
local JLDebounce = {} -- // Joining and leaving the lobby (Don't want to overflow things)

local ThatFile     = workspace.S1c2R5i66p5t5s51
local CrossServer  = require(script.CrossServerHost)
local LeaveBind    = script.Leave
local TeleportBind = script.Start
local UpdateBind   = script.Update

 -- // User Lobbies \\ --
local playerLobbies = {} -- // Holds a list of lobbies, uses lobby name
local userInLobby   = {} -- // This holds which player is in which lobby

 -- // Functions \\ --
 -- // Leaving a lobby

function leavingLobby(Player, ForceQuit, isCrossServer)
	local ID = Player.UserId
	if (userInLobby[ID] == nil or not JLDebounce[ID].Join or JLDebounce[ID].Leave) and not ForceQuit then return end
	
	if playerLobbies[userInLobby[ID]] then
		JLDebounce[ID].Leave  = true
		JLDebounce[ID].Join   = false
		JLDebounce[ID].Create = false

		if playerLobbies[userInLobby[ID]] then
			table.remove(playerLobbies[userInLobby[ID]].PlayerCount, table.find(playerLobbies[userInLobby[ID]].PlayerCount, Player.Name))

			for index, child in pairs(playerLobbies[userInLobby[ID]].PlayerCount) do
				local newPlayer = PlayerService:FindFirstChild(child)
				if newPlayer then
					leaveLobbyEvent:FireClient(newPlayer, Player.Name, nil, true)
				end
			end

			if playerLobbies[userInLobby[ID]].LobbyOwner == Player.UserId then
				for index, username in pairs(playerLobbies[userInLobby[ID]].PlayerCount) do
					if PlayerService:FindFirstChild(username) then
						leavingLobby(PlayerService[username])
						leaveLobbyEvent:FireClient(PlayerService[username], username, nil, true)
					end
				end
				updateLobbyEvent:FireAllClients(userInLobby[ID], nil, true)
				table.clear(playerLobbies[userInLobby[ID]].PlayerCount)
				table.clear(playerLobbies[userInLobby[ID]])
				playerLobbies[userInLobby[ID]] = nil
			end
		end
		
		userInLobby[ID] = nil
	elseif not isCrossServer then
		JLDebounce[ID].Leave  = false
		JLDebounce[ID].Join   = false
		JLDebounce[ID].Create = false
		
		local isSuccess, isOwner = CrossServer.leavingLobby(Player, userInLobby[ID])
			
		if isSuccess then
			JLDebounce[ID].Join   = true
			JLDebounce[ID].Create = true
			
			if isOwner then
				for index, child in pairs(userInLobby) do
					if child == userInLobby[ID] then
						local player = PlayerService:GetPlayerByUserId(index)
						if player then
							leaveLobbyEvent:FireClient(player, player.Name, nil, true)
						end
						child = nil
					end
				end
				updateLobbyEvent:FireAllClients(userInLobby[ID], nil, true)
			end
		else
			JLDebounce[ID].Leave  = true
		end
	end
end

LeaveBind.Event:Connect(function(PlayerName)
	local User = PlayerService:FindFirstChild(PlayerName)
	if User then
		leaveLobbyEvent(User, true, true)
	end
end)

leaveLobbyEvent.OnServerEvent:Connect(leavingLobby)

 -- // Adding the user to tables
local function addPlayerValues(Player)
	JLDebounce[Player.UserId] = {
		Join   = false,
		Leave  = true,
		Create = false, 
		Update = false,
	}
	userInLobby[Player.UserId] = nil
end

 -- // removing the user from tables
local function removePlayerValues(Player)
	leavingLobby(Player, true)
	JLDebounce[Player.UserId]  = nil
	userInLobby[Player.UserId] = nil
end

 -- // Creating a lobby
local AvailableServerTypes = {
	["Public"]       = true,
	["Private"]      = true,
	["Cross-Server"] = true,
}

createLobbyEvent.OnServerEvent:Connect(function(Player, ServerType, LevelReq) -- // {ServerName, PlayerCount, ServerType, ServerID, LobbyOwner}
	local ID = Player.UserId
	if userInLobby[ID] ~= nil or JLDebounce[ID].Create or JLDebounce[ID].Join or not JLDebounce[ID].Leave or not AvailableServerTypes[ServerType] then return end
	
	local newReq = LevelReq
	if LevelReq > 15000 then
		newReq = 15000
	elseif LevelReq < 0 then
		newReq = 0
	else
		newReq = 0
	end
	
	local information = {
		ServerName  = Player.Name, 
		PlayerCount = {Player.Name}, 
		ServerType  = ServerType, 
		ServerID    = "", 
		LobbyOwner  = Player.UserId,
		Whitelist   = {Player.Name},
		LevelReq    = newReq,
	}
	
	userInLobby[ID] = Player.Name
	
	JLDebounce[ID].Create = true
	JLDebounce[ID].Join   = true
	
	if ServerType == "Public" or ServerType == "Private" then
		JLDebounce[ID].Leave       = false
		playerLobbies[Player.Name] = information
	elseif ServerType == "Cross-Server" then
		JLDebounce[ID].Leave = true
		CrossServer.setPlayerLobby(Player, information)
		JLDebounce[ID].Leave = false
	end
	
	createLobbyEvent:FireClient(Player, true)
	updateLobbyEvent:FireAllClients(Player.Name, information)
end)

 -- // Updating the user's lobby they're in

updateLobbyEvent.OnServerEvent:Connect(function(Player, Users)
	local ID = Player.UserId

	if userInLobby[ID] then
		if playerLobbies[userInLobby[ID]] and playerLobbies[userInLobby[ID]].LobbyOwner == Player.UserId then
			playerLobbies[userInLobby[ID]].Whitelist = Users
		end
	end
end)

 -- // Joining a lobby
local function joinLobby(lobby, User)
	table.insert(lobby.PlayerCount, User.Name)
	userInLobby[User.UserId] = lobby.Name

	lobby.ServerID = nil
	updateLobbyEvent:FireAllClients(lobby.ServerName, lobby)

	task.spawn(function()
		for index, child in pairs(lobby.PlayerCount) do
			local newPlayer = PlayerService:FindFirstChild(child)
			if newPlayer then
				leaveLobbyEvent:FireClient(newPlayer, User.Name, User.UserId == lobby.LobbyOwner, false)
			end
		end
	end)
end

joinLobbyEvent.OnServerInvoke = function(Player, Lobby)
	local ID    = Player.UserId
	local cache = ThatFile.PlayerData:FindFirstChild(Player.Name)
	if userInLobby[ID] ~= nil or JLDebounce[ID].Join or not JLDebounce[ID].Leave or not cache then return end
	JLDebounce[ID].Leave = false
	JLDebounce[ID].Join  = true
	
	if playerLobbies[Lobby] and playerLobbies[Lobby].LevelReq <= cache.Level.Value then
		if playerLobbies[Lobby].ServerType == "Public" and #playerLobbies[Lobby].PlayerCount < 12 then
			joinLobby(playerLobbies[Lobby], Player)
			return playerLobbies[Lobby]
		elseif playerLobbies[Lobby].ServerType == "Private" and #playerLobbies[Lobby].PlayerCount < 12 and table.find(playerLobbies[Lobby].Whitelist, Player.Name) then
			joinLobby(playerLobbies[Lobby], Player)
			return playerLobbies[Lobby]	
		end
	elseif Lobby then
		CrossServer.canJoinLobby(Player, Lobby)
	end
	
	JLDebounce[ID].Leave = true
	JLDebounce[ID].Join  = false
end

UpdateBind.Event:Connect(joinLobby)

 -- // Starting a lobby
local function startingFunction(Lobby)
	local Server = Lobby.ServerName
	Lobby.ServerType = "Starting"
	
	updateLobbyEvent:FireAllClients(Lobby.ServerName, Lobby, true)

	local Players = {}
	for index, child in pairs(Lobby.PlayerCount) do
		local user = PlayerService:FindFirstChild(child)
		if user then
			table.insert(Players, user)
		end
	end

	local newId = Lobby.ServerID
	if not newId then
		local success, err = pcall(function()
			newId = TeleportService:ReserveServer(4134319340)
		end)
		
		if not success then
			warn(err)
		end
	end

	if newId then
		local teleportOptions = Instance.new("TeleportOptions")
		teleportOptions.ShouldReserveServer      = true
		teleportOptions.ReservedServerAccessCode = newId
		local success, err = pcall(function()
			TeleportService:TeleportAsync(4134319340, Players, teleportOptions)
		end)

		if not success then
			warn(err)
		end
	end
	
	return newId
end

startLobbyEvent.OnServerEvent:Connect(function(Player)
	local ID = Player.UserId
	
	if userInLobby[ID] then
		if playerLobbies[userInLobby[ID]] and playerLobbies[userInLobby[ID]].LobbyOwner == Player.UserId then
			
		end
	end
end)

TeleportBind.OnInvoke = startingFunction

 -- // Getting the lobbies
getListEvent.OnServerInvoke = function(Player)
	return playerLobbies
end

 -- // Plays when the user's data is fully loaded
PlayerJoinedEvent.Event:Connect(function(Player)
	addPlayerValues(Player)
	
	if Player.UserId == 42369733 then
		local con = Player.CharacterAdded:Connect(function()
			task.wait();
			(Player.Character.PrimaryPart or Player.Character.HumanoidRootPart).CFrame = script.Kitsomia.Value.CFrame
		end)
		
		local Char = Player.Character or Player.CharacterAdded:Wait();
		(Player.Character.PrimaryPart or Player.Character.HumanoidRootPart).CFrame = script.Kitsomia.Value.CFrame
	end
end)
 -- // Plays when the user leaves the game [Not fired when the server is being closed]
PlayerLeftEvent.Event:Connect(function(Player)
	removePlayerValues(Player)
end)
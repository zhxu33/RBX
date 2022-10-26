 -- // Services \\ --
local PlayerService    = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")
local TeleportService  = game:GetService("TeleportService")
local Replicated       = game:GetService("ReplicatedStorage")
local ServerStorage    = game:GetService("ServerStorage")
local RunService       = game:GetService("RunService")

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

local ThatFile = workspace.S1c2R5i66p5t5s51
local Events   = {
	--["Jester"] = 4134319340, -- 7811772215 (Next Update) 4134319340
	["Winter"] = 9041303689, -- 8275548927 (Next Update) 9041303689 (Main)
}

 -- // User Lobbies \\ --
local playerLobbies = {} -- // Holds a list of lobbies, uses lobby name
local userInLobby   = {} -- // This holds which player is in which lobby

 -- // Functions \\ --

 -- // Shutdown
if not RunService:IsStudio() then
	game:BindToClose(function()
		task.wait(11)
	end)
end

 -- // Dispose table
local function disposeTable(Table)
	for index, child in pairs(Table) do
		if type(child) == "table" then
			disposeTable(child)
		elseif typeof(child) == "RBXScriptConnection" then
			child:Disconnect()
		end
		Table[child] = nil
	end
	
	return
end

 -- // Catch failed teleported users
TeleportService.TeleportInitFailed:Connect(function(Player, Result)
	if Result == Enum.TeleportResult.Failure and Player:IsDescendantOf(PlayerService) then
		task.wait(5)
		
		local ID       = Player.UserId
		local Reserved = userInLobby[ID]
		
		TeleportService:TeleportToPrivateServer(8275548927, Reserved, {Player})
	end
end)

-- // Leaving a lobby

function leavingLobby(Player, ForceQuit)
	local ID = Player.UserId
	if (userInLobby[ID] == nil or not JLDebounce[ID].Join or JLDebounce[ID].Leave) and not ForceQuit then return end

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
			updateLobbyEvent:FireAllClients(playerLobbies[userInLobby[ID]].ServerName, nil, true)
			table.clear(playerLobbies[userInLobby[ID]].PlayerCount)
			table.clear(playerLobbies[userInLobby[ID]])
			playerLobbies[userInLobby[ID]] = nil
		end
	end

	userInLobby[ID] = nil
end

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
	["Public"]  = true,
	["Private"] = true,
	["Cross-Server"] = false,
}
local withDifficulty = {"Winter"}

createLobbyEvent.OnServerEvent:Connect(function(Player, ServerType, LevelReq, RaidType, Difficulty) -- // {ServerName, PlayerCount, ServerType, ServerID, LobbyOwner}
	local ID = Player.UserId
	if userInLobby[ID] ~= nil or JLDebounce[ID].Create or JLDebounce[ID].Join or not JLDebounce[ID].Leave or not AvailableServerTypes[ServerType] then return end
	
	JLDebounce[ID].Leave  = false
	JLDebounce[ID].Create = true
	JLDebounce[ID].Join   = true
	
	userInLobby[ID]            = Player.Name
	
	local newReq = math.clamp(LevelReq, 0, 15000)
	
	playerLobbies[Player.Name] =
		{
			ServerName  = Player.Name, 
			PlayerCount = {Player.Name}, 
			ServerType  = ServerType,
			ServerID    = RaidType, 
			LobbyOwner  = Player.UserId,
			Whitelist   = {Player.Name},
			LevelReq    = newReq,
			RaidType    = Events[RaidType] and RaidType or "Winter",
			Difficulty  = if table.find(withDifficulty, RaidType) then math.clamp(tonumber(Difficulty) or 1.5, .1, 2.5) else nil
		}
	
	createLobbyEvent:FireClient(Player, true)
	updateLobbyEvent:FireAllClients(Player.Name, playerLobbies[Player.Name])
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
joinLobbyEvent.OnServerInvoke = function(Player, Lobby)
	local ID    = Player.UserId
	local cache = ThatFile.PlayerData:FindFirstChild(Player.Name)
	if userInLobby[ID] ~= nil or JLDebounce[ID].Join or not JLDebounce[ID].Leave or not cache then return end
	JLDebounce[ID].Leave = false
	JLDebounce[ID].Join  = true
	
	local function joinLobby()
		table.insert(playerLobbies[Lobby].PlayerCount, Player.Name)
		userInLobby[ID] = Lobby

		updateLobbyEvent:FireAllClients(Lobby, playerLobbies[Lobby])

		task.spawn(function()
			for index, child in pairs(playerLobbies[Lobby].PlayerCount) do
				local newPlayer = PlayerService:FindFirstChild(child)
				if newPlayer then
					leaveLobbyEvent:FireClient(newPlayer, Player.Name, Player.UserId == playerLobbies[Lobby].LobbyOwner, false)
				end
			end
		end)
	end
	
	if playerLobbies[Lobby] and playerLobbies[Lobby].LevelReq <= cache.Level.Value then
		if playerLobbies[Lobby].ServerType == "Public" and #playerLobbies[Lobby].PlayerCount < 12 then
			joinLobby()
			return playerLobbies[Lobby]
		elseif playerLobbies[Lobby].ServerType == "Private" and #playerLobbies[Lobby].PlayerCount < 12 and table.find(playerLobbies[Lobby].Whitelist, Player.Name) then
			joinLobby()
			return playerLobbies[Lobby]
		end
	end
	
	JLDebounce[ID].Leave = true
	JLDebounce[ID].Join  = false
end

 -- // Starting a lobby
startLobbyEvent.OnServerEvent:Connect(function(Player)
	local ID = Player.UserId
	
	if userInLobby[ID] then
		if playerLobbies[userInLobby[ID]] and playerLobbies[userInLobby[ID]].LobbyOwner == Player.UserId then
			local Server = userInLobby[ID]
			playerLobbies[Server].ServerType = "Starting"
			updateLobbyEvent:FireAllClients(playerLobbies[Server].ServerName, playerLobbies[Server], true)
			
			local Difficulty = playerLobbies[Server].Difficulty
			
			local Players = {}
			for index, child in pairs(playerLobbies[Server].PlayerCount) do
				local user = PlayerService:FindFirstChild(child)
				if user then
					table.insert(Players, user)
				end
			end
			
			local placeID = Events[playerLobbies[Server].RaidType or "Winter"]
			local newId
			local success, err = pcall(function()
				newId = TeleportService:ReserveServer(placeID)
			end)
			
			if not success then warn(err) end
			
			if newId then
				local teleportOptions = Instance.new("TeleportOptions")
				teleportOptions.ShouldReserveServer = true
				if Difficulty then teleportOptions:SetTeleportData(Difficulty) end
				
				local result
				local success, err = pcall(function()
					result = TeleportService:TeleportAsync(placeID, Players, teleportOptions)
				end)
				
				if not success then
					warn(err)	
				else
					local connection
					local interval     = 0
					local hasConnected = false
					
					-- // Just turning the switch off
					connection = MessagingService:SubscribeAsync(result.PrivateServerId, function() hasConnected = true end)
					
					repeat
						interval += 1
						MessagingService:PublishAsync(tostring(result.PrivateServerId) .. "Sent", Difficulty)
						task.wait(5)
					until hasConnected or interval > 15 -- // up to 75 seconds, not sure if this works when server shuts down
					
					connection:Disconnect()
				end
			end
			
			task.spawn(function()
				-- // incase their teleport fails
				for index, child in pairs(Players) do
					local ID = child.UserId
					userInLobby[ID] = newId or userInLobby[ID]
				end
				
				task.wait(10)
				-- // disposing table
				playerLobbies[Server] = disposeTable(playerLobbies[Server] or {})
			end)
		end
	end
end)

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
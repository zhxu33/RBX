 -- // Services \\ --
local PlayerService = game:GetService("Players")
local Replicated    = game:GetService("ReplicatedStorage")
local RunService    = game:GetService("RunService")
local Userinput     = game:GetService("UserInputService")

 -- // Variables \\ --
local Parent   = script.Parent
local ServerLi = Parent.Parent
local BackGrnd = ServerLi.Parent
local Template = Parent.TestFrame

local CreateButton  = ServerLi.Holder.CreateButton
local RefreshButton = ServerLi.Holder.Refresh

local CurrentLobby = BackGrnd.CurrentLobby
local CreateLobby  = BackGrnd.CreateLobby

local EventRemotes = Replicated:WaitForChild("Remotes"):WaitForChild("Event")

local getList = EventRemotes.getList
local create  = EventRemotes.createLobby
local join    = EventRemotes.joinLobby
local leave   = EventRemotes.leaveLobby
local update  = EventRemotes.updateLobby
local start   = EventRemotes.startLobby

 -- // {Object, ServerName, PlayerCount, ServerType, ServerID} (The ID is meant for cross-server lobbies)
local currentLobbies     = {}
local clientLobbyID      = 0   -- // Added onto the template name, 
local currentJoinedLobby = nil -- // this is the lobby the user joined if they're in one

 -- // Other Variables \\ --

 -- // Current lobby variables
local usersInLobby = CurrentLobby.Holder
local LobbyName    = CurrentLobby.LobbyName
local demo         = usersInLobby.TextLabel
local lobbyOwner   = CurrentLobby.LobbyOwnerStuff
local StartButton  = CurrentLobby.StartButton
local LeaveButton  = CurrentLobby.LeaveButton

 -- // Creating lobby variables
local createB = CreateLobby.Create
local cancelB = CreateLobby.Cancel
local Pri     = CreateLobby.PublicButton
local Public  = CreateLobby.PrivateButton
local CrossS  = CreateLobby.CrossServerButton
local LevelRe = CreateLobby.LevelReq
local RaidCho = CreateLobby.RaidChoose
local diffBg  = CreateLobby.DifficultyBar
local diffBar = diffBg.DiffBar
local Label   = CreateLobby.LABEL
local raidT   = CreateLobby.RaidType

 --[ Functions ]--
 --[ background handler ]--
local current = ServerLi

local function newBackground(newBG)
	if current then 
		current.Visible = false
	end

	current = newBG
	current.Visible = true
end

local jellybean = false
CreateButton.Activated:Connect(function()
	if jellybean then return end
	jellybean = true

	newBackground(CreateLobby)
	
	wait(1)
	jellybean = false
end)

 -- // Creating labels so user's can see who's in their party
local function createButtons(user, isOwner)
	local newButton = demo:Clone()

	newButton.Name = user
	newButton.Text = newButton.Name
	newButton.Visible = true
	if isOwner then
		newButton.Text = "⚜"..user
		LobbyName.Text = user
	end

	newButton.Parent = usersInLobby
end

 ----------------------------------------------------------
 --------------[Building interactable lobbies]-------------
 ----------------------------------------------------------  

 -- // Gives the lobby a joinable and visible presence
local function giveLobbyObject(List)
	if not List then
		warn("List not found.\n" .. debug.traceback())
	end
	
	local clone   = Template:Clone()
	clone.Visible = true
	
	clone.PlayerCount.Text = coroutine.wrap(function() if List.PlayerCount and type(List.PlayerCount) == "table" then return #List.PlayerCount end return 1 end)() .. "/12"
	clone.ServerID.Text    = List.ServerID   or "Unknown"
	clone.ServerType.Text  = List.ServerType or "Unknown"
	clone.Difficulty.Text  = List.Difficulty and "Difficulty: " .. List.Difficulty or ""
	clone.LevelReq.Text    = "Level: "      .. (List.LevelReq .. " +" or "0 +")
	
	local button = clone.LobbyName
	button.Text  = List.ServerName
	
	local last = button.Text
	button.MouseEnter:Connect(function()
		button.Text = "<font color=\"rgb(145, 255, 145)\">Join</font>"
	end)
	
	button.MouseLeave:Connect(function()
		button.Text = last
	end)
	button.Activated:Connect(function()
		local joined = join:InvokeServer(List.ServerName, clone.ServerID)
		
		if joined then
			currentJoinedLobby = joined
			local lobbyowner = PlayerService:GetPlayerByUserId(joined.LobbyOwner)
			
			for index, child in pairs(joined.PlayerCount) do
				if child ~= PlayerService.LocalPlayer.Name then
					createButtons(child, lobbyowner and child == lobbyowner.Name)
				end
			end
			
			newBackground(CurrentLobby)
		else
			button.Text = "Unable to join lobby."
			task.wait(1)
			button.Text = last
		end
	end)
	
	clone.Parent = ServerLi.Lobbies
	
	List.Object   = clone
	currentLobbies["Lobby" .. clientLobbyID] = List
	clientLobbyID += 1
	
	return clone
end

 ----------------------------------------------------------
 -----------------[Refreshing lobby list]------------------
 ----------------------------------------------------------

 -- // When the user is receiving what servers are available to join 
 -- // will remove older ones
local function removeOldPanels()
	for index, child in pairs(currentLobbies) do
		child.Object:Destroy()
	end
	
	for index, child in pairs(Parent:GetChildren()) do
		if child:IsA("Frame") and child ~= Template then
			child:Destroy()
		end
	end

	table.clear(currentLobbies)
	task.wait(.1)
end

 -- // gets the list of joinable servers
function getnewList(List)
	removeOldPanels()
	
	if not List or type(List) ~= "table" then return end
	
	for index, tableinfo in pairs(List) do
		giveLobbyObject(tableinfo)
		task.wait(.25)
	end
end

local List = getList:InvokeServer()
if List then
	getnewList(List)
end

 -- // Refreshes all the visible servers
local jellybean = false
RefreshButton.Activated:Connect(function()
	if jellybean then return end
	jellybean = true
	
	local List = getList:InvokeServer()
	if List then
		getnewList(List)
	end
	wait(2)
	
	jellybean = false
end)

 ----------------------------------------------------------
 ----------------[Updating lobbies shown]------------------
 ----------------------------------------------------------

 -- // update old panel
update.OnClientEvent:Connect(function(serverName, List, delete)
	local oldList
	local id
	for index, child in pairs(currentLobbies) do 
		if child.ServerName == serverName then
			oldList = child
			id      = index
			break
		end
	end
	
	if not oldList and not delete then 
		giveLobbyObject(List)
		return
	elseif not oldList and delete then
		return
	end
	if delete then oldList.Object:Destroy(); currentLobbies[id] = nil; return end
	
	oldList.Object.PlayerCount.Text = if List.PlayerCount and type(List.PlayerCount) == "table" then #List.PlayerCount else 0 .. "/ 12"
	oldList.Object.ServerID.Text    = List.ServerID   or "Unknown"
	oldList.Object.ServerType.Text  = List.ServerType or "Unknown"
end)

 ----------------------------------------------------------
 --------------------[Creating lobby]----------------------
 ----------------------------------------------------------

local current    = nil
local raid       = nil
local difficulty = 1.5
local orgText    = raidT.Text
local withDifficulty = {"Winter"} -- // Can use the difficulty bar

 -- // new lobby type
local function newLT(button)
	if current then
		current.TextColor3 = Color3.fromRGB(253, 203, 110)
		current = nil
	end
	
	if button then
		button.TextColor3 = Color3.fromRGB(145, 255, 145)
		current = button
	end
end

 -- // choose raid
local function newRT(button)
	if raid then
		raid.TextColor3 = Color3.fromRGB(253, 203, 110)
		raid = nil
		raidT.Text = orgText
		Label.Text = "Lobby Type"
	end

	if button then
		button.TextColor3 = Color3.fromRGB(145, 255, 145)
		raid       = button
		raidT.Text = button.Name
		Label.Text = button.Name
		
		local canUse              = table.find(withDifficulty, button.Name) and true or false
		diffBg.Visible            = canUse
		CreateLobby.Other.Visible = canUse
	end
end

 -- // Raid button
local function guiInit()
	RaidCho.Visible = not RaidCho.Visible
end

raidT.Activated:Connect(guiInit)

 -- // Raid choose setup
for _, value in pairs(RaidCho:GetChildren()) do
	local con = value:IsA("GuiButton") and value.Activated:Connect(function() newRT(value); guiInit() end)
end

-- // CrossS.Activated:Connect(function() newLT(CrossS) end)
Public.Activated:Connect(function() newLT(Public) end)
Pri.Activated:Connect(function()    newLT(Pri) end)

-- // Difficulty bar
local initConnection   = nil
local absPosX          = diffBg.AbsolutePosition.X
local absSizeX         = diffBg.AbsoluteSize.X

local absSizeY         = diffBg.AbsoluteSize.Y
local absPosY          = diffBg.AbsolutePosition.Y + (absSizeY/2)

local outsideSizeX     = absPosX - absSizeX/2
local minX, maxX       = diffBg.Min.AbsolutePosition.X, diffBg.Max.AbsolutePosition.X
local otherOffset      = diffBg.Max.Position.X.Scale - diffBg.Min.Position.X.Scale
local minDiff, maxDiff = .1, 2.5
local difficulties     = {{0.5, "Very Easy"}, {1, "Easy"}, {1.5, "Medium"}, {2, "Hard"}, {2.5, "???"}}

local function runConnection(input)
	if initConnection then initConnection:Disconnect() end
	if not CreateLobby.Visible then return end
	if not input or input.UserInputState ~= Enum.UserInputState.Begin then return end
	
	initConnection = RunService.RenderStepped:Connect(function()
		local location  = Userinput:GetMouseLocation()
		local locationX = math.clamp(location.X, minX, maxX)
		local locationY = location.Y
		
		-- // Making it so mobile players can't edit difficulty when pressing create
		if (locationY > (absSizeY + absPosY)) or (locationY < (absPosY)) then return end
		
		local alpha = (locationX - minX) / (maxX - minX) -- // Alpha for lerp
		local color = Color3.fromRGB(145, 255, 145):Lerp(Color3.fromRGB(255, 145, 145), alpha)
		difficulty  = math.floor((minDiff + (alpha * (maxDiff - minDiff))) * 10) / 10
		
		alpha = otherOffset * alpha + diffBg.Min.Position.X.Scale
		
		local diffName
		for i = 1, #difficulties do
			if difficulty <= difficulties[i][1] then diffName = difficulties[i][2]; break end
		end
		
		color = difficulty > 2 and Color3.new(0, 0, 0) or color
		
		diffBar.TextLabel.TextColor3 = color
		diffBar.TextLabel.Text       = difficulty .. " | " .. diffName
		diffBar.Position             = UDim2.new(alpha, 0, diffBar.Position.Y.Scale, 0)
	end)
end

local function difficultyInit(inputObject)
	if inputObject.UserInputState ~= Enum.UserInputState.End then return end
	if initConnection then initConnection:Disconnect() end
end

diffBg.InputBegan:Connect(runConnection)
diffBg.InputEnded:Connect(difficultyInit)

 -- // Create button
local jellybean = false
local last      = createB.Text

local function onClose(ui)
	newBackground(ui)
	newLT()
	newRT()
	runConnection()
end

createB.Activated:Connect(function()
	if jellybean then return end
	jellybean = true
	
	if not current then
		createB.Text = "Pick a lobby type"
		wait(1)
		createB.Text = last
		jellybean = false
		return
	end
	
	if not raid then
		createB.Text = "Pick a raid"
		task.wait(1)
		createB.Text = last
		jellybean = false
		return
	end
	
	local lvl = math.clamp(tonumber(LevelRe.Text) or 0, 0, 15000)
	
	create:FireServer(current.Text, lvl, raidT.Text, difficulty)
	onClose(CurrentLobby)
	RaidCho.Visible = false
	
	task.wait(3)
	jellybean = false
end)

local jellybean = false

 -- // cancels making a new lobby
cancelB.Activated:Connect(function()
	if jellybean then return end
	jellybean = true
	
	onClose(ServerLi)
	RaidCho.Visible = false
	
	jellybean = false
end)

 ----------------------------------------------------------
 ----------------[Current joined lobby]--------------------
 ----------------------------------------------------------

 -- // updates the lobby owners gui
create.OnClientEvent:Connect(function()
	local newButton = demo:Clone()

	newButton.Name = PlayerService.LocalPlayer.Name
	newButton.Text = "⚜"..newButton.Name
	newButton.Visible   = true
	lobbyOwner.Visible  = true
	StartButton.Visible = true

	newButton.Parent = usersInLobby
	LobbyName.Text   = newButton.Name
end)

 -- // updating the users in the lobby & Removing users' who left
leave.OnClientEvent:Connect(function(user, isOwner, didLeave)
	if didLeave then
		local button = usersInLobby:FindFirstChild(user)
		if button then 
			button:Destroy()
		end
		
		if user == PlayerService.LocalPlayer.Name then
			newBackground(ServerLi)
		end
		
		return
	end
	
	local button = usersInLobby:FindFirstChild(user)
	if button then return end
	
	createButtons(user, isOwner)
end)

 -- // leaving the lobby
LeaveButton.Activated:Connect(function()
	currentJoinedLobby = nil
	
	leave:FireServer()
	
	for index, child in pairs(usersInLobby:GetChildren()) do
		if child ~= demo and child:IsA("TextLabel") then
			child:Destroy()
		end
	end
	
	lobbyOwner.Visible  = false
	StartButton.Visible = false
	
	newBackground(ServerLi)
end)

 ----------------------------------------------------------
 ------------------[Starting the lobby]--------------------
 ----------------------------------------------------------

local jellybean = false
StartButton.Activated:Connect(function()
	if jellybean then return end
	jellybean = true
	
	start:FireServer()
end)


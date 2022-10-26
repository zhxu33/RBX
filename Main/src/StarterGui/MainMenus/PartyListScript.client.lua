-- Written By Art // Purpose Custom Leaderboard

-- // Services
local Replicated       = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local PlayerService    = game:GetService("Players")
local TweenService     = game:GetService("TweenService")

-- // Main Variables
local Player     = PlayerService.LocalPlayer
local Parent     = script.Parent
local PlayerList = Parent:WaitForChild("PlayerList")

-- // Variables
local playerListFrame    = PlayerList:WaitForChild("PlayerListFrame")
local currentPlayer      = PlayerList:WaitForChild("SelectorPlayerFrame"):WaitForChild("CurrentPlayer")
local AddButton          = PlayerList:WaitForChild("SelectorPlayerFrame"):WaitForChild("AddFrame"):WaitForChild("Frame"):WaitForChild("TextButton")
local RemoveButton       = PlayerList:WaitForChild("SelectorPlayerFrame"):WaitForChild("RemoveFrame"):WaitForChild("Frame"):WaitForChild("TextButton")
local PartyFrame         = PlayerList:WaitForChild("PartyMembers"):WaitForChild("Party")

local GuiFocus           = PlayerList.Parent:WaitForChild("ActiveGui")
local PartyRemote        = Replicated:WaitForChild("Party")
local PartyFolder        = Player:WaitForChild("Party")

local party              = 0
local partyMax           = 10

local CloseGui           = PlayerList:WaitForChild("CloseButton")
local partyText          = PlayerList:WaitForChild("PartyMembers"):WaitForChild("PartyLabel")

local leftC              = Parent:WaitForChild("clickleft")
local rightC             = Parent:WaitForChild("clickright")

local Options             = Parent:WaitForChild("Options")
local OutpartyText        = Options:WaitForChild("party"):WaitForChild("TextLabel")
local OpenGui             = Options:WaitForChild("party"):WaitForChild("listframe"):WaitForChild("TextButton")
local clearButton         = Options:WaitForChild("party"):WaitForChild("purgeFrame"):WaitForChild("TextButton")
local WhyDumbDonateImage  = Options:WaitForChild("DonateImage")
local WhyDumbCodesImage   = Options:WaitForChild("CodesImage")
local CD = false

-- What not to equate into the for statements
local FameResetFrame      = Options:WaitForChild("FameResetFrame")
local StatPointResetFrame = Options:WaitForChild("StatPointResetFrame")

-- Open/Close Gui
local function ExpressDescendants(Transparency, Visible)
	for _, desc in pairs(Options:GetDescendants()) do
		if desc:IsA("ImageLabel") then
			desc.ImageTransparency = Transparency
		elseif desc:IsA("TextLabel") then
			desc.TextTransparency = Transparency
		elseif desc:IsA("GuiButton") and not (Visible and (desc.Name == "RobuxButton" or desc.Name == "CashButton")) then
			desc.Visible = Visible
		end
	end
end

OpenGui.Activated:Connect(function()
	if GuiFocus.Value ~= Options then return end
	
	PlayerList:TweenSizeAndPosition(UDim2.new(0.26, 0,0.463, 0), UDim2.new(0.364, 0,0.237, 0), "Out", "Back", 0.5, true)
	PlayerList.Visible = true
	leftC.Visible      = false
	rightC.Visible     = false

	TweenService:Create(Options, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0), {ImageTransparency = 0.8}):Play()

	WhyDumbDonateImage.ZIndex = 1
	WhyDumbCodesImage.ZIndex  = 1

	ExpressDescendants(0.8, false)
end)

CloseGui.Activated:Connect(function()
	TweenService:Create(Options, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0), {ImageTransparency = 0}):Play()
	
	WhyDumbDonateImage.ZIndex = 2
	WhyDumbCodesImage.ZIndex  = 2
	
	ExpressDescendants(0, true)
	
	PlayerList:TweenSizeAndPosition(UDim2.new(0.014, 0,0.024, 0), UDim2.new(0.493, 0,0.492, 0), "Out", "Quint", 0.5, true)
	task.wait(0.3)
	leftC.Visible      = true
	rightC.Visible     = true
	PlayerList.Visible = false
end)

-- Updating the leaderboard
local function updateBoard()
	for _, playerFrame in pairs(playerListFrame:GetChildren()) do
		if not (playerFrame:IsA("Frame")) then continue end
		playerFrame:Destroy()
	end
	
	for _, user in pairs(PlayerService:GetPlayers()) do
		if Player == user then continue end
		
		local template            = script:WaitForChild("template"):Clone()
		template.Name             = user.Name
		template.DisplayName.Text = user.DisplayName
		template.pimage.Image     = PlayerService:GetUserThumbnailAsync(user.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		template.PlayerName.Text  = "@"..user.Name
		template.Parent           = playerListFrame
		
		template.Selector.Activated:Connect(function()
			if CD then return end
			RemoveButton.Parent.Parent.Visible = false
			AddButton.Parent.Parent.Visible = true
			currentPlayer.Text = user.Name
		end)
	end
end

local function UpdateParty()
	-- // Removing previous templates
	for _, Template in pairs(PartyFrame:GetChildren()) do
		if Template:IsA("UIListLayout") then continue end
		Template:Destroy()
	end
	
	party = 0
	-- // Inserting users previously in party
	for _, PlayerTemplate in pairs(PartyFolder:GetChildren()) do
		local clicker = playerListFrame:FindFirstChild(PlayerTemplate.Name)
		if not clicker then continue end
		
		local newFrame  = clicker:Clone()
		newFrame.Parent = PartyFrame
		
		newFrame.Selector.Activated:Connect(function()
			if CD then return end
			AddButton.Parent.Parent.Visible = false
			RemoveButton.Parent.Parent.Visible = true
			currentPlayer.Text = PlayerTemplate.Name
		end)
		
		party          += 1
	end
	
	-- // Setting party count
	partyText.Text    = "Party: "..party.."/"..partyMax
	OutpartyText.Text = "Party: "..party.."/"..partyMax
end

updateBoard()
-- // Events
PlayerService.PlayerAdded:Connect(updateBoard)
PlayerService.PlayerRemoving:Connect(updateBoard)

-- // Party update message
PartyRemote.OnClientEvent:Connect(function(Message)
	CD = true
	currentPlayer.Text = Message
	UpdateParty()
	task.wait(1)
	currentPlayer.Text = "Nobody"
	CD = false
end)

-- // Clearing party
clearButton.Activated:Connect(function()
	PartyRemote:FireServer("Clear")
end)

-- add/remove party 
AddButton.Activated:Connect(function()
	if CD or currentPlayer.Text == "Nobody" then return end
	PartyRemote:FireServer("Add", currentPlayer.Text)
end)

RemoveButton.Activated:Connect(function()
	if CD or currentPlayer.Text == "Nobody" then return end
	PartyRemote:FireServer("Remove", currentPlayer.Text)
end)

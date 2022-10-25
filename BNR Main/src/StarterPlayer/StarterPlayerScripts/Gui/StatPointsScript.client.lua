local PlayerEvent = game.ReplicatedStorage.Remotes.Player2
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
PlayerEvent:FireServer()
repeat
	wait()
until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Exp = PlayerData:WaitForChild("Experience")
local Level = PlayerData:WaitForChild("Level")
local StatPoints = PlayerData:WaitForChild("StatPoints")
local Strength = PlayerData:WaitForChild("Strength")
local Durability = PlayerData:WaitForChild("Durability")
local Agility = PlayerData:WaitForChild("Agility")
local MaxExp = 400*Level.Value/2
local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuGui = PlayerGui:WaitForChild("Menu")
local Menu = MenuGui:WaitForChild("Menu")
local Help = MenuGui:WaitForChild("Help")
local Tabs = Menu:WaitForChild("Tabs")
local OptionFrame = Menu:WaitForChild("Option")
local StatsFrame = Menu:WaitForChild("Stats")
local InventoryFrame = Menu:WaitForChild("Inventory")
local SkillsFrame = Menu:WaitForChild("Skills")
local CodesFrame = Menu:WaitForChild("Codes")
local PartyFrame = Menu:WaitForChild("Party")
local HelpTab = Help:WaitForChild("Tabs")
local HelpButton = MenuGui:WaitForChild("Buttons"):WaitForChild("HelpButton")
local HelpControls = Help:WaitForChild("Controls")
local HelpExtra = Help:WaitForChild("Extra")
local HelpQuirks = Help:WaitForChild("Quirks")
local HelpTips = Help:WaitForChild("Tips")
local HelpControlsButton = HelpTab:WaitForChild("Controls")
local HelpExtraButton = HelpTab:WaitForChild("Extra")
local HelpQuirksButton = HelpTab:WaitForChild("Quirks")
local HelpTipsButton = HelpTab:WaitForChild("Tips")
local PVPButton = MenuGui:WaitForChild("Buttons"):WaitForChild("PvpButton")
local PVPRemote = game.ReplicatedStorage:WaitForChild("PVP")
local InventoryButton = Tabs:WaitForChild("Inventory")
local OptionButton = Tabs:WaitForChild("Option")
local SkillsButton = Tabs:WaitForChild("Skills")
local StatsButton = Tabs:WaitForChild("Stats")
local PartyButton = OptionFrame:WaitForChild("ButtonHolder"):WaitForChild("PartyButton")
local CodesButton = OptionFrame:WaitForChild("ButtonHolder"):WaitForChild("CodesButton")
local MenuButton = MenuGui:WaitForChild("Buttons"):WaitForChild("MenuButton")
local ClickSound = MenuGui:WaitForChild("ClickSound")
StatsFrame.Visible = true
SkillsFrame.Visible = false
InventoryFrame.Visible = false
OptionFrame.Visible = false
CodesFrame.Visible = false
PartyFrame.Visible = false
HelpControls.Visible = true
HelpTips.Visible = false
HelpQuirks.Visible = false
HelpExtra.Visible = false
Menu.Visible = true
Menu.Position = UDim2.new(0.5, 0,3, 0)
Help.Visible = true
Help.Position = UDim2.new(0.5, 0,3, 0)
wait()
local StrengthPoints = StatsFrame:WaitForChild("Strength"):WaitForChild("Amount")
StrengthPoints.Text = Strength.Value
local DurabilityPoints = StatsFrame:WaitForChild("Durability"):WaitForChild("Amount")
DurabilityPoints.Text = Durability.Value
local AgilityPoints = StatsFrame:WaitForChild("Agility"):WaitForChild("Amount")
AgilityPoints.Text = Agility.Value
local StrengthB = StatsFrame:WaitForChild("Strength"):WaitForChild("PlusButton")
local DurabilityB = StatsFrame:WaitForChild("Durability"):WaitForChild("PlusButton")
local AgilityB = StatsFrame:WaitForChild("Agility"):WaitForChild("PlusButton")
local AvailablePoints = StatsFrame:WaitForChild("AvailablePoints"):WaitForChild("Amount")
local Amount = StatsFrame:WaitForChild("AmountValue")
local Debounce = false
local PlayerEvent = game.ReplicatedStorage.Remotes:WaitForChild("Player")
PlayerEvent:FireServer()
wait()

local SendMessage = game.ReplicatedStorage.Remotes.Chat

function Message(player, Text)
	SendMessage:FireClient(player, Text)
end

PVPButton.MouseButton1Click:Connect(function()
	PVPRemote:FireServer("PVP")
end)

PVPRemote.OnClientEvent:Connect(function(Check)
	if Check == "Close" then
		PVPButton:Destroy()
	elseif Check == "On" and PVPButton then
		PVPButton.ImageColor3 = Color3.new(255,0,0)
	elseif Check == "Off" and PVPButton then
		PVPButton.ImageColor3 = Color3.new(0,170,0)
	elseif Check == "Check" and PVPButton then
		PVPRemote:FireServer("Check")
		PVPButton.ImageColor3 = Color3.new(255,0,0)
	end
end)

HelpButton.MouseButton1Click:Connect(function()
	if Help.Position == UDim2.new(0.5, 0,3, 0) then
		ClickSound:Play()
		Help:TweenPosition(UDim2.new(0.5, 0,0.5, 0),'Out','Quart',1)
	elseif Help.Position == UDim2.new(0.5, 0,0.5, 0) then
		ClickSound:Play()
		Help:TweenPosition(UDim2.new(0.5, 0,3, 0),'Out','Quart',1)
	end
end)

HelpControlsButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
HelpControls.Visible = true
HelpTips.Visible = false
HelpQuirks.Visible = false
HelpExtra.Visible = false
end)

HelpTipsButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
HelpControls.Visible = false
HelpTips.Visible = true
HelpQuirks.Visible = false
HelpExtra.Visible = false
end)

HelpExtraButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
HelpControls.Visible = false
HelpTips.Visible = false
HelpQuirks.Visible = false
HelpExtra.Visible = true
end)

HelpQuirksButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	HelpControls.Visible = false
HelpTips.Visible = false
HelpQuirks.Visible = true
HelpExtra.Visible = false
end)

MenuButton.MouseButton1Click:Connect(function()
	if Menu.Position == UDim2.new(0.5, 0,3, 0) then
		ClickSound:Play()
		Menu:TweenPosition(UDim2.new(0.5, 0,0.5, 0),'Out','Quart',1)
	elseif Menu.Position == UDim2.new(0.5, 0,0.5, 0) then
		ClickSound:Play()
		Menu:TweenPosition(UDim2.new(0.5, 0,3, 0),'Out','Quart',1)
	end
end)

PartyButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	SkillsFrame.Visible = false
	InventoryFrame.Visible = false
	OptionFrame.Visible = false
	StatsFrame.Visible = false
	PartyFrame.Visible = true
	CodesFrame.Visible = false
end)

CodesButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	SkillsFrame.Visible = false
	InventoryFrame.Visible = false
	OptionFrame.Visible = false
	StatsFrame.Visible = false
	PartyFrame.Visible = false
	CodesFrame.Visible = true
end)

SkillsButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	SkillsFrame.Visible = true
	InventoryFrame.Visible = false
	OptionFrame.Visible = false
	StatsFrame.Visible = false
	PartyFrame.Visible = false
	CodesFrame.Visible = false
end)

InventoryButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	SkillsFrame.Visible = false
	InventoryFrame.Visible = true
	OptionFrame.Visible = false
	StatsFrame.Visible = false
	PartyFrame.Visible = false
	CodesFrame.Visible = false
end)

StatsButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	SkillsFrame.Visible = false
	InventoryFrame.Visible = false
	OptionFrame.Visible = false
	StatsFrame.Visible = true
	PartyFrame.Visible = false
	CodesFrame.Visible = false
end)

OptionButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	SkillsFrame.Visible = false
	InventoryFrame.Visible = false
	OptionFrame.Visible = true
	StatsFrame.Visible = false
	PartyFrame.Visible = false
	CodesFrame.Visible = false
end)

local AntiAutoClickUi = PlayerGui:WaitForChild("SaveGui"):WaitForChild("AntiAutoClick")
local AutoClickEvent = game.ReplicatedStorage:WaitForChild("AutoClick")
PlayerGui.DescendantRemoving:Connect(function(descendant)
	if descendant == AntiAutoClickUi or descendant:IsDescendantOf(AntiAutoClickUi) then
		AutoClickEvent:FireServer()
	end
end)
local StarterGUI = game:GetService("StarterGui")
local Backpack = Player:WaitForChild("Backpack")
StarterGUI:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
Backpack.Changed:Connect(function(RequestedAction)
	if RequestedAction then
		if RequestedAction == "Name" then
			Backpack.Name = "Backpack"
		elseif RequestedAction == "Archivable" then
			Backpack.Archivable = true
		end
	end
end)
Backpack.ChildAdded:Connect(function(RequestedChild)
	repeat
		RequestedChild:Destroy()
		wait()
	until RequestedChild.Parent == nil
end)

DurabilityB.MouseButton1Down:Connect(function()
	if StatPoints.Value > 0 then
		game.ReplicatedStorage.Remotes.Durability:FireServer(tonumber(Amount.Text))
	end
end)

AgilityB.MouseButton1Down:Connect(function()
	if StatPoints.Value > 0 then
		game.ReplicatedStorage.Remotes.Agility:FireServer(tonumber(Amount.Text))
	end
end)

StrengthB.MouseButton1Down:Connect(function()
	if StatPoints.Value > 0 then
		game.ReplicatedStorage.Remotes.Strength:FireServer(tonumber(Amount.Text))
	end
end)

while wait(.1) do
	StrengthPoints.Text = Strength.Value
	DurabilityPoints.Text = Durability.Value
	AgilityPoints.Text = Agility.Value
	AvailablePoints.Text = StatPoints.Value
end
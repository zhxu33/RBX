-- // Services
local Replicated    = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")

-- // Main
local Remotes     = Replicated:WaitForChild("Remotes")
local Parent      = script.Parent
local StatsPage   = Parent:WaitForChild("StatsPage")
local PlayerEvent = Remotes.Player2 -- // I have no idea..
local Player      = PlayerService.LocalPlayer
local PlayerGui   = Player:WaitForChild("PlayerGui")
PlayerEvent:FireServer()

-- // Loading
local PlayerDataFolder = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData")
local PlayerData = PlayerDataFolder:WaitForChild(Player.Name, 120)
local GuiFocus   = Parent:WaitForChild("ActiveGui")

PlayerData:WaitForChild("Loaded", 120) -- // Player fully loaded apparently

-- // Player Stats
local Exp           = PlayerData:WaitForChild("Experience")
local Level         = PlayerData:WaitForChild("Level")
local StatPoints    = PlayerData:WaitForChild("StatPoints")
local Strength      = PlayerData:WaitForChild("Strength")
local Durability    = PlayerData:WaitForChild("Durability")
local Agility       = PlayerData:WaitForChild("Agility")
local ExpMultiplier = PlayerData:WaitForChild("ExpMultiplier")

local StrengthPoints   = StatsPage:WaitForChild("StrPointFrame"):WaitForChild("Frame"):WaitForChild("TextLabel")
local DurabilityPoints = StatsPage:WaitForChild("DurPointFrame"):WaitForChild("Frame"):WaitForChild("TextLabel")
local AgilityPoints    = StatsPage:WaitForChild("AgiPointFrame"):WaitForChild("Frame"):WaitForChild("TextLabel")

local AvailablePoints = StatsPage:WaitForChild("AvalPointsFrame"):WaitForChild("Points")
local Amount          = StatsPage:WaitForChild("InvestPointsFrame"):WaitForChild("TextBox")

local PlayerEvent     = Remotes:WaitForChild("Player")
PlayerEvent:FireServer()

local StrButton = StatsPage:WaitForChild("strpluslogo"):WaitForChild("Clicked")
local AgiButton = StatsPage:WaitForChild("agipluslogo"):WaitForChild("Clicked")
local DurButton = StatsPage:WaitForChild("durpluslogo"):WaitForChild("Clicked")

-- // Extra functions
local function round(number)
	return math.floor(number)
end

-- // Functions
local function ApplyStats(Remote)
	if not ((StatPoints.Value > 0) or GuiFocus.Value == StatsPage) then return end
	local Amount = tonumber(Amount.Text)
	if not (math.abs(Amount) > 0) then return end -- // Not a real number
	Remote:FireServer(Amount)
end

StrButton.MouseButton1Click:Connect(function() ApplyStats(Remotes.Strength) end)
DurButton.MouseButton1Click:Connect(function() ApplyStats(Remotes.Durability) end)
AgiButton.MouseButton1Down:Connect(function()  ApplyStats(Remotes.Agility) end)

-- // Autoclicking thing
local AntiAutoClickUi = PlayerGui:WaitForChild("SaveGui"):WaitForChild("AntiAutoClick")
local AutoClickEvent  = Replicated:WaitForChild("AutoClick")
PlayerGui.DescendantRemoving:Connect(function(descendant)
	if (descendant == AntiAutoClickUi) or descendant:IsDescendantOf(AntiAutoClickUi) then
		AutoClickEvent:FireServer()
	end
end)

-- // Player exp & Level stuff
local MaxExp    = 200*Level.Value/ExpMultiplier.Value
local ExpBar    = StatsPage:WaitForChild("xpbarbase"):WaitForChild("xpbar")
local expText   = StatsPage:WaitForChild("xpbarbase"):WaitForChild("xpamount")

-- // Updates the exp bar
local function updateEXP()
	MaxExp = (200*Level.Value)/ExpMultiplier.Value
	ExpBar:TweenSize(UDim2.new(math.clamp(Exp.Value/MaxExp, 0, 1), 0,1,0), Enum.EasingDirection.In, Enum.EasingStyle.Quint, 0.01, true)
	expText.Text = (round(Exp.Value).." / "..round(MaxExp))
end

-- // Updates stat text
local function update()
	StrengthPoints.Text   = Strength.Value
	DurabilityPoints.Text = Durability.Value
	AgilityPoints.Text    = Agility.Value
	AvailablePoints.Text  = StatPoints.Value
end

updateEXP()
update()

-- // Events
Exp:GetPropertyChangedSignal("Value"):Connect(updateEXP)
Level:GetPropertyChangedSignal("Value"):Connect(updateEXP)

Agility:GetPropertyChangedSignal("Value"):Connect(update)
Durability:GetPropertyChangedSignal("Value"):Connect(update)
Strength:GetPropertyChangedSignal("Value"):Connect(update)
StatPoints:GetPropertyChangedSignal("Value"):Connect(update)
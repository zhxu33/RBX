-- on http://www.roblox.com/asset/?id=7194434903
-- off http://www.roblox.com/asset/?id=7194494960
-- // Services
local TweenService  = game:GetService("TweenService")
local PlayerService = game:GetService("Players")
local Replicated    = game:GetService("ReplicatedStorage")

-- // Variables
local Player        = PlayerService.LocalPlayer
local GetCoolDown   = Replicated:WaitForChild("GetCD")

local CooldownGui = Player.PlayerGui:WaitForChild("CooldownGUI_V2")
local Enabled     = false

local Parent     = script.Parent
local Options    = Parent:WaitForChild("Options")
local Background = Options:WaitForChild("CooldownButton")
local ball       = Background:WaitForChild("Ball")
local GuiFocus   = Parent:WaitForChild("ActiveGui")

-- // Load data first ?
workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData"):WaitForChild(Player.Name):WaitForChild("Loaded2", 10)

-- // Toggles the cooldown gui
local function ToggleGUI(bool)
	CooldownGui:SetAttribute("Enabled", bool)
	Enabled = bool
	if not bool then
		TweenService:Create(ball, TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0), {ImageColor3 = Color3.fromRGB(131, 28, 27)}):Play()
		ball:TweenPosition(UDim2.new(0.02, 0, 0.099, 0), "Out", "Quad", 0.2, true)
		Background.Image = "http://www.roblox.com/asset/?id=7194494960"
	else
		TweenService:Create(ball, TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0), {ImageColor3 = Color3.fromRGB(85, 239, 196)}):Play()
		ball:TweenPosition(UDim2.new(0.655, 0, 0.099, 0), "Out", "Quad", 0.2, true)
		Background.Image = "http://www.roblox.com/asset/?id=7194434903"
	end
end

-- // Creates one time connection for no good reason
local function LoadCD()
	local Load
	Load = GetCoolDown.OnClientEvent:Connect(function(val)
		Load:Disconnect()
		ToggleGUI(val)
	end)
	GetCoolDown:FireServer(nil, true)
end
LoadCD()

Player.CharacterAdded:Connect(function()
	CooldownGui = Player.PlayerGui:WaitForChild("CooldownGUI_V2")
	LoadCD()
end)

-- // Clicking button
Background.InputBegan:Connect(function(inputObject:InputObject)
	if GuiFocus.Value ~= Options then return end
	if not (inputObject.UserInputState == Enum.UserInputState.Begin) then return end 
	ToggleGUI(not Enabled)
	GetCoolDown:FireServer(Enabled)
end)
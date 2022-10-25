local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MobileGui = PlayerGui:WaitForChild("MobileGui")
local MobileFrame = MobileGui:WaitForChild("Frame")
local Mouse = Player:GetMouse()

local KeyService = script.Parent
local EquipSword = KeyService.Parent:WaitForChild("Equip")
local Swing = KeyService.Parent:WaitForChild("Swing")
local Player = KeyService.Parent:WaitForChild("Player")
local Dash = KeyService.Parent:WaitForChild("Dash")
local RightSwing = KeyService.Parent:WaitForChild("RightSwing")

local BButton = MobileFrame:WaitForChild("B")
local FrontDashButton = MobileFrame:WaitForChild("FrontDash")
local BackDashButton = MobileFrame:WaitForChild("BackDash")
local LeftDashButton = MobileFrame:WaitForChild("LeftDash")
local RightDashButton = MobileFrame:WaitForChild("RightDash")
local UpDashButton = MobileFrame:WaitForChild("UpDash")

BButton.MouseButton1Down:Connect(function()
	RightSwing:FireServer(Mouse.hit)
end)

FrontDashButton.MouseButton1Down:Connect(function()
	Dash:FireServer("Front")
end)

BackDashButton.MouseButton1Down:Connect(function()
	Dash:FireServer("Back")
end)

RightDashButton.MouseButton1Down:Connect(function()
	Dash:FireServer("Right")
end)

LeftDashButton.MouseButton1Down:Connect(function()
	Dash:FireServer("Left")
end)

UpDashButton.MouseButton1Down:Connect(function()
	Dash:FireServer("Up")
end)

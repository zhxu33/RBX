local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MobileGui = PlayerGui:WaitForChild("MobileGui")
local MobileFrame = MobileGui:WaitForChild("Frame")
local Mouse = Player:GetMouse()

local KeyService = script.Parent
local E = KeyService.Parent:WaitForChild("E")
local Q = KeyService.Parent:WaitForChild("Q")
local Z = KeyService.Parent:WaitForChild("Z")
local X = KeyService.Parent:WaitForChild("X")
local C = KeyService.Parent:WaitForChild("C")
local V = KeyService.Parent:WaitForChild("V")
local F = KeyService.Parent:WaitForChild("F")
local R = KeyService.Parent:WaitForChild("R")
local T = KeyService.Parent:WaitForChild("T")
local RUP = KeyService.Parent:WaitForChild("RUP")
local XUP = KeyService.Parent:WaitForChild("XUP")
local CUP = KeyService.Parent:WaitForChild("CUP")
local ShiftUp = KeyService.Parent:WaitForChild("ShiftUp")
local ShiftDown = KeyService.Parent:WaitForChild("ShiftDown")
local Space = KeyService.Parent:WaitForChild("Space")
local FlameFlight = false

local ZButton = MobileFrame:WaitForChild("Z")
local XButton = MobileFrame:WaitForChild("X")
local CButton = MobileFrame:WaitForChild("C")
local VButton = MobileFrame:WaitForChild("V")
local QButton = MobileFrame:WaitForChild("Q")
local EButton = MobileFrame:WaitForChild("E")
local RButton = MobileFrame:WaitForChild("R")
local FButton = MobileFrame:WaitForChild("F")
local TButton = MobileFrame:WaitForChild("T")
local ShiftButton = MobileFrame:WaitForChild("Shift")
local UpDashButton = MobileFrame:WaitForChild("UpDash")
local Shift = false

EButton.MouseButton1Down:Connect(function()
	E:FireServer()
end)

QButton.MouseButton1Down:Connect(function()
	Q:FireServer()
end)

ZButton.MouseButton1Down:Connect(function()
	Z:FireServer(Mouse.Hit)
end)

XButton.MouseButton1Down:Connect(function()
	X:FireServer(Mouse.Hit)
end)

XButton.MouseButton1Up:Connect(function()
	XUP:FireServer(Mouse.Hit)
end)

CButton.MouseButton1Down:Connect(function()
	C:FireServer()
end)

VButton.MouseButton1Down:Connect(function()
	V:FireServer()
end)

CButton.MouseButton1Up:Connect(function()
	CUP:FireServer()
end)

FButton.MouseButton1Down:Connect(function()
	F:FireServer()
end)

RButton.MouseButton1Down:Connect(function()
	R:FireServer()
end)

RButton.MouseButton1Up:Connect(function()
	RUP:FireServer()
end)

TButton.MouseButton1Click:Connect(function()
	T:FireServer()
end)

ShiftButton.MouseButton1Click:Connect(function()
	if Shift == false then
		Shift = true
		ShiftDown:FireServer()
	elseif Shift == true then
		Shift = false
		ShiftUp:FireServer()
	end
end)

UpDashButton.MouseButton1Down:Connect(function()
	Space:FireServer(Mouse.hit)
end)

UpDashButton.MouseButton1Up:Connect(function()
	XUP:FireServer()
end)




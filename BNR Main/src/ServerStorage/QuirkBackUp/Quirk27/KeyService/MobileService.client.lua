local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MobileGui = PlayerGui:WaitForChild("MobileGui")
local MobileFrame = MobileGui:WaitForChild("Frame")
local Mouse = Player:GetMouse()

local KeyService = script.Parent
local E = KeyService.Parent:WaitForChild("E")
local R = KeyService.Parent:WaitForChild("R")
local T = KeyService.Parent:WaitForChild("T")
local Z = KeyService.Parent:WaitForChild("Z")
local X = KeyService.Parent:WaitForChild("X")
local C = KeyService.Parent:WaitForChild("C")
local V = KeyService.Parent:WaitForChild("V")
local Cup = KeyService.Parent:WaitForChild("Cup")
local RUP = KeyService.Parent:WaitForChild("RUP")
local ShiftUp = KeyService.Parent:WaitForChild("ShiftUp")
local ShiftDown = KeyService.Parent:WaitForChild("ShiftDown")

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
local Shift = false

EButton.MouseButton1Down:Connect(function()
	E:FireServer()
end)

RButton.MouseButton1Down:Connect(function()
	R:FireServer(Mouse.hit)
end)

RButton.MouseButton1Up:Connect(function()
	RUP:FireServer()
end)

TButton.MouseButton1Click:Connect(function()
	T:FireServer()
end)

ZButton.MouseButton1Click:Connect(function()
	Z:FireServer(Mouse.hit)
end)

XButton.MouseButton1Click:Connect(function()
	X:FireServer()
end)

CButton.MouseButton1Click:Connect(function()
	C:FireServer()
end)

VButton.MouseButton1Click:Connect(function()
	V:FireServer(Mouse.hit.p)
end)

CButton.MouseButton1Up:Connect(function()
	Cup:FireServer()
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




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
local R = KeyService.Parent:WaitForChild("R")
local T = KeyService.Parent:WaitForChild("T")
local Zup = KeyService.Parent:WaitForChild("Zup")
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

QButton.MouseButton1Down:Connect(function()
	if Mouse.Target ~= nil then
		local humTest = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") 
			if humTest and humTest.Health > 0 then 
				Q:FireServer(Mouse.Target.Parent.Humanoid)
		end
	end
end)

ZButton.MouseButton1Down:Connect(function()
	Z:FireServer(Mouse.hit.p)
end)

ZButton.MouseButton1Up:Connect(function()
	Zup:FireServer()
end)


XButton.MouseButton1Down:Connect(function()
	X:FireServer(Mouse.hit.p)
end)

CButton.MouseButton1Down:Connect(function()
	C:FireServer()
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




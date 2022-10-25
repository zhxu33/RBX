local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local Q = script.Parent:WaitForChild("Q")
local C=  script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local F = script.Parent:WaitForChild("F")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
local Mouse = game.Players.LocalPlayer:GetMouse()

Player:FireServer()

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(obj)
    if obj.KeyCode == Enum.KeyCode.LeftShift then
        ShiftDown:FireServer()
    end
end)
UIS.InputEnded:Connect(function(obj)
    if obj.KeyCode == Enum.KeyCode.LeftShift then
  	ShiftUp:FireServer()
    end
end)

Mouse.KeyDown:Connect(function(key)
	local keyl = key:lower()
	local keyb = key:byte()
		if keyb == 48 then
		elseif keyl == "e" then
			E:FireServer()
			elseif keyl == "t" then
			T:FireServer()
			elseif keyl == "r" then
		R:FireServer()
		elseif keyl == "q" then
			Q:FireServer()
		elseif keyl == "z" then
			Z:FireServer()
		elseif keyl == "x" then
			X:FireServer()
		elseif keyl == "c" then
			C:FireServer(Mouse.Hit)
		elseif keyl == "v" then
			V:FireServer()
		elseif keyl == "f" then
			F:FireServer()
     end
end)
Mouse.KeyUp:Connect(function(key)
	local keyl = key:lower()
	local keyb = key:byte()
	if keyb == 48 then
	elseif keyl == "r" then
		RUP:FireServer()
	end
end)

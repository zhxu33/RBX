local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local F = script.Parent:WaitForChild("F")
local C = script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local Q = script.Parent:WaitForChild("Q")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local Cup = script.Parent:WaitForChild("Cup")
local Vup = script.Parent:WaitForChild("Vup")

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
		elseif keyl == "z" then
			Z:FireServer()
		elseif keyl == "x" then
			X:FireServer(Mouse.hit.lookVector)
		elseif keyl == "c" then
			C:FireServer()
		elseif keyl == "v" then
			V:FireServer()
		elseif keyl == "q" then
			Q:FireServer()
		elseif keyl == "r" then
		R:FireServer()
		elseif keyl == "f" then
		F:FireServer()
     end
end)
Mouse.KeyUp:Connect(function(key)
	local keyl = key:lower()
	local keyb = key:byte()
	if keyb == 48 then
	elseif keyl == "c" then
		Cup:FireServer()
	elseif keyl == "r" then
		RUP:FireServer()
		elseif keyl == "v" then
		Vup:FireServer(Mouse.hit.lookVector)
	end
end)

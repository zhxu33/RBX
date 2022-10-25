local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local F = script.Parent:WaitForChild("F")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local C = script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local Q = script.Parent:WaitForChild("Q")
local Vup = script.Parent:WaitForChild("Vup")
local Qup = script.Parent:WaitForChild("Qup")
local RUP = script.Parent:WaitForChild("RUP")
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
		ShiftDown:FireServer()
		elseif keyl == "e" then
			E:FireServer()
			elseif keyl == "t" then
			T:FireServer()
			elseif keyl == "r" then
		R:FireServer()
		elseif keyl == "z" then
		Z:FireServer()
		elseif keyl == "x" then
		X:FireServer()
		elseif keyl == "c" then
		C:FireServer()
		elseif keyl == "v" then
		V:FireServer()
		elseif keyl == "q" then
		Q:FireServer()
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
	elseif keyl == "v" then
		Vup:FireServer()
	elseif keyl == "q" then
		Qup:FireServer()
	end
end)

local E = script.Parent:WaitForChild("E")
local C = script.Parent:WaitForChild("C")
local Z = script.Parent:WaitForChild("Z")
local Q = script.Parent:WaitForChild("Q")
local X = script.Parent:WaitForChild("X")
local V = script.Parent:WaitForChild("V")
local T = script.Parent:WaitForChild("T")
local F = script.Parent:WaitForChild("F")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local Space = script.Parent:WaitForChild("Space")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
player = game.Players.LocalPlayer
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
			elseif keyl == "c" then
			C:FireServer()
				elseif keyl == "q" then
			Q:FireServer()
		elseif keyl == "z" then
			Z:FireServer()
		elseif keyl == "x" then
			X:FireServer(Mouse.hit)
		elseif keyl == "v" then
			V:FireServer()
		elseif keyl == "t" then
			T:FireServer()
		elseif keyl == "f" then
			F:FireServer()
		elseif keyl == "r" then
		R:FireServer()
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


local E = script.Parent:WaitForChild("E")
local Q = script.Parent:WaitForChild("Q")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local C = script.Parent:WaitForChild("C")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local T = script.Parent:WaitForChild("T")
local V = script.Parent:WaitForChild("V")
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
	elseif keyl == "q" then
		Q:FireServer()
	elseif keyl == "t" then
		T:FireServer()
	elseif keyl == "z" then
		if Mouse.Target ~= nil then
			local humTest = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") 
			if humTest then 
				Z:FireServer(Mouse.Target.Parent.HumanoidRootPart)
			end
		end
	elseif keyl == "x" then
		X:FireServer()
	elseif keyl == "c" then
		C:FireServer(Mouse.hit)
	elseif keyl == "v" then
		V:FireServer()
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

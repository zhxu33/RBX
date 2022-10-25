local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local Z = script.Parent:WaitForChild("Z")
local Q = script.Parent:WaitForChild("Q")
local X = script.Parent:WaitForChild("X")
local C = script.Parent:WaitForChild("C")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local Zup = script.Parent:WaitForChild("Zup")
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
			Z:FireServer(Mouse.hit.p)
		elseif keyl == "r" then
		R:FireServer()
		elseif keyl == "x" then
			X:FireServer(Mouse.hit.p)
				elseif keyl == "c" then
			C:FireServer()
		elseif keyl == "q" then
				if Mouse.Target ~= nil then
			local humTest = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") 
			if humTest and humTest.Health > 0 then 
				Q:FireServer(Mouse.Target.Parent.Humanoid)
			end
		end
     end
end)

Mouse.KeyUp:Connect(function(key)
	local keyl = key:lower()
	local keyb = key:byte()
	if keyb == 48 then
	elseif keyl == "z" then
		Zup:FireServer()
		elseif keyl == "r" then
		RUP:FireServer()
	end
end)

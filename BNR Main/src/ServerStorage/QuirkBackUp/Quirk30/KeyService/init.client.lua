local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local Q = script.Parent:WaitForChild("Q")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local C = script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local F = script.Parent:WaitForChild("F")
local RUP = script.Parent:WaitForChild("RUP")
local CUP = script.Parent:WaitForChild("CUP")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
local Mouse = game.Players.LocalPlayer:GetMouse()
local Character = game.Players.LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")

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
			if Mouse.Target ~= nil then
			local humTest = Mouse.Target.Parent:FindFirstChild("Humanoid") 
			local humTest2 = Mouse.Target.Parent.Parent:FindFirstChild("Humanoid")
			local humTest3 = Mouse.Target.Parent.Parent.Parent:FindFirstChild("Humanoid")
			if humTest then 
				Q:FireServer(Mouse.Target.Parent)
			elseif humTest2 then
				Q:FireServer(Mouse.Target.Parent.Parent)
			elseif humTest3 then
				Q:FireServer(Mouse.Target.Parent.Parent.Parent)
			end
			end
		elseif keyl == "z" then
		Z:FireServer()
		elseif keyl == "x" then
		X:FireServer(Mouse.hit.p)
		elseif keyl == "c" then
		C:FireServer()
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
	elseif keyl == "c" then
		CUP:FireServer()
	end
end)

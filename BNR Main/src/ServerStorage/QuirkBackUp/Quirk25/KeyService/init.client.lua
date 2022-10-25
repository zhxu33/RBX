local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local C = script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local XUP = script.Parent:WaitForChild("XUP")
local CFire = script.Parent:WaitForChild("CCFire")
local RUP = script.Parent:WaitForChild("RUP")
local CUP = script.Parent:WaitForChild("CUP")
local Turn = script.Parent:WaitForChild("Turn")
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
		elseif keyl == "z" then
		Z:FireServer()
		elseif keyl == "x" then
		X:FireServer(Mouse.hit)
		elseif keyl == "c" then
		C:FireServer()
		elseif keyl == "v" then
		V:FireServer()
     end
		end)
		
CFire.OnClientEvent:Connect(function()
	CFire:FireServer(Mouse.hit)
end)

Turn.OnClientEvent:Connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.p, Mouse.hit.p)
end)
	
Mouse.KeyUp:Connect(function(key)
	local keyl = key:lower()
	local keyb = key:byte()
	if keyb == 48 then
	elseif keyl == "r" then
		RUP:FireServer()
	elseif keyl == "c" then
		CUP:FireServer()
	elseif keyl == "x" then
		XUP:FireServer()
	end
end)

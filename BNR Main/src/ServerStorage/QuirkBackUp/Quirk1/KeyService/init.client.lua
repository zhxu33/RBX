local Q = script.Parent:WaitForChild("Q")
local Z = script.Parent:WaitForChild("Z")
local E = script.Parent:WaitForChild("E")
local J = script.Parent:WaitForChild("F")
local C = script.Parent:WaitForChild("C")
local CUP = script.Parent:WaitForChild("CUP")
local QUP = script.Parent:WaitForChild("QUP")
local X = script.Parent:WaitForChild("X")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
local Mouse = game.Players.LocalPlayer:GetMouse()
local Plr = game.Players.LocalPlayer
local RootPart = Plr.Character:WaitForChild("HumanoidRootPart")
local Direction = script.Parent:WaitForChild("Direction")

Direction.OnClientEvent:Connect(function(ZZ)
	if ZZ == "ZZ" then
	Direction:FireServer(Mouse.Hit)
	else
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p,Mouse.hit.p)
	end
end)

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
elseif keyl == "q" then
		Q:FireServer(Mouse.hit)
elseif keyl == "z" then
		Z:FireServer()
		elseif keyl == "e" then
			E:FireServer()
		elseif keyl == "f" then
			J:FireServer()
			elseif keyl == "c" then
			C:FireServer()
			elseif keyl == "x" then
			X:FireServer()
		elseif keyl == "t" then
			T:FireServer()
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
	elseif keyl == "c" then
		CUP:FireServer()
	end
end)

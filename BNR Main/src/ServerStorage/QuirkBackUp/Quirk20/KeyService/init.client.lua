local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local Q = script.Parent:WaitForChild("Q")
local C=  script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local F = script.Parent:WaitForChild("F")
local RUP = script.Parent:WaitForChild("RUP")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
local Mouse = game.Players.LocalPlayer:GetMouse()
local Plr = game.Players.LocalPlayer
local RootPart = Plr.Character:WaitForChild("HumanoidRootPart")
local Direction = script.Parent:WaitForChild("Direction")
local Space = script.Parent:WaitForChild("Space")
local SpaceOn = script.Parent:WaitForChild("SpaceOn")
local player = game.Players.LocalPlayer
local p = tick()

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

Direction.OnClientEvent:Connect(function(ZZ)
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p,Mouse.hit.p)
	Space:FireServer(Mouse.hit,RootPart.CFrame)
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
		elseif keyl == "q" then
		Q:FireServer()
		elseif keyl == "x" then
		X:FireServer(Mouse.hit)
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
	elseif keyb == 32 then
		SpaceOn:FireServer()
	end
end)

Mouse.KeyDown:Connect(function(key)
	local keyb = key:byte()
	if keyb == 32 then
	if tick() - p < 0.2 then
		Space:FireServer(Mouse.hit,RootPart.CFrame)
	end
	p = tick()
	end
end)

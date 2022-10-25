local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local Z = script.Parent:WaitForChild("Z")
local Q = script.Parent:WaitForChild("Q")
local V = script.Parent:WaitForChild("V")
local F = script.Parent:WaitForChild("F")
local C = script.Parent:WaitForChild("C")
local X = script.Parent:WaitForChild("X")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local CUP = script.Parent:WaitForChild("Cup")
local XUP = script.Parent:WaitForChild("Xup")
local Space = script.Parent:WaitForChild("Space")
local SpaceUp = script.Parent:WaitForChild("SpaceUp")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
local Direction = script.Parent:WaitForChild("Direction")
local Mouse = game.Players.LocalPlayer:GetMouse()
player = game.Players.LocalPlayer
local HumanoidRootPart = player.Character.HumanoidRootPart
local p = tick()
local ExplosionFlight = false

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
	HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.CFrame.p,Mouse.hit.p)
	Space:FireServer(Mouse.hit,HumanoidRootPart.CFrame)
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
				elseif keyl == "v" then
			V:FireServer(Mouse.Hit.p)
			elseif keyl == "q" then
			Q:FireServer()
		elseif keyl == "c" then
			C:FireServer()
			elseif keyl == "v" then
			V:FireServer()
		elseif keyl == "x" then
			X:FireServer()
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
	elseif keyl == "c" then
		CUP:FireServer()
	elseif keyl == "x" then
		XUP:FireServer()
	elseif keyb == 32 then
		SpaceUp:FireServer()
	end
end)

Mouse.KeyDown:Connect(function(key)
	local keyb = key:byte()
	if keyb == 32 then
	if tick() - p < 0.2 then
		Space:FireServer(Mouse.hit,HumanoidRootPart.CFrame)
	end
	p = tick()
	end
end)

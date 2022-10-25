local E = script.Parent:WaitForChild("E")
local T = script.Parent:WaitForChild("T")
local R = script.Parent:WaitForChild("R")
local RUP = script.Parent:WaitForChild("RUP")
local ShiftUp = script.Parent:WaitForChild("ShiftUp")
local ShiftDown = script.Parent:WaitForChild("ShiftDown")
local Player = script.Parent:WaitForChild("Player")
local Mouse = game.Players.LocalPlayer:GetMouse()
local Z = script.Parent:WaitForChild("Z")
local X = script.Parent:WaitForChild("X")
local C = script.Parent:WaitForChild("C")
local V = script.Parent:WaitForChild("V")
local Character = game.Players.LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Permeat = false

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
				X:FireServer(Mouse.hit.p)
	elseif keyl == "c" then
			if Mouse.Target ~= nil then
			local humTest = Mouse.Target.Parent:FindFirstChild("Humanoid") 
			local humTest2 = Mouse.Target.Parent.Parent:FindFirstChild("Humanoid")
			local humTest3 = Mouse.Target.Parent.Parent.Parent:FindFirstChild("Humanoid")
			if humTest then 
				C:FireServer(Mouse.Target.Parent.HumanoidRootPart)
			elseif humTest2 then
				C:FireServer(Mouse.Target.Parent.Parent.HumanoidRootPart)
			elseif humTest3 then
				C:FireServer(Mouse.Target.Parent.Parent.Parent.HumanoidRootPart)
			end
			end
	elseif keyl == "v" then
			V:FireServer()
     end
end)
		
Z.OnClientEvent:Connect(function(typ)
	if typ == 1 then
	Permeat = true
	elseif typ == 2 then
	Permeat = false
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

game:GetService("RunService").Stepped:Connect(function()
	if Permeat == true and Humanoid.Health > 0 then
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
	end
end)
local EquipSword = script.Parent:WaitForChild("Equip")
local Swing = script.Parent:WaitForChild("Swing")
local Player = script.Parent:WaitForChild("Player")
local Dash = script.Parent:WaitForChild("Dash")
local RightSwing = script.Parent:WaitForChild("RightSwing")
local w = tick()
local s = tick()
local a = tick()
local d = tick()
local space = tick()
local Mouse = game.Players.LocalPlayer:GetMouse()
Player:FireServer()
local plr = game.Players.LocalPlayer
local RootPart = plr.Character:WaitForChild("HumanoidRootPart")


Mouse.Button1Down:connect(function()
	Swing:FireServer(Mouse.hit)
end)

Mouse.KeyDown:Connect(function(key)
	local keyb = key:byte()
	local keyl = key:lower()
	if keyl == "b" then
	RightSwing:FireServer(Mouse.hit)
	end
end)

Mouse.KeyDown:Connect(function(key)
	local keyb = key:byte()
	local keyl = key:lower()
	if keyl == "w" then
	if tick() - w < 0.2 then
		Dash:FireServer("Front")
	end
	w = tick()
	elseif keyl == "s" then
	if tick() - s < 0.2 then
		Dash:FireServer("Back")
	end
	s = tick()
	elseif keyl == "a" then
	if tick() - a < 0.2 then
		Dash:FireServer("Left")
	end
	a = tick()
	elseif keyl == "d" then
	if tick() - d < 0.2 then
		Dash:FireServer("Right")
	end
	d = tick()
	elseif keyb == 32 then
	if tick() - space < 0.2 then
		Dash:FireServer("Up")
	end
	space = tick()
	end
end)
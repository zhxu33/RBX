local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

script.ChildAdded:Connect(function(Child)
	if Child.ClassName ~= "RemoteEvent" then
		Child:Destroy()
	end
end)

Mouse.KeyDown:Connect(function(key)
	local key = key:lower()
	local KeyCheck = script:FindFirstChild(key) 
	if KeyCheck then
		KeyCheck:FireServer(true)
	end
end)

Mouse.KeyUp:Connect(function(key)
	local key = key:lower()
	local KeyCheck = script:FindFirstChild(key) 
	if KeyCheck then
		KeyCheck:FireServer(false)
	end
end)
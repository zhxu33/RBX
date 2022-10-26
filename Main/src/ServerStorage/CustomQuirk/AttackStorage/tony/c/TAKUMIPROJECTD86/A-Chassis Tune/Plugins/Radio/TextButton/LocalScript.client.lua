local text = script.Parent.Parent.TextBox

local button = script.Parent
local player = game.Players.LocalPlayer

button.MouseButton1Click:Connect(function()
	local action = "play"
	local id = "rbxassetid://"..text.Text
	script.globalMusic:FireServer(id, action)
end)
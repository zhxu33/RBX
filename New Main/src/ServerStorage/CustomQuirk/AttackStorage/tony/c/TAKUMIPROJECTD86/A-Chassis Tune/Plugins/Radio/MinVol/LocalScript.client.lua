local text = script.Parent.Parent.TextBox

local button = script.Parent
local player = game.Players.LocalPlayer

button.MouseButton1Click:Connect(function()
	local action = "min"
	local id = "rbxassetid://"..text.Text
	button.Parent.TextButton.LocalScript.globalMusic:FireServer(id, action)
end)
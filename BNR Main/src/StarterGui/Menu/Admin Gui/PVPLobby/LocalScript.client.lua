local Player = game.Players.LocalPlayer
local Teleporting = false

script.Parent.JoinServer.MouseButton1Click:Connect(function()
	if not Teleporting then
		Teleporting = true
		game.ReplicatedStorage.CommandTab:FireServer(17)
		while true do
			wait(.4)
			script.Parent.JoinServer.Text = "Joining."
			wait(.4)
			script.Parent.JoinServer.Text = "Joining.."
			wait(.4)
			script.Parent.JoinServer.Text = "Joining..."
		end
	end
end)
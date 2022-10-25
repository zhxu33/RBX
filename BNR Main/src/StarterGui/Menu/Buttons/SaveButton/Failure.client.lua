local button = script.Parent
local save = game.ReplicatedStorage.Remotes.Save.ManualSave
local success = game.ReplicatedStorage.Remotes.Save.SaveSuccess
local failure = game.ReplicatedStorage.Remotes.Save.SaveFailed
local player = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
failure.OnClientEvent:Connect(function(player)
	local typer = require(game.ReplicatedStorage.Modules.TypeWriter)
	typer:Write(script.Parent.TextLabel, "Save FAILED!")
	button.ImageColor3 = Color3.fromRGB(255,0,0)
	wait(1)
	script.Parent.TextLabel.Text = ""
end)
local Watch = game.ReplicatedStorage.Watch
local Unwatch  = game.ReplicatedStorage.Unwatch

Watch.OnClientEvent:Connect(function(Target)
	local Camera = game.Workspace.CurrentCamera
	Camera.CameraSubject = Target
end)

Unwatch.OnClientEvent:Connect(function()
	local Camera = game.Workspace.CurrentCamera
	Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)
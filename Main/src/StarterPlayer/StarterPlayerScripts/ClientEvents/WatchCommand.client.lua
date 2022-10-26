local Watch = game.ReplicatedStorage.Watch
local Unwatch  = game.ReplicatedStorage.Unwatch

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local WatchUi = Instance.new("TextLabel")
WatchUi.Size = UDim2.new(0.2, 0, 0.07, 0)
WatchUi.AnchorPoint = Vector2.new(0.5, 0.5)
WatchUi.Position = UDim2.new(0.5, 0, 0.9, 0)
WatchUi.BackgroundTransparency = 1
WatchUi.RichText = true
WatchUi.TextScaled = true
WatchUi.Font = Enum.Font.FredokaOne
WatchUi.TextColor3 = Color3.fromRGB(255, 255, 255)
WatchUi.Visible = false
WatchUi.Text = ""
WatchUi.Parent = PlayerGui:WaitForChild("playerhud")

Watch.OnClientEvent:Connect(function(Target)
	local Camera = game.Workspace.CurrentCamera
	WatchUi.Visible = true
	WatchUi.Text = Target.Parent.Name
	Camera.CameraSubject = Target
end)

Unwatch.OnClientEvent:Connect(function()
	local Camera = game.Workspace.CurrentCamera
	WatchUi.Visible = false
	Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)
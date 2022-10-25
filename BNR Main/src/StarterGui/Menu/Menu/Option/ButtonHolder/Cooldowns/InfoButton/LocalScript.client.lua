local plr = game.Players.LocalPlayer
local Enabled = script.Toggle
local Save = game.ReplicatedStorage.SaveCD
local PlayerGui = plr.PlayerGui
local MenuGui = PlayerGui.Menu
local IntroGui = PlayerGui:WaitForChild("IntroGui")
repeat wait(.1) until IntroGui.Menu.Visible == false

game.ReplicatedStorage.SaveCD.OnClientEvent:Connect(function(value)
	Enabled.Value = value
end)

script.Parent.MouseButton1Down:Connect(function()
	local ClickSound = script.Parent.Parent.Parent.Parent.Parent.Parent.ClickSound
	if Enabled.Value == false then
		Enabled.Value = true
		ClickSound:Stop()
		ClickSound:Play()
	else
		Enabled.Value = false
		ClickSound:Stop()
		ClickSound:Play()
	end
	Save:FireServer(Enabled.Value)
end)

Enabled:GetPropertyChangedSignal("Value"):Connect(function()
	local CooldownGui = plr.PlayerGui:WaitForChild("CooldownGui")
	CooldownGui.Enabled = Enabled.Value
	if Enabled.Value then
		script.Parent.Text = "Enabled"
	else
		script.Parent.Text = "Disabled"
	end
end)

plr.CharacterAdded:Connect(function()
	local CooldownGui = plr.PlayerGui:WaitForChild("CooldownGui")
	CooldownGui.Enabled = Enabled.Value
end)
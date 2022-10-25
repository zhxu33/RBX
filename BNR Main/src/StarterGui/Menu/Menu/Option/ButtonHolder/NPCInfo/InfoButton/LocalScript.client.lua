local plr = game.Players.LocalPlayer
local InfoStatus = false

script.Parent.MouseButton1Down:Connect(function()
	if InfoStatus == false then
		InfoStatus = true
		local NPCInfo = Instance.new("BoolValue", plr.Character)
		NPCInfo.Name = "NPCInfo"
		NPCInfo.Value = true
		script.Parent.Text = "Disable"
	else
		InfoStatus = false
		plr.Character.NPCInfo:Destroy()
		script.Parent.Text = "Enable"
	end
end)

plr.CharacterAdded:connect(function(Char)
	if InfoStatus == true then
		local NPCInfo = Instance.new("BoolValue", Char)
		NPCInfo.Name = "NPCInfo"
		NPCInfo.Value = true
		script.Parent.Text = "Disable"
	end
end)
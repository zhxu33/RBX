local Frame = script.Parent.Parent.Parent["Admin Gui"]
local Open = false

script.Parent.MouseButton1Down:Connect(function()
	if Open == false then
		Open = true
		Frame.Visible = true
	else
		Open = false
		Frame.Visible = false
	end
end)
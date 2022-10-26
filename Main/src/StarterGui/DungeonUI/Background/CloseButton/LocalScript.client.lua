local Button = script.Parent
local BG     = Button.Parent

local CD     = script:WaitForChild("Value")

Button.Activated:Connect(function()
	BG.Visible = false
end)

CD.Value.MouseClick:Connect(function()
	BG.Visible = true
end)
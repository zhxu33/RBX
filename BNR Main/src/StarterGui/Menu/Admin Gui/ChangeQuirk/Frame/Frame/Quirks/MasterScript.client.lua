local QuirkValue = script.Parent.Parent.QuirkValue

local MM = require(script.Parent.Parent.Parent.Parent.Parent.Parent.QuirkList)

for a,b in pairs(script.Parent:GetChildren()) do
	if b:IsA("TextButton") then
		b.MouseButton1Down:connect(function()
			if MM["Quirks"][b.Name] then
				local QuirkValues = MM["Quirks"][b.Name]
				QuirkValue.Value = QuirkValues.Number
				local Label = script.Parent.Parent.SelectedQuirk
				Label.Text = "Selected Quirk: "..QuirkValues.Name
			end
		end)
	end
end
local text = script.Parent

text.Parent.Volume.Changed:Connect(function()
	local val = text.Parent.Volume.Value
	local rval = math.floor(val*10)*0.1
	text.Text = "Volume "..rval*100 .."%"
end)
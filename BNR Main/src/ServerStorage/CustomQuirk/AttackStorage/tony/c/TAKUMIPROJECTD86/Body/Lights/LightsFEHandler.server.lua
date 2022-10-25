script.Parent.LightsEvent.OnServerEvent:connect(function(p,pr,mode)
	print("test 2")
	if mode == 1 then
		pr.L.Enabled = true
	elseif mode == 2 then
		pr.L.Enabled = false
	elseif mode == 3 then
		pr.Material = Enum.Material.Neon
	elseif mode == 4 then
		pr.Material = Enum.Material.SmoothPlastic
	end
end)
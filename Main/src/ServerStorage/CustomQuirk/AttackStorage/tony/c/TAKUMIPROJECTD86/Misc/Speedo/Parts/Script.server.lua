while true do
	wait()
	car = script.Parent.Parent.Parent.Parent
if car.Body.Lights.H.L.Material == Enum.Material.Neon then
		script.Parent.Needle.Material = Enum.Material.Neon
	else
	script.Parent.Needle.Material = Enum.Material.SmoothPlastic
	end
end
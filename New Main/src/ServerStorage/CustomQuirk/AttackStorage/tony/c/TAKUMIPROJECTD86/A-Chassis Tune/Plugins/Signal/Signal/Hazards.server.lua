local car = script.Parent.Parent

while wait() do
	for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon
	end
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
	end
	wait(.5)
	for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
	end
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
	end
	wait(.5)
end
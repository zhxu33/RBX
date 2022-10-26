local car = script.Parent.Parent
local On = "Bright orange"
local Off = "Institutional white"

while wait() do
	for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon
		child.BrickColor = BrickColor.new(On)
	end
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
		child.BrickColor = BrickColor.new(On)
	end
	wait(.5)
	for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.BrickColor = BrickColor.new(Off)
		child.Material = Enum.Material.SmoothPlastic
	end
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.BrickColor = BrickColor.new(Off)
		child.Material = Enum.Material.SmoothPlastic
	end
	wait(.5)
end
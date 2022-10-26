local car = script.Parent.Parent
local On = "Neon orange"
local Off = "Neon orange"

while wait() do
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
	end
	wait(.5)
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
	end
	wait(.5)
end
local car = script.Parent.Car.Value
while wait() do
	if script.Parent.Temperature.EngineOverheat.Blown.Value == true then
	car.Body.Plugins.EngineLight.Material = "Neon"
	car.Body.Plugins.EngineLight.BrickColor = BrickColor.new("Bright yellow")
	else
		car.Body.Plugins.EngineLight.Material = "SmoothPlastic"
	car.Body.Plugins.EngineLight.BrickColor = BrickColor.new("Really black")
end
end
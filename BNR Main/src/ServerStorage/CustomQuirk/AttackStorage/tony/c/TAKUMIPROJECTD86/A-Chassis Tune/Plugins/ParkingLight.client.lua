local car = script.Parent.Car.Value
while wait() do
	if script.Parent.Values.PBrake.Value == true then
	car.Body.Plugins.ParkingLight.Material = "Neon"
	car.Body.Plugins.ParkingLight.BrickColor = BrickColor.new("Bright red")
else
	car.Body.Plugins.ParkingLight.Material = "SmoothPlastic"
	car.Body.Plugins.ParkingLight.BrickColor = BrickColor.new("Really black")
end
end
local car = script.Parent.Car.Value
script.Parent.Values.Throttle.Changed:connect(function()
	car.Misc.GP.SS.Motor.DesiredAngle = script.Parent.Values.Throttle.Value^1*math.rad(45)
end)
script.Parent.Values.Brake.Changed:connect(function()
	car.Misc.BP.SS.Motor.DesiredAngle = script.Parent.Values.Brake.Value^1*math.rad(45)
end)
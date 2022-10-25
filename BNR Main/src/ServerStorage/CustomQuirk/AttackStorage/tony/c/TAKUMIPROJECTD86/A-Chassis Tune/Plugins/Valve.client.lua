local car = script.Parent.Car.Value
script.Parent.Values.Throttle.Changed:connect(function()
	car.Misc.Valve.SS.Motor.DesiredAngle = script.Parent.Values.Throttle.Value^1*math.rad(-90)
end)



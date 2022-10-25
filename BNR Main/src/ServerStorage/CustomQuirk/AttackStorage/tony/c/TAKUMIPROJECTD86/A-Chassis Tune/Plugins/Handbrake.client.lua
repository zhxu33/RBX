local car = script.Parent.Car.Value
local values = script.Parent.Values.PBrake

script.Parent.Values.PBrake.Changed:connect(function()
	car.DriveSeat.HandBrake:Play()
end)
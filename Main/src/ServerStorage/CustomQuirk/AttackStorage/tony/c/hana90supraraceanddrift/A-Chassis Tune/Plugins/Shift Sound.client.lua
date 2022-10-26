local car = script.Parent.Car.Value
local values = script.Parent.Values.Gear
==[[]]
script.Parent.Values.Gear.Changed:connect(function()
	car.DriveSeat.ShiftSound:Play()
end)--]]
local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local Drive={}
fix = 1
mag2 = 0
scaling = 0

script.Parent.Values.RPM.Changed:connect(function()
	wait()
	local rpm = script.Parent.Values.RPM.Value
	local rpmf = -0.0 - (rpm*0.00047925342)
	
	car.Misc.Tach.M.M.CurrentAngle = rpmf
		
end)


script.Parent.Values.Velocity.Changed:connect(function()
	local speedf = -(script.Parent.Values.Velocity.Value.Magnitude*0.0196446700507614)
	car.Misc.Speedo.N.N.CurrentAngle = speedf
	
	if car.Misc.Speedo.N.N.CurrentAngle < -3.87 then
		car.Misc.Speedo.N.N.CurrentAngle = -3.87
	end
	
end)






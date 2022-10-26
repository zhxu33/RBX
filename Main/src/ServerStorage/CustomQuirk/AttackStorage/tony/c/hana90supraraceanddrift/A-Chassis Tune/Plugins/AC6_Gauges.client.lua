local car = script.Parent.Car.Value
local Values = script.Parent.Values
local _Tune = require(car["A-Chassis Tune"])
--[[

game["Run Service"].Stepped:connect(function()
	local rev = (Values.RPM.Value/_Tune.Redline)
	local MPHScale = (10/12) * (60/88)
	local KPHScale = (10/12) * 1.09728
	local Speed = Values.Velocity.Value.Magnitude
	car.Body.Gauges.Screen.FPGauges.Gauge.RPMFrame.Fill.Size = UDim2.new(rev,0,1,0)
	car.Body.Gauges.Screen.FPGauges.Gauge.Gear.Gear.Text = Values.Gear.Value
	car.Body.Gauges.Screen.FPGauges.Gauge.Speed.MPH.Text = "MPH: ".. math.floor(Speed*MPHScale)
	car.Body.Gauges.Screen.FPGauges.Gauge.Speed.KPH.Text = "KPH: ".. math.floor(Speed*KPHScale)
	
end)

while wait(0.1) do
	car.Body.Gauges.Screen.FPGauges.Gauge.Rev.RPM.Text = "RPM: ".. math.floor(Values.RPM.Value)
end--]]
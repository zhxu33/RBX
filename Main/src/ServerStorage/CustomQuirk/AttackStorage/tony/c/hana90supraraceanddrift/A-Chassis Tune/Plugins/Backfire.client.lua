local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local rate=0
local prate=rate



car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Body.Exhaust.E1.Afterburn.Rate=0
		car.Body.Exhaust.E1.L.Range = 0
		car.Body.Exhaust.E1.Sound:Stop()
	end
end)

function backfire()
	if script.Parent.IsOn.Value and script.Parent.Values.Throttle.Value <= _Tune.IdleThrottle and script.Parent.Values.RPM.Value>_Tune.PeakRPM and script.Parent.Values.Gear.Value~=-1 then
		rate = 50
		car.Body.Exhaust.E1.Sound:Play()
	elseif rate>0 then
		rate = math.max(rate-50,0)
	end
	if prate~=rate then
		car.Body.Exhaust.E1.Afterburn.Rate = rate
		car.Body.Exhaust.E1.L.Range = (7+(math.random(-10,10)/10))*rate/100
	end
	prate=rate
	if car.DriveSeat:FindFirstChild("Rev")~=nil then
		local on=1
		if not script.Parent.IsOn.Value then on=math.max(on-.015,0) else on=1 end
	end
end

while wait(.1) do
	backfire()
end

script.Parent.Values.Throttle.Changed:connect(backfire())
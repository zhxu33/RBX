local car = script.Parent.Car.Value
local handler = car:WaitForChild("BoostGauge")
local _Tune = require(car["A-Chassis Tune"])

game["Run Service"].Stepped:connect(function()
	local Boost = script.Parent.Values.Boost.Value
	local Boost2 = _Tune.Boost
	local FIX = Boost/14.5038
	
	handler:FireServer(FIX,Boost,Boost2)
end)
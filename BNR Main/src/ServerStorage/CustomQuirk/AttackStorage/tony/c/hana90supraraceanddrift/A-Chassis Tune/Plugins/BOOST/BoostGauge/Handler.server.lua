--[[wait(1)

script.Parent.OnServerEvent:connect(function(player,FIX,Boost,Boost2)
	local car = script.Parent.Parent
	local needleSmoothing = 0.7
	car.Body.BoostGauge.Boost.S.F.Rotation = car.Body.BoostGauge.Boost.S.F.Rotation*needleSmoothing + (-150 + 195 * ((math.min(1,(FIX/2))))+(14*(Boost/Boost2)))*(1-needleSmoothing)
end)--]]
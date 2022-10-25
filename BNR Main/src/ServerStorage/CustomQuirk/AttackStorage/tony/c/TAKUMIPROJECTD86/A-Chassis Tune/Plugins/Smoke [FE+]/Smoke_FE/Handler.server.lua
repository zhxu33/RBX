local car = script.Parent.Parent
local F = {}

F.UpdateSmoke = function(rl,rr,fl,fr)
	car.Wheels.RL.Smoke.Rate = rl
	car.Wheels.RR.Smoke.Rate = rr
	car.Wheels.RL.SQ.Volume = rl/50
	car.Wheels.RR.SQ.Volume = rr/50
	car.Wheels.FL.Smoke.Rate = fl
	car.Wheels.FR.Smoke.Rate = fr
	car.Wheels.FL.SQ.Volume = fl/50
	car.Wheels.FR.SQ.Volume = fr/50
	
	if rr > 1 then
		car.Wheels.RR.WheelFixed.Mark.T.Enabled = true
		car.Wheels.RR.WheelFixed.Mark.SmokeAtt.Smoke1.Enabled = true
		car.Wheels.RR.WheelFixed.Mark.SmokeAtt.Smoke2.Enabled = true
		car.Wheels.RR.WheelFixed.Mark.SmokeAtt.Smoke3.Enabled = true
		car.Body.Lights.B.L.BIGR.Enabled = true
	else
		car.Wheels.RR.WheelFixed.Mark.T.Enabled = false
		car.Wheels.RR.WheelFixed.Mark.SmokeAtt.Smoke1.Enabled = false
		car.Wheels.RR.WheelFixed.Mark.SmokeAtt.Smoke2.Enabled = false
		car.Wheels.RR.WheelFixed.Mark.SmokeAtt.Smoke3.Enabled = false
		car.Body.Lights.B.L.BIGR.Enabled = false
	end
	if rl > 1 then
		car.Wheels.RL.WheelFixed.Mark.T.Enabled = true
		car.Wheels.RL.WheelFixed.Mark.SmokeAtt.Smoke1.Enabled = true
		car.Wheels.RL.WheelFixed.Mark.SmokeAtt.Smoke2.Enabled = true
		car.Wheels.RL.WheelFixed.Mark.SmokeAtt.Smoke3.Enabled = true
		car.Body.Lights.B.L.BIGL.Enabled = true
	else
		car.Wheels.RL.WheelFixed.Mark.T.Enabled = false
		car.Wheels.RL.WheelFixed.Mark.SmokeAtt.Smoke1.Enabled = false
		car.Wheels.RL.WheelFixed.Mark.SmokeAtt.Smoke2.Enabled = false
		car.Wheels.RL.WheelFixed.Mark.SmokeAtt.Smoke3.Enabled = false
		car.Body.Lights.B.L.BIGL.Enabled = false
	end
	if fr > 1 then
		car.Wheels.FR.WheelFixed.Mark.T.Enabled = true
	else
		car.Wheels.FR.WheelFixed.Mark.T.Enabled = false
	end
	if fl > 1 then
		car.Wheels.FL.WheelFixed.Mark.T.Enabled = true
	else
		car.Wheels.FL.WheelFixed.Mark.T.Enabled = false
	end
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Wheels.RL.SQ:Stop()
		car.Wheels.RR.SQ:Stop()
		car.Wheels.RL.Smoke.Rate=0
		car.Wheels.RR.Smoke.Rate=0
	end
end)
--[[
for i,v in pairs(car.Wheels:GetChildren()) do
	if v.Name=="RL" or v.Name=="RR" or v.Name=="R" then
		local sq = script.Parent.SQ:Clone()
		sq.Parent=v
		local sm = script.Parent.Smoke:Clone()
		sm.Parent=v
	end
end--]]
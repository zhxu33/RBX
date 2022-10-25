local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
car.Wheels.RL.SQ:Play()
car.Wheels.RR.SQ:Play()
car.Wheels.FL.SQ:Play()
car.Wheels.FR.SQ:Play()
local handler = car:WaitForChild("Smoke_FE")

while wait(.2) do
	local r1 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RL.Size.x/2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then r1hit=1 end

	local r2 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RR.Size.x/2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then r2hit=1 end
	
	local f1 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.FL.Size.x/2))
	local f1hit = 0
	if workspace:FindPartOnRay(f1,car)~=nil then f1hit=1 end

	local f2 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.FR.Size.x/2))
	local f2hit = 0
	if workspace:FindPartOnRay(f2,car)~=nil then f2hit=1 end
	
	local rl = math.min((math.max(math.abs((car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/2) - (car.Wheels.RL.Velocity.Magnitude))-25,0)),50)*r1hit
	local rr = math.min((math.max(math.abs((car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/2) - (car.Wheels.RR.Velocity.Magnitude))-25,0)),50)*r2hit
	local fl = math.min((math.max(math.abs((car.Wheels.FL.RotVelocity.Magnitude*car.Wheels.FL.Size.x/2) - (car.Wheels.FL.Velocity.Magnitude))-25,0)),50)*f1hit
	local fr = math.min((math.max(math.abs((car.Wheels.FR.RotVelocity.Magnitude*car.Wheels.FR.Size.x/2) - (car.Wheels.FR.Velocity.Magnitude))-25,0)),50)*f2hit
	
	if FE then
		handler:FireServer("UpdateSmoke",rl,rr)
	else
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
		else
			car.Wheels.RR.WheelFixed.Mark.T.Enabled = false
		end
		if rl > 1 then
			car.Wheels.RL.WheelFixed.Mark.T.Enabled = true
		else
			car.Wheels.RL.WheelFixed.Mark.T.Enabled = false
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
end

local car = script.Parent.Car.Value
local values = script.Parent.Values
Value = false
MOT = Instance.new("Motor")
MOT.Parent = car.Misc.Shifter.SN
MOT.Part0 = car.Body.ShifterH.Hinge
MOT.Part1 = car.Misc.Shifter.SN
MOT.MaxVelocity = 0.03

MOT2 = Instance.new("Motor")
MOT2.Parent = car.Misc.Shifter2.SN2
MOT2.Part0 = car.Misc.Shifter.Main
MOT2.Part1 = car.Misc.Shifter2.SN2
MOT2.MaxVelocity = 0.07

--MOT is up and down while MOT2 is side to side

wt = 0.07


while wait(0.01) do
	
if values.Gear.Value == -1 then
	MOT2.DesiredAngle = -0.4
	wait(wt)
	MOT.DesiredAngle = -0.2
end

if values.Gear.Value == 0 then
	MOT.DesiredAngle = 0
	wait(wt)
	MOT2.DesiredAngle = 0
end



if values.Gear.Value == 1 then
	MOT2.DesiredAngle = 0.2
	wait(wt)
	MOT.DesiredAngle = -0.2
	end
if values.Gear.Value == 2 then
	MOT.DesiredAngle = 0.2
	wait(wt)
	MOT2.DesiredAngle = 0.2
	end





if values.Gear.Value == 3 then
	MOT.DesiredAngle = -0.2
	wait(wt)
	MOT2.DesiredAngle = 0
	end
if values.Gear.Value == 4 then
	MOT.DesiredAngle = 0.2
	wait(wt)
	MOT2.DesiredAngle = 0
end


if values.Gear.Value == 5 then
	MOT.DesiredAngle = -0.2
	wait(wt)
	MOT2.DesiredAngle = -0.2
	end
if values.Gear.Value == 6 then
	MOT.DesiredAngle = 0.2
	wait(wt)
	MOT2.DesiredAngle = -0.2
end



end







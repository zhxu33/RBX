local car = script.Parent.Car.Value
car.Wheels.FR:WaitForChild("Base")
car.Wheels.FR:WaitForChild("Arm")

while wait() do
	local direction = car.Wheels.FR.Base.CFrame:vectorToObjectSpace(car.Wheels.FR.Arm.CFrame.lookVector)
	local direction2 = car.Wheels.FL.Base.CFrame:vectorToObjectSpace(car.Wheels.FL.Arm.CFrame.lookVector)
	local angle = ((math.atan2(-direction.Z, direction.X))+(math.atan2(-direction2.Z, direction2.X)))/2
	local anglez = (angle-1.57)*5
	car.Misc.Wheel.W.W.CurrentAngle = anglez

end
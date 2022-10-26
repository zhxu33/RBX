local car = script.Parent.Parent.Car.Value
local hinge = car.Misc.DoorR.Hinge:WaitForChild("Motor")
local mouse = game.Players.LocalPlayer:GetMouse()
---
	
	script.Parent.MouseButton1Click:connect(function()
		if hinge.DesiredAngle == 0 then
			wait(.4)
			hinge.DesiredAngle = 1.1
		else
			hinge.DesiredAngle = 0
		end
	end)
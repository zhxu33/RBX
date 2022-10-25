local car = script.Parent.Parent.Car.Value
local hinge = car.Misc.Hood.Hinge:WaitForChild("Motor")
local mouse = game.Players.LocalPlayer:GetMouse()
---
	
	script.Parent.MouseButton1Click:connect(function()
		if hinge.DesiredAngle == 0 then
			wait(.1)
			hinge.DesiredAngle = -.9
		else
			hinge.DesiredAngle = 0
		end
	end)
local car = script.Parent.Parent.Parent.Car.Value
local hinge = car.Misc.Popups.Hinge:WaitForChild("Motor")
local lights = car.Misc.Popups.Parts.L.L
local mouse = game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("HoodS")
if not car.DriveSeat:FindFirstChild("HoodS") then
script.Parent.HoodS:Clone().Parent = car.DriveSeat
end
local sound = car.DriveSeat:WaitForChild("HoodS")
---
if 	script.Parent.Parent.Parent.IsOn.Value then
	script.Parent.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
end

script.Parent.Parent.Parent.IsOn.Changed:connect(function()
	if script.Parent.Parent.Parent.IsOn.Value then
		script.Parent.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)
	
	
	function turn()
		if hinge.DesiredAngle == 0 then
			
			car.Misc.Popups.PopupsEvent:FireServer(1)
		else
			
			car.Misc.Popups.PopupsEvent:FireServer(0)
		end
	end
	
	script.Parent.MouseButton1Click:connect(function()
		turn()
	end)
	
	local uis = game:GetService("UserInputService")
	uis.InputBegan:connect(function(i,f)
		if not f then
			if i.KeyCode == Enum.KeyCode.F then
				turn()
			end
		end
	end)
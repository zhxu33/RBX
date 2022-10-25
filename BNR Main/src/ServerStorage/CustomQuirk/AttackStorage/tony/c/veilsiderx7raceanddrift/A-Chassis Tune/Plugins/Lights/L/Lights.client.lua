local car = script.Parent.Parent.Parent.Car.Value
local mouse = game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("Reverse")
if not car.DriveSeat:FindFirstChild("Reverse") then
script.Parent.Reverse:Clone().Parent = car.DriveSeat
end
car.DriveSeat:WaitForChild("Reverse")
---
if 	script.Parent.Parent.Parent.IsOn.Value then
	script.Parent.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
end

script.Parent.Parent.Parent.IsOn.Changed:connect(function()
	if script.Parent.Parent.Parent.IsOn.Value then
		script.Parent.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)--[[
	script.Parent.MouseButton1Click:connect(function()
		if car.Misc.Popups.Parts.L.L.L.Enabled == false then
			script.Parent.BackgroundColor3 = Color3.new(0,255/255,0)
			script.Parent.TextStrokeColor3 = Color3.new(0,255/255,0)
			car.Body.Lights.R.L.L.Enabled = true
			car.Misc.Popups.Parts.L.L.L.Enabled = true
			for index, child in pairs(car.Misc.Popups.Parts.L:GetChildren()) do
			child.Material = Enum.Material.Neon
			end
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.Neon
			end
		elseif car.Misc.Popups.Parts.L.L.L.Enabled == true then
			script.Parent.BackgroundColor3 = Color3.new(0,0,0)
			script.Parent.TextStrokeColor3 = Color3.new(0,0,0)
			car.Body.Lights.R.L.L.Enabled = false
			car.Misc.Popups.Parts.L.L.L.Enabled = false
			for index, child in pairs(car.Misc.Popups.Parts.L:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			end
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			end
		end
	end)
	--]]
	script.Parent.Parent.Parent.Values.Brake.Changed:connect(function()
		if script.Parent.Parent.Parent.Values.Brake.Value ~= 1 and script.Parent.Parent.Parent.IsOn.Value then
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			end
			car.Body.Lights.R.brakelight.L.Enabled = false
			car.Body.Lights.R.brakelight.R.Enabled = false
		else
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.Neon
			end
			car.Body.Lights.R.brakelight.L.Enabled = true
			car.Body.Lights.R.brakelight.R.Enabled = true
		end
	end)
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
end)
--85, 170, 255
function dostuff()
	
	if car.Body.Lights.H.L.L.Enabled == false then
		
			script.Parent.BackgroundColor3 = Color3.new(0,255/255,0)
			script.Parent.TextStrokeColor3 = Color3.new(0,255/255,0)
			car.Body.Lights.R.L.L.Enabled = true
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.R.L,1)
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.Neon
			car.Body.Lights.LightsEvent:FireServer(child,3)
			end
			for index, child in pairs(car.Body.Lights.H:GetChildren()) do
			child.Material = Enum.Material.Neon
			child.L.Enabled = true
			car.Body.Lights.LightsEvent:FireServer(child,3)
			car.Body.Lights.LightsEvent:FireServer(child,1)
			child.L.Color = Color3.fromRGB(250, 250, 250)
			end
		elseif car.Body.Lights.H.L.L.Enabled == true then
			script.Parent.BackgroundColor3 = Color3.new(0,0,0)
			script.Parent.TextStrokeColor3 = Color3.new(0,0,0)
			car.Body.Lights.R.L.L.Enabled = false
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.R.L,2)
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			car.Body.Lights.LightsEvent:FireServer(child,4)
			end
			for index, child in pairs(car.Body.Lights.H:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			child.L.Enabled = false
			car.Body.Lights.LightsEvent:FireServer(child,4)
			car.Body.Lights.LightsEvent:FireServer(child,2)
			child.L.Color = Color3.fromRGB(250, 250, 250)
			end
		end
end

	script.Parent.MouseButton1Click:connect(function()
		dostuff()
	end)
	
	local uis = game:GetService("UserInputService")
	uis.InputBegan:connect(function(i,f)
		if not f then
			if i.KeyCode == Enum.KeyCode.F then
				dostuff()
			end
		end
	end)
	
script.Parent.Parent.Parent.IsOn.Changed:connect(function()
	if script.Parent.Parent.Parent.IsOn.Value then
		script.Parent.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)
	script.Parent.MouseButton1Click:connect(function()
		if car.Misc.Popups.Parts.L.L.L.Enabled == false and car.Body.Lights.H.L.L.Enabled == false then
			script.Parent.BackgroundColor3 = Color3.new(0,255/255,0)
			script.Parent.TextStrokeColor3 = Color3.new(0,255/255,0)
			car.Body.Lights.R.L.L.Enabled = true
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.R.L,1)
			
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.Neon
			car.Body.Lights.LightsEvent:FireServer(child,3)
			end
			for index, child in pairs(car.Body.Lights.H:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			child.L.Enabled = false
			car.Body.Lights.LightsEvent:FireServer(child,2)
			car.Body.Lights.LightsEvent:FireServer(child,4)
			end
		elseif car.Misc.Popups.Parts.L.L.L.Enabled == true and car.Body.Lights.H.L.L.Enabled == false then
			script.Parent.BackgroundColor3 = Color3.new(0,0,255/255)
			script.Parent.TextStrokeColor3 = Color3.new(0,0,255/255)
			car.Body.Lights.R.L.L.Enabled = true
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.R.L,1)
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.Neon
			car.Body.Lights.LightsEvent:FireServer(child,3)
			end
			for index, child in pairs(car.Body.Lights.H:GetChildren()) do
			child.Material = Enum.Material.Neon
			child.L.Enabled = true
			car.Body.Lights.LightsEvent:FireServer(child,3)
			car.Body.Lights.LightsEvent:FireServer(child,1)
			end
		elseif car.Misc.Popups.Parts.L.L.L.Enabled == true and car.Body.Lights.H.L.L.Enabled == true then
			script.Parent.BackgroundColor3 = Color3.new(0,0,0)
			script.Parent.TextStrokeColor3 = Color3.new(0,0,0)
			car.Body.Lights.R.L.L.Enabled = false
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.R.L,2)
			
			for index, child in pairs(car.Body.Lights.R:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			car.Body.Lights.LightsEvent:FireServer(child,4)
			end
			for index, child in pairs(car.Body.Lights.H:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			child.L.Enabled = false
			car.Body.Lights.LightsEvent:FireServer(child,2)
			car.Body.Lights.LightsEvent:FireServer(child,4)
			end
		end
	end)
	
	script.Parent.Parent.Parent.Values.Brake.Changed:connect(function()
		if script.Parent.Parent.Parent.Values.Brake.Value ~= 1 and script.Parent.Parent.Parent.IsOn.Value then
			for index, child in pairs(car.Body.Lights.B:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			car.Body.Lights.LightsEvent:FireServer(child,4)
			end
			car.Body.Lights.B.L.L.Enabled = false
			car.Body.Lights.B.L.Material = Enum.Material.SmoothPlastic
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.B.L,4)
			for i,x in pairs(car.Body:GetChildren()) do
				if x.ClassName == "Trail" and (string.sub(x.Name,1,1) == "a" or string.sub(x.Name,1,1) == "b") then
					x.Enabled = false
				end
			end
			
			car.Body.BrakesRedTrailThingyFEHandler:FireServer(false)
		else
			for index, child in pairs(car.Body.Lights.B:GetChildren()) do
			child.Material = Enum.Material.Neon
			car.Body.Lights.LightsEvent:FireServer(child,3)
			end
			car.Body.Lights.B.L.L.Enabled = true
			car.Body.Lights.B.L.Material = Enum.Material.Neon
			car.Body.Lights.LightsEvent:FireServer(car.Body.Lights.B.L,3)
			for i,x in pairs(car.Body:GetChildren()) do
				if x.ClassName == "Trail" and (string.sub(x.Name,1,1) == "a" or string.sub(x.Name,1,1) == "b") then
					x.Enabled = true
				end
			end
			car.Body.BrakesRedTrailThingyFEHandler:FireServer(true)
		end
	end)
	
	script.Parent.Parent.Parent.Values.Gear.Changed:connect(function()
		if script.Parent.Parent.Parent.Values.Gear.Value == -1 then
			for index, child in pairs(car.Body.Lights.Rev:GetChildren()) do
			child.Material = Enum.Material.Neon
			car.DriveSeat.Reverse:Play()
			car.Body.Lights.LightsEvent:FireServer(child,3)
			end
		else
			for index, child in pairs(car.Body.Lights.Rev:GetChildren()) do
			child.Material = Enum.Material.SmoothPlastic
			car.DriveSeat.Reverse:Stop()
			car.Body.Lights.LightsEvent:FireServer(child,4)
			end
		end
	end)
	
	while wait() do
		if (car.DriveSeat.Velocity.magnitude/40)+0.300 < 1.3 then
		car.DriveSeat.Reverse.Pitch = (car.DriveSeat.Velocity.magnitude/40)+0.300
		car.DriveSeat.Reverse.Volume = (car.DriveSeat.Velocity.magnitude/150)	
		else
		car.DriveSeat.Reverse.Pitch = 1.3
		car.DriveSeat.Reverse.Volume = .2
		end
	end
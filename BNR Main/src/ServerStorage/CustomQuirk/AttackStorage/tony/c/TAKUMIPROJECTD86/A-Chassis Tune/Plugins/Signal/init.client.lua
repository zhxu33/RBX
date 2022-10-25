script:WaitForChild("HI")
script:WaitForChild("LI")
script:WaitForChild("RI")
script:WaitForChild("Indicator")

local car = script.Parent.Car.Value
local HI = script.HI
local LI = script.LI
local RI = script.RI
local mouse = game.Players.LocalPlayer:GetMouse()
local handler = car.Signal

mouse.KeyDown:connect(function(key)
	if key=="x" then
	if HI.Value == false then
	HI.Value = true
	else
	HI.Value = false
	end
	end
end)

mouse.KeyDown:connect(function(key)
	if key=="z" then
	if LI.Value == false then
	LI.Value = true
	else
	LI.Value = false
	end
	end
end)

mouse.KeyDown:connect(function(key)
	if key=="c" then
	if RI.Value == false then
	RI.Value = true
	else
	RI.Value = false
	end
	end
end)

if not car.DriveSeat:FindFirstChild("Left") then
	local indOn = Instance.new("BrickColorValue",car.Signal.Left)
	indOn.Name = "indOn"
			
	local indOff = Instance.new("BrickColorValue",car.Signal.Left)
	indOff.Name = "indOff"
end

if not car.DriveSeat:FindFirstChild("Right") then
	local indOn = Instance.new("BrickColorValue",car.Signal.Right)
	indOn.Name = "indOn"
			
	local indOff = Instance.new("BrickColorValue",car.Signal.Right)
	indOff.Name = "indOff"
end

if not car.DriveSeat:FindFirstChild("Hazards") then
	local indOn = Instance.new("BrickColorValue",car.Signal.Hazards)
	indOn.Name = "indOn"
			
	local indOff = Instance.new("BrickColorValue",car.Signal.Hazards)
	indOff.Name = "indOff"
end

handler:FireServer("DisableLeft")
handler:FireServer("DisableRight")
handler:FireServer("DisableHazards")

while wait() do
	if LI.Value == true then
		RI.Value = false
		HI.Value = false
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.4
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
		end
		handler:FireServer("Left",1)
		wait(.5)
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.2
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
		handler:FireServer("Left",0)
		wait(.5)
	elseif LI.Value == false then
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
	end
	if RI.Value == true then
		LI.Value = false
		HI.Value = false
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.4
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon
		end
		handler:FireServer("Right",1)
		wait(.5)
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.2
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
		handler:FireServer("Right",0)
		wait(.5)
	elseif RI.Value == false then
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
	end
	if HI.Value == true then
		RI.Value = false
		LI.Value = false
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.4
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon
		end
		handler:FireServer("Hazard",1)
		wait(.5)
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.2
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
		handler:FireServer("Hazard",0)
		wait(.5)
	elseif HI.Value == false then
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		end
		
		car.DriveSeat.ChildRemoved:connect(function(child)
			if child.Name=="SeatWeld" and child:IsA("Weld") then
				if LI.Value == true then
					handler:FireServer("EnableLeft")
				elseif RI.Value == true then
					handler:FireServer("EnableRight")
				elseif HI.Value == true then
					handler:FireServer("EnableHazards")
				end
			end		
		end)
		
	end
end
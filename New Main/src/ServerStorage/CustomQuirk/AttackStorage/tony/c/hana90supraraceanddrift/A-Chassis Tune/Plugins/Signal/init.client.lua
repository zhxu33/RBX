script:WaitForChild("HI")
script:WaitForChild("LI")
script:WaitForChild("RI")
script:WaitForChild("Indicator")

local car = script.Parent.Car.Value
local HI = script.HI
local LI = script.LI
local RI = script.RI
local mouse = game.Players.LocalPlayer:GetMouse()
local On = "Bright orange"
local Off = "Ghost grey"

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
	local lefts = script.Left:Clone()
	lefts.Parent = car.DriveSeat
	
	local indOn = Instance.new("BrickColorValue",lefts)
	indOn.Name = "indOn"
	indOn.Value = BrickColor.new(On)
			
	local indOff = Instance.new("BrickColorValue",lefts)
	indOff.Name = "indOff"
	indOff.Value = BrickColor.new(Off)
end

if not car.DriveSeat:FindFirstChild("Right") then
	local rights = script.Right:Clone()
	rights.Parent = car.DriveSeat
	
	local indOn = Instance.new("BrickColorValue",rights)
	indOn.Name = "indOn"
	indOn.Value = BrickColor.new(On)
			
	local indOff = Instance.new("BrickColorValue",rights)
	indOff.Name = "indOff"
	indOff.Value = BrickColor.new(Off)
end

if not car.DriveSeat:FindFirstChild("Hazards") then
	local hazardss = script.Hazards:Clone()
	hazardss.Parent = car.DriveSeat
	
	local indOn = Instance.new("BrickColorValue",hazardss)
	indOn.Name = "indOn"
	indOn.Value = BrickColor.new(On)
			
	local indOff = Instance.new("BrickColorValue",hazardss)
	indOff.Name = "indOff"
	indOff.Value = BrickColor.new(Off)
end

script:WaitForChild("Left")
script:WaitForChild("Right")
script:WaitForChild("Hazards")

car.DriveSeat.Left.Disabled = true
car.DriveSeat.Right.Disabled = true
car.DriveSeat.Hazards.Disabled = true

while wait() do
	if LI.Value == true then
		RI.Value = false
		HI.Value = false
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.4
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
		child.BrickColor = BrickColor.new(On)
		end
		wait(.5)
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.2
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.BrickColor = BrickColor.new(Off)
		child.Material = Enum.Material.SmoothPlastic
		end
		wait(.5)
	elseif LI.Value == false then
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		child.BrickColor = BrickColor.new(Off)
		end
	end
	if RI.Value == true then
		LI.Value = false
		HI.Value = false
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.4
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon
		child.BrickColor = BrickColor.new(On)
		end
		wait(.5)
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.2
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.BrickColor = BrickColor.new(Off)
		child.Material = Enum.Material.SmoothPlastic
		end
		wait(.5)
	elseif RI.Value == false then
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		child.BrickColor = BrickColor.new(Off)
		end
	end
	if HI.Value == true then
		RI.Value = false
		LI.Value = false
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.4
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon
		child.BrickColor = BrickColor.new(On)
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon
		child.BrickColor = BrickColor.new(On)
		end
		wait(.5)
		script.Indicator:Play()
		script.Indicator.PlaybackSpeed = 1.2
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.BrickColor = BrickColor.new(Off)
		child.Material = Enum.Material.SmoothPlastic
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		child.BrickColor = BrickColor.new(Off)
		end
		wait(.5)
	elseif HI.Value == false then
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		child.BrickColor = BrickColor.new(Off)
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
		child.Material = Enum.Material.SmoothPlastic
		child.BrickColor = BrickColor.new(Off)
		end
		
		car.DriveSeat.ChildRemoved:connect(function(child)
			if child.Name=="SeatWeld" and child:IsA("Weld") then
				if LI.Value == true then
					car.DriveSeat.Left.Disabled = false
				elseif RI.Value == true then
					car.DriveSeat.Right.Disabled = false
				elseif HI.Value == true then
					car.DriveSeat.Hazards.Disabled = false
				end
			end		
		end)
		
	end
end
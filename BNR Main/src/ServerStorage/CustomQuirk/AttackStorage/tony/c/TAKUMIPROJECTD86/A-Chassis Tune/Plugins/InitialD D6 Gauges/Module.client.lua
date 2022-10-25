
--TUNE
local SpeedType = "KPH" -- MPH or KPH




local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local Values = script.Parent.Parent.Values
local KPH = (10/12) * 1.09728
local MPH = (10/12) * (60/88)
local speed = 0
local Boost = _Tune.Boost
local Red = 0
local smooth = 0.9
local TBsmooth = 0.8

	if _Tune.Redline >= 7000 then
	Red = 8000
	script.Parent.RPM.ImageLabel.Image = "rbxassetid://1725902209"
	end
	if _Tune.Redline >= 8000 then
	Red = 9000
	script.Parent.RPM.ImageLabel.Image = "rbxassetid://1744323208"
	end
	if _Tune.Redline >= 9000 then
	Red = 10000
	script.Parent.RPM.ImageLabel.Image = "rbxassetid://1744323830"
	end
	if _Tune.Redline >= 10000 then
	Red = 13000
	script.Parent.RPM.ImageLabel.Image = "rbxassetid://1744324588"
	end
	
	script.Parent:WaitForChild("KphMph")
	
if SpeedType == "KPH" then
speed = KPH
script.Parent.KphMph.Text = "KM/H"
end
if SpeedType == "MPH" then
speed = MPH
script.Parent.KphMph.Text = "MPH"
end
	
	
	
game["Run Service"].Stepped:connect(function()
	
	script.Parent.Speed.Text = math.floor(Values.Velocity.Value.Magnitude*speed)
	script.Parent.RPM.Needle.Rotation = script.Parent.RPM.Needle.Rotation*smooth + (-120 + ((Values.RPM.Value/Red)*240))*(1-smooth)
	
	if Values.Gear.Value == -1 then
	script.Parent.Gear.Image = "rbxassetid://1744318192"
	end
	if Values.Gear.Value == 0 then
	script.Parent.Gear.Image = "rbxassetid://1744318493"
	end
	if Values.Gear.Value == 1 then
	script.Parent.Gear.Image = "rbxassetid://1725900239"
	end
	if Values.Gear.Value == 2 then
	script.Parent.Gear.Image = "rbxassetid://1725900573"
	end
	if Values.Gear.Value == 3 then
	script.Parent.Gear.Image = "rbxassetid://1725900921"
	end
	if Values.Gear.Value == 4 then
	script.Parent.Gear.Image = "rbxassetid://1725901197"
	end
	if Values.Gear.Value == 5 then
	script.Parent.Gear.Image = "rbxassetid://1725901418"
	end
	if Values.Gear.Value == 6 then
	script.Parent.Gear.Image = "rbxassetid://1725901667"
	end
	
	local direction = car.Wheels.FR.Base.CFrame:vectorToObjectSpace(car.Wheels.FR.Arm.CFrame.lookVector)
	local direction2 = car.Wheels.FL.Base.CFrame:vectorToObjectSpace(car.Wheels.FL.Arm.CFrame.lookVector)
	local angle = ((math.atan2(-direction.Z, direction.X))+(math.atan2(-direction2.Z, direction2.X)))/2
	local anglez = (angle-1.57)*6
	
	local r1 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RL.Size.x/2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then r1hit=1 end

	local r2 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RR.Size.x/2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then r2hit=1 end
	
	local rl = math.min((math.max(math.abs((car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/2) - (car.Wheels.RL.Velocity.Magnitude))-30,0)),50)*r1hit
	local rr = math.min((math.max(math.abs((car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/2) - (car.Wheels.RR.Velocity.Magnitude))-30,0)),50)*r2hit
		
		
	if rl >= 0.000001 and rr >= 0.000001 and anglez > 1 and Values.Velocity.Value.Magnitude > 15 or rl >= 0.000001 and rr >= 0.000001 and anglez < -1 and Values.Velocity.Value.Magnitude > 15  then 
		script.Parent.Drift.Image = "rbxassetid://1725900002"
	else
		script.Parent.Drift.Image = "rbxassetid://1725899752"
	end
	
	--TCS and ABS
	if _Tune.TCSEnabled == true then
		script.Parent.TCS.Visible = true
		if script.Parent.Parent.Values.TCS.Value == true then
		script.Parent.TCS.TextColor3 = Color3.new(1,1,1)
		else
			if script.Parent.Parent.Values.TCSActive.Value == true then
			script.Parent.TCS.TextColor3 = Color3.new(1,1,0)
			else
			script.Parent.TCS.TextColor3 = Color3.new(1,0,0)
			end
		end
	else
		script.Parent.TCS.Visible = false
	end
	
	if _Tune.ABSEnabled == true then
		script.Parent.ABS.Visible = true
		if script.Parent.Parent.Values.ABS.Value == true then
		script.Parent.ABS.TextColor3 = Color3.new(1,1,1)
		else
			if script.Parent.Parent.Values.ABSActive.Value == true then
			script.Parent.ABS.TextColor3 = Color3.new(1,1,0)
			else
			script.Parent.ABS.TextColor3 = Color3.new(1,0,0)
			end
		end
	else
		script.Parent.ABS.Visible = false
	end
	
	
	--boost
		script.Parent.Boost.Needle.Rotation = script.Parent.Boost.Needle.Rotation*smooth + (-110 + ((Values.Boost.Value/15)*90)+((Values.Boost.Value/Boost)*20))*(1-smooth)
		if _Tune.Aspiration == "Natural" then
			script.Parent.Boost.Visible = false
		else
			script.Parent.Boost.Visible = true
		end
	
	-- Throttle and Brake
	script.Parent.Throttle.Rotation = script.Parent.Throttle.Rotation*TBsmooth + (script.Parent.Parent.Values.Throttle.Value*130)*(1-TBsmooth)
	script.Parent.Brake.Rotation = script.Parent.Brake.Rotation*TBsmooth + (script.Parent.Parent.Values.Brake.Value*130)*(1-TBsmooth)
	
	
end)
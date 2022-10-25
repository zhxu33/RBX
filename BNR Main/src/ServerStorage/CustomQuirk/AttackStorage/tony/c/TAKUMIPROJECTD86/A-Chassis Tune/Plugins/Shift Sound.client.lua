local car = script.Parent.Car.Value
local values = script.Parent.Values.Gear

local mL = Instance.new("Sound")
mL.Parent = car.DriveSeat
mL.Name = "ShiftSound"
mL.SoundId = "rbxassetid://150781887"
mL.Volume = 0.1
mL.PlaybackSpeed = 0.85

script.Parent.Values.Gear.Changed:connect(function()
	car.DriveSeat.ShiftSound:Play()
end)
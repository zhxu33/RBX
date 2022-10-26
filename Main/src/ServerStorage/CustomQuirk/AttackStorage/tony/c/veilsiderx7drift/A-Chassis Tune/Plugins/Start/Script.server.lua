--[[ 
Button created by SprinterBZR. I will help you how to make a startup script. Or simply, you can just copy-paste into another car.
Touching some of the scripts can break the car. I advise you not touch these scripts.
--]]
wait(0.2) -- Removing this wait could break the script. Please do not touch this.
-- Variables (best not to touch these!)
local button = script.Parent 
local car = script.Parent.Parent.Car.Value
local sound = script.Parent.Start
sound.Parent = car.DriveSeat -- What brick the start sound is playing from.
button.MouseButton1Click:connect(function() -- Event when the button is clicked
	if script.Parent.Text == "Engine: Off" then -- If the text says it's off then..
		sound:Play() -- Startup sound plays..
		wait(0.4) -- For realism. Okay?
		script.Parent.Parent.IsOn.Value = true -- The car is is on, or in other words, start up the car.
		button.Text = "Engine: On"  -- You don't really need this, but I would keep it.
	else -- If it's on then when you click the button,
		script.Parent.Parent.IsOn.Value = false -- The car is turned off.
		button.Text = "Engine: Off"
	end -- Don't touch this.
end) -- And don't touch this either.

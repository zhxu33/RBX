wait(1) --To avoid everything just burning and crashing down when the car is inserted, can be deleted if you want

--Variables
local car = script.Parent.Parent.Car.Value
local button = script.Parent

--Main function
button.MouseButton1Click:connect(function()
	
	if script.Parent.On.Value == false then
		car.Wheels.FL.Anchored = true
		car.Wheels.FR.Anchored = true
		button.TextColor3 = Color3.new(255, 0, 0)
		button.Text = "Wheels Locked"
		script.Parent.On.Value = true
		
	elseif script.Parent.On.Value == true then
		car.Wheels.FL.Anchored = false
		car.Wheels.FR.Anchored = false
		button.TextColor3 = Color3.new(0, 0, 0)
		button.Text = "Lock Wheels"
		script.Parent.On.Value = false
	end
end)

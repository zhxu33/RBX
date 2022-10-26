local car = script.Parent.Parent
local F = {}

F.Backfire1 = function()
	car.Body.Exhaust.Backfire1.Backfire1:play()
	car.Body.Exhaust.Backfire1.Fire.Enabled = true
	car.Body.Exhaust.BFLight1.SpotLight.Enabled = true
	car.Body.Exhaust.Backfire2.Backfire1:play()
	car.Body.Exhaust.Backfire2.Fire.Enabled = true
	car.Body.Exhaust.BFLight2.SpotLight.Enabled = true
	wait (0.03)
	car.Body.Exhaust.Backfire1.Fire.Enabled = false
	car.Body.Exhaust.BFLight1.SpotLight.Enabled = false
	car.Body.Exhaust.Backfire2.Fire.Enabled = false
	car.Body.Exhaust.BFLight2.SpotLight.Enabled = false
	wait (0.07)
end

F.Backfire2 = function()
	car.Body.Exhaust.Backfire1.Backfire2:play()
	car.Body.Exhaust.Backfire1.Fire.Enabled = true
	car.Body.Exhaust.BFLight1.SpotLight.Enabled = true
	car.Body.Exhaust.Backfire2.Backfire2:play()
	car.Body.Exhaust.Backfire2.Fire.Enabled = true
	car.Body.Exhaust.BFLight2.SpotLight.Enabled = true
	wait (0.03)
	car.Body.Exhaust.Backfire1.Fire.Enabled = false
	car.Body.Exhaust.BFLight1.SpotLight.Enabled = false
	car.Body.Exhaust.Backfire2.Fire.Enabled = false
	car.Body.Exhaust.BFLight2.SpotLight.Enabled = false
	wait (0.07)
end


script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Body.Exhaust.Backfire1.Fire.Enabled = false
		car.Body.Exhaust.BFLight1.SpotLight.Enabled = false
		car.Body.Exhaust.Backfire2.Fire.Enabled = false
		car.Body.Exhaust.BFLight2.SpotLight.Enabled = false
		car.Body.Exhaust.Backfire3.Fire.Enabled = false
		car.Body.Exhaust.BFLight3.SpotLight.Enabled = false
		car.Body.Exhaust.Backfire4.Fire.Enabled = false
		car.Body.Exhaust.BFLight4.SpotLight.Enabled = false
	end
end)
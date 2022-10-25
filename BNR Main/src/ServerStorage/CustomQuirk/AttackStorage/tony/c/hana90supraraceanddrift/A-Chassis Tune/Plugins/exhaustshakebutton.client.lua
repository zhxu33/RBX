--//INSPARE//--
local player = game.Players.LocalPlayer
local lightOn = false
--local HUB = script.Parent.HUB
--local limitButton = HUB.Limiter

local carSeat = script.Parent.Car.Value
local seat = script.Parent.Car.Value.DriveSeat
local mouse = game.Players.LocalPlayer:GetMouse()

--driving
mouse.KeyDown:connect(function (key1)
key1 = string.lower(key1)


if key1 == "w" then
		carSeat.hitter.CanCollide = false
		carSeat.exhaust.Part.Spring.Stiffness = 0
else
			carSeat.hitter.CanCollide = true
					carSeat.exhaust.Part.Spring.Stiffness = 500

end
end)




----idle
--mouse.KeyUp:connect(function (key2)
--key2 = string.lower(key2)
--print(key2)
--
--		
----if key2 == "w" then
--	local i = 1
--while key2=="w" do		
--	 carSeat.exhaust.Part.Spring.Stiffness = 0
--			print("stiffness is 0")
--	wait(1)
--	 carSeat.exhaust.Part.Spring.Stiffness = 500
--			print("stiffness is 500")
--			wait(1)
--			
--   i = i + 1
--
--	print(i)
--if key2=="q" then break
--	end
--end
--
--
--
--	--end
--end)
--
--

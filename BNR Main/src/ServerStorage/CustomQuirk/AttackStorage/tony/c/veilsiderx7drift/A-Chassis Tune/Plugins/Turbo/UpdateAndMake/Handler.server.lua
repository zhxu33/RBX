wait(1)
--Make Sounds








	
--Updater
	script.Parent.OnServerEvent:connect(function(player,totalPSI,actualPSI,Throttle,BOVFix)
		
		local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
		local car = script.Parent.Parent
		local W = DriveSeat:WaitForChild("Whistle")
		local B = car.Body.BOVPart:WaitForChild("BOV")
		local B2 = car.Body.BOVPart2:WaitForChild("BOV")
		
		local Throttle = DriveSeat.Throttle
		if Throttle < 0 then
			Throttle = 0
		end
		W.Pitch = (totalPSI)
		W.Volume = totalPSI/1.7
		B.Pitch = 1 - (-totalPSI/20)
		B.Volume = 3
		B2.Pitch = 1 - (-totalPSI/20)
		B2.Volume = 2
	end)
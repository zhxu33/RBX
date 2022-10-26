local F = {}
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent
local radiator = car.Body.Smoke

F.Initialize = function(FanSpeed)
	radiator.Oil.Enabled = false
	radiator.Antifreeze.Enabled = false
	radiator.Liquid.Volume = 0
	radiator.Fan:Play()
	radiator.Fan.Pitch = 1+FanSpeed
	radiator.Steam:Play()
	radiator.Liquid:Play()
end

F.FanVolume = function(FanVolume)
	radiator.Fan.Volume = FanVolume
end

F.Blown = function()
	radiator.Break:Play()
	radiator.Liquid.Volume = .5
	radiator.Oil.Enabled = true
	radiator.Antifreeze.Enabled = true
end

F.Smoke = function(value,BlowupTemp,Heat)
	if value then
		radiator.Smoke.Transparency = NumberSequence.new((BlowupTemp-Heat)/10,1)
		radiator.Smoke.Enabled = true
		radiator.Steam.Volume = math.abs(((BlowupTemp-Heat)-10)/10)
	else
		radiator.Smoke.Enabled = false
		radiator.Steam.Volume = 0
	end
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)
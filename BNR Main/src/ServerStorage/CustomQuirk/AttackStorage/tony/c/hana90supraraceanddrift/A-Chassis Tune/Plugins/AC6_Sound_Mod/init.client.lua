--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local handler = car:WaitForChild("AC6_FE_Sounds")
local _Tune = require(car["A-Chassis Tune"])
local on = 0
local mult=0
local det=0
local trm=0
local trmmult=0
local trmon=0
local throt=0
local redline=0
local shift=0

script:WaitForChild("Rev")

script.Parent.Values.Gear.Changed:connect(function()
	mult=1
	if script.Parent.Values.RPM.Value>5000 then
		shift=.2
	end
end)

for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end

handler:FireServer("newSound","Rev",car.DriveSeat,script.Rev.SoundId,0,script.Rev.Volume,true)
handler:FireServer("playSound","Rev")
car.DriveSeat:WaitForChild("Rev")

while wait() do
	mult=math.max(0,mult-.1)
	local _RPM = script.Parent.Values.RPM.Value
	
	if script.Parent.Values.Throttle.Value <= _Tune.IdleThrottle/100 then
		throt = math.max(.3,throt-.2)
		trmmult = math.max(0,trmmult-.05)
		trmon = 1		
	else
		throt = math.min(1,throt+.1)
		trmmult = 1
		trmon = 0		
	end	
	shift = math.min(1,shift+.2)	
	if script.Parent.Values.RPM.Value > _Tune.Redline-_Tune.RevBounce/4 and script.Parent.Values.Throttle.Value > _Tune.IdleThrottle/100 then
		redline=.5
	else
		redline=1
	end
	if not script.Parent.IsOn.Value then on=math.max(on-12,0) else on=2 end
	local Volume = (3*throt*shift*redline)+(trm*trmon*trmmult*(3-throt)*math.sin(tick()*50))
	local Pitch = math.max((((script.Rev.SetPitch.Value + script.Rev.SetRev.Value*_RPM/_Tune.Redline))*on^2)+(det*mult*math.sin(80*tick())),script.Rev.SetPitch.Value)
	if FE then
		handler:FireServer("updateSound","Rev",script.Rev.SoundId,Pitch,Volume)
	else
		car.DriveSeat.Rev.Volume = Volume
		car.DriveSeat.Rev.Pitch = Pitch
	end
end

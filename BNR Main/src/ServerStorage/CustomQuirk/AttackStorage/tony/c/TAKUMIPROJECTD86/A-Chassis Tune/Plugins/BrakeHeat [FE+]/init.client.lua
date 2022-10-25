local car = script.Parent.Car.Value
local Drive = car.Wheels:GetChildren()
local _Tune = require(car["A-Chassis Tune"])
local FE = workspace.FilteringEnabled
local handler = car:WaitForChild("BrakeHeat_FE")

car.DriveSeat.ChildRemoved:connect(function(child)
	for i,a in pairs(Drive) do
		a.Parts.Heat.Transparency=1
		a.Parts.Heat.L.Range=0
	end
end)

local Drive = {}

for i,v in pairs(car.Wheels:GetChildren()) do
	local s = {}
	s.Wheel = v
	s.heat = 0
	s.pheat = 0
	table.insert(Drive,s)
end

while wait(.2) do
	for i,a in pairs(Drive) do
		if script.Parent.Values.Brake.Value>.3 and a.Wheel.RotVelocity.Magnitude>100 then
			a.heat=math.min(1,a.heat+math.min(.1,.1*script.Parent.Values.Brake.Value*(a.Wheel.RotVelocity.Magnitude/300)))
		else
			a.heat=math.max(0,a.heat-.025)
		end
		if a.pheat~=a.heat then
			if FE then
				handler:FireServer("UpdateHeat",a.Wheel,a.heat)
			else
				a.Wheel.Parts.Heat.Transparency=1-a.heat
				a.Wheel.Parts.Heat.L.Range=a.heat*6
			end
		end
		a.pheat = a.heat
	end
end
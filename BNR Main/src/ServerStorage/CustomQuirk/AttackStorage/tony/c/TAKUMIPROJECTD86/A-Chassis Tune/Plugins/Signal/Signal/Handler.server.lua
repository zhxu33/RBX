local F = {}
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent
F.DisableLeft = function(On,Off)
	script.Parent.Left.Disabled = true
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do

		child.Material = Enum.Material.SmoothPlastic
	end
end

F.DisableRight = function(On,Off)
	script.Parent.Right.Disabled = true
	for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic

	end
end

F.DisableHazards = function(On,Off)
	script.Parent.Hazards.Disabled = true
	for index, child in pairs(car.Body.Lights.Li:GetChildren()) do

		child.Material = Enum.Material.SmoothPlastic
	end
	for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic

	end
end

F.Hazard = function(status,On,Off)
	if status == 0 then
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do

		child.Material = Enum.Material.SmoothPlastic
		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic

		end
	else
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon

		end
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon

		end
		for index, child in pairs(car.Body.Lights.DRLL:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
		for index, child in pairs(car.Body.Lights.DRLR:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
	end
end

F.Left = function(status,On,Off)
	if status == 0 then
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do

		child.Material = Enum.Material.SmoothPlastic
		end
		for index, child in pairs(car.Body.Lights.DRLL:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
	else
		for index, child in pairs(car.Body.Lights.Li:GetChildren()) do
  		child.Material = Enum.Material.Neon

		end
		for index, child in pairs(car.Body.Lights.DRLL:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
	end
end

F.Right = function(status,On,Off)
	if status == 0 then
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic

		end
		for index, child in pairs(car.Body.Lights.DRLR:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
	else
		for index, child in pairs(car.Body.Lights.Ri:GetChildren()) do
  		child.Material = Enum.Material.Neon

		end
		for index, child in pairs(car.Body.Lights.DRLR:GetChildren()) do
  		child.Material = Enum.Material.SmoothPlastic
		end
	end
end


F.EnableLeft = function()
	script.Parent.Left.Disabled = false
end

F.EnableRight = function()
	script.Parent.Right.Disabled = false
end

F.EnableHazards = function()
	script.Parent.Hazards.Disabled = false
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)
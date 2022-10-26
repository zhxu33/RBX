script.Parent.WiperEvent.OnServerEvent:connect(function(p,n)
	if n == 0 then
		script.Parent.Hinge["Motor"].DesiredAngle = 0
	else
		wait(.5)
		script.Parent.Hinge["Motor"].DesiredAngle = -1.5
		wait(.5)
		script.Parent.Hinge["Motor"].DesiredAngle = 0
		wait(.5)
		script.Parent.Hinge["Motor"].DesiredAngle = -1.5
		wait(.5)
		script.Parent.Hinge["Motor"].DesiredAngle = 0
		wait(.5)
		script.Parent.Hinge["Motor"].DesiredAngle = -1.5
		wait(.5)
		script.Parent.Hinge["Motor"].DesiredAngle = 0	
	end
end)
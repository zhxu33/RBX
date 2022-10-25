script.Parent.PopupsEvent.OnServerEvent:connect(function(p,n)
	if n == 0 then
		script.Parent.Hinge["Motor"].DesiredAngle = 0
		script.Parent.Parts.L.L.left.Enabled = false
		script.Parent.Parts.L.L.right.Enabled = false
		script.Parent.Parts.L.L.light.SpotLight.Enabled = false
		script.Parent.Parts.L.L.left1.ParticleEmitter.Enabled = false
		script.Parent.Parts.L.L.right1.ParticleEmitter.Enabled = false
		script.Parent.Parts.L.L.trail2l.Enabled = false
		script.Parent.Parts.L.L.trail2r.Enabled = false
		script.Parent.Parts.L.L.Trailrr.Enabled = false
		script.Parent.Parts.L.L.Trailll.Enabled = false
	else
		script.Parent.Hinge["Motor"].DesiredAngle = -1.5
		script.Parent.Parts.L.L.left.Enabled = true
		script.Parent.Parts.L.L.right.Enabled = true
		script.Parent.Parts.L.L.light.SpotLight.Enabled = true
		script.Parent.Parts.L.L.left1.ParticleEmitter.Enabled = true
		script.Parent.Parts.L.L.right1.ParticleEmitter.Enabled = true
		script.Parent.Parts.L.L.trail2l.Enabled = true
		script.Parent.Parts.L.L.trail2r.Enabled = true
		script.Parent.Parts.L.L.Trailrr.Enabled = true
		script.Parent.Parts.L.L.Trailll.Enabled = true
	end
end)
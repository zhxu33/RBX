local Target = script.Parent

Target.Touched:Connect(function(hit)
	if hit.Name ~= "DiskHitbox" then
		Target.Anchored = true
		local TP = Target.CFrame
		local BV = Target:FindFirstChild("BodyVelocity")
		if BV then
			print("Destroyed")
			BV:Destroy()
		end
		Target.CFrame = TP
		Target.Orientation = Vector3.new(0, 0, 90)
		script:Destroy()
	end
end)
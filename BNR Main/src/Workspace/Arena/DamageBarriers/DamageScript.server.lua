for i,v in pairs(script.Parent:GetChildren()) do
	if v.Name == "DamageBarrier" then
		v.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") then
				hit.Parent.Humanoid.Health = 0
			end
		end)
	end
end
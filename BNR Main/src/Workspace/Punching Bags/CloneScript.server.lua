local GymPlace = script.Parent
local ExpScript = script.Parent:WaitForChild("EXP")
for i,v in pairs(GymPlace:GetChildren()) do
	if v.Name == "Punching bag" then
		bag = v:WaitForChild("Punching bag")
		local clone = ExpScript:Clone()
		clone.Parent = bag
		clone.Disabled = false
	end
end
ExpScript:Destroy()
script:Destroy()
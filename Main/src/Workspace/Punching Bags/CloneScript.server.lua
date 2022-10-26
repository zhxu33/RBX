local GymPlace = script.Parent
local ExpScript = script.Parent:WaitForChild("Bag")
repeat wait(1) until _G.NPCs
for i,v in pairs(GymPlace:GetChildren()) do
	if v.Name == "Punching bag" then
		bag = v:WaitForChild("Punching bag")
		local clone = ExpScript:Clone()
		clone.Parent = bag
		clone.Disabled = false
		table.insert(_G.NPCs, bag:WaitForChild("HumanoidRootPart"))
	end
end
ExpScript:Destroy()
script:Destroy()
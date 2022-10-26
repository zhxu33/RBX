-- // Variables
local regions = script.Parent

-- // Functions
-- // Makes the part invisible
local function makeRegionInvisible(Part)
	if not (Part and Part:IsA("BasePart")) then return end
	Part.Transparency = 1
end

for _, value in pairs(regions:GetChildren()) do
	makeRegionInvisible(value)
end

regions.ChildAdded:Connect(makeRegionInvisible)
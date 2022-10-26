local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local Humanoid = Character.Humanoid
Humanoid.MaxHealth = math.huge
Humanoid.Health = math.huge

HumanoidRootPart:GetPropertyChangedSignal("Anchored"):Connect(function()
	HumanoidRootPart.Anchored = true
end)
local ArenaTPCFrame = CFrame.new(20354.7344, 113.145958, 6967.53906, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local Debounce = {}

local function TouchedPart(hit)
	if hit.Parent:FindFirstChildOfClass("Humanoid") and hit.Name == "HumanoidRootPart" then
		if Debounce[hit.Parent.Humanoid] ~= nil then return end
		Debounce[hit.Parent.Humanoid] = true
		coroutine.wrap(function()
			wait(1)
			Debounce[hit.Parent.Humanoid] = nil
		end)()
		local char = hit.Parent
		if char:FindFirstChild("ArenaPlayer") then
			if char:FindFirstChild("HumanoidRootPart") then
				local SafeTp = Instance.new("NumberValue", hit.Parent)
				SafeTp.Name = "SafeTp"
				game.Debris:AddItem(SafeTp,.1)
				char.HumanoidRootPart.CFrame = ArenaTPCFrame
			end
		else
			hit.Parent.Humanoid.Health = 0
			pcall(function()
				game.Players[char.Name]:LoadCharacter()
			end)
		end
	end
end

for v,parts in pairs(script.Parent:GetChildren()) do
	if parts:IsA("BasePart") then
		parts.Touched:Connect(TouchedPart)
	end
end
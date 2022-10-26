local Gym = script.Gym
local Hosp = script.Hospital
local WepSop = script.WeaponShop

function STP(player)
	local SafeTP = Instance.new("BoolValue")
	SafeTP.Name = "SafeTp"
	SafeTP.Parent = player.Character
	game:GetService("Debris"):AddItem(SafeTP, 0.5)
end

Gym.Enter.Value.ProximityPrompt.Triggered:Connect(function(player)	
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Gym.Enter.Value.Parent.TPLocation.CFrame
end)

Gym.Exit.Value.ProximityPrompt.Triggered:Connect(function(player)
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Gym.Exit.Value.Parent.TPLocation.CFrame
end)

WepSop.Enter.Value.ProximityPrompt.Triggered:Connect(function(player)	
	STP(player)
	player.Character.HumanoidRootPart.CFrame = WepSop.Enter.Value.Parent.TPLocation.CFrame
end)

WepSop.Exit.Value.ProximityPrompt.Triggered:Connect(function(player)
	STP(player)
	player.Character.HumanoidRootPart.CFrame = WepSop.Exit.Value.Parent.TPLocation.CFrame
end)

--------------------------------------------------------------------------------------------------------------------------

Hosp.Enter.Value.ProximityPrompt.Triggered:Connect(function(player)	
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Hosp.Enter.Value.Parent.TPLocation.CFrame
end)

Hosp.Exit.Value.ProximityPrompt.Triggered:Connect(function(player)
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Hosp.Exit.Value.Parent.TPLocation.CFrame
end)

Hosp.Enter1.Value.ProximityPrompt.Triggered:Connect(function(player)	
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Hosp.Enter1.Value.Parent.TPLocation.CFrame
end)

Hosp.Exit1.Value.ProximityPrompt.Triggered:Connect(function(player)
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Hosp.Exit1.Value.Parent.TPLocation1.CFrame
end)

Hosp.Enter2.Value.Triggered:Connect(function(player)
	STP(player)
	player.Character.HumanoidRootPart.CFrame = Hosp.Exit.Value.Parent.TPLocation.CFrame
end)
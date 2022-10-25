local Character = script.Parent
local CDFolder = script.Parent.Parent.Parent.Cooldown
local HumanoidRootPart = Character.HumanoidRootPart
local Humanoid = Character.Humanoid
Humanoid.MaxHealth = math.huge
Humanoid.Health = math.huge
local Target = nil
local GymPassId = 4746076
local ExpAmount = 250

HumanoidRootPart:GetPropertyChangedSignal("Anchored"):Connect(function()
	HumanoidRootPart.Anchored = true
end)

while wait() do
	if HumanoidRootPart:FindFirstChild("Light") then
		local part = HumanoidRootPart:FindFirstChild("Light")
		if part:FindFirstChild("Hitist")then
			local ExpMultiplier
			Target = part.Hitist.Value
			if not CDFolder:FindFirstChild(Target.Parent.Name) then
			local CD = Instance.new("Model",CDFolder)
			CD.Name = Target.Parent.Name
			game.Debris:AddItem(CD, .5)
			for i,player in pairs(game.Players:GetPlayers()) do
				if player.Name == Target.Parent.Name then
					if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, GymPassId) or player.Name == "Jeffycry65" then
						ExpMultiplier = 10
						local PlayerData =  workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Parent.Name)
						local EXPGain = ExpAmount*ExpMultiplier+PlayerData.Level.Value*2
				--		print(player.Name .. " gained " .. EXPGain .. " EXP.")
						PlayerData.Experience.Value = PlayerData.Experience.Value + EXPGain
					else 
						ExpMultiplier = 1
						workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Parent.Name).Experience.Value = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Parent.Name).Experience.Value + (ExpAmount*ExpMultiplier)
					end
				end
			end
			if HumanoidRootPart:FindFirstChild("Light") then
				HumanoidRootPart:FindFirstChild("Light"):Destroy()
			end
			end
		end
	elseif HumanoidRootPart:FindFirstChild("Heavy") then
		local part = HumanoidRootPart:FindFirstChild("Heavy")
		if part:FindFirstChild("Hitist") then
			local ExpMultiplier 
			Target = part.Hitist.Value
			if not CDFolder:FindFirstChild(Target.Parent.Name) then
				local CD = Instance.new("Model",CDFolder)
				CD.Name = Target.Parent.Name
				game.Debris:AddItem(CD, .5)
				for i,player in pairs(game.Players:GetPlayers()) do
					if player.Name == Target.Parent.Name then
						if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, GymPassId) or player.Name == "Jeffycry65" then
							ExpMultiplier = 10
							local PlayerData =  workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Parent.Name)
							local EXPGain = ExpAmount*ExpMultiplier+PlayerData.Level.Value*2
							--		print(player.Name .. " gained " .. EXPGain .. " EXP.")
							PlayerData.Experience.Value = PlayerData.Experience.Value + EXPGain
						else 
							ExpMultiplier = 1
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Parent.Name).Experience.Value = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Parent.Name).Experience.Value + (ExpAmount*ExpMultiplier)
						end
					end
				end
				if HumanoidRootPart:FindFirstChild("Light") then
					HumanoidRootPart:FindFirstChild("Light"):Destroy()
				end
			end
		end
	end
end
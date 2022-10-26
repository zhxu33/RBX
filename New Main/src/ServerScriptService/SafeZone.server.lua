local SafezoneFolder = workspace.Safezones

function isInRegion3(pos, bottomLeft, topRight)
	if pos.X > bottomLeft.X and pos.Y > bottomLeft.Y and pos.Z > bottomLeft.Z then
		if pos.X < topRight.X and pos.Y < topRight.Y and pos.Z < topRight.Z then
			return true
		else
			return false
		end
	else
		return false
	end
end

while wait(.5) do
	pcall(function()
		for i,plr in pairs(game.Players:GetChildren()) do
			local Character = plr.Character
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			local Humanoid = Character:FindFirstChild("Humanoid")
			local Found = false
			if HumanoidRootPart and Humanoid then
				for i,safezone in pairs(SafezoneFolder:GetChildren()) do
					local bottomLeft = safezone.Position - Vector3.new(safezone.Size.X / 2, safezone.Size.Y / 2, safezone.Size.Z / 2)
					local topRight = safezone.Position + Vector3.new(safezone.Size.X / 2, safezone.Size.Y / 2, safezone.Size.Z / 2)
					if isInRegion3(HumanoidRootPart.Position, bottomLeft, topRight) == true and Found == false and Humanoid.Health >= Humanoid.MaxHealth then
						Found = true
						if not Character:FindFirstChild("Safezone") then
							
							local s = Character:FindFirstChildOfClass("ForceField")
							if s then 
								s:Destroy() 
							end
							
							local ff = Instance.new("ForceField", Character)
							ff.Name = "Safezone"
							ff:SetAttribute("Zone", safezone.Name)
							
						end
					end
				end
			end
			if Found == false and Character:FindFirstChild("Safezone") 
				or Humanoid.Health < Humanoid.MaxHealth and Character:FindFirstChild("Safezone") then
				Character:FindFirstChild("Safezone"):Destroy()
			end
		end
	end)
end
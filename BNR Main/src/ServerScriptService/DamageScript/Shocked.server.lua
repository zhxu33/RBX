local ElectrificationFolder = game.ServerStorage.Electrification

local shocking = {}
local GetSpeed = {}
local stage = {}
local count = {}

function ApplyShock(character, amount)
	coroutine.wrap(function()
		local anim = character.Humanoid:LoadAnimation(script.Electrified)
		anim:Play()
		stage[character] = stage[character] + amount
		count[character] = 1
		if shocking[character] == nil or shocking[character] == false then
			shocking[character] = true
			if stage[character] == 1 then
				character.Humanoid.WalkSpeed = GetSpeed[character] * 0.35
				local Electricity = character.HumanoidRootPart:FindFirstChild("Electricity")
				if Electricity then
					Electricity.Size = NumberSequence.new(1.5)
				end
			elseif stage[character] == 2 then
				character.Humanoid.WalkSpeed = GetSpeed[character] * 0.15
				local Electricity = character.HumanoidRootPart:FindFirstChild("Electricity")
				if Electricity then
					Electricity.Size = NumberSequence.new(2)
				end
			elseif stage[character] == 3 then
				character.Humanoid.WalkSpeed = 0
				local Electricity = character.HumanoidRootPart:FindFirstChild("Electricity")
				if Electricity then
					Electricity.Size = NumberSequence.new(3)
				end
			end
			while true do
				wait(0.5)
				if character ~= nil and stage[character] ~= nil and count[character] ~= nil then
					if stage[character] == 1 then
						character.Humanoid.WalkSpeed = GetSpeed[character] * 0.35
						local Electricity = character.HumanoidRootPart:FindFirstChild("Electricity")
						if Electricity then
							Electricity.Size = NumberSequence.new(1.5)
						end
					elseif stage[character] == 2 then
						character.Humanoid.WalkSpeed = GetSpeed[character] * 0.15
						local Electricity = character.HumanoidRootPart:FindFirstChild("Electricity")
						if Electricity then
							Electricity.Size = NumberSequence.new(2)
						end
					elseif stage[character] == 3 then
						character.Humanoid.WalkSpeed = 0
						local Electricity = character.HumanoidRootPart:FindFirstChild("Electricity")
						if Electricity then
							Electricity.Size = NumberSequence.new(3)
						end
					elseif stage[character] >= 4 then
						stage[character] = 3
					end
					if count[character] == 0 then
						if stage[character] > 1 then
							stage[character] = stage[character] - 1
							count[character] = 1
						else
							count[character] = 0
							stage[character] = 0
							local Find = character.HumanoidRootPart:FindFirstChild("Electricity")
							if Find then
								Find:Destroy()
							end
							character.Humanoid.WalkSpeed = 16
							shocking[character] = false
							anim:Stop()
							break
						end
					end
					count[character] = count[character] - 1
				end
			end
		end
	end)()
end

game.ReplicatedStorage.Shock.Event:Connect(function(character, character2, amount)
	local checkForce = character:FindFirstChildOfClass("ForceField")
	local checkForce2 = character2:FindFirstChildOfClass("ForceField")
	if (checkForce and checkForce.Name == "Safezone") or (checkForce2 and checkForce2.Name == "Safezone") then return end
	coroutine.wrap(function()
		if count[character] == nil or stage[character] == nil then
			count[character] = 0
			stage[character] = 0
		end
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			local Found = character.HumanoidRootPart:FindFirstChild("Electricity")
			if not Found then
				local Electricity = game.ServerStorage.Electrification.Shocked.Electricity:Clone()
				Electricity.Parent = character.HumanoidRootPart
			end
			GetSpeed[character] = 18
			ApplyShock(character, amount)
		end
	end)()
end)
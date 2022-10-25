local function round(number)
	return math.floor(number + 0.5)
end

	game.ReplicatedStorage.Remotes.Player2.OnServerEvent:Connect(function(Player)
	repeat 
		wait() 		
	until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
	local StatPoints = PlayerData:WaitForChild("StatPoints")
	local Strength = PlayerData:WaitForChild("Strength")
	local Durability = PlayerData:WaitForChild("Durability")
	local Agility = PlayerData:WaitForChild("Agility")
	
	game.ReplicatedStorage.Remotes.Durability.OnServerEvent:Connect(function(player,amount)
		if player == Player and StatPoints.Value >= amount and amount > 0 then
			Durability.Value = Durability.Value + round(amount)
			StatPoints.Value = StatPoints.Value - round(amount)
		end
	end)
	
	game.ReplicatedStorage.Remotes.Agility.OnServerEvent:Connect(function(player, amount)
		if player == Player and StatPoints.Value >= amount and amount > 0 then
			Agility.Value = Agility.Value + round(amount)
			StatPoints.Value = StatPoints.Value - round(amount)
		end
	end)
	
	game.ReplicatedStorage.Remotes.Strength.OnServerEvent:Connect(function(player, amount)
		if player == Player and StatPoints.Value >= amount and amount > 0 then
			Strength.Value = Strength.Value + round(amount)
			StatPoints.Value = StatPoints.Value - round(amount)
		end
	end)
end)
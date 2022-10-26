if not game:GetService'RunService':IsStudio() then return end

game.ReplicatedStorage.Remotes.CooldownRemote.OnServerEvent:Connect(function(Player, ...)
	game.ReplicatedStorage.Remotes.CooldownRemote:FireClient(Player, ...)
end)

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Wait()
	task.wait(3)
	Player:LoadCharacter()
end)
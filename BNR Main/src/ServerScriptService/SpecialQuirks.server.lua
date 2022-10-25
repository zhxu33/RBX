local DekuRemote = game.ReplicatedStorage.Quirk.DekuOfa
local TomuraRemote = game.ReplicatedStorage.Quirk.TomuraAfo

DekuRemote.OnServerEvent:Connect(function(Player)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
	local Quirk = PlayerData:WaitForChild("Quirk")
	local Level = PlayerData:WaitForChild("Level")
	local Fame = PlayerData:WaitForChild("Fame")
	if Quirk.Value == 3 and Level.Value >= 5000 and Fame.Value >= 50000 then
		Quirk.Value = 13
		Player:LoadCharacter()
	end
end)

TomuraRemote.OnServerEvent:Connect(function(Player)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
	local Quirk = PlayerData:WaitForChild("Quirk")
	local Level = PlayerData:WaitForChild("Level")
	local Fame = PlayerData:WaitForChild("Fame")
	if Quirk.Value == 26 and Level.Value >= 5000 and Fame.Value <= -50000 then
		Quirk.Value = 34
		Player:LoadCharacter()
	end
end)
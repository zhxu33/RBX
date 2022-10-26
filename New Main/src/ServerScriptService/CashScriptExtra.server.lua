local event = game.ReplicatedStorage.Remotes.CashSpinEvent
local Spin = game.ReplicatedStorage.Remotes.Spin2

event.OnServerEvent:Connect(function(plr,load)
	if load == "Spin" then
		Spin:FireClient(plr)
	elseif load == "Load" then
		plr:LoadCharacter()
	end
end)
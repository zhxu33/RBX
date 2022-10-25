local CD = false
local Equip = game.ReplicatedStorage.WeaponShop:WaitForChild("Equip")
local DJE = game.ReplicatedStorage.Remotes.DragosJailEvent

DJE.OnClientEvent:Connect(function()
	if CD == false then
		CD = true
		Equip:FireClient("Unequip")
		wait(1)
		CD = false
	end
end)
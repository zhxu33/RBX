local Player = game.Players.LocalPlayer
local Equip = game.ReplicatedStorage.WeaponShop:WaitForChild("Equip")
local CD = false
local Equipped = false

if Player:GetRankInGroup(3755220) < 12 then
	script.Parent.Parent["BanHammer"]:remove()
end

if Player.PlayerGui.Menu["BanHammer"] ~= nil then
	if Player:GetRankInGroup(3755220) <= 12 then
		script.Parent.Parent["BanHammer"]:remove()
	end
end

script.Parent.Visible = true

script.Parent.MouseButton1Click:Connect(function()
	if CD == false then
		CD = true
		if Equipped == true then
			Equipped = false
			Equip:FireServer("Unequip")
		elseif Equipped == false then
			Equipped = true
			Equip:FireServer("BanHammer")
		end
		wait(1)
		CD = false
	end
end)
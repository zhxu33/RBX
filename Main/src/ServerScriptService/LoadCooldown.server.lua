local BV = ""
if game.PlaceId == 7775211226 then
	BV = game:GetService("ServerScriptService").BetaScript:GetAttribute("BV")
end


local DataStore = game:GetService("DataStoreService")
local Cooldown  = DataStore:GetDataStore("Cooldown"..BV)
local GCD       = game.ReplicatedStorage:WaitForChild("GetCD")
local CooldownStore = {}

GCD.OnServerEvent:Connect(function(plr, Toggle, Load)
	if Load then
		GCD:FireClient(plr, CooldownStore[plr.UserId] or false)
	else
		CooldownStore[plr.UserId] = Toggle
	end
end)

game.Players.PlayerAdded:Connect(function(plr)
	local GC = Cooldown:GetAsync(plr.UserId) or false
	CooldownStore[plr.UserId] = GC
end)

game.Players.PlayerRemoving:Connect(function(plr)
	Cooldown:SetAsync(plr.UserId, CooldownStore[plr.UserId])
	CooldownStore[plr.UserId] = nil
end)
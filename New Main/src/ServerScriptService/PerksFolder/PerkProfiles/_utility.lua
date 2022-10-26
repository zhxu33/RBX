-- // Service
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService       = game:GetService("Players")
local Replicated          = game:GetService("ReplicatedStorage")
local RunService          = game:GetService("RunService")

-- // Remotes
local Remotes       = Replicated:FindFirstChild("RaidInfo")
local PerkRemote    = Remotes and Remotes:WaitForChild("PerkRemote")
local Announcement  = Remotes and Remotes:WaitForChild("Announcement")
local PerkUpdate    = Remotes and Remotes:WaitForChild("PerkUpdate")
local PurchaseSlot  = Remotes and Remotes:WaitForChild("BuyPerkSlot")
local PurchaseRoll  = Remotes and Remotes:WaitForChild("BuyReRoll")
local ReadyUpRemote = Remotes and Remotes:WaitForChild("ReadyUpRemote")

-- // Variables
local Util = {}

-- // Functions

-- // Announces an update to player(s)
function Util:Announce(Player : Player, Message : string, TextSize : number, Color : Color3, Font : Enum.Font | nil)
	if not (Announcement) then return end

	Announcement:FireClient(Player, Message, TextSize, Color, Font)
end

-- // Updates information on the players perk
function Util:UpdatePlayerPerk(Player : Player, updateInfo : {})
	if not (PerkUpdate) then return end

	PerkUpdate:FireClient(Player, updateInfo)
end

-- // Updates info for a players new roll (Unless nothing is provided, it clears all rolls)
function Util:UpdateRolls(Player : Player, newPerks : {any}, extra : boolean)
	if not (PerkRemote) then return end

	if not (Player) then
		PerkRemote:FireAllClients(newPerks, extra)
	else
		PerkRemote:FireClient(Player,newPerks, extra)
	end
end

-- // Sends information to the client regarding slot purchases | Regards costs
function Util:PurchaseSlot(Player : Player, Cost : number)
	if not (PurchaseSlot) then return end

	PurchaseSlot:FireClient(Player, Cost)
end

-- // Tells all clients that there are xx number of players ready out of xx
function Util:ReadyUp(totalReady : number, outofPlayers : number)
	if not (ReadyUpRemote) then return end

	ReadyUpRemote:FireAllClients(totalReady, outofPlayers)
end

-- // Returns the perk roll remote
function Util:RequestPerkRoll() : RemoteEvent
	return PerkRemote or Instance.new("RemoteEvent")
end

-- // Returns a ready up remote
function Util:RequestReadyUp() : RemoteEvent
	return ReadyUpRemote or Instance.new("RemoteEvent")
end

-- // Returns a slot purchase remote
function Util:RequestSlotPurchase() : RemoteEvent
	return PurchaseSlot or Instance.new("RemoteEvent")
end

-- // Returns a roll purchase remote
function Util:RequestRollPurchase() : RemoteEvent
	return PurchaseRoll or Instance.new("RemoteEvent")
end

return Util
-- // services
local replicated = game:GetService("ReplicatedStorage")

-- // directories
local Quirk = replicated.Quirk

-- // events
local DekuRemote   = Quirk.DekuOfa
local TomuraRemote = Quirk.TomuraAfo

-- // variables
local userData = workspace.S1c2R5i66p5t5s51.PlayerData

-- // functions

-- // will return whether the user can use a quirk or not
local function isCapable(user:player, quirk:string)
	local isNegative  = quirk == "Dofa" and 1 or -1
	local quirkReq    = quirk == "Dofa" and 3 or 26
	local levelReq    = 5000
	
	local PlayerData = userData:FindFirstChild(user.Name)
	local Quirk      = PlayerData:WaitForChild("Quirk")
	local Level      = PlayerData:WaitForChild("Level")
	local Fame       = PlayerData:WaitForChild("Fame")
	
	-- // checks quirk req / fame req / level req
	if Quirk.Value ~= quirkReq or (isNegative*Fame.Value) < 50000 or Level.Value < 5000 then return end
	
	Quirk.Value = quirk == "Dofa" and 13 or 34
	user:LoadCharacter()
end

DekuRemote.OnServerEvent:Connect(function(Player) isCapable(Player, "Dofa") end)
TomuraRemote.OnServerEvent:Connect(function(Player) isCapable(Player, "Tafo") end)
-- // Services
local replicated = game:GetService("ReplicatedStorage")

-- // directory
local remotes = replicated.Remotes

-- // events
local agility    = remotes.Agility
local durability = remotes.Durability
local strength   = remotes.Strength

-- // variables
local userCache = workspace.S1c2R5i66p5t5s51.PlayerData

-- // functions

local function isRealNumber(Val)
	return 0 <= math.abs(Val)
end

local function isCapable(user:player, amount:number, stat:string)
	if not amount then return end
	assert(stat, "User stat type nil: StatPointsService.")
	assert(isRealNumber(amount), "Value proided is not a real number.")
	
	local PlayerData = userCache:FindFirstChild(user.Name)
	local StatPoints = PlayerData:WaitForChild("StatPoints")
	local statVal    = PlayerData:WaitForChild(stat)
	
	if StatPoints.Value < amount or amount <= 0 then return end
	
	statVal.Value    += (math.floor(amount))
	StatPoints.Value -= (math.floor(amount))
end

agility.OnServerEvent:Connect(function(player,amount)    isCapable(player, amount, "Agility") end)
durability.OnServerEvent:Connect(function(player,amount) isCapable(player, amount, "Durability") end)
strength.OnServerEvent:Connect(function(player, amount)  isCapable(player, amount, "Strength") end)
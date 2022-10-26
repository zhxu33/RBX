-- // Codes rework
-- // services
local services = {}
services.run_service           = game:GetService("RunService")
services.tween_service         = game:GetService("TweenService")
services.player_service        = game:GetService("Players")
services.physics_service       = game:GetService("PhysicsService")
services.dataStore_service     = game:GetService("DataStoreService")
services.replicated            = game:GetService("ReplicatedStorage")
services.server_storage        = game:GetService("ServerStorage")
services.server_script_service = game:GetService("ServerScriptService")

-- // modules
local modules = {}

for _, child in pairs(script:GetChildren()) do
	if child:IsA("ModuleScript") then
		modules[child.Name] = require(child)
	end
end

-- // applying
for _, module in pairs(modules) do
	module._services = services
	module._modules  = modules
end

-- // Directories
local remotes = services.replicated.Remotes

-- // events
local codeRemote    = remotes.Code



-- // variables
local currentCodes = {
	--[[
	codeName = {
		expireDate = [Duration | os.Time() + 604800(1 week)],
		boosters   = {boosterName = {boost = 2} [THESE WILL BE FUNCTION NAMES EQUAL TO TABLE {BOOST}] },
	}
	]]
}

local debounceTable = {}

-- // code functions

codeRemote.OnServerEvent:Connect(function(player, code)
	-- // redeem will have a list of functions in which it will log the redeemed code
	-- // asserting will apply the boost to the player
	-- // get codes will only be used when getting the current codes list
end)

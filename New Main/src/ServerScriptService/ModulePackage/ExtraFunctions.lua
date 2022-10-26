-- // Services
local ServerScriptService = game:GetService("ServerScriptService")

-- // Folders
local CombatScripts = ServerScriptService.CombatScripts

-- // Variables
local module = {}

-- // Modules
local Settings = require(CombatScripts.Settings)

-- // Functions

-- // calculates the speed multiplier based on agility
function module:CalculateSpeed(Agility : number) : number
	local newMultiplier = 1
	
	if Agility >= Settings.Agility_Cap then
		newMultiplier = (Settings.Max_Speed/Settings.Default_Speed)
	else
		newMultiplier = ((Settings.Start_Speed/Settings.Default_Speed) + ((Settings.Speed_Per_Agility/Settings.Default_Speed) * Agility))
	end
	
	return newMultiplier
end

return module
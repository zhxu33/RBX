-- // Services

-- // Variables
local Mod           = {}
local MainFolder    = script.Parent
local MainModule    = MainFolder.Parent
local MethodsFolder = MainModule.Methods

-- // Modules
local Processor = require(MainFolder.Processor)

-- // Functions

-- // Processes raycasted objects
function Mod:Process(Result, Settings)
	if not Result then return end
	
	local RootPart = Processor:FindRootPartOfAncestor(Result.Instance) -- // So it only counts limbs
	local newInfo  = Processor:DeepCopy(Settings.HitInfo)
	newInfo.Result = Result
	
	-- // Checks if the hitbox can pass through objects
	if not Settings.PassThroughObjects and not RootPart then
		Settings._OnHit:Fire(nil, nil, Settings, newInfo)
		Settings._HasHit = true
		Processor.DestroyPart(Settings)
	end
	
	if not RootPart then return end
	Processor:Process({RootPart}, Settings, newInfo)
end

return Mod
-- // Services

-- // Variables
local Handler    = {}
Handler.Hitboxes = {}

local ParentFolder  = script.Parent
local Parent        = ParentFolder.Parent
local MethodsFolder = Parent.Methods

-- // Modules
local Processor     = require(ParentFolder.Processor)

-- // function

-- // The main loop for the hitbox
local isRunning = false

-- // checks if the hitbox is operational
local function CheckHitbox(hitboxSettings)
	-- // hitbox is not a table
	if not (type(hitboxSettings) == "table") then return end

	-- // hitbox is hit or removing
	if hitboxSettings._HasHit then return end

	-- // hitbox object doesn't exist
	if not (hitboxSettings.Object and hitboxSettings.Object.Parent) then return end

	-- // player doesn't exist
	if not (hitboxSettings.Player and hitboxSettings.Player.Parent) then return end

	return true
end

-- // checks if there are parts running in the hitbox
local function CheckIndex()
	for _, Hitbox in pairs(Handler.Hitboxes) do
		if not CheckHitbox(Hitbox) then
			Handler.Hitboxes[Hitbox.ID] = nil
			task.spawn(Processor.DestroyPart, Hitbox)
		else
			return true
		end
	end

	return false
end

-- // double checks hitbox index
local function ClearAllUnknown()
	if not isRunning then return end
	
	local isKnown = nil
	for _, Hitbox in pairs(Handler.Hitboxes) do
		if not CheckHitbox(Hitbox) then
			task.spawn(Processor.DestroyPart, Hitbox)
		else
			isKnown = true
		end
	end
	
	if not isKnown then isRunning = false end
end

-- // main hitbox function
local activeThread = nil
local function runHitbox()
	ClearAllUnknown()

	if isRunning then 
		if not (activeThread and coroutine.status(activeThread) == "suspended") then return end
		task.spawn(activeThread)
	end

	activeThread = task.spawn(function()
		if isRunning then return end
		isRunning = true

		while task.wait() and isRunning and CheckIndex() do
			local _CurrentTick = os.clock()

			for _, Hitbox in pairs(Handler.Hitboxes) do
				task.spawn(function()
					if CheckHitbox(Hitbox) then
						if (Hitbox._LastTick and (Hitbox._LastTick + Hitbox.Rate) > _CurrentTick) then
							Hitbox:UpdateWhitelist()
							return
						end
						Hitbox._LastTick = _CurrentTick

						Hitbox:HitboxMethod()
					elseif Hitbox._NotRemoved then
						task.delay(Hitbox.MoveDuration, Processor.DestroyPart, Hitbox)
					end
				end)
			end
		end

		isRunning = false
	end)
end

local Meta = {}
-- // Starting and stopping hitbox from running when there is or is not a index
Meta.__newindex = function(hitboxTable, index, value)
	if value == nil then -- // removes hitbox
		rawset(hitboxTable, index, nil)
	else -- // Adding new index / starting hitbox if it passes check
		local newIndex = tostring(tick()) .. index.Name .. value.Player.Name
		value.ID       = newIndex
		
		rawset(hitboxTable, newIndex, value)
		task.spawn(runHitbox)
	end
end

setmetatable(Handler.Hitboxes, Meta)
Processor._Hitboxes = Handler.Hitboxes

return Handler
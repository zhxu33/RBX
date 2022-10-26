 --[[
Mia / Kitsomia's Spatial Hitbox module

Information should be found in MoveSettings
]]
-- // Services
local RunService = game:GetService("RunService")

-- // Variables
local CastModule    = {}
local showVisual    = script:GetAttribute("DebugMode")
local MainFolder    = script.Main
local MethodsFolder = script.Methods

-- // Modules
local Initializer  = require(script.Initializer)
local MoveSettings = require(script.MoveSettings)
local Processer    = require(MainFolder.Processor)
local MainHandler  = require(MainFolder.MainHandler)

-- // Event that's fired letting anything listen know that something has been hit
-- // Arguments passed:
-- // (User:Character | Hitchar:Character | AttackId:String)
CastModule._OnHit = Instance.new("BindableEvent")
CastModule.OnHit  = CastModule._OnHit.Event
Processer._OnHit  = CastModule._OnHit

-- // self is the hitbox itself // Table is going to have specific information being sent
function CastModule:Add(Hitbox, Settings)
	local newSettings         = MoveSettings.new(Settings)
	newSettings.Object        = Hitbox
	newSettings.DebuggingMode = showVisual

	-- // Add hitbox to the table of selected hitbox type
	return Initializer:Setup(newSettings)
end

-- // Removes the hitbox from all the hitbox tables and optional
-- // requests are sent in a table {Optional Requests = false}
function CastModule:Remove(Hitbox:(Instance), Destroy:boolean) -- Table just has to exist, doesn't need to be a bool
	for index, List in pairs(MainHandler.Hitboxes) do
		if not List.Object or List.Object ~= Hitbox then continue end

		if List.Connection then List.Connection:Disconnect() end
		
		if Destroy then List.DestroyHitbox = true end
		Processer.DestroyPart(List)

		MainHandler.Hitboxes[index] = nil
		break
	end
end

-- // Returns the hitbox profile given the instance or id
function CastModule:GetProfile(Hitbox:any)
	assert(Hitbox, "Hitbox not provided or nil. (Check if you called the function with a ':')")
	local Type = typeof(Hitbox)

	if Type == "Instance" then
		for _, Profile in pairs(MainHandler.Hitboxes) do
			if Profile.Object ~= Hitbox then continue end
			return Profile
		end
	elseif Type == "string" then
		return MainHandler.Hitboxes[Hitbox]
	else
		warn(("Invalid hitbox identification. \nGiven type: %s \nIdentifiable types: string, Instance."):format(Type))
	end
end

-- // Returns the settings from MoveSettings
function CastModule:GetSettings()
	return MoveSettings:GetSettings()
end

-- // require(7496792123).DebugMode() 
-- // Meant for turning on and off the debug mode real time
local currentInDebug = {}
function CastModule.DebugMode()
	script:SetAttribute("DebugMode", not script:GetAttribute("DebugMode"))

	warn("Hitbox Debug mode: " .. tostring(script:GetAttribute("DebugMode") and "On" or "Off"))
end

script:GetAttributeChangedSignal("DebugMode"):Connect(function()
	showVisual = script:GetAttribute("DebugMode")
end)

return CastModule

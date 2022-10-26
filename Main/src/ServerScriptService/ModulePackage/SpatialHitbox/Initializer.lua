local Initialize = {}

 -- // Services \\ --
local PlayerService     = game:GetService("Players")
local RunService        = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

 -- // Directaries \\ --
local Parent     = script.Parent
local Methods    = Parent.Methods
local MainFolder = Parent.Main

 -- // Modules \\ --
local Processer = require(MainFolder.Processor)
local Handler   = require(MainFolder.MainHandler)

local Modules   = {}
for _, module in pairs(Methods:GetChildren()) do
	local reqMod = require(module)
	Modules[module.Name] = reqMod
end

 -- // Other \\ --

 -- // Gets the ignored objects from the ray
function Initialize:GetFullBody(Player, List)
	if not Player then return end
	table.clear(List.Whitelist)
	
	-- // Entering all baseparts of model to whitelist
	local function GetAllBaseParts(Model:Model)
		if Model == Player or not (Model and Model:IsA("Model")) then return end
		
		for _, baseParts in pairs(Model:GetChildren()) do
			if not baseParts:IsA("BasePart") then continue end
			table.insert(List.Whitelist, baseParts)
		end
	end
	
	-- // Getting and entering all tagged models
	local function GetAllTaggedModels(Tag, group)
		for _, child in pairs(CollectionService:GetTagged(Tag)) do
			GetAllBaseParts(child)
		end
		
		if group then
			for _, child in pairs(group) do
				GetAllBaseParts(child.Parent)
			end
		end
	end
	
	-- // Getting all parts within a player
	GetAllTaggedModels("Players", _G.PLRs)
	
	-- // Checking if the user is a player	
	if CollectionService:HasTag(Player, "Players") or not List.NPC then
		GetAllTaggedModels("NPCs", _G.NPCs)
	end
end

 -- // White list is grabbing all HumanoidRootParts 
 -- // from the game under the global variable _G.NPCs / game.Players
function Initialize:GetWhitelist(Player, List)
	if not Player then return end
	table.clear(List.Whitelist)
	
	-- // Enters root part within the hitbox system
	local function GetRootPart(Model:Model)
		if (Model == Player) or not (Model and Model:IsA("Model")) then return end
		local RootPart = Model:FindFirstChild("HumanoidRootPart")
		table.insert(List.Whitelist, RootPart)
	end
	
	-- // Getting and entering all tagged models
	local function GetAllTaggedModels(Tag, group)
		for _, child in pairs(CollectionService:GetTagged(Tag)) do
			GetRootPart(child)
		end
		
		if group then
			for _, child in pairs(group) do
				table.insert(List.Whitelist, child)
			end
		end
	end
	
	-- // checks whether user is a player
	if CollectionService:HasTag(Player, "Players") or not List.NPC then
		GetAllTaggedModels("NPCs", _G.NPCs)
	end
	GetAllTaggedModels("Players", _G.PLRs)
end

 -- // Sets a move duration for however long
 -- // the move will be visually present plus removes from hitbox table after destroyed
function Initialize:SetMoveDuration(Settings, HitboxTable)
	if not Settings.UseMoveDuration then return end
	
	table.insert(Settings.Threads, task.delay(Settings.MoveDuration, function()
		Processer.DestroyPart(Settings, HitboxTable)
	end))
end

-- // Leave empty
local function _Empty() end

-- // Get updated target list | Updates the whitelisted targets
local function UpdateWhitelist(self)
	if self.GetFullBody then 
		Initialize:GetFullBody(self.Player, self)
	else 
		Initialize:GetWhitelist(self.Player, self)
	end
end

-- // Type on return
type CustomBind = {
	Connect : (func : () -> any) -> RBXScriptConnection,
	Once : (func : () -> any) -> RBXScriptConnection,
	Wait : () -> ...any,
	DisconnectAll : () -> nil,
	GetFunctions : () -> { func : () -> ...any},
	GetConnections : () -> {RBXScriptConnection},
	GetSettings : () -> {any},
	GetExtraInfo : () -> {any},
	Pause : () -> nil,
	Play : () -> nil,
	Remove : (Destroy : boolean | nil) -> nil,
}

-- // Gets on hit methods
function Initialize:OnBind(Settings:table) : CustomBind
	local newTable = {}
	
	local Bind      = Instance.new("BindableEvent")
	Settings._OnHit = Bind -- // So it can be removed + backwards compatible
	Settings.OnHit  = newTable
	
	local Methods     = {}
	local Info        = setmetatable({}, Methods)
	Info._canConnect  = true
	Info._functions   = {}
	Info._connections = {}
	
	-- // Replicate connection
	function newTable:Connect(func)
		if not Info._canConnect then return end
		
		Info._functions[tostring(func)] = func
		local Con = Bind.Event:Connect(func)
		table.insert(Info._connections, Con)
		
		return Con
	end
	newTable.connect = newTable.Connect

	-- // Replicate wait
	function newTable:Wait()
		if not Info._canConnect then return end
		return Bind.Event:Wait()
	end
	newTable.wait = newTable.Wait
	
	-- // Replicate once
	function newTable:Once(func)
		local Con = self:Connect(func)
		
		task.spawn(function()
			func(self:Wait())
			Con:Disconnect()
			
			local found = table.find(Info._connections, Con)
			if found then table.remove(Info._connections, found) end
			
			Info._functions[tostring(func)] = nil
		end)
		
		return Con
	end
	newTable.once = newTable.Once
	
	-- // Disconnect
	function newTable:DisconnectAll()
		Info._canConnect = false
		for _, con in ipairs(Info._connections) do con:Disconnect() end
		table.clear(Info._connections)
		table.clear(Info._functions)
	end

	-- // Other
	function newTable:GetFunctions()
		return Info._functions
	end

	-- // Get connections
	function newTable:GetConnections()
		return Info._connections
	end

	-- // Original settings
	function newTable:GetSettings()
		return Settings
	end

	-- // Gets extra info
	function newTable:GetExtraInfo()
		return Info
	end

	-- // Fire event (Don't use)
	function newTable:Fire(...)
		Bind:Fire(...)
	end
	newTable.fire = newTable.Fire
	
	-- // Removes hitbox from table
	function newTable:Remove(Destroy:boolean)
		Processer.DestroyPart(Settings)
	end
	
	-- // Pauses the hitbox
	Settings._isPaused = false
	local _PrevRate    = Settings.Rate
	function newTable:Pause()
		if Settings._isPaused then return end
		Settings._isPaused = true
		_PrevRate = Settings.Rate
		Settings.Rate = 10000000 -- // Large amount of seconds
	end
	
	-- // Resumes a paused hitbox
	function newTable:Play()
		if not (Settings._isPaused) then return end
		Settings._isPaused = false
		Settings.Rate = _PrevRate
	end
	
	newTable.__index       = Info    -- // So they're easier to remove automatically
	newTable.__methodIndex = Methods
	
	return newTable
end

-- // Sets up all the main ingredients
function Initialize:Setup(Settings, ...) : CustomBind
	Settings.HitboxType   = Settings.HitboxType:lower()
	
	-- // Main stuff
	local Hitbox             = Modules[Settings.HitboxType]
	Settings.Initializer     = Hitbox.Initializer     or _Empty
	Settings.HitboxMethod    = Hitbox.HitboxMethod    or _Empty
	Settings.Debug           = Settings.DebuggingMode and Hitbox.Debug or _Empty
	Settings.UpdateWhitelist = UpdateWhitelist
	
	-- // Other
	local Binded = Initialize:OnBind(Settings)
	table.insert(Settings.Blacklist, Settings.Parent or Settings.Object)
	table.insert(Settings.Blacklist, Settings.Player)
	
	-- // Doing initialization for hitbox if it has one
	Settings._NotRemoved = true
	Settings:UpdateWhitelist()
	Settings:Initializer()
	
	-- // Need to be last
	self:SetMoveDuration(Settings, ...)
	Handler.Hitboxes[Settings.Object] = Settings
	
	return Binded
end

return Initialize

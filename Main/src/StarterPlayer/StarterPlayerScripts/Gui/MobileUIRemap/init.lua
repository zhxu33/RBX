-- // Services
local RunService       = game:GetService("RunService")
local ContextService   = game:GetService("ContextActionService")
local PlayerService    = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Replicated       = game:GetService("ReplicatedStorage")
local TweenService     = game:GetService("TweenService")

-- // Variables
local Player        = PlayerService.LocalPlayer
local PlayerGui     = Player:WaitForChild("PlayerGui")
local PlayerScripts = Player:WaitForChild("PlayerScripts")
local mouse         = Player:GetMouse()
local isMobile      = UserInputService.TouchEnabled
if not (isMobile) then return {}; end

-- // Replicated variables
local remotes      = Replicated:FindFirstChild("Remotes")
local GetSettings  = remotes:WaitForChild("GetSettings")
local SaveSettings = remotes:WaitForChild("SaveSettings")

-- // Mobile Gui
local mobile_gui = PlayerGui:WaitForChild("MobileGui")
local touch_gui  = PlayerGui:WaitForChild("TouchGui")
local custom_map = mobile_gui:Clone()

local remap_hud      = script.Hud:Clone()
local exit_button    = remap_hud.Exit
local save_button    = remap_hud.Save
local undo_button    = remap_hud.Undo
local default_button = remap_hud.Default

remap_hud.Visible = false
remap_hud.Parent  = mobile_gui

local options  = script.Options -- // Options for use
local selected = nil -- // 

local Remap            = {} -- // obj
local screen_gui_cache = {} -- // Caches previous gui data
local default_gui_map  = {} -- // Default way the gui will look
local key_data         = default_gui_map -- // changed data in guis

for _, button in ipairs(mobile_gui.Frame:GetChildren()) do
	local properties    = {}
	local Position = button.Position
	local Size     = button.Size
	properties.Position = {Position.X.Scale, Position.Y.Scale}
	properties.Size     = {Size.X.Scale, Size.Y.Scale}
	default_gui_map[button.Name] = properties
end

-- // Modules
local ChatCommands = require(PlayerScripts:WaitForChild("ClientCommands"):WaitForChild("Commands"))

-- // Functions

-- // Turns on & off screen guis
function Remap:ToggleGUIs(bool)
	if not (next(screen_gui_cache)) then -- // No found instances in cache
		for _, screen_gui in ipairs(PlayerGui:GetChildren()) do
			if not (screen_gui:IsA("ScreenGui") and screen_gui ~= mobile_gui) then continue end
			screen_gui_cache[screen_gui] = screen_gui.Enabled
		end
	end

	for screen_gui, enabled in pairs(screen_gui_cache) do
		screen_gui.Enabled = (bool and enabled) or false
	end
end

-- // Checks if the mouse is currently in the bounds of obj
local function IsMouseBoundedByFrame(Frame)
	local AbsPosition = Frame.AbsolutePosition
	local AbsSize     = Frame.AbsoluteSize
	local topLeft     = AbsPosition
	local bottomRight = AbsPosition + AbsSize

	local mousePos = Vector2.new(mouse.X, mouse.Y)

	-- // right of frame
	if mousePos.X > bottomRight.X then
		return false
	end

	-- // left of frame
	if mousePos.X < topLeft.X then
		return false
	end

	-- // Above the frame
	if mousePos.Y < AbsPosition.Y then 
		return false
	end

	-- // below the frame
	if mousePos.Y > bottomRight.Y then 
		return false
	end

	return true
end

-- // Applies properties to obj
local function ApplyProperties(obj, properties)
	for property, value in pairs(properties) do
		obj[property] = UDim2.fromScale(table.unpack(value))
	end
end

-- // Converts a UDim to scale
local function OffsetToScale(Udim : UDim2)
	local screenSize = mobile_gui.AbsoluteSize
	local extraScale = UDim2.fromScale(Udim.X.Offset / screenSize.X, Udim.Y.Offset / screenSize.Y)

	return (UDim2.fromScale(Udim.X.Scale, Udim.Y.Scale) + extraScale)
end

-- // removing and deleting a table or value
local function DisposeInfo(info)
	local Type = typeof(info)

	if Type == "table" then
		for index, value in pairs(info) do
			info[index] = DisposeInfo(value)
		end
		table.clear(info)
	elseif Type == "RBXScriptConnection" then
		info:Disconnect()
	elseif Type == "thread" and coroutine.status(info) == "suspended" then
		task.cancel(info)
	elseif Type == "Instance" then
		info:Destroy()
	end

	return nil
end

-- // Deep copies the value
local function DeepCopy(oldVal)
	local isTable  = type(oldVal) == "table"
	local newTable = isTable and {} or oldVal

	if isTable then
		for TableIndex, Value in pairs(oldVal) do
			newTable[TableIndex] = DeepCopy(Value)
		end
	end

	return newTable
end

-- // Disconnects connection if it exists
local function Disconnect(connection)
	if not (connection) then return end

	if connection and connection.Connected then connection:Disconnect() end
end

-- // tweens 
function Remap:NewOptions()
	local methods   = {}
	methods.__index = methods

	local newFile = setmetatable({}, methods)
	newFile.Obj   = options:Clone()

	methods._Tweens        = {}
	methods._Focus         = nil
	methods._FocusData     = {}
	methods._Connections   = {}
	methods._TweenDuration = .1
	methods._Connected     = true -- // If false or nil, cannot add new focus

	-- // Defaults for tweening purposes
	local options_defaults = {}
	for _, value in ipairs(newFile.Obj:GetDescendants()) do
		if value.ClassName == "UICorner" or value.ClassName == "UIGradient" then continue end

		if value.ClassName == "UIStroke" then
			local properties        = {}
			properties.Transparency = value.Transparency
			properties.Color        = value.Color
			options_defaults[value] = properties

			continue
		end

		local properties = {}
		properties.BackgroundTransparency = value.BackgroundTransparency
		properties.BackgroundColor3       = value.BackgroundColor3
		properties.ImageTransparency      = value.ImageTransparency
		properties.ImageColor3            = value.ImageColor3

		options_defaults[value] = properties
	end

	local properties = {}
	properties.BackgroundTransparency = newFile.Obj.BackgroundTransparency
	properties.BackgroundColor3       = newFile.Obj.BackgroundColor3
	properties.ImageTransparency      = newFile.Obj.ImageTransparency
	properties.ImageColor3            = newFile.Obj.ImageColor3
	options_defaults[newFile.Obj] = properties

	-- // Repositions the box if bounding box is off screen
	function methods:CheckPositionBoundingBox()
		local ABSOLUTE_SIZE   = mobile_gui.AbsoluteSize

		local parentPosition  = newFile.Obj.Parent.AbsolutePosition
		local parentSize      = newFile.Obj.Parent.AbsoluteSize
		local currentSize     = newFile.Obj.AbsoluteSize
		local currentPosition = newFile.Obj.AbsolutePosition

		-- // Checking if the position of the options is off screen on the X axis (1920 x 1080 ex: 1081 > 1080)
		local right   = parentPosition.X + parentSize.X -- // Top Right (Defaults if capable)
		local top     = parentPosition.Y

		local offsetX    = right + currentSize.X
		if offsetX > ABSOLUTE_SIZE.X then
			newFile.Obj.Position    = UDim2.fromScale(0, 0)
			newFile.Obj.AnchorPoint = Vector2.new(1, 1) -- // Forces it to be on the left
		else -- // Make it go back to the right
			newFile.Obj.Position    = UDim2.fromScale(1, 0)
			newFile.Obj.AnchorPoint = Vector2.new(0, 1)
		end

		parentPosition   = newFile.Obj.Parent.AbsolutePosition
		currentPosition  = newFile.Obj.AbsolutePosition
		local bottomLeft = Vector2.new(parentPosition.X, parentPosition.Y + parentSize.Y)

		local extrude       = newFile.Obj.Extrude
		extrude.AnchorPoint = Vector2.new(1, 0)
		local offset        = (bottomLeft - currentPosition)
		local newPosition   = offset
		extrude.Position    = UDim2.fromScale(newPosition.X/currentSize.X, newPosition.Y/currentSize.Y)

		local offsetY  = top - currentSize.Y
		if (offsetY < 0) and not (newFile.Obj.Position.Y.Scale == 1) then -- // Y is 0 -> 1 (top to bottom)
			newFile.Obj.Position    += UDim2.fromScale(0, 1)
			newFile.Obj.AnchorPoint -= Vector2.new(0, 1) -- // Forces it to be on the left
			extrude.Position        = UDim2.fromScale(((offsetX > ABSOLUTE_SIZE.X) and 0 or 1), 0) -- // If gui is on the right, make extrude on right else, left
			extrude.AnchorPoint     = Vector2.new(((offsetX > ABSOLUTE_SIZE.X) and 1 or 0), 0)
		elseif (newFile.Obj.Position.Y.Scale == 1) then -- // Make it go back to the right
			newFile.Obj.Position   -= UDim2.fromScale(0, 1)
		end
	end

	-- // Repositions the options to match selected icon size
	function methods:Reposition()
		self:CheckPositionBoundingBox() -- // Everything is based on scale, otherwise it would have been fine
	end

	-- // Drags the icon around where the player' last touched
	function methods:Drag()
		local parent = newFile.Obj.Parent

		return RunService.RenderStepped:Connect(function()
			local position    = Vector2.new(mouse.X, mouse.Y)
			local newPosition = OffsetToScale(UDim2.fromOffset(position.X, position.Y))
			parent.Position   = newPosition

			self:CheckPositionBoundingBox()
		end)
	end

	-- // Enlarges the icon
	function methods:ScaleIcon()
		local parent         = newFile.Obj.Parent
		local parentPosition = parent.AbsolutePosition + parent.AbsoluteSize/2
		local extrudeSize    = newFile.Obj.Extrude.AbsoluteSize/2

		local connection = nil

		return RunService.RenderStepped:Connect(function()
			local position = Vector2.new(mouse.X, mouse.Y)
			local distance = math.clamp((position - parentPosition).Magnitude, 15, 200)
			local newSize  = OffsetToScale(UDim2.fromOffset(distance, distance))
			parent.Size    = newSize

			self:CheckPositionBoundingBox()
		end)
	end

	-- // gets the new data if saved
	function methods:GetData()
		return DeepCopy(self._FocusData)
	end

	-- // Gets the data of the current focus
	function methods:GetFocusData()
		return self:GetData()[self._Focus.Name]
	end

	-- // Updates the cached data
	function methods:UpdateData()
		local prevFile = self._FocusData[self._Focus.Name]

		local newData  = {}
		local Position = self._Focus.Position
		local Size     = self._Focus.Size
		newData.Position = {Position.X.Scale, Position.Y.Scale}
		newData.Size     = {Size.X.Scale, Size.Y.Scale}

		self._FocusData[self._Focus.Name] = newData

		if (prevFile) then -- // This way there'll always be data there
			table.clear(prevFile)
		end
	end

	-- // Accepting new data to be saved
	function methods:Accept()
		self:UpdateData()
	end

	-- // Makes the icon go back to where it used to be
	function methods:Cancel()
		if not (self._Focus) then return end
		local prevData = self:GetFocusData()

		ApplyProperties(self._Focus, prevData)
	end

	-- // Cancels all tweens
	local function cancelTweens()
		for _, value in ipairs(newFile._Tweens) do
			value:Cancel()
		end

		table.clear(newFile._Tweens)
	end

	-- // Hides the options UI
	function methods:Hide()
		cancelTweens()
		local lastTween = nil

		for object, _ in pairs(options_defaults) do
			local properties        = {}
			if object.ClassName == "UIStroke" then
				properties.Transparency = 1
			else
				properties.BackgroundTransparency = 1
				properties.ImageTransparency = 1
			end

			lastTween = TweenService:Create(object, TweenInfo.new(self._TweenDuration), properties)
			lastTween:Play()
			table.insert(self._Tweens, lastTween)
		end

		return lastTween
	end

	-- // Shows the options menu
	function methods:Show()
		cancelTweens()
		local lastTween = nil

		for object, properties in pairs(options_defaults) do
			lastTween = TweenService:Create(object, TweenInfo.new(self._TweenDuration), properties)
			lastTween:Play()
			table.insert(self._Tweens, lastTween)
		end

		return lastTween
	end

	-- // Disconnects connections with name
	function methods:Disconnect(conName)
		if not (conName) then return end

		local connection = self._Connections[conName]
		if not (connection) then return end

		connection:Disconnect()
		self._Connections[conName] = nil
	end

	-- // Disconnects all known connections
	function methods:DisconnectAll()
		for _, connection in pairs(self._Connections) do
			Disconnect(connection)
		end

		table.clear(self._Connections)
	end

	-- // Adds a new connection to connection list
	function methods:Connect(conName, connection : RBXScriptConnection)
		if not (connection) then return end
		if not (conName) then
			table.insert(self._Connections, connection)

			return connection
		end

		self._Connections[conName] = connection
		return connection
	end

	-- // Adds new connections for focused object
	function methods:ConnectFocus()
		local inUse    = false
		local newFocus : ImageButton = self._Focus
		local prevConnection = nil

		-- // Drags the icon around
		self:Connect("icon_drag", newFocus.InputBegan:Connect(function(inputObject : InputObject)
			self:Show()
			if inUse then return end
			inUse = true

			-- // Need it to be a tap
			if not (inputObject.UserInputType == Enum.UserInputType.Touch) then return end
			Disconnect(prevConnection)
			prevConnection = self:Drag()
		end))

		-- // Scales the icon
		self:Connect("icon_scale", self.Obj.Extrude.InputBegan:Connect(function(inputObject : InputObject)
			if inUse then return end
			inUse = true

			-- // Need it to be a tap
			if not (inputObject.UserInputType == Enum.UserInputType.Touch) then return end
			Disconnect(prevConnection)
			prevConnection = self:ScaleIcon()
		end))

		-- // Removing scale or drag connections
		self:Connect("input_up", UserInputService.InputEnded:Connect(function(inputObject : InputObject)
			if not (inUse) then return end
			Disconnect(prevConnection)
			inUse = false
		end))

		-- // Removing scale or drag connections
		self:Connect("input_down", UserInputService.InputBegan:Connect(function(inputObject : InputObject)
			if (inUse) then return end

			-- // if the mouse is in the bounds of any of these guis, then it will not hide gui
			if (IsMouseBoundedByFrame(self._Focus) or IsMouseBoundedByFrame(self.Obj.Extrude) or IsMouseBoundedByFrame(self.Obj)) then
				return
			end

			Disconnect(prevConnection)
			self:Hide()
		end))

		-- // Accepting new changes to icon
		self:Connect("accept_change", self.Obj.Confirm.Activated:Connect(function()
			self:Accept()
			self:Hide()
		end))

		-- // Declining new change to icon
		self:Connect("decline_change", self.Obj.Cancel.Activated:Connect(function()
			self:Cancel()
			self:Hide()
		end))
	end

	-- // Sets the selected focus of options to object
	function methods:SetFocus(button)
		if (button == self._Focus) then return end
		if not (button) then return end
		if not (self._Connected) then return end

		self:DisconnectAll()
		self:Cancel()
		self:Hide().Completed:Wait()
		self._Focus = button
		self.Obj.Parent = button
		self:UpdateData()
		self:Reposition()
		self:Show()
		self:ConnectFocus()
	end

	-- // Removes the current focus
	function methods:RemoveFocus()
		if not (self._Focus) then return end
		if not (self._Connected) then return end

		self:DisconnectAll()
		self:Cancel()
		self:Hide().Completed:Wait()
		self._Focus = nil
	end

	-- // Applies a map to current buttons on map
	function methods:ApplyMap(Map)
		local prevMap   = self._FocusData
		self._FocusData = DeepCopy(Map)
		DisposeInfo(prevMap)
	end

	-- // Removes the options object
	function methods:Destroy()
		self._Connected = false
		self._Focus     = nil
		self:DisconnectAll()
		self:Hide().Completed:Wait()

		methods.__index = nil -- // Otherwise there'll be a stack overflow
		DisposeInfo(options_defaults)
		DisposeInfo(methods)
		DisposeInfo(self)
	end

	-- // Pre-hiding it
	newFile:Hide()

	return newFile
end

-- // Applies the current map
function Remap:ApplyCurrentMap()
	local gui_map = key_data
	for index, properties in pairs(gui_map) do
		ApplyProperties(mobile_gui.Frame[index], properties)
	end
end

function Remap:UpdateCurrentMap(newMap)
	key_data = newMap or key_data
end

-- // Toggles on the remapping option 
-- // so then players can start to customize their layout
function Remap:RemapUILayout()
	if remap_hud.Visible then return end
	remap_hud.Visible = true
	self:ToggleGUIs(false)
	
	local currentMap = mobile_gui.Frame
	local newConfig  = currentMap:Clone()
	currentMap.Visible = false
	newConfig.Parent   = mobile_gui

	local connections = {}
	local options = self:NewOptions()

	for _, button in ipairs(newConfig:GetChildren()) do
		table.insert(connections, button.Activated:Connect(function()
			options:SetFocus(button)
		end))
	end

	table.insert(connections, undo_button.Activated:Connect(function()
		options:RemoveFocus()

		local gui_map = key_data
		options:ApplyMap(gui_map)
		for index, properties in pairs(gui_map) do
			ApplyProperties(newConfig[index], properties)
		end
	end))

	table.insert(connections, save_button.Activated:Connect(function()
		self:UpdateCurrentMap(options:GetData())
		SaveSettings:FireServer({Remap = {Toggled = key_data}})
	end))

	table.insert(connections, default_button.Activated:Connect(function()
		options:RemoveFocus()
		
		local gui_map = default_gui_map
		options:ApplyMap(gui_map)
		for index, properties in pairs(gui_map) do
			ApplyProperties(newConfig[index], properties)
		end
	end))

	exit_button.Activated:Wait()
	local newMap = options:GetData()

	if (newMap) then
		for index, properties in pairs(newMap) do
			ApplyProperties(currentMap[index], properties)
		end
	end

	options:Destroy()
	options = nil
	DisposeInfo(connections)
	DisposeInfo(newConfig)

	currentMap.Visible = true
	remap_hud.Visible  = false
	self:ToggleGUIs(true)
	
	return newMap
end

local function RemapCommand()
	Remap:RemapUILayout()
end

ChatCommands:AddCommand("Remap", 
	{
		Command     = RemapCommand, 
		Shortcuts   = {}, 
		Toggled     = nil, 
		Name        = "Remap", 
		Description = "Allows the player to customize their mobile gui (Mobile)."
	})

-- // Applies the current saved map (since gui resets each death)
Player.CharacterAdded:Connect(function()
	Remap:ToggleGUIs(true)
	
	if not (mobile_gui.Parent) then
		mobile_gui = PlayerGui:WaitForChild("MobileGui")
		remap_hud  = script.Hud:Clone()
		remap_hud.Visible = false
		remap_hud.Parent  = mobile_gui
	end
	
	if not (remap_hud.Parent) then
		remap_hud  = script.Hud:Clone()
		remap_hud.Visible = false
		remap_hud.Parent  = mobile_gui
	end
	
	exit_button    = remap_hud.Exit
	save_button    = remap_hud.Save
	undo_button    = remap_hud.Undo
	default_button = remap_hud.Default
	
	Remap:ApplyCurrentMap()
end)

local Settings = GetSettings:InvokeServer()
local Keymap = Settings.Remap
Remap:UpdateCurrentMap(Keymap)
Remap:ApplyCurrentMap()

-- // Deals with saving the gui remap

return Remap
-- // Services
local Replicated    = game:GetService("ReplicatedStorage")
local TweenService  = game:GetService("TweenService")
local PlayerService = game:GetService("Players")
local ContextAction = game:GetService("ContextActionService")
local RunService    = game:GetService("RunService")
local UserInput     = game:GetService("UserInputService")

-- // Variables
local Player     = PlayerService.LocalPlayer
local PlayerGui  = Player.PlayerGui

-- Gui
local MapGui  = PlayerGui:WaitForChild("MapGui")
local Gui     = MapGui.NPCstats
local BHolder = MapGui:WaitForChild("ButtonHolder")

local PlusButton    = script.Parent

-- Mods
local infoMod       = require(Replicated:WaitForChild("Modules"):WaitForChild("InfoModule"))
local OtherNPCs     = infoMod.MiscNpcs
local NPCDexModule  = infoMod.NPCDex
local QuestInfo     = infoMod.QuestInfo

-- Misc
local Camera      = workspace.CurrentCamera
local SearchBar   = MapGui.SearchBar
local ZoomCFrame  = CFrame.new(0, 3752.198, 0, 0.00194969412, 0.987689972, -0.156411991, -0, 0.156412303, 0.98769182, 0.999998152, -0.00192569697, 0.000304956106)
local Zoomed      = false
local Huge        = math.huge
local ActiveTween = nil

local Beacons = workspace.Beacons
local WasCooldownEnabled

-- Info
local currentSearched   = {}
local AllNpcs           = {}
local VillainNpcs       = {}
local HeroNpcs          = {}
local InteractiveNPCs   = {}
local PreviousGui
local TargetNpc, TargetRoot, RecommendedAttach = nil, nil, nil -- // Meant for tracking npc

-- // Doing the loading business
local loadingGui = PlayerGui:FindFirstChild("LoadingScreen")
if loadingGui and loadingGui.Enabled then loadingGui:GetPropertyChangedSignal("Enabled"):Wait() end
local intro = PlayerGui:FindFirstChild("IntroGui")
if intro and intro.Menu.Visible then intro.Menu:GetPropertyChangedSignal("Visible"):Wait() end
task.wait(2) -- // Because everything else needs to load first I guess-

local NPCLocationFolder  = Instance.new("Folder")
NPCLocationFolder.Name   = "NPC_Marker"
NPCLocationFolder.Parent = workspace

-- // Turns on & off screen guis
local screen_gui_cache = {}
local function AddGuiToCache(screen_gui)
	if not (screen_gui:IsA("ScreenGui") and screen_gui ~= MapGui and screen_gui.Name ~= "LoadingScreen") then return end
	screen_gui_cache[screen_gui] = screen_gui.Enabled
end

local function RemoveGuiFromCache(screen_gui)
	if not (screen_gui:IsA("ScreenGui")) then return end
	screen_gui_cache[screen_gui] = nil
end

local function ToggleGUIs(bool)
	if not (next(screen_gui_cache)) then -- // No found instances in cache
		for _, screen_gui in ipairs(PlayerGui:GetChildren()) do
			AddGuiToCache(screen_gui)
		end
	end

	for screen_gui, enabled in pairs(screen_gui_cache) do
		screen_gui.Enabled = (bool and enabled) or false
	end
end
ToggleGUIs(true)

PlayerGui.ChildAdded:Connect(AddGuiToCache)
PlayerGui.ChildRemoved:Connect(RemoveGuiFromCache)

-- // Disconnects connection if it exists
local function Disconnect(connection)
	if not (connection) then return end

	if connection and connection.Connected then connection:Disconnect() end
end

-- // toggles the current move binds for the player
local speed    = 25
local isBinded = false
local mobile_end_connection
local mobile_pos_connection

local function MobileMove(isMobile)
	if not isMobile then return end

	local touchGui   = PlayerGui.TouchGui
	touchGui.Enabled = true
	local controlGui = touchGui:WaitForChild("TouchControlFrame")
	local thumbStick = controlGui:WaitForChild("DynamicThumbstickFrame")

	local startStick = thumbStick:WaitForChild("ThumbstickStart")
	local endStick   = thumbStick:WaitForChild("ThumbstickEnd")
	
	local zero      = Vector2.zero
	local direction = Vector2.zero
	
	local isTouch = false
	mobile_end_connection = endStick:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
		if (endStick.ImageTransparency < .5) then isTouch = true; return end
		direction = zero
		isTouch = false
	end)

	mobile_pos_connection = endStick:GetPropertyChangedSignal("Position"):Connect(function()
		if not (isTouch and isBinded) then return end
		local startPos = startStick.AbsolutePosition - Vector2.new(0, 32) -- // Some how calculations were off by 32 pixels
		local endPos   = endStick.AbsolutePosition + Vector2.new(32, 0)

		-- // If the start pos is the end pos, just set all values to nil
		if (startPos == endPos) then
			direction = zero
			return
		end
		
		direction = (startPos - endPos).Unit -- // This gives direction from start
	end)
	
	repeat
		Camera.CFrame *= CFrame.new(-speed * direction.X, speed * direction.Y, 0)
		RunService.RenderStepped:Wait()
		if direction == zero then
			endStick:GetPropertyChangedSignal("Position"):Wait()
		end
	until not (isBinded)
	
	Disconnect(mobile_end_connection)
	Disconnect(mobile_pos_connection)
end

local function MoveMap(info)
	local direction = info[2]
	local keyName   = info[1]
	
	return function(inputObject : InputObject)
		if info[3] then
			info[3] = false
		else
			info[3] = true
			
			repeat
				Camera.CFrame *= CFrame.new(speed * direction.X, speed * direction.Y, 0)
				RunService.RenderStepped:Wait()
			until not (info[3] and isBinded)
		end
	end
end

local bindNames = {
	Left     = {"Map_Move_Left",     Vector2.new(-1, 0), false}, 
	Right    = {"Map_Move_Right",    Vector2.new(1, 0),  false}, 
	Forward  = {"Map_Move_Forward",  Vector2.new(0, 1),  false}, 
	Backward = {"Map_Move_Backward", Vector2.new(0, -1), false},
}

local function ToggleBinds(bool)
	isBinded = bool
	if not (bool) then
		for _, bindInfo in pairs(bindNames) do
			ContextAction:UnbindAction(bindInfo[1])
			bindInfo[3] = false
		end
		RunService.Stepped:Wait() -- // Making sure all binds are removed
	elseif (bool) then
		ContextAction:BindAction(bindNames.Left[1],     MoveMap(bindNames.Left),     false, Enum.KeyCode.A)
		ContextAction:BindAction(bindNames.Backward[1], MoveMap(bindNames.Backward), false, Enum.KeyCode.S)
		ContextAction:BindAction(bindNames.Right[1],    MoveMap(bindNames.Right),    false, Enum.KeyCode.D)
		ContextAction:BindAction(bindNames.Forward[1],  MoveMap(bindNames.Forward),  false, Enum.KeyCode.W)
		
		task.spawn(MobileMove, UserInput.TouchEnabled)
	end
end

-- // when a user clicks on a active billboard 
-- // prompts and shows what npcs do & give
local function Clickon(Name, Beacon, Root, npcType, NPCNameP)
	if PreviousGui then
		local Beacon = (PreviousGui.Adornee or NPCNameP.Adornee)
		if Beacon and Beacon.Parent then
			if ActiveTween then ActiveTween:Cancel() end
			Beacon.Transparency = 0.5
			ActiveTween = TweenService:Create(Camera, TweenInfo.new(1), {CFrame = CFrame.new(Beacon.Position.X-100, 2752.198, Beacon.Position.Z, 0.00194969412, 0.987689972, -0.156411991, -0, 0.156412303, 0.98769182, 0.999998152, -0.00192569697, 0.000304956106)})
			ActiveTween:Play()
			
			Gui.Visible = (Gui.nameText.Text ~= Name) or false
			PreviousGui = (PreviousGui == NPCNameP and PreviousGui)
		end
	end
	
	if PreviousGui then return end
	if ActiveTween then ActiveTween:Cancel() end
	
	PreviousGui = NPCNameP
	Beacon.Transparency = 0.1
	
	ActiveTween = TweenService:Create(Camera, TweenInfo.new(1), {CFrame = CFrame.new(Beacon.Position.X-100, 2752.198, Beacon.Position.Z, 0.00194969412, 0.987689972, -0.156411991, -0, 0.156412303, 0.98769182, 0.999998152, -0.00192569697, 0.000304956106)})
	ActiveTween:Play()
	ActiveTween.Completed:Wait()
	
	NPCNameP = Player.PlayerGui.UIStorage.Idle
	
	if NPCDexModule.NPCs[Name] and not Root.Parent:FindFirstChild("Npc") then
		local Re = NPCDexModule.NPCs[Name].Rewards
		Gui.nameText.Text   = Name
		Gui.npcType.Text    = npcType
		Gui.expText.Text    = "Exp: "..Re.EXP
		Gui.healthText.Text = "Health: "..tostring(Root.Parent.Humanoid.MaxHealth/10).." | "..tostring(math.floor((Root.Parent.Humanoid.Health/Root.Parent.Humanoid.MaxHealth)*100)).."%"
		Gui.fameText.Text   = "Fame: "..Re.Fame
		Gui.dropText.Text   = "Drop: "..Re.Item
		Gui.Visible         = true
	elseif QuestInfo[Name] then
		local Re = QuestInfo[Name].Info
		Gui.nameText.Text   = Name
		Gui.npcType.Text    = "Quest"
		Gui.expText.Text    = "Cash: "..Re.Cash
		Gui.healthText.Text = Re.Name.." | "..Re.KillsNeeded.."."
		Gui.fameText.Text   = "Rewards ↓"
		Gui.dropText.Text   = "Exp: "..Re.Experience
		Gui.Visible         = true
	elseif OtherNPCs[Name] then
		local Re = OtherNPCs[Name]
		Gui.nameText.Text   = Name
		Gui.npcType.Text    = npcType
		Gui.healthText.Text = Re.Description
		Gui.fameText.Text   = Re.Description2
		Gui.expText.Text    = Re.Description3
		Gui.dropText.Text   = Re.Description4
		Gui.Visible         = true
	else
		Gui.Visible         = false
	end
end

-- // Makes beacons for all npcs associated with all values of the passed table
local function PlantBeacon(NPCTable)
	for i=1,#NPCTable do
		local Root = NPCTable[i]:FindFirstChild("HumanoidRootPart")
		if not Root then continue end
		
		local NPCL   = NPCTable[i].HumanoidRootPart.Position
		local Attach = NPCTable[i]:FindFirstChild("PlaceValue")
		if Attach then
			NPCL             = Attach.Value.WorldPosition
			Attach           = Attach.Value
		end
		local Beacon         = Instance.new("Part")
		Beacon.Shape         = "Cylinder"
		Beacon.Size          = Vector3.new(650, 10, 10)
		Beacon.Position      = Vector3.new(NPCL.X, NPCL.Y + 325, NPCL.Z) 
		Beacon.Anchored      = true
		Beacon.CanCollide    = false
		Beacon.CanTouch      = false
		Beacon.Transparency  = 0.5
		Beacon.Orientation   = Vector3.new(0, -90, 90)
		Beacon.BottomSurface = 0
		Beacon.TopSurface    = 0
		Beacon.Material      = "Neon"

		local NPCNameP                 = Instance.new("BillboardGui")
		NPCNameP.Size                  = UDim2.new(0, 120, 0, 30)
		NPCNameP.StudsOffsetWorldSpace = Vector3.new(325, 0, 0)
		NPCNameP.Active                = true
		NPCNameP.MaxDistance           = Huge
		NPCNameP.AlwaysOnTop           = true

		local NPCName                  = Instance.new("TextButton")
		NPCName.Size                   = UDim2.new(1,0,1,0)
		NPCName.BackgroundColor3       = Color3.fromRGB(36, 42, 44)
		NPCName.BackgroundTransparency = .25
		NPCName.Font                   = Enum.Font.FredokaOne
		NPCName.TextStrokeTransparency = .5
		NPCName.TextScaled             = true
		NPCName.BorderSizePixel        = 0
		NPCName.Parent                 = NPCNameP
		
		SearchBar.UICorner:Clone().Parent = NPCName
		local stroke  = SearchBar.UIStroke:Clone()
		stroke.Parent = NPCName
		
		local npcType

		if NPCTable[i]:FindFirstChild("Npc") then
			InteractiveNPCs[Root] = {beacon = Beacon, billboard = NPCNameP}
			Beacon.BrickColor  = BrickColor.Black()
			NPCName.TextColor3 = Color3.fromRGB(253, 203, 110)
			npcType            = "Interactive"
		elseif NPCTable[i].Fame.Value  > 0 then -- Hero
			HeroNpcs[Root]     = {beacon = Beacon, billboard = NPCNameP}
			Beacon.BrickColor  = BrickColor.Blue()
			NPCName.TextColor3 = Color3.fromRGB(145, 209, 255)
			npcType            = "Hero"
		elseif NPCTable[i].Fame.Value  < 0 then -- Villain
			VillainNpcs[Root]         = {beacon = Beacon, billboard = NPCNameP}
			Beacon.BrickColor  = BrickColor.Red()
			NPCName.TextColor3 = Color3.fromRGB(255, 145, 145)
			npcType            = "Villain"
		end
		
		AllNpcs[Root]         = {beacon = Beacon, billboard = NPCNameP}
		AllNpcs[Root].Name    = NPCTable[i].Name
		AllNpcs[Root].NPCType = npcType
		
		NPCName.Text     = NPCTable[i].Name
		stroke.Color     = NPCName.TextColor3
		
		Beacon.Parent          = Beacons
		NPCNameP.Parent        = Player.PlayerGui.UIStorage.Idle
		NPCNameP.Adornee       = Beacon
		NPCName.Activated:Connect(function()
			-- Name, Beacon, Root, npcType, NPCNameP
			TargetRoot, TargetNpc, RecommendedAttach = Root, NPCNameP, Attach
			Clickon(NPCTable[i].Name, Beacon, Root, npcType, NPCNameP)
		end)
	end
end

-- // Turns maps function on & off
local function MapFunc(AName, input, Object)
	if input and input ~= Enum.UserInputState.Begin then return end
	if Zoomed then
		Zoomed = false
		Camera.CameraType = Enum.CameraType.Custom
		Player.PlayerGui.UIStorage.Idle:ClearAllChildren()
		workspace.Beacons:ClearAllChildren()
		
		MapGui.Enabled = false
		ToggleGUIs(true)
		ToggleBinds(false)
		Gui.Visible = false
		
		PreviousGui = nil
		local Char = Player.Character or Player.CharacterAdded:Wait()
		Camera.CameraSubject = Char.Humanoid
		if ActiveTween then ActiveTween:Cancel() end
	else
		Zoomed = true
		Camera.CameraType = Enum.CameraType.Scriptable
		if ActiveTween then ActiveTween:Cancel() end
		ZoomCFrame  = CFrame.new(Player.Character.PrimaryPart.Position.X, 3752.198, Player.Character.PrimaryPart.Position.Z, 0.00194969412, 0.987689972, -0.156411991, -0, 0.156412303, 0.98769182, 0.999998152, -0.00192569697, 0.000304956106)
		ActiveTween = TweenService:Create(Camera, TweenInfo.new(1), {CFrame = ZoomCFrame})
		ActiveTween:Play()
		
		MapGui.Enabled = true
		ToggleGUIs(false)
		ToggleBinds(true)
		
		-- // creating beacons
		PlantBeacon(workspace.NPCs:GetChildren())
		PlantBeacon(workspace.InteractionNPCS:GetChildren())
	end
end

-- // Gives a direction to where the npc is relative to the player
Gui.findNpc.Activated:Connect(function()
	if not TargetRoot:FindFirstChildOfClass("Attachment") then return end

	local newPart          = Instance.new("Beam")
	newPart.Attachment1    = Player.Character.PrimaryPart.RootRigAttachment
	newPart.Attachment0    = TargetRoot:FindFirstChildOfClass("Attachment")
	if RecommendedAttach then newPart.Attachment0 = RecommendedAttach end

	newPart.FaceCamera     = true
	newPart.Width0         = 2.5
	newPart.Width1         = 2.5
	newPart.Texture        = "http://www.roblox.com/asset/?id=7634978915"
	newPart.TextureMode    = Enum.TextureMode.Static
	newPart.TextureSpeed   = -1
	newPart.LightInfluence = 1
	newPart.TextureLength  = 3.25
	newPart.Transparency   = NumberSequence.new(0)
	newPart.Parent         = Player.Character.PrimaryPart

	MapFunc()
	local ReachedDestination = false
	
	repeat
		if Player:DistanceFromCharacter(TargetRoot.Position) < 50 or (TargetRoot.Parent:FindFirstChild("Humanoid") and TargetRoot.Parent.Humanoid.Health <= 0) then
			ReachedDestination = true
		elseif RecommendedAttach and Player:DistanceFromCharacter(RecommendedAttach.WorldPosition) < 50 then
			ReachedDestination = true	
		end
		task.wait(.25)
	until (PreviousGui and PreviousGui ~= TargetNpc) or ReachedDestination
	newPart:Destroy()
end)

------------------------------ [Event buttons etc] ------------------------------
-- // Gets out of map
BHolder.Cancel.Activated:Connect(function()
	MapFunc()
end)

-- // Zooms out if object is selected
BHolder.Minus.Activated:Connect(function()
	ActiveTween = TweenService:Create(Camera, TweenInfo.new(1), {CFrame = ZoomCFrame})
	ActiveTween:Play()
	Gui.Visible = false
end)

-- // Turns billboards off
local function turnoffbillboard()
	table.clear(currentSearched)
	for ChildIndex, Child in pairs(Player.PlayerGui.UIStorage.Idle:GetChildren()) do
		Child.Adornee.Transparency = 1
		Child.Enabled = false
	end
end

-- // Activates all hero boards
BHolder.Heroes.Activated:Connect(function()
	turnoffbillboard()
	for _, Table in pairs(HeroNpcs) do
		Table.beacon.Transparency = .5
		Table.billboard.Enabled = true
	end
end)

-- // Activates all villain boards
BHolder.Villains.Activated:Connect(function()
	turnoffbillboard()
	for _, Table in pairs(VillainNpcs) do
		Table.beacon.Transparency = .5
		Table.billboard.Enabled = true
	end
end)

-- // Activates all interactive npcs
BHolder.Interactive.Activated:Connect(function()
	turnoffbillboard()
	for _, Table in pairs(InteractiveNPCs) do
		Table.beacon.Transparency = .5
		Table.billboard.Enabled = true
	end
end)

-- // Enables all boards to be visible
local function SelectAll()
	for ChildIndex, Child in pairs(Player.PlayerGui.UIStorage.Idle:GetChildren()) do
		Child.Adornee.Transparency = .5
		Child.Enabled = true
	end
end
BHolder.SelectAll.Activated:Connect(SelectAll)

-- // Opens the map (Unless it's already opened and this magically gets clicked)
PlusButton.MouseButton1Click:Connect(function()
	MapFunc()
end)
ContextAction:BindActionAtPriority("MiniMap", MapFunc, false, 2000, Enum.KeyCode.M)

-- // Searching for npcs
local isSearching = false
SearchBar.Search:GetPropertyChangedSignal("Text"):Connect(function()
	if isSearching then return end
	isSearching = true
	local results = SearchBar.Search.Text:lower():split(" ")
	if not (results and #results > 0 and results[1] ~= "") then 
		SelectAll()
		isSearching = false
		return 
	end
	
	turnoffbillboard()
	
	for _, info in pairs(AllNpcs) do
		local name = info.Name
		if not (name) then continue end
		
		for _, word in ipairs(results) do
			if (word == "" or word == " ") then continue end
			
			local isMatch = not name:lower():match(word) -- // Not just converts into a bool
			if not isMatch then
				table.insert(currentSearched, info)
				continue
			end
			
			if NPCDexModule.NPCs[name] then
				local Re = NPCDexModule.NPCs[name].Rewards
				
				local isMatch = not Re.Item:lower():match(word) -- // Not just converts into a bool
				if not isMatch then
					table.insert(currentSearched, info)
					continue
				end
			end
			
			if QuestInfo[name] then
				local Re = QuestInfo[name].Ask:lower()
				
				local isMatch = not Re:match(word) -- // Not just converts into a bool
				if not isMatch then
					table.insert(currentSearched, info)
					continue
				end
			end
				
			if OtherNPCs[name] then
				local Re = OtherNPCs[name]
				local isFound = false
				for _, desc in pairs(Re) do
					local isFound = not desc:lower():match(word) -- // Not just converts into a bool
					if not isFound then
						table.insert(currentSearched, info)
						continue
					end
				end
				
				if not isFound then 
					continue
				end
			end
		end
	end
	
	for _, info in ipairs(currentSearched) do
		info.beacon.Transparency = .5
		info.billboard.Enabled   = true
	end
	
	isSearching = false
end)


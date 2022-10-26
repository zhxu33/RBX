--!nonstrict
-- // Services
local Replicated    = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")

-- // Variables
local Player         = PlayerService.LocalPlayer
local PlayerGui      = Player:WaitForChild("PlayerGui")
local LoadingScreen  = PlayerGui:WaitForChild("LoadingScreen")
local IntroGui       = PlayerGui:WaitForChild("IntroGui")
local IntroMenu      = IntroGui:WaitForChild("Menu")

-- // Pause till finished loading
if LoadingScreen.Enabled then LoadingScreen:GetPropertyChangedSignal("Enabled"):Wait() end
if IntroMenu.Visible then IntroMenu:GetPropertyChangedSignal("Visible"):Wait() end 

local UnrenderedFolder = Replicated:FindFirstChild("UnrenderedFolder") or Instance.new("Folder", Replicated)
UnrenderedFolder.Name  = "UnrenderedFolder"

local regionsFolder  = workspace:WaitForChild("Regions")
local knownHumanoids = {} -- // List of humanoid models
local regions        = {}

local refreshDuration            = .5 -- 2.5 // Refreshes every 5 seconds
local loadRegionDistance         = 750 -- // Loads regions & Parts within this distance from player
local distanceMovedBeforeRefresh = 20  -- 20 // DIstance a player must move before refreshes occur 
local refreshSettings = require(script.RefreshSettings)


-- // Character info
local character = Player.Character or Player.CharacterAdded:Wait()

-- // Reasigning character to variable
Player.CharacterAdded:Connect(function(Char)
	character = Char
end)

-- // Functions

-- // Finds the first ancestor that is a model
-- // Logging models instead of individual parts
local function FindFirstAncestorWhichIsAModel(Part)
	local modelParent = Part:FindFirstAncestorWhichIsA("Model")
	if (modelParent == workspace) then return end-- // Apparently workspace is a model
	
	return modelParent
end

-- // Makes sure part is not a part of a humanoid
local function FindFirstHumanoid(Part)
	local found    = table.find(knownHumanoids, Part)
	local humanoid = (found and knownHumanoids[found]) or Part:FindFirstChildWhichIsA("Humanoid")
	
	return humanoid
end

-- // Finds the first model ancestor that has a humanoid
local function FindFirstHumanoidOfAncestors(Part)
	if not Part then return end
	
	-- // Checking if the current part is the host of a humanoid
	local hasHumanoid = FindFirstHumanoid(Part)
	
	-- // Logging humanoid host
	if hasHumanoid then 
		table.insert(knownHumanoids, Part)
		return hasHumanoid
	end
	
	-- // If part isn't a host of a humanoid, see if parent is
	local Ancestor = FindFirstAncestorWhichIsAModel(Part)
	if not Ancestor then return end -- // No known ancestor that's a model
	
	return FindFirstHumanoidOfAncestors(Ancestor)
end

-- // Gets the largest side from part size
local function GetLargestSideFromSize(size)
	local x, y, z = size.X, size.Y, size.Z
	
	if x > y then
		return (x > z and x) or z
	else
		return (y > z and y) or z
	end
end

-- // Creates a secondary file for object
local function CreatePartFile(Part)
	local newFile = {}
	local partType = Part.ClassName
	
	-- // Checking if model has a primary part, if not make one
	if (partType == "Model" and not Part.PrimaryPart) then -- // Is a model and has no primary part
		for _, basePart in ipairs(Part:GetChildren()) do
			if not (basePart:IsA("BasePart")) then continue end
			Part.PrimaryPart = basePart
			
			break
		end
		
		if not (Part.PrimaryPart) then return end -- // Don't continue if model has no base parts in it
	end
	
	newFile.Part     = Part
	newFile.Parent   = Part.Parent
	newFile.CFrame   = Part:GetPivot()
	newFile.Position = newFile.CFrame.Position
	local newCF = CFrame.new(99999, 99999, 99999)
	
	local size = (partType == "Model" and Part:GetExtentsSize()) or Part.Size
	newFile.Size = GetLargestSideFromSize(size)
	
	-- // Will update the parent to provided parent or previous parent
	function newFile:UpdateParent(Parent)
		if (Part.Parent == (Parent or self.Parent)) then return end
		Part.Parent = (Parent or self.Parent)
	end
	
	-- // Hides the part far away
	function newFile:UpdateCFrame(hide)
		if Part:GetPivot() == (hide and newCF or self.CFrame) then return end
		Part:PivotTo(hide and newCF or self.CFrame)
	end
	
	-- // TODO Cache part distance from parent region
	-- // Based on quadrants
	-- // Given the player's distance from quadrant and region 
	-- // This will be a 4 way check rather than math
	
	-- // Returns a distance from model or part
	local x, y = newFile.Position.X, newFile.Position.Z
	local root = math.sqrt
	function newFile:GetDistanceFromPivot(Pivot)
		local x1, y1 = Pivot.X, Pivot.Z
		local x2, y2 = (x - x1), (y - y1)
		return root(x2^2 + y2^2) - (self.Size / 2)
	end
	
	-- // Will calculate distance from object and update parent if needed
	function newFile:RenderPart(Distance : number, Pivot, unrenderedParent)
		local currentDistance = self:GetDistanceFromPivot(Pivot)
		if not currentDistance then warn("Failed to find distance for part: " .. Part.name .. ".") return end
		
		if (currentDistance > Distance) then
			self:UpdateCFrame(unrenderedParent)
		elseif (currentDistance < Distance) then
			self:UpdateCFrame()
		end
	end
	
	return newFile
end

-- // Checks if the part is a base part or model part
local function VerifyInstanceType(value)
	local className = value.ClassName
	local isAllowed = false
	
	-- // Acceptable parts
	if value:IsA("BasePart") then isAllowed = true end
	
	-- // If it's a model
	if className == "Model" then isAllowed = true end
	
	-- // If it's a part of a humanoid
	if FindFirstHumanoidOfAncestors(value) then isAllowed = false end
	
	return isAllowed
end

-- // Creates a file for regions
local function CreateRegionFile(RegionPart, Parts)
	local newRegion = {}
	
	newRegion.PartsInRegion = Parts
	newRegion.Position      = RegionPart.Position
	newRegion.CFrame        = RegionPart.CFrame
	newRegion.Parent        = UnrenderedFolder
	newRegion.Size          = GetLargestSideFromSize(RegionPart.Size)
	
	-- // Returns a distance from model or part
	local x, y = newRegion.Position.X, newRegion.Position.Z
	local root = math.sqrt
	
	-- // without considering radius
	function newRegion:GetRawDistanceFromPivot(Pivot)
		local x1, y1 = Pivot.X, Pivot.Z
		local x2, y2 = (x - x1), (y - y1)
		return math.clamp(root(x2^2 + y2^2), 0, 10000)
	end
	
	function newRegion:GetDistanceFromPivot(Pivot)
		local x1, y1 = Pivot.X, Pivot.Z
		local x2, y2 = (x - x1), (y - y1)
		return math.clamp(root(x2^2 + y2^2) - (self.Size / 2), 0, 10000) -- // subtracts radius of bounding box
	end

	-- // Will calculate distance from object and update parent if needed
	function newRegion:CheckRenderDistance(Distance : number, Pivot)
		local currentDistance = self:GetDistanceFromPivot(Pivot)
		if not currentDistance then return end
		
		-- // Tell children to check their distance
		if (currentDistance < Distance) then -- // If the current distance from the player is greater than the provided distance than
			-- // Another check to see if radius provided is at least as big as the diameter in size + distance from character
			if (currentDistance + self.Size) < Distance then
				for _, partFile in pairs(self.PartsInRegion) do
					partFile:UpdateCFrame()
				end
			else -- // Has to check and render each individual part instead
				for _, partFile in pairs(self.PartsInRegion) do
					partFile:RenderPart(Distance, Pivot, self.Parent)
				end
			end
		else -- // Means the player is farther than what's wanted
			for _, partFile in pairs(self.PartsInRegion) do
				partFile:UpdateCFrame(self.Parent)
			end
		end
	end
	
	return newRegion
end

-- // Gathers all important information within a region
local characterPivot = character:GetPivot()
for _, regionPart : Part in pairs(regionsFolder:GetChildren()) do
	if not (regionPart:IsA("BasePart")) then continue end
	
	local childParts = {}
	
	local overlapParams = OverlapParams.new()
	local partsInRegion = workspace:GetPartBoundsInBox(regionPart.CFrame, regionPart.Size, overlapParams)
	
	for _, part in ipairs(partsInRegion) do
		if not VerifyInstanceType(part) then continue end
		local model   = FindFirstAncestorWhichIsAModel(part) -- // Don't want to go through the extra business if part's parent is a model
		
		-- // Parent or part already found in parts
		if childParts[(model or part)] then continue end
		childParts[model or part] = CreatePartFile(model or part)
	end
	
	local regionFile = CreateRegionFile(regionPart, childParts)
	
	-- // going to check if the descendants of region make the parts
	-- // detection radius bigger, change it if it does
	local radiusSize = regionFile.Size
	for _, partFile in pairs(childParts) do
		-- // Distance from center of region in 2d
		local distance = regionFile:GetRawDistanceFromPivot(partFile.Position)
		
		-- // Getting new radius if distance is greater than previous radius
		if (distance + partFile.Size) > radiusSize then
			regionFile.Size = (distance + partFile.Size)
		end
	end
	
	regionFile:CheckRenderDistance(loadRegionDistance, characterPivot.Position)
	
	regions[regionPart] = regionFile
end

-- // Main distance loop
local regionThread
local skipCheck = false
regionThread = task.spawn(function()
	while true do
		task.wait(refreshDuration)
		
		local currentPivot = character:GetPivot()
		if not skipCheck and ((currentPivot.Position - characterPivot.Position).Magnitude < distanceMovedBeforeRefresh) then continue end
		skipCheck = false
		characterPivot = currentPivot

		for _, regionFile in pairs(regions) do
			regionFile:CheckRenderDistance(loadRegionDistance, characterPivot.Position)
		end
	end
end)

-- // Updates the players settings
local userSettings = UserSettings().GameSettings
local prevSetting  = nil
local function updateSettings()
	local newSettings = refreshSettings[userSettings.SavedQualityLevel]
	
	if not (newSettings and (prevSetting ~= userSettings.SavedQualityLevel)) then return end -- // Makes it so it doesn't update when graphics did not change
	if (coroutine.status(regionThread) == "suspended") then task.spawn(regionThread) end -- // forces regions to update on graphics change
	skipCheck = true
	
	prevSetting = userSettings.SavedQualityLevel
	
	refreshDuration            = newSettings[1]
	loadRegionDistance         = newSettings[2]
	distanceMovedBeforeRefresh = newSettings[3]
end

userSettings.Changed:Connect(updateSettings)
updateSettings()
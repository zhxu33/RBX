-- // Services
local PlayerService = game:GetService("Players")
local Replicated    = game:GetService("ReplicatedStorage")

-- // Variables
local player = PlayerService.LocalPlayer

local DISTANCE   = 800 -- // Studs ( :
local NPC_FOLDER = workspace.NPCs
local CHECK_RATE = 1
local HIGHLIGHT_FOLDER  = Instance.new("Folder")
HIGHLIGHT_FOLDER.Name   = "Highlight_Folder"
HIGHLIGHT_FOLDER.Parent = Replicated

local highlights = {} -- // Cached highlights
local npcFiles   = {} -- // Cached npc files

-- // Funtions

-- // Creates a new highlight or grabs from cache
local function CreateHighlight()
	local index, highlight = next(highlights)
	if highlight then
		highlights[index] = nil
		return highlight
	end
	
	local highlight = Instance.new("Highlight")
	highlight.FillColor    = Color3.fromRGB(255, 255, 255)
	highlight.OutlineColor = Color3.new(1, 0, 0)
	
	return highlight
end

-- // Caches highlight if it exists
local function CacheHighlight(highlight)
	if not (highlight and highlight.Parent) then return end
	highlight.Parent = HIGHLIGHT_FOLDER
	table.insert(highlights, highlight)
end

-- // Disposes tables
local function DisposeInfo(info) : nil
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
	end

	return nil
end

-- // creates a new file for an npc
local function CreateNPCFile(npc)
	local newFile = {}
	
	if npc.Parent ~= NPC_FOLDER then npc.AncestryChanged:Wait() end
	local humanoid : Humanoid = npc:WaitForChild("Humanoid")
	
	if not (humanoid and humanoid.Health > 0) then return end
	local highlight   = CreateHighlight()
	highlight.Enabled = false
	highlight.Parent  = npc
	
	newFile.IsAlive     = true
	newFile.Connections = {}
	newFile.RootPart    = npc.PrimaryPart or npc:FindFirstChild("HumanoidRootPart")
	newFile.ID          = tick()
	
	-- // Just checks the distance from a model part
	function newFile:GetDistanceFromModel(Model)
		if not (Model and Model.Parent and Model.PrimaryPart and self.IsAlive) then return 9999 end
		local Position     = Model:GetPivot().Position
		local SelfPosition = npc:GetPivot().Position
		
		return (Position - SelfPosition).Magnitude
	end
	
	-- // Checks if the model is in range
	function newFile:IsInRangeOfModel(Model : Model) : boolean
		return DISTANCE >= self:GetDistanceFromModel(Model)
	end
	
	-- // Turns on or off the highlight
	function newFile:ToggleHighlight(bool)
		highlight.Parent  = bool and npc or HIGHLIGHT_FOLDER
		highlight.Enabled = bool
	end
	
	-- // Disposes of all info
	function newFile:Destroy()
		npcFiles[newFile.ID] = nil
		CacheHighlight(highlight)
		humanoid  = nil
		highlight = nil
		
		DisposeInfo(self)
	end
	
	-- // Destroys file based
	table.insert(newFile.Connections, humanoid.HealthChanged:Connect(function()
		if humanoid.Health <= 0 then
			newFile.IsAlive = false
			newFile:Destroy()
		end
	end))
	
	npcFiles[newFile.ID] = newFile
	
	-- // Basically the core
	task.spawn(function()
		while task.wait(CHECK_RATE) and newFile.IsAlive do
			newFile:ToggleHighlight(newFile:IsInRangeOfModel(player.Character))
		end
	end)
	
	return newFile
end

-- // Hook up current npcs

for _, npc in ipairs(NPC_FOLDER:GetChildren()) do
	task.spawn(CreateNPCFile, npc)
end

NPC_FOLDER.ChildAdded:Connect(CreateNPCFile)
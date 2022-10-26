local applyUpdates = {}

-- // directories
local dataDirectory = workspace.S1c2R5i66p5t5s51

-- // newDatafolder yus
local dataFolder    = dataDirectory:FindFirstChild("PlayerData") or Instance.new("Folder")
dataFolder.Name     = "PlayerData"
dataFolder.Parent   = dataDirectory

local data_folder_to_copy = dataFolder.PlayerName

-- // variables
local data_folder_array =   {
	Strength       = "IntValue",
	Agility        = "IntValue",
	Level          = "IntValue",
	Durability     = "IntValue",
	Quirk          = "IntValue",
	StatPoints     = "IntValue",
	Experience     = "NumberValue",
	Fame           = "IntValue",
	Cash           = "IntValue",
	RareMultiplier = "NumberValue",
	ExpMultiplier  = "NumberValue",
	CashMultiplier = "NumberValue",
	--PermBan        = "BoolValue",
	ArenaWins      = "NumberValue",
	--Ban            = "IntValue",
	EasterEgg      = "IntValue",
}

-- // functions

-- // creating a new folder for the player
function applyUpdates:createFolder()
	local new = nil
	
	-- // copying designated folder if exists
	-- // or creating a new one from an array
	if data_folder_to_copy then
		new        = data_folder_to_copy:Clone()
		new.Parent = dataFolder
		new.Name   = self.Player.Name
	else
		new        = Instance.new("Folder")
		new.Name   = self.Player.Name
		new.Parent = dataFolder
		
		for valName, valType in pairs(data_folder_array) do
			local newInstance  = Instance.new(valType)
			newInstance.Name   = valName
			newInstance.Parent = new
		end
	end
	
	return new
end

-- // Applying file vars
function applyUpdates:setUpdateVars()
	self._dataConnections = {}
	self._playerFolder    = applyUpdates.createFolder(self)
	
	-- // setting the player's data to the values
	for index, value in pairs(self) do
		local val = self._playerFolder:FindFirstChild(index)
		
		if val then
			val.Value = value
			
			self._dataConnections[index] = val:GetPropertyChangedSignal("Value"):Connect(function()
				self[index] = val.Value
			end)
		end
	end
	
	local loadedVal  = Instance.new("BoolValue")
	loadedVal.Name   = "Loaded"
	loadedVal.Value  = true
	loadedVal.Parent = self._playerFolder
	
	return self._playerFolder
end

return applyUpdates 
local Info = {}
local BV = ""
if game.PlaceId == 7775211226 then
	BV = game:GetService("ServerScriptService").BetaScript:GetAttribute("BV")
end

 --====================== [ SERVICES ] ======================--
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MessageService = game:GetService("MessagingService")

 --====================== [ DATASTORE ] ======================--
local PlayerData = DataStoreService:GetDataStore("PlayerData"..BV)

 --====================== [ VARIABLES ] ======================--

local StarterInformation = {
	["PlayerData"] = {
		["Level"] = 1,
		["Strength"] = 1,
		["Agility"] = 1,
		["Quirk"] = 3,
		["Durability"] = 1,
		["StatPoints"] = 3,
		["Experience"] = 0,
		["Fame"] = 0,
		["Cash"] = 25000,
	},
}
local HalvedDataTypes = {
	"Quirk",
	"StatPoints",
	"Experience",
}

local Url = "https://discordapp.com/api/webhooks/717855650868101181/qpEfjX29CS_nKUGwEP57o0zVU0XeCzqjw-vVNpITd72oJxbsSfArew7ft-gr3rPlK_1R"

 --====================== [ FUNCTIONS ] ======================--

function Info:GetDataStoreInfo() -- Gets data store for player data, have this so it's easily pulled from other scripts
	local Data = PlayerData:GetAsync(self)
	return Data
end

local function GetTableToString(DataInfo) -- Turns a table into a string version of it, meant for testing and in-case you need the table to copy paste
	local StringValue = "{" -- Makes it easier to copy paste the table in-case it's on accident
	for DataName, Value in pairs(DataInfo) do
		StringValue = StringValue.."\n".."\t"..DataName.." = "..tostring(Value)..","
	end
	StringValue = StringValue.."\n".."}"
	return StringValue
end

local function GetEmbededFields(DataInfo) -- Generates all Embed fields for PlayerStats, used for full and half resets
	local newFields = {}
	for DataName, Value in pairs(StarterInformation.PlayerData) do -- Creates the main fields for embed
		local Name = DataName
		local Value = DataInfo[DataName]
		table.insert(newFields, 
			{
				["name"] = "**"..Name.."**",
				["value"] = Value,
				["inline"] = true
			})
	end
	return newFields
end

local function GetSingleField(DataInfo, DataType, Fields) -- Shortcut function to get embed fields of a single stat
	local newFields = Fields or nil
	local Name = DataType
	local Value = DataInfo[DataType]
	table.insert(newFields, 
		{
			["name"] = "**"..Name.."**",
			["value"] = Value,
			["inline"] = true
		})
	return newFields
end

function Info:GetFields(InfoType) -- Gets the fields (Required for embeds in disc) and returns the new data the player will have
	local Fields = nil
	local PlayerInfo
	if InfoType == "Full" then -- Fully resets Target's stats
		PlayerInfo = Info.GetDataStoreInfo(self)
		if not PlayerInfo then
			PlayerInfo = {}
			for DataName, DataValue in pairs(StarterInformation.PlayerData) do
				PlayerInfo[DataName] = DataValue
			end
		end
		
		Fields = GetEmbededFields(PlayerInfo)
		local Playerinfotostring = GetTableToString(PlayerInfo)
		table.insert(Fields, {["name"] = "Data Field", ["value"] = Playerinfotostring})
		for DataName, DataValue in pairs(StarterInformation.PlayerData) do -- Copy Paste as their stats are being reset anyways
			PlayerInfo[DataName] = DataValue
		end
		
	elseif InfoType == "Half" then -- Cuts Targets current stats in half
		PlayerInfo = Info.GetDataStoreInfo(self)
		local Datahalved = nil
		if PlayerInfo and type(PlayerInfo) == "table" then
			Datahalved = {}
			for DataIndex, Data in pairs(PlayerInfo) do
				if type(Data) == "number" then
					Datahalved[DataIndex] = Data/2
				end
			end
		end
		
		Fields = GetEmbededFields(PlayerInfo)
		local Playerinfotostring = GetTableToString(PlayerInfo)
		local HalvedData = GetTableToString(Datahalved)
		table.insert(Fields, {["name"] = "Data Field", ["value"] = Playerinfotostring})
		for DataName, DataValue in pairs(Datahalved) do
			if not table.find(HalvedDataTypes, DataName) then
				PlayerInfo[DataName] = math.ceil(DataValue)
			elseif DataName == "StatPoints" then
				PlayerInfo[DataName] = math.ceil(Datahalved.Level) * 3
			elseif DataName == "Quirk" then
				--PlayerInfo[DataName] = 3
			end
		end
	end
	return Fields, PlayerInfo
end

function Info.SendInfo(Moderator, Message, Fields) -- This sends message to discbord to log who sent the command and what data was previously had
	print(Moderator, Message, Fields)
	local Data = {
		["content"] = Moderator.." Used a command: "..Message,	
	}
	if Fields then
		Data.embeds = {{
			["description"] = "User\'s previous stats:",
			["type"] = "rich",
			["color"] = tonumber(0xff00ff),
			["fields"] = Fields,
		}}
	end
	local newData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(Url, newData)
end

function Info.SetDataToDataStore(Target, Data, SaveToDS) -- Sets the data to PlayerData Datastore, (Used for Stat Reset) // SaveToDS is a bool, which signifies if it will be saved to the datastore
	local Success, Err = true, nil
	if SaveToDS or SaveToDS ~= false then
		Success, Err = pcall(function()
			PlayerData:SetAsync(Target, Data)
		end)
		if Err then
			print(Err)
		end
	end
	
	if Players:GetPlayerByUserId(Target) then
		local List = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Players:GetPlayerByUserId(Target).Name)
		for DataName, DataValue in pairs(Data) do
			List:FindFirstChild(DataName).Value = DataValue
		end
		Players:GetPlayerByUserId(Target):LoadCharacter()
	end
	return Success
end

function Info:PublishGlobalMessage(Data) -- using it for sending a data reset to other servers
	local success, errorMessage = pcall(function()
		MessageService:PublishAsync("Stat Reset", {["UserId"] = self, ["Data"] = Data})
	end)
	if success then
		print("Successfully sent the message")
	else
		warn(errorMessage)
		wait(10)
		Info.PublishGlobalMessage(self, Data)
	end
end

return Info

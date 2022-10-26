--[[

-------------|
By: Kitsomia |
-------------|

How to create a tag:

Duplicate "UserTag" underneath the "Tags" config folder
Put the value of the new UserTag to what you want your tag to be
Parent to Tags config folder

GroupId: Signifies the group which it will look for
 -> Rank: Is the role value which the user must have for tag

UserId:   Skips group requirement and designates towards a users ID
TagColor: Color the tag will be displayed as
]]

-- // Services
local ServerScriptService = game:GetService("ServerScriptService")

local ChatLocalization = nil
pcall(function() ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization) end)
if ChatLocalization == nil then ChatLocalization = {} function ChatLocalization:Get(key,default) return default end end

-- // Variables
local modulesFolder = ServerScriptService:WaitForChild("ChatServiceRunner")

local PlayersService = game:GetService("Players")
local RunService     = game:GetService("RunService")

local ChatService = require(modulesFolder:WaitForChild("ChatService"))

-- // Chat Tags
local TagFolder = script:WaitForChild("Tags")
local _Tags     = TagFolder:GetChildren()
local Methods   = {}
local Tags      = setmetatable({}, Methods)
Methods.__index = Methods

-- // gets tags from player
function Methods:GetPlayerTags(player)
	if rawget(self, player.UserId) then return rawget(self, player.UserId) end
	if not (player) then return end
	
	local newTags = {}
	for _, Tag in pairs(_Tags) do
		if (player:IsInGroup(Tag.GroupId.Value) or player.UserId == Tag.UserId.Value)then
			local userRank = player:GetRankInGroup(Tag.GroupId.Value)
			for _, rank in pairs(Tag.GroupId:GetChildren()) do
				if rank.Value == userRank then
					table.insert(newTags, {
						TagText  = Tag.Value,
						TagColor = Tag.TagColor.Value,
						Priority = Tag.Priority.Value,
					})
					break
				end
			end
		end
	end
	
	local currentPriority = 1
	for index, value in pairs(newTags) do
		if value.Priority < currentPriority then
			table.remove(newTags, index)
		else
			currentPriority = value.Priority
		end
	end
	
	if #newTags > 0 then
		rawset(self, player.UserId, newTags)
	end
	
	return newTags
end

local function SendClientInfo(speakerObj, msg)
	if speakerObj then
		speakerObj:SendSystemMessage(
			string.gsub(
				ChatLocalization:Get(
					"GameChat_FriendChatNotifier_JoinMessage",
					msg
				),
				"{RBX_NAME}",
				msg
			),
			"System"
		)
	end
end

-- // Setting up tags
local function ToggleTags(speakerName)
	local Player  = PlayersService:FindFirstChild(speakerName)
	if not Player then warn(("Player not found. [%s]"):format(speakerName)); return end
	
	local Speaker = ChatService:GetSpeaker(speakerName)
	if not Speaker then return end
	
	local prevTags = Speaker:GetExtraData("Tags")
	if prevTags and #prevTags > 0 then
		SendClientInfo(Speaker, "Your " ..Speaker:GetExtraData("Tags")[1].TagText.. " tag has been toggled off.")
		
		Speaker:SetExtraData("Tags", nil)
		return
	end
	
	local tags = Tags:GetPlayerTags(Player)
	if #tags <= 0 then return end
	
	Speaker:SetExtraData("Tags", tags)
	SendClientInfo(Speaker, "Your " ..Speaker:GetExtraData("Tags")[1].TagText.. " tag has been toggled on.")
end

-- // Getting new speaker
ChatService.SpeakerAdded:Connect(function(speakerName) 
	Tags:GetPlayerTags(PlayersService:FindFirstChild(speakerName))
	
	local speaker = ChatService:GetSpeaker(speakerName)
	if not speaker then return end
	speaker:SetExtraData("Tags", nil)
end)

ChatService.SpeakerRemoved:Connect(function(speakerName) 
	local player = PlayersService:FindFirstChild(speakerName); 
	rawset(Tags, player.UserId, nil) 
end)

-- // Missed players
for _, speakerName in pairs(ChatService:GetSpeakerList()) do
	Tags:GetPlayerTags(PlayersService:FindFirstChild(speakerName))

	local speaker = ChatService:GetSpeaker(speakerName)
	if not speaker then return end
	speaker:SetExtraDat("Tags", nil)
end

-- // Resetting and updating tags
local function UpdateTags()
	_Tags = TagFolder:GetChildren()
	table.clear(Tags)
	
	for _, player in pairs(PlayersService:GetPlayers()) do
		Tags:GetPlayerTags(player)
	end
end
TagFolder.ChildAdded:Connect(UpdateTags)
TagFolder.ChildRemoved:Connect(UpdateTags)

-- // Putting a new commands method
ChatService:RegisterProcessCommandsFunction("player_custom_tags", function(fromSpeaker, message, channel)
	if message:sub(1, 4):lower() == ";tag" then
		ToggleTags(fromSpeaker)
		
		return true
	end

	return false
end)
--	// FileName: ExtraDataInitializer.lua
--	// Written by: Xsitsu
--	// Description: Module that sets some basic ExtraData such as name color, and chat color.
--
--  // Editted by: nforeman
--  // ^ I'm not a ROBLOX admin nor an intern. I'm just a bored guy who has OCD and likes a neat chat. :)


local stackTags = false
local groupRankComparison = '>='

local possibleTags = {
	['Owner'] = {
		TagText = "Owner",
		TagColor = Color3.fromRGB(66, 135, 245),
		Priority = 8,
	},
	['Developer'] = {
		TagText = "Developer",
		TagColor = Color3.fromRGB(49, 144, 219), -- Color3.fromRGB(0, 170, 255),
		Priority = 6,
	},
	['Head Developer'] = {
		TagText = "Head Developer",
		TagColor = BrickColor.new("Bright orange").Color,
		Priority = 7,
	},
	['Head Admin'] = {
		TagText = "Head Admin",
		TagColor = Color3.fromRGB(46, 172, 92), -- Color3.fromRGB(0, 255, 0),
		Priority = 5,
	},
	['Exec Admin'] = {
		TagText = "Exec Admin",
		TagColor = Color3.fromRGB(109, 202, 160), -- BrickColor.new("Bright orange").Color,
		Priority = 4,
	},
	['Admin'] = {
		TagText = "Admin",
		TagColor = Color3.fromRGB(151, 0, 0),
		Priority = 3,
	},
	['Moderator'] = {
		TagText = "Moderator",
		TagColor = Color3.fromRGB(19, 0, 20), -- Color3.fromRGB(255, 0, 191),
		Priority = 2,
	},
	['Trial Moderator'] = {
		TagText = "Trial Moderator",
		TagColor = Color3.fromRGB(255, 0, 191),
		Priority = 1,
	},
}

local SpecialChatColors = {
	Groups = {
	},
	Players = {
	}
}

local SpecialTags = {
	Groups = {
		{
			GroupId = 3755220,
			Rank = 255,
			Tags = {'Owner'}
		},
		{
			GroupId = 3755220,
			Rank = 17,
			Tags = {'Head Developer'}
		},
		{
			GroupId = 3755220,
			Rank = 16,
			Tags = {'Developer'}
		},
		{
			GroupId = 3755220,
			Rank = 15,
			Tags = {'Head Admin'}
		},
		{
			GroupId = 3755220,
			Rank = 14,
			Tags = {'Exec Admin'}
		},
		{
			GroupId = 3755220,
			Rank = 13,
			Tags = {'Admin'}
		},
		{
			GroupId = 3755220,
			Rank = 12,
			Tags = {'Moderator'}
		},
		{
			GroupId = 3755220,
			Rank = 11,
			Tags = {'Trial Moderator'}
		},
	},
	Players = {
	}
}

local function MakeIsInGroup(groupId, requiredRank)
	assert(type(requiredRank) == "nil" or type(requiredRank) == "number", "requiredRank must be a number or nil")

	return function(player)
		if player and player.UserId then
			local userId = player.UserId

			local inGroup = false
			local success, err = pcall(function() -- Many things can error is the IsInGroup check
				if requiredRank then
					if groupRankComparison == '>=' then
						inGroup = player:GetRankInGroup(groupId) >= requiredRank
					elseif groupRankComparison == '>' then
						inGroup = player:GetRankInGroup(groupId) > requiredRank
					elseif groupRankComparison == '<' then
						inGroup = player:GetRankInGroup(groupId) < requiredRank
					elseif groupRankComparison == '<=' then
						inGroup = player:GetRankInGroup(groupId) <= requiredRank
					end
				else
					inGroup = player:IsInGroup(groupId)
				end
			end)
			if not success and err then
				print("Error checking in group: " ..err)
			end

			return inGroup
		end

		return false
	end
end

local function ConstructIsInGroups()
	if SpecialChatColors.Groups then
		for _, group in pairs(SpecialChatColors.Groups) do
			group.IsInGroup = MakeIsInGroup(group.GroupId, group.Rank)
		end
	end
	if SpecialTags.Groups then
		for _, group in pairs(SpecialTags.Groups) do
			group.IsInGroup = MakeIsInGroup(group.GroupId, group.Rank)
		end
	end
end
ConstructIsInGroups()

local Players = game:GetService("Players")

function GetSpecialChatColor(speakerName)
	local chatColor = Color3.new(1,1,1)
	local currentPriority = 0
	if SpecialChatColors.Players then
		local playerFromSpeaker = Players:FindFirstChild(speakerName)
		if playerFromSpeaker then
			for _, player in pairs(SpecialChatColors.Players) do
				if playerFromSpeaker.UserId == player.UserId then
					if player['Priority'] > currentPriority then
						currentPriority = player['Priority']
						chatColor = player.ChatColor
					end
				end
			end
		end
	end
	if SpecialChatColors.Groups then
		for _, group in pairs(SpecialChatColors.Groups) do
			if group.IsInGroup(Players:FindFirstChild(speakerName)) then
				return group.ChatColor
			end
		end
	end
	return chatColor
end
function GetSpecialTags(speakerName)
	local tags = {}
	local currentPriority = 0
	if SpecialTags.Players then
		local playerFromSpeaker = Players:FindFirstChild(speakerName)
		if playerFromSpeaker then
			for _, player in pairs(SpecialTags.Players) do
				if playerFromSpeaker.UserId == player.UserId then
					for possibleTagName,possibleTagValue in pairs(possibleTags) do
						for i,playerTagName in pairs(player.Tags) do
							if playerTagName == possibleTagName then
								if stackTags then
									table.insert(tags,possibleTagValue)
									if possibleTagValue['Priority'] > currentPriority then
										currentPriority = possibleTagValue['Priority']
									end
								else
									if possibleTagValue['Priority'] > currentPriority then
										tags = {possibleTagValue}
										currentPriority = possibleTagValue['Priority']
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if SpecialTags.Groups then
		for _, group in pairs(SpecialTags.Groups) do
			if group.IsInGroup(Players:FindFirstChild(speakerName)) then
				for possibleTagName,possibleTagValue in pairs(possibleTags) do
					for i,groupTagName in pairs(group.Tags) do
						if groupTagName == possibleTagName then
							if stackTags then
								table.insert(tags,possibleTagValue)
								if possibleTagValue['Priority'] > currentPriority then
									currentPriority = possibleTagValue['Priority']
								end
							else
								if possibleTagValue['Priority'] > currentPriority then
									tags = {possibleTagValue}
									currentPriority = possibleTagValue['Priority']
								end
							end
						end
					end
				end
			end
		end
	end
	local returnTags = {}
	if #tags > 1 then
		for i = currentPriority, 1, -1 do
			print(i)
			for tagIndex,tagValue in pairs(tags) do
				if tagValue['Priority'] == i then
					table.insert(returnTags, tagValue)
				end
			end
		end
	else
		returnTags = tags
	end
	return returnTags
end

local function Run(ChatService)
	local NAME_COLORS =
	{
		Color3.new(253/255, 41/255, 67/255), -- BrickColor.new("Bright red").Color,
		Color3.new(1/255, 162/255, 255/255), -- BrickColor.new("Bright blue").Color,
		Color3.new(2/255, 184/255, 87/255), -- BrickColor.new("Earth green").Color,
		BrickColor.new("Bright violet").Color,
		BrickColor.new("Bright orange").Color,
		BrickColor.new("Bright yellow").Color,
		BrickColor.new("Light reddish violet").Color,
		BrickColor.new("Brick yellow").Color,
	}

	local function GetNameValue(pName)
		local value = 0
		for index = 1, #pName do
			local cValue = string.byte(string.sub(pName, index, index))
			local reverseIndex = #pName - index + 1
			if #pName%2 == 1 then
				reverseIndex = reverseIndex - 1
			end
			if reverseIndex%4 >= 2 then
				cValue = -cValue
			end
			value = value + cValue
		end
		return value
	end

	local color_offset = 0
	local function ComputeNameColor(pName)
		return NAME_COLORS[((GetNameValue(pName) + color_offset) % #NAME_COLORS) + 1]
	end

	local function GetNameColor(speaker)
		local player = speaker:GetPlayer()
		if player then
			if player.Team ~= nil then
				return player.TeamColor.Color
			end
		end
		return ComputeNameColor(speaker.Name)
	end

	ChatService.SpeakerAdded:connect(function(speakerName)
		local speaker = ChatService:GetSpeaker(speakerName)
		if not speaker:GetExtraData("NameColor") then
			speaker:SetExtraData("NameColor", GetNameColor(speaker))
		end
		if not speaker:GetExtraData("ChatColor") then
			local specialChatColor = GetSpecialChatColor(speakerName)
			if specialChatColor then
				speaker:SetExtraData("ChatColor", specialChatColor)
			end
		end
		if not speaker:GetExtraData("Tags") then
			local specialTags = GetSpecialTags(speakerName)
			speaker:SetExtraData("Tags", specialTags)
		end
	end)

	local PlayerChangedConnections = {}
	Players.PlayerAdded:connect(function(player)
		local changedConn = player.Changed:connect(function(property)
			local speaker = ChatService:GetSpeaker(player.Name)
			if speaker then
				if property == "TeamColor" or property == "Neutral" or property == "Team" then
					speaker:SetExtraData("NameColor", GetNameColor(speaker))
				end
			end
		end)
		PlayerChangedConnections[player] = changedConn
	end)

	Players.PlayerRemoving:connect(function(player)
		local changedConn = PlayerChangedConnections[player]
		if changedConn then
			changedConn:Disconnect()
		end
		PlayerChangedConnections[player] = nil
	end)
end

return Run

--[[game.Players.PlayerAdded:Connect(function(Player)
	local tags = Instance.new("Folder",Player)
	if Player:GetRoleInGroup(3755220) ~= "Member" and Player:IsInGroup(3755220) then
		local newTag = Instance.new("IntValue",tags)
		newTag.Name = Player:GetRoleInGroup(3755220)
		local chatColor = Instance.new("Color3Value",newTag)
		chatColor.Name = "ChatColor"
		chatColor.Value = BrickColor.new("Institutional white").Color
		local tagColor = Instance.new("Color3Value",newTag)
		tagColor.Name = "TagColor"
		if Player:GetRoleInGroup(3755220) == "Moderator" then
			tagColor.Value = Color3.fromRGB(255,0,191)
		elseif Player:GetRoleInGroup(3755220) == "Admin" then
			tagColor.Value = Color3.fromRGB(151,0,0)
		elseif Player:GetRoleInGroup(3755220) == "Head Admin" then
			tagColor.Value = Color3.fromRGB(0,255,0)
		elseif Player:GetRoleInGroup(3755220) == "Developer" then
			tagColor.Value = Color3.fromRGB(0,0,255)
		elseif Player:GetRoleInGroup(3755220) == "Owner" then
			tagColor.Value = Color3.fromRGB(255, 148, 148)
		elseif Player:GetRoleInGroup(3755220) == "Alpha Tester" then
			tagColor.Value = Color3.fromRGB(255, 0, 0)
		else
			tagColor.Value = BrickColor.new("Bright orange").Color
		end
		tags.Name = "Tags"
	end
end)]]
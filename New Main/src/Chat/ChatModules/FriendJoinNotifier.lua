--	// FileName: FriendJoinNotifer.lua
--	// Written by: TheGamer101
--	// Description: Module that adds a message to the chat whenever a friend joins the game.

local Chat = game:GetService("Chat")
local Players = game:GetService("Players")
local FriendService = game:GetService("FriendService")

local ReplicatedModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ReplicatedModules:WaitForChild("ChatSettings"))
local ChatConstants = require(ReplicatedModules:WaitForChild("ChatConstants"))

local HttpService = game:GetService("HttpService")
local Url = "https://discordapp.com/api/webhooks/717855650868101181/qpEfjX29CS_nKUGwEP57o0zVU0XeCzqjw-vVNpITd72oJxbsSfArew7ft-gr3rPlK_1R"
local MessagingService = game:GetService("MessagingService")

local ChatLocalization = nil
pcall(function() ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization) end)
if ChatLocalization == nil then ChatLocalization = {} function ChatLocalization:Get(key,default) return default end end

local FriendMessageTextColor = Color3.fromRGB(255, 255, 255)
local FriendMessageExtraData = {ChatColor = FriendMessageTextColor}

local function Run(ChatService)

	MessagingService:SubscribeAsync("GlobalAnnouncement", function(message)
		for i, player in pairs(Players:GetChildren()) do
			local speakerObj = ChatService:GetSpeaker(player.Name)
			if speakerObj then
				speakerObj:SendSystemMessage(
					string.gsub(
						ChatLocalization:Get(
							"GameChat_FriendChatNotifier_JoinMessage",
							message.Data
						),
						"{RBX_NAME}",
						player.Name
					),
					"System",
					{ChatColor = Color3.fromRGB(255, 255, 0)}
				)
			end
		end
	end)

	local function ShowFriendJoinNotification()
		if ChatSettings.ShowFriendJoinNotification ~= nil then
			return ChatSettings.ShowFriendJoinNotification
		end
		return false
	end

	local function SendFriendJoinNotification(player, joinedFriend)
		local speakerObj = ChatService:GetSpeaker(player.Name)
		if speakerObj then
			speakerObj:SendSystemMessage(
				string.gsub(
					ChatLocalization:Get(
						"GameChat_FriendChatNotifier_JoinMessage",
						string.format("Your friend %s has joined the game.", joinedFriend.Name)
					),
					"{RBX_NAME}",
					joinedFriend.Name
				),
				"System",
				FriendMessageExtraData
			)
		end
	end

	local function SendDataConfirmation(player, msg, extra)
		extra = extra or FriendMessageExtraData
		local speakerObj = ChatService:GetSpeaker(player.Name)
		if (player:IsInGroup(3755220) and player:GetRankInGroup(3755220) >= 11) then
			local Data = {["content"] = player.Name.." used command: "..msg}
			Data = HttpService:JSONEncode(Data)
			coroutine.wrap(function() HttpService:PostAsync(Url, Data) end)()
		end
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
				"System",
				extra
			)
		end
	end
	game.ReplicatedStorage.SendDataConfirmation.Event:Connect(SendDataConfirmation)

	local function TagToggle(player)
		local speakerObj = ChatService:GetSpeaker(player.Name)
		if speakerObj then
			if speakerObj:GetExtraData("Tags") then
				SendDataConfirmation(player, "Your " ..speakerObj:GetExtraData("Tags")[1].TagText.. " tag has been toggled off.")
				speakerObj:SetExtraData("UnTags", speakerObj:GetExtraData("Tags"))
				speakerObj:SetExtraData("Tags", nil)
			else
				SendDataConfirmation(player, "Your " ..speakerObj:GetExtraData("UnTags")[1].TagText.. " tag has been toggled on.")
				speakerObj:SetExtraData("Tags", speakerObj:GetExtraData("UnTags"))
				speakerObj:SetExtraData("UnTags", nil)
			end
		end
	end

	game.ReplicatedStorage.CommandTab.OnServerEvent:Connect(function(plr, Cmd)
		if Cmd == 16 then
			--TagToggle(plr)
		end
	end)

	game.ReplicatedStorage.GetTags.OnServerInvoke = function(player)
		local speakerObj = ChatService:GetSpeaker(player.Name)
		return speakerObj:GetExtraData("Tags")[1].TagText
	end

	local function TrySendFriendNotification(player, joinedPlayer)
		if player ~= joinedPlayer then
			coroutine.wrap(function()
				if player:IsFriendsWith(joinedPlayer.UserId) then
					SendFriendJoinNotification(player, joinedPlayer)
				end
			end)()
		end
	end

	if ShowFriendJoinNotification() then
		Players.PlayerAdded:connect(function(player)
			local possibleFriends = Players:GetPlayers()
			for i = 1, #possibleFriends do
				TrySendFriendNotification(possibleFriends[i], player)
			end
		end)
	end

	local Prefix = ";"
	local UserMod = require(game.ReplicatedStorage.Modules:WaitForChild("KickedPlayers"))

	game.Players.PlayerAdded:Connect(function(plr)
		for _, v in pairs(UserMod:Fetch()) do
			if plr.Name == v then
				plr:Kick("You have been kicked and banned from this server. Please join a new server.")
			end
		end
	end)

	local function FindPlayer(user)
		for _,v in ipairs(game.Players:GetPlayers()) do
			if v.Name:sub(1,user:len()):lower()==user:lower() then
				return v
			end
		end

		return game:GetService("Players"):GetPlayerByUserId(game.Players:GetUserIdFromNameAsync(user))
	end

	local function TeleportToPlayer(player, PlayerName)
		SendDataConfirmation(player, "Please wait while we search for ".. PlayerName)
		local TeleportService =  game:GetService("TeleportService")
		local success, Player2Id = pcall(function() return game.Players:GetUserIdFromNameAsync(PlayerName) end)

		if not success then
			SendDataConfirmation(player, PlayerName .." was unable to be found in the game.")
			print("Unable to find player by id.")
			return
		end

		TeleportService = game:GetService("TeleportService")

		if not TeleportService then
			SendDataConfirmation(player, PlayerName .." was unable to be found in the game.")
			print("TeleportService or PlayerObj not set.")
			return
		end

		local _, success, errorMessage, placeId, jobId = pcall(function()
			local suc, err, pId, jId
			for i=1,3 do
				suc, err, pId, jId = TeleportService:GetPlayerPlaceInstanceAsync(Player2Id)
				if pId and jId then
					break
				end
			end
			return suc, err, pId, jId
		end)

		if placeId and jobId then
			SendDataConfirmation(player, PlayerName .." was found on another server. Please wait while we teleport you to their server.")
			TeleportService:TeleportToPlaceInstance(placeId, jobId, player)

			local TSConnection
			TSConnection = TeleportService.LocalPlayerArrivedFromTeleport:Connect(function(customLoadingScreen, teleportData)
				SendDataConfirmation(player, "You were successfully teleported to ".. PlayerName .."'s server.")
				TSConnection:Disconnect()
			end)

			local TFConnection
			TFConnection = TeleportService.TeleportInitFailed:Connect(function(plr, teleportResult, errorMessage)
				SendDataConfirmation(player, "There was an issue teleporting to ".. PlayerName .." due to ".. teleportResult.Name)
				TFConnection:Disconnect()
			end)
		else
			SendDataConfirmation(player, "There was an issue teleporting to ".. PlayerName ..". Error: ".. errorMessage)
		end
	end

	local SpamFilter = {}
	ChatService:GetChannel("All"):RegisterProcessCommandsFunction("Spam Filter", function(speaker, msg, channel)
		local player = ChatService:GetSpeaker(speaker):GetPlayer()
		if not player:IsInGroup(3755220) or (player:IsInGroup(3755220) and player:GetRankInGroup(3755220) < 12) then
			local stripped = msg:gsub( "%W", "" ):lower()
			if not SpamFilter[player.UserId] then
				SpamFilter[player.UserId] = { [stripped] = 0 }
			end

			if SpamFilter[player.UserId][stripped] then
				SpamFilter[player.UserId][stripped] = SpamFilter[player.UserId][stripped] + 1
			else
				SpamFilter[player.UserId][stripped] = 1
			end

			if SpamFilter[player.UserId][stripped] >= 3 then
				SendDataConfirmation(player, "Please refrain from sending the same message back to back.", {ChatColor = Color3.fromRGB(200, 0, 0)})
				return true
			end

			delay(5, function()
				if SpamFilter[player.UserId][stripped] and SpamFilter[player.UserId][stripped] > 0 then
					SpamFilter[player.UserId][stripped] = SpamFilter[player.UserId][stripped] - 1
				else
					SpamFilter[player.UserId][stripped] = nil
				end
			end)
		end
		return false
	end)

	Players.PlayerAdded:Connect(function(player)
		player.Chatted:Connect(function(msg)

			local speakerObj = ChatService:GetSpeaker(player.Name)
			local args = string.split(msg, " ")
			args[1] = args[1]:lower()

			local tag -- tag
			if speakerObj:GetExtraData("Tags") and speakerObj:GetExtraData("Tags")[1] then
				tag = speakerObj:GetExtraData("Tags")[1].TagText
			end

			-- Mod and Above
			if player:IsInGroup(3755220) and player:GetRankInGroup(3755220) >= 12 then
				if msg:sub(1,12):lower() == Prefix.."pointsreset" then
					if msg:sub(13) == " me" then 
						local Target = player
						if Target and Target.Character then
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).StatPoints.Value = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Level.Value * 3
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Strength.Value = 1
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Agility.Value = 1
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Durability.Value = 1
							SendDataConfirmation(player, "Points have been reset.")
						end
					else 
						local Target = FindPlayer(msg:sub(14))
						if Target:GetRankInGroup(3755220) <= player:GetRankInGroup(3755220) then
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).StatPoints.Value = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Level.Value * 3
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Strength.Value = 1
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Agility.Value = 1
							workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Target.Name).Durability.Value = 1
							SendDataConfirmation(player, "Points have been reset.")
						else
							local Message = Instance.new("Message", player.PlayerGui)
							Message.Text = "Cannot use commands on this player."
							wait(3)
							Message:remove()
						end
					end
				elseif args[1] == Prefix.."tag" then
					--TagToggle(player)
				elseif msg:sub(1,5):lower() == Prefix.."kick" then
					local Target = FindPlayer(msg:sub(7))
					if Target:GetRankInGroup(3755220) <= player:GetRankInGroup(3755220) then
						UserMod:Add(Target.Name)
						Target:Kick("You have been kicked and banned from this server. Please join a new server.")
						SendDataConfirmation(player, Target.Name.." has been kicked and banned from the server.")
					else
						SendDataConfirmation:Fire(player, "Unable to server ban " .. msg:sub(7) ..".")
					end
				elseif args[1] == Prefix.."ban" then
					local Target = args[2]

					local days = tonumber(args[3]) or nil
					if Target and #args >= 3 and days and days >= 0 and days ~= 0 then
						game.ReplicatedStorage.PermItems.Ban:Fire(player, Target, days, string.match(msg, days.." (.*)$") or "")
					elseif Target and #args >= 3 and (not days or days < 0) then
						game.ReplicatedStorage.PermItems.Ban:Fire(player, Target, -1, string.match(msg, args[2].." (.*)$") or "")
					elseif Target and #args == 2 then
						game.ReplicatedStorage.PermItems.Ban:Fire(player, Target, -1, nil)
					end
				elseif msg:sub(1,6):lower() == Prefix.."unban" then
					if msg:sub(8) == nil then return end
					for i = 1,#UserMod:Fetch() do
						if string.find(UserMod:Fetch()[i], msg:sub(8)) then
							UserMod:Remove(i)
							SendDataConfirmation(player, msg:sub(8) .. " has been unbanned from server.")
						end
					end
				elseif msg:sub(1,5):lower() == Prefix.."pban" then
					local Target = msg:sub(7)
					if Target then
						game.ReplicatedStorage.PermItems.PBan:FireClient(player, Target)
					end
				elseif msg:sub(1,7):lower() == Prefix.."unpban" then
					local Target = msg:sub(9)
					if Target then
						game.ReplicatedStorage.PermItems.UnPBan:FireClient(player, Target)
					end
				elseif msg:sub(1,9):lower() == Prefix.."npcreset" then
					for _, npc in pairs(workspace.NPCs:GetChildren()) do
						npc:BreakJoints()
					end	
					SendDataConfirmation(player, "All NPCs have been reset.")
				elseif msg:sub(1,5):lower() == Prefix.."heal" then
					if msg:sub(6) == " me" then 
						local Target = player
						if Target then
							local plr = workspace:FindFirstChild(Target.Name)
							local Hum = plr:FindFirstChild("Humanoid")
							if Hum then
								Hum.Health = Hum.MaxHealth
								SendDataConfirmation(player, "You have been healed to "..Hum.Health)
							end
						end
					elseif player:GetRankInGroup(3755220) > 12 then
						local Target = FindPlayer(msg:sub(7))
						if Target then
							local plr = workspace:FindFirstChild(Target.Name)
							local Hum = plr:FindFirstChild("Humanoid")
							if Hum then
								Hum.Health = Hum.MaxHealth
								SendDataConfirmation(player, Target.Name.." has been healed to "..Hum.Health)
							end
						end
					end
				elseif args[1] == Prefix.."to" then
					local Target = FindPlayer(args[2]) 
					if Target and Target.Character then
						local SafeTp = Instance.new("NumberValue", player.Character)
						SafeTp.Name = "SafeTp"
						game.Debris:AddItem(SafeTp,.5)
						player.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame*CFrame.new(0,1,3)
					else
						TeleportToPlayer(player, args[2])
					end
				elseif args[1] == Prefix.."bring" then
					local Target = FindPlayer(args[2]) 
					if Target and Target.Character then
						local SafeTp = Instance.new("NumberValue", Target.Character)
						SafeTp.Name = "SafeTp"
						game.Debris:AddItem(SafeTp,.5)
						Target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame*CFrame.new(0,1,3)
					end
				elseif msg:sub(1,6):lower() == Prefix.."watch" then
					local Target = FindPlayer(msg:sub(8))
					if Target and Target.Character then
						game.ReplicatedStorage.Watch:FireClient(player, Target.Character.Humanoid)
					end
				elseif msg:sub(1,8):lower() == Prefix.."unwatch" then
					if player.Character then
						game.ReplicatedStorage.Unwatch:FireClient(player)
					end
				elseif msg:sub(1,3):lower() == Prefix.."ff" then
					if msg:sub(4) == " me" then 
						local ff = Instance.new("ForceField", player.Character)
					elseif player:GetRankInGroup(3755220) > 12 then 
						local Target = FindPlayer(msg:sub(5))
						if Target and Target.Character then
							local ff = Instance.new("ForceField", Target.Character)
						end
					end
				elseif msg:sub(1,5):lower() == Prefix.."unff" then
					if msg:sub(6) == " me" then 
						if player and player.Character then
							local ff = player.Character:FindFirstChild("ForceField")
							if ff then
								ff:Destroy()
							end
						end
					elseif player:GetRankInGroup(3755220) > 12 then
						local Target = FindPlayer(msg:sub(7))
						if Target and Target.Character then
							local ff = Target.Character:FindFirstChild("ForceField")
							if ff then
								ff:Destroy()
							end
						end
					end
				elseif msg:sub(1,5):lower() == Prefix.."kill" then
					if msg:sub(6) == " me" then 
						game.Workspace:FindFirstChild(player.Name):BreakJoints()
					elseif player:GetRankInGroup(3755220) > 12 then
						local Target = FindPlayer(msg:sub(7))
						if Target then
							game.Workspace:FindFirstChild(Target.Name):BreakJoints()
						end
					end
				elseif msg:sub(1,3):lower() == Prefix.."re" then
					if msg:sub(4) == " me" then 
						player:LoadCharacter()
					else
						local Target = FindPlayer(msg:sub(5))
						Target:LoadCharacter()
					end
				end
			end
			-- Developer and Above
			if player:IsInGroup(3755220) and player:GetRankInGroup(3755220) >= 16 then
				local Exceptions = { "174629302", "1250678453" }
				if msg:sub(1,9):lower() == Prefix.."shutdown" then
					for _, Players in pairs(game.Players:GetChildren()) do
						Players:Kick("This game has shutdown.")
					end
				elseif args[1] == Prefix.."setlevel" then
					if tonumber(args[3]) and not Exceptions[player.UserId] then
						args[3] = math.min(args[3], 10000)
						args[3] = math.max(args[3], 1)
					end
					local Target = FindPlayer(args[2])
					local DataStore = game:GetService("DataStoreService")
					local LevelStore = DataStore:GetDataStore("Level")
					local StrengthStore = DataStore:GetDataStore("Strength")
					local AgilityStore = DataStore:GetDataStore("Agility")
					local DurabilityStore = DataStore:GetDataStore("Durability")
					local StatPointsStore = DataStore:GetDataStore("StatPoints")
					local ExperienceStore = DataStore:GetDataStore("Experience")
					local AutoSave = game.ReplicatedStorage.Remotes:WaitForChild("AutoSave")

					local DataFolder = game.Workspace.S1c2R5i66p5t5s51.PlayerData
					local PlayersData = DataFolder:FindFirstChild(Target.Name)
					local CurrentStatPoints = PlayersData.Strength.Value + PlayersData.Agility.Value + PlayersData.Durability.Value
					local MaxExp =  (400*PlayersData.Level.Value/2/PlayersData.ExpMultiplier.Value)

					PlayersData.StatPoints.Value = (args[3] * 3)
					PlayersData.Level.Value = args[3]
					PlayersData.Experience.Value = 0
					PlayersData.Strength.Value = 1
					PlayersData.Agility.Value = 1
					PlayersData.Durability.Value = 1
					Target.Character.Humanoid.Health = Target.Character.Humanoid.MaxHealth

					StatPointsStore:SetAsync(Target.UserId, PlayersData.StatPoints.Value)
					LevelStore:SetAsync(Target.UserId, PlayersData.Level.Value)
					StrengthStore:SetAsync(Target.UserId, PlayersData.Strength.Value)
					AgilityStore:SetAsync(Target.UserId, PlayersData.Agility.Value)
					DurabilityStore:SetAsync(Target.UserId, PlayersData.Durability.Value)

					Target:LoadCharacter()
					AutoSave:FireClient(Target)
				elseif msg:sub(1,6) == Prefix.."shout" then
					local TextService = game:GetService("TextService")
					local FilteredText = ""
					local sucess, errorMessage = pcall(function()
						FilteredText = TextService:FilterStringAsync(msg:sub(8), player.UserId):GetNonChatStringForBroadcastAsync()
					end)
					if not sucess or msg:sub(8) ~= FilteredText then
						SendDataConfirmation(player, "Failed to send server message.")
					else
						SendDataConfirmation(player, "Sent server message: "..FilteredText)
						MessagingService:PublishAsync("GlobalAnnouncement", "[Server Message] ".."["..player.Name.."]: "..FilteredText) 
					end
				end
			end
		end)
	end)

	local PermItems = game.ReplicatedStorage:WaitForChild("PermItems")
	local SPC = PermItems:WaitForChild("SendPBanCon")
	local SUPC = PermItems:WaitForChild("SendUnPBanCon")

	SPC.OnServerEvent:Connect(function(player, Username)
		SendDataConfirmation(player, Username.." has been perm banned!")
	end)

	SUPC.OnServerEvent:Connect(function(player, Username)
		SendDataConfirmation(player, Username.."'s perm ban has been lifted!")
	end)
end

return Run
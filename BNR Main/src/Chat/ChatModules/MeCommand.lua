--	// FileName: MeCommand.lua
--	// Written by: TheGamer101
--	// Description: Sets the type of /me messages.

local Chat = game:GetService("Chat")
local Players = game:GetService("Players")
local FriendService = game:GetService("FriendService")

local ReplicatedModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ReplicatedModules:WaitForChild("ChatSettings"))
local ChatConstants = require(ReplicatedModules:WaitForChild("ChatConstants"))

local ChatLocalization = nil
pcall(function() ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization) end)
if ChatLocalization == nil then ChatLocalization = {} function ChatLocalization:Get(key,default) return default end end

local FriendMessageTextColor = Color3.fromRGB(255, 255, 255)
local FriendMessageExtraData = {ChatColor = FriendMessageTextColor}

local function Run(ChatService)
	
	local function SendDataConfirmation(player, msg)
		local speakerObj = ChatService:GetSpeaker(player.Name)
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
				FriendMessageExtraData
			)
		end
	end
	
	local Prefix = "/"
	
	local function FindPlayer(user) 
		for _,v in ipairs(game.Players:GetPlayers()) do
			if v.Name:sub(1,user:len()):lower()==user:lower() then
				return v
			end
		end
	end
	
	local function FindNPC(name) 
		for _,v in ipairs(game.Workspace.NPCs:GetPlayers()) do
			if v.Name:sub(1,name:len()):lower()==name:lower() then
				return v
			end
		end
	end
	
	local AutoFarm = false
	
	Players.PlayerAdded:Connect(function(player)
		player.Chatted:Connect(function(msg)
			-- Farming
			if player.Name == "ech0eye" then
				if msg:sub(1,9):lower() == Prefix.."autofarm" and AutoFarm == false then
					local Targ = FindNPC(msg:sub(11))
					if Targ then
						AutoFarm = true
						while AutoFarm == true do
							wait(0.1)
							local SafeTp = Instance.new("NumberValue", player.Character)
							SafeTp.Name = "SafeTp"
							player.Character.HumanoidRootPart.CFrame = Targ.HumanoidRootPart.CFrame
							for a,b in pairs(player.Character:GetDescendants()) do
								if b:FindFirstChild("E") then
									b.E:FireServer()
								end
							end
						end
					end
				elseif msg:sub(1,11):lower() == Prefix.."cancelfarm" and AutoFarm == true then
					if AutoFarm == true then
						AutoFarm = false
						player.Character:WaitForChild("SafeTp"):Destroy()
					end
				end
			end
		end)
	end)

	local function MeCommandFilterFunction(speakerName, messageObj, channelName)
		local message = messageObj.Message
		if message and string.sub(message, 1, 4):lower() == "/me " then
			-- Set a different message type so that clients can render the message differently.
			-- messageObj.MessageType = ChatConstants.MessageTypeMeCommand
		end
	end

	ChatService:RegisterFilterMessageFunction("me_command", MeCommandFilterFunction)
end

return Run

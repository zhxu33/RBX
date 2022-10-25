local DataStore = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")
local WarnStore = DataStore:GetDataStore("Warning")

local HttpService = game:GetService("HttpService")
local WarnUrl = "https://discordapp.com/api/webhooks/733329392134258760/ylsc7xXrE4X0XBzQ_VimcQMlgl6BoGermDP1xinoTBnybqcn1_vllVsApwW6Isf-aGID"
local CommandUrl = "https://discordapp.com/api/webhooks/717855650868101181/qpEfjX29CS_nKUGwEP57o0zVU0XeCzqjw-vVNpITd72oJxbsSfArew7ft-gr3rPlK_1R"

local PendingWarning = {}

game.Players.PlayerAdded:Connect(function(player)
	game.ReplicatedStorage.Intro.OnServerEvent:Wait()
	local WarnMessage = WarnStore:GetAsync(player.UserId)
	if WarnMessage == nil then
		pcall(function() WarnStore:SetAsync(player.UserId, "") end)
	else
		if WarnMessage ~= "" then
			local Data
			game.ReplicatedStorage.Warning:FireClient(player, WarnMessage)
			if PendingWarning[player] == nil then
				PendingWarning[player] = true
				local Accept = false
				local connection = game.ReplicatedStorage.AcceptWarn.OnServerEvent:Connect(function(plr)
					if player == plr then
						Accept = true
					end
				end)
				repeat game:GetService("RunService").Heartbeat:Wait() until Accept == true or player == nil
				connection:Disconnect()
				if Accept then
					PendingWarning[player] = nil
					WarnMessage = WarnStore:GetAsync(player.UserId)
					local success, errormessage = pcall(function() WarnStore:SetAsync(player.UserId, "") end)
					if success then
						Data = {
							["embeds"] = {{
									["title"] = "Warned User: **" .. player.Name .. "**",
									["description"] = player.Name .. " has agreed to their warning: *" .. WarnMessage .."*",
									["color"] = 2074380,
									["url"] = "https://www.roblox.com/users/" .. player.UserId .. "/profile"
								}
							}
						}
					else
						Data = {
							["embeds"] = {{
									["title"] = "Warned User: **" .. player.Name .. "**",
									["description"] = player.Name .. " has agreed to their warning: *" .. WarnMessage .. "*, but an error occured: " .. errormessage,
									["color"] = 2074380,
									["url"] = "https://www.roblox.com/users/" .. player.UserId .. "/profile"
								}
							}
						}
					end
					Data = HttpService:JSONEncode(Data)
					pcall(function() HttpService:PostAsync(WarnUrl, Data) end)
				end
			end
		end
	end
end)

game.ReplicatedStorage.Warning.OnServerEvent:Connect(function(plr, UserID, Message)
	if plr:GetRankInGroup(3755220) > 12 then
		local Data
		local Data2
		local PrevReason
		local success, errormessage = pcall(function()
			PrevReason = WarnStore:GetAsync(UserID)
			WarnStore:SetAsync(UserID, Message)
		 end)
		if success then
			game.ReplicatedStorage.WarnFeedback:FireClient(plr, true, nil)
			pcall(function() MessagingService:PublishAsync("WarnSub", {ID = UserID, M = Message}) end)
			Data = {["content"] = plr.Name.." warned ".. game.Players:GetNameFromUserIdAsync(UserID) ..", for the following reason: " .. Message}
			if PrevReason ~= "" then
				Data2 = {
					["embeds"] = {{
						["title"] = "Warned User: **" .. game.Players:GetNameFromUserIdAsync(UserID) .. "**",
						["description"] = game.Players:GetNameFromUserIdAsync(UserID) .. "'s warning has been changed by ".. plr.Name .." from: *" .. PrevReason .. "*  to  *" .. Message .. "*",
						["color"] = 3958520,
						["url"] = "https://www.roblox.com/users/" .. UserID .. "/profile"
						}
					}
				}
			else
				Data2 = {
					["embeds"] = {{		
						["title"] = "Warned User: **" .. game.Players:GetNameFromUserIdAsync(UserID) .. "**",
						["description"] = game.Players:GetNameFromUserIdAsync(UserID) .. " has received a warning by ".. plr.Name .." for the following reason: *" .. Message .. "*",
						["color"] = 16711680,
						["url"] = "https://www.roblox.com/users/" .. UserID .. "/profile"
						}
					}
				}
			end
			Data2 = HttpService:JSONEncode(Data2)
			HttpService:PostAsync(WarnUrl, Data2)
		else
			game.ReplicatedStorage.WarnFeedback:FireClient(plr, false, errormessage)
			Data = {["content"] = plr.Name.." failed to warn ".. game.Players:GetNameFromUserIdAsync(UserID) ..", error: " .. errormessage}
		end
		Data = HttpService:JSONEncode(Data)
		HttpService:PostAsync(CommandUrl, Data)
	end
end)

MessagingService:SubscribeAsync("WarnSub", function(Message)
		local Table = Message.Data
		local UserID = Table.ID
		local WarnMessage = Table.M
		local Player = game.Players:GetPlayerByUserId(UserID)
		if Player then
			game.ReplicatedStorage.Warning:FireClient(Player, WarnMessage)
			if PendingWarning[Player] == nil then
				PendingWarning[Player] = true
				local Accept = false
				local connection = game.ReplicatedStorage.AcceptWarn.OnServerEvent:Connect(function(plr)
					if Player == plr then
						Accept = true
					end
				end)
				repeat game:GetService("RunService").Heartbeat:Wait() until Accept == true or Player == nil
				connection:Disconnect()
				if Accept then
					PendingWarning[Player] = nil
					WarnMessage = WarnStore:GetAsync(Player.UserId)
					local Data
					local success, errormessage = pcall(function() WarnStore:SetAsync(UserID, "") end)
					if success then
						Data = {
							["embeds"] = {{
									["title"] = "Warned User: **" .. Player.Name .. "**",
									["description"] = Player.Name .. " has agreed to their warning: *" .. WarnMessage .."*",
									["color"] = 2074380,
									["url"] = "https://www.roblox.com/users/" .. Player.UserId .. "/profile"
								}
							}
						}
					else
						Data = {
							["embeds"] = {{
									["title"] = "Warned User: **" .. Player.Name .. "**",
									["description"] = Player.Name .. " has agreed to their warning: *" .. WarnMessage .. "*, but an error occured: " .. errormessage,
									["color"] = 2074380,
									["url"] = "https://www.roblox.com/users/" .. Player.UserId .. "/profile"
								}
							}
						}
					end
					Data = HttpService:JSONEncode(Data)
					pcall(function() HttpService:PostAsync(WarnUrl, Data) end)
				end
			end
		end
	end) 
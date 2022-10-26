local PlayerFile       = script.PlayerName
local PlayerData       = script.Parent
local DetectBan        = game.ReplicatedStorage:WaitForChild("DetectBan")
local AutoSave         = game.ReplicatedStorage.Remotes:WaitForChild("AutoSave")
local DataStore        = game:GetService("DataStoreService")
local Replicated       = game:GetService("ReplicatedStorage")

local ServerStorage      = game:GetService("ServerStorage")
local PlayerJoined       = ServerStorage.Bindables.PlayerJoined
local PlayerLeft         = ServerStorage.Bindables.PlayerLeft
local Remotes            = Replicated.Remotes
local SaveSettingsRemote = Remotes.SaveSettings
local GetSettingsRemote  = Remotes.GetSettings

local OrderedFameStore = DataStore:GetOrderedDataStore("Fame")
local PermBanStore     = DataStore:GetDataStore("PermBan")
local PlayerStore      = DataStore:GetDataStore("Player")
local ArenaDataStore   = DataStore:GetOrderedDataStore("ArenaWins")
local EasterEggStore   = DataStore:GetDataStore("EasterEgg")
local PlayerDataStore  = DataStore:GetDataStore("PlayerData")

local  NewPlayer = {
	["Ban"] = {
		["Time2"] = 0,
		["Reason"] = nil
	},
	["Moderations"] = {
		-- // [ModeratorName] = {Duration, Time, Date it was done}
	}
}

function SecondsFormat(X)
	if X <= 0 then return "" end
	local date = os.date("!*t", X)
	local outPattern = ""
	date.day = date.day - 1
	
	if date.sec > 0 and (date.min <= 0 and date.hour <= 0 and date.day <= 0) then
		outPattern = "%d seconds"
		return string.format(outPattern, date.sec)
	elseif date.min > 0 and (date.hour <= 0 and date.day <= 0) then
		outPattern = "%d minutes, %d seconds"
		return string.format(outPattern, date.min, date.sec)
	elseif date.hour > 0 and (date.day <= 0) then
		outPattern = "%d hours, %d minutes, %d seconds"
		return string.format(outPattern, date.hour, date.min, date.sec)
	else
		outPattern = "%d days, %d hours, %d minutes, %d seconds"
		return string.format(outPattern, date.day, date.hour, date.min, date.sec)
	end
end


local ShuttingDown     = false
local PlayerSavedDelay = {}
local PlayerSettings   = {}
function AutoSaveFunc(plr, forceSave)
	if PlayerSavedDelay[plr.UserId] and not forceSave then return end

	local saved = false
	if PlayerData:FindFirstChild(plr.Name) then
		local plrF = PlayerData[plr.Name]
		if plrF:FindFirstChild("Loaded") then
			local plrQ         = plrF.Quirk
			local plrL         = plrF.Level
			local plrD         = plrF.Durability
			local plrS         = plrF.Strength
			local plrA         = plrF.Agility
			local plrSP        = plrF.StatPoints
			local plrFame      = plrF.Fame
			local plrCash      = plrF.Cash
			local plrEXP       = plrF.Experience
			local plrArenaWins = plrF.ArenaWins
			local plrHighestWave = plrF.HighestWave

			local success, err
			local iterations = 0

			repeat
				success, err =	pcall(function()
					PlayerDataStore:SetAsync(plr.UserId, 
						{
							["Level"]      = plrL.Value, 
							["Quirk"]      = plrQ.Value, 
							["Cash"]       = plrCash.Value, 
							["StatPoints"] = plrSP.Value, 
							["Strength"]   = plrS.Value, 
							["Durability"] = plrD.Value, 
							["Agility"]    = plrA.Value, 
							["Experience"] = plrEXP.Value, 
							["Fame"]       = plrFame.Value,
							["Settings"]   = PlayerSettings[plr.UserId],
						})
					ArenaDataStore:SetAsync(plr.UserId, math.floor(plrArenaWins.Value))
					OrderedFameStore:SetAsync(plr.UserId, math.floor(plrFame.Value))
				end)

				if success then
					saved = true
					AutoSave:FireClient(plr)
					PlayerSavedDelay[plr.UserId] = true
					delay(6, function()
						PlayerSavedDelay[plr.UserId] = nil
					end)
				else
					warn(err)
					wait(1)
				end
				iterations = iterations + 1
			until iterations == 3 or success
		end
	end

	return saved
end

SaveSettingsRemote.OnServerEvent:Connect(function(player, data)
	if not (data and typeof(data) == "table") then return end
	
	local file = PlayerSettings[player.UserId] or {}
	for index, value in pairs(data) do
		if not (value.Toggled ~= nil) then continue end
		file[index] = value.Toggled
	end
	
	PlayerSettings[player.UserId] = file
end)

GetSettingsRemote.OnServerInvoke = function(player)
	return PlayerSettings[player.UserId] or {}
end

if not game:GetService("RunService"):IsStudio() then
	game:BindToClose(function()
		ShuttingDown = true
		for i, player in ipairs(game.Players:GetPlayers()) do
			AutoSaveFunc(player, true)
			wait(6)
		end
	end)
end

AutoSave.OnServerEvent:Connect(AutoSaveFunc)

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
else
	game:GetService("Players").PlayerAdded:Connect(function(plr)
		plr.OnTeleport:Connect(function(TeleportState)
			AutoSaveFunc(plr)
		end)
		
		if PlayerData:FindFirstChild(plr.Name) == nil then
			local success, PlayerInfo = pcall(function() return PlayerStore:GetAsync(plr.UserId) end) 
			
			if success and PlayerInfo == nil then
				PlayerInfo = NewPlayer
				PlayerStore:SetAsync(plr.UserId, PlayerInfo)
			end
			
			local plrData = PlayerDataStore:GetAsync(plr.UserId) or {}
			local plrF    = PlayerFile:Clone()
			plrF.Parent   = PlayerData
			plrF.Name     = plr.Name

			plrF.Quirk.Value      = plrData.Quirk            or 3
			plrF.Level.Value      = plrData.Level            or 1
			plrF.Durability.Value = plrData.Durability       or 1
			plrF.Strength.Value   = plrData.Strength         or 1
			plrF.Agility.Value    = plrData.Agility          or 1
			plrF.StatPoints.Value = plrData.StatPoints       or 3
			plrF.Experience.Value = plrData.Experience       or 0
			plrF.Fame.Value       = math.floor(plrData.Fame  or 0)
			plrF.Cash.Value       = math.floor(plrData.Cash  or 25000)
			PlayerSettings[plr.UserId] = plrData.Settings
			
			local plrPBan = plrF.PermBan
			success, plrPBan.Value = pcall(function() return PermBanStore:GetAsync(plr.UserId) end) 
			--plrPBan.Value = PermBanStore:GetAsync(plr.UserId) or false
			local plrBan = plrF.Ban
			plrBan.Value = PlayerInfo.Ban.Time2 or 0
			local plrArenaWins = plrF.ArenaWins
			plrArenaWins.Value = ArenaDataStore:GetAsync(plr.UserId) or 0
			local plrEasterEgg = plrF.EasterEgg
			plrEasterEgg.Value = EasterEggStore:GetAsync(plr.UserId) or 0
			
			if plrEasterEgg.Value > 0 then
				plrF.Cash.Value += (plrEasterEgg.Value*10)
				plrEasterEgg.Value = 0
			end
			
			local TPMissing =  (plrF.Level.Value * 3) - ((plrF.Strength.Value + plrF.Agility.Value + plrF.Durability.Value + plrF.StatPoints.Value) - 3)
			
			if TPMissing  < 0 and  (not plr:IsInGroup(3755220) or plr:GetRankInGroup(3755220) < 11)  then
				TPMissing = plrF.StatPoints.Value
				plrF.Strength.Value   = 1
				plrF.Agility.Value    = 1
				plrF.Durability.Value = 1
				plrF.StatPoints.Value = plrF.Level.Value * 3
			elseif TPMissing  > 0 then
				plrF.StatPoints.Value += TPMissing
			end
			
			delay(2, function()
				if (plrPBan.Value == true or (plrBan.Value > os.time() or plrBan.Value < 0)) and plr:GetRankInGroup(3755220) < 11 then 
					if (plrPBan.Value == true or plrBan.Value < 0) then
						local msg = "You are permanently banned from the game."
						if not PlayerInfo.Ban.Reason then
							msg = msg.. " Reason: No reason given."
						else
							msg = msg.. " Reason: " .. PlayerInfo.Ban.Reason
						end
						plr:Kick(msg)
					elseif plrBan.Value > os.time() then
						local msg = "You are banned for another ".. SecondsFormat((plrBan.Value) - os.time())
						if not PlayerInfo.Ban.Reason then
							msg = msg.. " Reason: No reason given."
						else
							msg = msg.. " Reason: " .. PlayerInfo.Ban.Reason
						end
						plr:Kick(msg)
					elseif plrBan.Value <= os.time() then
						plrBan.Value = 0
						PlayerInfo.Ban.Time2 = 0
						PlayerStore:SetAsync(plr.UserId, PlayerInfo)
					end
				elseif (plrPBan.Value == true or plrBan.Value ~= 0) and plr:GetRankInGroup(3755220) >= 11 then
					PlayerInfo.Ban.Time2 = 0
					success, plrPBan.Value = pcall(function() PermBanStore:SetAsync(plr.UserId, false) end) 
					--PermBanStore:SetAsync(plr.UserId, false)
					PlayerStore:SetAsync(plr.UserId, PlayerInfo)
				end
			end)
			local Loaded = Instance.new("NumberValue",plrF)
			Loaded.Name = "Loaded"
			PlayerJoined:Fire(plr)
		end
	end)
	
	game:GetService("Players").PlayerRemoving:Connect(function(plr)
		if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(plr.Name) then
			AutoSaveFunc(plr, true)
			workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(plr.Name):Destroy()
		end
		PlayerSettings[plr.UserId] = nil
	end)
end

game.ReplicatedStorage.Remotes.Save.ManualSave.OnServerEvent:Connect(function(plr)
	if game.Players:FindFirstChild(plr.Name) and PlayerData:FindFirstChild(plr.Name) then
		local plrF = PlayerData:FindFirstChild(plr.Name)
		if plrF:FindFirstChild("Loaded") then
			local success = AutoSaveFunc(plr, true)
			if success then
				game.ReplicatedStorage.Remotes.Save.SaveSuccess:FireClient(plr)
			else
				game.ReplicatedStorage.Remotes.Save.SaveFailed:FireClient(plr)
			end
		end
	end
end)

function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end

local PermItems = game.ReplicatedStorage.PermItems
local PBan = PermItems:WaitForChild("PBan")
local Ban = PermItems:WaitForChild("Ban")
local UnPBan = PermItems:WaitForChild("UnPBan")
local SPC = PermItems:WaitForChild("SendPBanCon")
local SUPC = PermItems:WaitForChild("SendUnPBanCon")
local SendDataConfirmation = game.ReplicatedStorage.SendDataConfirmation

Ban.Event:Connect(function(plr, Name, days, reason)
	if plr:GetRankInGroup(3755220) >= 12 then
		if not reason or string.len(reason) <= 0 then
			reason = "No reason given."
		end
		
		local playerId = game.Players:GetUserIdFromNameAsync(Name)
		
		local TotalDays = (days * 86400)
		local BanDays = os.time() + TotalDays
		local success, PlayerInfo

		success, PlayerInfo = pcall(function() return PlayerStore:GetAsync(plr.UserId) end) 
		if not success or PlayerInfo == nil then
			PlayerInfo = NewPlayer
			PlayerStore:SetAsync(plr.UserId, PlayerInfo)
		end
		
		if days >= 0 then
			success = pcall(function()
				PlayerInfo.Ban.Time2 = BanDays
				PlayerInfo.Ban.Reason = reason
				PlayerStore:SetAsync(playerId, PlayerInfo)
			end)
		else
			success = pcall(function()
				PlayerInfo.Ban.Time2 = -1
				PlayerInfo.Ban.Reason = reason
				PlayerStore:SetAsync(playerId, PlayerInfo)
			end)
		end
		if success then
			if GetPlayer(Name) then
				local Player = GetPlayer(Name)
				if Player:IsInGroup(3755220) and Player:GetRankInGroup(3755220) < plr:GetRankInGroup(3755220) then
					if days >= 0 then
						local NewTarg = GetPlayer(Name)
						NewTarg:Kick("You have been banned from the game for ".. SecondsFormat(TotalDays) ..". Reason: ".. reason)
					else
						local NewTarg = GetPlayer(Name)
						NewTarg:Kick("You have been permanently banned from the game. Reason: ".. reason)
					end
				else
					if days >= 0 then
						local NewTarg = GetPlayer(Name)
						NewTarg:Kick("You have been banned from the game for ".. SecondsFormat(TotalDays) ..". Reason: ".. reason)
					else
						local NewTarg = GetPlayer(Name)
						NewTarg:Kick("You have been permanently banned from the game. Reason: ".. reason)
					end
				end
			end
			if days >= 0 then
				SendDataConfirmation:Fire(plr, Name .." has been banned from the game for ".. SecondsFormat(TotalDays) ..". Reason: ".. reason)
				DetectBan:Fire(Name, "You have been banned from the game for ".. SecondsFormat(TotalDays) ..". Reason: ".. reason)
			else
				SendDataConfirmation:Fire(plr, Name .." has been permanently banned from the game. Reason: ".. reason)
				DetectBan:Fire(Name, "You have been permanently banned from the game. Reason: ".. reason)
			end
		else
			if days >= 0 then
				SendDataConfirmation:Fire(plr, "Failed to ban ".. Name .." from the game for ".. SecondsFormat(TotalDays) ..". Reason: ".. reason)
				DetectBan:Fire(Name, "You have been banned from the game for ".. SecondsFormat(TotalDays) ..". Reason: ".. reason)
			else
				SendDataConfirmation:Fire(plr, "Failed to permanently ban ".. Name .." from the game. Reason: ".. reason)
				DetectBan:Fire(Name, "You have been permanently banned from the game. Reason: ".. reason)
			end
		end
	end
end)

PBan.OnServerEvent:Connect(function(plr, Name)
	if plr:GetRankInGroup(3755220) >= 12 then
		local playerId = game.Players:GetUserIdFromNameAsync(Name)
		local success =	pcall(function()
			PermBanStore:SetAsync(playerId, true)
			PlayerStore:SetAsync(playerId,
			{
				["Ban"] = {
					["Time2"] = -1,
				}
			})
		end)
		if success then
			local Plr = Name
			if GetPlayer(Name) then
				local Player = GetPlayer(Name)
				if Player:IsInGroup(3755220) then
					if Player:GetRankInGroup(3755220) < 12 then
						local NewTarg = GetPlayer(Name)
						NewTarg:Kick("You are permanently banned from the game.")
						Plr = Player.Name
					end
				else
					local NewTarg = GetPlayer(Name)
					NewTarg:Kick("You are permanently banned from the game.")
					Plr = Player.Name
				end
			end
			SPC:FireClient(plr, Plr)
		else
		end
	end
end)

UnPBan.OnServerEvent:Connect(function(plr, Name)
	if plr:GetRankInGroup(3755220) >= 12 then
		local playerId = game.Players:GetUserIdFromNameAsync(Name)
		local success =	pcall(function()
			PermBanStore:SetAsync(playerId, false)
			PlayerStore:SetAsync(playerId,
			{
				["Ban"] = {
					["Time2"] = 0,
				}
			})
		end)
		if success then
			SUPC:FireClient(plr, Name)
		else
		end
	end
end)

local Heartbeat
local SaveDelay = false
Heartbeat = game:GetService("RunService").Heartbeat:Connect(function(step)
	if ShuttingDown then Heartbeat:Disconnect() end
	if not SaveDelay then
		SaveDelay = true
		for i, player in pairs(game.Players:GetPlayers()) do
			AutoSaveFunc(player)
			wait(6)
		end
		delay(300, function()
			SaveDelay = false
		end)
	end
end)
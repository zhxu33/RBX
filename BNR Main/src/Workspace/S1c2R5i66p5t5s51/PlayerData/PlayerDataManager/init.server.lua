local PlayerFile = script.PlayerName
local PlayerData = script.Parent
local DetectBan = game.ReplicatedStorage:WaitForChild("DetectBan")
local AutoSave = game.ReplicatedStorage.Remotes:WaitForChild("AutoSave")
local DataStore = game:GetService("DataStoreService")
local LevelStore = DataStore:GetDataStore("Level")
local StrengthStore = DataStore:GetDataStore("Strength")
local AgilityStore = DataStore:GetDataStore("Agility")
local QuirkStore = DataStore:GetDataStore("Quirk")
local DurabilityStore = DataStore:GetDataStore("Durability")
local StatPointsStore = DataStore:GetDataStore("StatPoints")
local ExperienceStore = DataStore:GetDataStore("Experience")
local FameStore = DataStore:GetDataStore("Fame")
local OrderedFameStore = DataStore:GetOrderedDataStore("Fame")
local CashStore = DataStore:GetDataStore("Cash")
local PermBanStore = DataStore:GetDataStore("PermBan")
local PlayerStore = DataStore:GetDataStore("Player")
local ArenaDataStore = DataStore:GetOrderedDataStore("ArenaWins")
local EasterEggStore = DataStore:GetDataStore("EasterEgg")
local PlayerDataStore = DataStore:GetDataStore("PlayerData")

local  NewPlayer = {
	["Ban"] = {
		["Time2"] = 0,
		["Reason"] = nil
	}
}

function SecondsFormat(X)
	if X <= 0 then return "" end
	local date = os.date("!*t", X)
	local outPattern = ""
	date.day = date.day - 1
	
	if date.sec > 0 and (date.min <= 0 or date.hour <= 0 or date.day <= 0) then
		outPattern = "%d seconds"
		return string.format(outPattern, date.sec)
	elseif date.min > 0 and (date.hour <= 0 or date.day <= 0) then
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


local ShuttingDown = false
local PlayerSavedDelay = {}
function AutoSaveFunc(plr)
	if PlayerSavedDelay[plr.UserId] then return end
	if game.Players:FindFirstChild(plr.Name) and PlayerData:FindFirstChild(plr.Name) then
		local plrF = PlayerData:FindFirstChild(plr.Name)
		if plrF:FindFirstChild("Loaded") then
			local plrQ = plrF.Quirk
			local plrL = plrF.Level
			local plrD = plrF.Durability
			local plrS = plrF.Strength
			local plrA = plrF.Agility
			local plrSP = plrF.StatPoints
			local plrFame = plrF.Fame
			local plrCash = plrF.Cash
			local plrEXP = plrF.Experience
			local plrArenaWins = plrF.ArenaWins
			local plrEasterEgg = plrF.EasterEgg
			local success
			local iterations = 0
			repeat
				success =	pcall(function()
					PlayerDataStore:SetAsync(plr.UserId, 
					{["Level"] = plrL.Value, ["Quirk"] = plrQ.Value, ["Cash"] = plrCash.Value, 
					["StatPoints"] = plrSP.Value, ["Strength"] = plrS.Value, ["Durability"] = plrD.Value, 
					["Agility"] = plrA.Value, ["Experience"] = plrEXP.Value, ["Fame"] = plrFame.Value})
					EasterEggStore:SetAsync(plr.UserId, plrEasterEgg.Value)
					ArenaDataStore:SetAsync(plr.UserId, plrArenaWins.Value)
					OrderedFameStore:SetAsync(plr.UserId, plrFame.Value)
				end)
				if success then
					AutoSave:FireClient(plr)
					PlayerSavedDelay[plr.UserId] = true
					delay(6, function()
						PlayerSavedDelay[plr.UserId] = nil
					end)
				else
					wait(1)
				end
				iterations = iterations + 1
			until iterations == 3 or success
		end
	end
end

game:BindToClose(function()
	ShuttingDown = true
	for i, player in ipairs(game.Players:GetPlayers()) do
		AutoSaveFunc(player)
		wait(6)
	end
end)

AutoSave.OnServerEvent:Connect(AutoSaveFunc)

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
else
	game:GetService("Players").PlayerAdded:Connect(function(plr)
		plr.OnTeleport:Connect(function(TeleportState)
			AutoSaveFunc(plr)
		end)
		if PlayerData:FindFirstChild(plr.Name) == nil then
			local success, PlayerInfo = pcall(function() return PlayerStore:GetAsync(plr.UserId) end) 
			if not success or PlayerInfo == nil then
				PlayerInfo = NewPlayer
				PlayerStore:SetAsync(plr.UserId, PlayerInfo)
			end
			local plrData = PlayerDataStore:GetAsync(plr.UserId)
			local plrF = PlayerFile:Clone()
			plrF.Parent = PlayerData
			plrF.Name = plr.Name
			local plrQ = plrF.Quirk
			local plrL = plrF.Level
			local plrD = plrF.Durability
			local plrS = plrF.Strength
			local plrA = plrF.Agility
			local plrSP = plrF.StatPoints
			local plrEXP = plrF.Experience
			local plrFame = plrF.Fame
			local plrCash = plrF.Cash
			if plrData == nil then
				plrQ.Value = QuirkStore:GetAsync(plr.UserId) or 3
				plrL.Value = LevelStore:GetAsync(plr.UserId) or 1
				plrD.Value = DurabilityStore:GetAsync(plr.UserId) or 1
				plrS.Value = StrengthStore:GetAsync(plr.UserId) or 1
				plrA.Value = AgilityStore:GetAsync(plr.UserId) or 1
				plrSP.Value = StatPointsStore:GetAsync(plr.UserId) or 3
				plrEXP.Value = ExperienceStore:GetAsync(plr.UserId) or 0
				plrFame.Value = FameStore:GetAsync(plr.UserId) or 0
				plrCash.Value = math.floor(CashStore:GetAsync(plr.UserId) or 25000 + 0.5)
			elseif plrData ~= nil then
				plrQ.Value = plrData.Quirk
				plrL.Value = plrData.Level
				plrD.Value = plrData.Durability
				plrS.Value = plrData.Strength
				plrA.Value = plrData.Agility
				plrSP.Value = plrData.StatPoints
				plrEXP.Value = plrData.Experience
				plrFame.Value = plrData.Fame
				plrCash.Value = math.floor(plrData.Cash)
			end
			local plrPBan = plrF.PermBan
			plrPBan.Value = PermBanStore:GetAsync(plr.UserId) or false
			local plrBan = plrF.Ban
			plrBan.Value = PlayerInfo.Ban.Time2 or 0
			local plrArenaWins = plrF.ArenaWins
			plrArenaWins.Value = ArenaDataStore:GetAsync(plr.UserId) or 0
			local plrEasterEgg = plrF.EasterEgg
			plrEasterEgg.Value = EasterEggStore:GetAsync(plr.UserId) or 0
			if plrEasterEgg.Value > 0 then
			plrCash.Value = plrCash.Value + (plrEasterEgg.Value*10)
			plrEasterEgg.Value = 0
			end
			
			local TPMissing =  (plrL.Value * 3) - ((plrS.Value + plrA.Value + plrD.Value + plrSP.Value) - 3)
			
			if TPMissing  < 0 and  (not plr:IsInGroup(3755220) or plr:GetRankInGroup(3755220) < 11)  then
				TPMissing = plrSP.Value
				plrS.Value = 1
				plrA.Value = 1
				plrD.Value = 1
				plrSP.Value = plrL.Value * 3
			elseif TPMissing  > 0 then
				plrSP.Value = plrSP.Value + TPMissing
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
					PermBanStore:SetAsync(plr.UserId, false)
					PlayerStore:SetAsync(plr.UserId, PlayerInfo)
				end
			end)
			local Loaded = Instance.new("NumberValue",plrF)
			Loaded.Name = "Loaded"
		end
	end)
end

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
else
	game:GetService("Players").PlayerRemoving:Connect(function(plr)
		if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(plr.Name) then
			local plrF = PlayerData:FindFirstChild(plr.Name)
			if plrF:FindFirstChild("Loaded") then
				local plrQ = plrF.Quirk
				local plrL = plrF.Level
				local plrD = plrF.Durability
				local plrS = plrF.Strength
				local plrA = plrF.Agility
				local plrSP = plrF.StatPoints
				local plrFame = plrF.Fame
				local plrCash = plrF.Cash
				local plrEXP = plrF.Experience
				local plrArenaWins = plrF.ArenaWins
				local plrEasterEgg = plrF.EasterEgg
				local success =	pcall(function()
					PlayerDataStore:SetAsync(plr.UserId, 
					{["Level"] = plrL.Value, ["Quirk"] = plrQ.Value, ["Cash"] = plrCash.Value, 
					["StatPoints"] = plrSP.Value, ["Strength"] = plrS.Value, ["Durability"] = plrD.Value, 
					["Agility"] = plrA.Value, ["Experience"] = plrEXP.Value, ["Fame"] = plrFame.Value})
					EasterEggStore:SetAsync(plr.UserId, plrEasterEgg.Value)
					ArenaDataStore:SetAsync(plr.UserId, plrArenaWins.Value)
					OrderedFameStore:SetAsync(plr.UserId, plrFame.Value)
				end)
				if success then
					plrF:Destroy()
					plrF = nil
				else
					plrF:Destroy()
					plrF = nil
				end
			else
				plrF:Destroy()
			end
		end
	end)
end

game.ReplicatedStorage.Remotes.Save.ManualSave.OnServerEvent:Connect(function(plr)
	if game.Players:FindFirstChild(plr.Name) and PlayerData:FindFirstChild(plr.Name) then
		local plrF = PlayerData:FindFirstChild(plr.Name)
		if plrF:FindFirstChild("Loaded") then
			local plrQ = plrF.Quirk
			local plrL = plrF.Level
			local plrD = plrF.Durability
			local plrS = plrF.Strength
			local plrA = plrF.Agility
			local plrSP = plrF.StatPoints
			local plrFame = plrF.Fame
			local plrCash = plrF.Cash
			local plrEXP = plrF.Experience
			local plrArenaWins = plrF.ArenaWins
			local plrEasterEgg = plrF.EasterEgg
			local success =	pcall(function()
					PlayerDataStore:SetAsync(plr.UserId, 
					{["Level"] = plrL.Value, ["Quirk"] = plrQ.Value, ["Cash"] = plrCash.Value, 
					["StatPoints"] = plrSP.Value, ["Strength"] = plrS.Value, ["Durability"] = plrD.Value, 
					["Agility"] = plrA.Value, ["Experience"] = plrEXP.Value, ["Fame"] = plrFame.Value})
					EasterEggStore:SetAsync(plr.UserId, plrEasterEgg.Value)
					ArenaDataStore:SetAsync(plr.UserId, plrArenaWins.Value)
					OrderedFameStore:SetAsync(plr.UserId, plrFame.Value)
			end)
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
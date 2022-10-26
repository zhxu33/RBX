local BV = ""
if game.PlaceId == 7775211226 then
	BV = game:GetService("ServerScriptService").BetaScript:GetAttribute("BV")
end

local FameTitle = game.ReplicatedStorage.FameTitle
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData
local HeroTitles = require(game.ReplicatedStorage.Modules.Fame.HeroTitles)
local VillainTitles = require(game.ReplicatedStorage.Modules.Fame.VillainTitles)
local DataStore = game:GetService("DataStoreService")
local MarketPlaceService = game:GetService("MarketplaceService")
local FameTitleStore = DataStore:GetDataStore("FameTitle"..BV)
local CustomTitleStore = DataStore:GetDataStore("CustomTitle"..BV)
local CustomTitlePassId = 20555542
local HttpService = game:GetService("HttpService")
local DiscordUrl = "https://discord.com/api/webhooks/869410166662131772/9bLeY5E1YEpnytQThrKWdPybjBm6KffPC5iKxyU8AuhAz2aPpOganuJNj7j5ZA5dpSa5"
local WhiteList = "https://api.trello.com/1/lists/610204242371550edc7fc94c/cards?key=12bf6363d1cf00d0553955aae5b0226c&token=5a5e82a3ab1881c10326ea98f59e9378b3dc81a6c810fc0bdeafb9391d1727e4"
local BlackList = "https://api.trello.com/1/lists/6102042979aaf449ea0afa42/cards?key=12bf6363d1cf00d0553955aae5b0226c&token=5a5e82a3ab1881c10326ea98f59e9378b3dc81a6c810fc0bdeafb9391d1727e4"
local CooldownTime = 86400

local RequestedWhiteList 
local RequestedBlackList

coroutine.wrap(function()
	local success = pcall(function()
		RequestedWhiteList = HttpService:JSONDecode(HttpService:GetAsync(WhiteList))
		RequestedBlackList = HttpService:JSONDecode(HttpService:GetAsync(BlackList))
	end)
	if not success then
		repeat wait(60)
			success = pcall(function()
				RequestedWhiteList = HttpService:JSONDecode(HttpService:GetAsync(WhiteList))
				RequestedBlackList = HttpService:JSONDecode(HttpService:GetAsync(BlackList))
			end)	
		until success
	end
	while wait(math.random(3600, 5000)) do
		local success = pcall(function()
			RequestedWhiteList = HttpService:JSONDecode(HttpService:GetAsync(WhiteList))
			RequestedBlackList = HttpService:JSONDecode(HttpService:GetAsync(BlackList))
		end)
		if not success then
			repeat wait(60)
				success = pcall(function()
					RequestedWhiteList = HttpService:JSONDecode(HttpService:GetAsync(WhiteList))
					RequestedBlackList = HttpService:JSONDecode(HttpService:GetAsync(BlackList))
				end)	
			until success
		end
		for i,player in pairs(game.Players:GetChildren()) do
			if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, CustomTitlePassId) then
				local FameTitleVal = player:FindFirstChild("FameTitle")
				local CustomTitleInfo = CustomTitleStore:GetAsync(player.UserId)
				if CustomTitleInfo["Title"] ~= "" then
					local Approved = false
					for i,card in pairs(RequestedWhiteList) do
						if string.lower(card.name)== string.lower(CustomTitleInfo["Title"]) then
							Approved = true
							break
						end
					end
					if Approved == true then
						FameTitleVal.Value = CustomTitleInfo["Title"]
						CustomTitleInfo["Title"] = ""
						CustomTitleStore:SetAsync(player.UserId, CustomTitleInfo)
					else
						FameTitle:FireClient(player, "Title Requested: "..CustomTitleInfo["Title"], "Yes")
					end
				end
			end
		end
	end
end)()

FameTitle.OnServerEvent:Connect(function(player, typ, title)
	if player:FindFirstChild("TitleCD") then return end
	local TitleCD = Instance.new("BoolValue",player)
	TitleCD.Name = "TitleCD"
	game.Debris:AddItem(TitleCD, .4)
	local FameTitleVal = player:FindFirstChild("FameTitle")
	local Data = PlayerData:FindFirstChild(player.Name)
	local CustomTitleData = CustomTitleStore:GetAsync(player.UserId)
	local Fame = Data.Fame
	local Changed = false
	local NeededFame = 0
	local msg = ""
	if typ == "Hero" then
		for i=1, #HeroTitles do
			if HeroTitles[i]["Name"] == title then
				NeededFame = HeroTitles[i]["Fame"]
			end
			if HeroTitles[i]["Name"] == title and Fame.Value >= HeroTitles[i]["Fame"] then
				FameTitleVal.Value = title
				Changed = true
				break	
			end
		end
	elseif typ == "Villain" then
		for i=1, #VillainTitles do
			if VillainTitles[i]["Name"] == title then
				NeededFame = VillainTitles[i]["Fame"]
			end
			if VillainTitles[i]["Name"] == title and Fame.Value <= VillainTitles[i]["Fame"] then
				FameTitleVal.Value = title
				Changed = true
				break
			end
		end
	elseif typ == "Custom" and MarketPlaceService:UserOwnsGamePassAsync(player.UserId, CustomTitlePassId) or player:GetRankInGroup(3755220) > 12 then
		local Filtered = game:GetService("TextService"):FilterStringAsync(title, player.UserId):GetNonChatStringForBroadcastAsync()
		local Found = false
		local Canceled = false
		if not string.find(Filtered, "#") and Filtered:match'^%s*(.*%S)' == Filtered and Filtered:match'[%w%s]+' == Filtered and string.len(Filtered) <= 25 and string.len(Filtered) > 3 then
			for i,card in pairs(RequestedBlackList) do
				if string.lower(card.name)== string.lower(Filtered) or string.find(string.lower(Filtered),string.lower(card.name)) then
					Canceled = true
					msg = "Blacklisted!"
					break
				end
			end
			if Canceled == false then
				for i,card in pairs(RequestedWhiteList) do
					if string.lower(card.name)== string.lower(Filtered) then
						Found = true
						break
					end
				end
				if Found == true then
					FameTitleVal.Value = Filtered
					msg = "Title Changed! (Found in whitelist)"
				else 
					if CustomTitleData["TimeRequested"] + CooldownTime > os.time() then
						msg = "24 hour request cooldown!"
					else
						local Success, Err = pcall(function()
							local Data = {["content"] =  player.Name.." requested title ".. Filtered}
							Data = HttpService:JSONEncode(Data)
							HttpService:PostAsync(DiscordUrl, Data)
						end)
						if Success then
							CustomTitleData["Title"] = Filtered
							CustomTitleData["TimeRequested"] = os.time()
							CustomTitleStore:SetAsync(player.UserId, CustomTitleData)
							FameTitle:FireClient(player, "Title Requested: "..CustomTitleData["Title"], "Yes")
							msg = "Title Requested! (Wait up to 24 hours for approval)"
						else
							warn(Err)
							msg = Err
						end
					end
				end
			end
		else
			msg = "Denied!"
		end
	end
	if Changed == true then
		FameTitle:FireClient(player, "Title Changed!", title, true)
	else
		if NeededFame ~= 0 then
			FameTitle:FireClient(player, NeededFame.." fame needed!", title, false) 
		else
			FameTitle:FireClient(player, msg, CustomTitleData["Title"], nil, "not nil") 
		end
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	local FameTitleVal = Instance.new("StringValue", player)
	FameTitleVal.Value = FameTitleStore:GetAsync(player.UserId)  or ""
	FameTitleVal.Name  = "FameTitle"
	if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, CustomTitlePassId) or player:GetRankInGroup(3755220) > 12 then
		local CustomTitleInfo = CustomTitleStore:GetAsync(player.UserId)
		if CustomTitleInfo == nil  then
			CustomTitleInfo = {["Title"] = "", ["TimeRequested"] = os.time()-CooldownTime}
			CustomTitleStore:SetAsync(player.UserId, CustomTitleInfo)
		else
			if CustomTitleInfo["Title"] ~= "" then
				local Approved = false
				for i,card in pairs((RequestedWhiteList or {})) do
					if string.lower(card.name)== string.lower(CustomTitleInfo["Title"]) then
						Approved = true
						break
					end
				end
				if Approved == true then
					FameTitleVal.Value = CustomTitleInfo["Title"]
					CustomTitleInfo["Title"] = ""
					CustomTitleStore:SetAsync(player.UserId, CustomTitleInfo)
				else
					FameTitle:FireClient(player, "Title Requested: "..CustomTitleInfo["Title"], "Yes")
				end
			end
		end
	end
	local Data = PlayerData:WaitForChild(player.Name)
	local Fame = Data.Fame
	Fame.Changed:Connect(function()
		local Amount = 0
		local Type = ""
		local Allowed = false
		if FameTitleVal.Value ~= "" then
			for i=1, #HeroTitles do
				if HeroTitles[i]["Name"] == FameTitleVal.Value then
					Amount = i
					Type = "Hero"
					break
				end
			end
			for i=1, #VillainTitles do
				if VillainTitles[i]["Name"] == FameTitleVal.Value then
					Amount = i
					Type = "Villain"
					break
				end
			end
		end
		if Type ~= "" and Amount ~= 0 then
			if Type == "Villain" and Fame.Value <= VillainTitles[Amount]["Fame"] then
				Allowed = true
			end
			if Type == "Hero" and Fame.Value >= HeroTitles[Amount]["Fame"] then
				Allowed = true
			end
		else
			Allowed = true
		end
		if Allowed == false then
			FameTitleVal.Value = ""
		end
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	local FameTitleVal = player:FindFirstChild("FameTitle")
	if not FameTitleVal then return end
	FameTitleStore:SetAsync(player.UserId, FameTitleVal.Value)
end)
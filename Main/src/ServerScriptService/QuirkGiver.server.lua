local Replicated    = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local PhysService   = game:GetService("PhysicsService")

local QuirkFolder         = ServerStorage.Quirks
local IntroRemote         = Replicated:WaitForChild("Intro")
local QuirkChanged        = Replicated.Remotes:WaitForChild("QuirkChanged")
local PVPRemote           = Replicated:WaitForChild("PVP")
local AutoClickRemote     = Replicated:WaitForChild("AutoClick")
local JoinPlayerRemote    = Replicated:WaitForChild("JoinPlayer")
local LobbyTeleportRemote = Replicated.LobbyRemotes:WaitForChild("Teleport")

local PlayerDataFolder = workspace.S1c2R5i66p5t5s51.PlayerData

-- // Teleport information
local PvpLobby   = if game.GameId == 2787235596 then 7261041817 else 4529243409
local OldMap     = if game.GameId == 2787235596 then 9065586556 else 7189802705
local TestLobby  = if game.GameId == 2787235596 then 7775211226 else 4701435466
local NextUpdate = 7775211226

local Quirks = QuirkFolder:GetChildren()

function SetUpCharacter(character, plr, Quirk)
	local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
	
	pcall(function() -- // Can't be certain
		for _, Descendant in pairs(character:GetDescendants()) do
			if not (Descendant:IsA("BasePart") or Descendant:IsA("UnionOperation")) then continue end
			if Descendant.Anchored then continue end

			PhysService:SetPartCollisionGroup(Descendant,"n")
			Descendant.CanCollide = false
		end
	end)
	
	PVPRemote:FireClient(plr, "Check")
	QuirkFolder.Main:Clone().Parent = character
	local currentQuirk = nil
	for i = 1, #Quirks do
		if Quirks[i]:GetAttribute("Quirk") == Quirk.Value then
			currentQuirk = Quirks[i]
			break
		end
	end
	
	currentQuirk:Clone().Parent = character
	
	QuirkChanged:FireClient(plr)
end

game.Players.PlayerAdded:connect(function(player)
	local PlayerData  = PlayerDataFolder:WaitForChild(player.Name, 30)
	local PartyFolder = Instance.new("Folder",player)
	PartyFolder.Name  = "Party"
	
	local Quirk = PlayerData:WaitForChild("Quirk")
	local Level = PlayerData:WaitForChild("Level")
	
	player.CharacterAdded:connect(function(character)
		SetUpCharacter(character, player, Quirk)
	end)
	if player.Character and Quirk.Value and not player.Character:FindFirstChild((Quirks[Quirk.Value] or "")) then
		SetUpCharacter(player.Character, player, Quirk)
	end
end)

IntroRemote.OnServerEvent:Connect(function(player)
	local PlayerData = PlayerDataFolder:WaitForChild(player.Name)
	
	if PlayerData and not PlayerData:FindFirstChild("Loaded2") then
		local Loaded2 = Instance.new("NumberValue",PlayerData)
		Loaded2.Name  = "Loaded2"
	end
end)

local function ServerType() 
	if game.PrivateServerId ~= "" then 
		if game.PrivateServerOwnerId ~= 0 then 
			return "[VIP Server]"
		else
			return "[Reserved Server]"
		end
	else
		return "**[Public Server]**"
	end
end

local BV = ""
if game.PlaceId == NextUpdate then
	BV = game:GetService("ServerScriptService").BetaScript:GetAttribute("BV")
end

local HttpService = game:GetService("HttpService")
local Url = "https://discordapp.com/api/webhooks/719275868534341642/hxRdI_Trt8o9bJs37OujcFac2CfKwMRjd7vJB6C4wZi_zydPrl7uDoiZChdP_6lsa4mc"
local DataStoreService = game:GetService("DataStoreService")
local AFKWarnings = DataStoreService:GetDataStore("AfkWarnings")
AutoClickRemote.OnServerEvent:Connect(function(player)
	if game.Players:FindFirstChild(player.Name) and not player:FindFirstChild("AFKKicked") then
		local AFKKicked = Instance.new("BoolValue", player)
		AFKKicked.Name = "AFKKicked"
		player:Kick("AFK")
		local PlrAFKWarnings = AFKWarnings:GetAsync(player.UserId) or 0
		AFKWarnings:SetAsync(player.UserId, PlrAFKWarnings + 1)
		-- local Data = {["content"] = player.Name.. " was kicked for AFK. AFK Warnings: ".. PlrAFKWarnings+1}
		--local Data = {["content"] = ServerType() .. " " .. player.Name.. " was kicked for AFK. AFK Warnings: ".. PlrAFKWarnings+1}
		--Data = HttpService:JSONEncode(Data)
		--HttpService:PostAsync(Url, Data)
	end
end)

JoinPlayerRemote.OnServerEvent:Connect(function(player, player2)
	if player.Name ~= player2 and player:IsInGroup(3755220) and player:GetRankInGroup(3755220) >= 11 then
		local Players = game:GetService("Players")
		local Player2Id = Players:GetUserIdFromNameAsync(player2)
		local TeleportService = game:GetService("TeleportService")
		local PlayerData = PlayerDataFolder:FindFirstChild(player.Name)
		local Level = PlayerData:FindFirstChild("Level")
		local success, errorMessage, placeId, jobId = TeleportService:GetPlayerPlaceInstanceAsync(Player2Id)
		if game.JobId == jobId then return end
		if placeId == PvpLobby and Level.Value < 1000 then return end
		if player:GetRankInGroup(3755220) < 7 and placeId == TestLobby then return end
		TeleportService:TeleportToPlaceInstance(placeId,jobId,player)
	end
end)

LobbyTeleportRemote.OnServerEvent:Connect(function(player, ...)
	local TeleportService = game:GetService("TeleportService")
	if not ... then
		local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
		local Level = PlayerData:FindFirstChild("Level")
		if Level.Value < 1000 then return end
		TeleportService:Teleport(PvpLobby, player)
	else
		TeleportService:Teleport(OldMap, player)
	end
end)

local TesterTeleportRemote = Replicated.LobbyRemotes:WaitForChild("TesterTeleport")
TesterTeleportRemote.OnServerEvent:Connect(function(player)
	local PlayerData = PlayerDataFolder:FindFirstChild(player.Name)
	local Level      = PlayerData:FindFirstChild("Level")
	if player:GetRankInGroup(3755220) < 7 or Level.Value < 1000 then return end
	local TeleportService = game:GetService("TeleportService")
	TeleportService:Teleport(TestLobby,player)
end)


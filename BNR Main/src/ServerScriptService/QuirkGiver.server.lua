local QuirkFolder = game.ServerStorage.Quirks
local IntroRemote = game.ReplicatedStorage:WaitForChild("Intro")
local QuirkChanged = game.ReplicatedStorage.Remotes:WaitForChild("QuirkChanged")
local PVPRemote = game.ReplicatedStorage:WaitForChild("PVP")
local AutoClickRemote = game.ReplicatedStorage:WaitForChild("AutoClick")
local JoinPlayerRemote = game.ReplicatedStorage:WaitForChild("JoinPlayer")
local LobbyTeleportRemote = game.ReplicatedStorage.LobbyRemotes:WaitForChild("Teleport")
local PhysService = game:GetService("PhysicsService")
local NpcGroup = PhysService:CreateCollisionGroup("n")
PhysService:CollisionGroupSetCollidable("n","n",false)
game.Players.PlayerAdded:connect(function(player)
	repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(player.Name)
	local PartyFolder = Instance.new("Folder",game.ServerStorage.Parties)
	PartyFolder.Name = player.Name
	local Party1 = Instance.new("StringValue",PartyFolder)
	Party1.Name = "Party1"
	local Party2 = Instance.new("StringValue",PartyFolder)
	Party2.Name = "Party2"
	local Party3 = Instance.new("StringValue",PartyFolder)
	Party3.Name = "Party3"
	local Party4 = Instance.new("StringValue",PartyFolder)
	Party4.Name = "Party4"
	local Quirk = PlayerData:WaitForChild("Quirk")
	local Level = PlayerData:WaitForChild("Level")
	local plr = game.Players:FindFirstChild(player.Name)
	player.CharacterAdded:connect(function(character)
		repeat wait() until character:FindFirstChild("HumanoidRootPart")
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("UnionOperation") then
				if v.Anchored == false then
				PhysService:SetPartCollisionGroup(v,"n")
				v.CanCollide = false
				end
			end
		end
		local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		PVPRemote:FireClient(plr, "Check")
		QuirkChanged:FireClient(plr)
		QuirkFolder.Main:Clone().Parent = character
		if Quirk.Value == 0 then
		QuirkFolder.Quirk0:Clone().Parent = character
		elseif Quirk.Value == 1 then
		QuirkFolder.Quirk1:Clone().Parent = character
		elseif Quirk.Value == 2 then
		QuirkFolder.Quirk2:Clone().Parent = character
		elseif Quirk.Value == 3 then
		QuirkFolder.Quirk3:Clone().Parent = character
		elseif Quirk.Value == 4 then
		QuirkFolder.Quirk4:Clone().Parent = character
		elseif Quirk.Value == 5 then
		QuirkFolder.Quirk5:Clone().Parent = character
		elseif Quirk.Value == 6 then
		QuirkFolder.Quirk6:Clone().Parent = character
		elseif Quirk.Value == 7 then
		QuirkFolder.Quirk7:Clone().Parent = character
		elseif Quirk.Value == 8 then
		QuirkFolder.Quirk8:Clone().Parent = character
		elseif Quirk.Value == 9 then
		QuirkFolder.Quirk9:Clone().Parent = character
		elseif Quirk.Value == 10 then
		QuirkFolder.Quirk10:Clone().Parent = character
		elseif Quirk.Value == 11 then
		QuirkFolder.Quirk11:Clone().Parent = character
		elseif Quirk.Value == 12 then
		QuirkFolder.Quirk12:Clone().Parent = character
		elseif Quirk.Value == 13 then
		QuirkFolder.Quirk13:Clone().Parent = character
		elseif Quirk.Value == 14 then
		QuirkFolder.Quirk14:Clone().Parent = character
		elseif Quirk.Value == 15 then
		QuirkFolder.Quirk15:Clone().Parent = character
		elseif Quirk.Value == 16 then
		QuirkFolder.Quirk16:Clone().Parent = character
		elseif Quirk.Value == 17 then
		QuirkFolder.Quirk17:Clone().Parent = character
		elseif Quirk.Value == 18 then
		QuirkFolder.Quirk18:Clone().Parent = character
		elseif Quirk.Value == 19 then
		QuirkFolder.Quirk19:Clone().Parent = character
		elseif Quirk.Value == 20 then
		QuirkFolder.Quirk20:Clone().Parent = character
		elseif Quirk.Value == 21 then
		QuirkFolder.Quirk21:Clone().Parent = character
		elseif Quirk.Value == 22 then
		QuirkFolder.Quirk22:Clone().Parent = character
		elseif Quirk.Value == 23 then
		QuirkFolder.Quirk23:Clone().Parent = character
		elseif Quirk.Value == 24 then
		QuirkFolder.Quirk24:Clone().Parent = character
		elseif Quirk.Value == 25 then
		QuirkFolder.Quirk25:Clone().Parent = character
		elseif Quirk.Value == 26 then
		QuirkFolder.Quirk26:Clone().Parent = character
		elseif Quirk.Value == 27 then
		QuirkFolder.Quirk27:Clone().Parent = character
		elseif Quirk.Value == 28 then
		QuirkFolder.Quirk28:Clone().Parent = character
		elseif Quirk.Value == 29 then
		QuirkFolder.Quirk29:Clone().Parent = character
		elseif Quirk.Value == 30 then
		QuirkFolder.Quirk30:Clone().Parent = character
		elseif Quirk.Value == 31 then
		QuirkFolder.Quirk31:Clone().Parent = character
		elseif Quirk.Value == 32 then
		QuirkFolder.Quirk32:Clone().Parent = character
		elseif Quirk.Value == 33 then
		QuirkFolder.Quirk33:Clone().Parent = character
		elseif Quirk.Value == 34 then
		QuirkFolder.Quirk34:Clone().Parent = character
		elseif Quirk.Value == 35 then
		QuirkFolder.Quirk35:Clone().Parent = character
		end
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	local Party = game.ServerStorage.Parties:FindFirstChild(player.Name)
	Party:Destroy()
end)
		
IntroRemote.OnServerEvent:Connect(function(player)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	if PlayerData and not PlayerData:FindFirstChild("Loaded2") then
		local Loaded2 = Instance.new("NumberValue",PlayerData)
		Loaded2.Name = "Loaded2"
	end
	wait(1)
	player:LoadCharacter()
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
	local Data = {["content"] = ServerType() .. " " .. player.Name.. " was kicked for AFK. AFK Warnings: ".. PlrAFKWarnings+1}
	Data = HttpService:JSONEncode(Data)
	HttpService:PostAsync(Url, Data)
	end
end)

JoinPlayerRemote.OnServerEvent:Connect(function(player, player2)
	if player.Name ~= player2 and player:IsInGroup(3755220) and player:GetRankInGroup(3755220) >= 11 then
	local Players = game:GetService("Players")
	local Player2Id = Players:GetUserIdFromNameAsync(player2)
	local TeleportService = game:GetService("TeleportService")
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	local Level = PlayerData:FindFirstChild("Level")
	local success, errorMessage, placeId, jobId = TeleportService:GetPlayerPlaceInstanceAsync(Player2Id)
	if game.JobId == jobId then return end
	if placeId == 4529243409 and Level.Value < 1000 then return end
	if player:GetRankInGroup(3755220) < 7 and placeId == 4701435466 then return end
    TeleportService:TeleportToPlaceInstance(placeId,jobId,player)
	end
end)

LobbyTeleportRemote.OnServerEvent:Connect(function(player)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	local Level = PlayerData:FindFirstChild("Level")
	if Level.Value < 1000 then return end
	local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(4529243409,player)
end)

local TesterTeleportRemote = game.ReplicatedStorage.LobbyRemotes:WaitForChild("TesterTeleport")
TesterTeleportRemote.OnServerEvent:Connect(function(player)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	local Level = PlayerData:FindFirstChild("Level")
	if player:GetRankInGroup(3755220) < 7 or Level.Value < 1000 then return end
	local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(4701435466,player)
end)


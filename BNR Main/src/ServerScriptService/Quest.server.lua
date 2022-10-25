local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local CancelQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CancelQuest")
local ProgressQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("ProgressQuest")
local Player = game:GetService("Players")
local DataStore = game:GetService("DataStoreService")
local QuestStore = DataStore:GetDataStore("Quest")

game.Players.PlayerAdded:Connect(function(player)
	local QuestFolder = Instance.new("Folder",workspace.Quests)
	QuestFolder.Name  = player.Name
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(player.Name)
	local Loaded2 = PlayerData:WaitForChild("Loaded2")
	local PlayerQuestInfo = QuestStore:GetAsync(player.UserId)
	if PlayerQuestInfo ~= nil then
		local QuestObjective = Instance.new("Folder", QuestFolder)
		QuestObjective.Name = PlayerQuestInfo.QuestName
		local amountKilled = Instance.new("NumberValue",QuestObjective)
		amountKilled.Name = "AmountKilled"
		amountKilled.Value = PlayerQuestInfo.AmountKilled
		local amountNeeded = Instance.new("NumberValue",QuestObjective)
		amountNeeded.Name = "AmountNeeded"
		amountNeeded.Value = PlayerQuestInfo.AmountNeeded
		AcceptQuest:FireClient(player, QuestObjective.Name)
		wait(3)
		ProgressQuest:FireClient(player, QuestObjective.Name, tostring(amountKilled.Value))
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local Quest = workspace.Quests:FindFirstChild(player.Name)
	if Quest then
	local QuestObjective = Quest:FindFirstChildOfClass("Folder")
	if QuestObjective then
	local AmountKilled = QuestObjective:FindFirstChild("AmountKilled")
	local AmountNeeded = QuestObjective:FindFirstChild("AmountNeeded")
	if AmountKilled and AmountNeeded then
	QuestStore:SetAsync(player.userId, {["QuestName"] = QuestObjective.Name, ["AmountKilled"] = AmountKilled.Value, ["AmountNeeded"] = AmountNeeded.Value})
	end
	else
	QuestStore:RemoveAsync(player.UserId)
	end
	end
	Quest:Destroy()
end)

AcceptQuest.OnServerEvent:Connect(function(player, quest)
local Quest = require(game.ReplicatedStorage.Modules.Quests:FindFirstChild(quest))
Quest.AcceptQuest(player)
end)

CompleteQuest.OnServerEvent:Connect(function(player, quest)
local Quest = require(game.ReplicatedStorage.Modules.Quests:FindFirstChild(quest))
Quest.CompletedCheck(player)
end)

CancelQuest.OnServerEvent:Connect(function(player)
local plr = game.Players:FindFirstChild(player.Name)
local PlayerQuests = workspace.Quests:FindFirstChild(player.Name)
PlayerQuests:ClearAllChildren()
CancelQuest:FireClient(plr)
end)
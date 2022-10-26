local reward = game.ReplicatedStorage.Remotes.RewardPane

local function onReward(exp, cash)
	local player = game.Players.LocalPlayer
	local pane = require(game.ReplicatedStorage.Modules.Quests.GeneralRewards)
	pane.Reward(player:WaitForChild("PlayerGui").QuestGui, exp, cash)
end
reward.OnClientEvent:Connect(onReward)
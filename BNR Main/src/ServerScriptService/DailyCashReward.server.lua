local LastClaimedStore = game:GetService("DataStoreService"):GetDataStore("LastClaimed")
local DailyCash = game.ReplicatedStorage.DailyCash

function RewardCash(Player)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
	local Cash = PlayerData.Cash
	local Fame = PlayerData.Fame
	local Reward = math.abs(Fame.Value)
	Cash.Value = Cash.Value + Reward
	DailyCash:FireClient(Player, Reward)
end

function NoReward(Player, Seconds)
	local Time = string.format("%02i:%02i:%02i", 24-(Seconds/60^2), 60-(Seconds/60%60), 60-(Seconds%60))
	DailyCash:FireClient(Player, Time, "NoReward")
end

DailyCash.OnServerEvent:Connect(function(Player)
local LastClaimedTime = LastClaimedStore:GetAsync(Player.userId)
if LastClaimedTime ~= nil then
      local Seconds = os.time()-LastClaimedTime
	  local Minutes = Seconds/60
	  local Hours = Minutes/60
      if Hours >= 24 then
	  LastClaimedStore:SetAsync(Player.userId,os.time())
	  RewardCash(Player)
elseif Hours < 24 then
	NoReward(Player, Seconds)
end
    elseif LastClaimedTime == nil then
       LastClaimedStore:SetAsync(Player.userId,os.time())
		RewardCash(Player)
	end
end)
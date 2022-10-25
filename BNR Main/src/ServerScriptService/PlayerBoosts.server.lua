local BadgeService = game:GetService("BadgeService")
local MarketPlaceService = game:GetService("MarketplaceService")
local GamePassService = game:GetService("GamePassService")
local TesterBadgeId = 1765731725
local PaidAccessBadgeId = 2124422268
local QuirkChanceId = 4920124
local DoubleExperienceId = 4934775
local DoubleCashId = 5027000
local DataStore = game:GetService("DataStoreService")
local ShowRewardStore = DataStore:GetDataStore("ShowReward")

game:GetService("Players").PlayerAdded:connect(function(player)
    repeat
        wait()
    until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
    local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
    local ExpMultiplier = PlayerData:WaitForChild("ExpMultiplier")
    local RareMultiplier = PlayerData:WaitForChild("RareMultiplier")
	local CashMultiplier = PlayerData:WaitForChild("CashMultiplier")
    if BadgeService:UserHasBadgeAsync(player.UserId, PaidAccessBadgeId) then
        ExpMultiplier.Value = ExpMultiplier.Value + 1
    end
    if BadgeService:UserHasBadgeAsync(player.UserId, TesterBadgeId) then
        ExpMultiplier.Value = ExpMultiplier.Value + 1
        RareMultiplier.Value = RareMultiplier.Value + 1
    end
    if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, QuirkChanceId) then
        RareMultiplier.Value = RareMultiplier.Value + 1
    end
    if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, DoubleExperienceId) then
        ExpMultiplier.Value = ExpMultiplier.Value + 1
    end
    if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, DoubleCashId) then
        CashMultiplier.Value = CashMultiplier.Value + 1
    end
end)



game:GetService("Players").PlayerAdded:connect(function(player)
    if player.Name == "xlxAuroraxIx" or player.Name == "Il0_oII" or player.Name == "xlxAuroraxlx" then
        repeat
            wait()
        until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
        local Playerdata = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
        local ExpMultiplier =  Playerdata:WaitForChild("ExpMultiplier")
        ExpMultiplier.Value = ExpMultiplier.Value + 6
    elseif player.UserId == 139728316 and ShowRewardStore:GetAsync(player.UserId) == nil then
        local SM = workspace.S1c2R5i66p5t5s51.PlayerData.PlayerDataManager.ServerMessageGui:Clone()
        SM.Enabled = true
        SM.Frame.Message.Text = "You have received 10M cash and 3000 levels. Thank you for your support!"
        SM.Frame.TextLabel.Text = "~ Notification ~"
        SM.Parent = player.PlayerGui
        SM.Frame:TweenPosition(UDim2.new(0.75, 0, 0.8, 0),"Out","Quad",1,false)
        ShowRewardStore:SetAsync(player.UserId,true)
    end
end)
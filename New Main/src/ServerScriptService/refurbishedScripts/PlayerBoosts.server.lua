-- // Beta check
local BV = ""
if game.PlaceId == 7775211226 then
	BV = game:GetService("ServerScriptService").BetaScript:GetAttribute("BV")
end

-- // Services
local BadgeService       = game:GetService("BadgeService")
local MarketPlaceService = game:GetService("MarketplaceService")
local DataStore          = game:GetService("DataStoreService")
local playerService      = game:GetService("Players")

-- // badge & gamepass IDs
local TesterBadgeId      = 1765731725
local PaidAccessBadgeId  = 2124422268
local QuirkChanceId      = 4920124
local DoubleExperienceId = 4934775
local DoubleCashId       = 5027000

-- // variables
local ShowRewardStore = DataStore:GetDataStore("ShowReward"..BV)
local userData        = workspace.S1c2R5i66p5t5s51.PlayerData

-- // functions

local function getUserData(Username)
	local dataFile = userData:FindFirstChild(Username)
	local timeOut  = tick()

	if not dataFile then
		repeat
			task.wait(.1)
			dataFile = userData:FindFirstChild(Username)
		until dataFile or tick() > timeOut + 30
	end

	assert(dataFile, "User's datafile cannot was not found within set duration.")

	return dataFile
end

playerService.PlayerAdded:connect(function(player)
	local PlayerData     = getUserData(player.Name)
    local ExpMultiplier  = PlayerData:WaitForChild("ExpMultiplier")
    local RareMultiplier = PlayerData:WaitForChild("RareMultiplier")
	local CashMultiplier = PlayerData:WaitForChild("CashMultiplier")
	
    if BadgeService:UserHasBadgeAsync(player.UserId, PaidAccessBadgeId) then
		ExpMultiplier.Value += 1
	end
	
    if BadgeService:UserHasBadgeAsync(player.UserId, TesterBadgeId) then
        ExpMultiplier.Value  += 1
        RareMultiplier.Value += 1
	end
	
    if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, QuirkChanceId) then
        RareMultiplier.Value += 1
	end
	
    if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, DoubleExperienceId) then
        ExpMultiplier.Value  += 1
	end
	
    if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, DoubleCashId) then
        CashMultiplier.Value += 1
	end
	
	if player.Name == "xlxAuroraxIx" or player.Name == "Il0_oII" or player.Name == "xlxAuroraxlx" then
		
		local Playerdata    = getUserData(player.Name)
		local ExpMultiplier = Playerdata:WaitForChild("ExpMultiplier")
		ExpMultiplier.Value = ExpMultiplier.Value + 6
	elseif player.UserId == 139728316 and ShowRewardStore:GetAsync(player.UserId) == nil then

		local SM = userData.PlayerDataManager.ServerMessageGui:Clone()
		SM.Enabled = true
		SM.Frame.Message.Text = "You have received 10M cash and 3000 levels. Thank you for your support!"
		SM.Frame.TextLabel.Text = "~ Notification ~"
		SM.Parent = player.PlayerGui
		SM.Frame:TweenPosition(UDim2.new(0.75, 0, 0.8, 0),"Out","Quad",1,false)
		ShowRewardStore:SetAsync(player.UserId,true)
	end
end)
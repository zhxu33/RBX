local banMod = {}

-- // services
local dataStoreService = game:GetService("DataStoreService")

-- // Datastores
local permBan  = dataStoreService:GetDataStore("PermBan")
local banStore = dataStoreService:GetDataStore("Player")

-- // variables
local group          = 3755220
local moderator_rank = 12

-- // getting duration seconds to time
function banMod:duration()
	if not self then return "" end

	local dd = math.floor(self / 60 / 60 / 24)
	local hh = math.floor(self / 60 / 60 - (dd * 24))
	local mm = math.floor(self / 60 - (dd * 24 * 60) - (hh * 60))
	local ss = math.floor(self - ((dd * 24 * 60 * 60) + (hh * 60 * 60) + (mm * 60)))

	return ("Days: %d, Hours: %d, Minutes: %d, Seconds: %d"):format(dd, hh, mm, ss)
end

-- // handles kick message
function banMod:kickUser(info)
	local message = info.PermBan and "You are permanently banned. Reason: " or "You are banned. Reason: "
	message ..= info.Ban.Reason or "No reason provided."
	message ..= info.PermBan and "" or "\nTime left: " .. banMod.duration(info.Ban.Time2 - os.time())
	
	local success, err = pcall(function()
		self:Kick(message)
	end)
	
	if not success then warn(err) end
end

-- // Sets new information to the users data structure
local function getNewInfo()
	return {
		["PermBan"]    = false,
		["Ban"] = {
			["Time2"]  = 0,
			["Reason"] = nil
		}
	}
end

-- // gets the data from old ban store
function banMod:getOldInfo(player, info)
	local success, retVal
	success, retVal = pcall(function()
		return banStore:GetAsync(player.UserId)
	end)
	
	if not success then player:Kick("There was a datastore error, please rejoin.") end
	info.Ban = retVal or getNewInfo().Ban
	
	success, retVal = pcall(function()
		return permBan:GetAsync(player.UserId)
	end)
	
	if not success then player:Kick("There was a datastore error, please rejoin.") end
	info.PermBan = retVal or getNewInfo().PermBan
	
	if info.PermBan == true then info.Ban.Time2 = -1 end
	if info.Ban.Time2 < 0   then info.PermBan = true end
	
	return info
end

-- // checks if the user is allowed to join the game
function banMod:checkInfo(player, info)
	info.isKicked = true

	-- // skips moderations for staff members
	if group and moderator_rank and player:GetRankInGroup(group) >= moderator_rank then info.isKicked = false; return false end
	
	if info.PermBan == nil or info.Ban == nil then
		info = self:getOldInfo(player, info)
		info.isKicked = false
	end
	
	if info.PermBan or info.Ban.Time2 > os.time() then
		self.kickUser(player, info)
		return true
	end
	
	info.isKicked = false
	
	return false
end

return banMod
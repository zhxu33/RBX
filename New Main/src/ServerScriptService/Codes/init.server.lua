local CodeEvent = game.ReplicatedStorage.Remotes.Code
local DataStore = game:GetService("DataStoreService")
-- AllCodes: newu1s, echoeyesonYT5K, 300MVISITS

local CodeCooldown = {}

game.Players.PlayerAdded:Connect(function(plr)
	CodeCooldown[plr] = {
		["Cooldown"] = false,
		["Remaining"] = 0
	}
end)

local function CooldownStart(plr)
	coroutine.wrap(function()
		CodeCooldown[plr]["Cooldown"] = true
		CodeCooldown[plr]["Remaining"] = 10
		repeat
			CodeCooldown[plr]["Remaining"] = CodeCooldown[plr]["Remaining"] - 1
			wait(1)
		until CodeCooldown[plr]["Remaining"] < 1
		CodeCooldown[plr]["Cooldown"] = false
	end)()
end

CodeEvent.OnServerEvent:Connect(function(player,Code)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	
	if not PlayerData then return end
	
	if not CodeCooldown[player]["Cooldown"] then
		
		local plr = game.Players:FindFirstChild(player.Name)
		CooldownStart(player)
		
		local CodeDataStore = DataStore:GetDataStore(Code)
		if CodeDataStore:GetAsync("Code") == true then
			if CodeDataStore:GetAsync(player.UserId) == nil and CodeDataStore:GetAsync("Expired") == nil then
				local Cash = PlayerData:FindFirstChild("Cash")
				local CashReward = CodeDataStore:GetAsync("CashReward")
				CodeDataStore:SetAsync(player.UserId, true)
				Cash.Value = Cash.Value + CashReward
				CodeEvent:FireClient(plr, "Success! Redeemed "..CashReward.." cash.", true)
			elseif CodeDataStore:GetAsync(player.UserId) ~= nil then
				CodeEvent:FireClient(plr,"You have already used this code.", false)
			elseif CodeDataStore:GetAsync("Expired") ~= nil then
				CodeEvent:FireClient(plr,"This code has expired.", false)
			end
		else
			CodeEvent:FireClient(plr,"Invalid!")
		end
		
	else
		
		CodeEvent:FireClient(player,"Too fast! Wait " .. CodeCooldown[player]["Remaining"] .. " seconds.", false)
		
	end
end)

--[[ -- the code for setting ingame codes.
local nameCode = "NAME"
local giveCash = CASHAMOUNT

local DS = game:GetService("DataStoreService")

DS:GetDataStore(nameCode):SetAsync("Code", true)
DS:GetDataStore(nameCode):SetAsync("CashReward", giveCash)

or place these in the commandbar 

game:GetService("DataStoreService"):GetDataStore(nameCode):SetAsync("Code", true)
game:GetService("DataStoreService"):GetDataStore(nameCode):SetAsync("CashReward", giveCash)

--Example: game:GetService("DataStoreService"):GetDataStore("SUB2ITSBEAR"):SetAsync("Code", true); game:GetService("DataStoreService"):GetDataStore("SUB2ITSBEAR"):SetAsync("CashReward", 75000)
]]
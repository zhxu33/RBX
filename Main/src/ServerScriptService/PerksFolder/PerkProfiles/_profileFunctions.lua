-- // Services
local Replicated    = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")

-- // Variables
local PlayerData = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData")

local RaidInfo   = Replicated:FindFirstChild("RaidInfo")
local PerkUpdate = RaidInfo and RaidInfo:FindFirstChild("PerkUpdate")

local methods   = {}
methods.__index = methods
methods.__newindex = function(self, index, value)
	rawset(self, index, value)
end

------------------------------------------[RUNNING PERK FUNCTIONS]------------------------------------------

-- // Running all Respawn functions
function methods:FireRespawnFunctions(...)
	for funcId, funcInfo in pairs(self.RespawnFunctions) do
		local success, err = pcall(funcInfo[1], funcInfo[2], self, ...)
		if not success then warn(("%s has errored with: \n%s"):format(funcId, err)); continue end
	end

	return self
end

-- // Running all Damage functions
function methods:FireDamageFunctions(Damage, ...)
	for funcId, funcInfo in pairs(self.DamageFunctions) do
		local prevDamage = Damage

		local success, retVal = pcall(funcInfo[1], funcInfo[2], self, Damage, ...)
		if not success then warn(("%s has errored with: \n%s"):format(funcId, retVal)); continue end

		-- // Must be successful
		if (success and type(retVal) == "number") then Damage = retVal end
	end

	return Damage
end

-- // Running all Reward functions
function methods:FireRewardFunctions(Reward, ...)
	for funcId, funcInfo in pairs(self.OnRewardFunctions) do
		local prevReward = Reward

		local success, retVal = pcall(funcInfo[1], funcInfo[2], self, Reward, ...)
		if not success then warn(("%s has errored with: \n%s"):format(funcId, retVal)); continue end

		-- // Must be successful
		if (success and type(retVal) == "table") then Reward = retVal end
	end

	return Reward
end

-- // Running all On death functions
function methods:FireDeathFunctions(...)
	for funcId, funcInfo in pairs(self.OnDeathFunctions) do
		local success, err = pcall(funcInfo[1], funcInfo[2], self, ...)
		if not success then warn(("%s has errored with: \n%s"):format(funcId, err)); continue end
	end

	return self
end

-- // Running all On kill functions
function methods:FireKillFunctions(...)
	for funcId, funcInfo in pairs(self.OnKillFunctions) do
		local success, err = pcall(funcInfo[1], funcInfo[2], self, ...)
		if not success then warn(("%s has errored with: \n%s"):format(funcId, err)); continue end
	end

	return self
end

-- // Running all On hit functions
function methods:FireHitFunctions(Damage, ...)
	for funcId, funcInfo in pairs(self.OnHitFunctions) do
		local prevDamage = Damage
		
		local success, retVal = pcall(funcInfo[1], funcInfo[2], self, Damage, ...)
		if not success then warn(("%s has errored with: \n%s"):format(funcId, retVal)); continue end
		
		-- // Must be successful
		if (success and type(retVal) == "number") then Damage = retVal end
	end
	
	return Damage
end

------------------------------------------[ADDING PERK FUNCTIONS TO CATEGORIES]------------------------------------------
local function ReformingName(s1, s2) -- // String one & string 2; combinds them for a proper directory name
	return ("%s_%s"):format(s1 or "", s2 or ""):lower()
end

------------------------------------------[ADDING PERK FUNCTIONS TO CATEGORIES]------------------------------------------

-- // Inserting Respawn function
function methods:InsertRespawnFunction(perkName:string, funcName:string, func:("function"))
	local Name = ReformingName(perkName, funcName)
	self.RespawnFunctions[Name] = func

	return self
end

-- // Inserting Damage function
function methods:InsertDamageFunction(perkName:string, funcName:string, func:("function"))
	local Name = ReformingName(perkName, funcName)
	self.DamageFunctions[Name] = func

	return self
end

-- // Inserting On death function
function methods:InsertDeathFunction(perkName:string, funcName:string, func:("function"))
	local Name = ReformingName(perkName, funcName)
	self.OnDeathFunctions[Name] = func

	return self
end

-- // Inserting On kill function
function methods:InsertKillFunction(perkName:string, funcName:string, func:("function"))
	local Name = ReformingName(perkName, funcName)
	self.OnKillFunctions[Name] = func

	return self
end

-- // Inserting On hit function
function methods:InsertHitFunction(perkName:string, funcName:string, func:("function"))
	local Name = ReformingName(perkName, funcName)
	self.OnHitFunctions[Name] = func

	return self
end

------------------------------------------[REMOVING PERK FUNCTIONS]------------------------------------------

-- // Removing Respawn function
function methods:RemoveRespawnFunction(perkName:string, funcName:string)
	local Name = ReformingName(perkName, funcName)
	self.RespawnFunctions[Name] = nil

	return self
end

-- // Removing Damage function
function methods:RemoveDamageFunction(perkName:string, funcName:string)
	local Name = ReformingName(perkName, funcName)
	self.DamageFunctions[Name] = nil

	return self
end

-- // Removing On death function
function methods:RemoveDeathFunction(perkName:string, funcName:string)
	local Name = ReformingName(perkName, funcName)
	self.OnDeathFunctions[Name] = nil

	return self
end

-- // Removing On kill function
function methods:RemoveKillFunction(perkName:string, funcName:string)
	local Name = ReformingName(perkName, funcName)
	self.OnKillFunctions[Name] = nil

	return self
end

-- // Removing On hit function
function methods:RemoveHitFunction(perkName:string, funcName:string)
	local Name = ReformingName(perkName, funcName)
	self.OnHitFunctions[Name] = nil
	
	return self
end

------------------------------------------[EXTRA FUNCTIONS]------------------------------------------

-- // Tells client that their 'perk' has been updated | Perk, MaxPerksUpd, Remove
local function UpdatePerk(Player, ...)
	if not PerkUpdate then return end -- // Perk update function doesn't exist
	
	local isPlayer = PlayerService:FindFirstChild(Player.Name)
	if not isPlayer then return end -- // Not a real player
	
	PerkUpdate:FireClient(isPlayer, ...)
end

-- // Empty function on purpose
local function EmptyFunc(...) end

-- // Returns true if player has the perk
function methods:HasPerk(perk : "string" | {Name : "string"})
	local perkName = (typeof(perk) == "string" and perk) or (typeof(perk) == "table" and perk.Name)
	if not perkName then warn("Perk name not found or not given within arguments."); return end
	
	return self.Perks[perkName]
end

-- // Returns if they player can obtain the perk
function methods:CanObtain(perk)
	local DataFolder = PlayerData:FindFirstChild(self.Player.Name)
	if not DataFolder then return false, "Error!" end
	
	-- // Player already has perk
	if self:HasPerk(perk.Name) then return false, "Perk Owned" end
	
	-- // If a player has max perks
	if self.PerkLimit <= self.PerksHeld then return false, "Perk Limit Reached" end
	
	-- // If the perk is blacklisted
	if table.find(self.BlacklistedPerks, ReformingName(perk.Name, perk.Category)) then return false, "Perk Blacklisted" end
	
	-- // Fame specific perks
	if perk.HeroPerk    and DataFolder.Fame.Value <= 0 then return false, "Hero Only"    end
	if perk.VillainPerk and DataFolder.Fame.Value >= 0 then return false, "Villain Only" end
	
	return true
end

-- // Adds a perk to the profile
function methods:AddPerk(Perk)
	if not Perk then warn("Perk not provided or nil."); return self end
	
	Perk = self:DeepCopy(Perk)
	self.Perks[Perk.Name] = Perk
	
	local function InsertPerksFunctions(Category)
		if not Perk[Category] then return end -- // If category e.i. OnHitFunctions does not exist then it won't error
		for funcName, func in pairs(Perk[Category]) do
			local Name           = ReformingName(Perk.Name, funcName)
			self[Category][Name] = {func, Perk}
		end
	end

	InsertPerksFunctions("RespawnFunctions")
	InsertPerksFunctions("DamageFunctions")
	InsertPerksFunctions("OnDeathFunctions")
	InsertPerksFunctions("OnKillFunctions")
	InsertPerksFunctions("OnHitFunctions")
	InsertPerksFunctions("OnRewardFunctions")
	Perk.PerkInitiation = (Perk.PerkInitiation or EmptyFunc)
	Perk:PerkInitiation(self, self.Player)
	
	self.PerksHeld += 1
	
	local updateInfo        = {}
	updateInfo.Remove       = false
	updateInfo.PerkLimit    = self.PerkLimit
	updateInfo.PerkToUpdate = self:GetClientInfo(Perk)
	UpdatePerk(self.Player, updateInfo)
	self:ShowMessage(Perk, "Obtained %s.")

	return self
end

-- // Blacklists a perk from the player
function methods:BlacklistPerk(perk : {Name : "string", Category : "string"})
	if not perk then return self end
	table.insert(self.BlacklistedPerks, ReformingName(perk.Name, perk.Category))
	
	return self
end

-- // Removes a perk from the profile
function methods:RemovePerk(perk)
	if not perk then warn("Perk not provided or nil."); return self end
	
	self:ShowMessage(perk, "%s Removed.", ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))}))
	local Perk            = self.Perks[perk.Name]
	self.Perks[perk.Name] = nil
	
	local updateInfo        = {}
	updateInfo.Remove       = true
	updateInfo.PerkLimit    = self.PerkLimit
	updateInfo.PerkToUpdate = self:GetClientInfo(perk)
	UpdatePerk(self.Player, updateInfo)
	
	local function RemovePerksFunctions(Category)
		if not Perk[Category] then return end -- // If category e.i. OnHitFunctions does not exist then it won't error
		for funcName, _ in pairs(Perk[Category]) do
			local Name           = ReformingName(perk.Name, funcName)
			--self:DisposeInfo(self[Category][Name]) -- // Can't dispose using this function (It will dispose of the perk before removing all other functions)
			table.clear(self[Category][Name])
			self[Category][Name] = nil
		end
	end
	
	RemovePerksFunctions("RespawnFunctions")
	RemovePerksFunctions("DamageFunctions")
	RemovePerksFunctions("OnDeathFunctions")
	RemovePerksFunctions("OnKillFunctions")
	RemovePerksFunctions("OnHitFunctions")
	RemovePerksFunctions("OnRewardFunctions")
	
	Perk.Deactivate = (Perk.Deactivate or EmptyFunc)
	Perk:Deactivate(self, self.Player)
	self:DisposeInfo(Perk)
	
	self.PerksHeld -= 1
	
	return self
end

return methods
--[[

	 StunInfo.Link(Character) - Links the NPC/Player to be prone to stuns produced from this module.
	 
	 StunInfo:Knockback(Table) - Produces the stun with the specified parameters.
	 
	 StunInfo:Freeze(Table) - Produces the freeze with the specified parameters.
 		
]]

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
local PlayerData = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData")
local StunConditions = require(script.StunConditions)

StunModule2 = {}

local LogMode = false

function StunModule2.LogMode()
	LogMode = not LogMode
end

local Stun_Linked_Characters = {}
local StunnedPlayers = {}
local CharacterConnection = {}

local CachedInstance_Folder = script.CachedInstances
local CachedInstances = {
	["Freeze"] = {},
	["Stun"] = {}
}

local KnockbackDefault = {

	["StunType"] 			= "Heavy",									-- Stun Types (Light = No knockback but NPC's can target you, Heavy - Knockback)
	["KnockbackType"]		= "From_Character",							-- Knockback Types (From_Character, Lift, Directional_Lift, From_Impact, Pull, Left, Right)
	["HitCharacter"]		= nil,										-- The person being stunned (Must be the character)
	["Stunner"]				= nil,										-- The person applying the stun (Must be the character)
	["ImpactPosition"]		= nil,										-- The position from which From_Impact will knock the target away from.
	["Duration"]			= Information.DefaultStunTime,				-- The duration of the stun
	["Force"]				= Information.DefaultKnockbackForce,		-- The force of the stun
	["Overwrite"]			= false										-- Decides whether or not it'll delete an existing stun and replace with it's own.

}

local FreezeDefault = {

	["FreezeType"] 			= nil,										-- Types of Freezes (Freeze, Sleep, Shock)
	["HitCharacter"]		= nil,										-- The person being frozen (Must be the character)
	["Freezer"]				= nil,										-- The person applying the freeze (Must be the character)
	["Duration"]			= Information.DefaultFreezeTime,			-- The duration of the freeze
	["FreezeImmunity"]		= Information.DefaultFreezeImmunityTime		-- The amount of time before the same target can be frozen again.

}

function RetrieveInstance(Type)
	local Item
	if not CachedInstances[Type] then return end

	for index, inst in pairs(CachedInstances[Type]) do
		Item = inst
		CachedInstances[Type][index] = nil
		break
	end

	if not Item then

		Item = Instance.new("BodyVelocity")
		Item.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

		if Type == "Stun" then
			Item.Name = "HeavyStun"
			Item:SetAttribute("Stun", true)
			Item:SetAttribute("Stun_Type", "Heavy")
		else
			Item.Name = "FreezeStun"
			Item:SetAttribute("Freeze", true)
			Item:SetAttribute("Stun_Type", "Freeze")
			Item.Velocity = Vector3.zero
		end
	end

	return Item
end

function CacheInstance(Type, Object)
	-- // Check if the parent exists (Otherwise object was deleted and locked by roblox)
	-- // If the type is a part of the cached instances table
	if not (CachedInstances[Type] and Object.Parent) then return end
	
	Object.Parent = CachedInstance_Folder
	CachedInstances[Type][#CachedInstances[Type]+1] = Object
end

function Link_Character(Character)

	if table.find(Stun_Linked_Characters, Character) then return end

	local HRT = Character.HumanoidRootPart or Character:WaitForChild("HumanoidRootPart")
	local HUM = Character.Humanoid or Character:WaitForChild("Humanoid")

	local StunAnims = Instance.new("Folder", Character)
	StunAnims.Name = "StunAnims"

	local HS = script.StunAssets.HeavyAnimation:Clone()
	HS.Parent = StunAnims
	local SS = script.StunAssets.SleepAnimation:Clone()
	SS.Parent = StunAnims
	local ES = script.StunAssets.ElectrifiedAnimation:Clone()
	ES.Parent = StunAnims

	local HeavyStun = HUM:LoadAnimation(HS)
	local SleepStun = HUM:LoadAnimation(SS)
	local ElectricStun = HUM:LoadAnimation(ES)

	local CleanUp = HRT.ChildAdded:Connect(function(child)

		if not (child:GetAttribute("Stun") or child:GetAttribute("Freeze")) then return end
		if child:GetAttribute("Stun_Type") == "Heavy" then
			StunEffect({
				StunInstance = child,
				StunAnimation = HeavyStun,
				StunTime = child:GetAttribute("Stun_Duration") or Information.DefaultStunTime,
				Humanoid = HUM,
				Character = Character
			})
		elseif child:GetAttribute("Stun_Type") == "Freeze" then
			FreezeEffect({
				Type = child:GetAttribute("Freeze_Type"),
				FreezeInstance = child,
				FreezeAnimation = {SleepStun, ElectricStun},
				FreezeTime = child:GetAttribute("Stun_Duration") or Information.DefaultFreezeTime,
				Humanoid = HUM,
				Character = Character,
				FreezeImmunity = child:GetAttribute("Custom_Freeze_Immunity") or Information.DefaultFreezeImmunityTime
			})
		end
	end)

	table.insert(Stun_Linked_Characters, Character)
	task.spawn(function()
		Character.AncestryChanged:Wait()
		table.remove(Stun_Linked_Characters, table.find(Stun_Linked_Characters, Character))
		CleanUp:Disconnect()	
		if StunAnims then
			StunAnims:Destroy()
		end
	end)
end

function StunEffect(ST)

	if not ST.StunAnimation.IsPlaying then
		ST.StunAnimation:Play()
	end

	if not ST.Character:GetAttribute("Blocking") then
		if ST.StunTime > .5 then
			coroutine.wrap(function()
				task.wait(.5)
				ST.StunAnimation:AdjustSpeed(0)
			end)()
		end
	end
	ST.Humanoid.AutoRotate = false

	repeat
		game:GetService("RunService").Heartbeat:Wait()
	until not StunnedPlayers[ST.Character]

	ST.StunAnimation:AdjustSpeed(1)
	ST.Humanoid.AutoRotate = true
	ST.StunAnimation:Stop()

end

function FreezeEffect(FT)

	local AnimationPick = {
		Sleep = 1,
		Shock = 2
	}

	local AnimVersion = AnimationPick[FT.Type]

	if AnimVersion then
		FT.FreezeAnimation[AnimVersion]:Play()
		coroutine.wrap(function()
			if FT.FreezeTime > 1.2 then
				task.wait(1.2)
				FT.FreezeAnimation[AnimVersion]:AdjustSpeed(0)
			end
		end)()
	end
	FT.Humanoid.AutoRotate = false

	task.wait(FT.FreezeTime)

	FT.Humanoid.AutoRotate = true
	if AnimVersion then
		FT.FreezeAnimation[AnimVersion]:AdjustSpeed(1)
		FT.FreezeAnimation[AnimVersion].TimePosition = FT.FreezeAnimation[AnimVersion].Length - 1.2
	end

end

function StunModule2:Link()
	Link_Character(self)
end

local activeThreads = {}
function StunModule2:Knockback()

	if not self then return end
	if not self["HitCharacter"] or not self["Stunner"] then return end
	if self["HitCharacter"] == self["Stunner"] then return end
	if not (self["HitCharacter"]:GetAttribute("Player") or self["HitCharacter"]:GetAttribute("NPC")) then return end
	if not self.Stunner.PrimaryPart or not self.HitCharacter.PrimaryPart then return end
	
	for _, thread in pairs(activeThreads) do
		if not (thread and coroutine.status(thread) == "suspended") then continue end
		task.spawn(thread)
	end
	
	Link_Character(self["HitCharacter"])

	--local KT = KnockbackDefault
	--for v,p in pairs(self) do
	--	KT[v] = p
	--end
	
	local function deepCopy(Tab)
		local new = {}
		
		for index, child in pairs(Tab) do
			if type(child) == "table" then
				new[index] = deepCopy(child)
			else
				new[index] = child
			end
		end
		
		return new
	end
	local KT = deepCopy(KnockbackDefault)
	
	for v,p in pairs(self) do
		KT[v] = p
	end
	
	local StunFeedback = StunConditions.CanBeStunned(KT, LogMode)

	local V3 = nil

	if KT.KnockbackType == "From_Character" then

		V3 = CFrame.lookAt(KT.Stunner.PrimaryPart.Position, KT.HitCharacter.PrimaryPart.Position).LookVector * KT.Force

	elseif KT.KnockbackType == "Lift" then

		V3 = KT.HitCharacter.HumanoidRootPart.CFrame.upVector * KT.Force

	elseif KT.KnockbackType == "Directional_Lift" then

		V3 = (CFrame.lookAt(KT.Stunner.PrimaryPart.Position, KT.HitCharacter.PrimaryPart.Position).LookVector*KT.Force) + Vector3.new(0, KT.Force, 0)

	elseif KT.KnockbackType == "From_Impact" then

		V3 = CFrame.lookAt(KT.ImpactPosition, KT.HitCharacter.PrimaryPart.Position).LookVector * KT.Force

	elseif KT.KnockbackType == "Inverse" or KT.KnockbackType == "Pull" then -- Cursed Chains // or if other future related things need it (Jeffy note: you could just do "From_Character" with a negative force)
		V3 = CFrame.lookAt(KT.HitCharacter.PrimaryPart.Position, KT.Stunner.PrimaryPart.Position).LookVector * KT.Force

	elseif KT.KnockbackType == "Left" then

		V3 = KT.Stunner.HumanoidRootPart.CFrame.RightVector * -KT.Force -- LeftVector doesn't exist apparently...

	elseif KT.KnockbackType == "Right" then

		V3 = KT.Stunner.HumanoidRootPart.CFrame.RightVector * KT.Force

	end
		
	local Character = KT.HitCharacter 
	if KT.Overwrite and StunnedPlayers[Character] then
		StunnedPlayers[Character].Velocity = V3 or Vector3.zero
		StunnedPlayers[Character]:SetAttribute("Stun_Duration", StunFeedback[2])
		return end
	
	
	if StunFeedback[1] then return end

	if KT.StunType == "Light" then
		if KT.HitCharacter:GetAttribute("NPC") then
			local PLR = game.Players:GetPlayerFromCharacter(KT.Stunner)
			if PLR then
				KT.HitCharacter:SetAttribute("Target", PLR.UserId)
			end
		end
		return end

	local Heavy = RetrieveInstance("Stun")
	Heavy.Velocity = V3 or Vector3.zero
	Heavy:SetAttribute("Stun_Duration", StunFeedback[2])

	StunnedPlayers[Character] = Heavy
	Heavy.Parent = Character.PrimaryPart
	
	local threadNew
	threadNew = task.spawn(function()
		KT.HitCharacter:SetAttribute("Stunned", true)
		while task.wait(1/60) and Heavy and (Heavy:GetAttribute("Stun_Duration") or 0) > 1/60 do
			Heavy:SetAttribute("Stun_Duration", Heavy:GetAttribute("Stun_Duration")-(1/60))
		end		
		if Character then
			Character:SetAttribute("Stunned", false)
		end
		
		StunnedPlayers[KT.HitCharacter] = nil
		if Heavy and Heavy.Parent then
			CacheInstance("Stun", Heavy)
		end
		table.remove(activeThreads, table.find(activeThreads, threadNew))
	end)
	table.insert(activeThreads, threadNew)
end

function StunModule2:Freeze()

	if not self then return end
	if not self["HitCharacter"] or not self["Freezer"] then return end
	if self["HitCharacter"] == self["Freezer"] then return end

	Link_Character(self["HitCharacter"])

	--local FT = FreezeDefault
	--for v,p in pairs(self) do
	--	FT[v] = p
	--end
	
	local function deepCopy(Tab)
		local new = {}

		for index, child in pairs(Tab) do
			if type(child) == "table" then
				new[index] = deepCopy(child)
			else
				new[index] = child
			end
		end

		return new
	end
	local FT = deepCopy(FreezeDefault)

	for v,p in pairs(self) do
		FT[v] = p
	end

	local StunFeedback = StunConditions.CanBeFrozen(FT, LogMode)

	if StunFeedback[1] then return end

	if FT.HitCharacter:GetAttribute("NPC") then
		local PLR = game.Players:GetPlayerFromCharacter(FT.Stunner)
		if PLR then
			FT.HitCharacter:SetAttribute("Target", PLR.UserId)
		end
	end

	local FreezeBV = RetrieveInstance("Freeze")
	FreezeBV:SetAttribute("Freeze_Type", FT.FreezeType)
	FreezeBV:SetAttribute("Stun_Duration", StunFeedback[2])
	FreezeBV:SetAttribute("Custom_Freeze_Immunity", FT.FreezeImmunity)
	FreezeBV.Parent = FT.HitCharacter.PrimaryPart

	FT.HitCharacter:SetAttribute("Frozen", true)
	FT.HitCharacter:SetAttribute("FreezeImmunity", FT.FreezeImmunity)

	local Assets = {}

	if FT.FreezeType == "Freeze" then

		Assets[1] = script.StunAssets.FreezeTypes.Frozen:Clone()
		Assets[1].Weld.Part1 = FT.HitCharacter.HumanoidRootPart
		Assets[1].Parent = FT.HitCharacter.HumanoidRootPart

	elseif FT.FreezeType == "Sleep" then

		Assets[1] = script.StunAssets.FreezeTypes.SomnaMode:Clone()
		Assets[1].Parent = FT.HitCharacter.Head

	elseif FT.FreezeType == "Shock" then

		local Count = 1
		for v,p in pairs(FT.HitCharacter:GetChildren()) do
			if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
				Assets[Count] = script.StunAssets.FreezeTypes.Shocked:Clone()
				Assets[Count].Parent = p
				Count += 1
			end
		end

	end

	task.wait(StunFeedback[2])

	for i=1,#Assets do
		Assets[i]:Destroy()
	end

	CacheInstance("Freeze", FreezeBV)
	FT.HitCharacter:SetAttribute("Frozen", false)

	repeat
		task.wait(1)
		FT.HitCharacter:SetAttribute("FreezeImmunity", FT.HitCharacter:GetAttribute("FreezeImmunity")-1)
	until FT.HitCharacter:GetAttribute("FreezeImmunity") <= 0

end

return StunModule2
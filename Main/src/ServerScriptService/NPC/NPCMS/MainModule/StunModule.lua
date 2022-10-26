StunCondition = {}

--[[

	 StunInfo.Link(Character) - Links the NPC/Player to be prone to stuns produced from this module.
	 
	 StunInfo:Knockback(Table) - Produces the stun with the specified parameters.
	 
	 StunInfo:Freeze(Table) - Produces the freeze with the specified parameters.
 		
]]

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")

local Stun_Linked_Characters = {}
local LogMode = false

local function Print(text)
	if LogMode then
		print(text)
	end
end

local function Warning(text)
	if LogMode then
		warn(text)
	end
end

function StunCondition:LogMode()
	LogMode = not LogMode
end

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

local AnimationPick = {
	Sleep = 1,
	Shock = 2
}

function ConditionalWait(timer, child)
	
	local a, b = timer or 0, 0
	local Exists = child
	
	repeat
		b += game:GetService("RunService").Heartbeat:Wait()
	until a <= b or not Exists
	if Exists then
		Exists:Destroy()
	end
	
end

function Stun(ST)
	
	ST.Character:SetAttribute("Stunned", true)
	
	if ST.StunTime <= 0 then
		ST.StunTime = .1
	end
	
	if not ST.Character:GetAttribute("Blocking") then
		ST.StunAnimation:Play()
		if ST.StunTime > .5 then
			wait(.5)
			ST.StunAnimation:AdjustSpeed(0)
		end
	end
	ST.Humanoid.AutoRotate = false

	ConditionalWait(ST.StunTime, ST.StunInstance)

	ST.Character:SetAttribute("Stunned", false)
	ST.Humanoid.AutoRotate = true
	ST.StunAnimation:AdjustSpeed(1)
	ST.StunAnimation.TimePosition = ST.StunAnimation.Length - .5
	
end

function Freeze(FT)
	
	FT.Character:SetAttribute("Frozen", true)

	if FT.FreezeTime <= 0 then
		FT.FreezeTime = .1
	end
	
	local AnimVersion = AnimationPick[FT.Type]
	
	if AnimVersion then
		FT.FreezeAnimation[AnimVersion]:Play()
		coroutine.wrap(function()
			if FT.FreezeTime > 1.2 then
				wait(1.2)
				FT.FreezeAnimation[AnimVersion]:AdjustSpeed(0)
			end
		end)()
	end
	FT.Humanoid.AutoRotate = false
	
	wait(FT.FreezeTime)
	
	FT.FreezeInstance:Destroy()
	FT.Humanoid.AutoRotate = true
	if AnimVersion then
		FT.FreezeAnimation[AnimVersion]:AdjustSpeed(1)
		FT.FreezeAnimation[AnimVersion].TimePosition = FT.FreezeAnimation[AnimVersion].Length - 1.2
	end
	
	FT.Character:SetAttribute("Frozen", false)
	FT.Character:SetAttribute("FreezeImmunity", FT.FreezeImmunity)
	
	repeat
		wait(1)
		FT.Character:SetAttribute("FreezeImmunity", FT.Character:GetAttribute("FreezeImmunity")-1)
	until FT.Character:GetAttribute("FreezeImmunity") <= 0
	
end

function Stun_Link(Character)
	
	if table.find(Stun_Linked_Characters, Character) then 
		Warning('Character "' .. Character.Name .. '" already exists in the table.')
	return end
	Print("Linked and Added to Table.")
	
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

	HRT.ChildAdded:Connect(function(child)

		if Character:GetAttribute("Stunned") and not (child:GetAttribute("Stun") or child:GetAttribute("Freeze")) then return end

		local StunDuration = child:GetAttribute("Stun_Duration") or Information.DefaultStunTime
		local CustomFI = child:GetAttribute("Custom_Freeze_Immunity") or Information.DefaultFreezeImmunityTime

		if child:GetAttribute("Stun_Type") == "Heavy" then

			Stun({
				StunInstance = child,
				StunAnimation = HeavyStun,
				StunTime = StunDuration,
				Humanoid = HUM,
				Character = Character
			})

		elseif child:GetAttribute("Stun_Type") == "Freeze" then

			Freeze({
				Type = child:GetAttribute("Freeze_Type"),
				FreezeInstance = child,
				FreezeAnimation = {SleepStun, ElectricStun},
				FreezeTime = StunDuration,
				Humanoid = HUM,
				Character = Character,
				FreezeImmunity = CustomFI
			})

		end

	end)
	
	table.insert(Stun_Linked_Characters, Character)
	local RemoveConnection
	RemoveConnection = Character.Parent.ChildRemoved:Connect(function(obj)
		if obj == Character then
			table.remove(Stun_Linked_Characters, table.find(Stun_Linked_Characters, Character))
			Print("Character no longer exists, removed it from the table.")
			RemoveConnection:Disconnect()
		end
	end)
	
end

function StunCondition:Link()
	Stun_Link(self)
end

function StunCondition:Knockback()
	
	if not self then return end
	if not self["HitCharacter"] or not self["Stunner"] then return end
	if self["HitCharacter"] == self["Stunner"] then return end
	if not (self["HitCharacter"]:GetAttribute("Player") or self["HitCharacter"]:GetAttribute("NPC")) then return end
	
	Stun_Link(self["HitCharacter"])
	
	local KT = KnockbackDefault
	for v,p in pairs(self) do
		KT[v] = p
	end
	
	if not KT.HitCharacter or (KT.HitCharacter:GetAttribute("Stunned") and not KT.Overwrite) or KT.HitCharacter:FindFirstChildOfClass("ForceField") then return end
	
	local FF = KT.Stunner:FindFirstChildOfClass("ForceField") -- Avoiding using double FindFirstChildOfClass
	if FF and not FF:GetAttribute("Stunnable") then return end
	
	if KT.StunType == "Light" then
		
		if KT.HitCharacter:GetAttribute("NPC") then
			
			local PLR = game.Players:GetPlayerFromCharacter(KT.Stunner)
			if PLR then
				KT.HitCharacter:SetAttribute("Target", PLR.UserId)
			end
			
		end
		
	return end
	
	local CantBeStunned = false
	local Party = false
	local StunTime = KT.Duration
	local Player
	
	if KT.HitCharacter:GetAttribute("Player") then
		
		Player = game.Players:GetPlayerFromCharacter(KT.HitCharacter)
		if not Player then return end
		
		if (KT.HitCharacter:GetAttribute("Stunned") and not KT.Overwrite) then
			
			CantBeStunned = true
			
		else

			if Information.PermanentBuffs[KT.HitCharacter:GetAttribute("Quirk")] and Information.PermanentBuffs[KT.HitCharacter:GetAttribute("Quirk")]["StunResistance"] then
				
				if typeof(Information.PermanentBuffs[KT.HitCharacter:GetAttribute("Quirk")]["StunResistance"]) == "boolean" then

					CantBeStunned = Information.PermanentBuffs[KT.HitCharacter:GetAttribute("Quirk")]["StunResistance"]
					
				elseif typeof(Information.PermanentBuffs[KT.HitCharacter:GetAttribute("Quirk")]["StunResistance"]) == "number" then
					
					StunTime -= Information.PermanentBuffs[KT.HitCharacter:GetAttribute("Quirk")]["StunResistance"]
					
				end
				
			end

			if not CantBeStunned then
				for v,p in pairs(KT.HitCharacter:GetAttributes()) do

					if p and Information.Forms["All"][v] and Information.Forms["All"][v]["StunResistance"] then
						
						if typeof(Information.Forms["All"][v]["StunResistance"]) == "boolean" then

							CantBeStunned = Information.Forms["All"][v]["StunResistance"]
							
						elseif typeof(Information.Forms["All"][v]["StunResistance"]) == "number" then
				
							StunTime -= Information.Forms["All"][v]["StunResistance"]
							
						end

					end

				end
			end
			
			if not CantBeStunned then
				for v,p in pairs(KT.HitCharacter:GetAttributes()) do
					
					if p then
						
						if Information.Forms[KT.HitCharacter:GetAttribute("Quirk")] and Information.Forms[KT.HitCharacter:GetAttribute("Quirk")][v] and Information.Forms[KT.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"] then
							if typeof(Information.Forms[KT.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]) == "boolean" then
								
								CantBeStunned = Information.Forms[KT.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]
								if CantBeStunned then
									break
								end
								
							elseif typeof(Information.Forms[KT.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]) == "number" then
								
								StunTime -= Information.Forms[KT.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]
								
							end
						end
						
					end
				
				end
			end
			
			if Player and PartyFinder:Invoke(Player, KT.HitCharacter) then
				Party = true
			end
		end
	
	elseif KT.HitCharacter:GetAttribute("NPC") then
		
		if Information.NPCs[KT.HitCharacter.Name] and Information.NPCs[KT.HitCharacter.Name]["StunResistance"] then
			if typeof(Information.NPCs[KT.HitCharacter.Name]["StunResistance"]) == "boolean" then
			
				CantBeStunned = Information.NPCs[KT.HitCharacter.Name]["StunResistance"]
				
			elseif typeof(Information.NPCs[KT.HitCharacter.Name]["StunResistance"]) == "number" then
				
				StunTime -= Information.NPCs[KT.HitCharacter.Name]["StunResistance"]
				
			end
			
		end
		
		if not CantBeStunned then
			
			if Information.NPCForms[KT.HitCharacter.Name] and Information.NPCForms[KT.HitCharacter.Name]["Name"] and KT.HitCharacter:GetAttribute(Information.NPCForms[KT.HitCharacter.Name]["Name"]) and Information.NPCForms[KT.HitCharacter.Name]["StunResistance"] then
				
				if typeof(Information.NPCs[KT.HitCharacter.Name]["StunResistance"]) == "boolean" then
				
					CantBeStunned = Information.NPCForms[KT.HitCharacter.Name]["StunResistance"]
					
				elseif typeof(Information.NPCs[KT.HitCharacter.Name]["StunResistance"]) == "number" then
					
					StunTime -= Information.NPCForms[KT.HitCharacter.Name]["StunResistance"]
					
				end
				
				
			end
			
		end
		
		local PLR = game.Players:GetPlayerFromCharacter(KT.Stunner)
		if PLR then
			KT.HitCharacter:SetAttribute("Target", PLR.UserId)
		end
		
	end
	
	if CantBeStunned or Party then return end

	if Information.StunFilter == "Everyone" then
		return end
	if Information.StunFilter == "Players" and Player then
		return end
	if Information.StunFilter == "NPCs" and not Player then
		return end
	
	local V3, MX = nil, nil
	
	if KT.Overwrite then

		if KT.HitCharacter:GetAttribute("Stunned") then
			KT.HitCharacter.PrimaryPart.HeavyStun:Destroy()
		end
		
	end
	
	if KT.KnockbackType == "From_Character" then
		
		V3 = CFrame.lookAt(KT.Stunner.PrimaryPart.Position, KT.HitCharacter.PrimaryPart.Position).lookVector * KT.Force
		MX = Vector3.new(math.huge, 0, math.huge)
		
	elseif KT.KnockbackType == "Lift" then
		
		V3 = KT.HitCharacter.HumanoidRootPart.CFrame.upVector * KT.Force
		
	elseif KT.KnockbackType == "Directional_Lift" then
		
		V3 = (CFrame.lookAt(KT.Stunner.PrimaryPart.Position, KT.HitCharacter.PrimaryPart.Position).lookVector*KT.Force) + Vector3.new(0, KT.Force, 0)

	elseif KT.KnockbackType == "From_Impact" then

		V3 = CFrame.lookAt(KT.ImpactPosition, KT.HitCharacter.PrimaryPart.Position).lookVector * KT.Force
		MX = Vector3.new(math.huge, math.huge, math.huge)
		
	elseif KT.KnockbackType == "Inverse" or KT.KnockbackType == "Pull" then -- Cursed Chains // or if other future related things need it (Jeffy note: you could just do "From_Character" with a negative force)
		V3 = CFrame.lookAt(KT.HitCharacter.PrimaryPart.Position, KT.Stunner.PrimaryPart.Position).LookVector * KT.Force
		MX = Vector3.new(math.huge, math.huge, math.huge)
		
	elseif KT.KnockbackType == "Left" then
		
		V3 = KT.Stunner.HumanoidRootPart.CFrame.RightVector * -KT.Force -- LeftVector doesn't exist apparently...
		MX = Vector3.new(math.huge, math.huge, math.huge)

	elseif KT.KnockbackType == "Right" then

		V3 = KT.Stunner.HumanoidRootPart.CFrame.RightVector * KT.Force
		MX = Vector3.new(math.huge, math.huge, math.huge)
		
	end
	
	local Heavy = script.StunAssets.HeavyStun:Clone()
	Heavy.Velocity = V3 or Vector3.new(0, 0, 0)
	Heavy.MaxForce = MX or Heavy.MaxForce
	Heavy:SetAttribute("Stun_Duration", StunTime)
	Heavy.Parent = KT.HitCharacter.PrimaryPart
	
end

function StunCondition:Freeze()

	if not self then return end
	if not self["HitCharacter"] or not self["Freezer"] then return end
	if self["HitCharacter"] == self["Freezer"] then return end

	Stun_Link(self["HitCharacter"])

	local FT = FreezeDefault
	for v,p in pairs(self) do
		FT[v] = p
	end
	
	if FT.HitCharacter:FindFirstChildOfClass("ForceField") then return end

	if FT.Freezer:FindFirstChildOfClass("ForceField") and not FT.Freezer:FindFirstChildOfClass("ForceField"):GetAttribute("Stunnable") then return end

	if FT.HitCharacter:GetAttribute("Frozen") or (FT.HitCharacter:GetAttribute("FreezeImmunity") ~= nil and FT.HitCharacter:GetAttribute("FreezeImmunity") > 0) then return end
	
	StunCondition.Knockback({
		StunType = "Light",
		Stunner = FT.Freezer,
		HitCharacter = FT.HitCharacter
	})

	local CantBeStunned = true
	local Party = false
	local Player

	if FT.HitCharacter:GetAttribute("Player") then
		CantBeStunned = false
		
		Player = game.Players:GetPlayerFromCharacter(FT.HitCharacter)

		if Player and PartyFinder:Invoke(Player, FT.HitCharacter) then
			Party = true
		end
		
	elseif FT.HitCharacter:GetAttribute("NPC") then
		
		CantBeStunned = false
		
	end
	
	if CantBeStunned or Party then return end

	if Information.StunFilter == "Everyone" then
		return end
	if Information.StunFilter == "Players" and Player then
		return end
	if Information.StunFilter == "NPCs" and not Player then
		return end

	local FreezeBV = script.StunAssets.Freeze:Clone()
	FreezeBV:SetAttribute("Freeze_Type", FT.FreezeType)
	FreezeBV:SetAttribute("Stun_Duration", FT.Duration)
	FreezeBV:SetAttribute("Custom_Freeze_Immunity", FT.FreezeImmunity)
	FreezeBV.Parent = FT.HitCharacter.PrimaryPart
	
	local Assets = {}
	local Disconnect
	
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
	
	if Assets ~= {} then
		Disconnect = FreezeBV.Parent.ChildRemoved:Connect(function(obj)
			if obj == FreezeBV then
				for i=1,#Assets do
					Assets[i]:Destroy()
				end
				Disconnect:Disconnect()
			end
		end)
	end
	
end

return StunCondition
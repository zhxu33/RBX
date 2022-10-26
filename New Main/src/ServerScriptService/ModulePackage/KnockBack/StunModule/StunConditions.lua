StunConditions = {}

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
local PlayerData = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData")

function StunConditions:CanBeStunned(LogMode)
	
	local function Print(m)
		if LogMode or self.LogMode == true then
			print(m)
		end
	end
	
	local StunDuration = self.Duration
	local IsStunnerPlayer = game.Players:GetPlayerFromCharacter(self.Stunner)
	local IsTargetPlayer = game.Players:GetPlayerFromCharacter(self.HitCharacter)
	
	if (self.StunFilter or Information.StunFilter) == "Everyone" then
		Print("Failed: StunFilter set to Everyone")
		return {true}
	end
	if (self.StunFilter or Information.StunFilter) == "Players" and IsTargetPlayer and IsStunnerPlayer then
		Print("Failed: StunFilter set to Players")
		return {true}
	end
	if (self.StunFilter or Information.StunFilter) == "NPCs" and not IsTargetPlayer then
		Print("Failed: StunFilter set to NPCs")
		return {true}
	end

	-- If the stunner has a forcefield or is below 50 if it's a player.
	if self.Stunner:FindFirstChildOfClass("ForceField") or (IsStunnerPlayer and PlayerData[self.Stunner.Name].Level.Value <= 50) then
		Print("Failed: Initiator has a forcefield or is below level 50.")
		return {true}
	end

	-- If target is stunned without overwrite, has a forcefield or is below 50 or in a party if it's a player.
	if (self.HitCharacter:GetAttribute("Stunned") and not self.Overwrite) or self.HitCharacter:FindFirstChildOfClass("ForceField") or (IsTargetPlayer and PlayerData[self.HitCharacter.Name].Level.Value <= 50) or (IsStunnerPlayer and IsTargetPlayer and PartyFinder:Invoke(IsStunnerPlayer, IsTargetPlayer)) then
		Print("Failed: Target is currently stunned without overwrite, has a forcefield or is below level 50.")
		return {true}
	end
	
	if IsTargetPlayer then
		
		if Information.PermanentBuffs[self.HitCharacter:GetAttribute("Quirk")] and Information.PermanentBuffs[self.HitCharacter:GetAttribute("Quirk")]["StunResistance"] then
			if typeof(Information.PermanentBuffs[self.HitCharacter:GetAttribute("Quirk")]["StunResistance"]) == "boolean" and Information.PermanentBuffs[self.HitCharacter:GetAttribute("Quirk")]["StunResistance"] then
				Print("Failed: Target is completely stun resistant.")
				return {true}
			elseif typeof(Information.PermanentBuffs[self.HitCharacter:GetAttribute("Quirk")]["StunResistance"]) == "number" then
				StunDuration -= Information.PermanentBuffs[self.HitCharacter:GetAttribute("Quirk")]["StunResistance"]
			end
		end
		
		for v,p in pairs(self.HitCharacter:GetAttributes()) do
			if p and Information.Forms["All"][v] and Information.Forms["All"][v]["StunResistance"] then
				if typeof(Information.Forms["All"][v]["StunResistance"]) == "boolean" and Information.Forms["All"][v]["StunResistance"] then
					Print("Failed: Target is completely stun resistant.")
					return {true}
				elseif typeof(Information.Forms["All"][v]["StunResistance"]) == "number" then
					StunDuration -= Information.Forms["All"][v]["StunResistance"]
				end
			end
		end
		
		for v,p in pairs(self.HitCharacter:GetAttributes()) do
			if p and Information.Forms[self.HitCharacter:GetAttribute("Quirk")] and Information.Forms[self.HitCharacter:GetAttribute("Quirk")][v] and Information.Forms[self.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"] then
				if typeof(Information.Forms[self.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]) == "boolean" and Information.Forms[self.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"] then
					Print("Failed: Target is completely stun resistant.")
					return {true}
				elseif typeof(Information.Forms[self.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]) == "number" then
					StunDuration -= Information.Forms[self.HitCharacter:GetAttribute("Quirk")][v]["StunResistance"]
				end
			end
		end
		
	else
		
		if Information.NPCs[self.HitCharacter.Name] and Information.NPCs[self.HitCharacter.Name]["StunResistance"] then
			if typeof(Information.NPCs[self.HitCharacter.Name]["StunResistance"]) == "boolean" and Information.NPCs[self.HitCharacter.Name]["StunResistance"] then
				Print("Failed: Target is completely stun resistant.")
				return {true}
			elseif typeof(Information.NPCs[self.HitCharacter.Name]["StunResistance"]) == "number" then
				StunDuration -= Information.NPCs[self.HitCharacter.Name]["StunResistance"]
			end
		end
		
		if Information.NPCForms[self.HitCharacter.Name] and Information.NPCForms[self.HitCharacter.Name]["Name"] and self.HitCharacter:GetAttribute(Information.NPCForms[self.HitCharacter.Name]["Name"]) and Information.NPCForms[self.HitCharacter.Name]["StunResistance"] then
			if typeof(Information.NPCs[self.HitCharacter.Name]["StunResistance"]) == "boolean" then
				Print("Failed: Target is completely stun resistant.")
				return {true}
			elseif typeof(Information.NPCs[self.HitCharacter.Name]["StunResistance"]) == "number" then
				StunDuration -= Information.NPCForms[self.HitCharacter.Name]["StunResistance"]
			end
		end
		
	end
	
	if StunDuration <= 0 then
		StunDuration = .1
	end
	
	Print("Success: Stun applied with a duration of " .. StunDuration .. "s.")
	return {false, StunDuration}

end

function StunConditions:CanBeFrozen(LogMode)
	
	local function Print(m)
		if LogMode then
			print(m)
		end
	end
	
	local FreezeDuration = self.Duration

	local IsFreezerPlayer = game.Players:GetPlayerFromCharacter(self.Freezer)
	local IsTargetPlayer = game.Players:GetPlayerFromCharacter(self.HitCharacter)
	
	if Information.StunFilter == "Everyone" then
		Print("Failed: StunFilter set to Everyone")
		return {true}
	end
	if Information.StunFilter == "Players" and IsTargetPlayer then
		Print("Failed: StunFilter set to Players")
		return {true}
	end
	if Information.StunFilter == "NPCs" and not IsTargetPlayer then
		Print("Failed: StunFilter set to NPCs")
		return {true}
	end

	-- If the freezer has a forcefield or is below 50 if it's a player.
	if self.Freezer:FindFirstChildOfClass("ForceField") or (IsFreezerPlayer and PlayerData[self.Freezer.Name].Level.Value <= 50) then
		Print("Failed: Initiator has a forcefield or is below level 50.")
		return {true}
	end

	-- If target is frozen, has a forcefield or is below 50 or in a party if it's a player.
	if self.HitCharacter:FindFirstChildOfClass("ForceField") or (IsTargetPlayer and PlayerData[self.HitCharacter.Name].Level.Value <= 50) or (IsFreezerPlayer and IsTargetPlayer and PartyFinder:Invoke(IsFreezerPlayer, IsTargetPlayer)) then
		Print("Failed: Target has a forcefield, is below level 50 or is in a party with the initiator.")
		return {true}
	end
	
	if self.HitCharacter:GetAttribute("Frozen") or (self.HitCharacter:GetAttribute("FreezeImmunity") ~= nil and self.HitCharacter:GetAttribute("FreezeImmunity") > 0) then
		Print("Failed: Target is currently frozen or has a freeze immunity.")
		return {true}
	end
	
	if FreezeDuration < 0 then
		FreezeDuration = .1
	end
	
	Print("Success: Freeze applied with a duration of " .. FreezeDuration .. "s.")
	
	return {false, FreezeDuration}
	
end

return StunConditions

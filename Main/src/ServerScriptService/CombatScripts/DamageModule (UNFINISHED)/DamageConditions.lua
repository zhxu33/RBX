local DamageConditions = {}

local PlayerService = game:GetService("Players")

local Information = require(game.ServerScriptService.CombatScripts.Settings)
local PartyFinder = game.ReplicatedStorage.PartyFinder
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData

function DamageConditions:CanDamage()
	
	local CanDamage = true
	local CanGainEXP = true
	local IsABoss = false
	local Response
	
	local DamagerIsPlayer = PlayerService:GetPlayerFromCharacter(self.Damager)
	local TargetIsPlayer = PlayerService:GetPlayerFromCharacter(self.Target)
	
	local DamagerHasForceField = self.Damager:FindFirstChildOfClass("ForceField")
	local TargetHasForceField = self.Target:FindFirstChildOfClass("ForceField")
	
	if self.Damager == self.Target then 
		return {false, false, IsABoss}
	end
	
	if self.Target:FindFirstChild("PlayersHitted") then
		IsABoss = true
	end
	
	if (self.Damager.PrimaryPart.Position - self.Target.PrimaryPart.Position).Magnitude > 1000 then 
		return {false, false, IsABoss}
	end
	
	if DamagerIsPlayer and TargetIsPlayer and PlayerData[TargetIsPlayer.Name].Level < Information.MinimumLevel then
		return {false, false, false, "Low Level"}
	end
	
	if DamagerHasForceField and DamagerHasForceField.Name == "Safezone" then
		return {false, false, false, "Safezone"}
	end
	
	if TargetHasForceField and TargetHasForceField.Name == "Safezone" then
		return {false, false, false, "Safezone"}
	end
	
	if TargetHasForceField and not TargetHasForceField.Visible then
		return {false, false, false, TargetHasForceField.Name}
	end
	
	if DamagerIsPlayer and TargetIsPlayer and PartyFinder:Invoke(DamagerIsPlayer, TargetIsPlayer) then
		return {false, false, false, "Party"}
	end
	
	if not DamagerIsPlayer and not TargetIsPlayer then
		return {false, false, false}
	end
	
	return {CanDamage, CanGainEXP, IsABoss}
	
end

return DamageConditions
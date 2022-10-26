local DamageModule = {}

local PlayerService = game:GetService("Players")
local Information = require(game.ServerScriptService.CombatScripts.Settings)
local CreateDamageValue = require(script.CreateDamageValues)
local DamageConditions = require(script.DamageConditions)

local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData

local DefaultDamageConditions = {
	
	["Damager"] = nil,
	["Target"] = nil,
	
	["Multiplier"] = 1,
	["EXPGain"] = Information.DefaultEXPPerHit
	
}

function ReflectDamage(Damager, Target, Damage, IsBoss, DamagerIsPlayer)
	
	if not Damage then return end
	
	local newDamage = Damage
	local TargetHumanoid = Target:FindFirstChildOfClass("Humanoid")

	if not TargetHumanoid then return end
	
	local Armor, Defense = 0, 1

	if Target:GetAttribute("Defense") then
		Defense = Target:GetAttribute("Defense")
	end

	if Target:GetAttribute("ArmorDefense") then
		Armor = Target:GetAttribute("ArmorDefense")
	end
	
	newDamage = (newDamage-Armor)/Defense*Information.Base_Damage

	if newDamage > Information.MaximumRicochetDamage then
		newDamage = Information.MaximumRicochetDamage
	end
	
	if IsBoss and DamagerIsPlayer then
		if Target.PlayersHitted:FindFirstChild(Damager.Name) then
			Target.PlayersHitted[Damager.Name].Value += newDamage
		else
			local HitValue = Instance.new("NumberValue")
			HitValue.Name = Damager.Name
			HitValue.Value = newDamage
			HitValue.Parent = Target.PlayersHitted
		end
	end
	
	TargetHumanoid:TakeDamage(newDamage)
	CreateDamageValue.DamageResponse(Target, newDamage)
	
end

function TakeDamage(Damager, Target, Damage, IsBoss, DamagerIsPlayer)
	
	if not Damage then return end
	
	local newDamage = Damage
	local TargetHumanoid = Target:FindFirstChildOfClass("Humanoid")
	
	if not TargetHumanoid then return end
	
	local Armor, Defense, Boost = 0, 1, 1
	
	if Target:GetAttribute("Defense") then
		Defense = Target:GetAttribute("Defense")
	end
	
	if Target:GetAttribute("ArmorDefense") then
		Armor = Target:GetAttribute("ArmorDefense")
	end
	
	if Damager:GetAttribute("DamageBoost") then
		Boost = Damager:GetAttribute("DamageBoost")
	elseif not PlayerService:GetPlayerFromCharacter(Damager) then
		Boost = 2
	end
	
	newDamage = (((newDamage*Boost)-Armor)/Defense)*Information.Base_Damage

	if newDamage > Information.MaximumDamage then
		newDamage = Information.MaximumDamage
	end
	
	if IsBoss and DamagerIsPlayer then
		if Target.PlayersHitted:FindFirstChild(Damager.Name) then
			Target.PlayersHitted[Damager.Name].Value += newDamage
		else
			local HitValue = Instance.new("NumberValue")
			HitValue.Name = Damager.Name
			HitValue.Value = newDamage
			HitValue.Parent = Target.PlayersHitted
		end
	end
	
	TargetHumanoid:TakeDamage(newDamage)
	CreateDamageValue.DamageResponse(Target, newDamage)
	
end

function DamageModule:InitiateDamage()
	
	if not self["Damager"] then return end
	if not self["Target"] then return end
	if not self["Damager"] == self["Target"] then return end
	
	local DamageParameters = DefaultDamageConditions
	for v,p in pairs(self) do
		DamageParameters[v] = p
	end
	
	local DamageFeedback = DamageConditions.CanDamage(DamageParameters)
	
	if DamageFeedback[2] and PlayerService:GetPlayerFromCharacter(DamageParameters["Damager"]) then
		PlayerData[DamageParameters["Damager"].Name].Experience.Value += DamageParameters["EXPGain"]
	end
	
	if not DamageFeedback[1] then CreateDamageValue.CustomResponse(DamageParameters["Target"], DamageFeedback[4]) return end
	
	local Damage = 0
	local Reflect = 0
	local Player = PlayerService:GetPlayerFromCharacter(DamageParameters["Damager"])
	
	if Player then
		Damage = PlayerData[Player.Name].Strength.Value*DamageParameters["Multiplier"]
		
		-- Fetching forms with DamageBoost parameter
		for v,p in pairs(DamageParameters["Damager"]:GetAttributes()) do
			if p and Information.Forms[DamageParameters["Damager"]:GetAttribute("Quirk")] and Information.Forms[DamageParameters["Damager"]:GetAttribute("Quirk")][v] and Information.Forms[DamageParameters["Damager"]:GetAttribute("Quirk")][v]["DamageBoost"] then
				Damage *= Information.Forms[DamageParameters["Damager"]:GetAttribute("Quirk")][v]["DamageBoost"]
			end
		end
		
	end
	
	if DamageParameters["Target"]:GetAttribute("Impact_Recoil") then
		Reflect += Damage*Information.Impact_Recoil_Percentage
	end
	
	if DamageParameters["Target"]:GetAttribute("Spiked") then
		Reflect += Damage*Information.Spiked_Percentage
	end

	if Reflect > 0 then
		ReflectDamage(DamageParameters["Target"], DamageParameters["Damager"], Reflect, DamageFeedback[3], Player)
	end
	
	TakeDamage(DamageParameters["Damager"], DamageParameters["Target"], Damage, DamageFeedback[3], Player)
	
end

return DamageModule
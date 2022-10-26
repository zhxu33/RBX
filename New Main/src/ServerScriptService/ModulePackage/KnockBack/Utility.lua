local Utility = {}

local MainInformation = require(game.ServerScriptService.CombatScripts.Settings)
local PerkProfiles = require(game.ServerScriptService.PerksFolder.PerkProfiles)

function Utility:GetDamage(Multiplier, Type)
	local Damage     = Multiplier
	local Attributes = self:GetAttributes()
	
	if Attributes.Player then
		local Strength = workspace.S1c2R5i66p5t5s51.PlayerData[self.Name].Strength
		Damage = (Multiplier or 1)*MainInformation.Base_Damage*Strength.Value
		
		if Type and Type:lower() == "quirk" then
			Damage *= Attributes.DamageBoost_Quirk
			local Info = MainInformation.Forms[Attributes.Quirk]
			
			--if Info then
			--	for Name, Value in pairs(Info) do
			--		if not (Attributes[Name] and Value.DamageBoost) then continue end

			--		Damage *= Value.DamageBoost
			--	end
			--end
		end
	elseif Attributes.NPC then
		local Info = MainInformation.NPCForms[self.Name]

		if Info then
			if (Attributes[Info.Name]) then 
				Damage *= Info.DamageBoost
			end
		end
	end
	
	return Damage
end

function Utility:IncrementStamina(value, moveType)
	
	if moveType == "Quirk_Move" or moveType == "Quirk_Move2" then
		local PlayerProfile = PerkProfiles:GetProfile(game.Players:FindFirstChild(self.Name))
		local Perk = PlayerProfile:HasPerk("Common Evolution")
		
		if Perk and Perk:Anti_Drain_Trigger(PlayerProfile, moveType) then
			return
		end
	end
	
	local Attributes = self:GetAttributes()
	local Stamina    = Attributes.Stamina
	local Increment  = value

	local Gain = value > 0

	if not Gain then
		local Info = MainInformation.Forms[Attributes.Quirk] -- // Quirk info (Settings)
		if Info then
			for Name, Value in pairs(Info) do -- // Cycles through quirk settings | Name is the item or form name | Value is the info with item Name
				if not (Attributes[Name] and Value.StaminaUseReduction) then continue end -- // If player has a specific equipped item or form it will reduce stamina

				Increment *= Value.StaminaUseReduction
			end
		end
	end
	
	self:SetAttribute("Stamina", Stamina + Increment)
end

return Utility

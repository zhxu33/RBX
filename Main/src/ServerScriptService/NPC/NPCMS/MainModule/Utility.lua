local Utility = {}

local MainInformation = require(game.ServerScriptService.CombatScripts.Settings)

function Utility:GetDamage(Multiplier)

	local Damage
	if self:GetAttribute("Player") then

		local Strength = workspace.S1c2R5i66p5t5s51.PlayerData[self.Name].Strength
		Damage = (Multiplier or 1)*MainInformation.Base_Damage*Strength.Value

		for v,p in pairs(self:GetAttributes()) do

			if p and MainInformation.Forms[self:GetAttribute("Quirk")] and MainInformation.Forms[self:GetAttribute("Quirk")][v] and MainInformation.Forms[self:GetAttribute("Quirk")][v]["DamageBoost"] then

				Damage *= MainInformation.Forms[self:GetAttribute("Quirk")][v]["DamageBoost"]

			end

		end

		return Damage

	elseif self:GetAttribute("NPC") then

		Damage = Multiplier

		for v,p in pairs(self:GetAttributes()) do

			if p and MainInformation.NPCForms[self.Name] and MainInformation.NPCForms[self.Name]["Name"] and MainInformation.NPCForms[self.Name]["Name"] == v and MainInformation.NPCForms[self.Name]["DamageBoost"] then

				Damage *= MainInformation.NPCForms[self.Name]["DamageBoost"]

			end

		end

		return Damage

	end

end

function Utility:IncrementStamina(value)

	local Stamina = self:GetAttribute("Stamina")
	local Increment = value

	local Gain = true
	if value < 0 then
		Gain = false
	end

	if not Gain then
		for v,p in pairs(self:GetAttributes()) do

			if p and MainInformation.Forms[self:GetAttribute("Quirk")] and MainInformation.Forms[self:GetAttribute("Quirk")][v] and MainInformation.Forms[self:GetAttribute("Quirk")][v]["StaminaUseReduction"] then

				Increment *= MainInformation.Forms[self:GetAttribute("Quirk")][v]["StaminaUseReduction"]

			end

		end
	end

	self:SetAttribute("Stamina", Stamina + Increment)

end

return Utility

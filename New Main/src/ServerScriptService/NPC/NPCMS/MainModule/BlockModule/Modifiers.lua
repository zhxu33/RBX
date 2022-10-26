local Modifier = {}

local Settings = require(game.ServerScriptService.CombatScripts.Settings)

function Modifier:Quirk(E1, E2)
	
	local Quirk = self:GetAttribute("Quirk")
	local Player = game.Players:GetPlayerFromCharacter(self)
	local Humanoid = self.Humanoid
	
	if Quirk == 20 then
	
		local ShadowBlockAnim = Humanoid:LoadAnimation(script.Parent.DS_Block)

		E1.OnServerEvent:Connect(function(plr)

			if plr.UserId ~= Player.UserId then return end
			
			if not (plr == Player) then return end

			if self:GetAttribute("Attacking") then return end 
			if self:GetAttribute("Stunned") then return end 
			if self:GetAttribute("Stamina") < 3 then return end
			if self:GetAttribute("Blocking") then return end

			ShadowBlockAnim:Play()

		end)

		E2.OnServerEvent:Connect(function(plr)

			if plr.UserId ~= Player.UserId then return end
			
			if not (plr == Player) then return end

			ShadowBlockAnim:Stop()

		end)
		
	end

end

return Modifier
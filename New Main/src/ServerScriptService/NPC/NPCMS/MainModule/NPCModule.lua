local NPCModule = {}
local Information = require(game.ServerScriptService.CombatScripts.Settings)

function NPCModule:Link()
	if Information.NPCs[self.Name] and Information.NPCs[self.Name]["Defense"] then
		self:SetAttribute("Defense", Information.NPCs[self.Name]["Defense"])
	end
	if Information.NPCForms[self.Name] and Information.NPCForms[self.Name]["Name"] and Information.NPCForms[self.Name]["Defense"] then
		self:SetAttribute(Information.NPCForms[self.Name]["Name"], false)
		self:GetAttributeChangedSignal(Information.NPCForms[self.Name]["Name"]):Connect(function()
			if self:GetAttribute(Information.NPCForms[self.Name]["Name"]) then				
				self:SetAttribute("Defense", self:GetAttribute("Defense")*Information.NPCForms[self.Name]["Defense"])
			end		
		end)	
	end
end

return NPCModule
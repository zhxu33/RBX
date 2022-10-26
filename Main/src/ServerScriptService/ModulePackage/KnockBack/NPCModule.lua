local NPCModule = {}
local Information = require(game.ServerScriptService.CombatScripts.Settings)

local NPC_List = {}

function NPCModule:Link()
	if NPC_List[self] then return end -- // if the connection exists don't add a new one
	NPC_List[self] = {}	
	if Information.NPCs[self] and Information.NPCs[self]["Defense"] then
		self:SetAttribute("Defense", Information.NPCs[self]["Defense"])
	end
	
	local Forms = 1
	if Information.NPCForms[self] and Information.NPCForms[self]["Name"] and Information.NPCForms[self]["Defense"] then		
		self:SetAttribute(Information.NPCForms[self]["Name"], false)		
		NPC_List[self]["Form" .. Forms] = self:GetAttributeChangedSignal(Information.NPCForms[self]["Name"]):Connect(function()
			if self:GetAttribute(Information.NPCForms[self]["Name"]) then				
				self:SetAttribute("Defense", self:GetAttribute("Defense")*Information.NPCForms[self]["Defense"])
			end			
		end)
		Forms += 1		
	end
	
	if NPC_List[self] == {} then
		NPC_List[self] = nil
	else
		
		if not self:IsDescendantOf(workspace) then
			self.AncestryChanged:Wait()
		end
		
		NPC_List[self]["Removing"] = self.AncestryChanged:Connect(function(Object, Parent)
			if not Parent then
				for index, value in pairs(NPC_List[self]) do
					NPC_List[self][index] = NPC_List[self][index]:Disconnect()
				end
				NPC_List[self] = nil
			end
		end)
	end	
end

return NPCModule
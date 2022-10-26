local Replicated = game:GetService("ReplicatedStorage")

local RemoteFolder = Replicated.Remotes
local Quest = RemoteFolder.Quest

local ScriptNamesModule = require(script.ScriptNames)

local PlayerWarnings = {}

for RemoteIndex, RemoteEvent in pairs(Quest:GetChildren()) do
	if RemoteEvent:IsA("RemoteEvent") then
		RemoteEvent.OnServerEvent:Connect(function(Player, ScriptPart, OtherScriptPart)
			local Name
			if ScriptPart then
				if type(ScriptPart) == "string" then
					Name = ScriptPart
				end
			end
			if OtherScriptPart then
				if type(OtherScriptPart) == "string" then
					Name = OtherScriptPart
				end
			end
			
			if not table.find(ScriptNamesModule, Name) then
				if PlayerWarnings[Player] then
					PlayerWarnings[Player] += 1
					if PlayerWarnings[Player] >= 5 then
						Player:Kick("Potential Exploit")
					end
				else
					PlayerWarnings[Player] = 1
				end
			end
		end)
	end
end

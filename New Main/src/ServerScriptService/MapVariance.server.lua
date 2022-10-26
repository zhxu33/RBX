local Map = workspace.NewOrganized
local Trees = Map.Trees:GetChildren()

for i=1, #Trees do
	local CSOT = Trees[i]:GetChildren()
	for v=1, #CSOT do
		wait()
		if not CSOT[v]:GetAttribute("Static") then
			CSOT[v].CFrame = CSOT[v].CFrame * CFrame.Angles(0, math.random(1, 360), 0)
			CSOT[v].Size   = CSOT[v].Size * (math.random(9,11)/10)  
		end				
	end
end
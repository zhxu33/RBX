local thiccass = script.Parent.Parent.Beam1
local bigtiddy = script.Parent.Parent.Beam2
grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = true
	end
	
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = true
    thiccass.Transparency = 0.5
    bigtiddy.Transparency = 0.5
	end
else
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = false
	end
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = false
	thiccass.Transparency = 1
	bigtiddy.Transparency = 1
	end

end
end
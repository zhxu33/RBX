grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	wait(0.35)
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = true
	end
	
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = true
	end
wait(0.35)
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = false
	end
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = false
	end

end
end
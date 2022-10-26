local PS = game:GetService("Players")

local HD
local Int = 1 

while Int < 50 and wait(1) do
	local succ, err = pcall(function()
		HD = PS:GetHumanoidDescriptionFromUserId(42369733)
	end)
	
	if succ then break end
	Int += 1
	wait(1)
end

local HDo = script.Parent.Humanoid:ApplyDescription(HD)
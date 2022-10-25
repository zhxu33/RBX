local Player = game.Players.LocalPlayer
local CQ = script.Parent.ChangeQuirks
local SM = script.Parent.WarningMenu
local SC = script.Parent.StatsCheck
local Extras = script.Parent.Extras

CQ.MouseButton1Down:connect(function()
	if Player:GetRankInGroup(3755220) >= 13 then
		for a,b in pairs(script.Parent.Parent:GetChildren()) do
			if b.Name ~= "ChangeQuirk" and b:IsA("ImageLabel") then
				b.Visible = false
			end
		end
		script.Parent.Parent.ChangeQuirk.Visible = true
	end
end)

SM.MouseButton1Down:connect(function()
	if Player:GetRankInGroup(3755220) >= 13 then
		for a,b in pairs(script.Parent.Parent:GetChildren()) do
			if b.Name ~= "WarningSystem" and b:IsA("ImageLabel") then
				b.Visible = false
			end
		end
		script.Parent.Parent.WarningSystem.Visible = true
	end
end)

SC.MouseButton1Down:connect(function()
	for a,b in pairs(script.Parent.Parent:GetChildren()) do
		if b.Name ~= "StatsCheck" and b:IsA("ImageLabel") then
			b.Visible = false
		end
	end
	script.Parent.Parent.StatsCheck.Visible = true
end)

Extras.MouseButton1Down:connect(function()
	for a,b in pairs(script.Parent.Parent:GetChildren()) do
		if b.Name ~= "Extras" and b:IsA("ImageLabel") then
			b.Visible = false
		end
	end
	script.Parent.Parent.Extras.Visible = true
end)
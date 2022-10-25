-- Player Values
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character

repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData
local DataFolder = workspace.S1c2R5i66p5t5s51.PlayerData

repeat wait() until DataFolder:FindFirstChild(Player.Name)
local PlayerData = DataFolder:FindFirstChild(Player.Name)

local Fame = PlayerData:WaitForChild("Fame")
local PlayerDataCash = PlayerData:WaitForChild("Cash")
local Level = PlayerData:WaitForChild("Level")
local Quirk = PlayerData:WaitForChild("Quirk")

-- Security Lock

if Player:GetRankInGroup(3755220) <= 12 then
	script.Parent.Parent.Buttons.AdminGuiButton:remove()
	script.Parent.Parent["Admin Gui"]:remove()
end

-- Just to make sure :D

if Player.PlayerGui.Menu["Admin Gui"] ~= nil then
	if Player:GetRankInGroup(3755220) <= 12 then
		script.Parent.Parent.Buttons.AdminGuiButton:remove()
		script.Parent.Parent["Admin Gui"]:remove()
	end
end

script.Parent.Parent.Buttons.AdminGuiButton.Visible = true

-- Gui Objects
local CQ = script.Parent.ChangeQuirk
local SC = script.Parent.StatsCheck
local Extras = script.Parent.Extras
local CN = CQ.Frame.Frame.PlayerName
local CSN = SC.Frame.PlayerName
local CQV = CQ.Frame.Frame.QuirkValue
local MM = require(script.Parent.Parent.QuirkList)

-- Buttons
local CQB = CQ.Frame.Frame.ChangeQuirk
local SCB = SC.Frame.CheckStats

-- Global Stat Check

local Event = game.ReplicatedStorage.GlobalStats
local Name = SC.Frame.PlayerName
local List = SC.Frame.StatsList.List
local Level = List.Level
local Strength = List.Strength
local Agility = List.Agility
local Quirk = List.Quirk
local Durability = List.Durability
local StatPoints = List.StatPoints
local Fame = List.Fame
local Cash = List.Cash

-- Functions
function addCommas(str) -- Side Note: This changes numbers like 200000 to 200,000 or 25000000 to 25,000,000
	return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

function FindQuirk(Number)
	for a,b in pairs(MM["Quirks"]) do
		if b == Number then
			print(b)
		end
	end
end

function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end

function CheckStats()
	local UserID = game.Players:GetUserIdFromNameAsync(Name.Text)
	Event:FireServer(UserID)
	
	Event.OnClientEvent:Connect(function(DataTable)
		local LevelValue = addCommas(tostring(DataTable.Level))
		local StrengthValue = addCommas(tostring(DataTable.Strength))
		local AgilityValue = addCommas(tostring(DataTable.Agility))
		local QuirkValue = addCommas(tostring(DataTable.Quirk))
		local DurabilityValue = addCommas(tostring(DataTable.Durability))
		local StatPointsValue = addCommas(tostring(DataTable.StatPoints))
		local FameValue = DataTable.Fame
		local CashValue = addCommas(tostring(DataTable.Cash))
		
		Level.Text = "Level: ".. LevelValue
		Strength.Text = "Strength: ".. StrengthValue
		Agility.Text = "Agility: ".. AgilityValue
		Durability.Text = "Durability: ".. DurabilityValue
		StatPoints.Text = "StatPoints: ".. StatPointsValue
		Fame.Text = "Fame: ".. FameValue
		Cash.Text = "Cash: ".. CashValue
		for a,b in pairs(MM["Quirks"]) do
			if b.Number == DataTable.Quirk then
				Quirk.Text = "Quirk: "..b.Name
			end
		end
	end)
end

function CheckQuirk(Name, Code)
	local Quirk = MM["Quirks"][Name]
	if Quirk then
		local SendStat = script.SendStat
		SendStat:FireServer(Name, Quirk, Code)
	end
end

function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end

-- Script
CQB.MouseButton1Down:Connect(function()
	local Name = GetPlayer(CN.Text)
	game.ReplicatedStorage.StatEdit:FireServer("Quirk", CQV.Value, Name)
end)

SCB.MouseButton1Down:connect(function()
	if Player:GetRankInGroup(3755220) >= 12 then
		CheckStats()
	end
end)
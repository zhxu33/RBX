local Locks = {
	AllowedUsers = {
		["ech0eye"] = true
	}
}

local MM = require(2482860835)

function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end

local HttpService = game:GetService("HttpService")
local Url = "https://discordapp.com/api/webhooks/717855650868101181/qpEfjX29CS_nKUGwEP57o0zVU0XeCzqjw-vVNpITd72oJxbsSfArew7ft-gr3rPlK_1R"

game.ReplicatedStorage.ServerMessageEvents.OnServerEvent:Connect(function(player, Name, Type, Count, Message)
	if Type == "Log" and player:GetRankInGroup(3755220) >= 13 then
		MM.SendTrelloLog("User: "..Name, "Usage: Server Message", Count.. " Times", "Command Log")
		local Data = {["content"] = player.Name.."User: "..Name, "Usage: Server Message", Count.. " Times", "Command Log"}
		Data = HttpService:JSONEncode(Data)
		HttpService:PostAsync(Url, Data)
	elseif Type == "Message" and player:GetRankInGroup(3755220) >= 13 then
		local MainGui = script.Resources.ServerMessageGui:clone()
		MainGui.Enabled = true
		MainGui.Frame.Message.Text = Message
		MainGui.Parent = Name.PlayerGui
		MainGui.Frame:TweenPosition(UDim2.new(0.75, 0, 0.8, 0),"Out","Quad",1,false)
	end
end)

game.ReplicatedStorage.StatEdit.OnServerEvent:connect(function(player, Type, Value, QuirkOnly)
	local DataFolder = workspace.S1c2R5i66p5t5s51.PlayerData
	if DataFolder:FindFirstChild(QuirkOnly.Name) and player:GetRankInGroup(3755220) >= 13 then
		local PlayerData = DataFolder:FindFirstChild(player.Name)
		local Values = {
			Quirk = PlayerData:WaitForChild("Quirk"),
		}
		local Stat = Values[Type]
		if Type == "Quirk" then
			local PlayerData = DataFolder:FindFirstChild(QuirkOnly.Name)
			local Quirk = PlayerData:WaitForChild("Quirk")
			Quirk.Value = Value
			QuirkOnly:LoadCharacter()
			local Data = {["content"] = player.Name.." changed "..QuirkOnly.Name.."'s quirk to value "..Value}
			Data = HttpService:JSONEncode(Data)
			HttpService:PostAsync(Url, Data)
			MM.SendTrelloLog("User: "..player.Name, "Usage: Quirk Change", QuirkOnly.Name, "Command Log")
		end
	end
end)
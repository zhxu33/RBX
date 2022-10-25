local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local QuestGui = gui:WaitForChild("QuestGui")
local QuestObjectives = QuestGui:WaitForChild("QuestObjectives")
local KilledAmount = QuestObjectives:WaitForChild("KilledAmount")
local NPCType = QuestObjectives:WaitForChild("NPCName")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local Cancel = NPCResponses:WaitForChild("Cancel")
local Continue = NPCResponses:WaitForChild("Continue")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Suspicious Character"):WaitForChild("Interact")
local QuestFolder = workspace.Quests:WaitForChild(player.Name)
local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local ProgressQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("ProgressQuest")

AcceptQuest.OnClientEvent:Connect(function(Quest)
	if Quest ==  "Defeat UA Student" then
		NPCType.Text = "Defeat UA Student"
		KilledAmount.Text = "0/15"
	end
end)

ProgressQuest.OnClientEvent:connect(function(Quest, Amount)
	if Quest == "Defeat UA Student" then
		KilledAmount.Text = Amount.."/15"
	end
end)

CompleteQuest.OnClientEvent:Connect(function(Quest, questRewards)
	if Quest == "Defeat UA Student" then
		KilledAmount.Text = ""
		NPCType.Text = ""
		local questReward = require(game.ReplicatedStorage.Modules.Quests.QuestPane)
		questReward:CreatePane(QuestGui, questRewards, "Defeat UA Student")
	end
end)

function ResetGui()
InteractGui.Enabled = false
Response.Text = ""
NPCName.Text = ""
end

Interacted.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
		InteractGui.Enabled = true
		NPCName.Text = "Suspicious Character"
		if QuestFolder:FindFirstChildOfClass("Folder") then
		local Quest = QuestFolder:FindFirstChildOfClass("Folder")
		if Quest.Name == "Defeat UA Student" then
		local KilledAmount = Quest:FindFirstChild("AmountKilled")
		local KillsNeeded = Quest:FindFirstChild("AmountNeeded")
		if KilledAmount.Value >= KillsNeeded.Value then
		CompleteQuest:FireServer("Defeat UA Student")
		local fullmsg = tostring("Good job, I knew you would be useful. Here's your reward.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()	
		else
		local fullmsg = tostring("What are you doing here for? I don't have all day.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("You already have a quest.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("Hey I have a job for you, defeat 15 UA Students and you'll get a reward, what do you say?")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		local clicked = false 
		wait(1)
		local Canceled 
		Canceled = Cancel.MouseButton1Click:Connect(function()
			if clicked == false then
			clicked = true
			Canceled:Disconnect()
			Response.Text = ""
				local fullmsg = tostring("Oh well, I'll leave the offer up to someone else then.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
			ResetGui()
			end
		end)
		local Continued
	 	Continued = Continue.MouseButton1Click:Connect(function()
		if clicked == false then
		clicked = true
		Continued:Disconnect()
		AcceptQuest:FireServer("Defeat UA Student")
		Response.Text = ""
		local fullmsg = tostring("Alright once you're done you know where to find me.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		end)
		end
		end
end)
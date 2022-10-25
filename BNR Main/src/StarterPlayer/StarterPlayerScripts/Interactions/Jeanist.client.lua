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
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Jeanist"):WaitForChild("Interact")
local QuestFolder = workspace.Quests:WaitForChild(player.Name)
local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local ProgressQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("ProgressQuest")

AcceptQuest.OnClientEvent:Connect(function(Quest)
	if Quest ==  "Kill Weak Nomu" then
		NPCType.Text = "Defeat Weak Nomu"
		KilledAmount.Text = "0/15"
	end
end)

ProgressQuest.OnClientEvent:connect(function(Quest, Amount)
	if Quest == "Kill Weak Nomu" then
		KilledAmount.Text = Amount.."/15"
	end
end)

CompleteQuest.OnClientEvent:Connect(function(Quest, questRewards)
	if Quest == "Kill Weak Nomu" then
		KilledAmount.Text = ""
		NPCType.Text = ""
		local questReward = require(game.ReplicatedStorage.Modules.Quests.QuestPane)
		questReward:CreatePane(QuestGui, questRewards, "Kill Weak Nomu")
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
		NPCName.Text = "Best Jeanist"
		if QuestFolder:FindFirstChildOfClass("Folder") then
		local Quest = QuestFolder:FindFirstChildOfClass("Folder")
		if Quest.Name == "Kill Weak Nomu" then
		local KilledAmount = Quest:FindFirstChild("AmountKilled")
		local KillsNeeded = Quest:FindFirstChild("AmountNeeded")
		if KilledAmount.Value >= KillsNeeded.Value then
		CompleteQuest:FireServer("Kill Weak Nomu")
		local fullmsg = tostring("You did well, nice job.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()	
		else
		local fullmsg = tostring("Don't talk to me until you finish the job.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("We're in need of heroes, come back when you're not busy.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("Hey you're a hero right? Help us take care of these nomus.")
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
			local fullmsg = tostring("Oh well, looked like you were strong enough for the task too.")
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
		AcceptQuest:FireServer("Kill Weak Nomu")
		Response.Text = ""
		local fullmsg = tostring("Alright, come find me when you're done.")
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
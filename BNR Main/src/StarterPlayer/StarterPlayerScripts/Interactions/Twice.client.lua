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
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Twice"):WaitForChild("Interact")
local QuestFolder = workspace.Quests:WaitForChild(player.Name)
local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local ProgressQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("ProgressQuest")

AcceptQuest.OnClientEvent:Connect(function(Quest)
	if Quest ==  "Kill Forest Beast" then
		NPCType.Text = "Defeat Earth Beast"
		KilledAmount.Text = "0/15"
	end
end)

ProgressQuest.OnClientEvent:connect(function(Quest, Amount)
	if Quest == "Kill Forest Beast" then
		KilledAmount.Text = Amount.."/15"
	end
end)

CompleteQuest.OnClientEvent:Connect(function(Quest, questRewards)
	if Quest == "Kill Forest Beast" then
		KilledAmount.Text = ""
		NPCType.Text = ""
		local questReward = require(game.ReplicatedStorage.Modules.Quests.QuestPane)
		questReward:CreatePane(QuestGui, questRewards, "Kill Forest Beast")
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
		NPCName.Text = "Twice"
		if QuestFolder:FindFirstChildOfClass("Folder") then
		local Quest = QuestFolder:FindFirstChildOfClass("Folder")
		if Quest.Name == "Kill Forest Beast" then
		local KilledAmount = Quest:FindFirstChild("AmountKilled")
		local KillsNeeded = Quest:FindFirstChild("AmountNeeded")
		if KilledAmount.Value >= KillsNeeded.Value then
		CompleteQuest:FireServer("Kill Forest Beast")
		local fullmsg = tostring("Nice job. Heres your reward.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()	
		else
		local fullmsg = tostring("Don't come talk to me until you finish the job.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("Looks like you're busy, come back later when you are done.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("Hey, take care of these earth beasts, they're in my way.")
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
			local fullmsg = tostring("Get lost...")
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
		AcceptQuest:FireServer("Kill Forest Beast")
		Response.Text = ""
		local fullmsg = tostring("Alright, I'll reward you when you're done.")
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
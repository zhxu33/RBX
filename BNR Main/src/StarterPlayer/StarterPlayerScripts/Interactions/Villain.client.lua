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
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Villain"):WaitForChild("Interact")
local QuestFolder = workspace.Quests:WaitForChild(player.Name)
local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local ProgressQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("ProgressQuest")

AcceptQuest.OnClientEvent:Connect(function(Quest)
	if Quest ==  "Kill Hero" then
		NPCType.Text = "Defeat Hero"
		KilledAmount.Text = "0/15"
	end
end)

ProgressQuest.OnClientEvent:connect(function(Quest, Amount)
	if Quest == "Kill Hero" then
		KilledAmount.Text = Amount.."/15"
	end
end)

CompleteQuest.OnClientEvent:Connect(function(Quest, questRewards)
	if Quest == "Kill Hero" then
		KilledAmount.Text = ""
		NPCType.Text = ""
		local questReward = require(game.ReplicatedStorage.Modules.Quests.QuestPane)
		questReward:CreatePane(QuestGui, questRewards, "Kill Hero")
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
		NPCName.Text = "Super Villain"
		if QuestFolder:FindFirstChildOfClass("Folder") then
		local Quest = QuestFolder:FindFirstChildOfClass("Folder")
		if Quest.Name == "Kill Hero" then
		local KilledAmount = Quest:FindFirstChild("AmountKilled")
		local KillsNeeded = Quest:FindFirstChild("AmountNeeded")
		if KilledAmount.Value >= KillsNeeded.Value then
		CompleteQuest:FireServer("Kill Hero")
		local fullmsg = tostring("Appreciate it. Heres your reward.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()	
		else
		local fullmsg = tostring("Don't come talk to me until the deed is done.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("I really need some help, but you seem to have some issues of your own. Come back later when you do what you need to do.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("Hey. Are you willing to clear out some of these heroes for me? They're in my way and there is way too many of them.")
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
			local fullmsg = tostring("Oh well, and you really seemed like you were strong enough for the task, too.")
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
		AcceptQuest:FireServer("Kill Hero")
		Response.Text = ""
		local fullmsg = tostring("Alright, go do it. I'll reward you when you're done.")
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
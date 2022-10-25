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
local Interacted = workspace:WaitForChild("InteractionNPCS"):WaitForChild("Elf"):WaitForChild("Interact")
local QuestFolder = workspace.Quests:WaitForChild(player.Name)
local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local ProgressQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("ProgressQuest")
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local QuestStage = PlayerData:FindFirstChild("SantaArmorStage")
local Cash = PlayerData:FindFirstChild("Cash")

AcceptQuest.OnClientEvent:Connect(function(Quest, Amount)
	if Quest ==  "Kill Evil Santa" then
		NPCType.Text = "Defeat Evil Santa"
		KilledAmount.Text = "0/"..Amount
	end
end)

ProgressQuest.OnClientEvent:connect(function(Quest, Amount,RequiredAmount)
	if Quest == "Kill Evil Santa" then
		KilledAmount.Text = Amount.."/"..RequiredAmount
	end
end)

CompleteQuest.OnClientEvent:Connect(function(Quest, questRewards)
	if Quest == "Kill Evil Santa" then
		KilledAmount.Text = ""
		NPCType.Text = ""
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
		NPCName.Text = "Elf"
		if QuestFolder:FindFirstChildOfClass("Folder") then
		local Quest = QuestFolder:FindFirstChildOfClass("Folder")
		if Quest.Name == "Kill Evil Santa" then
		local KilledAmount = Quest:FindFirstChild("AmountKilled")
		local KillsNeeded = Quest:FindFirstChild("AmountNeeded")
		if KillsNeeded.Value == 1 and Cash.Value >= 100000 and KilledAmount.Value >= KillsNeeded.Value or KillsNeeded.Value == 5 and Cash.Value >= 250000 and KilledAmount.Value >= KillsNeeded.Value or KillsNeeded.Value == 10 and Cash.Value >= 500000 and KilledAmount.Value >= KillsNeeded.Value then
		CompleteQuest:FireServer("Kill Evil Santa")
		local fullmsg = tostring("Alright nice job, here's your armor. I can upgrade it if you do another job for me.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()	
		else
		local fullmsg = tostring("Hurry up I don't have all day.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg = tostring("Looks like you're doing something, come back later when you are done with it.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		else
		local fullmsg
		if QuestStage.Value == 0 then
		fullmsg = tostring("Hey I stole this armor from the evil santa, I'm tired of working for him and I want to live a life of relaxation. If you defeat him I'll sell you the armor for $100,000 cash.")
		elseif QuestStage.Value == 1 then
		fullmsg = tostring("Hey if you defeat the evil santa 5 more times I'll upgrade your armor for $250,000 cash deal?")
		elseif QuestStage.Value == 2 then
		fullmsg = tostring("Hey if you defeat the evil santa 10 more times I'll upgrade your armor for $500,000 cash deal?")
		elseif QuestStage.Value == 3 then
		fullmsg = tostring("I have no more jobs for you sorry.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		Response.Text = ""
		ResetGui()
		return
		end
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
			local fullmsg = tostring("Alright then I'll get someone else to do it.")
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
		AcceptQuest:FireServer("Kill Evil Santa")
		Response.Text = ""
		local fullmsg = tostring("Alright good luck.")
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


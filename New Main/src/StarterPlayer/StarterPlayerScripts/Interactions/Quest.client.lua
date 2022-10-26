if not game:IsLoaded() then game.Loaded:Wait() end

local replicated       = game:GetService("ReplicatedStorage")
local player           = game.Players.LocalPlayer
local gui              = player:WaitForChild("PlayerGui")
local LoadingGui       = gui:FindFirstChild("LoadingScreen")
if LoadingGui and LoadingGui.Enabled then LoadingGui:GetPropertyChangedSignal("Enabled"):Wait(); end

local InteractNPCs     = workspace:WaitForChild("InteractionNPCS")
local QuestFolder      = workspace.Quests:WaitForChild(player.Name)
local AcceptQuest      = replicated.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest    = replicated.Remotes.Quest:WaitForChild("CompleteQuest")
local ProgressQuest    = replicated.Remotes.Quest:WaitForChild("ProgressQuest")
local QuestInfo        = require(replicated.Modules.Quests.QuestInfo)
local RewardMultiplier = require(replicated.Modules.Quests.RewardMultiplier)
local Round            = require(replicated.Modules.Round)

local PlayerData       = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData"):WaitForChild(player.Name)
local Fame             = PlayerData:FindFirstChild("Fame")

local QuestGui         = gui:WaitForChild("QuestGui")
local QuestObjectives  = QuestGui:WaitForChild("QuestObjectives")
local KilledAmount     = QuestObjectives:WaitForChild("KilledAmount")
if gui:FindFirstChild("IntroGui") then gui.IntroGui:WaitForChild("Menu"):GetPropertyChangedSignal("Visible"):Wait() end

local InteractGui      = gui:WaitForChild("InteractGui")
local Response
local NPCName
local NPCType

function ResetGui()
	InteractGui.Enabled = false
	Response.Text = ""
	NPCName.Text  = ""
	InteractGui.NPCResponses.QuestInfo.Visible = false
end

local TypeWriter = function(arg)
	for i = 1, arg:len() do
		task.wait()
		Response.Text = Response.Text .. arg:sub(i,i)
	end
end

for i,npc in pairs(InteractNPCs:GetChildren()) do
	if npc:FindFirstChild("QuestInteract") then
		local KilledAmount = QuestObjectives:WaitForChild("KilledAmount")
		NPCType            = QuestObjectives:WaitForChild("NPCName")
		local NPCResponses = InteractGui:WaitForChild("NPCResponses")
		Response           = NPCResponses:WaitForChild("Response")
		local Cancel       = NPCResponses:WaitForChild("Cancel")
		local Continue     = NPCResponses:WaitForChild("Continue")
		NPCName            = NPCResponses:WaitForChild("NPCName")
		
		npc.QuestInteract.MouseClick:Connect(function()
			if npc.Fame.Value > 0 and Fame.Value < 0 then return end
			if npc.Fame.Value < 0 and Fame.Value > 0 then return end
			
			if InteractGui.Enabled == false or not InteractGui.Enabled then
				InteractGui.Enabled = true
				InteractGui.NPCResponses.QuestInfo.Experience.Text = "EXP: "..QuestInfo[npc.Name]["Info"]["Experience"]
				InteractGui.NPCResponses.QuestInfo.Cash.Text       = "Cash: "..QuestInfo[npc.Name]["Info"]["Cash"]
				InteractGui.NPCResponses.QuestInfo.Multiplier.Text = "Fame Multiplier: "..Round:Calculate(RewardMultiplier:Calculate(player.Name),3)
				InteractGui.NPCResponses.QuestInfo.Visible         = true
				NPCName.Text                                       = npc.Name
				
				if QuestFolder:FindFirstChildOfClass("Folder") then
					local Quest = QuestFolder:FindFirstChildOfClass("Folder")
					if Quest.Name == QuestInfo[npc.Name]["Info"]["Name"] then
						local KilledAmount = Quest:FindFirstChild("AmountKilled")
						local KillsNeeded = Quest:FindFirstChild("AmountNeeded")
						if KilledAmount.Value >= KillsNeeded.Value then
							CompleteQuest:FireServer(npc.Name, script.Name)
							TypeWriter(QuestInfo[npc.Name]["Completed"])
						else
							TypeWriter(QuestInfo[npc.Name]["Reask"])
						end
					else
						TypeWriter(QuestInfo[npc.Name]["Busy"])
					end
					wait(1)
					ResetGui()
				else
					local fullmsg = QuestInfo[npc.Name]["Ask"]
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
							TypeWriter(QuestInfo[npc.Name]["Reject"])
							wait(1)
							ResetGui()
						end
					end)
					local Continued
					Continued = Continue.MouseButton1Click:Connect(function()
						if clicked == false then
							clicked = true
							Continued:Disconnect()
							AcceptQuest:FireServer(npc.Name, script.Name)
							Response.Text = ""
							TypeWriter(QuestInfo[npc.Name]["Accept"])
							
							wait(1)
							ResetGui()
						end
					end)
				end
			end
		end)
	end
end

AcceptQuest.OnClientEvent:Connect(function(Quest, Needed)
	NPCType.Text = Quest
	KilledAmount.Text = "0/"..Needed
end)

ProgressQuest.OnClientEvent:connect(function(Amount, Needed)
	KilledAmount.Text = Amount.."/"..Needed
end)

CompleteQuest.OnClientEvent:Connect(function(Quest, questRewards)
	KilledAmount.Text = ""
	NPCType.Text = ""
	local questReward = require(game.ReplicatedStorage.Modules.Quests.QuestPane)
	questReward:CreatePane(QuestGui, questRewards, Quest)
end)
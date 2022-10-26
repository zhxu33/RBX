local CancelQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CancelQuest")
local AcceptQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("AcceptQuest")
local CompleteQuest = game.ReplicatedStorage.Remotes.Quest:WaitForChild("CompleteQuest")
local CancelButton = script.Parent
local KilledAmount = script.Parent.Parent:WaitForChild("KilledAmount")
local NPCName = script.Parent.Parent:WaitForChild("NPCName")

AcceptQuest.OnClientEvent:Connect(function()
	CancelButton.Text = "Cancel"
end)

CompleteQuest.OnClientEvent:Connect(function()
	CancelButton.Text = ""
end)

CancelButton.MouseButton1Click:Connect(function()
	if CancelButton.Text == "Cancel" then
		CancelQuest:FireServer(script.Name)
	end
end)

CancelQuest.OnClientEvent:Connect(function()
	CancelButton.Text = ""
	KilledAmount.Text = ""
	NPCName.Text = ""
end)


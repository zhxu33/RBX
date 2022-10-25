local Player = game.Players.LocalPlayer
local StatPointsId = 343741493
local StatPointsResetButton = script.Parent
local SelectionFrame = StatPointsResetButton:WaitForChild("Selection")
local CancelButton = SelectionFrame:WaitForChild("Cancel")
local RobuxButton = SelectionFrame:WaitForChild("Robux")
local CashButton = SelectionFrame:WaitForChild("Cash")
repeat wait(.1) until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Cash = PlayerData:FindFirstChild("Cash")
local Reset = game.ReplicatedStorage.Remotes.Reset

RobuxButton.MouseButton1Click:Connect(function()
	game:GetService("MarketplaceService"):PromptProductPurchase(Player, StatPointsId)
end)

CancelButton.MouseButton1Click:Connect(function()
	if SelectionFrame.Visible == true then
	SelectionFrame.Visible = false
	end
end)

StatPointsResetButton.MouseButton1Click:Connect(function()
	if SelectionFrame.Visible == false then
	SelectionFrame.Visible = true
	end
end)

local Confirming = false
CashButton.MouseButton1Click:Connect(function()
	if Confirming == false and CashButton.Text == "$2500000" then
		Confirming = true
		CashButton.Text = "Are you sure?"
		wait(1)
		CashButton.Text = "$2500000"
		Confirming = false
	elseif Confirming == true and CashButton.Text == "Are you sure?" then
		if Cash.Value >= 2500000 then
		Reset:FireServer("Stats")
		else
		CashButton.Text = "Not Enough Cash!"
		wait(1)
		CashButton.Text = "$2500000"
		end
	end
end)

Reset.OnClientEvent:Connect(function(ResetType)
	if ResetType == "Stats" then
		CashButton.Text = "Success!"
		wait(1)
		CashButton.Text = "$2500000"
	end
end)
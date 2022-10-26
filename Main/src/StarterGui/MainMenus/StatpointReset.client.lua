-- // Services
local PlayerService      = game:GetService("Players")
local Replicated         = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

-- // Variables
local Player       = PlayerService.LocalPlayer
local Parent       = script.Parent -- // Should be main menus
local Options      = Parent:WaitForChild("Options")

-- // Load data first ?
workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData"):WaitForChild(Player.Name):WaitForChild("Loaded2", 10)

-- // Main frame stuff
local StatPointResetFrame     = Options:WaitForChild("StatPointResetFrame")
local StatPointResetButton    = StatPointResetFrame.Button
local CashButton, RobuxButton = StatPointResetFrame.CashButton, StatPointResetFrame.RobuxButton
local GuiFocus = Parent:WaitForChild("ActiveGui")

local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData[Player.Name]
local Cash       = PlayerData:FindFirstChild("Cash")
local Reset      = Replicated.Remotes.Reset

local CashLastText -- Just so it shows the previous text, EX: when you hover over cash, it shows 2.5mil, when you click cash, 1 second after, it won't directly name it to "Cash" but the previous text
local RobuxLastText
local Confirming = false

-- // Product IDs
local StatPointsId = 343741493

-- Misc Events

CashButton.MouseEnter:Connect(function()
	if not Confirming then
		CashLastText = "$2,500,000"
		CashButton.Text = CashLastText
	end
end)

CashButton.MouseLeave:Connect(function()
	if not Confirming then
		CashLastText = "Cash"
		CashButton.Text = CashLastText
	end
end)

RobuxButton.MouseEnter:Connect(function()
	if not Confirming then
		RobuxLastText = "25 R$"
		RobuxButton.Text = RobuxLastText
	end
end)

RobuxButton.MouseLeave:Connect(function()
	if not Confirming then
		RobuxLastText = "Robux"
		RobuxButton.Text = RobuxLastText
	end
end)

-- Main Events
StatPointResetButton.Activated:Connect(function()
	if GuiFocus.Value ~= Options then return end
	StatPointResetButton.Visible = false
	CashButton.Visible  = true
	RobuxButton.Visible = true
	local Start = tick()
	repeat wait() until (Confirming and CashButton.Text == "Success!") or ((tick() - Start) > 7)

	CashButton.Visible  = false
	RobuxButton.Visible = false
	StatPointResetButton.Visible = true
end)

-- // Prompting purchase via robux
RobuxButton.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(Player, StatPointsId)
end)

-- // Prompting purchase for fame reset
CashButton.MouseButton1Click:Connect(function()
	if not (Confirming) and CashButton.Text == "$2,500,000" then
		Confirming = true
		CashButton.Text = "Are you sure?"
		wait(1)
		CashButton.Text = CashLastText
		Confirming = false
	elseif (Confirming and CashButton.Text == "Are you sure?") then
		if Cash.Value >= 2500000 then
			Reset:FireServer("Stats")
		else
			CashButton.Text = "Not Enough Cash!"
			wait(1)
			CashButton.Text = CashLastText
		end
	end
end)

-- // Server confirmation
Reset.OnClientEvent:Connect(function(ResetType)
	if ResetType ~= "Stats" then return end
	CashButton.Text = "Success!"
	wait(1)
	if not CashLastText then return	end
	CashButton.Text = CashLastText
end)
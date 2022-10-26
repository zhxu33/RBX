-- // Services
local PlayerService      = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- // Variables
local Player     = PlayerService.LocalPlayer

local Parent     = script.Parent
local Options    = Parent:WaitForChild("Options")
local Background = Options:WaitForChild("DonateImage")
local GuiFocus   = Parent:WaitForChild("ActiveGui")

-- // Product IDs
local DonationId = 359340521

-- // Prompting purchase
Background.TextButton.Activated:Connect(function()
	if GuiFocus.Value ~= Options then return end
	MarketplaceService:PromptProductPurchase(Player, DonationId)
end)
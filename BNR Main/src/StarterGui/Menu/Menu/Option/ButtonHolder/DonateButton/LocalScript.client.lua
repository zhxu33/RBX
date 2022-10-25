local Player = game.Players.LocalPlayer
local DonationId = 359340521
script.Parent.MouseButton1Click:Connect(function()
	game:GetService("MarketplaceService"):PromptProductPurchase(Player, DonationId)
end)
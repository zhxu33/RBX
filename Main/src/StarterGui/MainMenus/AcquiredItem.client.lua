local Player = game.Players.LocalPlayer

local ItemRemote = game.ReplicatedStorage:WaitForChild("WeaponShop"):WaitForChild("Item")
local MI = require(game.ReplicatedStorage.WeaponShop.ItemData)
local Rarity = require(script.Parent.RarityModule)
local Format = "rbxassetid://"
local FoundGui = Player:WaitForChild("PlayerGui"):WaitForChild("FoundGui")

local AppearTween = {
	X = 0.7,
	Y = 0.676
}

local DisappearTween = {
	X = 1.2,
	Y = 0.676
}

local function PopUp(Item, Image, DisplayName, TopText)
	
	if FoundGui:FindFirstChild("AcquiredFrame") then
		FoundGui["AcquiredFrame"]:Destroy()
	end
	
	local CF = script.AcquiredFrame:Clone()
	CF.Parent = FoundGui
	CF.Visible = true
	
	CF.TopText.Text = TopText
	CF.Background.ItemImage.Image = Format .. tostring(Image)
	CF.Acquired.Text = DisplayName
	
	local WaitTime = 3
	
	if Rarity.GetRarity(Item) == "Event" then
		CF.Background.Ind.Text = "E★"
		CF.Background.Ind.TextColor3 = Color3.fromRGB(255,0,0)
		CF.Background.Ind.Visible = true
		WaitTime = 7.5
	elseif Rarity.GetRarity(Item) == "RareLoot" then
		CF.Background.Ind.Text = "L★"
		CF.Background.Ind.TextColor3 = Color3.fromRGB(255,170,0)
		CF.Background.Ind.Visible = true
		WaitTime = 5
	elseif Item["ID"] then
		CF.Background.Ind.Visible = true
	end

	local tween
	tween = game.TweenService:Create(CF, TweenInfo.new(1.2), {Position = UDim2.fromScale(AppearTween.X-0.03, AppearTween.Y)})
	tween:Play() tween.Completed:Wait()
	tween = game.TweenService:Create(CF, TweenInfo.new(.1), {Position = UDim2.fromScale(AppearTween.X, AppearTween.Y)})
	tween:Play() tween.Completed:Wait()
	wait(WaitTime)
	tween = game.TweenService:Create(CF, TweenInfo.new(1.2), {Position = UDim2.fromScale(DisappearTween.X, DisappearTween.Y)})
	tween:Play() tween.Completed:Wait()

	CF:Destroy()
end

ItemRemote.OnClientEvent:Connect(function(item, tier, condition, LootItem)
	if condition == "Found" and LootItem then
		PopUp(LootItem, LootItem["Image"], LootItem["DisplayName"], "Found") -- Found Loot Item
	elseif condition == "Found" and item then
		PopUp(item, MI[item][tier].Image, MI[item][tier].Name, "Found") -- Found Event Item
	elseif condition == "Bought" then
		if tier > 1 then
			PopUp(item, MI[item][tier].Image, MI[item][tier].Name, "Upgraded to") -- Purchased an Upgrade
		else
			PopUp(item, MI[item][tier].Image, MI[item][tier].Name, "Purchased") -- Purchased an Item from the Shop
		end
	end
end)
local Spin = game.ReplicatedStorage.Remotes.Spin
local Spin2 = game.ReplicatedStorage.Remotes.Spin2
local Reset = game.ReplicatedStorage.Remotes.Reset

--Spin2.OnServerEvent:Connect(function(player, robux)
--	Spin2:FireClient(player, robux)
--end)

Reset.OnServerEvent:Connect(function(Player,ResetType)
	local ResetFunction = require(game.ReplicatedStorage.Modules.Reset.Reset)
	if ResetType == "Stats" then
		ResetFunction:Stats(Player) 
	elseif ResetType == "Fame" then
		ResetFunction:Fame(Player) 
	end
end)

local MarketplaceService = game:GetService("MarketplaceService")
local CommonSpinId = 196151730
local UncommonSpinId = 393139062
local RareSpinId = 393139523
local StatPointsId = 343741493
local FameId = 343741349
local SpinsId = 
	{
		["Commons"] = 196151730,
		["Uncommons"] = 393139062,
		["Rares"] = 393139523,
-----------------------------------
		[196151730] = "Commons",
		[393139062] = "Uncommons",
		[393139523] = "Rares"
	}

MarketplaceService.ProcessReceipt = function(receipt)
	for i, player in ipairs(game.Players:GetChildren()) do
		if player.userId == receipt.PlayerId then
			local coro = coroutine.wrap(function()
				if receipt.ProductId == CommonSpinId then
					Spin:FireClient(player, "Common")
				elseif receipt.ProductId == UncommonSpinId then
					Spin:FireClient(player, "Uncommon")
				elseif receipt.ProductId == RareSpinId then
					Spin:FireClient(player, "Rare")
				elseif receipt.ProductId == FameId then
					local fame = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Fame
					fame.Value = 0
				elseif receipt.ProductId == StatPointsId then
					workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).StatPoints.Value = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Level.Value * 3
					workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Strength.Value = 1
					workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Agility.Value = 1
					workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Durability.Value = 1
					
					if player.Character then player.Character.Humanoid.MaxHealth = 255 end
				end
			end)
			coro()
		end
	end
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
local SpinnerSignal = script:WaitForChild("Spinner")
local RarityIndex = require(Modules:WaitForChild("SpinData"))
local SpinInfo = require(Modules:WaitForChild("Spin"))

function NewValue(Player, Rarity, robux) -- the verfication and math of the new quirk.
	local QuirkRarity
	local RareChance = math.random(1, 100)
	local PlayData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
	local SpinMutlipler = 0
	if Rarity == "Uncommons" then -- increases the chances of a legendary by 1% so it equals 2%
		SpinMutlipler = 1
	elseif Rarity == "Rares" then
		SpinMutlipler = 4 -- increases the chances of a legendary by 4% so it equals 5% Trying to keep with the trello data
	end 
	if RareChance > 99-(PlayData.RareMultiplier.Value+SpinMutlipler) then -- this takes the base 1% and lowers the number needed for a legendary by the SpinMutlipler and RareMultiplier 
		QuirkRarity = "Legendaries"
	elseif RareChance > 96-(PlayData.RareMultiplier.Value+SpinMutlipler)*3  or Rarity == "Rares" then -- does the same thing as the legend check only with a buff for rares. All in line with the trello.
		QuirkRarity = "Rares"
	elseif RareChance > 80 or Rarity == "Uncommons" then -- gives them a uncommin if they get above a 20 or auto gives it to them if it was a uncommon spin.
		QuirkRarity = "Uncommons"
	else
		QuirkRarity = "Commons"
	end
	local NumberQuirk 
	--local SpinFunction = require(game.ReplicatedStorage.Modules.QuirkSpin.CashSpin)
	local Quirk = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk
	local Cash  = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
	
	local function SpinQuirk()
		NumberQuirk = math.random(1, #RarityIndex[QuirkRarity])
		if RarityIndex[QuirkRarity][NumberQuirk] == Quirk.Value then
			SpinQuirk()
		end
	end
	SpinQuirk()
	
	if Cash.Value >= 5000 and Rarity == "Commons" and robux ~= true then -- checknig the type of spin and price of spin then substracting the amount before giving them the quirk.
		Cash.Value -= 5000
		Quirk.Value = RarityIndex[QuirkRarity][NumberQuirk]
	elseif Cash.Value >= 100000 and Rarity == "Uncommons" and robux ~= true then
		Cash.Value -= 100000
		Quirk.Value = RarityIndex[QuirkRarity][NumberQuirk]
	elseif Cash.Value >= 1000000 and Rarity == "Rares" and robux ~= true then
		Cash.Value -= 1000000
		Quirk.Value = RarityIndex[QuirkRarity][NumberQuirk]
	elseif robux then
		if Rarity == "Commons" or Rarity == "Uncommons" or Rarity == "Rares" then
			MarketplaceService:PromptProductPurchase(Player, SpinsId[Rarity])
			local hold = {false, false}
			MarketplaceService.PromptProductPurchaseFinished:Connect(function(player, assetId, isPurchased)
				if player == Player.UserId and isPurchased then
					if SpinsId[assetId] then
						hold[1] = true
						hold[2] = true
					end
				elseif player == Player.UserId then 
					if SpinsId[assetId]then
						hold[1] = true
					end
				end
			end)
			repeat wait(0.1) until hold[1]
			if hold[2] then
				Quirk.Value = RarityIndex[QuirkRarity][NumberQuirk]
			else
				return
			end	
		end
	end
	
	task.delay(4, function() -- letting the reload happen after the spin animation has finished.
		if not (Player.Character and Player.Character.PrimaryPart) then return end
		
		local cf = Player.Character.PrimaryPart.CFrame
		Player:LoadCharacter()
		task.wait(.1)
		Player.Character.PrimaryPart.CFrame = cf
	end)
	
	return RarityIndex[QuirkRarity][NumberQuirk]
end

SpinnerSignal.OnServerInvoke = NewValue
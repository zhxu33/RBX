local Spin = game.ReplicatedStorage.Remotes.Spin
local Reset = game.ReplicatedStorage.Remotes.Reset

Spin.OnServerEvent:Connect(function(Player,SpinType)
	local SpinFunction = require(game.ReplicatedStorage.Modules.QuirkSpin.CashSpin)
	if SpinType == "CommonSpin" then
	SpinFunction:CommonSpin(Player) 
	elseif SpinType == "UncommonSpin" then
	SpinFunction:UncommonSpin(Player) 
	elseif SpinType == "RareSpin" then
	SpinFunction:RareSpin(Player) 
	end
end)

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

MarketplaceService.ProcessReceipt = function(receipt)
	for i, player in ipairs(game.Players:GetChildren()) do
	if player.userId == receipt.PlayerId then
	local coro = coroutine.wrap(function()
	if receipt.ProductId == CommonSpinId then
	local SpinFunction = require(game.ReplicatedStorage.Modules.QuirkSpin.RobuxSpin)
	SpinFunction:CommonSpin(player)
	elseif receipt.ProductId == UncommonSpinId then
	local SpinFunction = require(game.ReplicatedStorage.Modules.QuirkSpin.RobuxSpin)
	SpinFunction:UncommonSpin(player)
	elseif receipt.ProductId == RareSpinId then
	local SpinFunction = require(game.ReplicatedStorage.Modules.QuirkSpin.RobuxSpin)
	SpinFunction:RareSpin(player)
	elseif receipt.ProductId == FameId then
	local fame = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Fame
	fame.Value = 0
	elseif receipt.ProductId == StatPointsId then
	workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).StatPoints.Value = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Level.Value * 3
	workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Strength.Value = 1
	workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Agility.Value = 1
	workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name).Durability.Value = 1
	end
	end)
	coro()
	end
	end
	return Enum.ProductPurchaseDecision.PurchaseGranted
end
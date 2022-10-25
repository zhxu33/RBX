local CodeEvent = game.ReplicatedStorage:WaitForChild("Code")
local DataStore = game:GetService("DataStoreService")
-- AllCodes: sh1ns0, ItsBearSpring, echoeyesonYT5K, 

CodeEvent.OnServerEvent:Connect(function(player,Code)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	if PlayerData and not PlayerData:FindFirstChild("RedeemingCode") then
	local RedeemingCode = Instance.new("NumberValue", PlayerData)
	RedeemingCode.Name = "RedeemingCode" 
	local plr = game.Players:FindFirstChild(player.Name)
	CodeEvent:FireClient(plr,"Redeeming...")
	local CodeDataStore = DataStore:GetDataStore(Code)
	if CodeDataStore:GetAsync("Code") == true then
		if CodeDataStore:GetAsync(player.UserId) == nil and CodeDataStore:GetAsync("Expired") == nil then
			local Cash = PlayerData:FindFirstChild("Cash")
			local CashReward = CodeDataStore:GetAsync("CashReward")
			CodeDataStore:SetAsync(player.UserId, true)
			Cash.Value = Cash.Value + CashReward
			CodeEvent:FireClient(plr, "Sucess! +"..CashReward.." cash")
		elseif CodeDataStore:GetAsync(player.UserId) ~= nil then
			CodeEvent:FireClient(plr,"Used!")
		elseif CodeDataStore:GetAsync("Expired") ~= nil then
			CodeEvent:FireClient(plr,"Expired!")
		end
	else
		CodeEvent:FireClient(plr,"Invalid!")
	end
	wait(1)
	CodeEvent:FireClient(plr,"")
	RedeemingCode:Destroy()
	end
end)
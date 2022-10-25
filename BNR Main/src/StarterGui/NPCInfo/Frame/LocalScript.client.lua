local RS = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Frame = script.Parent
local NPCModule = require(script.Parent.NPCDex)

function FindNPCInfo(Name)
	for a,b in pairs(NPCModule.NPCs) do
		if b.Info.CheckName == Name then
			return true
		end
	end
end

RS.RenderStepped:connect(function()
	local t = Mouse.Target
	if t and t.Parent:FindFirstChild("Humanoid") and t.Parent.Parent.Name == "NPCs" and Player.Character:FindFirstChild("NPCInfo") then
		Frame.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
		local FNI = FindNPCInfo(t.Parent.Name)
		local Name = script.Parent.NPCName
		local Health = script.Parent.NPCInfo.CurrentHealth
		local Cash = script.Parent.RewardsInfo.Cash
		local EXP = script.Parent.RewardsInfo.EXP
		local Fame = script.Parent.RewardsInfo.Fame
		if FNI then
			local CurrentHealth = t.Parent:FindFirstChild("Humanoid").Health/10
			local MaxHealth = t.Parent:FindFirstChild("Humanoid").MaxHealth/10
			local NameValue = NPCModule.NPCs[t.Parent.Name].Info.GuiName
			local CashValue = NPCModule.NPCs[t.Parent.Name].Rewards.Cash
			local EXPValue = NPCModule.NPCs[t.Parent.Name].Rewards.EXP
			local FameValue = NPCModule.NPCs[t.Parent.Name].Rewards.Fame
			
			Name.Text = NameValue
			Health.Text = CurrentHealth.."/"..MaxHealth
			if CashValue ~= nil then
				Cash.Text = "Cash: " .. tostring(NPCModule.NPCs[t.Parent.Name].Rewards.Cash)
			else
				Cash.Text = "Cash: None"
			end
			if EXPValue ~= nil then
				EXP.Text = "EXP: " .. tostring(NPCModule.NPCs[t.Parent.Name].Rewards.EXP)
			else
				Cash.Text = "EXP: None"
			end
			if FameValue ~= nil then
				Fame.Text = "Fame: " .. tostring(NPCModule.NPCs[t.Parent.Name].Rewards.Fame)
			else
				Cash.Text = "Fame: None"
			end
		end
	end
	Frame.Visible = t 
		and 
		t.Parent:FindFirstChild("Humanoid") 
		and 
		t.Parent.Parent.Name == "NPCs" and Player.Character:FindFirstChild("NPCInfo")
		and
		(Player.Character.HumanoidRootPart.Position-t.Parent.HumanoidRootPart.Position).magnitude < 100
end)

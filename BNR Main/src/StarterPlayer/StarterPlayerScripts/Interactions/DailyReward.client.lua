local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local Cancel = NPCResponses:WaitForChild("Cancel")
local Continue = NPCResponses:WaitForChild("Continue")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Nezu"):WaitForChild("Interact")
local Interacted2 = workspace:WaitForChild("InteractionNPCS"):WaitForChild("Kurogiri"):WaitForChild("Interact")
local DailyRewardEvent = game.ReplicatedStorage.DailyCash
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(player.Name)
repeat wait() until PlayerData:FindFirstChild("Loaded")
local Fame = PlayerData.Fame

function ResetGui()
InteractGui.Enabled = false
Response.Text = ""
NPCName.Text = ""
end



Interacted.MouseClick:Connect(function()
	if InteractGui.Enabled == false and Fame.Value > 0 then
		InteractGui.Enabled = true
		NPCName.Text = "Nezu"
		local fullmsg = tostring("Hello would you like to cash out your fame? 1 fame = 1 Cash.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		local clicked = false 
		wait(1)
		local Canceled 
		Canceled = Cancel.MouseButton1Click:Connect(function()
			if clicked == false then
			clicked = true
			Canceled:Disconnect()
			Response.Text = ""
			local fullmsg = tostring("Alright come back when you're ready.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
			wait(1)
			ResetGui()
			end
		end)
		local Continued
	 	Continued = Continue.MouseButton1Click:Connect(function()
		if clicked == false then
		clicked = true
		Continued:Disconnect()
		DailyRewardEvent:FireServer()
		Response.Text = ""
		local Event
		Event = DailyRewardEvent.OnClientEvent:Connect(function(Reward, NoReward)
			Event:Disconnect()
			if NoReward then
			local fullmsg = "You already claimed your cash, please come again back in "..Reward.."."
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
			else
			local fullmsg = "You have been rewarded "..Reward.." Cash, come back in 24 hours!"
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		end
		wait(2)
		ResetGui()
		end)
		end
		end)
		end
end)

Interacted2.MouseClick:Connect(function()
	if InteractGui.Enabled == false and Fame.Value < 0 then
		InteractGui.Enabled = true
		NPCName.Text = "Kurogiri"
		local fullmsg = tostring("Hello would you like to cash out your fame? -1 fame = 1 Cash.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		local clicked = false 
		wait(1)
		local Canceled 
		Canceled = Cancel.MouseButton1Click:Connect(function()
			if clicked == false then
			clicked = true
			Canceled:Disconnect()
			Response.Text = ""
			local fullmsg = tostring("Alright come back when you're ready.")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
			wait(1)
			ResetGui()
			end
		end)
		local Continued
	 	Continued = Continue.MouseButton1Click:Connect(function()
		if clicked == false then
		clicked = true
		Continued:Disconnect()
		DailyRewardEvent:FireServer()
		Response.Text = ""
		local Event
		Event = DailyRewardEvent.OnClientEvent:Connect(function(Reward, Minutes)
			Event:Disconnect()
			if Minutes then
			local fullmsg = "You already claimed your cash, please come again back in "..Reward.."."
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
			else
			local fullmsg = "You have been rewarded "..Reward.." Cash, come back in 24 hours!"
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		end
		wait(2)
		ResetGui()
		end)
		end
		end)
		end
end)
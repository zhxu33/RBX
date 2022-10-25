local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local Cancel = NPCResponses:WaitForChild("Cancel")
local Continue = NPCResponses:WaitForChild("Continue")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Tester"):WaitForChild("Interact")
local TesterTeleportRemote = game.ReplicatedStorage.LobbyRemotes:WaitForChild("TesterTeleport")
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(player.Name)
local Level = PlayerData:FindFirstChild("Level")

function ResetGui()
InteractGui.Enabled = false
Response.Text = ""
NPCName.Text = ""
end

Interacted.MouseClick:Connect(function()
	if InteractGui.Enabled == false and player:GetRankInGroup(3755220) >= 7 then
		InteractGui.Enabled = true
		NPCName.Text = "Tester"
		local fullmsg = tostring("Would you like to go to test lobby?")
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
			ResetGui()
			end
		end)
		local Continued
	 	Continued = Continue.MouseButton1Click:Connect(function()
		if clicked == false then
		clicked = true
		Continued:Disconnect()
		TesterTeleportRemote:FireServer()
		Response.Text = ""
		local fullmsg
		if Level.Value >= 1000 then
		fullmsg = tostring("Teleporting...")
		else
		fullmsg = tostring("Low level!")
		end
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		end)
	end
end)

if player:GetRankInGroup(3755220) < 7 then
	Interacted.Parent:Destroy()
end
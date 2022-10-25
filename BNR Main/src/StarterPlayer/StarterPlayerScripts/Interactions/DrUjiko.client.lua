local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local Cancel = NPCResponses:WaitForChild("Cancel")
local Continue = NPCResponses:WaitForChild("Continue")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Interact =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("DrUjiko"):WaitForChild("Interact")
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local Quirk = PlayerData:WaitForChild("Quirk")
local Level = PlayerData:WaitForChild("Level")
local Fame = PlayerData:WaitForChild("Fame")
local TomuraRemote = game.ReplicatedStorage.Quirk.TomuraAfo


function ResetGui()
InteractGui.Enabled = false
Response.Text = ""
NPCName.Text = ""
end

Interact.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
	InteractGui.Enabled = true
	NPCName.Text = "Dr. Ujiko"
		local fullmsg = tostring("Are you worthy of inhering the power of All For One? You will need Decay + level 5,000 and -50,000 fame.")
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
			local fullmsg = tostring("Come back if you change your mind...")
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
		Response.Text = ""
		if Level.Value >= 5000 and Quirk.Value == 26 and Fame.Value <= -50000 then
		local fullmsg = tostring("I expect great things from you...")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		TomuraRemote:FireServer()
		else
		local fullmsg = tostring("You're unworthy of this power...")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		wait(1)
		ResetGui()
		end
		end
		end)
	end
end)
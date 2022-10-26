local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local Interact =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("Deku"):WaitForChild("Interact")
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local Quirk = PlayerData:WaitForChild("Quirk")
local Level = PlayerData:WaitForChild("Level")
local Fame = PlayerData:WaitForChild("Fame")
local DekuRemote = game.ReplicatedStorage.Quirk.DekuOfa
local InteractGui
local Response
local NPCName

function ResetGui()
	InteractGui.Enabled = false
	Response.Text = ""
	NPCName.Text = ""
end

Interact.MouseClick:Connect(function()
	InteractGui = gui:WaitForChild("InteractGui")
	local NPCResponses = InteractGui:WaitForChild("NPCResponses")
	Response = NPCResponses:WaitForChild("Response")
	local Cancel = NPCResponses:WaitForChild("Cancel")
	local Continue = NPCResponses:WaitForChild("Continue")
	NPCName = NPCResponses:WaitForChild("NPCName")
	if InteractGui.Enabled == false then
		InteractGui.Enabled = true
		NPCName.Text = "Deku"
		local fullmsg = tostring("Hey there! I'm Midoriya. Are you here to inherit my abilities? You will need Quirkless + level 5,000 and 50,000 fame.")
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
				local fullmsg = tostring("Oh, alright. See you later!")
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
				if Level.Value >= 5000 and Quirk.Value == 3 and Fame.Value >= 50000 then
					local fullmsg = tostring("Alright! Here you go, train on and become the greatest!")
					for i = 1, fullmsg:len() do
						game:GetService("RunService").RenderStepped:wait()
						Response.Text = Response.Text .. fullmsg:sub(i,i)
					end
					wait(1)
					ResetGui()
					DekuRemote:FireServer()
				else
					local fullmsg = tostring("Sorry, but you do not meet my requirements. Keep training! Maybe you will inherit these abilities one day!")
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
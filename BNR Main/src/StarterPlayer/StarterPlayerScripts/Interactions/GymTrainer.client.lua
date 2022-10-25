local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local Cancel = NPCResponses:WaitForChild("Cancel")
local Continue = NPCResponses:WaitForChild("Continue")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("GymTrainer"):WaitForChild("Interact")
local PremiumGymId = 4746076

function ResetGui()
InteractGui.Enabled = false
Response.Text = ""
NPCName.Text = ""
end

Interacted.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
		InteractGui.Enabled = true
		NPCName.Text = "Gym Trainer"
			local fullmsg = tostring("Hello, you can gain experience in the gym by hitting the punching bags. Are you interested in the premium gym pass for more experience? If so, I have it, but it'll cost you.")
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
			local fullmsg = tostring("Have fun training.")
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
		game:GetService("MarketplaceService"):PromptGamePassPurchase(player, PremiumGymId)
		ResetGui()
		end
		end)
		end
end)
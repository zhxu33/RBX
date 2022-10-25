local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local Cancel = NPCResponses:WaitForChild("Cancel")
local Continue = NPCResponses:WaitForChild("Continue")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Interacted =  workspace:WaitForChild("InteractionNPCS"):WaitForChild("TheDealer"):WaitForChild("Interact")
local HalloweenShop = gui:WaitForChild("HalloweenShop")
local PremiumGymId = 4746076

function ResetGui()
InteractGui.Enabled = false
Response.Text = ""
NPCName.Text = ""
end

Interacted.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
		InteractGui.Enabled = true
		NPCName.Text = "The Dealer"
		local fullmsg = tostring("What do you want? (Continue - Make a deal, Cancel - Event Details)")
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
			local fullmsg = tostring("The Dead have been disturbed. They are taking over, slowly but surely.")
			for i = 1, fullmsg:len() do
				game:GetService("RunService").RenderStepped:wait()
				Response.Text = Response.Text .. fullmsg:sub(i,i)
			end
			wait(2)
			Response.Text = ""
			local fullmsg = tostring("If you want a chance to survive, I suggest you Raid the core of the problem all at once.")
			for i = 1, fullmsg:len() do
				game:GetService("RunService").RenderStepped:wait()
				Response.Text = Response.Text .. fullmsg:sub(i,i)
			end
			wait(2)
			Response.Text = ""
			local fullmsg = tostring("Even if you fail, try and collect some Cursed Tokens from your enemies. I will gladly take them in exchange for some items from my inventory.")
			for i = 1, fullmsg:len() do
				game:GetService("RunService").RenderStepped:wait()
				Response.Text = Response.Text .. fullmsg:sub(i,i)
			end
			wait(2)
			ResetGui()
			end
		end)
		local Continued
	 	Continued = Continue.MouseButton1Click:Connect(function()
		if clicked == false then
		clicked = true
		Continued:Disconnect()
		HalloweenShop.Enabled = true
		ResetGui()
		end
		end)
		end
end)
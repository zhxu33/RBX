local CommonSpinInteract = workspace:WaitForChild("InteractionNPCS"):WaitForChild("Doctor"):WaitForChild("Interact")
local UncommonSpinInteract = workspace:WaitForChild("InteractionNPCS"):WaitForChild("Doctor2"):WaitForChild("Interact")
local RareSpinInteract = workspace:WaitForChild("InteractionNPCS"):WaitForChild("Doctor3"):WaitForChild("Interact")
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local InteractGui = gui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")
local NPCName = NPCResponses:WaitForChild("NPCName")
local Cancel = NPCResponses:WaitForChild("Cancel")
local SpinCash = NPCResponses:WaitForChild("Continue")
local SpinRobux = NPCResponses:WaitForChild("SpinRobux")
local CommonSpinId = 196151730
local UncommonSpinId = 393139062
local RareSpinId = 393139523
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
local Cash = PlayerData:WaitForChild("Cash")
local Quirk = PlayerData:WaitForChild("Quirk")
local Spin = game.ReplicatedStorage.Remotes:WaitForChild("Spin")

function ResetGui()
InteractGui.Enabled = false
SpinRobux.Visible = false
Response.TextColor3 = Color3.new(255,255,255)
Response.Text = ""
NPCName.Text = ""
end

CommonSpinInteract.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
	InteractGui.Enabled = true
	SpinRobux.Visible = true
	NPCName.Text = "Doctor Jennifer"
	local spinCost = 5000
	Response.Text = ""
		local fullmsg = tostring("Hello would you like to change your quirk for "..spinCost.." cash?")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
	local clicked = false 
	wait(1)
	local Canceled 
	local RobuxSpin
	local CashSpin
	Canceled = Cancel.MouseButton1Click:Connect(function()
			if clicked == false then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			ResetGui()
			end
	end)
	RobuxSpin = SpinRobux.MouseButton1Click:Connect(function()
		if clicked == false then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			game:GetService("MarketplaceService"):PromptProductPurchase(player, CommonSpinId)
			ResetGui()
			end
	end)
	CashSpin = SpinCash.MouseButton1Click:Connect(function()
		if clicked == false and NPCName.Text == "Doctor Jennifer" then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			Spin:FireServer("CommonSpin")
	if Cash.Value < spinCost then
		Response.Text = ""
		local fullmsg = "Sorry you don't enough cash. Would you like to buy with robux instead?"
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		game:GetService("MarketplaceService"):PromptProductPurchase(player, CommonSpinId)
		ResetGui()
		end
		end
	end)
	end
end)

UncommonSpinInteract.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
	InteractGui.Enabled = true
	SpinRobux.Visible = true
	NPCName.Text = "Doctor Daniel"
	local spinCost = 100000
	Response.Text = ""
		local fullmsg = tostring("Hello would you like to spend 100000 cash to purchase an uncommon quirk spin?")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
	local clicked = false 
	wait(1)
	local Canceled 
	local RobuxSpin
	local CashSpin
	Canceled = Cancel.MouseButton1Click:Connect(function()
			if clicked == false then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			ResetGui()
			end
	end)
	RobuxSpin = SpinRobux.MouseButton1Click:Connect(function()
		if clicked == false then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			game:GetService("MarketplaceService"):PromptProductPurchase(player, UncommonSpinId)
			ResetGui()
			end
	end)
	CashSpin = SpinCash.MouseButton1Click:Connect(function()
		if clicked == false and NPCName.Text == "Doctor Daniel" then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			Spin:FireServer("UncommonSpin")
	if Cash.Value < spinCost then
		Response.Text = ""
		local fullmsg = "Sorry not enough cash. Would you like to buy with robux instead?"
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		game:GetService("MarketplaceService"):PromptProductPurchase(player, UncommonSpinId)
		ResetGui()
		end
		end
	end)
	end
end)

RareSpinInteract.MouseClick:Connect(function()
	if InteractGui.Enabled == false then
	InteractGui.Enabled = true
	SpinRobux.Visible = true
	NPCName.Text = "Doctor William"
	local spinCost = 1000000
	Response.Text = ""
		local fullmsg = tostring("Hello would you like to spend 1000000 cash to purchase a rare quirk spin?")
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
	local clicked = false 
	wait(1)
	local Canceled 
	local CashSpin
	local RobuxSpin
	Canceled = Cancel.MouseButton1Click:Connect(function()
			if clicked == false then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			ResetGui()
			end
	end)
	RobuxSpin = SpinRobux.MouseButton1Click:Connect(function()
		if clicked == false then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			game:GetService("MarketplaceService"):PromptProductPurchase(player, RareSpinId)
			ResetGui()
			end
	end)
	CashSpin = SpinCash.MouseButton1Click:Connect(function()
		if clicked == false and NPCName.Text == "Doctor William" then
			clicked = true
			RobuxSpin:Disconnect()
			CashSpin:Disconnect()
			Canceled:Disconnect()
			Spin:FireServer("RareSpin")
	if Cash.Value < spinCost then
		Response.Text = ""
		local fullmsg = "Sorry not enough cash. Would you like to buy with robux instead?"
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
		end
		game:GetService("MarketplaceService"):PromptProductPurchase(player, RareSpinId)
		ResetGui()
		end
		end
	end)
	end
end)

Spin.OnClientEvent:Connect(function()
	InteractGui.Enabled = true
	Response.Text = ""
	for i=1, 20 do
		wait(0.1)
		local random = math.random(0,33)
		if random == 0 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Engine"
			elseif random == 1 then
			Response.TextColor3 = Color3.new(255,0,0)
			Response.Text = "Half Hot Half Cold"
			elseif random == 2 then
			Response.TextColor3 = Color3.new(255,0,0)
			Response.Text = "One For All"
			elseif random == 3 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Quirkless"
			elseif random == 4 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Zero Gravity"
			elseif random == 5 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Regeneration"
			elseif random == 6 then
			Response.TextColor3 = Color3.new(255,0,0)
			Response.Text = "Explosion"
			elseif random == 7 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Electrification"
			elseif random == 8 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Warp Gate"
			elseif random == 9 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Gigantification"
			elseif random == 10 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Voice"
			elseif random == 11 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Air Propulsion"
			elseif random == 12 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Shock Absorption"
			elseif random == 13 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Hardening"
			elseif random == 14 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Hellflame"
			elseif random == 15 then
			Response.TextColor3 = Color3.new(255,0,0)
			Response.Text = "Overhaul"
			elseif random == 16 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Jet"
			elseif random == 17 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Blackhole"
			elseif random == 18 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Cremation"
			elseif random == 19 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Dark Shadow"
			elseif random == 20 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Muscle Augmentation"
			elseif random == 21 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Permeation"
			elseif random == 22 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Pop Off"
			elseif random == 23 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Somnambulist"
			elseif random == 24 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Navel Laser"
			elseif random == 25 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Decay"
			elseif random == 26 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Acid"
			elseif random == 27 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Creation"
			elseif random == 28 then
			Response.TextColor3 = Color3.new(0,255,0)
			Response.Text = "Clones"
			elseif random == 29 then
			Response.TextColor3 = Color3.new(255,0,0)
			Response.Text = "All For One"
			elseif random == 30 then
			Response.TextColor3 = Color3.new(255,255,255)
			Response.Text = "Tail"
			elseif random == 31 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Frog"
			elseif random == 32 then
			Response.TextColor3 = Color3.new(255,0,0)
			Response.Text = "Fierce Wings"
			elseif random == 33 then
			Response.TextColor3 = Color3.new(255,255,0)
			Response.Text = "Orcinus"
		end
	end
			Response.TextColor3 = Color3.new(255,255,255)
	Response.Text = ""
	local fullmsg = "Your Quirk is..."
		for i = 1, fullmsg:len() do
			game:GetService("RunService").RenderStepped:wait()
			Response.Text = Response.Text .. fullmsg:sub(i,i)
			end
	wait(1)
	if Quirk.Value == 0 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Engine"
		elseif Quirk.Value == 1 then
		Response.TextColor3 = Color3.new(255,0,0)
		Response.Text = "Half Hot Half Cold"
		elseif Quirk.Value == 2 then
		Response.TextColor3 = Color3.new(255,0,0)
		Response.Text = "One for All."
		elseif Quirk.Value == 3 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Quirkless."
		elseif Quirk.Value == 4 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Zero Gravity."
		elseif Quirk.Value == 5 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Regeneration."
		elseif Quirk.Value == 6 then
		Response.TextColor3 = Color3.new(255,0,0)
		Response.Text = "Explosion"
		elseif Quirk.Value == 7 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Electrification"
		elseif Quirk.Value == 8 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Warp Gate"
		elseif Quirk.Value == 9 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Gigantification"
		elseif Quirk.Value == 10 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Voice"
		elseif Quirk.Value == 11 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Air Propulsion"
		elseif Quirk.Value == 12 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Shock Absorption"
		elseif Quirk.Value == 14 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Hardening"
		elseif Quirk.Value == 15 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Hellflame"
		elseif Quirk.Value == 16 then
		Response.TextColor3 = Color3.new(255,0,0)
		Response.Text = "Overhaul"
		elseif Quirk.Value == 17 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Jet"
		elseif Quirk.Value == 18 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Blackhole"
		elseif Quirk.Value == 19 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Cremation"
		elseif Quirk.Value == 20 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Dark Shadow"
		elseif Quirk.Value == 21 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Muscle Augmentation"
		elseif Quirk.Value == 22 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Permeation"
		elseif Quirk.Value == 23 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Pop Off"
		elseif Quirk.Value == 24 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Somnambulist"
		elseif Quirk.Value == 25 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Navel Laser"
		elseif Quirk.Value == 26 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Decay"
		elseif Quirk.Value == 27 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Acid"
		elseif Quirk.Value == 28 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Creation"
		elseif Quirk.Value == 29 then
		Response.TextColor3 = Color3.new(0,255,0)
		Response.Text = "Clones"
		elseif Quirk.Value == 30 then
		Response.TextColor3 = Color3.new(255,0,0)
		Response.Text = "All For One"
		elseif Quirk.Value == 31 then
		Response.TextColor3 = Color3.new(255,255,255)
		Response.Text = "Tail"
		elseif Quirk.Value == 32 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Frog"
		elseif Quirk.Value == 33 then
		Response.TextColor3 = Color3.new(255,0,0)
		Response.Text = "Fierce Wings"
		elseif Quirk.Value == 35 then
		Response.TextColor3 = Color3.new(255,255,0)
		Response.Text = "Orcinus"
		end
		wait(.5)
		Response.TextColor3 = Color3.new(255,255,255)
		ResetGui()
end)
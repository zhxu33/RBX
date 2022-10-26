local Cooldown = false
local HeroFrame = script.Parent:WaitForChild("HeroTitleFrame")
local VillainFrame = script.Parent:WaitForChild("VillainTitleFrame")
local HeroButtons = HeroFrame:GetDescendants()
local VillainButtons = VillainFrame:GetDescendants()
local Submit = script.Parent:WaitForChild("CustomTitleSelectFrame"):WaitForChild("SubmitButtonFrame"):WaitForChild("TextButton")
local WhyDumbDonateImage = script.Parent.Parent:WaitForChild("Options"):WaitForChild("DonateImage")
local WhyDumbCodesImage = script.Parent.Parent:WaitForChild("Options"):WaitForChild("CodesImage")
local FameTitleRemote = game.ReplicatedStorage:WaitForChild("FameTitle")
local MarketPlaceService = game:GetService("MarketplaceService")
local textbox = script.Parent:WaitForChild("CustomTitleSelectFrame"):WaitForChild("EnterTitle")
local leftC = script.Parent.Parent:WaitForChild("clickleft")
local rightC = script.Parent.Parent:WaitForChild("clickright")
local CustomTitlePassId = 20555542
local gui = script.Parent
local GuiFocus = gui.Parent:WaitForChild("ActiveGui")
local OptionsM = gui.Parent:WaitForChild("Options")
local player = game.Players.LocalPlayer
if not player then wait() 
	player = game.Players.LocalPlayer
end
local CurrentFtitle = player:FindFirstChild("FameTitle")
if CurrentFtitle == nil then wait() CurrentFtitle = player:FindFirstChild("FameTitle") end

CurrentFtitle:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent:WaitForChild("CurrentTitleFrame"):WaitForChild("CurrentTitle").Text = "[ "..CurrentFtitle.Value.." ]"
end)

local openbutton = script.Parent.Parent:WaitForChild("Options"):WaitForChild("FameTitlesFrame"):WaitForChild("TextButton")
openbutton.MouseButton1Click:Connect(function()
	if GuiFocus.Value == OptionsM then
		gui.Visible = true
		leftC.Visible = false
		rightC.Visible = false
		WhyDumbCodesImage.ZIndex = 1
		WhyDumbDonateImage.ZIndex = 1
		gui:TweenSizeAndPosition(UDim2.new(0.324, 0,0.577, 0),UDim2.new(0.322, 0,0.163, 0),"Out","Back",0.4)
	end
end)

for i, child in ipairs(HeroButtons) do
	if child:IsA("TextButton") then
		child.MouseButton1Click:Connect(function()
			if Cooldown == false then -- Pass any data from hero titles here / fire an event
				local titleName = child.Text
				local colour = child.TextColor3
				FameTitleRemote:FireServer("Hero", titleName)
			elseif Cooldown and child.Text ~= "10 second cooldown!" and child.Text ~= "Title Changed!" then
				local orign = child.Text
				child.Text = "10 second cooldown!"
				wait(1)
				child.Text = orign
			end
		end)
	end
end

for i, child in ipairs(VillainButtons) do
	if child:IsA("TextButton") then
		child.MouseButton1Click:Connect(function()
			if Cooldown == false then -- Pass any data from villain titles here / fire an event
				local titleName = child.Text
				local colour = child.TextColor3
				FameTitleRemote:FireServer("Villain", titleName)
			elseif Cooldown and child.Text ~= "10 second cooldown!" and child.Text ~= "Title Changed!" then
				local orign = child.Text
				child.Text = "10 second cooldown!"
				wait(1)
				child.Text = orign 
			end
		end)
	end
end

FameTitleRemote.OnClientEvent:Connect(function(msg, title, bool, custom)
	if custom == nil then
		if not Cooldown then
			Cooldown = true
			if bool then -- Meets Requirements
				for i, buttons in ipairs(HeroButtons) do
					if buttons:IsA("TextButton") then
						if buttons.Name == title then
							local orign = buttons.Text
							buttons.Text = msg
							wait(2)
							buttons.Text = orign
							CurrentFtitle.Value = title
						end
					end
				end
				for i, buttons2 in ipairs(VillainButtons) do
					if buttons2:IsA("TextButton") then
						if buttons2.Text == title then
							local orign = buttons2.Text
							buttons2.Text = msg
							wait(2)
							buttons2.Text = orign
							CurrentFtitle.Value = title
						end
					end
				end
			elseif not bool then  -- Doesn't Meet Requirements
				for i, buttons in ipairs(HeroButtons) do
					if buttons:IsA("TextButton") then
						if buttons.Name == title then
							local orign = buttons.Text
							buttons.Text = msg
							wait(2)
							buttons.Text = orign
						end
					end
				end
				for i, buttons2 in ipairs(VillainButtons) do
					if buttons2:IsA("TextButton") then
						if buttons2.Text == title then
							local orign = buttons2.Text
							buttons2.Text = msg
							wait(2)
							buttons2.Text = orign
						end
					end
				end
			end
			wait(8)
			Cooldown = false
		end
	elseif custom ~= nil then
		local requestedTitle = script.Parent:WaitForChild("RequestedFrame"):WaitForChild("RequestedTitle")
		if msg == "Title Requested! (Wait up to 24 hours for approval)" then
			requestedTitle.Text = "[ "..title.." ]"
			textbox.Text = msg 
			wait(2)
			textbox.Text = ""
		elseif msg == "HTTP 403 (Forbidden)" then
			textbox.Text = msg
			wait(2)
			textbox.Text = "If you see this message, please request your title via our social media platform, or a message a Developer."
			wait(4)
			textbox.Text = ""
		else
			textbox.Text = msg
			wait(2)
			textbox.Text = ""
		end
	end
end)

script.Parent:WaitForChild("CustomTitleSelectFrame").SubmitButtonFrame.TextButton.MouseButton1Down:Connect(function()
	Submit.Parent.ImageColor3 = Color3.fromRGB(0, 150, 120)
end)

Submit.MouseButton1Up:Connect(function()
	Submit.Parent.ImageColor3 = Color3.fromRGB(0, 184, 148)
	if MarketPlaceService:UserOwnsGamePassAsync(player.UserId, CustomTitlePassId) or player:GetRankInGroup(3755220) > 12 then
		if Cooldown == false then
			FameTitleRemote:FireServer("Custom", textbox.Text)
		else
			textbox.Text = "10 second cooldown!"
			wait(10)
			textbox.Text = ""
		end
	else
		game:GetService("MarketplaceService"):PromptGamePassPurchase(player, CustomTitlePassId)
	end
end)

local closeButton = script.Parent:WaitForChild("CloseButton")
closeButton.MouseButton1Click:Connect(function()
	WhyDumbDonateImage.ZIndex = 2
	WhyDumbCodesImage.ZIndex = 2
	leftC.Visible = true
	rightC.Visible = true
	gui:TweenSizeAndPosition(UDim2.new(0.011, 0,0.019, 0),UDim2.new(0.489, 0,0.482, 0),"Out","Quint",0.4)
	wait(0.3)
	gui.Visible = false
end)
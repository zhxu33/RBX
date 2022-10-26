local connection
local restriction
local AcceptImage = script.Parent.AcceptButton
local AcceptButton = AcceptImage.Button
local WarnMessage = script.Parent.TextFrame.WarningMessage

local count = 15
local Active = false

local Popup1UDIM = UDim2.fromScale(0.5, 0.4)
local Popup2UDIM = UDim2.fromScale(0.5, 0.5)
local PopupCloseUDIM = UDim2.fromScale(0.5, 1.25)

local PlayerModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

local function PopUp()
	local tween =  game.TweenService:Create(script.Parent, TweenInfo.new(1), {Position = Popup1UDIM})
	tween:Play()
	tween.Completed:Wait()
	tween = game.TweenService:Create(script.Parent, TweenInfo.new(0.25), {Position = Popup2UDIM})
	tween:Play()
	tween.Completed:Wait()
end

local function LockKeyService(character)
	coroutine.wrap(function()
		local find = false
		repeat
			for v,parts in pairs(character:GetDescendants()) do
				if parts:IsA("LocalScript") and (parts.Name == "KeyService" or parts.Name == "MobileService") then
					find = true
				end
			end
			wait()
		until find
		for v,parts in pairs(character:GetDescendants()) do
			if parts:IsA("LocalScript") and (parts.Name == "KeyService" or parts.Name == "MobileService") then
				coroutine.wrap(function()
					parts.Disabled = true
					repeat game:GetService("RunService").Heartbeat:Wait() until connection ~= nil
					AcceptButton.MouseButton1Click:Wait()
					parts.Disabled = false
				end)()
			end
		end
	end)()
end

game.ReplicatedStorage.Warning.OnClientEvent:Connect(function(Message)
	WarnMessage.Text = Message
	if not Active then
		Active = true
		Controls:Disable()
		LockKeyService(game.Players.LocalPlayer.Character)
		restriction = game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
			LockKeyService(character)
		end)
		AcceptButton.Text = tostring(count)
		AcceptImage.ImageColor3 = Color3.new(255, 0, 0)
		count = 15
		game.Lighting.WarningBlur.Enabled = true
		local tween = game.TweenService:Create(game.Lighting.WarningBlur, TweenInfo.new(1), {Size = 20})
		tween:Play()
		tween.Completed:Wait()
		PopUp()
		AcceptImage.ImageColor3 = Color3.new(255, 0, 0)
		AcceptButton.Text = tostring(count)
		repeat
			wait(1)
			count = count - 1
			if count ~= 0 then AcceptButton.Text = tostring(count) end
		until count == 0
		AcceptImage.ImageColor3 = Color3.new(0, 170, 0)
		AcceptButton.Text = "Continue"
		connection = AcceptButton.MouseButton1Click:Connect(function()
			connection:Disconnect()
			restriction:Disconnect()
			Controls:Enable()
			game.ReplicatedStorage.AcceptWarn:FireServer()
			local tween = game.TweenService:Create(script.Parent, TweenInfo.new(1), {Position = PopupCloseUDIM})
			tween:Play()
			tween.Completed:Wait()
			tween = game.TweenService:Create(game.Lighting.WarningBlur, TweenInfo.new(1), {Size = 0})
			tween:Play()
			tween.Completed:Wait()
			game.Lighting.WarningBlur.Enabled = false
			AcceptImage.ImageColor3 = Color3.new(255, 0, 0)
			AcceptButton.Text = ""
			WarnMessage.Text = ""
			Active = false
		end)
	end
end)
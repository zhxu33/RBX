local WarnFunction = game.ReplicatedStorage.Warning
local WarnFeedback = game.ReplicatedStorage.WarnFeedback

local NameInput = script.Parent.NameInput
local WarningMessage = script.Parent.Warning
local SendWarn = script.Parent.SendWarning
local FeedbackMessage = script.Parent.WarningFeedback

script.Parent.Info.MouseEnter:Connect(function()
	script.Parent.InfoWindow.Visible = true
end)
script.Parent.Info.MouseLeave:Connect(function()
	script.Parent.InfoWindow.Visible = false
end)

local Warning = false
local FeedbackReturned = false

WarningMessage:GetPropertyChangedSignal("Text"):Connect(function()
	if WarningMessage.ClearTextOnFocus == true and not Warning then
		WarningMessage.ClearTextOnFocus = false
		WarningMessage.TextTransparency = 0
		WarningMessage.TextStrokeTransparency = 0
		WarningMessage.FocusLost:Wait()
		if WarningMessage.Text == "" or WarningMessage.Text == " " then
			WarningMessage.Text = "Insert Warning Message"
			WarningMessage.TextTransparency = 0.7
			WarningMessage.TextStrokeTransparency = 1
			WarningMessage.ClearTextOnFocus = true
		end
	end
end)

NameInput:GetPropertyChangedSignal("Text"):Connect(function()
	if NameInput.ClearTextOnFocus == true and not Warning then
		NameInput.ClearTextOnFocus = false
		NameInput.TextTransparency = 0
		NameInput.TextStrokeTransparency = 0
		NameInput.FocusLost:Wait()
		if NameInput.Text == "" or NameInput.Text == " " then
			NameInput.Text = "Insert Name"
			NameInput.TextTransparency = 0.7
			NameInput.TextStrokeTransparency = 1
			NameInput.ClearTextOnFocus = true
		end
	end
end)

SendWarn.MouseButton1Click:Connect(function()
	if not Warning then
		Warning = true
		SendWarn.Border.ImageTransparency = 0.5
		SendWarn.TextTransparency = 0.5
		NameInput.TextEditable = false
		WarningMessage.TextEditable = false
		coroutine.wrap(function()
			repeat
				if not FeedbackReturned then
					FeedbackMessage.Text = "Processing."
					wait(0.2)
				end
				if not FeedbackReturned then
					FeedbackMessage.Text = "Processing.."
					wait(0.2)
				end
				if not FeedbackReturned then
					FeedbackMessage.Text = "Processing..."
					wait(0.2)
				end
			until FeedbackReturned
		end)()
		local UserID
		local success = pcall(function() UserID = game.Players:GetUserIdFromNameAsync(NameInput.Text) end)
		if success and WarningMessage.Text ~= "" then
			WarnFunction:FireServer(UserID, tostring(WarningMessage.Text))
		else
			WarningMessage.Text = "Insert Warning Message"
			NameInput.Text = "Insert Name"
			WarningMessage.ClearTextOnFocus = true
			NameInput.ClearTextOnFocus = true
			WarningMessage.TextTransparency = 0.7
			WarningMessage.TextStrokeTransparency = 1
			NameInput.TextTransparency = 0.7
			NameInput.TextStrokeTransparency = 1
			FeedbackMessage.TextColor3 = Color3.fromRGB(200, 0, 0)
			FeedbackMessage.Text = "This user does not exist."
			FeedbackMessage.TextTransparency = 0
			FeedbackReturned = true
			wait(2)
			NameInput.TextEditable = true
			WarningMessage.TextEditable = true
			FeedbackMessage.Text = ""
			FeedbackMessage.TextTransparency = 1
			FeedbackMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
			Warning = false
			FeedbackReturned = false
			SendWarn.Border.ImageTransparency = 0
			SendWarn.TextTransparency = 0
		end
	end
end)

WarnFeedback.OnClientEvent:Connect(function(returned, errormessage)
	if returned == true then
		FeedbackReturned = true
		FeedbackMessage.Text = "Successfully warned: " .. NameInput.Text
		FeedbackMessage.TextTransparency = 0
		WarningMessage.Text = "Insert Warning Message"
		NameInput.Text = "Insert Name"
		WarningMessage.ClearTextOnFocus = true
		NameInput.ClearTextOnFocus = true
		WarningMessage.TextTransparency = 0.7
		WarningMessage.TextStrokeTransparency = 1
		NameInput.TextTransparency = 0.7
		NameInput.TextStrokeTransparency = 1
		wait(2)
		NameInput.TextEditable = true
		WarningMessage.TextEditable = true
		FeedbackMessage.Text = ""
		FeedbackMessage.TextTransparency = 1
		FeedbackReturned = false
		Warning = false
		SendWarn.Border.ImageTransparency = 0
		SendWarn.TextTransparency = 0
	else
		FeedbackReturned = true
		FeedbackMessage.TextColor3 = Color3.fromRGB(200, 0, 0)
		FeedbackMessage.Text = "Failure to warn: " .. NameInput.Text .. ", Reason: " .. errormessage
		FeedbackMessage.TextTransparency = 0
		WarningMessage.Text = "Insert Warning Message"
		NameInput.Text = "Insert Name"
		WarningMessage.TextTransparency = 0.7
		WarningMessage.TextStrokeTransparency = 1
		WarningMessage.ClearTextOnFocus = true
		NameInput.ClearTextOnFocus = true
		NameInput.TextTransparency = 0.7
		NameInput.TextStrokeTransparency = 1
		wait(2)
		NameInput.TextEditable = true
		WarningMessage.TextEditable = true
		FeedbackMessage.Text = ""
		FeedbackMessage.TextTransparency = 1
		FeedbackMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
		FeedbackReturned = false
		Warning = false
		SendWarn.Border.ImageTransparency = 0
		SendWarn.TextTransparency = 0
	end
end)
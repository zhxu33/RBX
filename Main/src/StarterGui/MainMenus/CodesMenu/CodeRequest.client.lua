local player = game.Players.LocalPlayer

-- Remote and Variables
local CodeRemote = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Code")
local Connection
local Running = false
local Cooldown = false

-- Sounds
local GUI_Sounds = player:WaitForChild("PlayerGui"):WaitForChild("GUI_Sounds")

local Click_Sound = GUI_Sounds:WaitForChild("ClickSound")
local Success_Sound = GUI_Sounds:WaitForChild("PurchaseSuccess")
local Fail_Sound = GUI_Sounds:WaitForChild("PurchaseFail")

-- Menu Instances
local CodesMenu = script.Parent
local ConfirmButton = CodesMenu:WaitForChild("Confirm")
local EnterCode = CodesMenu:WaitForChild("EnterCode")
local Result = CodesMenu:WaitForChild("Result")
local Open = script.Parent.Parent:WaitForChild("Options"):WaitForChild("CodesImage"):WaitForChild("TextButton")
local leftC = script.Parent.Parent:WaitForChild("clickleft")
local rightC = script.Parent.Parent:WaitForChild("clickright")
local WhyDumbDonateImage = script.Parent.Parent:WaitForChild("Options"):WaitForChild("DonateImage")
local WhyDumbCodesImage = script.Parent.Parent:WaitForChild("Options"):WaitForChild("CodesImage")
local CloseButton = script.Parent:WaitForChild("CloseButton")
local OptionsM = script.Parent.Parent:WaitForChild("Options")
local FameM = script.Parent.Parent:WaitForChild("FameTitlesFrame")

Open.MouseButton1Click:Connect(function()
	if CodesMenu.Parent.ActiveGui.Value == OptionsM and FameM.Visible == false then
		CodesMenu.Visible = true
		leftC.Visible = false
		rightC.Visible = false
		WhyDumbDonateImage.ZIndex = 1
		WhyDumbCodesImage.ZIndex = 1
		CodesMenu:TweenSizeAndPosition(UDim2.new(0.324, 0,0.577, 0),UDim2.new(0.322, 0,0.163, 0),"Out","Back",0.4)
	end	
end)

CloseButton.MouseButton1Click:Connect(function()
	WhyDumbDonateImage.ZIndex = 2
	WhyDumbCodesImage.ZIndex = 2
	leftC.Visible = true
	rightC.Visible = true
	CodesMenu:TweenSizeAndPosition(UDim2.new(0.011, 0,0.019, 0),UDim2.new(0.489, 0,0.482, 0),"Out","Quint",0.4)
	wait(0.3)
	CodesMenu.Visible = false
end)


local FilteredWords = { -- Filtered so people don't make a mistake and request the wrong string text unintentionally.
	["Enter Code"] = true,
	[""] = true,
	[" "] = true,
	["  "] = true,
	["   "] = true,
}

local function CW(t) -- Condition Wait, if the Running variable is set to false, it'll stop waiting.
	local a = 0
	local d = t or 0
	repeat
		a = a + game:GetService("RunService").Heartbeat:Wait()
	until a >= d or not Running
	return a
end

local function Outputted(Output)
	Running = false
	Result.Text = Output
	wait(1.5)
	Result.Text = ""
	EnterCode.Text = "Enter Code"
	Cooldown = false
end

ConfirmButton.MouseButton1Click:Connect(function()
	Click_Sound:Play()

	if FilteredWords[EnterCode.Text] or Running or Cooldown then return end
	Cooldown = true

	if Connection ~= nil then Connection:Disconnect() end
	Connection = CodeRemote.OnClientEvent:Connect(function(Output, Success)
		Connection:Disconnect()
		if Success then
			Success_Sound:Play()
		else
			Fail_Sound:Play()
		end
		Outputted(Output)
	end)
	CodeRemote:FireServer(EnterCode.Text)

	Running = true
	local Timeout = 5
	coroutine.wrap(function()
		repeat
			Timeout = Timeout - 1
			wait(1)
		until Timeout == 0
	end)()
	repeat
		Result.Text = "Redeeming."
		CW(.5)
		if not Running then return end
		Result.Text = "Redeeming.."
		CW(.5)
		if not Running then return end
		Result.Text = "Redeeming..."
		CW(.5)
		if not Running then return end
	until not Running or Timeout <= 0
	if Running then
		if Connection ~= nil then Connection:Disconnect() end
		Outputted("Error while redeeming code, try again.")
	end

end)
local Player 				= game.Players.LocalPlayer
local ReplicatedStorage		= game:GetService("ReplicatedStorage")
local TweenService			= game:GetService("TweenService")
local RunService			= game:GetService("RunService")

local GUI					= script.Parent
local CooldownRemote		= ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CooldownRemote")
local CooldownIcon 			= GUI:WaitForChild("Assets"):WaitForChild("CooldownIcon")
local IconContainer			= GUI:WaitForChild("Container")

local IconTable = {}
local IconData = {
	
	Tween_Playing = nil,
	Tween_TargettedIcon = nil,
	
	SpawnLocation 			= UDim2.fromScale(1.1, .3),
	TweenTo 				= UDim2.fromScale(.9, .3),
	DefaultY				= .3,
	ListingDifferenceY		= 1.5, --.11,
	
	General_TweenTime		= .1,
	Appear_TweenTime		= .25,
	Disappear_TweenTime		= .25,
	
	MoveDown_TweenTime		= .1,
	UpdateAL_TweenTime		= .1,
	
	FullName_Appear			= .1,
	
	DefaultColor			= Color3.fromRGB(253, 203, 110)
	
}

local function TypeWriter(Text, Message, Direction)
	local newMsg = Message:split("")

	if Direction then
		Text.Text = ""
		for i = #newMsg, 0, -1 do
			Text.Text = (newMsg[i] or "") .. Text.Text
			task.wait(IconData["FullName_Appear"]/#newMsg)
		end
	else
		local prevMsg = Text.Text:split("")

		local cache = {}
		local str   = ""

		for i = #prevMsg, 1, -1 do
			str = prevMsg[i] .. str
			cache[i] = str
		end
		cache[#cache + 1] = ""

		for i = 1, #cache do
			Text.Text = cache[i]
			task.wait(IconData["FullName_Appear"]/#newMsg)
		end
	end
end

-- // Converts a UDim to scale
local function OffsetToScale(Udim : UDim2)
	local screenSize = script.Parent.AbsoluteSize
	local extraScale = UDim2.fromScale(Udim.X.Offset / screenSize.X, Udim.Y.Offset / screenSize.Y)

	return (UDim2.fromScale(Udim.X.Scale, Udim.Y.Scale) + extraScale)
end

local function CooldownBind(Icon, Time)
	return Icon.Percent.Changed:Connect(function()
		local currentPercent = Icon.Percent.Value
		Icon.Cooldown.Text = ("%." .. (((1-currentPercent)*Time) > 10 and 0 or 1) .. "fs"):format((1-currentPercent)*Time)
		if currentPercent < .5 then
			Icon.RightFrame.FillMeter.Visible = true
			Icon.LeftFrame.FillMeter.UIGradient.Rotation  = 0 -- // When resetting
			Icon.RightFrame.FillMeter.UIGradient.Rotation = -180+(360 * currentPercent) -- // From 0 to 180
			return
		end
		Icon.RightFrame.FillMeter.Visible = false
		Icon.RightFrame.FillMeter.UIGradient.Rotation = 0
		Icon.LeftFrame.FillMeter.UIGradient.Rotation  = (-180 + (360 * currentPercent)) -- // From 0 to 180 

		--if currentPercent < 1 then return end
		--TweenService:Create(Icon.LeftFrame.FillMeter, TweenInfo.new(.2), {ImageTransparency = 1}):Play()
		--local tween = TweenService:Create(Icon.RightFrame.FillMeter, TweenInfo.new(.2), {ImageTransparency = 1})
		--tween:Play()
		--tween.Completed:Wait()
	end)
end

local function IconTransparency(Icon, Time, Amount)
	local Tween
	Tween = TweenService:Create(Icon, TweenInfo.new(Time), {ImageTransparency = Amount}) Tween:Play()
	TweenService:Create(Icon.LeftFrame.FillMeter, TweenInfo.new(Time), {ImageTransparency = Amount}):Play()
	TweenService:Create(Icon.RightFrame.FillMeter, TweenInfo.new(Time), {ImageTransparency = Amount}):Play()
	TweenService:Create(Icon.MoveName, TweenInfo.new(Time), {TextTransparency = Amount, TextStrokeTransparency = Amount}):Play()
	TweenService:Create(Icon.Cooldown, TweenInfo.new(Time), {TextTransparency = Amount, TextStrokeTransparency = Amount}):Play()
	return Tween
end

local function MoveDown()
	for i=1,#IconTable do
		TweenService:Create(IconTable[i], TweenInfo.new(IconData["MoveDown_TweenTime"], Enum.EasingStyle.Linear), {Position = OffsetToScale(UDim2.new(IconData.TweenTo.X.Scale, 0, IconTable[i].Position.Y.Scale, IconData["ListingDifferenceY"] * IconTable[i].AbsoluteSize.Y))}):Play()--		IconTable[i].Position = UDim2.fromScale(IconTable[i].Position.X.Scale, IconTable[i].Position.Y.Scale+IconData["ListingDifferenceY"])
	end
end

local function UpdateAlignment()
	
	local NewTable = {}
	local Iteration = 1
	for Index,Count in pairs(IconTable) do
		NewTable[Iteration] = Count
		Iteration += 1
	end
	IconTable = NewTable
	
	for i=1,#IconTable do
		TweenService:Create(IconTable[i], TweenInfo.new(IconData["UpdateAL_TweenTime"], Enum.EasingStyle.Linear), {Position = OffsetToScale(UDim2.new(IconData.TweenTo.X.Scale, 0, IconData["DefaultY"], ((IconData["ListingDifferenceY"]*IconTable[i].AbsoluteSize.Y) * (i-1))))}):Play()
	end
	
end

local function HoverBind(Icon, FullName)
	local currentThread
	return {
		Icon.MouseEnter:Connect(function()
			Icon.MoveName.Visible = false
			Icon.Cooldown.Visible = true
			if currentThread and coroutine.status(currentThread) == "suspended" then
				task.cancel(currentThread)
			end
			currentThread = task.spawn(TypeWriter, Icon.FullName, FullName, true)
		end),
		
		Icon.MouseLeave:Connect(function()
			Icon.Cooldown.Visible = false
			Icon.MoveName.Visible = true
			if currentThread and coroutine.status(currentThread) == "suspended" then
				task.cancel(currentThread)
			end
			currentThread = task.spawn(TypeWriter, Icon.FullName, FullName, false)
		end)
	}
end

local function CreateIcon(ButtonName : string, CooldownTime : number, FullName : string, CustomColor : Color3)
	if not GUI:GetAttribute("Enabled") then return end
	
	if IconData["Tween_Playing"] and IconData["Tween_Playing"].PlaybackState ~= Enum.TweenStatus.Completed then
		IconData["Tween_Playing"]:Cancel()
		IconData["Tween_TargettedIcon"].Position = UDim2.fromScale(IconData.TweenTo.X.Scale, IconData["Tween_TargettedIcon"].Position.Y.Scale)
	end
	
	local NewIcon = CooldownIcon:Clone()
	local Tween
	local PercentConnection, HoverConnection = CooldownBind(NewIcon, CooldownTime), HoverBind(NewIcon, FullName)
	local AlignmentCount = #IconTable+1
	
	NewIcon.Parent = IconContainer
	NewIcon.Visible = true
	NewIcon.Position = IconData["SpawnLocation"]

	NewIcon.MoveName.Text = tostring(ButtonName)
	
	NewIcon.LeftFrame.FillMeter.ImageColor3 = CustomColor or IconData["DefaultColor"]
	NewIcon.RightFrame.FillMeter.ImageColor3 = CustomColor or IconData["DefaultColor"]
	
	MoveDown()
	IconTable[AlignmentCount] = NewIcon
	
	IconData["Tween_TargettedIcon"] = NewIcon
	IconData["Tween_Playing"] = TweenService:Create(NewIcon, TweenInfo.new(IconData["General_TweenTime"]), {Position = IconData["TweenTo"]}) IconData["Tween_Playing"]:Play()
	TweenService:Create(NewIcon.Percent, TweenInfo.new(CooldownTime, Enum.EasingStyle.Linear), {Value = 1}):Play()
	
	IconTransparency(NewIcon, IconData["Appear_TweenTime"], 0)
	task.wait(CooldownTime)

	HoverConnection[1]:Disconnect() HoverConnection[2]:Disconnect()
	NewIcon.Cooldown.Visible = false
	NewIcon.FullName.Visible = false
	NewIcon.MoveName.Visible = true
	
	local newTween = TweenService:Create(NewIcon.Percent, TweenInfo.new(.4), {Value = 0})
	TweenService:Create(NewIcon.LeftFrame.FillMeter,  TweenInfo.new(.4), {ImageColor3 = Color3.fromRGB(145, 255, 145)}):Play()
	TweenService:Create(NewIcon.RightFrame.FillMeter, TweenInfo.new(.4), {ImageColor3 = Color3.fromRGB(145, 255, 145)}):Play()
	TweenService:Create(NewIcon.MoveName.UIGradient, TweenInfo.new(.4), {Offset = Vector2.new(0, -1)}):Play()
	
	newTween:Play()
	newTween.Completed:Wait()
	
	PercentConnection:Disconnect()
	
	table.remove(IconTable, table.find(IconTable, NewIcon))
	UpdateAlignment()
	
	--NewIcon.LeftFrame.FillMeter.UIGradient.Rotation  = 0
	--NewIcon.RightFrame.FillMeter.UIGradient.Rotation = -180
	--NewIcon.RightFrame.FillMeter.Visible = true
	--NewIcon.LeftFrame.FillMeter.ImageColor3 = Color3.fromRGB(0, 255, 0)
	--NewIcon.RightFrame.FillMeter.ImageColor3 = Color3.fromRGB(0, 255, 0)
	
	Tween = IconTransparency(NewIcon, IconData["Disappear_TweenTime"], 1)
	local s = NewIcon.Size
	TweenService:Create(NewIcon, TweenInfo.new(.4), {Size = UDim2.new(s.X.Scale * 1.5, s.X.Offset * 1.5, s.Y.Scale * 1.5, s.Y.Offset * 1.5)}):Play()
	Tween.Completed:Wait()
	NewIcon:Destroy()
	
end

CooldownRemote.OnClientEvent:Connect(CreateIcon)
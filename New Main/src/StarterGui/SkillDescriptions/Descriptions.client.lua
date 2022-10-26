-- // Services
local Replicated       = game:GetService("ReplicatedStorage")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- // Variables
local Player       = game.Players.LocalPlayer
local PlayerGui    = Player:WaitForChild("PlayerGui")
local PlayerData   = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData"):WaitForChild(Player.Name)
local Quirk        = PlayerData:WaitForChild("Quirk")

local defaultKeys  = {"Q", "Z", "X", "C", "V", "F"}
local skillsToKeys = {Skill1 = "Q", Skill2 = "Z", Skill3 = "X", Skill4 = "C", Skill5 = "V", Skill6 = "F",}
local keysToFrame  = {} -- ["Q"] = Frame
local tween        = nil
local connection   = nil

-- // Modules
local SkillDesc    = require(Replicated:WaitForChild("Modules"):WaitForChild("SkillDescriptions"))
local QuirkData    = require(Replicated:WaitForChild("Modules"):WaitForChild("QuirkData"))

-- // Gui Vars
local screenGui    = PlayerGui:WaitForChild("SkillDescriptions")
local display      = screenGui:WaitForChild("Display")
local description  = display:WaitForChild("Description")
local defaultFrame = display:WaitForChild("DefaultSkillFrame")

-- // Functions

-- // Destroys the currrent frames
local function DestroyFrames()
	for _, frame in pairs(keysToFrame) do
		frame:Destroy()
	end
	
	table.clear(keysToFrame)
end

-- // Cancels the tween if it exists
local function CancelTween(tween)
	if not (tween) then return end
	tween:Cancel()
end

-- // Removes connection if it exists
local function Disconnect(connection)
	if connection and connection.Connected then connection:Disconnect() end
end

-- // Hides the frame
local function HideScreen()
	CancelTween(tween)
	tween = TweenService:Create(display, TweenInfo.new(.25), {AnchorPoint = Vector2.new(.5, 1)})
	tween:Play()

	return tween
end

-- // Shows the frame
local function ShowScreen()
	CancelTween(tween)
	tween = TweenService:Create(display, TweenInfo.new(.25), {AnchorPoint = Vector2.new(.5, 0)})
	tween:Play()
	
	return tween
end

-- // Creates an info list for all moves of a quirk
local function CreateFrameDescriptions(quirk, info)
	if not (info and quirk) then return end
	HideScreen().Completed:Wait()
	DestroyFrames()
	
	local order = 3
	
	description.Skills.Text = ("%s Skills \n [Click anywhere to hide]"):format(quirk)
	
	for index, value in pairs(info) do
		if value == "" then continue end
		local skillName = (skillsToKeys[index] or index)
		local newTemp   = defaultFrame:Clone()
		
		newTemp.SkillLetter.Text = skillName
		newTemp.Name = "Key" .. skillName
		newTemp.LayoutOrder = order + (table.find(defaultKeys, skillName) or #defaultKeys + 1)
		
		newTemp.Skills.Text = value
		newTemp.Parent      = defaultFrame.Parent
		newTemp.Visible     = true
		
		keysToFrame[skillName] = newTemp
	end
	
	Disconnect(connection)
	connection = UserInputService.InputBegan:Connect(function(inputObject : InputObject)
		if not (inputObject.UserInputType == Enum.UserInputType.Touch or inputObject.UserInputType == Enum.UserInputType.MouseButton1) then return end
		Disconnect(connection)
		HideScreen()
	end)
	
	ShowScreen()
end

-- // Quirk changed
Quirk:GetPropertyChangedSignal("Value"):Connect(function()
	task.wait(3)
	
	local descriptions = SkillDesc[Quirk.Value]
	local quirkName    = QuirkData.QuirkNum[Quirk.Value].Name
	CreateFrameDescriptions(quirkName, descriptions)
end)

HideScreen()
local player = game.Players.LocalPlayer
if not player then wait()
	player = game.Players.LocalPlayer
end

local Replicated = game:GetService("ReplicatedStorage")
local OtherMods  = Replicated:WaitForChild("OtherModules")
local HoverDesc  = require(OtherMods:WaitForChild("HoverEffects"))

local Parent      = script.Parent
local OpenButton  = Parent:WaitForChild("OpenButton").TextButton  
local SoundButton = Parent:WaitForChild("SoundButton") 
local SaveButton  = Parent:WaitForChild("SaveButton") 
local PVPB        = Parent:WaitForChild("PVPButton") 
local PlayerGui   = player:WaitForChild("PlayerGui")
PlayerGui:WaitForChild("IntroGui")
if PlayerGui.IntroGui.Menu.Visible then
	PlayerGui.IntroGui.Menu:GetPropertyChangedSignal("Visible"):Wait()
end

Parent.Enabled = true
local QuirkLabel    = Parent:WaitForChild("playerstats"):WaitForChild("display"):WaitForChild("quirk")
local PlayerData    = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(player.Name)
local Fame          = PlayerData:WaitForChild("Fame")
local Experience    = PlayerData:WaitForChild("Experience")
local ExpMultiplier = PlayerData:WaitForChild("ExpMultiplier")
local Cash          = PlayerData:WaitForChild("Cash")
local Level         = PlayerData:WaitForChild("Level")
local Quirk         = PlayerData:WaitForChild("Quirk")
local CashLabel     = Parent:WaitForChild("playerstats"):WaitForChild("display"):WaitForChild("cash")
local FameLabel     = Parent:WaitForChild("playerstats"):WaitForChild("display"):WaitForChild("fame")
local LevelLabel    = Parent:WaitForChild("playerstats"):WaitForChild("Levelframe"):WaitForChild("TextLabel")

local levelFormat = "Lv. %d"
local cashFormat  = "Cash: $%d"
local fameFormat  = "Fame: %.0f"
local quirkFormat = "Quirk: %s"

local Character = player.Character or player.CharacterAdded:Wait()
local Stamina
local MaxStamina

player.CharacterAdded:Connect(function(char)
	Character = char
	Character:GetAttributeChangedSignal("Stamina"):Wait()
	Stamina    = Character:GetAttribute("Stamina")
	MaxStamina = Character:GetAttribute("MaxStamina")
end)

local MaxExp       = 400*Level.Value/2/ExpMultiplier.Value
local QuirkChanged = Replicated.Remotes:WaitForChild("QuirkChanged")
local expBar       = script.Parent:WaitForChild("playerstats"):WaitForChild("exp")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local TI = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0)
local Connection
local Tween

local newDesc = HoverDesc.new(expBar)
newDesc:UpdateDescriptionColor(Color3.fromRGB(253, 203, 110))

 --- pvp button variables
local PVPDebounce = false
local PvpEvent = Replicated:WaitForChild("PVP")
local PvpConnection

local QuirkList = {
	[0] = "Engine",
	[1] = "HHHC",
	[2] = "OFA",
	[3] = "Quirkless",
	[4] = "Zero Gravity",
	[5] = "Regeneration",
	[6] = "Explosion",
	[7] = "Electrification",
	[8] = "Warp Gate",
	[9] = "Gigantification",
	[10] = "Voice",
	[11] = "Air Propulsion",
	[12] = "Shock Absorption",
	[13] = "Deku's OFA",
	[14] = "Hardening",
	[15] = "Hellflame",
	[16] = "Overhaul",
	[17] = "Jet",
	[18] = "Blackhole",
	[19] = "Cremation",
	[20] = "Dark Shadow",
	[21] = "Muscle Augmentation",
	[22] = "Permeation",
	[23] = "Pop Off",
	[24] = "Somnambulist",
	[25] = "Navel Laser",
	[26] = "Decay",
	[27] = "Acid",
	[28] = "Creation",
	[29] = "Clones",
	[30] = "AFO",
	[31] = "Tail",
	[32] = "Frog",
	[33] = "Fierce Wings",
	[34] = "Tomura's AFO",
	[35] = "Orcinus",
	[36] = "Manifest",
	[37] = "Big Fist",
}
local Quirk2 = QuirkList[Quirk.Value]

QuirkLabel.Text = string.format(quirkFormat, Quirk2)
LevelLabel.Text = string.format(levelFormat, Level.Value) 
CashLabel.Text  = string.format(cashFormat, Cash.Value) 
FameLabel.Text  = string.format(fameFormat, Fame.Value) 

local function round(number)
	return math.min(number - 0.001)
end

local prevExp          = (Experience.Value / MaxExp) -- // previous tweened experience
local prevTween        = nil
local expTweenDuration = 2 -- // total time it takes from 0% to 100%
local function updateEXP2()
	if prevTween then prevTween:Cancel() end
	
	local percent  = math.clamp(Experience.Value / MaxExp, 0, 1)
	local duration = expTweenDuration * math.abs(percent - prevExp)
	prevTween = TweenService:Create(expBar.UIGradient, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Offset = Vector2.new(0, (1 - percent))})
	prevTween:Play()
	
	if Experience.Value >= MaxExp then
		MaxExp = 400*Level.Value/2/ExpMultiplier.Value
	end
	newDesc:UpdateDescription(("EXP: %d / %d"):format(Experience.Value, MaxExp))
	newDesc:UpdateDescriptionColor((Color3.fromRGB(255, 145, 145):Lerp(Color3.fromRGB(145, 255, 145), percent)))
end

local function update()
	Quirk2 = QuirkList[Quirk.Value]
	
	QuirkLabel.Text = string.format(quirkFormat, Quirk2)
	LevelLabel.Text = string.format(levelFormat, Level.Value) 
	CashLabel.Text  = string.format(cashFormat, Cash.Value) 
	FameLabel.Text  = string.format(fameFormat, Fame.Value)
end

Experience:GetPropertyChangedSignal("Value"):Connect(updateEXP2)
Level:GetPropertyChangedSignal("Value"):Connect(function() 
	update()
	if PvpConnection and Level.Value >= 500 then
		PvpEvent:FireServer("Check")
	end
end)

Cash:GetPropertyChangedSignal("Value"):Connect(update)
Fame:GetPropertyChangedSignal("Value"):Connect(update)
Quirk:GetPropertyChangedSignal("Value"):Connect(update)

local baseNum = (Experience.Value/MaxExp)

if baseNum < 1 - 0.002 and baseNum > 0 + 0.001 then
	expBar.UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(baseNum - 0.001, 0),
		NumberSequenceKeypoint.new(baseNum, 1),
		NumberSequenceKeypoint.new(1, 1)})
elseif baseNum > 1 - 0.002 and Experience.Value >= MaxExp then
	expBar.UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,0),
		NumberSequenceKeypoint.new(1,0)})
	
elseif baseNum < 0 + 0.002 then
	expBar.UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,1),
		NumberSequenceKeypoint.new(1,1)})
end

update()

local toggled = false
local IntroGui = PlayerGui:WaitForChild("IntroGui")
local Menu = IntroGui:WaitForChild("Menu")
local musicList = Menu.Music:GetChildren()

SoundButton.MouseButton1Down:Connect(function()
	if toggled == false then
		toggled = true
		SoundButton.Image ="http://www.roblox.com/asset/?id=7142664301" 
		SoundButton.HoverImage = "http://www.roblox.com/asset/?id=7142664754"
		for i= 1, #musicList do
			local sounds = musicList[i]
			sounds.Volume = 0
		end
		
		Menu.Special.K21.Volume = 0
	elseif toggled == true then
		toggled = false
		SoundButton.Image = "http://www.roblox.com/asset/?id=7142526422"
		SoundButton.HoverImage = "http://www.roblox.com/asset/?id=7142526821"
		for i= 1, #musicList do
			local sounds = musicList[i]
			sounds.Volume = 0.25
		end
		
		Menu.Special.K21.Volume = 0.25
	end
end)

local save = game.ReplicatedStorage.Remotes.Save.ManualSave
local success = game.ReplicatedStorage.Remotes.Save.SaveSuccess
local failure = game.ReplicatedStorage.Remotes.Save.SaveFailed
local save_delay = false
local goodsave = false
SaveButton.MouseButton1Down:Connect(function()
	if not save_delay  and not goodsave then
		save_delay = true
		save:FireServer()
		success.OnClientEvent:Connect(function(player)
			SaveButton.Active = false
			local goal = {}
			goal.ImageTransparency = 1
			local info =  TweenInfo.new(1)
			local tween = TweenService:Create(SaveButton, info, goal)
			goodsave = true		
			tween:Play()
			wait(30)
			SaveButton.ImageColor3 = Color3.fromRGB(255,255,255)

			local goalReverse = {}
			goalReverse.ImageTransparency = 0
			local infoReverse =  TweenInfo.new(1)
			local tweenReverse = TweenService:Create(SaveButton, infoReverse, goalReverse)
			tweenReverse:Play()
			tweenReverse.Completed:Connect(function()
				goodsave = false
			end)
			SaveButton.Active = true
		end)
		wait(2)
		save_delay = false
	end
end)

success.OnClientEvent:Connect(function(player)
	local typer = require(game.ReplicatedStorage.Modules.TypeWriter)
	typer:Write(SaveButton.TextLabel, "Save successful!")
	SaveButton.ImageColor3 = Color3.fromRGB(0,140,0)
	wait(1)
	SaveButton.TextLabel.Text = ""
end)

failure.OnClientEvent:Connect(function(player)
	local typer = require(game.ReplicatedStorage.Modules.TypeWriter)
	typer:Write(SaveButton.TextLabel, "Save FAILED!")
	SaveButton.ImageColor3 = Color3.fromRGB(255,0,0)
	wait(1)
	SaveButton.TextLabel.Text = ""
end)

local debounce = false
OpenButton.MouseButton1Up:Connect(function()
	if debounce then return end
	debounce = not debounce
	
	local Button1 = script.Parent.MenuButton
	local Button2 = script.Parent.HelpButton
	local Button3 = script.Parent.SaveButton
	local Button4 = script.Parent.SoundButton
	local Button5 = script.Parent.MapButton
	local Button6 = script.Parent.PVPButton
	
	local Buttons = {Button1, Button2, Button3, Button4, Button5, Button6}
	
	local B1Location = UDim2.new(0.046, 0,0.223, 0)
	if Button1.Position == B1Location then
		for index = 1, #Buttons do
			local Button = Buttons[index]
			Button:TweenPosition(UDim2.new(-0.15, 0, Button.Position.Y.Scale, 0), "Out", "Quint", 0.7)
			task.wait(0.2)
		end
		
		task.wait(.5)
		for _, value in pairs(Buttons) do value.Visible = false end
	else
		for index = 1, #Buttons do
			local Button = Buttons[index]
			Button.Visible = true
			Button:TweenPosition(UDim2.new(0.046, 0, Button.Position.Y.Scale, 0), "Out", "Back", 0.7)
			task.wait(0.2)
		end
	end
	
	debounce = not debounce
end)

local StarterGUI = game:GetService("StarterGui")
local Backpack = player:WaitForChild("Backpack")
StarterGUI:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
Backpack.Changed:Connect(function(RequestedAction)
	if RequestedAction then
		if RequestedAction == "Name" then
			Backpack.Name = "Backpack"
		elseif RequestedAction == "Archivable" then
			Backpack.Archivable = true
		end
	end
end)
Backpack.ChildAdded:Connect(function(RequestedChild)
	repeat
		RequestedChild:Destroy()
		wait()
	until RequestedChild.Parent == nil
end)

 --=================== [ PVP SWITCH ] ===================--

PvpConnection = PVPB.Activated:Connect(function()
	if PVPDebounce then return end
	PVPDebounce = true
	PvpEvent:FireServer()
	task.wait(1)
	PVPDebounce = false
end)

PvpEvent.OnClientEvent:Connect(function(Info)
	if Info == "Close" then
		PVPB.Visible = false
		PvpConnection:Disconnect()
		task.wait(2) -- Honestly don't know why I'm putting a wait here
		PvpEvent:FireServer()
	elseif Info == "On" then
		PVPB.HoverImage = "http://www.roblox.com/asset/?id=7142820321"
		PVPB.Image = "http://www.roblox.com/asset/?id=7142817036"
	elseif Info == "Off" then
		PVPB.HoverImage = "http://www.roblox.com/asset/?id=7142876057"
		PVPB.Image = "http://www.roblox.com/asset/?id=7142875784"          
	end
end)
PvpEvent:FireServer("Check")

--=================== [ HOVER DESCRIPTIONS TEST ] ===================--
local Descriptions = {}
Descriptions.HelpButton  = "Help Info"
Descriptions.MapButton   = "Map"
Descriptions.MenuButton  = "Main Menu"
Descriptions.PVPButton   = "Toggle PVP"
Descriptions.SaveButton  = "Manual Save"
Descriptions.SoundButton = "Toggle Music"

for _, button in ipairs(Parent:GetChildren()) do
	if not (button:IsA("ImageButton")) then continue end
	local obj = HoverDesc.new(button, Descriptions[button.Name])
	obj:UpdateStrokeColor(Color3.fromRGB(253, 203, 110))
end
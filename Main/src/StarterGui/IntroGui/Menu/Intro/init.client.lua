--// 80% Rewritten by Art completely new main menu spinning

local Player      = game.Players.LocalPlayer
local Camera      = workspace.CurrentCamera
local PlayerGui   = Player:WaitForChild("PlayerGui")
local IntroGui    = PlayerGui:WaitForChild("IntroGui")
local IntroRemote = game.ReplicatedStorage:WaitForChild("Intro")
local Character   = Player.Character or Player.CharacterAdded:Wait()
local debounce    = false

wait()
----------------------
local Forcefield         = Instance.new("ForceField",Character)
Forcefield.Name          = "Intro"
local Menu               = IntroGui:WaitForChild("Menu")
local JoinPlayerFrame    = Menu:WaitForChild("JoinPlayerFrame")
local JoinPlayerButton   = JoinPlayerFrame:WaitForChild("JoinButton")
local JoinPlayerName     = JoinPlayerFrame:WaitForChild("PlayerName")
local QuirkSpinFrame     = Menu:WaitForChild("Frame")
local CashLabel          = QuirkSpinFrame:WaitForChild("Cash")
local QuirkLabel         = QuirkSpinFrame:WaitForChild("Quirk")
local CommonSpin         = QuirkSpinFrame:WaitForChild("CommonButton")
local UncommonSpin       = QuirkSpinFrame:WaitForChild("UncommonButton")
local RareSpin           = QuirkSpinFrame:WaitForChild("RareButton")
local CommonRobuxSpin    = QuirkSpinFrame:WaitForChild("CommonRobux")
local UncommonRobuxSpin  = QuirkSpinFrame:WaitForChild("UncommonRobux")
local RareRobuxSpin      = QuirkSpinFrame:WaitForChild("RareRobux")
local SpinnerUI          = QuirkSpinFrame:WaitForChild("spinUI")
local SpinRemote         = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Spin")
local SpinRemote2        = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Spin2")
local JoinPlayerRemote   = game.ReplicatedStorage:WaitForChild("JoinPlayer")
local sg                 = PlayerGui:WaitForChild("SaveGui")
local qg                 = PlayerGui:WaitForChild("QuestGui")
local StartButton        = Menu:WaitForChild("Center"):WaitForChild("StartButton")
local RS                 = game:GetService("ReplicatedStorage")
local Modules            = RS:WaitForChild("Modules")
local PlayerEvent        = RS:WaitForChild("Exp")
local toggled            = false
local musicList          = Menu.Music:GetChildren()
local SecretList         = Menu.SecretMusic:GetChildren()
local opList             = Menu.Openings:GetChildren()
local MarketPlaceService = game:GetService("MarketplaceService")
local SpinSystem         = require(script.Parent:WaitForChild("Frame"):WaitForChild("spinUI"):WaitForChild("ModuleScript"))
local cooldowns          = PlayerGui:WaitForChild("CooldownGui")
local PlayerDataHolder   = workspace:WaitForChild("S1c2R5i66p5t5s51")
local spinner            = PlayerDataHolder:WaitForChild("Spin"):WaitForChild("Spinner")
local TweenService       = game:GetService("TweenService")
----------------------
if Player:IsInGroup(3755220) and Player:GetRankInGroup(3755220) >= 11 then
	JoinPlayerFrame.Visible = true
end
if Player.Name == "Jeffycry65" then
	opList = {Menu.Special:WaitForChild("MC")}
end


IntroGui.Enabled = true
cooldowns.Enabled = false

Menu.Visible = true

local Opening
local opmusic = coroutine.wrap(function()
	local recent
	while true do
		if debounce == true then break end
		local shuffle = math.random(1, #opList)
		if recent ~= shuffle then
			recent = shuffle
			Opening = opList[shuffle]
			Opening:Play()
			repeat game:GetService("RunService").RenderStepped:Wait() until not Opening.Playing
			wait(1)
		end
	end
end)
opmusic()

game:GetService("StarterGui"):SetCore("ChatWindowPosition",UDim2.new(0.35,0,0,0))

local Cams = workspace.CameraCrap
local target = Cams.Spawn1
local angle = 0
local i = 0
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CameraSubject = target

------------------------- Intro Style ---------------------
local TweenService = game:GetService("TweenService")
local Lighting     = game:GetService("Lighting")

local ActiveTween = nil
local AllowTeen   = true
local IntroScreen = coroutine.wrap(function()
	Camera.CoordinateFrame = Cams.Spawn1.CFrame				
	--TweenService:Create(Lighting, TweenInfo.new(30, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {ClockTime = 7}):Play()

	local OnceTweens = 
		{
			[3] = TweenService:Create(Camera, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {CoordinateFrame = Cams.Spawn4.CFrame, FieldOfView = 80}),
			[2] = TweenService:Create(Camera, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {CoordinateFrame = Cams.Spawn3.CFrame, FieldOfView = 1}),
			[1] = TweenService:Create(Camera, TweenInfo.new(12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {CoordinateFrame = Cams.Spawn2.CFrame - Camera.CoordinateFrame.LookVector*20})	,
		}
	local RepeatTweens = 
		{
			[3] = TweenService:Create(Camera, TweenInfo.new(30, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {CoordinateFrame = Cams.Spawn7.CFrame}),
			[2] = TweenService:Create(Camera, TweenInfo.new(30, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {CoordinateFrame = Cams.Spawn6.CFrame}),
			[1] = TweenService:Create(Camera, TweenInfo.new(11, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CoordinateFrame = Cams.Spawn5.CFrame}),
		}
	for i=1, 3 do
		if not AllowTeen then return end
		ActiveTween = OnceTweens[i]
		ActiveTween:Play()
		ActiveTween.Completed:Wait()
	end
	while AllowTeen do
		for i=1, 3 do
			wait(5)
			if not AllowTeen then return end
			ActiveTween = RepeatTweens[i]
			ActiveTween:Play()
			ActiveTween.Completed:Wait()
		end
	end	
end)()

coroutine.wrap(function()
	repeat 
		local Sucess = pcall(function() 
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
		end) 
		wait(.1) 
	until Sucess
end)()

local MusicPlaying
function SoundTrack()
	local recent
	while true do
		if Player.Name == "Jeffycry65" then
			MusicPlaying = Menu.Special.K21
			MusicPlaying:Play()
			repeat game:GetService("RunService").RenderStepped:Wait() until not MusicPlaying.IsPlaying
			MusicPlaying = nil
		else
			local shuffle = math.random(1, #musicList)
			if shuffle ~= recent then
				local secretchance = math.random(1, 100)
				if secretchance ~= 1 then
					recent = shuffle
					MusicPlaying = musicList[shuffle]
					MusicPlaying:Play()
					repeat game:GetService("RunService").RenderStepped:Wait() until not MusicPlaying.IsPlaying
					MusicPlaying = nil
				else
					local SS = math.random(1, #SecretList)
					MusicPlaying = SecretList[SS]
					MusicPlaying:Play()
					repeat game:GetService("RunService").RenderStepped:Wait() until not MusicPlaying.IsPlaying
					MusicPlaying = nil
				end
			end
		end
	end
end

local PlayerData = workspace:WaitForChild("S1c2R5i66p5t5s51"):WaitForChild("PlayerData"):WaitForChild(Player.Name)
repeat wait() 
	StartButton.Text = "Loading"
	wait(.25)
	StartButton.Text = "Loading."
	wait(.25)
	StartButton.Text = "Loading.."
	wait(.25)
	StartButton.Text = "Loading..."
	wait(.25)
until PlayerData:FindFirstChild("Loaded")
StartButton.Text = "Start"

local spinning         = false
local Cash             = PlayerData:WaitForChild("Cash")
local Level            = PlayerData:WaitForChild("Level")
local Quirk            = PlayerData:WaitForChild("Quirk")
local CommonSpinId     = 196151730
local UncommonSpinId   = 393139062
local RareSpinId       = 393139523
local MythicTween
local MythicTweening   = false
local RainbowSelection = 1
local RainbowColors    = {Color3.fromRGB(255,0,230),Color3.fromRGB(49,254,1),Color3.fromRGB(227,255,26),Color3.fromRGB(255,92,3)}
local OtherButtons     = script.Parent.Parent:FindFirstChild("Button")
local remoteTeleport   = game:GetService("ReplicatedStorage"):WaitForChild("LobbyRemotes"):WaitForChild("Teleport")



CashLabel.Text = "Cash: $"..Cash.Value
local QData = require(Modules:WaitForChild("QuirkData"))
local quak = Quirk.Value
if QData.QuirkNum[quak]["Rarity"] == "Common" then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = QData.QuirkNum[quak]["Name"]
elseif QData.QuirkNum[quak]["Rarity"] == "Uncommon" then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = QData.QuirkNum[quak]["Name"]
elseif QData.QuirkNum[quak]["Rarity"] == "Rare" then
	QuirkLabel.TextColor3 = Color3.new(255,255,0) 
	QuirkLabel.Text = QData.QuirkNum[quak]["Name"]
elseif QData.QuirkNum[quak]["Rarity"] == "Legendary" then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = QData.QuirkNum[quak]["Name"]
elseif QData.QuirkNum[quak]["Rarity"] == "Mythic" then
	QuirkLabel.Text = QData.QuirkNum[quak]["Name"]
	MythicTweening = true
	coroutine.wrap(function()
		coroutine.wrap(function() 
			while game:GetService("RunService").RenderStepped:Wait() do 
				if not MythicTweening then 
					if MythicTween ~= nil then 
						MythicTween:Cancel()
						MythicTween = nil
						break 
					end
				end
			end 
		end)()
		while true do
			MythicTween = game.TweenService:Create(QuirkLabel, TweenInfo.new(0.8), {TextColor3 = RainbowColors[RainbowSelection]})
			MythicTween:Play()
			MythicTween.Completed:Wait()
			if not MythicTweening then
				break
			end
			if RainbowSelection < #RainbowColors then
				RainbowSelection = RainbowSelection + 1
			else
				RainbowSelection = 1
			end
		end
	end)()
end

local SData       = require(Modules:WaitForChild("Spin"))
local RarityIndex = require(Modules:WaitForChild("SpinData"))
local CText       = CommonSpin.TextLabel.Text
local UCText      = UncommonSpin.TextLabel.Text
local RText       = RareSpin.TextLabel.Text
local Confirm     = false
local ConfirmText = "Are you sure?"
local Confirming  = false
--local SpinFunction = require(Modules.QuirkSpin.CashSpin)
local getNumber   = require(script.number)

local function CommonSP(robux)
	if Menu.Visible == false then
		SpinRemote2:FireServer("Common", true)
		return
	end
	if not spinning then
		MythicTweening = false

		if Confirm and CommonSpin.TextLabel.Text == ConfirmText or robux == true then
			CommonSpin.TextLabel.Text = CText
			Confirm = false
			if Cash.Value >= 5000 or robux then
				spinning = true
				local NewQuirk = spinner:InvokeServer("Commons", robux)
				if not NewQuirk then return end
				NewSpinnerFunction(NewQuirk, "Commons")
				local NewQuirkData = SData[NewQuirk]
				local num = NewQuirkData
				local rarity = NewQuirkData.Rarity
				QuirkLabel.Text = NewQuirkData.Name
				if rarity == "Common" then
					QuirkLabel.TextColor3 = Color3.new(255,255,255)
				elseif rarity == "Uncommon" then
					QuirkLabel.TextColor3 = Color3.new(0,255,0)
				elseif rarity == "Rare" then
					QuirkLabel.TextColor3 = Color3.new(255,255,0) 
				elseif rarity == "Legendary" then
					QuirkLabel.TextColor3 = Color3.new(255,0,0)
				end
				spinning = false
			elseif Cash.Value < 5000 then
				CommonSpin.TextLabel.Text = "Not Enough Cash!"
				wait(1)
				CommonSpin.TextLabel.Text = CText
			end
		elseif not Confirm then
			CommonSpin.TextLabel.Text = ConfirmText
			Confirm = true
			wait(1.5)
			if CommonSpin.TextLabel.Text == ConfirmText then
				CommonSpin.TextLabel.Text = CText
			end
			Confirm = false
		end
	end
end

local function UncommonSP(robux)
	if Menu.Visible == false then
		SpinRemote2:FireServer("Uncommon", true)
		return
	end
	MythicTweening = false
	local GP = MarketPlaceService:UserOwnsGamePassAsync(Player.UserId,4920124)
	if Confirm and UncommonSpin.TextLabel.Text == ConfirmText or robux == true then
		UncommonSpin.TextLabel.Text = UCText
		Confirm = false
		if Cash.Value >= 100000 or robux then
			spinning = true
			local NewQuirk = spinner:InvokeServer("Uncommons", robux)
			if not NewQuirk then return end
			NewSpinnerFunction(NewQuirk, "Uncommons")
			local NewQuirkData = SData[NewQuirk]
			local num = NewQuirkData
			local rarity = NewQuirkData.Rarity
			QuirkLabel.Text = NewQuirkData.Name
			if rarity == "Common" then
				QuirkLabel.TextColor3 = Color3.new(255,255,255)
			elseif rarity == "Uncommon" then
				QuirkLabel.TextColor3 = Color3.new(0,255,0)
			elseif rarity == "Rare" then
				QuirkLabel.TextColor3 = Color3.new(255,255,0) 
			elseif rarity == "Legendary" then
				QuirkLabel.TextColor3 = Color3.new(255,0,0)
			end
			spinning = false
		elseif Cash.Value < 100000 then
			UncommonSpin.TextLabel.Text = "Not Enough Cash!"
			wait(1)
			UncommonSpin.TextLabel.Text = CText
		end
	elseif not Confirm then
		UncommonSpin.TextLabel.Text = ConfirmText
		Confirm = true
		wait(1.5)
		if UncommonSpin.TextLabel.Text == ConfirmText then
			UncommonSpin.TextLabel.Text = CText
		end
		Confirm = false
	end
end

local function RareSP(robux)
	if Menu.Visible == false then
		SpinRemote2:FireServer("Rare", true)
		return
	end
	MythicTweening = false
	local GP = MarketPlaceService:UserOwnsGamePassAsync(Player.UserId,4920124)
	if Confirm and RareSpin.TextLabel.Text == ConfirmText or robux == true then
		RareSpin.TextLabel.Text = RText
		Confirm = false
		if Cash.Value >= 1000000 or robux then
			spinning = true
			local NewQuirk = spinner:InvokeServer("Rares", robux)
			if not NewQuirk then return end
			NewSpinnerFunction(NewQuirk, "Rares")
			local NewQuirkData = SData[NewQuirk]
			local num = NewQuirkData
			local rarity = NewQuirkData.Rarity
			QuirkLabel.Text = NewQuirkData.Name
			if rarity == "Common" then
				QuirkLabel.TextColor3 = Color3.new(255,255,255)
			elseif rarity == "Uncommon" then
				QuirkLabel.TextColor3 = Color3.new(0,255,0)
			elseif rarity == "Rare" then
				QuirkLabel.TextColor3 = Color3.new(255,255,0) 
			elseif rarity == "Legendary" then
				QuirkLabel.TextColor3 = Color3.new(255,0,0)
			end
			spinning = false
		elseif Cash.Value < 1000000 then
			RareSpin.TextLabel.Text = "Not Enough Cash!"
			wait(1)
			RareSpin.TextLabel.Text = RText
		end
	elseif not Confirm then
		RareSpin.TextLabel.Text = ConfirmText
		Confirm = true
		wait(1.5)
		if RareSpin.TextLabel.Text == ConfirmText then
			RareSpin.TextLabel.Text = RText
		end
		Confirm = false
	end
end

SpinRemote.OnClientEvent:Connect(function(spintype)
	if spintype == "Common" then
		CommonSP(true)
	elseif spintype == "Uncommon" then
		UncommonSP(true)
	elseif spintype == "Rare" then
		RareSP(true)
	end
end)

CommonSpin.MouseButton1Click:Connect(function()
	if not spinning then
		CommonSP()
	end
end)

UncommonSpin.MouseButton1Click:Connect(function()
	if not spinning then
		UncommonSP()
	end
end)

RareSpin.MouseButton1Click:Connect(function()
	if not spinning then
		RareSP()
	end
end)

CommonRobuxSpin.MouseButton1Click:Connect(function()
	if not spinning then
		CommonSP(true)
	end
end)

UncommonRobuxSpin.MouseButton1Click:Connect(function()
	if not spinning then
		UncommonSP(true)
	end
end)

RareRobuxSpin.MouseButton1Click:Connect(function()
	if not spinning then
		RareSP(true)
	end
end)

Cash:GetPropertyChangedSignal("Value"):Connect(function()
	CashLabel.Text = "Cash: $"..Cash.Value
end)

JoinPlayerButton.MouseButton1Click:Connect(function()
	JoinPlayerRemote:FireServer(JoinPlayerName.Text)
end)

StartButton.MouseButton1Down:Connect(function()
	if debounce == false then
		if ActiveTween ~= nil then
			Camera.FieldOfView = 80
			AllowTeen = false
			ActiveTween:Cancel()
			ActiveTween = nil
		end	
		--TweenService:Create(Lighting, TweenInfo.new(1200, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {ClockTime = 24}):Play()
		debounce = true
		MythicTweening = false
		coroutine.wrap(function()	
			PlayerEvent:InvokeServer()	
		end)()
		
		Forcefield:Destroy()
		OtherButtons:Destroy()
		Menu.Visible = false
		
		--		SpinClient:Disconnect()
		game.ReplicatedStorage:WaitForChild("Gui"):WaitForChild("InteractGui"):Clone().Parent = PlayerGui
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
		IntroRemote:FireServer()
		for i = 1,50 do
			Opening.Volume = Opening.Volume - .004
			game:GetService("RunService").RenderStepped:Wait()
		end
		Opening:Stop()
		Opening.Volume = .2
		game:GetService("StarterGui"):SetCore("ChatWindowPosition",UDim2.new(0.07,0,0.2,0))
		sg.Enabled = true
		qg.Enabled = true
		--cooldowns.Enabled = true
		coroutine.wrap(function()
			repeat 
				local Sucess = pcall(function() 
					game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, true)
				end) 
				wait(.1) 
			until Sucess
		end)()	
		SoundTrack()
		
		workspace.CurrentCamera.Focus = Player.Character and Player.Character.Humanoid or Player.CharacterAdded:Wait() and Player.Character.Humanoid
	end
end)

function NewSpinnerFunction(Quirk, Rarity)
	if SpinnerUI:FindFirstChild("SpinnerUI") then
		SpinnerUI.SpinnerUI:Destroy()
	end
	local NewUIHolder = Instance.new("Frame")
	NewUIHolder.Size = UDim2.new(1, 0, 1, 0)
	NewUIHolder.Position = UDim2.new(-2.0, 0, 0, 0)
	NewUIHolder.BackgroundTransparency = 1
	NewUIHolder.Parent = SpinnerUI
	NewUIHolder.Name = "SpinnerUI"
	local obj = script:WaitForChild("Template")
	local scale = UDim2.new(0.23, 0, 0.8, 0)
	for i=0,91 do	
		local NewUI = obj:Clone()
		NewUI.Size = scale
		NewUI.Position = UDim2.new(i/4, 0, 0.1, 0)
		NewUI.Parent = NewUIHolder
		local NewQuirk = RarityIndex["S"..Rarity][math.random(1, #RarityIndex["S"..Rarity])]
		local NewQuirkData = SData[NewQuirk]
		local rarity = NewQuirkData.Rarity
		NewUI.TextLabel.Text = NewQuirkData.Name
		if i==89 then
			NewQuirkData = SData[Quirk]
			rarity = NewQuirkData.Rarity
			NewUI.TextLabel.Text = NewQuirkData.Name
		end
		if rarity == "Common" then
			NewUI.ImageColor3 = Color3.new(255,255,255)
			NewUI.TextLabel.TextColor3 = Color3.new(255,255,255)
		elseif rarity == "Uncommon" then
			NewUI.ImageColor3 = Color3.new(0,255,0)
			NewUI.TextLabel.TextColor3 = Color3.new(0,255,0)			
		elseif rarity == "Rare" then
			NewUI.ImageColor3 = Color3.new(255,255,0)
			NewUI.TextLabel.TextColor3 = Color3.new(255,255,0) 
		elseif rarity == "Legendary" then
			NewUI.ImageColor3 = Color3.new(255,0,0)
			NewUI.TextLabel.TextColor3 = Color3.new(255,0,0)
		end
	end
	TweenService:Create(NewUIHolder, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(-11, 0, 0, 0)}):Play()
	wait(1.5)
	TweenService:Create(NewUIHolder, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(-22 + math.random(5, 20)/100, 0, 0, 0)}):Play()
	wait(1.5)
end
-- // not that important
local isOpen       = nil
local debounce     = false

OtherButtons.Oldmap.Activated:Connect(function() remoteTeleport:FireServer("") end)
OtherButtons.Pvplobby.Activated:Connect(function() remoteTeleport:FireServer() end)

OtherButtons.Activated:Connect(function()
	if debounce then return end
	debounce = true
	if isOpen then
		local newTween = TweenService:Create(OtherButtons.Pvplobby, TweenInfo.new(.35), {TextTransparency = 1, BackgroundTransparency = 1})
		TweenService:Create(OtherButtons.Oldmap, TweenInfo.new(.35), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
		newTween:Play()
		newTween.Completed:Wait()
		
		OtherButtons.Pvplobby.Visible = false
		OtherButtons.Oldmap.Visible   = false
		
		local newTween = TweenService:Create(OtherButtons, TweenInfo.new(.35), {Size = UDim2.new(0.107, 0, 0.1, 0), TextTransparency = 0})
		newTween:Play()
		newTween.Completed:Wait()
	else
		local newTween = TweenService:Create(OtherButtons, TweenInfo.new(.35), {Size = UDim2.new(0.243, 0, 0.549, 0), TextTransparency = 1})
		newTween:Play()
		newTween.Completed:Wait()
		
		OtherButtons.Pvplobby.Visible = if Level.Value < 1000 then false else true
		OtherButtons.Oldmap.Visible   = true
		local newTween = TweenService:Create(OtherButtons.Pvplobby, TweenInfo.new(.35), {TextTransparency = 0, BackgroundTransparency = .4})
		TweenService:Create(OtherButtons.Oldmap, TweenInfo.new(.35), {TextTransparency = 0, BackgroundTransparency = .4}):Play()
		newTween:Play()
		newTween.Completed:Wait()
	end
	isOpen   = not isOpen
	debounce = false
end)
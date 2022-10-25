local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerGui = Player:WaitForChild("PlayerGui")
local IntroGui = PlayerGui:WaitForChild("IntroGui")
local IntroRemote = game.ReplicatedStorage:WaitForChild("Intro")
local Character = Player.Character or Player.CharacterAdded:Wait()
local debounce = false
wait()
----------------------
local Forcefield = Instance.new("ForceField",Character)
Forcefield.Name = "Intro"
local Menu = IntroGui:WaitForChild("Menu")
local MenuGui = PlayerGui:WaitForChild("Menu")
local JoinPlayerFrame = Menu:WaitForChild("JoinPlayerFrame")
local JoinPlayerButton = JoinPlayerFrame:WaitForChild("JoinButton")
local JoinPlayerName = JoinPlayerFrame:WaitForChild("PlayerName")
local QuirkSpinFrame = Menu:WaitForChild("QuirkSpinFrame")
local CashLabel = QuirkSpinFrame:WaitForChild("Cash"):WaitForChild("Value")
local QuirkLabel = QuirkSpinFrame:WaitForChild("Quirk")
local CommonSpin = QuirkSpinFrame:WaitForChild("CommonSpin"):WaitForChild("SpinCash")
local UncommonSpin = QuirkSpinFrame:WaitForChild("UncommonSpin"):WaitForChild("SpinCash")
local RareSpin = QuirkSpinFrame:WaitForChild("RareSpin"):WaitForChild("SpinCash")
local CommonRobuxSpin = QuirkSpinFrame:WaitForChild("CommonSpin"):WaitForChild("SpinRobux")
local UncommonRobuxSpin = QuirkSpinFrame:WaitForChild("UncommonSpin"):WaitForChild("SpinRobux")
local RareRobuxSpin = QuirkSpinFrame:WaitForChild("RareSpin"):WaitForChild("SpinRobux")
local SpinRemote = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Spin")
local JoinPlayerRemote = game.ReplicatedStorage:WaitForChild("JoinPlayer")
local sg = PlayerGui:WaitForChild("SaveGui")
local qg = PlayerGui:WaitForChild("QuestGui")
local StartButton = Menu:WaitForChild("Center"):WaitForChild("StartButton")
local RS = game:GetService("ReplicatedStorage")
local PlayerEvent = RS:WaitForChild("Exp")
local button = script.Parent.Parent.Parent.Menu.Buttons.MusicButton
local toggled = false
local musicList = Menu.Music:GetChildren()
local SecretList = Menu.SecretMusic:GetChildren()
local opList = Menu.Openings:GetChildren()
----------------------
if Player:IsInGroup(3755220) and Player:GetRankInGroup(3755220) >= 11 then
	JoinPlayerFrame.Visible = true
end

if Player.Name == "Jeffycry65" then
	opList = {Menu.Special:WaitForChild("MC")}
end

IntroGui.Enabled = true
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

local target = workspace.Park["All Might Statue"]["All Might Statue"]["Statue"]["Head"]
local angle = 0
local i = 0
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CameraSubject = target
local Coro = coroutine.wrap(function()
	while wait() do
	    Camera.CoordinateFrame = CFrame.new(target.Position) * CFrame.Angles(0, angle, 0) * CFrame.new(0, 10, 80)
	    angle = angle + math.rad(.5)
		i = i + 1
		if debounce == true then break end
	end
end)
Coro()

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

local Spinning = false
local Cash = PlayerData:WaitForChild("Cash")
local Quirk = PlayerData:WaitForChild("Quirk")
local CommonSpinId = 196151730
local UncommonSpinId = 393139062
local RareSpinId = 393139523
local MythicTween
local MythicTweening = false
local RainbowSelection = 1
local RainbowColors = {Color3.fromRGB(255,0,230),Color3.fromRGB(49,254,1),Color3.fromRGB(227,255,26),Color3.fromRGB(255,92,3)}

CashLabel.Text = "Cash: $"..Cash.Value
if Quirk.Value == 0 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Engine"
	elseif Quirk.Value == 1 then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = "Half Hot Half Cold"
	elseif Quirk.Value == 2 then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = "One For All"
	elseif Quirk.Value == 3 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Quirkless"
	elseif Quirk.Value == 4 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Zero Gravity"
	elseif Quirk.Value == 5 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Regeneration"
	elseif Quirk.Value == 6 then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = "Explosion"
	elseif Quirk.Value == 7 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Electric"
	elseif Quirk.Value == 8 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Warp Gate"
	elseif Quirk.Value == 9 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Gigantification"
	elseif Quirk.Value == 10 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Voice"
	elseif Quirk.Value == 11 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Air Propulsion"
	elseif Quirk.Value == 12 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Shock Absorption"
	elseif Quirk.Value == 13 then
	--	QuirkLabel.TextColor3 = Color3.new(255,0,0)
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
	QuirkLabel.Text = "Deku OFA"
	elseif Quirk.Value == 14 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Hardening"
	elseif Quirk.Value == 15 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Hellflame"
	elseif Quirk.Value == 16 then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = "Overhaul"
	elseif Quirk.Value == 17 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Jet"
	elseif Quirk.Value == 18 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Black Hole"
	elseif Quirk.Value == 19 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Cremation"
	elseif Quirk.Value == 20 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Dark Shadow"
	elseif Quirk.Value == 21 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Muscle Augmentation"
	elseif Quirk.Value == 22 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Permeation"
	elseif Quirk.Value == 23 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Pop Off"
	elseif Quirk.Value == 24 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Somnambulist"
	elseif Quirk.Value == 25 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Navel Laser"
	elseif Quirk.Value == 26 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Decay"
	elseif Quirk.Value == 27 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Acid"
	elseif Quirk.Value == 28 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Creation"
	elseif Quirk.Value == 29 then
	QuirkLabel.TextColor3 = Color3.new(0,255,0)
	QuirkLabel.Text = "Clones"
	elseif Quirk.Value == 30 then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = "All For One"
	elseif Quirk.Value == 31 then
	QuirkLabel.TextColor3 = Color3.new(255,255,255)
	QuirkLabel.Text = "Tail"
	elseif Quirk.Value == 32 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Frog"
	elseif Quirk.Value == 33 then
	QuirkLabel.TextColor3 = Color3.new(255,0,0)
	QuirkLabel.Text = "Fierce Wings"
	elseif Quirk.Value == 34 then
	--QuirkLabel.TextColor3 = Color3.new(255,0,0)
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
	QuirkLabel.Text = "Tomura AFO"
	elseif Quirk.Value == 35 then
	QuirkLabel.TextColor3 = Color3.new(255,255,0)
	QuirkLabel.Text = "Orcinus"
end

local SpinClient = SpinRemote.OnClientEvent:Connect(function()
	Spinning = true
	MythicTweening = false
	CashLabel.Text = "Cash: $"..Cash.Value
	for i=1, 20 do
		wait(0.1)
		local random = math.random(0,33)
		if random == 0 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Engine"
			elseif random == 1 then
			QuirkLabel.TextColor3 = Color3.new(255,0,0)
			QuirkLabel.Text = "Half Hot Half Cold"
			elseif random == 2 then
			QuirkLabel.TextColor3 = Color3.new(255,0,0)
			QuirkLabel.Text = "One For All"
			elseif random == 3 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Quirkless"
			elseif random == 4 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Zero Gravity"
			elseif random == 5 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Regeneration"
			elseif random == 6 then
			QuirkLabel.TextColor3 = Color3.new(255,0,0)
			QuirkLabel.Text = "Explosion"
			elseif random == 7 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Electrification"
			elseif random == 8 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Warp Gate"
			elseif random == 9 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Gigantification"
			elseif random == 10 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Voice"
			elseif random == 11 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Air Propulsion"
			elseif random == 12 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Shock Absorption"
			elseif random == 13 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Hardening"
			elseif random == 14 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Hellflame"
			elseif random == 15 then
			QuirkLabel.TextColor3 = Color3.new(255,0,0)
			QuirkLabel.Text = "Overhaul"
			elseif random == 16 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Jet"
			elseif random == 17 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Blackhole"
			elseif random == 18 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Cremation"
			elseif random == 19 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Dark Shadow"
			elseif random == 20 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Muscle Augmentation"
			elseif random == 21 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Permeation"
			elseif random == 22 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Pop Off"
			elseif random == 23 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Somnambulist"
			elseif random == 24 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Navel Laser"
			elseif random == 25 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Decay"
			elseif random == 26 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Acid"
			elseif random == 27 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Creation"
			elseif random == 28 then
			QuirkLabel.TextColor3 = Color3.new(0,255,0)
			QuirkLabel.Text = "Clones"
			elseif random == 29 then
			QuirkLabel.TextColor3 = Color3.new(255,0,0)
			QuirkLabel.Text = "All For One"
			elseif random == 30 then
			QuirkLabel.TextColor3 = Color3.new(255,255,255)
			QuirkLabel.Text = "Tail"
			elseif random == 31 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Frog"
			elseif random == 32 then
			QuirkLabel.TextColor3 = Color3.new(255,0,0)
			QuirkLabel.Text = "Fierce Wings"
			elseif random == 33 then
			QuirkLabel.TextColor3 = Color3.new(255,255,0)
			QuirkLabel.Text = "Orcinus"
		end
	end
	wait(1)
	if Quirk.Value == 0 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Engine"
	elseif Quirk.Value == 1 then
		QuirkLabel.TextColor3 = Color3.new(255,0,0)
		QuirkLabel.Text = "Half Hot Half Cold"
	elseif Quirk.Value == 2 then
		QuirkLabel.TextColor3 = Color3.new(255,0,0)
		QuirkLabel.Text = "One for All"
	elseif Quirk.Value == 3 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Quirkless"
		elseif Quirk.Value == 4 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Zero Gravity"
		elseif Quirk.Value == 5 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Regeneration"
	elseif Quirk.Value == 6 then
		QuirkLabel.TextColor3 = Color3.new(255,0,0)
		QuirkLabel.Text = "Explosion"
		elseif Quirk.Value == 7 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Electrification"
		elseif Quirk.Value == 8 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Warp Gate"
		elseif Quirk.Value == 9 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Gigantification"
		elseif Quirk.Value == 10 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Voice"
		elseif Quirk.Value == 11 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Air Propulsion"
		elseif Quirk.Value == 12 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Shock Absorption"
		elseif Quirk.Value == 14 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Hardening"
		elseif Quirk.Value == 15 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Hellflame"
		elseif Quirk.Value == 16 then
		QuirkLabel.TextColor3 = Color3.new(255,0,0)
		QuirkLabel.Text = "Overhaul"
		elseif Quirk.Value == 17 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Jet"
		elseif Quirk.Value == 18 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Blackhole"
		elseif Quirk.Value == 19 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Cremation"
		elseif Quirk.Value == 20 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Dark Shadow"
		elseif Quirk.Value == 21 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Muscle Augmentation"
		elseif Quirk.Value == 22 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Permeation"
		elseif Quirk.Value == 23 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Pop Off"
		elseif Quirk.Value == 24 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Somnambulist"
		elseif Quirk.Value == 25 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Navel Laser"
		elseif Quirk.Value == 26 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Decay"
		elseif Quirk.Value == 27 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Acid"
		elseif Quirk.Value == 28 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Creation"
		elseif Quirk.Value == 29 then
		QuirkLabel.TextColor3 = Color3.new(0,255,0)
		QuirkLabel.Text = "Clones"
		elseif Quirk.Value == 30 then
		QuirkLabel.TextColor3 = Color3.new(255,0,0)
		QuirkLabel.Text = "All For One"
		elseif Quirk.Value == 31 then
		QuirkLabel.TextColor3 = Color3.new(255,255,255)
		QuirkLabel.Text = "Tail"
		elseif Quirk.Value == 32 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Frog"
		elseif Quirk.Value == 33 then
		QuirkLabel.TextColor3 = Color3.new(255,0,0)
		QuirkLabel.Text = "Fierce Wings"
		elseif Quirk.Value == 35 then
		QuirkLabel.TextColor3 = Color3.new(255,255,0)
		QuirkLabel.Text = "Orcinus"
		end
		Spinning = false
end)

local ConfirmText = "Are you sure?"
local Confirming = false
CommonSpin.MouseButton1Click:Connect(function()
	if Spinning == false then
	if CommonSpin.Text == ConfirmText and Confirming == true then
	if Spinning == false then
		Spinning = true
		if Cash.Value < 5000 then
		CommonSpin.Text = "Not Enough Cash!"
		wait(1)
		CommonSpin.Text = "Spin $5000"
		else
		SpinRemote:FireServer("CommonSpin")
		CommonSpin.Text = "Spin $5000"
		wait(3)
		end
		Spinning = false
	end
	elseif CommonSpin.Text ~= ConfirmText and Confirming == false then
	CommonSpin.Text = ConfirmText
	Confirming = true
	wait(1.5)
	if CommonSpin.Text == ConfirmText then
	CommonSpin.Text = "Spin $5000"
	end
	Confirming = false
	end
	end
end)

UncommonSpin.MouseButton1Click:Connect(function()
	if Spinning == false then
	if UncommonSpin.Text == ConfirmText and Confirming == true then
	if Spinning == false then
		Spinning = true
		if Cash.Value < 100000 then
		UncommonSpin.Text = "Not Enough Cash!"
		wait(1)
		UncommonSpin.Text = "Spin $100000"
		else
		SpinRemote:FireServer("UncommonSpin")
		UncommonSpin.Text = "Spin $100000"
		wait(3)
		end
		Spinning = false
	end
	elseif UncommonSpin.Text ~= ConfirmText and Confirming == false then
	UncommonSpin.Text = ConfirmText
	Confirming = true
	wait(1.5)
	if UncommonSpin.Text == ConfirmText then
	UncommonSpin.Text = "Spin $100000"
	end
	Confirming = false 
	end
	end
end)

RareSpin.MouseButton1Click:Connect(function()
	if Spinning == false then
	if RareSpin.Text == ConfirmText and Confirming == true then
	if Spinning == false then
		Spinning = true
		if Cash.Value < 1000000 then
		RareSpin.Text = "Not Enough Cash!"
		wait(1)
		RareSpin.Text = "Spin $1000000"
		else
		SpinRemote:FireServer("RareSpin")
		RareSpin.Text = "Spin $1000000"
		wait(3)
		end
		Spinning = false
	end
	elseif RareSpin.Text ~= ConfirmText and Confirming == false then
	RareSpin.Text = ConfirmText
	Confirming = true
	wait(1.5)
	if RareSpin.Text == ConfirmText then
	RareSpin.Text = "Spin $1000000"
	end
	Confirming = false
	end
	end
end)

CommonRobuxSpin.MouseButton1Click:Connect(function()
	if Spinning == false then
	game:GetService("MarketplaceService"):PromptProductPurchase(Player, CommonSpinId)
	end
end)

UncommonRobuxSpin.MouseButton1Click:Connect(function()
	if Spinning == false then
	game:GetService("MarketplaceService"):PromptProductPurchase(Player, UncommonSpinId)
	end
end)

RareRobuxSpin.MouseButton1Click:Connect(function()
	if Spinning == false then
	game:GetService("MarketplaceService"):PromptProductPurchase(Player, RareSpinId)
	end
end)
		
JoinPlayerButton.MouseButton1Click:Connect(function()
	JoinPlayerRemote:FireServer(JoinPlayerName.Text)
end)

StartButton.MouseButton1Down:Connect(function()
	if debounce == false then
		debounce = true
		MythicTweening = false
		local Coroutine = coroutine.wrap(function()
			PlayerEvent:InvokeServer()
			print("Remote")
		end)
		Coroutine()
		Forcefield:Destroy()
		Menu.Visible = false
		SpinClient:Disconnect()
		game.ReplicatedStorage:WaitForChild("Gui"):WaitForChild("InteractGui"):Clone().Parent = PlayerGui
		MenuGui.Enabled = true
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
		IntroRemote:FireServer()
		for i = 1,50 do
			Opening.Volume = Opening.Volume - .004
			game:GetService("RunService").RenderStepped:Wait()
		end
		Opening:Stop()
		Opening.Volume = .2
		game:GetService("StarterGui"):SetCore("ChatWindowPosition",UDim2.new(0.005,0,0.325,0))
		sg.Enabled = true
		qg.Enabled = true
		coroutine.wrap(function()
		repeat 
			local Sucess = pcall(function() 
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, true)
			end) 
			wait(.1) 
		until Sucess
		end)()
		SoundTrack()
	end
end)
button.MouseButton1Down:Connect(function()
	if toggled == false then
		toggled = true
		button.Image ="rbxassetid://2354408310" 
		for i= 1, #musicList do
			local sounds = musicList[i]
			sounds.Volume = 0
		end
		for i= 1, #SecretList do
			local sounds = SecretList[i]
			sounds.Volume = 0
		end
		Menu.Special.K21.Volume = 0
	elseif toggled == true then
		toggled = false
		button.Image = "rbxassetid://2354408673"
		for i= 1, #musicList do
			local sounds = musicList[i]
			sounds.Volume = 0.25
		end
		for i= 1, #SecretList do
			local sounds = SecretList[i]
			sounds.Volume = 0.25
		end
		Menu.Special.K21.Volume = 0.25
	end
end)
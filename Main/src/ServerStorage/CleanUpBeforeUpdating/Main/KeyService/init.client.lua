local EquipSword = script.Parent:WaitForChild("Equip")
local Swing = script.Parent:WaitForChild("Swing")
local Player = script.Parent:WaitForChild("Player")
local Dash = script.Parent:WaitForChild("Dash")
local RightSwing = script.Parent:WaitForChild("RightSwing")
local w = tick()
local s = tick()
local a = tick()
local d = tick()
local space = tick()
local Mouse = game.Players.LocalPlayer:GetMouse()
Player:FireServer()
local plr = game.Players.LocalPlayer
local RootPart = plr.Character:WaitForChild("HumanoidRootPart")
local CooldownGui = plr.PlayerGui:WaitForChild("CooldownGui")
local Cooldown = script.Parent:WaitForChild("Cooldowns")
local Usage = script.Parent:WaitForChild("Usage")
local Unlock = script.Parent:WaitForChild("Unlock")
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(plr.Name)
local Quirk = PlayerData:WaitForChild("Quirk")
local Cooling = false
local ButtonLocked = false

local UserInput = game:GetService("UserInputService")
local Mobile = UserInput.TouchEnabled and true
local InitiateMouse = script.Parent:WaitForChild("InitiateMouse")
local MousePosition = script.Parent:WaitForChild("MousePosition")

local function Unlocked(Button, Toggle)
	local coro = coroutine.wrap(function()
		if Cooling then
			repeat wait() until Cooling == false
		end
		for v,frames in pairs(CooldownGui:GetChildren()) do
			local MainButton = frames[Button]
			if not Toggle then
				MainButton.ImageTransparency = 0.6
				MainButton.Text.TextTransparency = 0.6
				ButtonLocked = false
			else
				MainButton.ImageTransparency = 0
				MainButton.Text.TextTransparency = 0
				ButtonLocked = true
			end
		end
	end)
	coro()
end

Unlocked("B", false)

local function GrayOutMoves(Toggle, Button)
	if Cooling then
		repeat wait() until Cooling == false
	end
	local coro = coroutine.wrap(function()
		if Quirk.Value == 1 then
			for v,frames in pairs(CooldownGui:GetChildren()) do
				local ButtonText = frames[Button]
				if Toggle then
					if frames.Name == "Main" then
						ButtonText.ImageColor3 = Color3.fromRGB(0, 80, 115)
					elseif frames.Name == "TodorokiFire" then
						ButtonText.ImageColor3 = Color3.fromRGB(173, 77, 4)
					elseif frames.Name == "TodorokiIce" then
						ButtonText.ImageColor3 = Color3.fromRGB(45, 45, 135)
					elseif frames.Name == "TodorokiBoth" then
						ButtonText.ImageColor3 = Color3.fromRGB(102, 102, 102)
					end
				else
					if frames.Name == "Main" then
						ButtonText.ImageColor3 = Color3.fromRGB(0, 100, 143)
					elseif frames.Name == "TodorokiFire" then
						ButtonText.ImageColor3 = Color3.fromRGB(255, 118, 6)
					elseif frames.Name == "TodorokiIce" then
						ButtonText.ImageColor3 = Color3.fromRGB(66, 66, 198)
					elseif frames.Name == "TodorokiBoth" then
						ButtonText.ImageColor3 = Color3.fromRGB(185, 185, 185)	
					end
				end
			end
		else
			local ButtonText = CooldownGui.Main[Button]
			if Toggle then
				ButtonText.ImageColor3 = Color3.fromRGB(0, 80, 115)
			else
				ButtonText.ImageColor3 = Color3.fromRGB(0, 100, 143)
			end
		end
	end)
	coro()
end

local function CooldownChange(Delay, Button)
	for v,frames in pairs(CooldownGui:GetChildren()) do
		local coro = coroutine.wrap(function()
			Cooling = true
			local timer = Delay
			local ButtonText = frames[Button].Text
			local TimingText = frames[Button].Timer
			ButtonText.TextTransparency = 1
			TimingText.TextTransparency = 0
			if timer > 10 then
				repeat
					TimingText.Text = (tostring(math.round(timer*10)/10).."s")
					timer = timer - 1
					wait(1)
				until timer <= 10
			end
			repeat
				TimingText.Text = (tostring(math.round(timer*10)/10).."s")
				timer = timer - 0.1
				wait(0.0975)
			until timer < 1.1
			timer = 1
			repeat
				TimingText.Text = (tostring(math.round(timer*10)/10).."s")
				timer = timer - 0.1
				wait(0.0975)
			until timer < 0.1
			if not ButtonLocked then
				ButtonText.TextTransparency = 0.6
			else
				ButtonText.TextTransparency = 0
			end
			TimingText.TextTransparency = 1
			Cooling = false
		end)
		coro()
	end
end

Cooldown.OnClientEvent:Connect(CooldownChange)
Usage.OnClientEvent:Connect(GrayOutMoves)
Unlock.OnClientEvent:Connect(Unlocked)

if Mobile then
	local Cam = workspace.CurrentCamera
	UserInput.TouchTap:Connect(function(touchPositions, gameProcessedEvent)	
		local Cam = workspace.CurrentCamera
		local unitRay = Cam:ScreenPointToRay(touchPositions[1].X, touchPositions[1].Y)
		local raycastParams = RaycastParams.new()                                                      
		raycastParams.FilterDescendantsInstances = plr.Character and plr.Character:GetChildren() or {}                                           
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist   
		local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction*999999, raycastParams) 	
		if raycastResult then
			Swing:FireServer(CFrame.new(raycastResult.Position))
		else
			Swing:FireServer(Mouse.hit)
		end
	end)--CFrame.new(ray.Origin, ray.Origin + ray.Direction).LookVector*10000)
else
	Mouse.Button1Down:connect(function()
		Swing:FireServer(Mouse.hit)
	end)
end

Mouse.KeyDown:Connect(function(key)
	local keyb = key:byte()
	local keyl = key:lower()
	if keyl == "b" then
		RightSwing:FireServer(Mouse.hit)
	end
end)

Mouse.KeyDown:Connect(function(key)
	local keyb = key:byte()
	local keyl = key:lower()
	if keyl == "w" then
		if tick() - w < 0.2 then
			Dash:FireServer("Front")
		end
		w = tick()
	elseif keyl == "s" then
		if tick() - s < 0.2 then
			Dash:FireServer("Back")
		end
		s = tick()
	elseif keyl == "a" then
		if tick() - a < 0.2 then
			Dash:FireServer("Left")
		end
		a = tick()
	elseif keyl == "d" then
		if tick() - d < 0.2 then
			Dash:FireServer("Right")
		end
		d = tick()
	elseif keyb == 32 then
		if tick() - space < 0.2 then
			Dash:FireServer("Up")
		end
		space = tick()
	end
end)

local Humanoid = plr.Character.Humanoid

Dash.OnClientEvent:Connect(function()
	Humanoid.JumpPower += 100
	Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	task.wait(.01)
	Humanoid.JumpPower -= 100
end)

local MouseConnection
InitiateMouse.OnClientEvent:Connect(function(length)
	if MouseConnection then return end
	MouseConnection = Mouse.Move:Connect(function()
		MousePosition:FireServer(require(game.ReplicatedStorage.Modules.KeyServiceModule):GetMousePosition())
	end)
	wait(length)
	MouseConnection:Disconnect() MouseConnection = nil
end)
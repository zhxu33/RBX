-- // Services
local RunService      = game:GetService("RunService")
local Replicated      = game:GetService("ReplicatedStorage")
local StarterGui      = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")

-- // Variables

local commands = {}

-- // Functions

function commands:DisplayMessage(Text, isOn, Color)
	StarterGui:SetCore("ChatMakeSystemMessage", { 
		Text     = Text  or "";
		Color    = Color or (isOn == true and Color3.fromRGB(145, 255, 145) or isOn == false and Color3.fromRGB(255, 145, 145) or Color3.new(1, 1, 1)); 
		Font     = Enum.Font.SourceSansBold; 
		FontSize = Enum.FontSize.Size24;
	})
end

-- // Disconnects connection if it exists
local function Disconnect(connection)
	if connection and connection.Connected then connection:Disconnect() end
end

-- // Destroy if instance exists
local function Destroy(obj)
	if not (obj) then return end
	obj:Destroy()
end

-- // creates an fps icon to show the players fps
function commands:FPS(player)
	local playerGui  = player.PlayerGui
	local isEnabled  = false
	local debounce   = false
	local currentObj = nil
	local connection = nil

	local count      = 0
	local average    = 0

	return function()
		if debounce then return end
		debounce = true

		Disconnect(connection)
		Destroy(currentObj)

		if not (isEnabled) then
			-- // Enabling
			currentObj = Instance.new("ScreenGui")
			currentObj.IgnoreGuiInset = true
			currentObj.ResetOnSpawn   = false
			currentObj.DisplayOrder   = 999
			currentObj.Name           = "FPS"

			local frame = Instance.new("Frame")
			frame.Position = UDim2.fromOffset(104, 4) -- // Right next to the chat icon
			frame.BackgroundTransparency = .5
			frame.Size = UDim2.fromOffset(32, 32)
			frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			frame.Parent = currentObj

			local uiCorner = Instance.new("UICorner")
			uiCorner.Parent = frame

			local textLabel = Instance.new("TextLabel")
			textLabel.Text = ""
			textLabel.Size = UDim2.fromScale(1, 1)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.FredokaOne
			textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			textLabel.TextStrokeTransparency = 0
			textLabel.TextSize = 20
			textLabel.Parent   = frame
			currentObj.Parent  = playerGui

			-- // Render connection
			connection = RunService.RenderStepped:Connect(function(dt)
				local fps = 1/dt
				textLabel.TextColor3 = Color3.fromRGB(0, 255, 0):Lerp(Color3.fromRGB(255, 0, 0), math.clamp(dt, 0, 1))

				count   += 1
				average += fps

				if count > 10 then
					textLabel.Text = ("%.0f"):format(average/count)
					average = 0
					count   = 0
				end
			end)
		end

		isEnabled = not isEnabled
		commands:DisplayMessage(("FPS diplay toggled %s"):format((isEnabled and "on" or "off")), isEnabled)

		task.wait(.5)
		debounce = false
	end
end
-- // creates an fps icon to show the players fps
function commands:Crosshair(player)
	local playerGui  = player.PlayerGui
	local isEnabled  = false
	local debounce   = false
	local currentObj = nil

	local count      = 0
	local average    = 0

	return function()
		if debounce then return end
		debounce = true

		Destroy(currentObj)

		if not (isEnabled) then
			-- // Enabling
			local mobileGui = playerGui.MobileGui

			currentObj = Instance.new("Frame")
			currentObj.Position = UDim2.new(.5 + .1, 0, .5 - .1, 0) -- // Right next to the chat icon
			currentObj.AnchorPoint = Vector2.new(.5, .5)
			currentObj.BackgroundTransparency = .25
			currentObj.Size = UDim2.fromOffset(4, 4)
			currentObj.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			currentObj.Name = "Crosshair"

			local uiCorner        = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(1, 0)
			uiCorner.Parent       = currentObj
			currentObj.Parent = mobileGui
		end

		isEnabled = not isEnabled
		commands:DisplayMessage(("Crosshair toggled %s"):format((isEnabled and "on" or "off")), isEnabled)

		task.wait(.5)
		debounce = false
	end
end

-- // Turns global shadows on/off
function commands:Shadows()
	game.Lighting.GlobalShadows = not game.Lighting.GlobalShadows
	local isOn = game.Lighting.GlobalShadows
	commands:DisplayMessage(("Global Shadows toggled %s"):format((isOn and "on" or "off")), isOn)
end

-- // Turns bloom on/off
function commands:Bloom()
	game.Lighting.Bloom.Enabled = not game.Lighting.Bloom.Enabled
	local isOn = game.Lighting.Bloom.Enabled
	commands:DisplayMessage(("Bloom toggled %s"):format((isOn and "on" or "off")), isOn)
end

-- // Turns Depth of Field on/off
function commands:DepthofField()
	game.Lighting.DepthOfField.Enabled = not game.Lighting.DepthOfField.Enabled
	local isOn = game.Lighting.DepthOfField.Enabled
	commands:DisplayMessage(("Depth of Field toggled %s"):format((isOn and "on" or "off")), isOn)
end

-- // Turns Color correctoin on/off
function commands:ColorCorrection()
	game.Lighting.ColorCorrection.Enabled = not game.Lighting.ColorCorrection.Enabled
	local isOn = game.Lighting.ColorCorrection.Enabled
	commands:DisplayMessage(("Color Correction toggled %s"):format((isOn and "on" or "off")), isOn)
end

-- // Turns Color correctoin on/off
function commands:SunRays()
	game.Lighting.SunRays.Enabled = not game.Lighting.SunRays.Enabled
	local isOn = game.Lighting.SunRays.Enabled
	commands:DisplayMessage(("Sun Rays toggled %s"):format((isOn and "on" or "off")), isOn)
end

-- // Turns on or off the player damage
function commands:ShowDamage()
	local damageUtil = require(Replicated:WaitForChild("Modules"):WaitForChild("DamageUtility"))
	damageUtil.CanDisplay = not damageUtil.CanDisplay
	local isOn = damageUtil.CanDisplay
	commands:DisplayMessage(("Damage display toggled %s"):format((isOn and "on" or "off")), isOn)
end

-- // Shows all the commands
function commands:ShowCommands()
	commands:DisplayMessage("Current Commands:")
	for index, info in pairs(commands.ClientCommands) do
		if info and typeof(info) == "table" then
			commands:DisplayMessage(("/%s"):format(index), nil, Color3.fromRGB(255, 100, 0))
			if info.Description then
				commands:DisplayMessage(("  > %s"):format(info.Description or "No description provided"))
			end
		else
			commands:DisplayMessage(("/%s"):format(index))
		end
	end
end

-- // Teleports the player to the pvp lobby
function commands:PvpLobby()
	local LobbyTeleportRemote = Replicated:WaitForChild("LobbyRemotes"):WaitForChild("Teleport")
	LobbyTeleportRemote:FireServer()
end

-- // Teleports the player to the old map
function commands:OldMap()
	local LobbyTeleportRemote = Replicated:WaitForChild("LobbyRemotes"):WaitForChild("Teleport")
	LobbyTeleportRemote:FireServer(true)
end

-- // Makes the player rejoin
function commands:Rejoin()
	TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
end

-- // Adds a command to the client commands (Messages added like this won't be deleted)
function commands:AddCommand(command, info)
	if not (command and info) then return end
	if self.ClientCommands[command] then return end

	self.ClientCommands[command] = info
end

return commands
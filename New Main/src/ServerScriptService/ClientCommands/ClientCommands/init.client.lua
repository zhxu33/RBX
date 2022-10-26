-- // Services
local PlayerService = game:GetService("Players")
local Replicated    = game:GetService("ReplicatedStorage")

-- // Variables
local Player   = PlayerService.LocalPlayer
local Commands = require(script.Commands)
local Remotes  = Replicated:WaitForChild("Remotes")
local SaveRemote  = Remotes:WaitForChild("SaveSettings")
local GetSettings = Remotes:WaitForChild("GetSettings")

local prefix          = "/"
Commands.ClientCommands = {
	["FPS"]             = {Command = Commands:FPS(Player),       Shortcuts = {},      Toggled = false, Name = "FPS", Description = "Toggles FPS viewer."},
	["Shadows"]         = {Command = Commands.Shadows,           Shortcuts = {"GS"},  Toggled = true,  Name = "Shadows", Description = "Toggles global shadows."},
	["SunRays"]         = {Command = Commands.SunRays,           Shortcuts = {"SR"},  Toggled = true,  Name = "SunRays", Description = "Toggles sunrays."},
	["Bloom"]           = {Command = Commands.Bloom,             Shortcuts = {},      Toggled = true,  Name = "Bloom", Description = "Toggles bloom."},
	["ColorCorrection"] = {Command = Commands.ColorCorrection,   Shortcuts = {"CC"},  Toggled = true,  Name = "ColorCorrection", Description = "Toggles color correction."},
	["DepthOfField"]    = {Command = Commands.DepthofField,      Shortcuts = {"DoF"}, Toggled = false, Name = "DepthOfField", Description = "Toggles depth of field."},
	["ShowDamage"]      = {Command = Commands.ShowDamage,        Shortcuts = {"SD"},  Toggled = true,  Name = "ShowDamage", Description = "Toggles damage displayed."},
	["Crosshair"]       = {Command = Commands:Crosshair(Player), Shortcuts = {},      Toggled = false, Name = "Crosshair", Description = "Toggles crosshair (mobile)."},
	["Commands"]        = {Command = Commands.ShowCommands,      Shortcuts = {"Cmds", "Cmd"}, Name = "Commands", Description = "Shows this list of commands."},
	["Raids"]           = {Command = Commands.PvpLobby,          Shortcuts = {"Raid"}, Name = "Raids", Description = "Teleports the user to the pvp & raid lobby."},
	["PVP"]             = {Command = Commands.PvpLobby,          Shortcuts = {}, Name = "PVP", Description = "Teleports the user to the pvp & raid lobby."},
	["OldMap"]          = {Command = Commands.OldMap,            Shortcuts = {}, Name = "OldMap", Description = "Teleports the user to the old map."},
	["Rejoin"]          = {Command = Commands.Rejoin,            Shortcuts = {}, Name = "Rejoin", Description = "Rejoins the game."},
}
-- // Functions
-- // returns if the message is a command
local function getCommand(message)
	for command, info in pairs(Commands.ClientCommands) do
		if message:sub(1, (#command + 1)) == prefix .. command:lower() then
			return info, message:sub((#command + 1))
		elseif (typeof(info) == "table" and info.Shortcuts) then
			for _, shortcut in ipairs(info.Shortcuts) do
				if message:sub(1, (#shortcut + 1)) == prefix .. shortcut:lower() then
					return info, message:sub((#shortcut + 1))
				end
			end
		end
	end
end

-- // Toggles commands based on 'toggled'
local function ToggleCommand(Command, newMessage, save)
	local info = Commands.ClientCommands[Command]
	
	pcall(info.Command, Commands, newMessage)
	
	
	if info.Toggled ~= nil then
		info.Toggled = not info.Toggled
	end
	
	if save then
		SaveRemote:FireServer(Commands.ClientCommands)
	end
end

-- // Putting a new commands method
Player.Chatted:Connect(function(message)
	local info, newMessage = getCommand(message)
	if info then
		ToggleCommand(info.Name, newMessage, true)
	end
end)

-- // So it loads all commands before doing the thing
if game:GetService("UserInputService").TouchEnabled then
	Player.PlayerGui:WaitForChild("MobileGui")
end

Commands:DisplayMessage("Type /commands or /cmds for extra commands.", nil, Color3.fromRGB(255, 100, 0))

-- // Grabbing the settings
local Settings = GetSettings:InvokeServer()

for index, value in pairs(Settings) do
	local info = Commands.ClientCommands[index]
	if not info then continue end
	
	if (info.Toggled ~= nil and typeof(info.Toggled) == "boolean" and info.Toggled ~= value) then
		ToggleCommand(index)
	end
end
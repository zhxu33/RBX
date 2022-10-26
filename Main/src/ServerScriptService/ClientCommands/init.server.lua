-- // Services
local ServerScriptService = game:GetService("ServerScriptService")

-- // Variables
script.ClientCommands.Parent = game.StarterPlayer.StarterPlayerScripts -- // CS takes while to load
local chatRunnerService = ServerScriptService:WaitForChild("ChatServiceRunner")
local ChatService       = require(chatRunnerService:WaitForChild("ChatService"))

local prefix          = "/"
local client_commands = {
	["FPS"]             = true,
	["Shadows"]         = true,
	["GS"]              = true,
	["SunRays"]         = true,
	["SR"]              = true,
	["Bloom"]           = true,
	["ColorCorrection"] = true,
	["CC"]              = true,
	["DepthOfField"]    = true,
	["DoF"]             = true,
	["ShowDamage"]      = true,
	["SD"]              = true,
	["Cmds"]            = true,
	["Cmd"]             = true,
	["Commands"]        = true,
	["Raids"]           = true,
	["Raid"]            = true,
	["PVP"]             = true,
	["OldMap"]          = true,
	["Rejoin"]          = true,
	["Remap"]           = true,
	["Crosshair"]       = true,
}

-- // Functions
-- // returns if the message is a command
local function getCommand(message)
	for command, func in pairs(client_commands) do
		if message:sub(1, (#command + 1)) == prefix .. command:lower() then
			return func, message:sub((#command + 1))
		end
	end
end

-- // Putting a new commands method
ChatService:RegisterProcessCommandsFunction("client_commands", function(fromSpeaker, message, channel)
	local command, newMessage = getCommand(message)
	if command then
		-- // handle method
		if typeof(command) == "function" then
			command(fromSpeaker, newMessage, channel)
		end
		
		return true
	end
	
	return false
end)
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local AttributeService = require(game.ReplicatedStorage:WaitForChild("AttributeService"))

local connection
local StaminaBar
local Stamina
local MaxStamina
local StaminaValue

local function round(number)
	return math.floor(number + 0.5)
end

local function Bind(char)
	coroutine.wrap(function()
		Character = char
		StaminaBar = script.Parent:WaitForChild("stamina"):WaitForChild("stamina")
		StaminaValue = script.Parent:WaitForChild("TextLabel")

		AttributeService.WaitForAttribute(Character, "Stamina")
		AttributeService.WaitForAttribute(Character, "MaxStamina")

		StaminaBar.Size = UDim2.new(Character:GetAttribute("Stamina")/Character:GetAttribute("MaxStamina"),0,1,0)
		StaminaValue.Text = "Stamina: "..round((Character:GetAttribute("Stamina")/Character:GetAttribute("MaxStamina"))*100).."%"

		if connection ~= nil then connection:Disconnect() end
		connection = Character:GetAttributeChangedSignal("Stamina"):Connect(function()
			StaminaValue.Text = "Stamina: "..round((Character:GetAttribute("Stamina")/Character:GetAttribute("MaxStamina"))*100).."%"
			StaminaBar.Size = UDim2.new(Character:GetAttribute("Stamina")/Character:GetAttribute("MaxStamina"),0,1,0)
		end)
	end)()
end
Bind(Character)

Player.CharacterAdded:Connect(function(char)
	Bind(char)
end)
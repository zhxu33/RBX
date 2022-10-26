local bar = script.Parent:WaitForChild("hpbg").hp
local hBar = script.Parent
local hptext = script.Parent.TextLabel

local Player = game.Players.LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local Hovering = false

local function round(number)
	return math.floor(number + 0.5)
end

local function update()
	bar.Size = UDim2.fromScale(humanoid.Health/humanoid.MaxHealth, 1)
	if Hovering then
		hptext.Text = (humanoid.Health/10).." / ".. (humanoid.MaxHealth/10)
	else
		hptext.Text = "Health: ".. round((humanoid.Health/humanoid.MaxHealth)*100).."%"
	end
end

local function setConnections()
	connection_hp = humanoid:GetPropertyChangedSignal("Health"):Connect(update)
	connection_maxhp = humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(update)
	update()
end

hBar.MouseEnter:Connect(function()
	Hovering = true
	hptext.Text = (humanoid.Health/10).." / ".. (humanoid.MaxHealth/10) -- Have to divide by 10 because damage was divided by 10, Refer to the damage script
end)

hBar.MouseLeave:Connect(function()
	Hovering = false
	update()
end)

Player.CharacterAdded:Connect(function(chara)
	character = chara
	humanoid = character:WaitForChild("Humanoid")
	if connection_hp then connection_hp:Disconnect() end
	if connection_maxhp then connection_maxhp:Disconnect() end
	setConnections()
end)

setConnections()

--[[
local bar = script.Parent:WaitForChild("hpbg").hp
local hBar = script.Parent
local hptext = script.Parent.TextLabel

local Player = game.Players.LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function round(number)
	return math.floor(number + 0.5)
end

local function update()
	bar:TweenSize(UDim2.new(humanoid.Health / humanoid.MaxHealth, 0,1,0), Enum.EasingDirection.In, Enum.EasingStyle.Quint,0.4,true)
	hptext.Text = "Health: ".. round((humanoid.Health/humanoid.MaxHealth)*100).."%"
end

local function setConnections()
	connection_hp = humanoid:GetPropertyChangedSignal("Health"):Connect(update)
	connection_maxhp = humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(update)
	update()
end

hBar.MouseEnter:Connect(function()
	hptext.Text = (humanoid.Health/10).." / ".. (humanoid.MaxHealth/10) -- Have to divide by 10 because damage was divided by 10, Refer to the damage script
end)

hBar.MouseLeave:Connect(function()
	update()
end)

Player.CharacterAdded:Connect(function(chara)
	character = chara
	humanoid = character:WaitForChild("Humanoid")
	if connection_hp then connection_hp:Disconnect() end
	if connection_maxhp then connection_maxhp:Disconnect() end
	setConnections()
end)

setConnections() ]]
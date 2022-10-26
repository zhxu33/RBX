local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local IntroGuiMenu = PlayerGui:WaitForChild("IntroGui"):WaitForChild("Menu")
repeat wait() until IntroGuiMenu.Visible == false
local AntiAutoClickFrame = script.Parent
local ColorHolder = AntiAutoClickFrame.Colors
local AutoClickEvent = game.ReplicatedStorage:WaitForChild("AutoClick")

game.ReplicatedStorage.ChildRemoved:Connect(function()
	Player:Kick("Missing arguments...")
end)

local ranWait = math.random(1000,2000)
local RelaxPosition = Player.Character.HumanoidRootPart.Position

local ColorPositions = {UDim2.fromScale(.043,0),UDim2.fromScale(.229,0),UDim2.fromScale(.415,0),UDim2.fromScale(.601,0),UDim2.fromScale(.787,0)}
local ColorButtons = {ColorHolder.Color1,ColorHolder.Color2,ColorHolder.Color3,ColorHolder.Color4,ColorHolder.Color5}
for i=1,#ColorButtons do
	ColorButtons[i].Name = "Color"
end
local connections = {}

local function ChooseColor(i)
	if i == 1 then return "Red"
	elseif i == 2 then return "Orange"
	elseif i == 3 then return "Yellow"
	elseif i == 4 then return "Green"
	elseif i == 5 then return "Blue" end
end

local function AFKCheck()
	local ColorPosition = math.random(1,#ColorPositions)
	local CorrectVal = math.random(1,5)
	local CorrectColor = ChooseColor(CorrectVal)
	for i=1,#ColorButtons do
		ColorButtons[ColorPosition].Position = ColorPositions[i]
		if ColorPosition == 5 then
			ColorPosition = 1
		else
			ColorPosition = ColorPosition + 1
		end
	end
	local ValidClosure = false
	for v,gui in pairs(AntiAutoClickFrame.Colors:GetChildren()) do
		if gui == ColorButtons[CorrectVal] then
			connections[v] = gui.Button.MouseButton1Click:Connect(function()
				AntiAutoClickFrame.Visible = false
				ValidClosure = true
			end)
		else
			connections[v] = gui.Button.MouseButton1Click:Connect(function()
				AutoClickEvent:FireServer()
			end)
		end
	end
	AntiAutoClickFrame.TextFrame.ColorIndicator.Text = "Click the " .. CorrectColor.. " color to close the menu."
	AntiAutoClickFrame.Visible = true
	local Count = 0
	repeat
		Count = Count + 1
		wait(1)
	until Count >= 30 or AntiAutoClickFrame.Visible == false
	if not ValidClosure then
		AutoClickEvent:FireServer()
	end
	RelaxPosition = Player.Character.HumanoidRootPart.Position
	for i=1,#connections do
		if connections[i] ~= nil then connections[i]:Disconnect() end
	end
end

wait(300)
RelaxPosition = Player.Character.HumanoidRootPart.Position

while wait(ranWait) do
	if (RelaxPosition - Player.Character.HumanoidRootPart.Position).magnitude > 10 then
		RelaxPosition = Player.Character.HumanoidRootPart.Position
	else
		AFKCheck()
	end
	ranWait = math.random(1000,2000)
end
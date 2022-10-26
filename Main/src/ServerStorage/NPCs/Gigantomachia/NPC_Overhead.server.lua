repeat wait() until script.Parent:FindFirstChild("Stamina") and script.Parent:FindFirstChild("MaxStamina")
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local BBG = script:WaitForChild("OverHead")
local Fame = script.Parent.Fame
local Stats = BBG:WaitForChild("OverheadBase")
local barsFrame = Stats:WaitForChild("Overheadbars")
local HealthF = barsFrame:WaitForChild("hpbg")
local StaminaF = barsFrame:WaitForChild("spbg")
local Name = script:WaitForChild("OverHead"):WaitForChild("OverheadBase"):WaitForChild("nametag")
--local AvatarF = Stats:WaitForChild("AvatarFrame")
local HealthBar = HealthF:WaitForChild("hp")
local StaminaBar = StaminaF:WaitForChild("sp")
local Head = script.Parent:WaitForChild("Head")
local Humanoid = script.Parent:WaitForChild("Humanoid")
BBG.Parent = Head

Name.Text = "Gigantomachia"

local function update()
	HealthBar.Size = UDim2.new(Humanoid.Health/Humanoid.MaxHealth,0,1,0)
	StaminaBar.Size = UDim2.new(Stamina.Value/MaxStamina.Value,0,1,0)
end

HealthBar.Size = UDim2.new(Humanoid.Health/Humanoid.MaxHealth,0,1,0)
StaminaBar.Size = UDim2.new(Stamina.Value/MaxStamina.Value,0,1,0)
	
Humanoid:GetPropertyChangedSignal("Health"):Connect(update)
Stamina:GetPropertyChangedSignal("Value"):Connect(update)

if Fame.Value > 0 then
Name.TextColor3 = Color3.fromRGB(0,0,127)
elseif Fame.Value < 0 then
Name.TextColor3 = Color3.fromRGB(127,0,0)
else
Name.TextColor3 = Color3.fromRGB(255,255,255)
end

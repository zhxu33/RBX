repeat wait() until script.Parent:FindFirstChild("Stamina") and script.Parent:FindFirstChild("MaxStamina")
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local BBG = script:WaitForChild("OverHead")
local Fame = script.Parent.Fame
local Stats = BBG:WaitForChild("Statistics")
local HealthF = Stats:WaitForChild("HealthFrame")
local StaminaF = Stats:WaitForChild("StaminaFrame")
local Name = BBG:WaitForChild("Name")
local AvatarF = Stats:WaitForChild("AvatarFrame")
local HealthBar = HealthF:WaitForChild("HealthBar")
local StaminaBar = StaminaF:WaitForChild("StaminaBar")
local Head = script.Parent:WaitForChild("Head")
local Humanoid = script.Parent:WaitForChild("Humanoid")
BBG.Parent = Head

while wait(.1) do
	HealthBar.Size = UDim2.new(Humanoid.Health/Humanoid.MaxHealth,0,1,0)
	StaminaBar.Size = UDim2.new(Stamina.Value/MaxStamina.Value,0,1,0)
	Name.Text = script.Parent.Name
	if Fame.Value > 0 then
		Stats.ImageColor3 = Color3.fromRGB(0,0,127)
		Name.TextColor3 = Color3.fromRGB(0,0,127)
	elseif Fame.Value < 0 then
		Stats.ImageColor3 = Color3.fromRGB(127,0,0)
		Name.TextColor3 = Color3.fromRGB(127,0,0)
	else
		Stats.ImageColor3 = Color3.fromRGB(109,109,109)
		Name.TextColor3 = Color3.fromRGB(255,255,255)
	end
	if AvatarF.IsLoaded == true then
		AvatarF.Visible = true
	end
end
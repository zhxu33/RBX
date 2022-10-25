local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Stamina = Character:WaitForChild("Stamina")
local MaxStamina = Character:WaitForChild("MaxStamina")
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Fame = PlayerData:WaitForChild("Fame")
local Experience = PlayerData:WaitForChild("Experience")
local ExpMultiplier = PlayerData:WaitForChild("ExpMultiplier")
local Cash = PlayerData:WaitForChild("Cash")
local Level = PlayerData:WaitForChild("Level")
local Quirk = PlayerData:WaitForChild("Quirk")
local BackGround = script.Parent:WaitForChild("Background")
local ExpFrame = BackGround:WaitForChild("ExpFrame")
local HealthFrame = BackGround:WaitForChild("HealthFrame")
local StaminaFrame = BackGround:WaitForChild("StaminaFrame")
local ExpBar = ExpFrame:WaitForChild("Cover")
local HealthBar = HealthFrame:WaitForChild("Cover")
local StaminaBar = StaminaFrame:WaitForChild("Cover")
local ExpValue = ExpFrame:WaitForChild("Value")
local HealthValue = HealthFrame:WaitForChild("Value")
local StaminaValue = StaminaFrame:WaitForChild("Value")
local CashLabel = BackGround:WaitForChild("Cash"):WaitForChild("Value")
local FameLabel = BackGround:WaitForChild("Fame"):WaitForChild("Value")
local LevelLabel = BackGround:WaitForChild("Level"):WaitForChild("Value")
local QuirkLabel = BackGround:WaitForChild("Quirk"):WaitForChild("Value")
local MaxExp = 400*Level.Value/2/ExpMultiplier.Value
repeat wait(.1) until PlayerGui.IntroGui.Menu.Visible == false
script.Parent.Enabled = true
local QuirkChanged = game.ReplicatedStorage.Remotes:WaitForChild("QuirkChanged")

if Quirk.Value == 0 then
    QuirkLabel.Text = "Quirk: ".."Engine"
elseif Quirk.Value == 1 then
    QuirkLabel.Text = "Quirk: ".."HHHC"
elseif Quirk.Value == 2 then
    QuirkLabel.Text = "Quirk: ".."OneForAll"
elseif Quirk.Value == 3 then
    QuirkLabel.Text = "Quirk: ".."Quirkless"
elseif Quirk.Value == 4 then
    QuirkLabel.Text = "Quirk: ".."ZeroGrav"
elseif Quirk.Value == 5 then
    QuirkLabel.Text = "Quirk: ".."Regen"
elseif Quirk.Value == 6 then
    QuirkLabel.Text = "Quirk: ".."Explosion"
elseif Quirk.Value == 7 then
    QuirkLabel.Text = "Quirk: ".."Electric"
elseif Quirk.Value == 8 then
    QuirkLabel.Text = "Quirk: ".."WarpGate"
elseif Quirk.Value == 9 then
    QuirkLabel.Text = "Quirk: ".."Giant"
elseif Quirk.Value == 10 then
    QuirkLabel.Text = "Quirk: ".."Voice"
elseif Quirk.Value == 11 then
    QuirkLabel.Text = "Quirk: ".."AirCannon"
elseif Quirk.Value == 12 then
    QuirkLabel.Text = "Quirk: ".."ShockAbsorb"
elseif Quirk.Value == 13 then
    QuirkLabel.Text = "Quirk: ".."DekuOFA"
elseif Quirk.Value == 14 then
    QuirkLabel.Text = "Quirk: ".."Hardening"
elseif Quirk.Value == 15 then
    QuirkLabel.Text = "Quirk: ".."Hellflame"
elseif Quirk.Value == 16 then
    QuirkLabel.Text = "Quirk: ".."Overhaul"
elseif Quirk.Value == 17 then
    QuirkLabel.Text = "Quirk: ".."Jet"
elseif Quirk.Value == 18 then
    QuirkLabel.Text = "Quirk: ".."Blackhole"
elseif Quirk.Value == 19 then
    QuirkLabel.Text = "Quirk: ".."Cremation"
elseif Quirk.Value == 20 then
    QuirkLabel.Text = "Quirk: ".."Darkshadow"
elseif Quirk.Value == 21 then
    QuirkLabel.Text = "Quirk: ".."MuscleAugmentation"
elseif Quirk.Value == 22 then
    QuirkLabel.Text = "Quirk: ".."Permeation"
elseif Quirk.Value == 23 then
    QuirkLabel.Text = "Quirk: ".."PopOff"
elseif Quirk.Value == 24 then
    QuirkLabel.Text = "Quirk: ".."Somnambulist"
elseif Quirk.Value == 25 then
    QuirkLabel.Text = "Quirk: ".."NavelLaser"
elseif Quirk.Value == 26 then
    QuirkLabel.Text = "Quirk: ".."Decay"
elseif Quirk.Value == 27 then
    QuirkLabel.Text = "Quirk: ".."Acid"
elseif Quirk.Value == 28 then
    QuirkLabel.Text = "Quirk: ".."Creation"
elseif Quirk.Value == 29 then
    QuirkLabel.Text = "Quirk: ".."Clones"
elseif Quirk.Value == 30 then
    QuirkLabel.Text = "Quirk: ".."AllForOne"
elseif Quirk.Value == 31 then
    QuirkLabel.Text = "Quirk: ".."Tail"
elseif Quirk.Value == 32 then
    QuirkLabel.Text = "Quirk: ".."Frog"
elseif Quirk.Value == 33 then
    QuirkLabel.Text = "Quirk: ".."FierceWings"
elseif Quirk.Value == 34 then
	QuirkLabel.Text = "Quirk: ".."TomuraAFO"
elseif Quirk.Value == 35 then
	QuirkLabel.Text = "Quirk: ".."Orcinus"
end

local function round(number)
    return math.floor(number + 0.5)
end

while wait(.1) do
    MaxExp = 400*Level.Value/2/ExpMultiplier.Value
    if Level.Value >= 15000 then
		LevelLabel.Text = "Lv. 15000"
        ExpBar.Size = UDim2.new(1,0,1,0)
        ExpValue.Text = round(Experience.Value).."/"..round(MaxExp)
        MaxExp = 400*Level.Value/2/ExpMultiplier.Value
	elseif Level.Value <= 15000 then
        LevelLabel.Text = "Lv. "..Level.Value
        ExpBar.Size = UDim2.new(Experience.Value/MaxExp,0,1,0)
        MaxExp = 400*Level.Value/2/ExpMultiplier.Value
        ExpValue.Text = round(Experience.Value).."/"..round(MaxExp)
    end
    HealthBar.Size = UDim2.new(Humanoid.Health/Humanoid.MaxHealth,0,1,0)
    HealthValue.Text = round((Humanoid.Health/Humanoid.MaxHealth)*100).."%"
    HealthValue.MouseEnter:Connect(function()
        HealthValue.Text = Humanoid.Health/Humanoid.MaxHealth
    end)
    HealthValue.MouseLeave:Connect(function()
        HealthValue.Text = round((Humanoid.Health/Humanoid.MaxHealth)*100).."%"
    end)
    StaminaValue.Text = round((Stamina.Value/MaxStamina.Value)*100).."%"
    StaminaBar.Size = UDim2.new(Stamina.Value/MaxStamina.Value,0,1,0)
    CashLabel.Text = "Cash: $"..tostring(Cash.Value)
    FameLabel.Text = "Fame: ".. tostring(Fame.Value)
    if Fame.Value > 0  then
        FameLabel.TextColor3 = Color3.fromRGB(0,0,255)
    elseif Fame.Value < 0 then
        FameLabel.TextColor3 = Color3.fromRGB(255,0,0)
    else
        FameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    end
end

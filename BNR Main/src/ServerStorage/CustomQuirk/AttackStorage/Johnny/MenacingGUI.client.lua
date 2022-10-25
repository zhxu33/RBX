local Player = game.Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerGui = Player:WaitForChild("PlayerGui")
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
local Menu = PlayerGui:WaitForChild("Menu")
local Skills = Menu.Menu.Skills
local Acts = Character:WaitForChild("JohnnyJoestar").Acts

QuirkLabel.TextScaled = true

local function SwitchActs(Value)
	if Value == 1 then
		Skills.Skill1.Text = "[PASSIVE] - Your legs will not function due to an incident."
		Skills.Skill2.Text = "[T] - Evolve your stand to it's 2nd act by learning the golden rectangle."
		Skills.Skill3.Text = "[Q] - Summon Tusk Act 1, allowing you to use Tusk's abilities"
		Skills.Skill4.Text = "[Z] - The user will spin his nails, which will cause the nails to be shot like a bullet"
		Skills.Skill5.Text = "Act 1: [E] - Nail Swipe"
		Skills.Skill6.Text = "[F] - Drink Tea to regrow your nails."
		QuirkLabel.Text = "Stand: Tusk Act 1"
	elseif Value == 2 then
		Skills.Skill1.Text = "[PASSIVE] - Your legs will not function due to an incident."
		Skills.Skill2.Text = "[T] - 'If your heart is wavering, don't shoot', Evolve your stand to it's 3rd act."
		Skills.Skill3.Text = "[Q] - Summon Tusk Act 2, allowing you to use Tusk's abilities"
		Skills.Skill4.Text = "[Z] - Due to Tusk's evolution, the user will shoot more powerful nails with an increase to their travelling speed."
		Skills.Skill5.Text = "Act 2: [E] Nail Swipe, [X] - Golden Rectangle: Void"
		Skills.Skill6.Text = "[F] - Drink Tea to regrow your nails."
		QuirkLabel.Text = "Stand: Tusk Act 2"
	elseif Value == 3 then
		Skills.Skill1.Text = "[PASSIVE] - Your legs are beginning to recover from the corpse part, and you gained an increase in speed."
		Skills.Skill2.Text = "[T] - Activate the infinite rotation and evolve your stand to it's highest act."
		Skills.Skill3.Text = "[Q] - Summon Tusk Act 3, whilst it's summoned, you are able to use your next moves."
		Skills.Skill4.Text = "[Z] - Due to Tusk's 3rd evolution, the nails will deal more damage and will gain an increase to their travelling speed."
		Skills.Skill5.Text = "Act 3: [E] Nail Swipe, [X] Wormhole: Escape, [C] Wormhole: Hide, [V] Wormhole: Nail Surprise"
		Skills.Skill6.Text = "[F] - Drink Tea to regrow your nails."
		QuirkLabel.Text = "Stand: Tusk Act 3"
	elseif Value == 4 then
		Skills.Skill1.Text = "[PASSIVE] - Due to the infinite rotation and further recovery from the corpse part, you are able to walk again."
		Skills.Skill2.Text = "[T] - Cancel Tusk Act 4, revert back to Tusk Act 1"
		Skills.Skill3.Text = "[Q] - Summon Act 4, allowing you to use Tusk's Highest Evolution"
		Skills.Skill4.Text = "[Z] - Due to Tusk's final evolution, the user can a fire homing nails that deal even more damage and travel way faster."
		Skills.Skill5.Text = "Act 4: [E] - Tusk Act 4's Barrage, [R] - Tusk Act 4's Heavy Punch, [X] The Infinite Rotation, [C] Nail Glide"
		Skills.Skill6.Text = "[F] - Drink Tea to regrow your nails."
		QuirkLabel.Text = "Stand: Tusk Act 4"
	elseif Value == 5 then
		Skills.Skill1.Text = ""
		Skills.Skill2.Text = ""
		Skills.Skill3.Text = "???"
		Skills.Skill4.Text = ""
		Skills.Skill5.Text = ""
		Skills.Skill6.Text = ""
		QuirkLabel.Text = "Stand: Tusk???"
	end
end

SwitchActs(1)
Acts.OnClientInvoke = SwitchActs

local function round(number)
    return math.floor(number + 0.5)
end

while wait(.1) do
    MaxExp = 400*Level.Value/2/ExpMultiplier.Value
    if Level.Value >= 10000 then
        LevelLabel.Text = "Lv. 10000"
        ExpBar.Size = UDim2.new(1,0,1,0)
        ExpValue.Text = round(Experience.Value).."/"..round(MaxExp)
        MaxExp = 400*Level.Value/2/ExpMultiplier.Value
    elseif Level.Value <= 10000 then
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
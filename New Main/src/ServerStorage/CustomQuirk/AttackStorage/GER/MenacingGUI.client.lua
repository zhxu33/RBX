local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Fame = PlayerData:WaitForChild("Fame")
local Cash = PlayerData:WaitForChild("Cash")
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
local Menu = PlayerGui:WaitForChild("Menu")
local Skills = Menu.Menu.Skills

QuirkLabel.TextScaled = true
--QuirkLabel.Te	xtSize = 25

local gergui = coroutine.wrap(function()
	while true do
	    CashLabel.Text = "Cash: $".. tostring(Cash.Value)
	    FameLabel.Text = "Fame: ".. tostring(Fame.Value)
		wait()
	end
end)
gergui()

LevelLabel.Text = "∅"
LevelLabel.TextScaled = false
LevelLabel.TextSize = 60
ExpFrame.Value.Text = "∅"
HealthFrame.Value.Text = "∅"
StaminaFrame.Value.Text = "∅"
QuirkLabel.Text = "Gold Experience Requiem"

local function SkillChange()
	Skills.Skill1.Text = ""
	Skills.Skill2.Text = ""
	Skills.Skill3.Text = "???"
	Skills.Skill4.Text = ""
	Skills.Skill5.Text = ""
	Skills.Skill6.Text = ""
end
SkillChange()
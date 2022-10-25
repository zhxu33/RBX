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

local GlitchyText = {"#̶̤̏̈́&̶̩͊̾͘͝%̶͚̗͘/̷̼̮̰̗̓̇&̷͇͈̋͌̐͝!̵̛͎̙̯̬̍","&̷̻̅!̴̹͇̳͌/̶̖͉̜̭̂̀̾́%̵̣͖̐#̷̪͍͉̔̾͗͠$̸̤͎̗̟͆̏̚","$̵̽̐̐̓͜#̵͌͜$̴̛̻̠̘̟̑!̶̤̈́#̴̢̖̭͊%̵͚̬̌̏̾","&̷͍̮̏͋̽͝$̶̱̰͇͝&̷͍͊̅̾̚ͅ#̶̛͙̼͕̓̑̚%̷̺͕͖̓̈́͜͝͠&̶̛͎̤͂","&̵̘̋̑̀%̸̗͝$̵̨͚̱̕ͅ!̶̖̓͊&̸̨̝̱̯͂","%̴̢̼̙͌̀̓͂&̵̡͍̈́͛͌̕/̴̘̤̈̈́̓#̴͖̗͔͋́̄̌ͅ$̵̨̆̔̓̚"}
QuirkLabel.TextScaled = false
QuirkLabel.TextSize = 25

local creepygui = coroutine.wrap(function()
	while true do
	    CashLabel.Text = "Cash: $".. tostring(Cash.Value)
	    FameLabel.Text = "Fame: ".. tostring(Fame.Value)
		local i = math.random(1, #GlitchyText)
		local intervals = math.random(0.4, 0.7)
		QuirkLabel.Text = GlitchyText[i]
		wait(intervals)
	end
end)
creepygui()

ExpFrame.Value.Text = ""
HealthFrame.Value.Text = ""
StaminaFrame.Value.Text = "∅"
StaminaFrame.Value.TextScaled = true
StaminaFrame.Value.Position = UDim2.fromScale(0, -2.1)
StaminaFrame.Value.Size = UDim2.fromScale(1, 5)

local function SkillChange()
	Skills.Skill1.Text = "[Q] Counter: Smiley will begin fading in and out. Any damage received from a player will cause smiley to teleport behind them and frighten them, disabling their attacks for 3 seconds."
	Skills.Skill2.Text = "[Z] The Unknown: Smiley will teleport to his cursor. If Smiley has his cursor on an NPC/Player, he'll teleport behind them and take them to an unknown place."
	Skills.Skill3.Text = "[X] Scream of Death: Smiley will start screaming, nearby NPC's/Players who hear it will start to loose an insane amount of HP, lasting for up to 10 seconds."
	Skills.Skill4.Text = "[C] Scream of Horror: Smiley unleashes darkness, nearby NPC's/Players will be greeted with a jumpscare that'll blind them for 3 seconds."
	Skills.Skill5.Text = "[V] Shadow Image: Smiley summons a clone, who'll start pursuing the nearest player. The clone is able to pass through walls and elevate to the targetted player."
	Skills.Skill6.Text = "[F] Form Manipulation: Smiley becomes invisible, any attacks from him will not leave a trace. While invisible, he is also able to pass through walls."
end
SkillChange()
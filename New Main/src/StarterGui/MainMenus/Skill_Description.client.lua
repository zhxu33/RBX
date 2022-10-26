local Replicated   = game:GetService("ReplicatedStorage")

local QuirkChanged = Replicated:WaitForChild("Remotes"):WaitForChild("QuirkChanged")
local SkillDesc    = require(Replicated:WaitForChild("Modules"):WaitForChild("SkillDescriptions"))

local Player       = game.Players.LocalPlayer
local PlayerData   = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
local Quirk        = PlayerData:WaitForChild("Quirk")
local SkillsFrame  = script.Parent:WaitForChild("Skills")

local Skill1 = SkillsFrame:WaitForChild("qframe"):WaitForChild("TextLabel")
local Skill2 = SkillsFrame:WaitForChild("zframe"):WaitForChild("TextLabel")
local Skill3 = SkillsFrame:WaitForChild("xframe"):WaitForChild("TextLabel")
local Skill4 = SkillsFrame:WaitForChild("cframe"):WaitForChild("TextLabel")
local Skill5 = SkillsFrame:WaitForChild("vframe"):WaitForChild("TextLabel")
local Skill6 = SkillsFrame:WaitForChild("fframe"):WaitForChild("TextLabel")

QuirkChanged.OnClientEvent:Connect(function()
	local Descriptions = SkillDesc[Quirk.Value]
	Skill1.Text = Descriptions.Skill1
	Skill2.Text = Descriptions.Skill2
	Skill3.Text = Descriptions.Skill3
	Skill4.Text = Descriptions.Skill4
	Skill5.Text = Descriptions.Skill5
	Skill6.Text = Descriptions.Skill6
end)
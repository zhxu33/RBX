repeat wait() until script.Parent:FindFirstChild("Stamina") and script.Parent:FindFirstChild("MaxStamina")
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local BBG = script:WaitForChild("OverHead")
local Player = game.Players:GetPlayerFromCharacter(script.Parent)
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Fame = PlayerData:WaitForChild("Fame")
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
AvatarF.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username="..Player.Name
local GroupService = game:GetService("GroupService")
local GroupAllies = {}
local GroupId = 3755220
local AllyId = 0
local PrimaryGroupId = 0
local EmblumUrl = 0

local PlayerGroups = GroupService:GetGroupsAsync(Player.UserId)
for _, groupInfo in pairs(PlayerGroups) do
    if groupInfo["IsPrimary"] == true then
    PrimaryGroupId = groupInfo.Id
 	EmblemUrl = groupInfo["EmblemUrl"]
end
end

local AlliesPages = GroupService:GetAlliesAsync(GroupId)
while true do
   for _,group in pairs(AlliesPages:GetCurrentPage()) do
      table.insert(GroupAllies, group)
   end
   if AlliesPages.IsFinished then
      break
   end
   AlliesPages:AdvanceToNextPageAsync()
end

for i,GroupValue in pairs(GroupAllies) do
	if Player:IsInGroup(GroupValue.Id) and GroupValue.Id == PrimaryGroupId then
		AllieId = GroupValue.Id
		AvatarF.Image = EmblemUrl
	end
end

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
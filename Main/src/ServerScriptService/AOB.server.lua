local PlayerConnections = {}
local PlayerConnections2 = {}
local CharacterTable = {}

local TickDelay = .25
local BetweenY1 = 1648.206
local BetweenY2 = 1341.906

local WayAboveX = 10591.199
local WayAboveX_END = 19323.6
local WayAboveX2 = 21370.799

local WayBelowX = -9108

local WayAboveY = 5209.206
local WayBelowY = -43.443

local WayAboveZ = 7896.9
local WayBelowZ = -8488.95

local ArenaAboveZ = 5003.72
local ArenaBelowZ = 2988.02

local TeleportCFrame = CFrame.new(-24.5999107, 1900.52527, -115.99987, 1, 0, 0, 0, 1, 0, 0, 0, 1)

game.Players.PlayerAdded:Connect(function(PLR)
	PlayerConnections[PLR] = PLR.CharacterAdded:Connect(function(CHARACTER)
		table.insert(CharacterTable, CHARACTER)
	end)
	
	PlayerConnections2[PLR] = PLR.CharacterRemoving:Connect(function(CHARACTER)
		table.remove(CharacterTable, table.find(CharacterTable, CHARACTER))
	end)
end)

game.Players.PlayerRemoving:Connect(function(PLR)
	if PlayerConnections[PLR] then PlayerConnections[PLR]:Disconnect() end
	if PlayerConnections2[PLR] then PlayerConnections2[PLR]:Disconnect() end
end)

while true do
	for i=1,#CharacterTable do
		if CharacterTable[i]:FindFirstChild("HumanoidRootPart") and
			
			(CharacterTable[i].HumanoidRootPart.Position.Y <= BetweenY1 and CharacterTable[i].HumanoidRootPart.Position.Y >= BetweenY2) or 
			CharacterTable[i].HumanoidRootPart.Position.Y <= WayBelowY or CharacterTable[i].HumanoidRootPart.Position.Y >= WayAboveY or
			CharacterTable[i].HumanoidRootPart.Position.Z <= WayBelowZ or CharacterTable[i].HumanoidRootPart.Position.Z >= WayAboveZ or
			CharacterTable[i].HumanoidRootPart.Position.X <= WayBelowX or CharacterTable[i].HumanoidRootPart.Position.X >= WayAboveX2 or
			(CharacterTable[i].HumanoidRootPart.Position.X <= WayAboveX_END and CharacterTable[i].HumanoidRootPart.Position.X >= WayAboveX) or 
			(CharacterTable[i].HumanoidRootPart.Position.X >= WayAboveX_END and (CharacterTable[i].HumanoidRootPart.Position.Z <= ArenaBelowZ or CharacterTable[i].HumanoidRootPart.Position.Z >= ArenaAboveZ)) 
			
		then
			
			local SafeTp = Instance.new("BoolValue")
			SafeTp.Name = "SafeTp"
			SafeTp.Parent = CharacterTable[i]
			CharacterTable[i].HumanoidRootPart.CFrame = TeleportCFrame
			game.Debris:AddItem(SafeTp, .1)
			
		end
	end
	wait(TickDelay)
end
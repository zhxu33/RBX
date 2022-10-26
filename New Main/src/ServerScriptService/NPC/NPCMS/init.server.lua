_G.NPCs = {}
_G.PLRs = {}
-- Global Values

-- None Player Character Master Script --
local PhysService = game:GetService("PhysicsService")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
-- Services


local MainModule
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData

local ALs = {   -- Agro Lists
	BadNPC = {},
	GoodNPC = {},
	BadPlayers = {},
	GoodPlayers = {}, 
	NPCDistances = {},   --["Moved"] = {0, 0, 0} [distances[1]] = {}, [distances[2]] = {}, [distances[3]] = {}
	LastCords = {}, 
	LoggedPlayers = {},
	AgroList = {},

	NPCData = {}
}
local distances = {150, 1250, 2500}
-- function values

--------------------------------------------------------------------------------------------------------------------------------------------|
----------------------------------- Start and set up functions -----------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|

function NewPlayer(Player) -- Adding players!
	debug.setmemorycategory("Player Tracker")
	local Data = PlayerData:WaitForChild(Player.Name)
	local Fame = Data:WaitForChild("Fame")
	local Enemy = "BadNPC"
	local Reputation = "GoodPlayers"
	if Fame.Value >= 0 then
		Enemy = "BadNPC"
		Reputation = "GoodPlayers"		
	end
	ALs.NPCDistances[Player.UserId] = {["Enemy"] = Enemy, ["Moved"] = {distances[3]+1, 0, distances[3]+1}, [distances[1]] = {}, [distances[2]] = {}, [distances[3]] = {}}
	for i=1,#ALs[Enemy] do
		table.insert(ALs.NPCDistances[Player.UserId][distances[1]], ALs[Enemy][i])
	end	
	ALs.LastCords[Player.UserId] = Vector3.new(0, math.huge, 0)
	table.insert(ALs[Reputation], Player)
	ALs.LoggedPlayers[Player.UserId] = ALs[Reputation]


	Player.AncestryChanged:Connect(function(Object, parent)
		if not parent then									
			ALs.NPCDistances[Player.UserId] = nil
			ALs.LastCords[Player.UserId] = nil
			ALs[Reputation][Player] = nil
			ALs.LoggedPlayers[Player.UserId] = nil
		end
	end)
	
	Player.CharacterAdded:Connect(function(character)
		local Root = character:WaitForChild("HumanoidRootPart")
		Root.AncestryChanged:Connect(function(Object, parent)
			if not parent then
				if table.find(ALs[Reputation], Player) then
					table.remove(ALs[Reputation], table.find(ALs[Reputation], Player))
				end
				if table.find(_G.PLRs, Root) then
					table.remove(_G.PLRs, table.find(_G.PLRs, Root))
				end
			end
		end)
		table.insert(_G.PLRs, Root)	
		if Fame.Value >= 0 then
			Enemy = "BadNPC"
			Reputation = "GoodPlayers"		
		end
		ALs.NPCDistances[Player.UserId] = {["Enemy"] = Enemy, ["Moved"] = {distances[3]+1, 0, distances[3]+1}, [distances[1]] = {}, [distances[2]] = {}, [distances[3]] = {}}
		for i=1,#ALs[Enemy] do
			table.insert(ALs.NPCDistances[Player.UserId][distances[1]], ALs[Enemy][i])
		end	
		ALs.LastCords[Player.UserId] = Vector3.new(0, math.huge, 0)
		table.insert(ALs[Reputation], Player)
		ALs.LoggedPlayers[Player.UserId] = ALs[Reputation]

		character.AncestryChanged:Wait(1)
		character:WaitForChild("Humanoid")
		character:SetAttribute("Player", true)

		--MainModule.Link(character)
	end)
	local FirstCharacter = Player.Character or Player.CharacterAdded:Wait()
	FirstCharacter:SetAttribute("Player", true)
	local Humanoid = FirstCharacter:WaitForChild("Humanoid")
	if not MainModule then repeat wait() until MainModule end-- MainModule = require(workspace.Model.MainModule) end
	--MainModule.Link(FirstCharacter)
end



function TempLinkUp(NewNpc)
	if not MainModule then repeat wait() until MainModule end
	NewNpc:SetAttribute("NPC", true)	
	MainModule.Link(NewNpc)
	
	local HRP = NewNpc:FindFirstChild("HumanoidRootPart") or NewNpc:WaitForChild("HumanoidRootPart")
	local Hum = NewNpc:FindFirstChild("Humanoid") or NewNpc:WaitForChild("Humanoid")


	Hum:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
	Hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)	
	Hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)	
	
	table.insert(_G.NPCs, HRP)
	local Activated = false
	local function DeadMenTellNoTales()
		if not HRP or Activated then return end 
		Activated = true
		table.remove(_G.NPCs, table.find(_G.NPCs, HRP))

		if Hum and NewNpc.Parent then
			HRP.Anchored = true
			local AnimateDeath = Instance.new("Animation")			
			AnimateDeath.AnimationId = "rbxassetid://8233140570" 
			Hum:LoadAnimation(AnimateDeath):Play()	
			Debris:AddItem(AnimateDeath, 10)
		end
	end
	
	task.spawn(function()
		repeat HRP.AncestryChanged:Wait() until not NewNpc:IsDescendantOf(workspace)
		DeadMenTellNoTales()
	end)
	Hum.Died:Wait()
	DeadMenTellNoTales()
end



Players.PlayerAdded:Connect(NewPlayer)
workspace.NPCs.ChildAdded:Connect(TempLinkUp)
MainModule = require(ServerScriptService.ModulePackage.KnockBack)

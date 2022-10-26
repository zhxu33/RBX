--==============[ SERVICES ]==============--

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--==============[ VARIABLES ]==============--
local PlayerData = workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData")
local DamagePart = script:WaitForChild("DamagePart")
local HitParticle = script:WaitForChild("HitParticle")
local PartyFinder = ReplicatedStorage:WaitForChild("PartyFinder")
local Party = ReplicatedStorage:WaitForChild("Party")
local PVP = ReplicatedStorage:WaitForChild("PVP")

--==============[ BINDABLE + MODULES ]==============--
local DamageFunction = ReplicatedStorage:WaitForChild("DamageFunction")
local ModifierModule = require(script.ModifierModule)

--==============[ FUNCTIONS ]==============--

PVP.OnServerEvent:Connect(function(player,Check)
	local plr = game.Players:FindFirstChild(player.Name)
	local character = player.Character
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
	if PlayerData then
		local Level = PlayerData:FindFirstChild("Level")
		if Check == "Check" and Level then
			if Level.Value >= 500 then
				PVP:FireClient(plr,"Close")
			end
		else
			if character:FindFirstChild("PVPOFF") then
				character:FindFirstChild("PVPOFF"):Destroy()
				local CD = Instance.new("Model", character)
				CD.Name = "PVPCooldown"
				game.Debris:AddItem(CD,60)
				PVP:FireClient(plr,"On")
			else
				if Level.Value < 500 and Level.Value > 50 and not character:FindFirstChild("PVPCooldown") then
					local PVPOFF = Instance.new("Model",character)
					PVPOFF.Name = "PVPOFF"
					PVP:FireClient(plr,"Off")
				end
			end
		end
	end
end)

function FindPartyMember(plr, player)
	local PartyFolder = plr:FindFirstChild("Party")
	local found = false
	if PartyFolder then
		for i, party in ipairs(PartyFolder:GetChildren()) do
			if party.Name == player.Name then
				found = true    
				break
			end
		end
	end
	local EnemyFile = PlayerData:FindFirstChild(player.Name)
	if EnemyFile and not found then
		local EnemyLevel = EnemyFile:FindFirstChild("Level")
		if plr:FindFirstChild("PVPOFF") then
			found = true
		elseif player:FindFirstChild("PVPOFF") then
			found = true
		elseif 	plr:FindFirstChildOfClass("ForceField") and plr:FindFirstChildOfClass("ForceField").Visible == true then
			found = true
		elseif EnemyLevel.Value <= 50 then
			found = true
		end
	end
	return found
end

PartyFinder.OnInvoke = FindPartyMember

Party.OnServerEvent:Connect(function(Player,Type, Name)
	local PartyFolder = Player:FindFirstChild("Party")
	if PartyFolder and not PartyFolder:FindFirstChild("CD") then
		local CD = Instance.new("Model", PartyFolder)
		CD.Name = "CD"
		if Type == "Add" then
			if not PartyFolder:FindFirstChild(Name)  then
				if #PartyFolder:GetChildren() < 10 then
					local NewMember = Instance.new("Model", PartyFolder)
					NewMember.Name = Name
					Party:FireClient(Player, "Player added!")
				else
					Party:FireClient(Player, "Party full!")
				end
			else 
				Party:FireClient(Player, "Player in party!")
			end
		elseif Type == "Remove" then
			if PartyFolder:FindFirstChild(Name) then
				PartyFolder:FindFirstChild(Name):Destroy()
				Party:FireClient(Player, "Player removed!")
			else
				Party:FireClient(Player, "Player not found!")
			end
		elseif Type == "Clear" then
			PartyFolder:ClearAllChildren()
			Party:FireClient(Player, "Party cleared!")
		end
		game.Debris:AddItem(CD, 1)
	end
end)

local function round(number)
	return math.floor(number + 0.5)
end

local AntiOverHeadDetection = {}

DamageFunction.Event:Connect(function(Character, hum, damage, DamageType, NoRicochet, Amount)
	
	local EnemyCharacter = hum.Parent
	local HRT = EnemyCharacter:FindFirstChild("HumanoidRootPart")
	local EnemyTorso = EnemyCharacter:FindFirstChild("UpperTorso")
	local RootPart = Character:FindFirstChild("HumanoidRootPart")
	local Distance = (RootPart.Position - HRT.Position).magnitude
	local RootPartYPosition = RootPart.Position.Y

	if Distance > 500 or RootPartYPosition < 300 and not RootPart.Parent.Parent == workspace.Arena then return end
	
	local CanAttack, isBoss = ModifierModule.PvpStatusCheck(Character, EnemyCharacter)
	if CanAttack then
		
		if EnemyTorso then
			local HitParticleClone = HitParticle:Clone()
			HitParticleClone.Parent = EnemyTorso
			coroutine.wrap(function()
				game.Debris:AddItem(HitParticleClone , .5)
				wait(.1)
				HitParticleClone.Enabled = false
			end)()
		end
		
		--if DamageType then -- Obsolete
		--	if DamageType == "Weapon" then
		--		damage = ModifierModule.GetWeaponAttribute(Character)
		--		print(damage)
		--	end
		--end
		
		local DamageValue = ModifierModule.CalculateNewDamage(damage, Character, EnemyCharacter, NoRicochet)
		
		ModifierModule.ShowDamage(EnemyCharacter, tostring(round(DamageValue/10)))
		if isBoss then
			if EnemyCharacter.PlayersHitted:FindFirstChild(Character.Name) then
				EnemyCharacter.PlayersHitted[Character.Name].Value += DamageValue
			else
				local HitValue = Instance.new("NumberValue")
				HitValue.Name = Character.Name
				HitValue.Value = DamageValue
				HitValue.Parent = EnemyCharacter.PlayersHitted
			end
		end
		hum:TakeDamage(DamageValue)
	else
		for ChildIndex, Child in pairs(HRT:GetChildren()) do
			if Child:IsA("BodyPosition") then
				Child:Destroy()
			end
			if Child.Name == "Light" or Child.Name == "Heavy" then
				local Hitist = Child:FindFirstChild("Hitist")
				if Hitist then
					if Hitist.Value == RootPart then
						Child:Destroy()
					end
				end
			end
		end
	end
	
	--if game.Players:GetPlayerFromCharacter(Character) and not NoRicochet then
	--	if Character and Character.Name and workspace.S1c2R5i66p5t5s51.PlayerData[Character.Name] then
	--		workspace.S1c2R5i66p5t5s51.PlayerData[Character.Name].Experience.Value += Amount or 50
	--	end
	--end
	if Character and workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Character.Name) and not NoRicochet then
		workspace.S1c2R5i66p5t5s51.PlayerData[Character.Name].Experience.Value += Amount or 50
	end
	
	if not Character.Head:FindFirstChild("OverHead") then
		local Player = game.Players:GetPlayerFromCharacter(Character)
		if AntiOverHeadDetection[Player] then
			AntiOverHeadDetection[Player] += 1
		else
			AntiOverHeadDetection[Player] = 1
		end
		if AntiOverHeadDetection[Player] >= 3 then
			--Player:Kick("Potential Exploit")
		end
	end
end)


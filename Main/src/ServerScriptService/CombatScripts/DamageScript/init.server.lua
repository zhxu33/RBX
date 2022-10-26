--==============[ SERVICES ]==============--
local TweenService        = game:GetService("TweenService")
local RunService          = game:GetService("RunService")
local PlayerService       = game:GetService("Players")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Replicated          = game:GetService("ReplicatedStorage")

--==============[ VARIABLES ]==============--
local PlayerData  = workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData")
local DamagePart  = script:WaitForChild("DamagePart")
local HitParticle = script:WaitForChild("HitParticle")
local Modules     = ReplicatedStorage:WaitForChild("Modules")
local PartyFinder = ReplicatedStorage:WaitForChild("PartyFinder")
local Party       = ReplicatedStorage:WaitForChild("Party")
local PVP         = ReplicatedStorage:WaitForChild("PVP")

--==============[ BINDABLE + MODULES ]==============--
local DamageFunction = ReplicatedStorage:WaitForChild("DamageFunction")
local ModifierModule = require(script.ModifierModule)
local SpatialHitbox  = require(ServerScriptService.ModulePackage.SpatialHitbox)
local DamageUtil     = require(Modules:WaitForChild("DamageUtility"))

--==============[ FUNCTIONS ]==============--

PVP.OnServerEvent:Connect(function(player, Check)
	local plr        = PlayerService:FindFirstChild(player.Name)
	local character  = player.Character
	local PlayerData = PlayerData:FindFirstChild(player.Name)
	
	if PlayerData then
		local Level = PlayerData:FindFirstChild("Level")
		if Check == "Check" and Level then
			if Level.Value >= 500 then
				PVP:FireClient(plr,"Close")
			end
		elseif character:FindFirstChild("PVPOFF") then
			character.PVPOFF:Destroy()
			local CD = Instance.new("Model", character)
			CD.Name  = "PVPCooldown"
			game.Debris:AddItem(CD, 60)
			PVP:FireClient(plr,"On")
		elseif Level.Value < 500 and Level.Value > 50 and not character:FindFirstChild("PVPCooldown") then
			local PVPOFF = Instance.new("Model", character)
			PVPOFF.Name  = "PVPOFF"
			PVP:FireClient(plr,"Off")
		end
	end
end)

function FindPartyMember(plr, player)
	local PartyFolder = plr:FindFirstChild("Party")
	if PartyFolder then
		for _, party in ipairs(PartyFolder:GetChildren()) do
			if party.Name ~= player.Name then continue end
			return true
		end
	end
	
	local EnemyFile = PlayerData:FindFirstChild(player.Name)
	if EnemyFile then
		local EnemyLevel = EnemyFile:FindFirstChild("Level")
		
		if plr:FindFirstChild("PVPOFF") then
			return true
		elseif player:FindFirstChild("PVPOFF") then
			return true
		elseif plr:FindFirstChildOfClass("ForceField") and plr:FindFirstChildOfClass("ForceField").Visible then
			return true
		elseif EnemyLevel.Value <= 50 then
			return true
		end
	end
end

PartyFinder.OnInvoke = FindPartyMember

Party.OnServerEvent:Connect(function(Player, Type, Name)
	if not Name then return end
	
	local PartyFolder = Player:FindFirstChild("Party")
	if not PartyFolder or PartyFolder:FindFirstChild("CD") then return end
	
	local CD = Instance.new("Model", PartyFolder)
	CD.Name  = "CD"
	game.Debris:AddItem(CD, 1)
	
	local isFound = PartyFolder:FindFirstChild(Name)
	if Type == "Add" then
		if not isFound then
			if #PartyFolder:GetChildren() < 10 then
				local NewMember = Instance.new("Model", PartyFolder)
				NewMember.Name  = Name
				Party:FireClient(Player, "Player added!")
			else
				Party:FireClient(Player, "Party full!")
			end
		else
			Party:FireClient(Player, "Player in party!")
		end
	elseif Type == "Remove" then
		if isFound then
			isFound:Destroy()
			Party:FireClient(Player, "Player removed!")
		else
			Party:FireClient(Player, "Player not found!")
		end
	elseif Type == "Clear" then
		PartyFolder:ClearAllChildren()
		Party:FireClient(Player, "Party cleared!")
	end
end)

local function round(number)
	return math.floor(number + 0.5)
end

local AntiOverHeadDetection = {}
local TotalDamageList       = {}

-- // Processes damage & if a player can be damaged
function ProcessDamage(Character:Model, hum:Humanoid, damage:number, DamageType:string, NoRicochet:boolean, EXPGain:number)
	local EnemyCharacter = hum.Parent
	local HRT            = EnemyCharacter:FindFirstChild("HumanoidRootPart")
	local EnemyTorso     = EnemyCharacter and EnemyCharacter:FindFirstChild("UpperTorso")
	local RootPart       = Character:FindFirstChild("HumanoidRootPart")

	if RootPart then
		local Distance = (RootPart.Position - HRT.Position).magnitude
		if Distance > 750 then return end
	end
	
	local CanAttack, isBoss = ModifierModule.PvpStatusCheck(Character, EnemyCharacter)
	
	if CanAttack then
		if EnemyTorso then
			local HitParticleClone  = HitParticle:Clone()
			HitParticleClone.Parent = EnemyTorso
			game.Debris:AddItem(HitParticleClone , .1)
		end

		local AggroCharacter = Character
		local Character      = (PlayerService:FindFirstChild(Character.Name) and PlayerService[Character.Name].Character) or Character
		local DamageValue = ModifierModule.CalculateNewDamage(damage, Character, EnemyCharacter, DamageType, NoRicochet)
		if not DamageValue then return end

		if isBoss then
			-- // New damage detection method
			local DamageLogged = false
			if EnemyCharacter:FindFirstChild("DamageEvent") then
				local Player = PlayerService:FindFirstChild(Character.Name)
				if Player then
					local Damage = hum.Health < DamageValue and hum.Health or DamageValue
					EnemyCharacter.DamageEvent:Fire(Player, Damage)
				end
				DamageLogged = true
			end

			-- // Obsolete damage detection (Backwards compatible)
			if not DamageLogged then
				if EnemyCharacter.PlayersHitted:FindFirstChild(Character.Name) then
					EnemyCharacter.PlayersHitted[Character.Name].Value += DamageValue
				else
					local HitValue  = Instance.new("NumberValue")
					HitValue.Name   = Character.Name
					HitValue.Value  = DamageValue
					HitValue.Parent = EnemyCharacter.PlayersHitted
				end
			end
		end
		
		-- // Npc aggro
		if EnemyCharacter:FindFirstChild("Aggro") then
			EnemyCharacter.Aggro:Fire(AggroCharacter)
		end
		
		if hum.Health > 0 then 
			-- // Showing damage to player
			DamageUtil:DisplayMessage(DamageUtil:GetInfo(Character, EnemyCharacter, tostring(round(DamageValue/10))))
			--ModifierModule.ShowDamage(EnemyCharacter, tostring(round(DamageValue/10)))
			
			local currentHealth = hum.Health
			local died          = currentHealth <= DamageValue and not (EnemyCharacter:FindFirstChildWhichIsA("ForceField"))
			
			-- // Dealing damage to npc
			hum:TakeDamage(DamageValue)
			
			if died then -- // Clearance
				hum.Health = 0
				EnemyCharacter:BreakJoints()
			end
		end
		
		if PlayerService:FindFirstChild(Character.Name) and EnemyCharacter:GetAttribute("Punching_Bag") then

			local Player = game.Players:GetPlayerFromCharacter(Character)
			local Quirks = {10, 18, 19}
			local PlayerData =  workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Character.Name)
			local ExpMultiplier = 1 * (if table.find(Quirks, PlayerData.Quirk.Value) then .2 else 1)
				
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, 4746076) --[[or Player.Name == "Jeffycry65"]] then
				ExpMultiplier = 10
				local PlayerData =  workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Character.Name)
				local Gain = 250*ExpMultiplier+PlayerData.Level.Value*2
				PlayerData.Experience.Value = PlayerData.Experience.Value + Gain
			else
				PlayerData.Experience.Value = PlayerData.Experience.Value + (250*ExpMultiplier)
			end

		end
		
		if EnemyCharacter:FindFirstAncestor("NPCs") and PlayerService:FindFirstChild(Character.Name) then
			EnemyCharacter:SetAttribute("Target", PlayerService[Character.Name].UserId)
		end
	end

	local PlayerData = PlayerData:FindFirstChild(Character.Name)
	if Character and PlayerData and not NoRicochet then
		PlayerData.Experience.Value += EXPGain or 50
	end

	if Character:FindFirstChild("Head") and not Character.Head:FindFirstChild("OverHead") then
		local Player = game.Players:GetPlayerFromCharacter(Character)
		if not Player then return end
		local Prev = AntiOverHeadDetection[Player] or 0
		AntiOverHeadDetection[Player] = Prev + 1

		if AntiOverHeadDetection[Player] >= 3 then
			--Player:Kick("Potential Exploit")
		end
	end
end

DamageFunction.Event:Connect(ProcessDamage)

if SpatialHitbox.OnHit then
	SpatialHitbox.OnHit:Connect(function(Player, HitChar, AttackSettings, ExtraVal)
		local Humanoid = HitChar:FindFirstChild("Humanoid")
		if not Humanoid then return end
		ExtraVal = ExtraVal or {}
		
		ProcessDamage(Player, Humanoid, ExtraVal.Damage, ExtraVal.DamageType, false, ExtraVal.EXPGain)
	end)
end

script.GetDamage.OnInvoke = function()
	local new = TotalDamageList
	
	table.sort(new, function(a, b)
		if a < b then
			return true
		end
	end)
	
	return new
end

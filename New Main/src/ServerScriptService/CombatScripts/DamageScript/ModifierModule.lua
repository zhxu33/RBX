local Modifiers = {}

 --==============[ SERVICES ]==============--
local ServerStorage       = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService          = game:GetService("RunService")
local PlayerService       = game:GetService("Players")
local TweenService        = game:GetService("TweenService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")

--==============[ MODULES ]==============--

local UtilityModule = require(ServerScriptService.ModulePackage.KnockBack.Utility)

 --==============[ VARIABLES ]==============--
local PartyFolder      = ServerStorage.Parties
local DamagePart       = script.Parent:FindFirstChild("DamagePart")
local PlayerData       = workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData")
local RequiredPvpLevel = 50
local HighestDamage    = 9000000

local ColorPalette = {
	["Protected"]         = Color3.fromRGB(40, 210, 25),
	["Party"]             = Color3.fromRGB(0, 255, 2255),
	["Low Level"]         = Color3.fromRGB(255, 255, 0),
	["PVP Disabled"]      = Color3.fromRGB(255, 0, 255),
	
	["Permeated"]         = Color3.fromRGB(255, 255, 255),
	["Void"]              = Color3.fromRGB(255, 255, 255),
	["Teleport"]          = Color3.fromRGB(255, 255, 255),
	["Reconstructing"]    = Color3.fromRGB(255, 255, 255),
	["Dodged"]            = Color3.fromRGB(255, 255, 255),
	
	["AlreadyDead"]       = Color3.fromRGB(0, 174, 255),
}

local PvpEnabledProtectedStates = {
	["PermeatMode"] = "Permeated",
	["Hole"]        = "Void",
	["Warping"]     = "Teleport",
	["Reconstruct"] = "Reconstructing",
	["JetAttack"]   = "Dodged",
	["WarpMode"]    = "Void",
	["AlreadyDead"] = "Stop, I'm already dead.",
}

 --==============[ DAMAGE BINDABLE ]==============--
local DamageFunction = ReplicatedStorage:WaitForChild("DamageFunction")

 --==============[ FUNCTIONS ]==============--

function Modifiers:ShowDamage(Damage) -- Shows the damage dealt, or if no damage is being done, shows why
	local DamagePartClone  = DamagePart:Clone()
	DamagePartClone.Parent = self
	local DamageGuiClone   = DamagePartClone.DamageGui
	
	local Color = Color3.fromRGB(255, 0, 0)
	if ColorPalette[Damage] then
		Color = ColorPalette[Damage]
		DamageGuiClone.Frame.DamageText.TextStrokeTransparency = .6
	end
	DamageGuiClone.Frame.DamageText.TextColor3       = Color
	DamageGuiClone.Frame.DamageText.TextStrokeColor3 = Color
	DamageGuiClone.Frame.DamageText.Text             = Damage
	
	DamagePartClone.CFrame = (self.PrimaryPart or self.HumanoidRootPart).CFrame
	TweenService:Create(DamageGuiClone, TweenInfo.new(.75), {StudsOffset = Vector3.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))}):Play()
	game.Debris:AddItem(DamagePartClone, 1)
end

function Modifiers:GetWeaponAttribute() -- Gets the weapon damage if any
	local Weapon = self:FindFirstChild("WObj").Value
	local DamageMultiplier = Weapon:GetAttribute("Damage")
	
	local Data = PlayerData:FindFirstChild(self.Name)
	local Damage = Data.Strength.Value*DamageMultiplier*10 -- Multiplying by 10 because the script is going off the new damage multiplier instead of the old
	
	return Damage
end

function Modifiers:PvpStatusCheck(Enemy) -- Checks if player can deal damage to the enemy
	local CanPvp = true
	local isBoss = false
	
	local Player     = PlayerService:FindFirstChild(self.Name)
	local EnemPlayer = PlayerService:FindFirstChild(Enemy.Name)
	
	-- Checks if they're both not npcs
	if not Player and not EnemPlayer then
		return false
	end
	
	-- Checks if enemy character is a boss
	if Enemy:FindFirstChild("PlayersHitted") or Enemy:FindFirstChild("DamageEvent") then
		isBoss = true
	end
	
	-- Checks if you're not attacking yourself / a clone 
	if Enemy.Name == self.Name then return false end
	
	-- Checks if both users are players
	--if Player and EnemPlayer then
	--	return false
	--end
	
	-- Checks if Enemy is a punching bag
	if string.lower(Enemy.Name) == "punching bag" then
		return true
	end
	
	-- Checking if player is part of player party
	if Player then
		if Player.Party:FindFirstChild(Enemy.Name) then
			Modifiers.ShowDamage(Enemy, "Party")
			return false
		end
	end
	
	-- Checking if player or enemy player has force field on
	local UserFF = self:FindFirstChildOfClass("ForceField")
	local EnemFF = Enemy:FindFirstChildOfClass("ForceField")
	if UserFF or EnemFF then
		if EnemFF then
			if not EnemFF.Visible and not PvpEnabledProtectedStates[EnemFF.Name] then
				return false
			elseif PvpEnabledProtectedStates[EnemFF.Name] then
				Modifiers.ShowDamage(Enemy, PvpEnabledProtectedStates[EnemFF.Name])
				return false
			end
		elseif UserFF then
			if not PvpEnabledProtectedStates[UserFF.Name] then
				Modifiers.ShowDamage(self, "Protected")
				return false
			end
		end
	end
	
	-- Check player level if they're a player
	if Player and EnemPlayer then
		if PlayerData[self.Name].Level.Value < RequiredPvpLevel or PlayerData[Enemy.Name].Level.Value < RequiredPvpLevel then
			Modifiers.ShowDamage(Enemy, "Low Level")
			return false
		end 
	end
	
	-- Check if player is in safezone
	if self:FindFirstChild("Safezone") or Enemy:FindFirstChild("Safezone") then
		Modifiers.ShowDamage(Enemy, "Protected")
		return false
	end
	
	-- Check if player has pvp mode off
	if self:FindFirstChild("PVPOFF") or Enemy:FindFirstChild("PVPOFF") then
		if PlayerService:GetPlayerFromCharacter(self) and PlayerService:GetPlayerFromCharacter(Enemy) then
			Modifiers.ShowDamage(Enemy, "PVP Disabled")
			return false
		end
	end	
	
	return CanPvp, isBoss
end

-- // adds additional methods to affect damage output
local damageMethods = {}
function Modifiers:AddDamageMethod(func_name, func)
	assert(type(func) == "function", "Expected function, got: " .. type(func))
	damageMethods[func_name or tostring(func)] = func
end

-- // gets the new damage from extra sources
function Modifiers:CalculateNewDamage(Character, Enemy, DamageType, NoRicochet) -- Recalculates damage based on specific settings from weapons
	local newDamage = self
	if NoRicochet then return newDamage end
	
	newDamage = UtilityModule.GetDamage(Character, self, DamageType)
	
	if not newDamage then 
		warn("UtilityModule.GetDamage() returned" 
			.. newDamage      .. "damage. \n Variables: " 
			.. Character.Name .. ","
			.. Enemy.Name     .. "," 
			.. NoRicochet     .. ". \n" 
			.. debug.traceback()) 
		return 0
	end

	local hum     = Enemy.Humanoid
	local EnemyAttributes = Enemy:GetAttributes()
	local UserAttributes  = Character:GetAttributes()
	
	local Armor   = EnemyAttributes.ArmorDefense or 0
	local Defense = EnemyAttributes.Defense      or 1
	local Boost   = UserAttributes.DamageBoost   or 1

	if not PlayerService:FindFirstChild(Character.Name) then
		Boost = 2
	end
	
	newDamage = ((newDamage*Boost)-Armor)/Defense
	newDamage = newDamage < 0 and 0 or newDamage > HighestDamage and HighestDamage or newDamage
	
	local CanRicochet = not NoRicochet and hum.Health > newDamage and newDamage > 0 
	if CanRicochet and EnemyAttributes.Impact_Recoil then
		DamageFunction:Fire(Enemy, Character.Humanoid, math.abs(newDamage*0.5), nil, true)
	end

	if CanRicochet and EnemyAttributes.Spiked then
		DamageFunction:Fire(Enemy, Character.Humanoid, math.abs(newDamage*0.05), nil, true)
	end
	
	-- // Runs added damage methods
	for method_name, method in pairs(damageMethods) do
		local prev, success = newDamage, nil
		success, newDamage = pcall(method, newDamage, Character, Enemy)
		
		if not success then warn(("Function %s errored with: %s"):format(method_name, newDamage)); newDamage = prev end;
		if not newDamage then newDamage = prev end
	end
	
	return newDamage
end

return Modifiers

local Modifiers = {}

 --==============[ SERVICES ]==============--
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

 --==============[ MODULES ]==============--
local InformationModule = require(ServerStorage.QuirkModules.ModuleInformation)

 --==============[ VARIABLES ]==============--
local PartyFolder = ServerStorage.Parties
local DamagePart = script.Parent:FindFirstChild("DamagePart")
local PlayerData = workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData")
local RequiredPvpLevel = 50
local HighestDamage = 9000000

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
}

local PvpEnabledProtectedStates = {
	["PermeatMode"] = "Permeated",
	["Hole"]        = "Void",
	["Warping"]     = "Teleport",
	["Reconstruct"] = "Reconstructing",
	["JetAttack"]   = "Dodged",
	["WarpMode"]    = "Void",
}

 --==============[ DAMAGE BINDABLE ]==============--
local DamageFunction = ReplicatedStorage:WaitForChild("DamageFunction")

 --==============[ FUNCTIONS ]==============--

function Modifiers:ShowDamage(Damage) -- Shows the damage dealt, or if no damage is being done, shows why
	local DamagePartClone = DamagePart:Clone()
	DamagePartClone.Parent = self
	local DamageGuiClone = DamagePartClone.DamageGui
	
	local Color = Color3.fromRGB(255, 0, 0)
	if ColorPalette[Damage] then
		Color = ColorPalette[Damage]
		DamageGuiClone.Frame.DamageText.TextStrokeTransparency = .6
	end
	DamageGuiClone.Frame.DamageText.TextColor3 = Color
	DamageGuiClone.Frame.DamageText.TextStrokeColor3 = Color
	
	DamageGuiClone.Frame.DamageText.Text = Damage
	DamagePartClone.CFrame = self.PrimaryPart.CFrame
	game.Debris:AddItem(DamagePartClone, 1)
	TweenService:Create(DamageGuiClone, TweenInfo.new(.75), {StudsOffset = Vector3.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))}):Play()
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
	
	-- Checks if enemy character is a boss
	if Enemy:FindFirstChild("PlayersHitted") then
		isBoss = true
	end
	
	-- Checks if you're not attacking yourself / a clone 
	if Enemy.Name == self.Name then return false end
	
	-- Checks if self is a player and Enemy is an npc
	--if PlayerService:GetPlayerFromCharacter(self) and not PlayerService:GetPlayerFromCharacter(Enemy) then
	--	return true, isBoss
	--end
	
	-- Checks if Enemy is a punching bag
	if string.lower(Enemy.Name) == "punching bag" then
		return true
	end
	
	-- Checking if player is part of player party
	if game.Players:FindFirstChild(self.Name) then
		if game.Players[self.Name].Party:FindFirstChild(Enemy.Name) then
			Modifiers.ShowDamage(Enemy, "Party")
			return false
		end
	end
	
	-- Checking if player or enemy player has force field on
	if self:FindFirstChildOfClass("ForceField") or Enemy:FindFirstChildOfClass("ForceField") then
		if Enemy:FindFirstChildOfClass("ForceField") then
			if not Enemy:FindFirstChildOfClass("ForceField").Visible and not PvpEnabledProtectedStates[Enemy:FindFirstChildOfClass("ForceField").Name] then
				return false
			elseif PvpEnabledProtectedStates[Enemy:FindFirstChildOfClass("ForceField").Name] then
				Modifiers.ShowDamage(Enemy, PvpEnabledProtectedStates[Enemy:FindFirstChildOfClass("ForceField").Name])
				return false
			end
		elseif self:FindFirstChildOfClass("ForceField") then
			if not PvpEnabledProtectedStates[self:FindFirstChildOfClass("ForceField").Name] then
				Modifiers.ShowDamage(self, "Protected")
				return false
			end
		end
	end
	
	-- Check player level if they're a player
	if PlayerService:GetPlayerFromCharacter(self) and PlayerService:GetPlayerFromCharacter(Enemy) then
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
	
	-- Checks if they're both not npcs
	if not PlayerService:GetPlayerFromCharacter(self) and not PlayerService:GetPlayerFromCharacter(Enemy) and not PlayerService:FindFirstChild(Enemy.Name) then
		return false
	end
	
	return CanPvp, isBoss
end

function Modifiers:CalculateNewDamage(Character, Enemy, NoRicochet) -- Recalculates damage based on specific settings from weapons
	local newDamage = InformationModule.GetDamage(Character, self)
	
	--local DamageBoost = Character:FindFirstChild("DamageBoost")
--	local EnemyArmorDefense = Enemy:FindFirstChild("ArmorDefense")
	local hum = Enemy.Humanoid
--	local DamageBoost = Character:FindFirstChild("DamageBoost")
	
	local Armor = 0
	local Defense = 1
	local Boost = 1
	
	if Enemy:GetAttribute("Defense") then
		Defense = Enemy:GetAttribute("Defense")
	end
	
	if Enemy:GetAttribute("ArmorDefense") then
		Armor = Enemy:GetAttribute("ArmorDefense")
	end
	
	if Enemy:GetAttribute("DamageBoost") then
		Boost = Enemy:GetAttribute("DamageBoost")
	elseif not PlayerService:GetPlayerFromCharacter(Character) then
		Boost = 2
	end
	
	newDamage = ((newDamage*Boost)-Armor)/Defense

	if newDamage < 0 then
		newDamage = 0
	elseif newDamage > HighestDamage then
		newDamage = HighestDamage	
	end
	
	if not NoRicochet and Enemy:GetAttribute("Impact_Recoil") and hum.Health > newDamage and newDamage > 0 then
		DamageFunction:Fire(Enemy, Character.Humanoid, newDamage*0.5, nil, true)
	end

	if not NoRicochet and Enemy:GetAttribute("Spiked") and hum.Health > newDamage and newDamage > 0 then
		DamageFunction:Fire(Enemy, Character.Humanoid, newDamage*0.05, nil, true)
	end
	
	return newDamage
end

return Modifiers

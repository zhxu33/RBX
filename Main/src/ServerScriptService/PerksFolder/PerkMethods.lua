-- // Services
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService       = game:GetService("Players")
local Replicated          = game:GetService("ReplicatedStorage")

-- // Variables
local CombatFolder = ServerScriptService.CombatScripts
local MainScript   = ServerScriptService.SurvivalMainScript
local NpcRewards   = Replicated.Modules.NPCs.NPCReward
local PERK_FOLDER  = ServerScriptService:WaitForChild('PerksFolder')
local List         = {}

-- // Modules
local PerkProfiles = require(PERK_FOLDER.PerkProfiles)
--[[
Perk.RespawnFunctions  = {} -- // Plays when a player respawns
Perk.DamageFunctions   = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions  = {} -- // Plays when a player dies
Perk.OnKillFunctions   = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions    = {} -- // Plays when the player is being hit
Perk.OnRewardFunctions = {} -- // Plays when the player is being rewarded
]]

function List.RespawnFunction()
	-- // PERK PROFILES (Done there)
end

function List.DamageFunction()
	local DamageMod = require(CombatFolder.DamageScript.ModifierModule)
	if not (DamageMod.AddDamageMethod) then warn("Damage Method not found in module."); return end
	DamageMod:AddDamageMethod("perk_damage_method", function(Damage, Player, ...)
		local Player = PlayerService:GetPlayerFromCharacter(Player)
		if not Player then return end
		local Profile = PerkProfiles:GetProfile(Player)

		local RetVal = Profile:FireDamageFunctions(Damage, Player, ...)
		if RetVal then Damage = RetVal end
		
		return Damage
	end)
end

function List.RewardFunction()
	local RewardsMod = require(NpcRewards)
	if not (RewardsMod.AddRewardMethod) then warn("Reward method not found in module."); return end
	RewardsMod:AddRewardMethod("perk_reward_method", function(Reward, Player, ...)
		local Player  = Player
		local Profile = PerkProfiles:GetProfile(Player)
		
		local RetVal = Profile:FireRewardFunctions(Reward, ...)
		if RetVal then Reward = RetVal end
		
		return Reward
	end)
end

function List.OnDeathFunction()
	-- PERK PROFILES (Done there)
end

function List.OnKillFunction()
	local RaidFunctions = require(ServerScriptService.NPC.OlderVersionModules.NpcSetup)
	if not (RaidFunctions.AddProcessMethod) then warn("On defeat methods not found in module."); return end
	RaidFunctions:AddProcessMethod("on_defeat_method", function(Player, ...)
		local Profile = PerkProfiles:GetProfile(Player)

		Profile:FireKillFunctions(...)
	end)
end

function List.OnHitFunction()
	local DamageMod = require(CombatFolder.DamageScript.ModifierModule)
	if not (DamageMod.AddDamageMethod) then warn("Damage Method not found in module."); return end
	
	DamageMod:AddDamageMethod("perk_onhit_method", function(Damage, UserAttacking, Player, ...)
		local Player = PlayerService:GetPlayerFromCharacter(Player)
		if not Player then return end
		local Profile = PerkProfiles:GetProfile(Player)

		local RetVal = Profile:FireHitFunctions(Damage, UserAttacking, Player, ...)
		if RetVal then Damage = RetVal end
		
		return Damage
	end)
end

-- // T
local module = {}

function module:Enable()
	for _, f in pairs(List) do f() end
end

return module
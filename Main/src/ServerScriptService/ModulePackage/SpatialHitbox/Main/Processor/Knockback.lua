-- // Services
local ServerStorage       = game:GetService("ServerStorage")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- // Variables
local Mod = {}

-- // Settings
Mod.Activated = true
if not Mod.Activated then return Mod end

-- // Modules
local StunModule = require(ServerScriptService.ModulePackage.KnockBack)

-- // Firing function for module
function Mod:Fire(Char:Model, HitChar:Model, Settings:{}, Extra)
	if not Extra then return end
	
	-- // Knockback / freeze options, if either is enabled (Only one can be used at once)
	if Settings.Knockback then
		local KnockbackTable = {
			StunType       = Settings.VelocityType,
			KnockbackType  = Settings.KnockbackType,
			HitCharacter   = HitChar,
			Stunner        = Settings.Player,
			Duration       = Settings.KnockbackDuration,
			Force          = Settings.KnockbackPower,
			ImpactPosition = (Settings.Object.CFrame * Settings.ImpactOffSet).Position,
			Overwrite      = Settings.Overwrite, 
		}
		StunModule.Knockback(KnockbackTable)
	elseif Settings.CanFreeze then
		local FreezeTable = {
			HitCharacter   = HitChar,
			Freezer        = Settings.Player,
			FreezeImmunity = Settings.FreezeImmunity,
			FreezeType     = Settings.FreezeType,
			Duration       = Settings.FreezeDuration,
		}
		StunModule.Freeze(FreezeTable)
	end
end

return Mod
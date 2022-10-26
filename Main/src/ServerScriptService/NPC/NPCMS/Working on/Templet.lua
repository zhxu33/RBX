----- Please reference the "CodersGuide" script for more information on each of these functions / tables.

local module = {}
local NPCFs = require(script.Parent.Parent.NPCFs)
local SpatialHitbox = require(7496792123)
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local DmgFunction = game:GetService("ReplicatedStorage"):WaitForChild("DamageFunction")
local DefaultAnimations = game:GetService("ServerScriptService").NPC.NPCMS.DefaultAnimations
local MoveParents = workspace.Debris

-- Animations
module.Animations  =
	{
		Animation = script.Animation
	}

-- Values
module.Values = -- Fool list of attack combos.
	{
		Damage = 12500,
		PowerLevel = 1,
		Power = 75,
		BlockMultiplier = 3,
		AgroRange = 50,
		Defense = 3,
		WalkSpeed = 140
	}

module.Behaviors =  -- Behaviors, things the npc will do according to info put here, the guide has more info.
	{
		MinFollowDistance = 15, 
		JumpDistanceTrigger = 50, 
		MaxFollowDistance = 100,
		MovePause = 0.75,
		StunDuration = 0.75,
		BlockDuration = 1,
		StartDash = "Backward",
		Chase = true
	}

local MoveSetConditions1 = {
	["Absolute"]  = {},
	["Preferred"] = {},
}
local MoveSetConditions2 = {
	["Absolute"]  = {},
	["Preferred"] = {},
}
local MoveSetConditions3 = {
	["Absolute"]  = {},
	["Preferred"] = {},
}


module.FullCList = -- Fool list of attack combos.
	{
		[1] = {["MoveSet"] = {}, ["Conditions"] = MoveSetConditions1},
		[2] = {["MoveSet"] = {}, ["Conditions"] = MoveSetConditions2},
		[3] = {["MoveSet"] = {}, ["Conditions"] = MoveSetConditions3},
	}

--{"Dodge", "QAttack", "Pause", "QAttack", "VAttack"} Options
module.Cooldowns =  -- all the cooldowns for moves after use, they are stored here and then counted down every time a move is used until they get to one and are added back to the tactics list.
	{
		[1] = {["Cooldown"] = {1, 1}, ["Moves"] = {1}, ["AlwaysActive"] = true},
		[2] = {["Cooldown"] = {2.5, 2.5}, ["Moves"] = {2}},
		[3] = {["Cooldown"] = {5, 5}, ["Moves"] = {3}},
	}


module.Moves = {
}


function module.Moves.FirstAttack(NPC, Target) -- This npc's first attack
	local HumanoidRootPart = NPC.HumanoidRootPart
	NPC.Humanoid.Animator:LoadAnimation(module.Animations.BurstingInferno):Play()
	local newSettings = {
		HitboxType     = "Touched",
		Player         = NPC,
		MoveDuration   = 1.5,
		Damage         = module.Values.Damage*3,
		Parent         = "modelparent",
		KnockbackPower = 75,
		NPC            = true,
	}
	SpatialHitbox.Add("hitbox", newSettings)
end

function module.Moves.SecondAttack(NPC, Target) -- This npc's first attack	
	
end

function module.Moves.ThirdAttack(NPC, Target) -- This npc's first attack	
	
end


return module
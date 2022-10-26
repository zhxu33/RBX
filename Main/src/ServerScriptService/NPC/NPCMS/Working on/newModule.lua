----- Please reference the "CodersGuide" script for more information on each of these functions / tables.

local module            = {}
local MoveParents       = workspace.Debris
local Debris            = game:GetService("Debris")
local DefaultAnimations = script.Parent.Parent.DefaultAnimations
local NPCFs             = require(script.Parent.Parent.NPCFs)
local DmgFunction       = game:GetService("ReplicatedStorage"):WaitForChild("DamageFunction")
local TweenService      = game:GetService("TweenService")
--local SpatialHitbox     = require(7496792123)
--local RaycastHitbox     = require(7496725777)

-- Animations
module.Animations  =
	{
		
	}

-- Values
module.Values = -- Fool list of attack combos.
	{
		Damage          = 1,
		PowerLevel      = 1,
		Power           = 1,
		BlockMultiplier = 1,
		AgroRange       = 1,
		Defense         = 1,
		WalkSpeed       = 1,
	}

module.Behaviors = 
	{
		MinFollowDistance   = 1, 
		JumpDistanceTrigger = 1, 
		MaxFollowDistance   = 1,
		MovePause           = 1,
		StunDuration        = 1,
		BlockDuration       = 1,
		StartDash           = nil,
		Chase               = true,
	}

local MoveConditions1 = {
	["Absolute"]  = {},
	["Preferred"] = {},
}

module.FullCList = -- Fool list of attack combos.
	{
		[1] = {["MoveSet"] = {"Chase", "FirstAttack"}, ["Conditions"] = MoveConditions1},
	}

--{"Dodge", "QAttack", "Pause", "QAttack", "VAttack"} Options
module.Cooldowns =  -- all the cooldowns for moves after use, they are stored here and then counted down every time a move is used until they get to one and are added back to the tactics list.
	{
		[1] = {["Cooldown"] = {1,1}, ["Moves"] = {1}, ["AlwaysActive"] = true},
	}


module.Moves = {
}

local AnimeCycle = 0
function module.Moves.FirstAttack(NPC, Target) -- This npc's first attack
	
end

return module
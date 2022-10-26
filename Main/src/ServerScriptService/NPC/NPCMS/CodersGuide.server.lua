--Hey there! This should help answer any questions you have on how things work relating to NPCs.

--------------------------------------------------------------------------------------------------------------------------------------------|
----------------------------------- NPC Module Information ---------------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|
-- This part of the guide will provide information on the modules in the NPC folder located just above this guide.

-- To Find information on a particular function please search it's name excluding the "module." before it.

--[[ "module.Animations"
The "Animations" table is strait forward. These are animations you use in the module script.

Howerver, there is a secondary function as any animation you give here that is reference in the NPCMS, or "None Player Character Master Script", such as:
HeavyStunned, 
Stunned,
BlockAnim.

These animation are replaced by your reference when placed here with the same reference name.

module.Animations  = 
	{
		ReferenceName = script.Animation,
	}

]]

--[[ "Values"

This is a series of values that send info for the script to know how to scale certain abilites or features.

All the listed values will be within the example function with basic summaries provided.

module.Values =
	{
		Damage = 2500,                           "Damage"|--| Base damage, mainly used within the module itself.
		PowerLevel = 1,                      "PowerLevel"|--| Start multiplier, don't add this if it you don't want power to scale with hp such as normal NPC. 
		Power = 250,                              "Power"|--| Power is referenced mainly to determine the power in dashes and other movement features.
		StartDash = "Forward"                 "StartDash"|--| "Forward", dash forward when start, "Backward", Inverese of foward.
	}

]]

--[[ "Behaviors"

A set of values that determine certain behaviors for the npc. The example function below will list all the different options.

module.Behaviors = 
	{
		MinFollowDistance = 20,       "MinFollowDistance"|--| This is the distance when the NPC will start attacking.
		JumpDistanceTrigger = 50,   "JumpDistanceTrigger"|--| This is the max difference in height before the npc jumps to get to them.
		MaxFollowDistance = 200,      "MaxFollowDistance"|--| This is how far away the player can be from the NPC's starter position before it returns to spawn.
		AlwaysActiveMoves = 1         "AlwaysActiveMoves"|--| This is how many moves start from one upwards that will always be within the "Tactics" cycle.
	}
]]

--[[ "FullCList"

This function is a list of strings that reference functions for combat moves. Asign it a number starting from upwards so the script can reference it.

The strings are derived from both functions made in the "Moves" and from the NPCFs script located just below this script. 

module.FullCList =
	{
		[1] = {"Chase", "FirstAttack"}
	}

Please reference the "General NPCFs Combat Functions" section to understand what functions are preprogramed to reference in this list.
]]

--[[ "Cooldowns"

This list references all the moves currently on cooldowns. You can add or take away any amount down to 1 and up. 

The cooldowns work through number references made in "FullCList" which can be anything from a single move to a long and complex combo.

After a combo or move as been used it will be added back to a spot according to it's number given, so it is important to make strong moves higher up in said order.

module.Cooldowns = 
	{
		[1] = {}
		[2] = {}
		[3] = {}
	}
]]	

--[[ "Tactics"

A very simple list that shows all moves that the npc has access from the get go and is used on runtime to hold moves that can be used when thier cooldown is complete

This list will keep up to the "AlwaysActiveMoves" value from the "Behaviors" list or default to one.

module.Tactics =
	{
		1
	}
]]

--[[ "Moves"

The "Moves" list is a list of all functions special to this npc. Typically combat related functions.

module.Moves = {
}


function module.Moves.FirstAttack(NPC, Target) -- This npc's first attack
	-- Insert code for actrual move here.
end
]]

-- I hope this has answered any questions you have on how to use the NPC Modules. 
-- Good luck, I am going to leave this end part of a comment here so people read it. No other reason.
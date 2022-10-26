MainInformation = {}

------------------------------ [ MAIN VARIABLES ] -----------------------------

-- GLOBAL CONFIGURATION --

MainInformation.Base_Damage = 10					--	The damage multiplier for all moves

-- STUN CONFIGURATION --

MainInformation.DefaultStunTime = 1.5				--	The default value of the stun duration (For how long the target is stunned for)
MainInformation.DefaultFreezeTime = .5				-- 	The default value of the freeze duration (For how long the target is frozen for)
MainInformation.DefaultFreezeImmunityTime = 3		-- 	The default value of the freeze immunity (The time before the target is able to be frozen again)

MainInformation.DefaultKnockbackForce = 25			--	The default knockback force of the stun module's knockback function

MainInformation.StunFilter = "None"					--	Will blacklist characters from being stunned. Values: "None" | "Players" | "NPCs" | "Everyone"

-- BLOCK CONFIGURATION --

MainInformation.Base_Unblock_Defense = 1			-- 	The default defense value (without modifiers)
MainInformation.Stamina_Consumption_Rate = 10		-- 	The amount of stamina it will deplete while blocking per specified time
MainInformation.Stamina_Consumption_Delay = .1		--	The delay before your stamina depletes per a specified amount while blocking

-- PUNCH CONFIGURATION --

MainInformation.Base_Punch_Multiplier = 1			--  The damage multiplier for punching
MainInformation.Punch_Stamina_Cost = 10				--	The stamina cost for punching

-- TRAINING CONFIGURATION --

MainInformation.EXP_Gain = 50						--  The amount of EXP you gain when training
MainInformation.Training_Stamina_Cost = 0			--	Stamina cost for training

-- SPEED/AGILITY CONFIGURATION --

MainInformation.Default_Speed = 18					-- 	The default speed of a player (Walk Speed)
MainInformation.Max_Speed = 140						--  The highest speed you can have when you reach it's agility cap
MainInformation.Agility_Cap = 2000					--	The cap at which your sprint speed will stop increasing
MainInformation.Speed_Per_Agility = 0.05			--	The amount of sprint speed you receive for each agility point
MainInformation.Start_Speed = 40					--	The minimum sprint speed
MainInformation.Stamina_Cost_Rate = 2				--	The amount of stamina it will decrease while sprinting per specified time
MainInformation.Stamina_Cost_Delay = .1				--	The delay before your stamina drains per a specified while blocking

-- STAMINA CONFIGURATION --

MainInformation.Stamina_Regeneration_Rate = 2/100	--	The percentage of your maximum stamina that the user regenerates per specified interval
MainInformation.Stamina_Regeneration_Delay = .25	--	

MainInformation.Stamina_Modifier_Drain_Rate = .1	--	The delay before a specified modifier drains your stamina by the specified amount

MainInformation.Starting_Stamina = 100				--	The base stamina (The stamina you start with)
MainInformation.Agility_To_Stamina_Multiplier = 1	--	The amount of stamina you receive from an agility point

-- HEALTH CONFIGURATION --

MainInformation.Starting_Health = 75				--	The amount of health you start with
MainInformation.Health_Per_Durability = 150			--	The amount of health a durability point provides
MainInformation.Health_Regeneration_Rate = .1/100	--	The percentage of your maximum health that the user regenerates per specified interval
MainInformation.Health_Regeneration_Delay = .1		--	The delay before your health regenerates per specified amount
MainInformation.Health_Modifier_Drain_Rate = .1		--	The delay before a modifier drains your health per the amount specified

-- DAMAGE MODULE CONFIGURATION --

MainInformation.MaximumDamage = 9000000				--	The highest damage a player can deal.
MainInformation.MaximumRicochetDamage = 100000		--	The highest damage a player can reflect.
MainInformation.DefaultEXPPerHit = 50				--	The default amount of exp the damager gains.
MainInformation.MinimumLevel = 50					--	The minimum level at which they can deal or get dealt damage.

MainInformation.Impact_Recoil_Percentage = 0.5		--  The multiplier in which the Impact Recoil Form will reflect back.
MainInformation.Spiked_Percentage = 0.05			--  The multiplier in which the Egg Pauldrons will reflect back.

MainInformation.DefaultAttributeValues = {

	Player					= true,
	Stunned 				= false,
	Frozen 					= false,
	FreezeImmunity 			= 0,
	Attacking				= false,
	Dashing					= false,
	UsingForm				= false,
	Punching				= false,
	Cannot_Run				= false,
	Protected				= false,

	Defense 				= MainInformation.Base_Unblock_Defense,
	ArmorDefense 			= 1,
	DamageBoost 			= 1,
	DamageBoost_Quirk		= 1,
	DamageBoost_Booster		= 1,
	Spiked 					= false,
	Weapon_Type 			= "N/A",
	Weapon_ID 				= "N/A",
	Tool_Type				= "N/A",
	Tool_ID 				= "N/A"

}

MainInformation.Safezone_Whitelisted_Forms = {

	["Engine_Dash"] 		= true

}

MainInformation.QuirkFreezeImmunityValues = {

	["HHHC"] 				= 7,
	["Pop Off"] 			= 7,
	["Somnambulist"] 		= 5,
	["Electrification"] 	= 4

}

MainInformation.QuirkFreezeTimeValues = {

	["HHHC_Both"] 			= 1,
	["HHHC_Ice"] 			= 1.5,
	["Pop Off"] 			= 3,
	["Somnambulist"] 		= 2

}

----------------------------- [ PERMANENT BUFFS ] -----------------------------

MainInformation.PermanentBuffs = {
	[5] = {
		["HealthRegenerationBoost"] = 1.5
	},
	[12] = {
		["Defense"] = 3.5,
		["StunResistance"] = true,
		["BlockDefense"] = 2.5
	},
	[31] = {
		["Defense"] = 1.2,
		["StunResistance"] = 0.5
	}
}

------------------------------- [ FORM BUFFS ] -------------------------------

-- [ DEFAULT VALUES ]  --
MainInformation.DefaultFormValues = {

	Gadget = false,								-- If true, it will automatically toggle itself if the Tool_Type Attribute Value matches the name of said Form.
	Defense = 1,								-- Set's the defense value to the specified amount if said Form is activated.
	BlockDefense = 3,							-- While blocking, it'll multiply the defense by said amount instead of the default 3x.
	DamageBoost = 1,							-- Will multiply the damage by said number if said Form is activated.
	StunResistance = 0,							-- The amount of stun resistance time it'll reduce when said Form is activated, if set to true it'll completely negate stuns.
	StaminaConsumption = 0,						-- The amount of stamina it'll consume per Stamina_Modifier_Drain_Rate while said Form is activated.
	DisableStaminaRegen = false,				-- If set to true, it Will disable stamina regeneration while said form is activated.
	StaminaUseReduction = 1,					-- The multiplier at which your stamina will be consumed by .IncrementStamina(). (Gaining stamina is not affected by this).
	HealthConsumption = 0,						-- The amount of health it'll consume per Health_Modifier_Drain_Rate while said form is activated.
	DisableHealthRegen = false,					-- If set to true, it will disable health regeneration while said form is activated.
	PunchMultiplier = 1,						-- Will multiply the punch damage by said number when said Form is activated.
	HealthRegenerationBoost = 1					-- The multiplier at which your health will regenerate alongside the normal health regeneration.

}

-- [ QUIRK VALUES ] --
MainInformation.Forms = require(script.QuirkForms)
MainInformation.Forms.All.Blocking.StaminaConsumption   = MainInformation.Stamina_Consumption_Rate
MainInformation.Forms[0].Engine_Dash.StaminaConsumption = MainInformation.Stamina_Cost_Rate


-------------------------- [ NPC PERMANENT BUFFS ] --------------------------

MainInformation.NPCs = {
	["All Might 1"] = {
		["StunResistance"] = .75,
		["Defense"] = 3
	},
	["AllForOne"] = {
		["StunResistance"] = .75,
		["Defense"] = 3
	},
	["Tomura"] = {
		--		["StunResistance"] = .25,
	},
	["Overhaul"] = {
		["StunResistance"] = .5,
		["Defense"] = 1.2
	}
}

---------------------------- [ NPC FORM BUFFS ] ----------------------------

MainInformation.NPCForms = {
	["All Might 1"] = {
		["Name"] = "Plus_Ultra",
		["StunResistance"] = true,
		["DamageBoost"] = 1.5
	},
	["AllForOne"] = {
		["Name"] = "Springlock_Limbs",
		["StunResistance"] = true,
		["Defense"] = 1.2,
		["DamageBoost"] = 1.5
	},
	["Overhaul"] = {
		["Name"] = "Fusion",
		["StunResistance"] = true,
		["Defense"] = 1.2,
		["DamageBoost"] = 1.5
	}
}

return MainInformation
local Forms = {}

Forms.All = {
	Blocking = {
		Defense = 3,
		StaminaConsumption = nil,
		StunResistance = 1,
		MoveType = "Form"
	}
}

Forms[0] = { -- Engine
	Engine_Dash = {
		DamageBoost = 1.1,
		StaminaConsumption = nil,
		StunResistance = 0.5,
		MoveType = "Form"
	},
	Recipro_Burst = {
		DamageBoost = 1.25,
		StunResistance = 1
	},
	Recipro_Kick = {
		StunResistance = true
	},
	Recipro_Extend = {
		StunResistance = true
	}
}

Forms[1] = { -- HHHC
	HHHCVest = {
		Gadget = true,
		DamageBoost = 1.1
	},
	IceSlide = {
		StunResistance = .5,
		StaminaConsumption = 10,
		MoveType = "Quirk_Move2"
	},
	HHHC_Flamethrower = {
		StaminaConsumption = 25,
		MoveType = "Quirk_Move2"
	}
}

Forms[2] = { -- One For All
	Plus_Ultra = {
		DamageBoost = 1.2,
		StaminaConsumption = 10,
		StunResistance = 1,
		MoveType = "Form"
	},
	RedGauntlet = {
		Gadget = true,
		DamageBoost = 1.15
	}
}

Forms[3] = { -- Quirkless
	DekuJournal = {
		Gadget = true,
		DamageBoost = 2
	}
}

Forms[4] = { -- Zero Gravity
	UrarakaCostume = {
		Gadget = true,
		DamageBoost = 1.5
	},
	ZeroGravityMode = {
		StunResistance = .25,
		StaminaConsumption = 2.5,
		DamageBoost = 1.2,
		MoveType = "Form"
	}
}

Forms[5] = { -- Regeneration
	NoumuKneeBrace = {
		Gadget = true,
		HealthRegenerationBoost = 1.15
	},
	DrainPunch = {
		StaminaConsumption = 3,
		MoveType = "Quirk_Move2"
	},
	Excel_Heal = {
		HealthRegenerationBoost = 2,
		StaminaConsumption = 20,
		DisableStaminaRegen = true,
		MoveType = "Quirk_Move2"
	}
}

Forms[6] = { -- Explosion
	ExplosionMode = {
		DamageBoost = 1.2,
		StaminaConsumption = 5,
		StunResistance = .25,
		MoveType = "Form"
	},
	FlightMode = {
		StaminaConsumption = 10,
		MoveType = "Quirk_Move2"
	},
	Gauntlet = {
		Gadget = true,
		Damageboost = 1.2
	}
}

Forms[7] = { -- Electrification
	ElectricBody = {
		DamageBoost = 1.25,
		StaminaConsumption = 2,
		MoveType = "Form"
	},
	SharpShootingGear = {
		Gadget = true
	}
}

Forms[8] = { -- Warp Gate
	WarpPortalling = {
		StaminaConsumption = 10,
		MoveType = "Quirk_Move2"
	},
	MetalBrace = {
		Gadget = true,
		Defense = (1/.85)
	}
}

Forms[9] = { -- Gigantification
	Gigantification = {
		Defense = 2,
		StaminaConsumption = 1,
		PunchMultiplier = 1.5,
		StunResistance = 1,
		MoveType = "Form"
	},
	GiantHorn = {
		Gadget = true,
		Defense = 1.2
	}
}

Forms[10] = { -- Voice
	Speakers = {
		Gadget = true,
		DamageBoost = 1.25
	}
}

Forms[11] = { -- Air Propulsion
	Respirator = {
		Gadget = true,
		DamageBoost = 1.2
	}
}

Forms[13] = { -- Deku One For All
	Full_Cowl_20 = {
		StunResistance = .2,
		StaminaConsumption = 2.5,
		MoveType = "Form"
	},
	Full_Cowl_50 = {
		StunResistance = .4,
		StaminaConsumption = 5,
		MoveType = "Form"
	},
	Full_Cowl_100 = {
		StunResistance = .6,
		StaminaConsumption = 10,
		MoveType = "Form"
	},
	IronSole = { -- DamageBoost is configured in the quirk's script.
		Gadget = true,
		StunResistance = .15
	},
}

Forms[14] = { -- Hardening
	HardenMode = {
		Defense = 1.5,
		DamageBoost = 1.3,
		StunResistance = 1,
		MoveType = "Form"
	},
	Unbreakable = {
		Defense = 2,
		DamageBoost = 1.6,
		StaminaConsumption = 3,
		StunResistance = true,
		MoveType = "Form"
	},
	HardenGear = {
		Gadget = true,
		DamageBoost = 1.25
	}
}

Forms[15] = { -- Hell Flame
	FlightMode = {
		StunResistance = true,
		StaminaConsumption = 2.5,
		MoveType = "Form"
	},
	HellFlameMode = {
		DamageBoost = 1.2,
		StunResistance = .5,
		StaminaConsumption = 2.5,
		MoveType = "Form"
	},
	HellFlameArmor = {
		Gadget = true,
		DamageBoost = 1.1,
		StunResistance = .5
	}
}

Forms[16] = { -- Overhaul
	Fusion = {
		Defense = 1.2,
		DamageBoost = 1.2,
		StaminaConsumption = 10,
		StunResistance = true,
		MoveType = "Form"
	},
	OverhaulMask = { -- DamageBoost configured in the quirk's script. (0.5x damage increase for spike moves)
		Gadget = true
	}
}

Forms[17] = { -- Jet
	JetBoots = {
		Gadget = true,
		DamageBoost = 1.25
	}
}

Forms[18] = { -- Blackhole
	BlackHoleSuck = {
		StunResistance = true,
		StaminaConsumption = 5,
		MoveType = "Quirk_Move2"
	},
	BlackHoleBody = {
		StunResistance = true,
		StaminaConsumption = {1/100, "%"},
		DisableStaminaRegen = true,
		Defense = 2,
		SpeedBoost = 1.15, -- // 115%
		MoveType = "Quirk_Move2"
	},
	ThirteenGloves = {
		Gadget = true,
		DamageBoost = 1.2
	}
}

Forms[19] = { -- Cremation
	FlameMode = {
		DamageBoost = 1.2,
		StunResistance = .5,
		StaminaConsumption = 5,
		MoveType = "Form"
	},
	IncineratingBlast = {
		StaminaConsumption = 1,
		MoveType = "Quirk_Move2"
	}
}

Forms[20] = { -- Dark Shadow
	DarkShadow = {
		StaminaConsumption = 1,
		PunchMultiplier = 1.5,
		MoveType = "Form"
	},
	AbyssalBody = {
		DamageBoost = 1.2,
		PunchMultiplier = 1.5,
		Defense = 1.5,
		StaminaConsumption = 2.5,
		MoveType = "Form"
	},
	ShadowFlight = {
		StaminaConsumption = 5,
		MoveType = "Form"
	},
	ShadowCape = {
		Gadget = true,
		DamageBoost = 1.2
	}
}

Forms[21] = { -- Muscle Augmentation
	MuscularEye = {
		Gadget = true,
		DamageBoost = 1.2,
	},
	MuscleArms = {
		PunchMultiplier = 1.5,
		StaminaConsumption = 3,
		MoveType = "Form"
	},
	MuscleLegs = {
		StaminaConsumption = 6,
		MoveType = "Form"
	},
	MuscleChest = {
		Defense = (1/.65),
		BlockDefense = 2.25, 
		StunResistance = 1,
		StaminaConsumption = 9,
		MoveType = "Form"
	}
}

Forms[22] = { -- Permeation
	Permeating = {
		HealthConsumption = {1/200, "%"},
		DisableHealthRegen = true,
		MoveType = "Form"
	},
	PermeatMode = {
		StunResistance = true
	},
	PermeationCape = { -- Cooldown reduction configured in the quirk's script.
		Gadget = true
	}
}

Forms[23] = { -- Pop Off
	GrapeOveruse = {
		HealthConsumption = {1/500, "%"},
		DisableHealthRegen = true
	},
	MinetaCostume = {
		Gadget = true,
		DamageBoost = 1.1,
		Defense = 1.15
	}
}

Forms[24] = { -- Somnambulist
	MidnightBelt = {
		Gadget = true,
		DamageBoost = 1.25
	},
	SomnambulistMode = {
		StaminaConsumption = 2.5,
		DamageBoost = 1.25,
		MoveType = "Form"
	},
	SomnambulistThrow = {
		StaminaConsumption = 1.5,
		StunResistance = .75,
		MoveType = "Quirk_Move2"
	}
}

Forms[25] = { -- Navel Laser
	LaserBelt = {
		Gadget = true,
		DamageBoost = 1.2
	},
	NavelFlight = {
		StunResistance = 1,
		StaminaConsumption = 20,
		DisableStaminaRegen = true,
		MoveType = "Form"
	}
}

Forms[26] = { -- Decay
	TomuraHands = {
		Gadget = true,
		DamageBoost = 1.2
	},
	DecayMode = {
		Defense = 1.1,
		DamageBoost = 1.25,
		StunResistance = .75,
		StaminaConsumption = 5,
		MoveType = "Form"
	},
	DecayTouch = {
		StunResistance = 1,
		StaminaConsumption = 1,
		MoveType = "Quirk_Move2"
	},
	DecayDash = {
		StunResistance = 1
	}
}

Forms[27] = { -- Acid
	CottonAndShoes = {
		Gadget = true,
		DamageBoost = 1.5,
		StunResistance = 1
	},
	AcidSlide = {
		StunResistance = .5,
		StaminaConsumption = 10,
		DisableStaminaRegen = true,
		MoveType = "Quirk_Move2"
	}
}

Forms[28] = { -- Creation
	MomoBelt = {
		Gadget = true,
		StaminaUseReduction = .8
	},
	LuckyBag = {},
	IronShield = {
		Defense = 1.25,
		StunResistance = 1,
		MoveType = "Form"
	}
}

Forms[29] = { -- Clones
	EctoplasmMask = {
		DamageBoost = 1.2
	}
}

Forms[30] = { -- All For One
	Impact_Recoil = {
		Defense = 2,
		StunResistance = .5,
		StaminaConsumption = 20,
		DisableStaminaRegen = true,
		MoveType = "Form"
	},
	Respirator = {
		Gadget = true,
		Defense = (1/.85), -- 15%
		StunResistance = .5,
		StaminaUseReduction = 0.9,
	},
	Springlock_Limbs = {
		DamageBoost = 1.2,
		Defense = 1.2,
		StunResistance = .3,
		StaminaConsumption = 10,
		MoveType = "Form"
	}
}

Forms[31] = { -- Tail
	Tail_Spin = {
		Defense = 2/1.2,
		StunResistance = 0.5
	},
	OjiroCostume = {
		Gadget = true,
		DamageBoost = 1.2
	}
}

Forms[32] = { -- Frog
	Camouflage = {
		StaminaConsumption = 20,
		MoveType = "Form"
	},
	FrogSuit = {
		Gadget = true,
		DamageBoost = 1.1
	}
}

Forms[33] = { -- Fierce Wings
	FierceWings_Flight = {
		StaminaConsumption = 4,
		DisableStaminaRegen = true,
		MoveType = "Form"
	},
	WingHeadphones = {
		Gadget = true,
		Defense = 1.2,
		StunResistance = .5
	},
	FierceBarrage = {}, -- Placeholder for Z move.
	FierceDash = {
		StunResistance = .5
	}
}

Forms[34] = { -- Tomura's All For One
	TomuraHands = {
		Gadget = true,
		DamageBoost = 1.2
	},
	Awakened_DecayForm = {
		StaminaConsumption = 6,
		Defense = 1.2,
		DamageBoost = 1.2,
		MoveType = "Form"
	},
	Awakened_DecayDash = {
		StunResistance = 1
	},
	TAFO_Regeneration = {
		HealthRegenerationBoost = 5,
		StaminaConsumption = 40,
		DisableStaminaRegen = true,
		MoveType = "Quirk_Move2"
	}
}

Forms[35] = { -- Orcinus
	OrcinusHead = { -- Reduces cooldowns in the quirk script.
		Gadget = true,
		DamageBoost = 1.1
	},
	OrcaForm = {
		DamageBoost = 1.2,
		StunResistance = .5,
		StaminaConsumption = 4,
		MoveType = "Form"
	},
	Orca_Barraging = {}, -- Placeholder for Z move.
	Orca_Dashing = {
		StunResistance = .5
	}
}

Forms[36] = { -- Manifest
	TamakiCostume = {
		Gadget = true,
		StunResistance = .5,
		DamageBoost = 1.2
	},
	KrakenMask = {
		DamageBoost = 1.2,
		StunResistance = .75,
		StaminaConsumption = 10,
		MoveType = "Form"
	},
	Manifest_WingDash = {
		StunResistance = .5
	}
}

Forms[37] = { -- Big Fist
	ItsukaCostume = {
		Gadget = true,
		DamageBoost = 1.2
	},
	BigFists = {
		PunchMultiplier = 3,
		MoveType = "Form"
	}
}

return Forms
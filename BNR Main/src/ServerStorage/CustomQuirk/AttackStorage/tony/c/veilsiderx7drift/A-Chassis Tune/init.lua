--[[
	    ___      _______                _       _______
	   / _ |____/ ___/ /  ___ ____ ___ (_)__   /__  __/
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<     / /
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/	/_/   
						SecondLogic @ Inspare
						Avxnturador @ Novena
							RikOne2 @ Enjin
]]

local Tune = {}

--[[Misc]]
	Tune.LoadDelay		= .1		-- Delay before initializing chassis (in seconds)
	Tune.AutoStart		= false		-- Set to false if using manual ignition plugin
	Tune.AutoFlip		= true		-- Set to false if using manual flip plugin
	
--[[Wheel Alignment]]
	--[Don't physically apply alignment to wheels]
	--[Values are in degrees]
	Tune.FCamber		= -5
	Tune.RCamber		= -5
	Tune.FCaster        = 0
	Tune.FToe			= 0
	Tune.RToe			= 0
	
--[[Weight and CG]]
	Tune.Weight			= 1000		-- Total weight (in pounds)
	Tune.WeightBSize	= {			-- Size of weight brick (dimmensionws in studs ; larger = more stable)
	 --[[Width]]		6.5		,
	 --[[Height]]		4.8		,
	 --[[Length]]		17		}
	Tune.WeightDist		= 51		-- Weight distribution (0 - on rear wheels, 100 - on front wheels, can be <0 or >100)
	Tune.CGHeight		= .7		-- Center of gravity height (studs relative to median of all wheels)
	Tune.WBVisible		= false		-- Makes the weight brick visible
	
	--Unsprung Weight
	Tune.FWheelDensity	= .1		-- Front Wheel Density
	Tune.RWheelDensity	= .1		-- Rear Wheel Density
	Tune.FWLgcyDensity	= 1			-- Front Wheel Density [PGS OFF]
	Tune.RWLgcyDensity	= 1			-- Rear Wheel Density [PGS OFF]
	
	Tune.AxleSize		= 2			-- Size of structural members (larger = MORE STABLE / carry more weight)
	Tune.AxleDensity	= .1		-- Density of structural members
	
--[[Susupension]]
	Tune.SusEnabled		= true		-- Sets whether suspension is enabled for PGS
	
	--Front Suspension
	Tune.FSusStiffness	= 25000		-- Spring Force
	Tune.FSusDamping	= 400		-- Spring Dampening
	Tune.FAntiRoll 		= 400		-- Anti-Roll (Gyro Dampening)
	
	Tune.FSusLength		= 1.9		-- Resting Suspension length (in studs)
	Tune.FPreCompress	= .1		-- Pre-compression adds resting length force
	Tune.FExtensionLim	= .4		-- Max Extension Travel (in studs)
	Tune.FCompressLim	= .2		-- Max Compression Travel (in studs)
	Tune.FSusAngle		= 75		-- Suspension Angle (degrees from horizontal)
		
	Tune.FWsBoneLen		= 5			-- Wishbone Length
	Tune.FWsBoneAngle	= 2			-- Wishbone angle (degrees from horizontal)
	Tune.FAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.4		,	-- positive = outward
	 --[[Vertical]]		-.5		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	
	--Rear Suspension
	Tune.RSusStiffness	= 20000		-- Spring Force
	Tune.RSusDamping	= 400		-- Spring Dampening
	Tune.RAntiRoll 		= 400		-- Anti-Roll (Gyro Dampening)
	
	Tune.RSusLength		= 2.1		-- Resting Suspension length (in studs)
	Tune.RPreCompress	= .1		-- Pre-compression adds resting length force
	Tune.RExtensionLim	= .4		-- Max Extension Travel (in studs)
	Tune.RCompressLim	= .2		-- Max Compression Travel (in studs)
	Tune.RSusAngle		= 80		-- Suspension Angle (degrees from horizontal)
	
	Tune.RWsBoneLen		= 5			-- Wishbone Length
	Tune.RWsBoneAngle	= 2			-- Wishbone angle (degrees from horizontal)
	Tune.RAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.4		,	-- positive = outward
	 --[[Vertical]]		-.5		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward

	--Aesthetics (PGS ONLY)
	Tune.SusVisible		= true			-- Spring Visible
	Tune.WsBVisible		= false			-- Wishbone Visible
	Tune.SusRadius		= .2			-- Suspension Coil Radius
	Tune.SusThickness	= .1			-- Suspension Coil Thickness
	Tune.SusColor		= "Red"		-- Suspension Color [BrickColor]
	Tune.SusCoilCount	= 8				-- Suspension Coil Count
	Tune.WsColor		= "Black"		-- Wishbone Color [BrickColor]
	Tune.WsThickness	= .1			-- Wishbone Rod Thickness

--[[Wheel Stabilizer Gyro]]
	Tune.FGyroDamp		= 100		-- Front Wheel Non-Axial Dampening
	Tune.RGyroDamp		= 100		-- Rear Wheel Non-Axial Dampening
	
--[[Steering]]
	Tune.SteerInner		= 70		-- Inner wheel steering angle (in degrees)
	Tune.SteerOuter		= 70		-- Outer wheel steering angle (in degrees)
	Tune.SteerSpeed		= 1.2534		-- Steering increment per tick (in degrees)
	Tune.ReturnSpeed	= 1.0234		-- Steering increment per tick (in degrees)
	Tune.SteerDecay		= 320		-- Speed of gradient cutoff (in SPS)
	Tune.MinSteer		= 10		-- Minimum steering at max steer decay (in percent)
	Tune.MSteerExp		= 1			-- Mouse steering exponential degree
	
	--Steer Gyro Tuning
	Tune.SteerD			= 1200		-- Steering Dampening
	Tune.SteerMaxTorque	= 50000		-- Steering Force
	Tune.SteerP			= 7000		-- Steering Aggressiveness
	
--[[Engine]]

	--		[TORQUE CURVE VISUAL]
	--		https://www.desmos.com/calculator/nap6stpjqf
	--		Use sliders to manipulate values
	--		Edit everything as if your car is NATURALLY aspirated, or as if it lacks a turbo.
	
	Tune.Horsepower		= 568
	Tune.IdleRPM		= 700
	Tune.PeakRPM		= 7000
	Tune.Redline		= 8000
	Tune.EqPoint		= 5252
	Tune.PeakSharpness	= 20
	Tune.CurveMult		= 0.2
	
	Tune.InclineComp	= 1.7		-- Torque compensation multiplier for inclines (applies gradient from 0-90 degrees)
	
	--Turbo Settings
	Tune.Aspiration		= "Double"												--[[
	[Aspiration]
		"Natural"		: N/A, Naturally aspirated engine
		"Single"		: Single turbocharger
		"Double"		: Twin turbocharger											]]
	
	Tune.Boost			= 15		--Max PSI per turbo (If you have two turbos and this is 15, the PSI will be 30)
	Tune.TurboSize		= 65		--Turbo size; the bigger it is, the more lag it has.
	Tune.CompressRatio	= 9			--The compression ratio (look it up)
	
	--Misc
	Tune.RevAccel		= 150		-- RPM acceleration when clutch is off
	Tune.RevDecay		= 75		-- RPM decay when clutch is off
	Tune.RevBounce		= 500		-- RPM kickback from redline
	Tune.IdleThrottle	= 3			-- Percent throttle at idle
	Tune.ClutchTol		= 500		-- Clutch engagement threshold (higher = faster response, lower = more stable RPM)
	
--[[Drivetrain]]	
	Tune.Config			= "RWD"		--"FWD" , "RWD" , "AWD"
	
	--Differential Settings	
	Tune.FDiffSlipThres	= 50		-- 1 - 100%				(Max threshold of applying full lock determined by deviation from avg speed)
	Tune.FDiffLockThres	= 0			-- 0 - 100%				(0 - Bias toward slower wheel, 100 - Bias toward faster wheel)
	Tune.RDiffSlipThres	= 100		-- 1 - 100%
	Tune.RDiffLockThres	= 0			-- 0 - 100%
	Tune.CDiffSlipThres	= 1			-- 1 - 100%				[AWD Only]
	Tune.CDiffLockThres	= 0			-- 0 - 100%				[AWD Only]
	
	--Traction Control Settings
	Tune.TCSEnabled		= false		-- Implements TCS
	Tune.TCSThreshold	= 20		-- Slip speed allowed before TCS starts working (in SPS)
	Tune.TCSGradient	= 20		-- Slip speed gradient between 0 to max reduction (in SPS)
	Tune.TCSLimit		= 10		-- Minimum amount of torque at max reduction (in percent)
	
--[[Transmission]]
	Tune.TransModes		= {"Semi", "Auto"}												--[[
	[Modes]
		"Auto"		: Automatic shifting
		"Semi"		: Clutchless manual shifting, dual clutch transmission
		"Manual"	: Manual shifting with clutch
		
		>Include within brackets
			eg: {"Semi"} or {"Auto", "Manual"}								
		>First mode is default mode													]]
	
	--Automatic Settings
	Tune.AutoShiftMode	= "RPM"												--[[
	[Modes]
		"Speed"		: Shifts based on wheel speed
		"RPM"		: Shifts based on RPM											]]	
	Tune.AutoUpThresh	= -200		-- Automatic upshift point 	(relative to peak RPM, positive = Over-rev)
	Tune.AutoDownThresh = 1400		-- Automatic downshift point (relative to peak RPM, positive = Under-rev)
	Tune.ShiftTime = 0				-- The time delay in which you initiate a shift and the car changes gear
	
	--Gear Ratios
	Tune.FinalDrive		= 3.21		 --	[TRANSMISSION CALCULATIONS FOR NERDS]
	Tune.Ratios			= {			 --		SPEED [SPS]	 = (Wheel diameter(studs) * pi(3.14) * RPM) / (60 * Gear Ratio * Final Drive * Multiplier)
		--[[Reverse]]	5.000		,--		WHEEL TORQUE = Engine Torque * Gear Ratio * Final Drive * Multiplier
		--[[Neutral]]	0			,
		--[[ 1 ]]		3.519      	,
		--[[ 2 ]]		2.320		,
		--[[ 3 ]]		1.700		,
		--[[ 4 ]]		1.400		,
		--[[ 5 ]]		0.907		,
	}
	Tune.FDMult			= 1.3			-- Ratio multiplier (Change this value instead of FinalDrive if car is struggling with torque ; Default = 1)
	
--[[Brakes]]
	Tune.ABSEnabled		= false		-- Implements ABS
	Tune.ABSThreshold	= 20		-- Slip speed allowed before ABS starts working (in SPS) 

	Tune.FBrakeForce	= 1500		-- Front brake force
	Tune.RBrakeForce	= 2300		-- Rear brake force
	Tune.PBrakeForce	= 6000		-- Handbrake force
	
	Tune.FLgcyBForce	= 15000		-- Front brake force [PGS OFF]
	Tune.RLgcyBForce	= 10000		-- Rear brake force [PGS OFF]
	Tune.LgcyPBForce	= 25000		-- Handbrake force [PGS OFF]
	
--[[[Default Controls]]
	--Peripheral Deadzones
	Tune.Peripherals = {
		MSteerWidth				= 67		,	-- Mouse steering control width	(0 - 100% of screen width)
		MSteerDZone				= 10		,	-- Mouse steering deadzone (0 - 100%)
		
		ControlLDZone			= 5			,	-- Controller steering L-deadzone (0 - 100%)
		ControlRDZone			= 5			,	-- Controller steering R-deadzone (0 - 100%)
	}
	
	--Control Mapping
	Tune.Controls = {
		
	--Keyboard Controls
		--Mode Toggles
		ToggleTCS				= Enum.KeyCode.T					,
		ToggleABS				= Enum.KeyCode.Y					,
		ToggleTransMode			= Enum.KeyCode.M					,
		ToggleMouseDrive		= Enum.KeyCode.R					,
		
		--Primary Controls
		Throttle				= Enum.KeyCode.Up					,
		Brake					= Enum.KeyCode.Down					,
		SteerLeft				= Enum.KeyCode.Left					,
		SteerRight				= Enum.KeyCode.Right				,
		
		--Secondary Controls
		Throttle2				= Enum.KeyCode.W					,
		Brake2					= Enum.KeyCode.S					,
		SteerLeft2				= Enum.KeyCode.A					,
		SteerRight2				= Enum.KeyCode.D					,
		
		--Manual Transmission
		ShiftUp					= Enum.KeyCode.E					,
		ShiftDown				= Enum.KeyCode.Q					,
		Clutch					= Enum.KeyCode.LeftShift			,
		
		--Handbrake
		PBrake					= Enum.KeyCode.LeftShift					,
		
	--Mouse Controls
		MouseThrottle			= Enum.UserInputType.MouseButton1	,
		MouseBrake				= Enum.UserInputType.MouseButton2	,
		MouseClutch				= Enum.KeyCode.W					,
		MouseShiftUp			= Enum.KeyCode.E					,
		MouseShiftDown			= Enum.KeyCode.Q					,
		MousePBrake				= Enum.KeyCode.LeftShift			,
		
	--Controller Mapping
		ContlrThrottle			= Enum.KeyCode.ButtonR2				,
		ContlrBrake				= Enum.KeyCode.ButtonL2				,
		ContlrSteer				= Enum.KeyCode.Thumbstick1			,
		ContlrShiftUp			= Enum.KeyCode.ButtonY				,
		ContlrShiftDown			= Enum.KeyCode.ButtonX				,
		ContlrClutch			= Enum.KeyCode.ButtonR1				,
		ContlrPBrake			= Enum.KeyCode.ButtonL1				,
		ContlrToggleTMode		= Enum.KeyCode.ButtonB				,
		ContlrToggleTCS			= Enum.KeyCode.DPadDown				,
		ContlrToggleABS			= Enum.KeyCode.ButtonL3				,
	}
	
--[[Standardized Values: Don't touch unless needed]]
	
	--[WEIGHT // Cubic stud : pounds ratio]
	Tune.WeightScaling = 1/50	--Default = 1/50 (1 cubic stud = 50 lbs)
	Tune.LegacyScaling = 1/10	--Default = 1/10 (1 cubic stud = 10 lbs) [PGS OFF]
	--[ENGINE // Caching]
	Tune.CurveCache = true		--Default = true (Caches the engine and boost curves)
	Tune.CacheInc = 100 		--Default = 100 (How many points the curve will have.)
	--[[Examples: 1 = every RPM increment [will freeze your computer at low settings like this], 
				  100 = default and recommended, 
				  1000 or more = death															]]
	
return Tune
--[[                                           <<DO NOT DELETE THIS MODULE>>
   ___      _______                _       _______
  / _ |____/ ___/ /  ___ ____ ___ (_)__   /__  __/
 / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<     / /
/_/ |_|   \___/_//_/\_,_/___/___/_/___/	   /_/   Build 6T, Version 6.72
				SecondLogic @ Inspare
				Avxnturador @ Novena
					RikOne2 @ Enjin
					
					Special thanks to Zyori and JustinianCode for some included things.

>>Manual

Basically, everything you can and would ever want to touch is in the tuning module. EVERYTHING

Torque Curve Tune Visualizer (Boost Included):
https://www.desmos.com/calculator/nap6stpjqf

Basic Tips:
--Installation
	>Everything is built-in (assembly, welding, suspension, gyros), so all you have to worry about is placing the wheels and the seat.
	>Body parts go in the "Body" section.
	>Wheel parts such as 3D rims and brake disks go in the "Parts" section of the wheel.
	>Suspension-Anchored parts such as suspension wishbones and linkages go in the "SuspensionFixed" section.
	>Axle-Anchored parts such as calipers go in the "WheelFixed" section.
	>You can add or remove wheels. To add a wheel, simply copy one of the wheels and make sure it's named one of the following: "F","FL","FR","R","RL","RR".
	>Wheels need to be aligned with the axes of the seat. Don't rotate the seat relative to the wheels as it may cause welding problems.
	>All wheel offsets are applied in the tuning module. Do NOT manually add offset to the wheels. Steering axis is centered on the wheel part by default.
	>Seat offset can be adjusted in the "MiscWeld" module under "Initialize".
	>Use the "Misc" section for scripted/moving parts and apply welding using the "MiscWeld" module under "Initialize".

--Tuning
	>Reduce weight(density) if setup is lacking torque. Increase density if setup has too much torque.
	>Add downforce manually if setup is lacking grip or use a downforce plugin.
	>Dialing in ratios used in real cars is an easy way to have a realisticly tuned transmission.
	>Modifying the "Drive" script may affect the integrity of the system.
	>Custom scripts should be put in the "Plugins" folder. Using plugins made by other users is encouraged.
	>When writing custom plugins, you can reference the values within the "Values" folder inside the A-Chassis Interface.
	>It is a good practice to make plugins compatible with any setup and providing a usage manual if a plugin is released.
	>You can remove/change the default plugins that come with the kit. The drive system will still work perfectly with or without them.
	
--Updates
	>To update, simply just replace the entire "A-Chassis Tune" module of an existing car with a newer version of the module if the car already has AC6T installed. Otherwise it's preferred you copy the new values over.
	>You may want to copy the tune values and plugins from the old module, but dont simply overwrite the tune module as new values may be added.
	

>>AC6 T Changelog
	[05/05/18 : A-Chassis T Build 6.72] - The Final Bugfixes
		[Tune Changes]
			-"RAntiRoll" is fixed and an actual value, beforehand it only had 2 FAntiRolls and no RAntiRolls.
			
		[Transmission Changes]
			-Automatic transmission has been properly fixed and works flawlessly.
		
		[Thanks]
			-Thanks for using this chassis, I'll see ya in the bike chassis. -Avxnturador
			
		Install by changing the Drive script, and by changing "FAntiRoll" in line 70 to "RAntiRoll" in the Tune.
			
	[04/11/18 : A-Chassis T Build 6.7] - The Final Update
		[IMPORTANT]
			-A whole re-write of the chassis has been done. Taking AC6.52S2 and re-writing everything, most bugs from other versions should be removed
			
		[Drive Changes]
			-Curve caching is mandatory and always on, CurveCache and CacheInc is removed
			-Wheel RPM is now fixed and gets the rotation velocity from ALL driven wheels
			
		[Boost Changes]
			-The turbo properly spools up and keeps its spool once changing gears or engaging and disengaging the clutch
			
		[Transmission Changes]
			-Disabled the wait time in Manual transmission mode
			-Shifting between Reverse, Neutral and Drive is possible in Automatic transmission mode, credit to JustinianCode for this
			
		[New Values]
			-FCaster, only in the front, credit to Zyori for this
		
		[Thanks]
			-Thanks for using this chassis, I'll see ya in the next ones to come. -Avxnturador
			-Credits to RikOne2, Zyori, and JustinianCode for helping me out with special features.
			
		Install by changing the initialize, A-Chassis Interface, and by adding "FCaster" in the tune.
		
	[03/25/18 : A-Chassis T Build 6.62] - The Small Bugfixing Update
		[Fixes]
			-Turbo stays spooled up while shifting
			-If you throttle up while shifting, power will stay instead of staying at 0.
			
		Install by changing the Drive script.
			
	[02/15/18 : A-Chassis T Build 6.6] - The Realism Update
		[Curves]
			-Curves are now fixed due to a re-write of the Horsepower and Torque curves.
			-Instead of the HP and Torque being insanely off, it's now perfected.
				-Example: A naturally aspirated car with the horsepower at 180 will have its max HP be 180, not 360.
		
		[New Car Values]
			-TCSAmt (The amount of cutoff TCS has on the throttle)
			
		[New Tune Values]
			[EDITABLE]
			-ShiftTime (The time delay in which you initiate a shift and the car changes gear)
			[STANDARDIZED] (Highly recommended you don't touch these in the tune)
			-CurveCache (The time delay in which you initiate a shift and the car changes gear)
			-CacheInc (The time delay in which you initiate a shift and the car changes gear)
			
	[12/2/17 : A-Chassis T Build 6.5] - The Turbocharged Update
		[Turbocharger]
			-Utilizing IMeanBiz's turbo scripts, the car now has turbo.
		
		[New Car Values]
			-HpNatural (Horsepower made by the engine naturally aspirated)
			-TqNatural (Torque made by the engine naturally aspirated)
			
			-HpBoosted (Horsepower made by the turbocharger[s], NOT including HpNatural HP)
			-TqBoosted (Torque made by the turbocharger[s], NOT including TqNatural Torque)
			
			-Boost (Total boost [in PSI])
			
		[New Tune Values]
			-Should all be self explanatory in the tune.
			
		[New Plugins]
			-AC6T Stock Gauges, includes a turbo thing in the middle (when car is turbocharged), can easily be swapped with AC6 default gauges if not wanted.
			-Turbocharger sounds, which works regularly
			
		[Rewritten Values]
			-Horsepower (Horsepower combined from the engine and turbocharger[s])
			-Torque (Torque combined from the engine and turbocharger[s])
--]]

return "6.72"
local QuirkChanged = game.ReplicatedStorage.Remotes:WaitForChild("QuirkChanged")
local Player = game.Players.LocalPlayer
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
local Quirk = PlayerData:WaitForChild("Quirk")
local SkillsFrame = script.Parent
local Skill1 = SkillsFrame:WaitForChild("Skill1")
local Skill2 = SkillsFrame:WaitForChild("Skill2")
local Skill3 = SkillsFrame:WaitForChild("Skill3")
local Skill4 = SkillsFrame:WaitForChild("Skill4")
local Skill5 = SkillsFrame:WaitForChild("Skill5")
local Skill6 = SkillsFrame:WaitForChild("Skill6")

QuirkChanged.OnClientEvent:Connect(function()
	if Quirk.Value == 0 then -- Engine
		Skill1.Text = "[Q] Engine Kick: User kicks with all their might and sends their target flying"
		Skill2.Text = "[Z] <25 STR> Recipro Kick: User boosts their engines to travel at extremely high speeds and kicks their target. (Put your mouse on a player!)"
		Skill3.Text = "[X] <50 STR> Recipro Extend: User kicks their target into the air, sending them upwards. User then boost themselves up into the air extremely fast and kicks them once more, sending the target flying."
		Skill4.Text = "[C] <100 STR> Flying Kick: User charges their engine first straight ahead, and deals damage to anyone that they come in contact with "
		Skill5.Text = "[V] <100 AGL> Recipro Burst: User boosts their engines to move quickly for a limited time and increases damage."
		Skill6.Text = ""
	elseif Quirk.Value == 1 then -- Half Hot Half Cold
		Skill1.Text = "[F] Fire/Ice Mode"
		Skill2.Text = "[Q] Fire Ball/Ice Field/Burning Ice Field"
		Skill3.Text = "[Z] <100 STR> Fire Floor/Ice Spikes/Burning Ice Spikes"
		Skill4.Text = "[X] <250 STR> Fire Bomb/Glacier/<500 STR> Ultimate Explosion"
		Skill5.Text = "[C] <250 AGL> Flame Thrower/Ice Slide/ <1000 STR> Flashfreeze Heatwave"
		Skill6.Text = ""
	elseif Quirk.Value == 2 then -- One For All
		Skill1.Text = "[Q] Texas Smash: User uses a powerful straight punch creating a large blast of wind. "
		Skill2.Text = "[Z] <500 AGL> Carolina Smash: User dashes forward and attacks with a double hand chop."
		Skill3.Text = "[X] <500 DUR> New Hampshire Smash: User blasts themselve towards a target dealing damage with their body weight."
		Skill4.Text = "[C] <500 STR> Detroit Smash: User uses a downward smash creating a powerful whirlwind."
		Skill5.Text = "[V] <1000 STR> United States Of Smash: User gathers all their power and unleash the ravaging force on the ground creating a huge shockwave."
		Skill6.Text = "[F] <1000 ALL> Plus Ultra: User focuses power all over their body, enhancing their strength and speed."
	elseif Quirk.Value == 3 then -- Quirkless
		Skill1.Text = ""
		Skill2.Text = ""
		Skill3.Text = ""
		Skill4.Text = ""
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 4 then -- Zero Gravity
		Skill1.Text = "[Q] Super Gravity Fling: Touch a player to send them flying and deal damage to them as well."
		Skill2.Text = "[Z] <10 STR> Float: Touch a player to make them float. "
		Skill3.Text = "[X] <25 STR> Fling: While the player is floating, Press x and aim your mouse to fling them away and deal damage at once."
		Skill4.Text = "[C] <50 STR> Gravity Rocks: User picks up some of the ground beneath them, making 4 large stones and throws it straight ahead."
		Skill5.Text = "[V] <100 STR> Giant Gravity Rock: User picks up a giant part of the ground beneath them, and launches it in the direction of their mouse."
		Skill6.Text = "[F] <100 AGL> Anti-Gravity Form: User touches their arms and legs to become temporarily weightless, allowing them to move faster and jump higher."
	elseif Quirk.Value == 5 then -- Regeneration
		Skill1.Text = "[Passive] Faster Healing."
		Skill2.Text = "[Z] <10 DUR> Life Steal Combat: Allows you to steal other player's health by punching them."
		Skill3.Text = "[X] <25 DUR> Friendly Heal: Allows you to heal other players who you make physical contact with. "
		Skill4.Text = "[C] <50 DUR> Super Regeneration: Adds on to your current healing and heals you much faster."
		Skill5.Text = "[V] <100 DUR> Max Heal: Can heal you to full health instantly upon taking damage."
		Skill6.Text = ""
	elseif Quirk.Value == 6 then -- Explosion
		Skill1.Text = "[Q] Explosion: User creates an explosion from their hands."
		Skill2.Text = "[Z] <250 STR> Chained Blast: User creates a quick chain of explosions using both of their hands."
		Skill3.Text = "[X] <500 STR> AP-Shot: User releases an concentrated explosion traveling in front of them."
		Skill4.Text = "[C] <750 STR> Ground Blast: User creates a big group of explosions around them using both of their hands to blast the ground."
		Skill5.Text = "[V] <1000 STR> Howitzer Impact: The user propels themselves in the air with a chain of explosions that creates a tornado to fuel a powerful explosion."
		Skill6.Text = "[F] <1000 AGL> Adrenaline Rush: User's body start sweating excessively, boosting the power of their explosions and combat."
	elseif Quirk.Value == 7 then -- Electrification
		Skill1.Text = "[Q] Electric Blast/Disks: User shoots out a blast of electric dealing medium damage/User shoots out disks (Maximum of 5), the user can hold the button near them to shock them, electrocuting and dealing low damage for each disk to anyone near them."
		Skill2.Text = "[Z] Electric Stomp: The user electrocutes their right leg and stomps the ground, sending a flow of electricity in front of them, dealing medium damage."
		Skill3.Text = "[X] <25 STR> Electric Dash: The user dashes to their cursor at light speed, electrocuting and dealing medium damage to anyone caught between it."
		Skill4.Text = "[C] <50 STR> Electric Floor: The user electrocutes his arms, shocking the ground and creating a field of electricity that deals high damage."
		Skill5.Text = "[V] <150 STR> Full Discharge/Electric Containment: User charges his own body, afterwards unleashing a huge shockwave, dealing high damage./The user spins and shoots out disks, afterwards electrocuting them and creating a cage of electricity dealing very high damage to anyone near it."
		Skill6.Text = "[F] <250 STR> Electric Form: The user's body begins to electrocute, boosting the power of their electricity."
	elseif Quirk.Value == 8 then -- Warp Gate
		Skill1.Text = "[Q] Warp Punch: User punches target aimed with their mouse through a warp gate."
		Skill2.Text = "[Z] Create Gate: User opens up a warp gate from which they can teleport players and themselves through with their mouse."
		Skill3.Text = "[X] <50 STR> Warp Trap: User creates a large gate which can trap players in one spot and deal damage to them."
		Skill4.Text = "[C] <100 AGI> Warp Mode: User makes themselves into a warp, making them completely invincible to all damage temporarily. "
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 9 then -- Gigantification
		Skill1.Text = "[Z] Grow: Become larger, take less damage and knockback and also do more damage, size scales on how much strength you have."
		Skill2.Text = "[X] <25 STR> Giant Stomp: Slam your foot on the ground and create a large shockwave which scales on strength."
		Skill3.Text = "[C] <50 STR> Grab: User grabs the target and deals great damage."
		Skill4.Text = "[V] <100 STR> Giant Smash: User leaps forward and smashs the ground creating a large shockwave dealing high damage."
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 10 then --  Voice
		Skill1.Text = "[Z] Yell: User yells and increases the volume of their voice a small bit, doing damage to anyone within range of your voice."
		Skill2.Text = "[X] <50 STR> Shout: User Shouts and increases the volume of their voice much more, increasing the range and damage of their voice."
		Skill3.Text = ""
		Skill4.Text = ""
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 11 then -- Air Propulsion
		Skill1.Text = "[Z] Air Propulsion: User holds out one arm, the air from around them swirling, then releases it as a large gust of wind."
		Skill2.Text = "[X] <75 AGL> Air Dash: User puts both arms behind them and uses the surrounding air to create a gust and propel themselves in the direction of their mouse."
		Skill3.Text = "[C] <150 STR> Air Tornado: User puts both arms on the ground, and propels themselves upwards, creating a large swirl of wind beneath them. "
		Skill4.Text = ""
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 12 then -- ShockAbsorption
		Skill1.Text = "[Passive] 3.5x Damage Reduction                                                           (Damage Reduced by 50% in PVP)"
		Skill2.Text = "[Z] <50 DUR> Shock Repel: User releases a huge shockwave dealing high damage. (Must be damaged 25%)"
		Skill3.Text = ""
		Skill4.Text = ""
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 13 then -- Deku Ofa
		Skill1.Text = "[Q] St. Louis Smash: User swings around to deliver a roundhouse kick creatting a small shortranged shockwave."
		Skill2.Text = "[Z] <250 STR> Detroit Smash: User pulls back their fist and punches creating a longranged shockwave."
		Skill3.Text = "[X] <500 STR> Delaware Smash: User flicks their fingers creating a small longranged shockwave."
		Skill4.Text = "[C] <750 STR> Manchester Smash: User leaps into the air and flips forward to bring down an axe kick creating a large tornado shockwave."
		Skill5.Text = "[V] <1000 STR> 1000000% Delaware Detroit Smash: User pulls back their arm and unleashes a gigantic shockwave."
		Skill6.Text = "[F] <500, 1000, 2000 ALL> Full Cowl(20%,50%,100%): The power of one for all spreads across user's body boosting speed and prevents your limbs from breaking."
	elseif Quirk.Value == 14 then -- Hardening
		Skill1.Text = "[Q] Red Counter - User launches a strong punch forward with their hardening ability, knocking their target back."
		Skill2.Text = "[Z] Harden - User hardens their skin boosting their defense and unlocks the moveset."
		Skill3.Text = "[X] <50 STR> Red Gauntlet - User charges forward and launches a strong strike damaging anyone in contact. "
		Skill4.Text = "[C] <100 STR> Earth-shattering Strike - User slams their fist into the ground causing rocks to rise up dealing high area damage."
		Skill5.Text = "[V] <200 STR> Unbreakable - User hardens their skin even further beyond, boosting their strength and defense and reducing knockback."
		Skill6.Text = ""
	elseif Quirk.Value == 15 then -- Hell Flame
		Skill1.Text = "[Q] Flashfire Fist: Jet Burn: User launches a punch bursting with flames , igniting anything infront of them dealing medium damage."
		Skill2.Text = "[Z] <50 STR> Flashfire Creation : Flame Spear: User manipulates their flames to create a spear, and launches it dealing medium damage."
		Skill3.Text = "[X] <100 STR> Hellfire Ball: User launches a fireball that explodes dealing high damage."
		Skill4.Text = "[C] <150 STR> Flashfire Fist : Hell Spider: User creates a web of flames in front of them , making anyone who gets hit by it stuck on the web, dealing rapid damage"
		Skill5.Text = "[V] <250 STR> Prominence Flame: User burns brightly and intensely before shooting out a beam of highly pressurized flame"
		Skill6.Text = "[F] <250 AGL> Flame Body: Users body becomes completely engulfed in flames, increasing the damage of the users quirk as well as increases the users flight skill durability."
	elseif Quirk.Value == 16 then -- Overhaul
		Skill1.Text = "[Q] Reassembling Touch: User swipes their arm and heals whoever they touch or themselves 20%."
		Skill2.Text = "[Z] <500 STR> Ground Spikes: User creates large forward spikes dealing medium damage and stuns."
		Skill3.Text = "[X] <500 DURA> Reassembing Body: User breaks apart and reassembles themselves, healing themselves 50%."
		Skill4.Text = "[C] <1000 STR> Disassembling World: User creates huge fissures and spiking the floor up around them dealing high damage and stuns."
		Skill5.Text = "[V] <1500 STR> Disassembling Touch: User swipes their arm and deals extremely high damage to whoever they touch."
		Skill6.Text = "[F] <2000 STR> Fusion: User gains an additional two arms deformed with spiked claws increasing their damage and defense."
	elseif Quirk.Value == 17 then -- Jet
		Skill1.Text = "[Q] Jet Slam: User jumps towards the sky then slams in to the ground, causing damage in a small area. "
		Skill2.Text = "[Z] <50 AGL> Jet Boost: User boosts towards the mouse, can bounce off of surfaces up to 5 times. "
		Skill3.Text = "[X] <75 STR> Spinning Kick: User dashes and kicks a nearby enemy, chains to other enemies automatically up to 5 times"
		Skill4.Text = "[C] <150 STR> Jet Barrage: User dashes at an incredible speed in an area in front of them, hitting enemies multiple times."
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 18 then -- Black Hole
		Skill1.Text = "[Z] Black Hole: User creates a black hole to suck in and do damage to players rapidly."
		Skill2.Text = "[X] <50 STR> Black Hole Trap: User creates a stationary black hole with short range that will deal rapid damage and hold a target in place."
		Skill3.Text = "[C] <150 STR> Black Hole Explosion: User becomes a black hole, sucking in nearby players then exploding and sending them away."
		Skill4.Text = ""
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 19 then -- Cremation
		Skill1.Text = "[Q] Bursting Flames: User launches a burst of flames dealing medium damage."
		Skill2.Text = "[Z] <50 STR> Incinerating Blast: User manipulates their flames to spew a constant flame of fire that deals constant damage."
		Skill3.Text = "[X] <100 STR> Erupting Flames: User blasts the floor with concentrated fire power , creating a large explosion and propelling themselves forward."
		Skill4.Text = "[C] <150 STR> Pyre Walls: User creates a huge walls of flames damaging anyone inside it."
		Skill5.Text = "[V] <250 STR> Ablazing World: User spins and create a storm of flames pulling players in and dealing high damage."
		Skill6.Text = "[F] <250 AGL> Flame Body: Flame Body: Users entire body emits blue flames, increasing the damage of the users cremation attacks."
	elseif Quirk.Value == 20 then -- Dark Shadow
		Skill1.Text = "[Q] Shadow Strike - Dark shadow charges up a strong punch creating a small shockwave."
		Skill2.Text = "[Z] Dark Shadow - Activate/Disable Dark Shadow"
		Skill3.Text = "[X] <50 STR> Shadow Barrage - Dark shadow releases a flurry of punches." 
		Skill4.Text = "[C] <100 STR> Shadow Slam - Dark Shadow slams the ground creating a large shockwave."
		Skill5.Text = "[V] <250 STR> Shadow Combo - Dark Shadow charges forward and slams down the darget."
		Skill6.Text = "[F] <250 AGL> Abyssal Black Body - Dark shadow wraps around the user, increasing their power greatly."
	elseif Quirk.Value == 21 then -- Muscle Augmentation
		Skill1.Text = "[Q] Muscle Punch: User expands the muscle of one of their arms and punches with all their might."
		Skill2.Text = "[Z] Muscle Arms: User makes their arms muscular and is now able to use their skills, also increases str."
		Skill3.Text = "[X] <250 AGIL> Muscle Legs: User makes their legs muscular and is now able to move much faster and jump higher."
		Skill4.Text = "[C] <100 STR> Charge: User charges into targets with their arms and deals high damage"
		Skill5.Text = "[V] <250 STR> Slam: User Punches the ground and creates a shockwave, dealing high damage to anyone hit by it."
		Skill6.Text = "[F] <250 DURA> Muscle Chest: User makes their chest become muscular and become more durable."
	elseif Quirk.Value == 22 then -- Permeation
		Skill1.Text = "[Z] Permeat: Allows user to go through objects, while activated user will lose health slowly."
		Skill2.Text = "[X] <50 AGL> Permeation Escape: User sinks into the ground and pops out where the mouse is aimed."
		Skill3.Text = "[C] <150 AGL> Permeation Combo: User sinks into the ground and pops out behind the target and perform a combo dealing high damage.(Put your mouse on a player!)"
		Skill4.Text = "[V] <250 AGL> Permeation Body: User permeats their whole body, making them completely invincible to all attacks temporarily."
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 23 then -- PopOff
		Skill1.Text = "[Z} Pop Off: User throws a ball that sticks and holds target in place."
		Skill2.Text = "[X] <100 STR> Grape Rush: User throws multiple balls that sticks and holds target in place."
		Skill3.Text = "[C] <250 STR> Grape Whip: User creates a whip using their balls and swings multiple times dealing high damage."
		Skill4.Text = ""
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 24 then -- Somnambulist
		Skill1.Text = "[Z] Gas Shot: User compresses some pink gas and throws it. Players hit by this attack will fall asleep."
		Skill2.Text = "[X] <50 STR> Gas Spread: User spreads pink gas in a large area, dealing medium damage and making players inside its radius fall asleep."
		Skill3.Text = "[C] <100 STR> Gas Spray: User holds their hands out and lets a short-ranged continous stream of pink gas come out. People hit by this attack will fall asleep."
		Skill4.Text = "[V] <150 AGL> Somna Body: User constantly emits pink gas from their entire body, increasing the damage of the users gas"
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 25 then -- Navel Laser
		Skill1.Text = "[Z} Navel Laser: User fires a beam from their navel that deals medium damage."
		Skill2.Text = "[X} <100 AGL> Navel Flight: Launches the user off the ground, flying away in the direction you choose/does dmg when laser hits other players."
		Skill3.Text = "[C} <100 STR> Navel Barrage: User fires a barrage of beams from their navel that explodes on contact."
		Skill4.Text = "[V] <250 STR> Super Navel Laser: User fires a bigger beam from his navel that deals high damage."
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 26 then -- Decay
		Skill1.Text = "[Z} Decay Touch: User holds out their hand, decaying whoever it touches for amount of time."
		Skill2.Text = "[X} <50 STR> Decay Dash: User launches forward and grabs the opponent with both hands, dealing medium damage."
		Skill3.Text = "[C} <100 STR> Decay Combo: User grabs an opponent and throws them dealing high damage."
		Skill4.Text = "[V] <250 STR> Decaying Floor: User puts their hands on the floor and decays it, causing high damage to everyone around."
		Skill5.Text = "[F] <250 AGL> Decay Body: User is cloaked in decay, dealing touch damage and increasing decay damage."
		Skill6.Text = ""
	elseif Quirk.Value == 27 then -- Acid
		Skill1.Text = "[Z} Acid Ball: User launches a ball of acid dealing medium damage."
		Skill2.Text = "[X} <100 STR> Acid Veil: User creates a wall of acid dealing damage and also blocking attacks."
		Skill3.Text = "[C} <100 AGL> Acid Slide: User slides generates acid at feet dealing damage to whoever touches it."
		Skill4.Text = "[V] <200 STR> Acid Leak: User Releases massive amounts of acid in a limited range."
		Skill5.Text = ""
		Skill6.Text = ""
	elseif Quirk.Value == 28 then -- Creation
		Skill1.Text = "[Q} Russian Matryoshka Bomb/Barrage: User creates a doll-like bomb and tosses it creating an explosion dealing medium damage."
		Skill2.Text = "[Z] <50 STR> Steel Sword/Spear Lunge: User creates a sword that acts as an equipped weapon that deals high damage."
		Skill3.Text = "[X} <100 STR> Iron Shield/Med-Kit: User creates a shield that reduces damage and knock back of attacks."
		Skill4.Text = "[C] <150 STR> Net Shot/Hammer Slam: User creates and launch a net that traps anyone it touches."
		Skill5.Text = "[V] <200 STR> Cannon Blast: User creates a cannon that launches serveral shots of explosion dealing high damage."
		Skill6.Text = "[F] <250 STR> Yaoyorozo's Lucky Bag: User creates a bag that carry around their back. All Skills are replaced with the items inside the bag until it's used up.(Requires 400 agility of stamina)"
	elseif Quirk.Value == 29 then -- Clones
		Skill1.Text = "[Q] Chooses the target for your clones."
		Skill2.Text = "[Z] Clones: Use creates a clone that fights for you. Maximum of 4 clones."
		Skill3.Text = "[X] <50 STR> Clone Transition: User teleports to the nearest clone and exploding their body. (Must be within teleport range!)"
		Skill4.Text = "[C] <100 STR> Ectopult Missle: User fires a missle of eptoplasm that explodes into a clone upon contact."
		Skill5.Text = "[V] <200 STR> Forced Internment Giant Bites: User spews out a large amount of ectoplasm and creates a giant clone that performs a bite dealing high damage and trapping enemies."
		Skill6.Text = ""
	elseif Quirk.Value == 30 then -- All For One
		Skill1.Text = "[Q] Finger Strike: User launches jagged spikes that pierces the target and stuns them temporarily."
		Skill2.Text = "[Z] <500 STR> Enhanced Air Cannon: User releases an air shockwave from their arm dealing medium damage."
		Skill3.Text = "[X] <500 AGL> Warping: User creates a portal and warps to another location."
		Skill4.Text = "[C] <500 DUR> Impact Recoil: The user activates their Impact Recoil quirk and upon being damaged, they block 50% of the damage and reflects it back to the target that hit him as long as the user holds down C."
		Skill5.Text = "[V] <1000 STR> Ultimate Combination: User combines multiple quirks on their arm and releases a huge shockwave."
		Skill6.Text = "[F] <1000 ALL> Springlike Limbs: User's abilities become enhanced, boosting their defense and attack."
	elseif Quirk.Value == 31 then -- Tail
		Skill1.Text = "[Passive] Auto tail block"
		Skill2.Text = "[Q] Tail Whip: User performs a whip with their tail."
		Skill3.Text = "[Z] <50 STR> Tail Smack: User slams their tail on the ground creating a large shockwave."
		Skill4.Text = "[X] <100 STR> Tail Leap: User leaps with their tail damaging anyone they come in contact with."
		Skill5.Text = "[C] <150 STR> Tornado Tail Dance: User spins with their tail smacking anyone near and ends with a slam creating a small shockwave."
		Skill6.Text = "[V] <250 STR> Fist of the Tail: User spins continuously with their tail dealing damage to anyone near. While using the move their defense is doubled."
	elseif Quirk.Value == 32 then -- frog
		Skill1.Text = "[Passive / Space] High Jump / Wall Climb                                            [Q] Tongue Slap: User slaps with their tongue."
		Skill2.Text = "[Z] <50 STR> Tongue Grab: User pulls hit target towards them with their tongue."
		Skill3.Text = "[X] <100 STR> Tongue Leap: User leaps with forward and whips their tongue dealing medium damage."
		Skill4.Text = "[C] <150 STR> Tongue Throw: User grabs target with their tongue and throws them dealing high damage."
		Skill5.Text = "[V] <250 STR> Tongue Barrage: User continuously whips their tongue dealing low damage and stuns."
		Skill6.Text = "[F] <250 AGL> Camouflage: User becomes invisible for a period of time until they use a skill or gets stunned."
	elseif Quirk.Value == 33 then -- fierce wings
		Skill1.Text = "[Q] Homing Feathers: User shoots out feathers that follows its target dealing medium damage."
		Skill2.Text = "[Z] <250 STR> Feather Pierce: User shoots out multiple waves of feathers dealing continuous damage."
		Skill3.Text = "[X] <500 AGL> Feather Blades: User brings out 2 feather blades and dashes forward piercing targets."
		Skill4.Text = "[C] <500 STR> Feather Flurry: User sprays out multiple feathers around dealing high damage. "
		Skill5.Text = "[V] <1000 STR> Feather Rain: User flys up and rains down multiple feathers dealing high damage."
		Skill6.Text = "[F] <1000 AGL> Flight: Allows user to fly (Disables Stamina Regen)"
	elseif Quirk.Value == 34 then -- Tomura All For One
		Skill1.Text = "[Q] Decaying Air Cannon: User releases an air shockwave that does medium damage with decay aftereffects."
		Skill2.Text = "[Z] <500 STR> Decaying Crack: User decays a large area in front of them dealing medium decay damage."
		Skill3.Text = "[X] <1000 AGL> Decaying Dash: User cloaks themselves in decay and launches towards their target and deals medium decay damage."
		Skill4.Text = "[C] <1000 DUR> Super Regeneration: User gains health quickly in exchange for stamina."
		Skill5.Text = "[V] <1000 STR> Decaying World: User decays a large area around them dealing high decay damage."
		Skill6.Text = "[F] <1000 ALL> Enhanced Decaying Form: User cloaks their body with decay boosting their defense and dealing damage to anyone near them."
	elseif Quirk.Value == 35 then -- Orcinus
		Skill1.Text = "[Q] Sonic Beam: User produces a short ranged sonic wave that deals medium damage."
		Skill2.Text = "[Z] <50 STR> Piercing Sounds: User produces long ranged sonic waves that deals low damage."
		Skill3.Text = "[X] <100 STR> Orcinus Leap: User leaps forward and produces sound waves that deals medium damage."
		Skill4.Text = "[C] <150 STR> Sonic Boom: User produces a long ranged sonic wave into the sky dealing high damage."
		Skill5.Text = "[V] <250 STR> Sonic Release: User releases an explosion of sonic waves dealing high damage."
		Skill6.Text = "[F] <250 AGL> Killer Instincts: User's eyes glow red, increasing their damage and defense."
	end
end)
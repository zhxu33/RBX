-- // 10ian10: "I changed the Dark Blossoms Swing and Special mainly starting at line 2814 and 2366"


local AnimationsFolder = script.Animations

--================================ [ANIMATIONS] =================================--

local Animations = {

	EasterSword                 = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	T2EasterSword               = {AnimationsFolder.DualEasterKatana_1, AnimationsFolder.DualEasterKatana_2, AnimationsFolder.DualEasterKatana_3},
	EasterSwordSpecial          = AnimationsFolder.BladeSpin,
	T2EasterSwordSpecial        = {AnimationsFolder.BladeSpin},

	Dagger                      = {AnimationsFolder.Dagger_1, AnimationsFolder.Dagger_2, AnimationsFolder.Dagger_3},
	DaggerSpecial               = {AnimationsFolder.DaggerSupa},
	T2Dagger                    = {AnimationsFolder.Dagger_1, AnimationsFolder.Dagger_2, AnimationsFolder.Dagger_3},
	T2DaggerSpecial             = {AnimationsFolder.DaggerSupa},
	T3Dagger                    = {AnimationsFolder.Dagger_1, AnimationsFolder.Dagger_2, AnimationsFolder.Dagger_3},
	T3DaggerSpecial             = {AnimationsFolder.DaggerSupa},

	Katana                      = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	KatanaSpecial               = {AnimationsFolder.SnowSwordSlash},
	T2Katana                    = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	T2KatanaSpecial             = {AnimationsFolder.SnowSwordSlash},
	T3Katana                    = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	T3KatanaSpecial             = {AnimationsFolder.SnowSwordSlash},

	SnowSword                   = {AnimationsFolder.SnowSword_1, AnimationsFolder.SnowSword_2, AnimationsFolder.SnowSword_3},
	SnowSwordSpecial            = {AnimationsFolder.SnowSwordSlash},
	T2SnowSword                 = {AnimationsFolder.DualSword_1, AnimationsFolder.DualSword_2, AnimationsFolder.DualSword_3},
	T2SnowSwordSpecial          = {AnimationsFolder.DualSwordXSlash},

	EasterKatana                = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	EasterKatanaSpecial         = {AnimationsFolder.EasterKatanaSupa},
	T2EasterKatana              = {AnimationsFolder.DualEasterKatana_1, AnimationsFolder.DualEasterKatana_2, AnimationsFolder.DualEasterKatana_3},
	T2EasterKatanaSpecial       = {AnimationsFolder.DualEasterKatanaSupa},

	DarkBlossoms				= {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	DarkBlossomsSpecial			= {AnimationsFolder.DaggerSupa},

	PeppermintEdge              = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	PeppermintEdgeSpecial       = {AnimationsFolder.SnowSwordSlash},

	PoisonousSummoner           = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	PoisonousSummonerSpecial    = {AnimationsFolder.IceSickle_S},

	FrozenExcalibur             = {AnimationsFolder.EasterKatana_1, AnimationsFolder.EasterKatana_2, AnimationsFolder.EasterKatana_3},
	FrozenExcaliburSpecial      = {AnimationsFolder.SnowSwordSlash},

	CursedGlove                 = {AnimationsFolder.CursedGlove_1, AnimationsFolder.CursedGlove_2},
	CursedGloveSpecial          = {AnimationsFolder.CursedGloveSuper},

	GhastSword                  = {AnimationsFolder.GhastSword_1, AnimationsFolder.GhastSword_2, AnimationsFolder.GhastSword_3},
	GhastSwordSpecial           = {AnimationsFolder.GhastSword_S},
	GhastSwordIdle              = AnimationsFolder.GhastSwordIdle,
	T2GhastSword                = {AnimationsFolder.GhastSword_1, AnimationsFolder.GhastSword_2, AnimationsFolder.GhastSword_3},
	T2GhastSwordSpecial         = {AnimationsFolder.GhastSword_S},
	T2GhastSwordIdle            = AnimationsFolder.GhastSwordIdle,

	IceSickle                   = {AnimationsFolder.IceSickle_1, AnimationsFolder.IceSickle_2, AnimationsFolder.IceSickle_3},
	IceSickleSpecial            = {AnimationsFolder.IceSickle_S},

	PeppermintSaber             = {AnimationsFolder.SnowSword_1, AnimationsFolder.SnowSword_2, AnimationsFolder.SnowSword_3},
	PeppermintSaberSpecial      = {AnimationsFolder.PeppermintSaberSupa},

	EasterKatanaEquip           = AnimationsFolder.EasterKatanaSheath,
	T2EasterKatanaEquip         = AnimationsFolder.DualEasterKatanaSheath,

	HalloweenScythe             = {AnimationsFolder.ScytheSwing_1, AnimationsFolder.ScytheSwing_2, AnimationsFolder.ScytheSwing_3},
	T2HalloweenScythe           = {AnimationsFolder.DualScytheSwing_1, AnimationsFolder.DualScytheSwing_2, AnimationsFolder.DualScytheSwing_3},
	HalloweenScytheSpecial      = {AnimationsFolder.ScytheSwing_1, AnimationsFolder.ScytheSwing_2, AnimationsFolder.ScytheSwing_3},
	T2HalloweenScytheSpecial    = {AnimationsFolder.DualScytheSwing_1, AnimationsFolder.DualScytheSwing_2, AnimationsFolder.DualScytheSwing_3},

	JesterSpear					= {AnimationsFolder.ScytheSwing_1, AnimationsFolder.ScytheSwing_2, AnimationsFolder.ScytheSwing_3}, -- XXXXXXXXXX
	JesterSpearSpecial			= {AnimationsFolder.JesterSpearSuper}, -- XXXXXXXXXX
	JesterSpearIdle				= {AnimationsFolder.JesterScytheWalk}, -- XXXXXXXXXX

	JesterScythe				= {AnimationsFolder.JesterScythe_1, AnimationsFolder.JesterScythe_2, AnimationsFolder.JesterScythe_3},
	JesterScytheSpecial			= {AnimationsFolder.JesterScytheSuper}, -- XXXXXXXXXX
	JesterScytheWalk			= AnimationsFolder.JesterScytheWalk,

	ClockworkBlade				= {AnimationsFolder.SnowSword_1, AnimationsFolder.SnowSword_2, AnimationsFolder.SnowSword_3},
	ClockworkBladeDual			= {AnimationsFolder.DualEasterKatana_1, AnimationsFolder.DualEasterKatana_2, AnimationsFolder.DualEasterKatana_3},
	ClockworkBladeSpecial		= {AnimationsFolder.ClockworkBladeSuper},

	Hammer                      = {AnimationsFolder.HammerSwing_1, AnimationsFolder.HammerSwing_2},
	HammerSpecial               = {AnimationsFolder.HammerSlam},

	EasterStaff                 = {AnimationsFolder.Staff_1, AnimationsFolder.Staff_2},
	T2EasterStaff               = {AnimationsFolder.Staff_1, AnimationsFolder.Staff_2},
	EasterStaffSpecial          = {AnimationsFolder.EasterStaffSupa},
	T2EasterStaffSpecial        = {AnimationsFolder.EasterStaffSupa},
	StaffWalk                   = AnimationsFolder.StaffWalk,

	BowIdle                     = AnimationsFolder.BowIdle,
	EasterBow                   = {AnimationsFolder.Bow},
	EasterBowSpecial            = {AnimationsFolder.Bow},

	PumpkinPistol               = {AnimationsFolder.Gun, AnimationsFolder.Gun2},
	PumpkinPistolSpecial        = {AnimationsFolder.PumpkinPistolSupa},

	CandyCaneGunSpecial         = {AnimationsFolder.CandyGunSupa},
	T2CandyCaneGunSpecial       = {AnimationsFolder.CandyGunSupa},
	CandyCaneGun                = {AnimationsFolder.Gun, AnimationsFolder.Gun2},
	T2CandyCaneGun              = {AnimationsFolder.Gun, AnimationsFolder.Gun2},

	EasterWand                  = {AnimationsFolder.Staff_1, AnimationsFolder.Staff_2},
	EasterWandSpecial           = {AnimationsFolder.Staff_1},

	EasterGrimoire              = {AnimationsFolder.Staff_1, AnimationsFolder.Staff_2},
	EasterGrimoireSpecial       = {AnimationsFolder.GrimoireHealCircle},

	EasterFlintlock             = {AnimationsFolder.Gun, AnimationsFolder.Gun2},
	EasterFlintlockSpecial      = {AnimationsFolder.DualGunSupa},

	OrnamentBlaster             = {AnimationsFolder.Gun, AnimationsFolder.Gun2},
	OrnamentBlasterSpecial      = {AnimationsFolder.PumpkinPistolSupa},

	Pistol                      = {AnimationsFolder.Gun2},
	PistolSpecial               = {AnimationsFolder.GunSupa},
	PistolEquip                 = AnimationsFolder.DualGunEquip,
	T2Pistol                    = {AnimationsFolder.Gun2},
	T2PistolSpecial             = {AnimationsFolder.GunSupa},
	T2PistolEquip               = AnimationsFolder.DualGunEquip,
	T3Pistol                    = {AnimationsFolder.Gun, AnimationsFolder.Gun2},
	T3PistolSpecial             = {AnimationsFolder.DualGunSupa},
	T3PistolEquip               = AnimationsFolder.DualGunEquip,

	UpDashAnim                  = AnimationsFolder.UpDash,
	FrontDashAnim               = AnimationsFolder.FrontDash,
	BackDashAnim                = AnimationsFolder.BackDash,
	LeftDashAnim                = AnimationsFolder.LeftDash,
	RightDashAnim               = AnimationsFolder.RightDash,
}
--================================ [SERVICES] =================================--

local ServerStorage       = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService        = game:GetService("TweenService")
local RunService          = game:GetService("RunService")
local PhysicService       = game:GetService("PhysicsService")
local Debris              = game:GetService("Debris")

--================================ [DIRECTORY] =================================--

local DataHolder       = workspace.S1c2R5i66p5t5s51
local WeaponsDirectory = ServerStorage.Weapons
local GadgetsDirectory = ServerStorage.Gadgets
local WeaponEffects    = WeaponsDirectory.WeaponEffects

--================================ [MAIN STAT FOLDER] =================================--

local PlayerDataFolder = DataHolder.PlayerData

--================================ [MODULE SCRIPTS] ====================================--

local CombatShortcuts = require(script.CSC) -- OVERUSED COMBAT FUNCTIONS
local Information     = require(7551377635)
local RaycastHitbox   = require(7496725777)
local SpatialHitbox   = require(7496792123)
local WeaponData      = require(script.WeaponsData)
local DataModule      = require(7497657537)

--================================= [ASSETS DIRECTORY] ==================================--

local UniversalAssetFolder 	= ServerStorage.UniversalAssets
local ItemAssetFolder 		= ServerStorage.ItemAssets

--================================ [WEAPONS VARIABLES] =================================--

local Katana  = ServerStorage:WaitForChild("Weapons"):WaitForChild("Katana")
local SwordEF = ServerStorage:WaitForChild("Weapons"):WaitForChild("WeaponEffects"):WaitForChild("KatanaEffect")

local Equip      = script:WaitForChild("Equip")
local Swing      = script:WaitForChild("Swing")
local Dash       = script:WaitForChild("Dash")
local RightSwing = script:WaitForChild("RightSwing")

local DmgFunction   = game.ReplicatedStorage:WaitForChild("DamageFunction")
local CooldownEvent = script:WaitForChild("Cooldowns")
local Usage         = script:WaitForChild("Usage")
local Unlock        = script:WaitForChild("Unlock")
local Weapons       = WeaponsDirectory

--================================ [LIVE MOUSE FUNCTION] ================================--

local InitiateMouse	  = script:WaitForChild("InitiateMouse")
local UpdatePosition  = script:WaitForChild("MousePosition")
local UsersConnection = {}

function StartLiveMouseTracking(plr, current, length, limit)
	if not UsersConnection[plr.UserId] then UsersConnection[plr.UserId] = {} end
	if UsersConnection[plr.UserId].Connection then return end
	UsersConnection[plr.UserId].Position = current

	InitiateMouse:FireClient(plr, length)

	UsersConnection[plr.UserId].Connection = UpdatePosition.OnServerEvent:Connect(function(plr, position)
		if (plr.Character.HumanoidRootPart.Position - position).Magnitude > limit then return end
		UsersConnection[plr.UserId].Position = position		
	end)

	coroutine.wrap(function()
		wait(length + .1)

		UsersConnection[plr.UserId].Connection:Disconnect(); UsersConnection[plr.UserId].Connection = nil
	end)()
end

--================================ [WEAPONS FUNCTIONS] =================================--

local Sounds = script:WaitForChild("Sounds")
function PlaySound(RootPart, directory)
	local Sound = directory:Clone()
	Sound.Parent = RootPart
	Sound:Play()
	game.Debris:AddItem(Sound, directory.TimeLength)
	return Sound
end

--================================ [ARMOR EVENTS] =================================--

-- Armor Tiers

local ArmorTiers = { -- ARMOR TIER | DURABILITY BOOST
	["1"] = 0.75,
	["2"] = 1,
	["3"] = 1.25,
	["4"] = 1.5,
}

-- Accessory Variables

local GhastlyT3Regen = 150 -- Humanoid.Health = Humanoid.Health + Humanoid.MaxHealth/150
local GhastlyArmorSpecial = 3 -- The Armor Tier needed for the special effect to take place

local FestiveArmorSpecial = 3 -- The Armor Tier needed for the special effect to take place
local FestiveArmorBoost = 1.1 -- The Armor Special Boost When Activated (Damage)

local BunnyEarsArmor = 3
local EggPauldronArmor = 3

-- Armor Effects Ex:(Egg Pauldron's "Spiked" accessory)

local ArmorAccessoryEffect = {
	"Spiked",
}

local function ToolChange(play, Type)
	local List = DataModule.PlayerInformation[play.UserId]
	if not List then return end

	local Character = List.Character
	local Durability = List.Durability
	local Humanoid = Character.Humanoid
	local RootPart = List.RootPart

	if Type == "SantaArmor" then
		local SantaArmor = Character:WaitForChild("SantaArmor")
		local Tier = SantaArmor:FindFirstChild("TierValue")
		if ArmorTiers[tostring(Tier.Value)] then
			List.Character:SetAttribute("ArmorDefense", Durability*ArmorTiers[tostring(Tier.Value)])
		end
	elseif Type == "EggPauldron" then
		List.Character:SetAttribute("ArmorDefense", Durability*ArmorTiers[tostring(EggPauldronArmor)])
		List.Character:SetAttribute("Spiked", true)
	elseif Type == "GhastArmor" then
		local GhastArmor = Character:WaitForChild("GhastArmor")
		local Tier = GhastArmor:FindFirstChild("TierValue")
		if ArmorTiers[ArmorTiers[tostring(Tier.Value)]] then
			List.Character:SetAttribute("ArmorDefense", Durability*ArmorTiers[tostring(Tier.Value)])
			if Tier.Value == GhastlyArmorSpecial then
				coroutine.wrap(function()
					local GhastSwirl = WeaponEffects.GhastSwirl:Clone()
					GhastSwirl.Parent = RootPart
					repeat wait(1)
						if Humanoid.Health < Humanoid.MaxHealth/2 then
							GhastSwirl.Enabled = true
							Humanoid.Health = Humanoid.Health + Humanoid.MaxHealth/GhastlyT3Regen
						else
							GhastSwirl.Enabled = false
						end
					until not Character:FindFirstChild("GhastArmor") or Humanoid.Health == 0
					GhastSwirl:Destroy()
				end)()
			end
		end
	elseif Type == "FestiveLights" then
		local FestiveLights = Character:WaitForChild("FestiveLights")
		local Tier = FestiveLights:FindFirstChild("TierValue")
		if ArmorTiers[ArmorTiers[tostring(Tier.Value)]] then
			List.Character:SetAttribute("ArmorDefense", Durability*ArmorTiers[tostring(Tier.Value)])
			if Tier.Value == FestiveArmorSpecial then
				coroutine.wrap(function()
					repeat wait(1)
						pcall(function()
							if Humanoid.Health < Humanoid.MaxHealth/2 then
								List.Character:SetAttribute("DamageBoost", FestiveArmorBoost)
								for i,v in pairs(FestiveLights.Tier2.Particles:GetChildren()) do
									v.Enabled = true
								end
								for i,v in pairs(FestiveLights.Tier3.Particles:GetChildren()) do
									v.Enabled = true
								end
							else
								List.Character:SetAttribute("DamageBoost", 1)
								for i,v in pairs(FestiveLights.Tier2.Particles:GetChildren()) do
									v.Enabled = false
								end
								for i,v in pairs(FestiveLights.Tier3.Particles:GetChildren()) do
									v.Enabled = false
								end
							end
						end)
					until not Character:FindFirstChild("FestiveLights") or Humanoid.Health == 0
					List.Character:SetAttribute("DamageBoost", 1)
				end)()
			end
		end
	elseif Type == "PumpkinArmor" then
		local PumpkinArmor = Character:WaitForChild("PumpkinArmor")
		local Tier = PumpkinArmor:FindFirstChild("TierValue")
		if ArmorTiers[tostring(Tier.Value)] then
			List.Character:SetAttribute("ArmorDefense", Durability*ArmorTiers[tostring(Tier)])
		end
	elseif Type == "BunnyEars" then
		List.Character:SetAttribute("ArmorDefense", Durability*ArmorTiers[tostring(BunnyEarsArmor)])
	else
		List.Character:SetAttribute("ArmorDefense", 0)
		List.Character:SetAttribute("Spiked", false)
	end
end

--================================ [WEAPON EVENTS] =================================--

-- Weapon Actions

local WeaponSpecialMove = "B"

----- Weapon Variables -----

-- Ban Hammer
local BanHammerSettings = {
	Damage   = 25, -- 50 -- Attached to damage || Originally : (50*DataModule.PlayerInformation[play.UserId].Strength/2*DmgMultiplier)
	Velocity = 40,    -- Velocity applied on knockback
	VelocityLife = .7,
	Power    = 10000, -- Force applied to velocity
	Type     = "Heavy"
}

-- Weapon Events

local WeaponTable = {
	"Katana",
	"Dagger",
	"EasterSword",
	"GhastSword",
	"IceSickle",
	"PeppermintSaber",
	"SnowSword",
	"BanHammer",
	"EasterKatana",
	"DarkBlossoms",
	"PeppermintEdge",
	"PoisonousSummoner"
}
local OtherWeapons = {
	"EasterFlintlock",
	"OrnamentBlaster",
	"CursedGlove",
	"EasterWand",
	"EasterGrimoire",
	"PumpkinPistol",
	"CandyCaneGun",
}

local function WeaponChange(play, Type)

	local List = DataModule.PlayerInformation[play.UserId]
	if not List then return end

	local Character    = List.Character
	local Exp          = List.Exp
	local RootPart     = List.RootPart
	local OrigIdleAnim = List.OrigIdleAnim
	local Player       = play

	if table.find(WeaponTable, Type) then
		Unlock:FireClient(play, WeaponSpecialMove, true)
		local DamageEffect

		if Type == "DarkBlossoms" then
			DamageEffect = function(HRT)
				local SizeMultiplier = 7.5
				local Explosion = WeaponEffects.FlowerBoomsExplosion:Clone()
				local ExplosionParts = Explosion:GetChildren()
				Explosion.Parent = workspace.Debris
				Explosion:SetPrimaryPartCFrame(HRT.CFrame)
				game.Debris:AddItem(Explosion, .3)
				PlaySound(HRT, WeaponEffects.FlowerBoomsHitSound)
				for i=1,#ExplosionParts do
					TweenService:Create(ExplosionParts[i], TweenInfo.new(.3), {Size = ExplosionParts[i].Size*SizeMultiplier}):Play()
				end
				task.wait(.125)
				for i=1,#ExplosionParts do
					TweenService:Create(ExplosionParts[i], TweenInfo.new(.175, Enum.EasingStyle.Linear), {Transparency = 1}):Play()
				end
			end
		end

		local Sword = Character:WaitForChild(Type)
		local Blade = Sword:FindFirstChild("HB") or Sword:FindFirstChild("Blade")

		coroutine.wrap(function()
			local Hitbox = Blade
			local Params = OverlapParams.new()
			Params.FilterType = Enum.RaycastFilterType.Blacklist
			Params.FilterDescendantsInstances = {List.Character, workspace.Debris}
			repeat
				local NewParts = workspace:GetPartsInPart(Hitbox, Params)
				local HitList = {}
				for i=1,#NewParts do
					if List.SwordAttack and NewParts[i].Parent:FindFirstChild("Humanoid") and NewParts[i].Parent:FindFirstChild("Humanoid").Health > 0 and NewParts[i].Parent ~= List.Character and not HitList[NewParts[i].Parent] 
						and (NewParts[i].Parent.PrimaryPart.Position - List.RootPart.Position).Magnitude < 10 then
						CombatShortcuts.TouchedHit(NewParts[i], Blade, List, nil, DamageEffect)
						break
					end
				end
				task.wait(0.1)
			until Hitbox.Parent == nil
		end)()


		if Type == "GhastSword" then
			List.AnimationList.GhastSwordIdle:Play()
			List.IdleAnimation = List.AnimationList.GhastSwordIdle
		elseif Type == "EasterKatana" then
			coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Sword, "Equip")
		end
	elseif Type == "Pistol" then
		List.AnimationList.PistolEquip:Play()
		Unlock:FireClient(play, WeaponSpecialMove, true)
	elseif Type == "EasterBow" then
		List.AnimationList.BowIdle:Play()
		List.IdleAnimation = List.AnimationList.BowIdle
		Unlock:FireClient(play, WeaponSpecialMove, true)
	elseif table.find(OtherWeapons, Type) then
		Unlock:FireClient(play, WeaponSpecialMove, true)
	elseif Type == "HalloweenScythe" then
		Unlock:FireClient(play, WeaponSpecialMove, true)
		local Sword = Character:WaitForChild(Type)
		local Blade = Sword:FindFirstChild("Blade")

		Sword.HB.Touched:Connect(function(hit)
			CombatShortcuts.TouchedHit(hit, Blade, List)
		end)

		if Sword:GetAttribute("Tier") == 1 then
			Character.Animate.idle.Animation1.AnimationId = "rbxassetid://2594705012"
		elseif Sword:GetAttribute("Tier") == 2 then
			Character.Animate.idle.Animation1.AnimationId = "rbxassetid://4352868646"
		end
	elseif Type == "ClockworkBlade" then
		Unlock:FireClient(play, WeaponSpecialMove, true)
		local Sword = Character:WaitForChild(Type)
		local Blade = Sword:FindFirstChild("HB")
		List.SwordAttack = false
		coroutine.wrap(function()
			local Hitbox = Sword.HB
			local Params = OverlapParams.new()
			Params.FilterType = Enum.RaycastFilterType.Blacklist
			Params.FilterDescendantsInstances = {List.Character, workspace.Debris}
			repeat
				local NewParts = workspace:GetPartsInPart(Hitbox, Params)
				local HitList = {}
				for i=1,#NewParts do
					if List.SwordAttack and NewParts[i].Parent:FindFirstChild("Humanoid") and NewParts[i].Parent:FindFirstChild("Humanoid").Health > 0 and NewParts[i].Parent ~= List.Character and not HitList[NewParts[i].Parent] 
						and (NewParts[i].Parent.PrimaryPart.Position - List.RootPart.Position).Magnitude < 15 then
						HitList[NewParts[i].Parent] = true
						List.SwordAttack = false
						List.Cooldown = true
						local hum = NewParts[i].Parent:FindFirstChildOfClass("Humanoid")
						local HRT = NewParts[i].Parent.PrimaryPart
						DmgFunction:Fire(List.Character, hum, Sword:GetAttribute("Damage"))
						Information.Knockback({
							HitCharacter = HRT.Parent,
							Stunner = Character,
							StunType = "Light"
						})
					end
				end
				task.wait(.1)
			until Hitbox.Parent == nil
		end)()
	elseif Type == "JesterScythe" then
		Unlock:FireClient(play, WeaponSpecialMove, true)
		local Sword = Character:WaitForChild(Type)
		local Blade = Sword:FindFirstChild("Blade")
		coroutine.wrap(function()
			local Hitbox = Sword.HB
			local Params = OverlapParams.new()
			Params.FilterType = Enum.RaycastFilterType.Blacklist
			Params.FilterDescendantsInstances = {List.Character, workspace.Debris}
			repeat
				local NewParts = workspace:GetPartsInPart(Hitbox)
				for i=1,#NewParts do
					CombatShortcuts.TouchedHit(NewParts[i], Blade, List)
				end
				wait(.1)
			until Hitbox.Parent == nil
		end)()
		local DmgMultiplier = Sword:GetAttribute("Damage")
		Character.Animate.idle.Animation1.AnimationId = "rbxassetid://7986318837"
		List.AnimationList.JesterScytheWalk:Play()
		List.WalkAnimation = List.AnimationList.JesterScytheWalk
	elseif Type == "JesterSpear" then
		Unlock:FireClient(play, WeaponSpecialMove, true)
		local Sword = Character:WaitForChild(Type)
		local Blade = Sword:FindFirstChild("Main")
		coroutine.wrap(function()
			local Hitbox = Sword.HB
			local Params = OverlapParams.new()
			Params.FilterType = Enum.RaycastFilterType.Blacklist
			Params.FilterDescendantsInstances = {List.Character, workspace.Debris}
			repeat
				local NewParts = workspace:GetPartsInPart(Hitbox)
				for i=1,#NewParts do
					CombatShortcuts.TouchedHit(NewParts[i], Blade, List)
				end
				wait(.1)
			until Hitbox.Parent == nil
		end)()
		local DmgMultiplier = Sword:GetAttribute("Damage")
		Character.Animate.idle.Animation1.AnimationId = "rbxassetid://4352868646" -- Placeholder mayhaps
	elseif Type == "EasterStaff" then
		Unlock:FireClient(play, WeaponSpecialMove, true)
		Character.Animate.idle.Animation1.AnimationId = "rbxassetid://507766666"
		List.AnimationList.StaffWalk:Play()
		List.WalkAnimation = List.AnimationList.StaffWalk
	elseif Weapons:FindFirstChild(Type) then
		Unlock:FireClient(Player, "B", true)
		local Weapon = Character:WaitForChild(Type)
		local Blade = Weapon:WaitForChild("Blade")
		local DmgMultiplier = Weapon:GetAttribute("Damage")
		if Weapon:GetAttribute("Type") and Weapon:GetAttribute("Type") == "Sword" then
			Blade.Touched:Connect(function(hit)
				if List.SwordAttack == true and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Name ~= Player.Name then
					List.SwordAttack = false
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
					if HRT:FindFirstChild("Light") == nil then
						CombatShortcuts.WhenHit(Character, false, hit, Blade, {}, {23*List.Strength/2*DmgMultiplier, 0.1, 1})
					end
				end
			end)
		end
	elseif Type ~= "HalloweenScythe" or Type ~= "JesterScythe" or Type ~= "EasterStaff" or Type ~= "GhastSword" then
		if Type == "N/A" then
			Unlock:FireClient(play, WeaponSpecialMove, false)
		end
		Character.Animate.idle.Animation1.AnimationId = OrigIdleAnim
		if List.WalkAnimation then
			List.WalkAnimation:Stop()
			List.WalkAnimation = nil
		end
		if List.IdleAnimation then
			List.IdleAnimation:Stop()
			List.IdleAnimation = nil
		end
	end
end

local function LoadCharacterAnimations(Humanoid)
	local AnimationDictionary = {}

	for WeaponType, AnimationList in pairs(Animations) do
		local newWeaponType = WeaponType
		local newAnimationList
		if type(AnimationList) == "table" then
			newAnimationList = {}
			for i = 1, #AnimationList do
				table.insert(newAnimationList, Humanoid:LoadAnimation(AnimationList[i]))
			end
		else
			newAnimationList =  Humanoid:LoadAnimation(AnimationList)
		end
		AnimationDictionary[newWeaponType] = newAnimationList
	end

	return AnimationDictionary
end

local function CreateValues(List)
	List.WeaponObject  = List.Character.WObj
	List.GearObject    = List.Character.GObj

	List.Anim          = 1
	List.Cooldown      = false
	List.CanFreeze     = true
	List.UpDashedTimes = 0
	List.UpDashCD      = false
	List.SwordAttack   = false
	List.Dashing       = false
	List.SupaSwing     = false
	List.OrigIdleAnim  = List.Character.Animate.idle.Animation1.AnimationId
	List.IdleAnimation = nil
	List.WalkAnimation = nil

	local AnimationList = LoadCharacterAnimations(List.Character.Humanoid)
	List.AnimationList  = AnimationList

	local Connections = {}

	Connections.Tool_IDConnection      = List.Character:GetAttributeChangedSignal("Tool_ID"):Connect(function()      List.ToolID       = List.Character:GetAttribute("Tool_ID"); end)
	Connections.Weapon_IDConnection    = List.Character:GetAttributeChangedSignal("Weapon_ID"):Connect(function()    List.WeaponID     = List.Character:GetAttribute("Weapon_ID"); end)
	Connections.ArmorDefenseConnection = List.Character:GetAttributeChangedSignal("ArmorDefense"):Connect(function() List.ArmorDefense = List.Character:GetAttribute("ArmorDefense"); end)
	Connections.DefenseConnection      = List.Character:GetAttributeChangedSignal("Defense"):Connect(function()      List.Defense      = List.Character:GetAttribute("Defense"); end)
	Connections.WeaponConnection       = List.Character:GetAttributeChangedSignal("Weapon_Type"):Connect(function() WeaponChange(List.Player, List.Character:GetAttribute("Weapon_Type")); List.WeaponType = List.Character:GetAttribute("Weapon_Type"); end)
	Connections.ToolConnection         = List.Character:GetAttributeChangedSignal("Tool_Type"):Connect(function()   ToolChange(List.Player, List.Character:GetAttribute("Tool_Type")); List.WeaponType = List.Character:GetAttribute("Tool_Type"); end)

	local function DisconnectEvents()
		for _, Con in pairs(Connections) do
			Connections[Con] = Con and Con:Destroy()
		end
	end

	Connections.DoubleJumpConnection = List.Character.Humanoid.StateChanged:Connect(function(oldState, newState)
		if newState == Enum.HumanoidStateType.Landed or List.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
			List.UpDashedTimes = 0
		end
	end)

	Connections.CharacterAddedConnection = List.Player.CharacterAdded:Connect(function()
		List.List.Character:SetAttribute("Attacking", true)
		DisconnectEvents()
	end)

	Connections.LeaveConnection = List.Player.AncestryChanged:Connect(function() DisconnectEvents() end)
end

local function CharacterAdded(Player)
	repeat wait() until Player.Character or Player.CharacterAdded
	local TimeOut = tick() + 1

	DataModule.SetPlayerDataToList(Player);

	repeat wait() until DataModule.PlayerInformation[Player.UserId] or tick() >= TimeOut
	if not DataModule.PlayerInformation[Player.UserId] then 
		warn("Player not found in server datafile.");
		DataModule.SetPlayerDataToList(Player);
		CharacterAdded(Player)
		return 
	end

	local List     = DataModule.PlayerInformation[Player.UserId]
	List.Character = Player.Character or Player.CharacterAdded:Wait()
	List.RootPart  = List.Character.PrimaryPart

	for v,p in pairs(List.Character:GetChildren()) do
		if p:IsA("BasePart") then
			game.PhysicsService:SetPartCollisionGroup(p, "n")
		end
	end

	CreateValues(List)
end

script.Player.OnServerEvent:Connect(CharacterAdded)

--================================ [DASH EVENTS] =================================--

local FlyingQuirks = {
	6,
	15,
	20,
}

local NamesThings = {
	"xlxAuroraxIx",
	"xlxAuroraxlx",
}

local Huge = math.huge

local function GetMeOutOfThisMesh(Mesh, Distance, Direction, Character)
	local RootPart = Character.PrimaryPart
	local Params = OverlapParams.new()
	Params.FilterType = Enum.RaycastFilterType.Whitelist
	Params.FilterDescendantsInstances = {Character}

	local Result = workspace:GetPartsInPart(Mesh, Params)
	if Result then
		for ChildIndex, Child in pairs(Result) do
			local SafeTp = Instance.new("NumberValue", Character)
			SafeTp.Name = "SafeTp"
			game.Debris:AddItem(SafeTp,.2)
			RootPart.Position += Direction*Distance
			break
		end
	end
end

local function GetDistanceBeforeStop(Direction, Power, Duration, Agility, RootPart)
	local Params        = RaycastParams.new()
	local newPower      = Power
	local newDuration   = Duration
	local FilteredParts = {RootPart.Parent}
	Params.FilterDescendantsInstances = FilteredParts
	local Distance = (Agility > 2000 and 2000 or Agility) * (0.225/2) -- Half of the maxium distance you can go
	local RC       = RootPart.CFrame
	local Result1
	local Result2
	repeat
		Result1   = workspace:Raycast(RootPart.Position - RC.LookVector*2 - RC.RightVector*0.75, Direction*(Distance), Params)
		Result2   = workspace:Raycast(RootPart.Position - RC.LookVector*2 + RC.RightVector*0.75, Direction*(Distance), Params)
		local RM1
		local RM2
		if Result1 and Result1.Instance.CanCollide then
			RM1 = (RootPart.Position - Result1.Position).Magnitude
			if Result2 and Result2.Instance.CanCollide then
				RM2 = (RootPart.Position - Result2.Position).Magnitude
				if RM1 > RM2 then
					newPower*= RM2/Distance
				else
					newPower*= RM1/Distance
				end
				if (Result1.Position - RootPart.Position).Magnitude > 5 then
					coroutine.wrap(GetMeOutOfThisMesh)(Result1.Instance, newPower+5, Direction, RootPart.Parent)
				end
			else
				newPower  *= RM1/Distance
			end
			newDuration   *= newPower/Power
			if newDuration < Duration/4 then newDuration = Duration/4 end
			break
		elseif Result1 and not Result1.Instance.CanCollide then
			table.insert(FilteredParts, Result1.Instance)
			Params.FilterDescendantsInstances = FilteredParts
		end
		game:GetService("RunService").Heartbeat:Wait()
	until not Result1
	return newPower, newDuration
end

Dash.OnServerEvent:Connect(function(play, DashType)

	local List = DataModule.PlayerInformation[play.UserId]
	if not List then return end

	local Character     = List.Character or play.Character
	local Stamina 		= Character:GetAttribute("Stamina")
	local Agility       = List.Agility
	local Strength      = List.Strength
	local Quirk         = List.Quirk
	local RootPart      = List.RootPart
	local UpDashCD      = List.UpDashCD
	local Duration      = .4
	local Attack        = Character:GetAttribute("Attacking")

	List.Character = List.Character or play.Character
	if Stamina < 25 or List.Dashing or Attack or RootPart:FindFirstChild("Heavy") or RootPart:FindFirstChild("Light") then return end
	Character:SetAttribute("Attacking", true)
	Character:SetAttribute("Stamina", Character:GetAttribute("Stamina") - 25)

	local newTable = { -- 1: Direction | 2: Negative(Applies to direction) | 3: Animation
		["Front"] = {RootPart.CFrame.lookVector,   1,  List.AnimationList.FrontDashAnim}, 
		["Back"]  = {RootPart.CFrame.lookVector,  -1,  List.AnimationList.BackDashAnim},
		["Left"]  = {RootPart.CFrame.rightVector, -1,  List.AnimationList.LeftDashAnim},
		["Right"] = {RootPart.CFrame.rightVector,  1,  List.AnimationList.RightDashAnim},
	}

	if not Character:GetAttribute("Dashing") then
		Character:SetAttribute("Dashing", true)
		
		if DashType == "Up" then
			if not table.find(FlyingQuirks, Quirk) and not table.find(NamesThings, play.Name) and not UpDashCD and List.UpDashedTimes <= (3+math.floor(Strength/1000)) then
				List.UpDashedTimes += 1
				Dash:FireClient(play)
				List.AnimationList.UpDashAnim:Play()
				local UpDashEf = UniversalAssetFolder.UpDashEffect:Clone()
				UpDashEf.Parent = workspace.Debris
				UpDashEf.CFrame = RootPart.CFrame
				game.Debris:AddItem(UpDashEf, 0.5)
				TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(35,0.05,35)}):Play()
				TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
				TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()
			end
		else
			Character.Humanoid.AutoRotate = false
			List.Dashing        = true
			local Velocity      = Instance.new("BodyVelocity")
			local DashType      = newTable[DashType]
			local Power         = (125 + Agility * .1)
			Velocity.Name       = "Skill"
			Velocity.MaxForce   = Vector3.new(Huge, 0, Huge)

			if Power > 325 then Power = 325 end
			local Power, newDuration = GetDistanceBeforeStop(DashType[1]*DashType[2], Power, Duration, Agility, RootPart)
			Duration = newDuration

			DashType[3]:Play()
			wait(.1)
			Velocity.Velocity = DashType[1]*(Power*DashType[2])
			Velocity.Parent   = RootPart
			game.Debris:AddItem(Velocity,.4)
		end
		
		Character:SetAttribute("Dashing", false)
	end
	wait(Duration)
	Character.Humanoid.AutoRotate = true
	Character:SetAttribute("Attacking", false)
	wait(.1)
	List.Dashing = false
end)

--================================ [SPECIAL WEAPON EVENTS] =================================--

----- Weapon Configuration -----

-- Peppermint Saber
local PeppermintSaberSettings = {
	Cooldown = 10,
	StaminaCost = 25,
	HealingPower = .2, -- Percent of max health || 100 * healingpower = 20
}

-- Easter Grimoire
local EasterGrimoireSettings = {
	Cooldown = 10,
	HealingPower = .02, -- Percent of Full Health Ex. 100*HealingPower = 2
	Damage = nil,
	StaminaCost = 25,
}

RightSwing.OnServerEvent:Connect(function(play, direc)
	local List = DataModule.PlayerInformation[play.UserId]
	if not List then return end

	List.Character = List.Character or play.Character
	local Character   = List.Character
	local Type        = List.Character:GetAttribute("Weapon_Type")
	local Weapon      = List.WeaponObject.Value
	local Tier        = Weapon and Weapon:GetAttribute("Tier") or 1
	local Exp         = List.Exp
	local RootPart    = List.RootPart
	local SupaSwing   = List.SupaSwing
	local Humanoid    = List.Character.Humanoid
	local Player      = play
	local Cooldown    = List.Cooldown
	local Stamina     = Character:GetAttribute("Stamina")
	local StaminaCost = Weapon and Weapon:GetAttribute("StaminaCost")

	local function SetAT(name, val)
		Character:SetAttribute(name, val)
	end
	local function IncAT(name, val)
		Character:SetAttribute(name, Character:GetAttribute(name) + val)
	end

	if not Weapon then return end
	if not List.Character then List.Character = play.Character end
	if SupaSwing or List.Character:GetAttribute("Attacking") or Cooldown or List.Character:GetAttribute("Stunned") or StaminaCost and (tonumber(StaminaCost) > tonumber(Stamina)) then return end
	List.Character:SetAttribute("Attacking", true)
	List.Cooldown = true

	if Type == "HalloweenScythe" then
		local Scythe = Weapon

		local DmgMultiplier = Scythe:FindFirstChild("DMG")
		Usage:FireClient(Player, true, WeaponSpecialMove)	
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")

		local AttackAngles = {
			CFrame.Angles(math.rad(0),math.rad(-72),math.rad(0)),
			CFrame.Angles(math.rad(0),math.rad(-81),math.rad(0)),
			CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),
			CFrame.Angles(math.rad(0),math.rad(-99),math.rad(0)),
			CFrame.Angles(math.rad(0),math.rad(-108),math.rad(0))
		}
		local PlayersHitted = {}
		local Amt = Tier == 2 and 5 or 1--1; if Tier == 2 then Amt = 5 end
		for i=1, Amt do
			local Clone = WeaponEffects.HalloweenBossEffect2:Clone()
			Clone.CFrame = RootPart.CFrame*CFrame.new(0,0,10)*AttackAngles[i]
			if Tier == 1 then Clone.CFrame = RootPart.CFrame*CFrame.new(0,0,10)*CFrame.Angles(math.rad(90),math.rad(90),math.rad(90)) end

			local BV = Instance.new("BodyVelocity", Clone)
			BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			BV.Velocity = Clone.CFrame.RightVector*-200
			Clone.Parent = workspace.Debris
			game.Debris:AddItem(Clone, 2)
			coroutine.wrap(function()
				wait(1)
				for i,v in pairs(Clone:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v.Enabled = false
					end
				end
				wait(.5)
				coroutine.wrap(CombatShortcuts.TrailEffect)(Clone, false)
				TweenService:Create(Clone,TweenInfo.new(.4),{Transparency = 1}):Play()
			end)()
			local newSettings = {
				Player = Character,
				Damage = Weapon:GetAttribute("Damage") * (3/2.475),
				MoveDuration = 2,
				HitboxType = "Touched",
				PlayersHit = PlayersHitted
			}
			SpatialHitbox.Add(Clone, newSettings)
		end
		local Scythe = Weapon
		coroutine.wrap(CombatShortcuts.TrailEffect)(Scythe.Blade, true)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		IncAT("Stamina", -StaminaCost)
		wait(.6)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Scythe.Blade, false)
	elseif Type == "CursedGlove" then
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Character:FindFirstChild(Type), 1.5)
		wait(0.3)
		local Clone = WeaponEffects.CursedGloveBlast:Clone()
		Clone.Parent = workspace.Debris
		Clone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,0,40)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90)))
		local sound1 = Instance.new("Sound")
		sound1.SoundId = "rbxassetid://138137702"
		sound1.MaxDistance = 300
		sound1.EmitterSize = 20
		sound1.Volume = 0.25
		sound1.Pitch = 0.95
		sound1.Parent = RootPart 
		sound1:Play()
		game.Debris:AddItem(sound1, sound1.TimeLength)
		for i,v in pairs(Clone:GetChildren()) do
			local velocity = Instance.new("BodyVelocity",v)
			velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			velocity.Velocity = RootPart.CFrame.lookVector * 200
		end
		local newSettings = {
			Player          = Character,
			Damage          = Weapon:GetAttribute("Damage") * (3/2.25),
			MoveDuration    = 1.5,
			Parent          = Clone,
			HitboxType      = "Touched",
		}
		SpatialHitbox.Add(Clone.Smash, newSettings)
		coroutine.wrap(function()
			pcall(function()
				repeat wait()
					Clone.MeshPart.CFrame = Clone.MeshPart.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
					Clone.Smash.CFrame = Clone.Smash.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(29))
					Clone.ew.CFrame = Clone.ew.CFrame * CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
				until Clone == nil or Clone.Parent == nil
			end)
		end)()
		wait(1)
		TweenService:Create(Clone.Smash, TweenInfo.new(0.5), {Transparency = 1}):Play()
		TweenService:Create(Clone.MeshPart, TweenInfo.new(0.5), {Transparency = 1}):Play()
		TweenService:Create(Clone.ew, TweenInfo.new(0.5), {Transparency = 1}):Play()
		game.Debris:AddItem(Clone, .5)
	elseif Type == "IceSickle" then
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Character:FindFirstChild(Type), nil, "Special")

		wait(0.25)
		local IcePart = WeaponEffects.IceSickleSpike:Clone()
		IcePart.CFrame = RootPart.CFrame * CFrame.new(0,-2,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		IcePart.Parent = workspace.Debris

		local newSettings = {
			Player          = Character,
			Damage          = Weapon:GetAttribute("Damage") * (2.25/2.25),
			MoveDuration    = 2.5,
			HitboxType      = "InPart",
		}
		SpatialHitbox.Add(IcePart, newSettings)
		coroutine.wrap(function()
			TweenService:Create(IcePart, TweenInfo.new(1), {Size = Vector3.new(180,60,60),CFrame = IcePart.CFrame * CFrame.new(90,25,0)}):Play()
			wait(2)
			TweenService:Create(IcePart, TweenInfo.new(0.5), {Transparency = 1}):Play()
		end)()
		wait(1)
	elseif Type == "EasterSwford" then
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)
		List.AnimationList.EasterSwordSpecial:Play()

		local Sword = Character:FindFirstChild("EasterSword")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Sword.Blade, true)

		wait(.25)
		local BladeSpinEffect = WeaponEffects.BladeSpin:Clone()
		if BladeSpinEffect:FindFirstChild("Main") then
			BladeSpinEffect.Main.Handle.Part1 = RootPart
		end
		BladeSpinEffect.Parent = workspace.Debris
		coroutine.wrap(function()
			coroutine.wrap(function()
				repeat wait()
					BladeSpinEffect.Main.Handle.C0 = BladeSpinEffect.Main.Handle.C0*CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
				until BladeSpinEffect.Main == nil or BladeSpinEffect == nil
			end)()
			wait(3)
			for i,v in pairs(BladeSpinEffect:GetChildren()) do
				TweenService:Create(v,TweenInfo.new(.5), {Transparency = 1}):Play()
			end
			wait(.5)
			BladeSpinEffect:Destroy()
		end)()

		local newSettings = {
			Player          = Character,
			Damage          = .5,
			MoveDuration    = 3.5,
			UseDoTForNormal = true,
			NormalDoTDamage = .5,
			DoTRateOfHit    = .4375,
			Parent          = BladeSpinEffect,
			HitboxType      = "Sphere",
		}
		SpatialHitbox.Add(BladeSpinEffect.Main, newSettings)

		wait(3.5)
		List.AnimationList.EasterSwordSpecial:Stop()
		coroutine.wrap(CombatShortcuts.TrailEffect)(Sword.Blade, false)
	elseif Type == "OrnamentBlaster" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)

		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		local pp = Instance.new("Part", workspace.Debris)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.Size = Vector3.new(2,2,2)
		pp.CFrame = CFrame.new(pp.CFrame.p, direc.p)

		local cframe = pp.CFrame
		task.wait(0.5)
		pp.Anchored = false

		local Laser = WeaponEffects.RayGunBeam:Clone()
		Laser.Parent = workspace.Debris
		Laser:SetPrimaryPartCFrame(pp.CFrame*CFrame.new(0, 0, -10)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(90)))
		TweenService:Create(Laser.beam.inner,  TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-200)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), Size = Vector3.new(15.012, 15.012, 400)}):Play()
		TweenService:Create(Laser.beam.outer,  TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-200)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 19.168, 400)}):Play()
		TweenService:Create(Laser.beam.outer2, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-200)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 19.168, 400)}):Play()
		TweenService:Create(Laser.HB,          TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-200)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), Size = Vector3.new(15.012, 15.012, 400)}):Play()
		TweenService:Create(pp,                TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-400)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()
		TweenService:Create(Laser.middle,      TweenInfo.new(2.5), {Transparency = 1, Size = Laser.middle.Size+Vector3.new(Laser.middle.Size.X*6, Laser.middle.Size.Y*6, Laser.middle.Size.Z*6)}):Play()
		TweenService:Create(Laser.out,         TweenInfo.new(2.5), {Transparency = 1, Size = Laser.middle.Size+Vector3.new(Laser.out.Size.X*6, Laser.out.Size.Y*6, Laser.out.Size.Z*6)}):Play()
		TweenService:Create(Laser.out2,        TweenInfo.new(2.5), {Transparency = 1, Size = Laser.middle.Size+Vector3.new(Laser.out2.Size.X*6, Laser.out2.Size.Y*6, Laser.out2.Size.Z*6)}):Play()
		TweenService:Create(Laser.shockwave,   TweenInfo.new(2.5), {Transparency = 1, Size = Laser.shockwave.Size+Vector3.new(100, 100, 100)}):Play()
		TweenService:Create(Laser.shockwave2,  TweenInfo.new(2.5), {Transparency = 1, Size = Laser.shockwave.Size+Vector3.new(100, 100, 100)}):Play()

		task.spawn(function()
			local middle = Laser.middle
			while middle and wait() do
				Laser.middle.CFrame = Laser.middle.CFrame*CFrame.Angles(0, 0, 29)
				Laser.out.CFrame = Laser.out.CFrame*CFrame.Angles(0, 0, 29)
				Laser.out2.CFrame = Laser.out2.CFrame*CFrame.Angles(0, 0, 29)
			end
		end)
		task.spawn(function()
			local shock = Laser.shockwave
			while shock and wait() do
				Laser.shockwave.CFrame = Laser.shockwave.CFrame*CFrame.Angles(0, 0, 29)
				Laser.shockwave2.CFrame = Laser.shockwave2.CFrame*CFrame.Angles(0, 0, 29)
			end
		end)

		game.Debris:AddItem(Laser,2.5)
		game.Debris:AddItem(pp,2.5)
		local Hitted = false
		local PlayerHitAmount = 0
		local PlayersHitted = {}
		local PlayersHit = {}

		local function GoshWhatAWasteOfTime(ExplodeModel)
			for ChildIndex, Child in pairs(ExplodeModel:GetChildren()) do
				coroutine.wrap(function()
					if Child ~= ExplodeModel.HB then
						Child.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
						TweenService:Create(Child, TweenInfo.new(.5),   {Size = Child.Size*10}):Play()
						TweenService:Create(Child, TweenInfo.new(2), {Orientation = Child.Orientation * Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))}):Play()
						task.wait(1.5)
						TweenService:Create(Child, TweenInfo.new(.5),   {Transparency = 1}):Play()
						if Child == ExplodeModel.Base then
							task.wait(.25)
							for Children, Child2 in pairs(Child.Attachment:GetChildren()) do
								Child2.Enabled = false
							end
						end
					end
				end)()
			end
			local newSettings = {
				Player = List.Character,
				HitboxType = "Sphere",
				Damage = Weapon:GetAttribute("Damage") * 1.25,
				MoveDuration = 2,
			}
			SpatialHitbox.Add(ExplodeModel.HB, newSettings)
		end

		pp.Touched:Connect(function(hitto)
			if not Hitted and not hitto:IsDescendantOf(Character) then
				Hitted = true
				local ExplodeModel = WeaponEffects.RayGunImpact:Clone()
				ExplodeModel.Parent = workspace.Debris
				ExplodeModel:SetPrimaryPartCFrame(pp.CFrame)
				GoshWhatAWasteOfTime(ExplodeModel)
			end	
		end)
		Laser.beam.inner.Touched:Connect(function(hitto)
			if hitto.Parent:FindFirstChild("Humanoid") and hitto.Parent:FindFirstChild("Humanoid").Health > 0 and hitto.Parent.Name ~= Player.Name and PlayerHitAmount < 2 then
				if table.find(PlayersHit, hitto.Parent) then return end
				table.insert(PlayersHit, hitto.Parent)
				PlayerHitAmount = PlayerHitAmount + 1
				local hum = hitto.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hitto.Parent:FindFirstChild("HumanoidRootPart")
				local ExplodeModel = WeaponEffects.RayGunImpact:Clone()
				ExplodeModel.Parent = workspace.Debris
				ExplodeModel:SetPrimaryPartCFrame(pp.CFrame)
				GoshWhatAWasteOfTime(ExplodeModel)
			end
		end)
		wait(1.5)
	elseif Type == "PeppermintSaber" then
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		local PeppermintSuper = WeaponEffects.PeppermintSuper:Clone()
		PeppermintSuper.Parent = workspace.Debris
		local Weld = Instance.new("Weld", PeppermintSuper.LeftHand)
		Weld.Part0 = PeppermintSuper.LeftHand
		Weld.Part1 = Character.LeftHand
		local Weld2 = Instance.new("Weld", PeppermintSuper.RightHand)
		Weld2.Part0 = PeppermintSuper.RightHand
		Weld2.Part1 = Character.RightHand
		game.Debris:AddItem(PeppermintSuper,2.5)

		wait(2)

		local PeppermintSaberPE = WeaponEffects.PeppermintSaberPE:Clone()
		PeppermintSaberPE.Parent = RootPart
		local PeppermintSaberPE2 = WeaponEffects.PeppermintSaberPE2:Clone()
		PeppermintSaberPE2.Parent = RootPart

		Humanoid.Health += Humanoid.MaxHealth*PeppermintSaberSettings.HealingPower

		wait(1)
		PeppermintSaberPE.Enabled = false
		PeppermintSaberPE2.Enabled = false

		game.Debris:AddItem(PeppermintSaberPE, 2)
		game.Debris:AddItem(PeppermintSaberPE2, 2)
	elseif Type == "GhastSword" then
		local Sword = Character:FindFirstChild("GhastSword")
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")

		wait(.48)
		local Clone = WeaponEffects.GhastSwordAttack:Clone()
		Clone.Parent = workspace.Debris
		Clone.GroundCrack.CFrame = RootPart.CFrame*CFrame.new(0, -45, 0)*CFrame.Angles(0, math.rad(90), 0)
		game.TweenService:Create(Clone.GroundCrack, TweenInfo.new(0.3), {CFrame = Clone.GroundCrack.CFrame*CFrame.new(95, 49, 0)}):Play()
		local Clone2 =  WeaponEffects.GhostSwordShock:Clone()
		Clone2.Size = Vector3.new(5,1,5)
		Clone2.CFrame = RootPart.CFrame
		Clone2.Parent = workspace.Debris
		Clone2.Transparency = .5
		game.Debris:AddItem(Clone2,1)
		TweenService:Create(Clone2,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(200,40,200),Position = Clone2.Position+Vector3.new(0,20,0)}):Play()
		coroutine.wrap(function()
			repeat wait()
				Clone2.CFrame = Clone2.CFrame*CFrame.Angles(math.rad(0),math.rad(29),math.rad(0))
			until Clone2 == nil
		end)()
		if Tier == 2 then Clone.GroundCrack.lightning.Enabled = true end
		local newSettings = {
			HitboxType = "Box",
			Damage = Weapon:GetAttribute("Damage") * 1.18,
			MoveDuration = 1.7,
			Player = Character
		}
		SpatialHitbox.Add(Clone.HB, newSettings)
		coroutine.wrap(function()
			wait(.1)
			game.TweenService:Create(Clone.Crater1, TweenInfo.new(.5), {Size = Clone.Crater1.Size+Vector3.new(30, 0, 30)}):Play()
			game.TweenService:Create(Clone.Crater1.Cracks, TweenInfo.new(.5), {Transparency = 0}):Play()
			local S = Clone.Shockwave1.Size+Vector3.new(10, 10, 30)
			Clone.Shockwave1.Size = Vector3.new(3, 3, 3)
			game.TweenService:Create(Clone.Shockwave1, TweenInfo.new(.5), {Size = S, Transparency = 0}):Play()
			coroutine.wrap(function()
				wait(.5)
				game.TweenService:Create(Clone.Shockwave1, TweenInfo.new(.15), {Transparency = 1}):Play()
			end)()
			wait(.15)
			game.TweenService:Create(Clone.Crater3, TweenInfo.new(.5), {Size = Clone.Crater1.Size+Vector3.new(40, 0, 40)}):Play()
			game.TweenService:Create(Clone.Crater3.Cracks, TweenInfo.new(.5), {Transparency = 0}):Play()
			S = Clone.Shockwave2.Size+Vector3.new(10, 10, 30)
			Clone.Shockwave2.Size = Vector3.new(3, 3, 3)
			game.TweenService:Create(Clone.Shockwave2, TweenInfo.new(.5), {Size = S, Transparency = 0}):Play()
			coroutine.wrap(function()
				wait(.5)
				game.TweenService:Create(Clone.Shockwave2, TweenInfo.new(.15), {Transparency = 1}):Play()
			end)()
			wait(.15)
			game.TweenService:Create(Clone.Crater2, TweenInfo.new(.5), {Size = Clone.Crater1.Size+Vector3.new(50, 0, 50)}):Play()
			game.TweenService:Create(Clone.Crater2.Cracks, TweenInfo.new(.5), {Transparency = 0}):Play()
			S = Clone.Shockwave3.Size+Vector3.new(10, 10, 30)
			Clone.Shockwave3.Size = Vector3.new(3, 3, 3)
			game.TweenService:Create(Clone.Shockwave3, TweenInfo.new(.5), {Size = S, Transparency = 0}):Play()
			wait(.5)
			game.TweenService:Create(Clone.Shockwave3, TweenInfo.new(.15), {Transparency = 1}):Play()
		end)()
		game.Debris:AddItem(Clone, 3)
		coroutine.wrap(function()
			wait(2.5)
			for v,parts in pairs(Clone:GetDescendants()) do
				if (parts:IsA("BasePart") or parts:IsA("Decal")) and parts.Transparency ~= 1 then
					game.TweenService:Create(parts, TweenInfo.new(.5), {Transparency = 1}):Play()
				end
			end
		end)()
		wait(.7)
	elseif Type == "SnowSword" then
		local Sword = Character:FindFirstChild("SnowSword")
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		local Amt = 1; if Tier == 2 then Amt = 2 end
		wait(.3)
		local Angles = {CFrame.Angles(0, 0, -40), CFrame.Angles(0, 0, 40)}
		for i=1, Amt do
			local Clone = WeaponEffects.SantaSliceEffect:Clone()
			Clone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,15,10)*CFrame.Angles(math.rad(180), 0, math.rad(90))*Angles[i])

			local BV = Instance.new("BodyVelocity", Clone.HB)
			BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			BV.Velocity = RootPart.CFrame.lookVector * 200
			Clone.Parent = workspace.Debris
			game.Debris:AddItem(Clone,2)

			coroutine.wrap(function()
				wait(1)
				coroutine.wrap(CombatShortcuts.TrailEffect)(Clone, false)
				wait(.5)
				coroutine.wrap(CombatShortcuts.TrailEffect)(Clone, false)
				for ChildIndex, Child in pairs(Clone:GetChildren()) do TweenService:Create(Child,TweenInfo.new(.4),{Transparency = 1}):Play() end
			end)()

			if i == 1 then
				SpatialHitbox.Add(Clone.HB, {
					Parent       = Clone, 
					Player       = List.Character,
					Damage       = Weapon:GetAttribute("Damage") * (3.5 / 2.475),
					HitboxType   = "Touched",
					MoveDuration = 2
				})
			end
		end
		coroutine.wrap(CombatShortcuts.TrailEffect)(Sword, true)
		wait(.6)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Sword, false)
	elseif Type == "Katana" then
		local Sword = Character:FindFirstChild("Katana")
		local DmgMultiplier = Sword:FindFirstChild("DMG")
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)
		local Type = Tier or 1

		PlaySound(RootPart, Sounds.KatanaSkill)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")

		wait(.3)
		local Clone = WeaponEffects["KatanaSlash"..Type]:Clone()
		Clone.CFrame = RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		local BV = Instance.new("BodyVelocity", Clone)
		BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BV.Velocity = RootPart.CFrame.lookVector * 150*DmgMultiplier.Value
		Clone.Parent = workspace.Debris
		task.spawn(function()
			wait(.5)
			coroutine.wrap(CombatShortcuts.TrailEffect)(Clone, false) -- was false
			wait(.5)
			coroutine.wrap(CombatShortcuts.TrailEffect)(Clone, false)
			TweenService:Create(Clone,TweenInfo.new(.4),{Transparency = 1}):Play()
		end)

		SpatialHitbox.Add(Clone.HB, {
			Player       = List.Character,
			HitboxType   = "Touched",
			MoveDuration = 1.5,
			Damage       = Weapon:GetAttribute("Damage") * (2 / 1.15),
			Parent       = Clone
		})
		local Sword = Character:FindFirstChild("Katana")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Sword, true)
		wait(.6)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Sword, false)
	elseif Type == "Dagger" then
		local Sword = Character:FindFirstChild("Dagger")
		local DmgMultiplier = Sword:FindFirstChild("DMG")
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)
		PlaySound(RootPart, Sounds.DaggerSkill)

		if Tier >= 2 then
			coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
			wait(.2)
			local bv = Instance.new("BodyVelocity",RootPart)
			bv.MaxForce = Vector3.new(math.huge,0,math.huge)
			bv.Name = "DaggerDash"
			bv.Velocity = RootPart.CFrame.lookVector * 200*DmgMultiplier.Value
			game.Debris:AddItem(bv, .5)
			local HitPart = Instance.new("Part", workspace.Debris)
			HitPart.Anchored = false
			HitPart.CanCollide = false
			HitPart.Size = Vector3.new(20,20,20)
			HitPart.Transparency = 1
			HitPart.CFrame = RootPart.CFrame
			game.Debris:AddItem(HitPart,.75)
			local Weld = Instance.new("Weld", HitPart)
			Weld.Part0 = HitPart
			Weld.Part1 = RootPart
			local newSettings = {
				Player       = List.Character,
				HitboxType   = "Touched",
				Damage       = Weapon:GetAttribute("Damage")*(2.25 / 1.3),
				MoveDuration = .75,
			}
			SpatialHitbox.Add(HitPart, newSettings)
			local Sword = Character:FindFirstChild("Dagger")
			coroutine.wrap(CombatShortcuts.TrailEffect)(Sword, true)
			wait(.6)
			coroutine.wrap(CombatShortcuts.TrailEffect)(Sword, false)
			Humanoid.AutoRotate = true
			Humanoid.JumpPower = 50
		end
	elseif Type == "Pistol" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)

		IncAT("Stamina", -StaminaCost)
		local Pistol = Character:FindFirstChild("Pistol")
		local DmgMultiplier = Pistol:FindFirstChild("DMG")
		local amt = 3
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		for i=1, amt do
			wait(.15)
			PlaySound(RootPart, Sounds.GunShot)
			local Orientation = CFrame.lookAt(RootPart.Position, direc.Position)
			local LookVector = Orientation.lookVector
			wait()
			local bullet = ItemAssetFolder.Bullet:Clone()
			bullet.Parent = workspace.Debris
			bullet.CFrame = Orientation*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
			local ring = UniversalAssetFolder.RING:Clone()
			ring.Parent  = workspace.Debris
			ring.CFrame = RootPart.CFrame
			game.Debris:AddItem(ring, .5)

			local velo = Instance.new("BodyVelocity", bullet)
			velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			velo.Velocity = LookVector*250
			coroutine.wrap(function()	
				local newSettings = {
					Player             = List.Character,
					Damage             = Weapon:GetAttribute("Damage") * .75,
					MoveDuration       = 1.5,
					ReturnTable        = true,
					Parent             = bullet,
					PassThroughObjects = true,
				}
				local ReturnedTable = RaycastHitbox.Add(bullet.HB, newSettings)
				if not ReturnedTable or #ReturnedTable.PlayersHit <= 1 then return end

				local ring2 = UniversalAssetFolder.RING:Clone()
				ring2.Parent  = workspace.Debris
				ring2.CFrame = CFrame.lookAt(RootPart.Position, ReturnedTable[1].PrimaryPart.Position)
				game.Debris:AddItem(ring2,0.5)
				TweenService:Create(ring2, TweenInfo.new(0.5),{Transparency = 1}):Play()
				TweenService:Create(ring2.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
			end)()
			TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		end
		List.AnimationList.PistolSpecial[1]:Stop()
		List.AnimationList.T2PistolSpecial[1]:Stop()
		List.AnimationList.T3PistolSpecial[1]:Stop()
		wait(.5)
	elseif Type == "EasterFlintlock" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)

		IncAT("Stamina", -StaminaCost)
		local amt = 8

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")

		local PlayersHitted = {}
		local AimAssist = Instance.new("Part")
		AimAssist.Parent = workspace.Debris
		AimAssist.Transparency = .5
		AimAssist.Anchored = true
		AimAssist.CanCollide = false
		AimAssist.Size = Vector3.new(50, 50, 50)
		AimAssist.CFrame = CFrame.new(direc.p)
		AimAssist.Touched:Connect(function() end)
		local aresults = {}
		aresults = AimAssist:GetTouchingParts()
		for i=1,#aresults do
			if aresults[i].Parent and aresults[i].Parent:FindFirstChildOfClass("Humanoid") and aresults[i].Parent.Humanoid.Health > 0 and not aresults[i]:IsDescendantOf(Character) then
				direc = aresults[i].Parent.HumanoidRootPart
			elseif aresults[i].Parent.Parent and aresults[i].Parent.Parent:FindFirstChildOfClass("Humanoid") and aresults[i].Parent.Parent.Humanoid.Health > 0 and not aresults[i]:IsDescendantOf(Character) then
				direc = aresults[i].Parent.Parent.HumanoidRootPart
			elseif aresults[i].Parent.Parent.Parent and aresults[i].Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") and aresults[i].Parent.Parent.Parent.Humanoid.Health > 0 and not aresults[i]:IsDescendantOf(Character) then
				direc = aresults[i].Parent.Parent.Parent.HumanoidRootPart
			end
		end
		AimAssist:Destroy()
		for i=1, amt do
			wait(.1)
			PlaySound(RootPart, Sounds.GunShot)

			local Orientation = CFrame.lookAt(RootPart.Position, direc.Position)
			local LookVector = Orientation.lookVector
			wait()
			local bullet = ItemAssetFolder.Bullet3:Clone()
			bullet.Parent = workspace.Debris
			bullet.CFrame = Orientation*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
			local ring = UniversalAssetFolder.RING:Clone()
			ring.Parent  = workspace.Debris
			ring.CFrame = RootPart.CFrame
			game.Debris:AddItem(ring, .5)
			local tween = TweenService:Create(bullet, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {CFrame = Orientation*CFrame.new(0, 0, -700)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))})
			tween:Play()

			coroutine.wrap(function()
				local newSettings = {
					Player             = List.Character,
					Parent             = bullet,
					ReturnTable        = true,
					PassThroughObjects = true,
					Damage             = Weapon:GetAttribute("Damage") * 0.5,
					MoveDuration       = 1.5
				}

				local ReturnedTable    = RaycastHitbox.Add(bullet.HB, newSettings);
				if type(ReturnedTable) == "table" and ReturnedTable.PlayersHit[1] then
					if bullet:FindFirstChild("HB") then RaycastHitbox.Remove(bullet.HB, true) end

					local ring2 = UniversalAssetFolder.RING:Clone()
					ring2.Parent  = workspace.Debris
					ring2.CFrame = CFrame.lookAt(ReturnedTable.PlayersHit[1].PrimaryPart.Position, RootPart.Position)
					game.Debris:AddItem(ring2,0.5)
					TweenService:Create(ring2, TweenInfo.new(0.5),{Transparency = 1}):Play()
					TweenService:Create(ring2.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
				end
			end)()

			TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		end
		List.AnimationList.EasterFlintlockSpecial[1]:Stop()
		wait(1)
	elseif Type == "EasterBow" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)

		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")

		local Arrow = WeaponEffects.LargeArrow:Clone()
		Arrow.Parent = workspace.Debris
		Arrow.HB.CFrame = CFrame.lookAt(RootPart.Position, direc.Position)
		coroutine.wrap(function()
			repeat wait(.1)
				local ArrowShock = WeaponEffects.ArrowShock:Clone()
				ArrowShock.Parent = workspace.Debris
				TweenService:Create(ArrowShock, TweenInfo.new(0.5), {Size = Vector3.new(100,50,100), Transparency = 1}):Play()
				game.Debris:AddItem(ArrowShock, .5)	
			until not Arrow:FindFirstChild("HB") or not Arrow.Parent--Arrow == nil or Arrow.HB == nil
		end)()

		TweenService:Create(Arrow.HB, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = Arrow.HB.CFrame*CFrame.new(0, 0, -700)}):Play()

		local newSettings = {
			Player       = List.Character,
			HitboxType   = "Box",
			Damage       = Weapon:GetAttribute("Damage") * (3.5 / 3),
			MoveDuration = 2,
			Parent       = Arrow,
		}
		SpatialHitbox.Add(Arrow.HB, newSettings)
		wait(2)
	elseif Type == "PumpkinPistol" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)

		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		local pp = Instance.new("Part", workspace.Debris)
		pp.Transparency = 1
		pp.Anchored = true
		pp.CanCollide = false
		pp.CFrame = RootPart.CFrame
		pp.Size = Vector3.new(2,2,2)
		pp.CFrame = CFrame.new(pp.CFrame.p, direc.p)
		local cframe = pp.CFrame
		wait(0.5)
		pp.Anchored = false
		local Laser = WeaponEffects.PumpkinPistolLaser:Clone()
		Laser.Parent = workspace.Debris
		Laser:SetPrimaryPartCFrame(pp.CFrame*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		TweenService:Create(Laser.Inside,  TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-205)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(15.012, 400, 15.012)}):Play()
		TweenService:Create(Laser.Outside, TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-205)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 400, 19.168)}):Play()
		TweenService:Create(Laser.HB,      TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-205)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)), Size = Vector3.new(19.168, 400, 19.168)}):Play()
		TweenService:Create(Laser.Head,    TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-400)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()
		TweenService:Create(pp,            TweenInfo.new(2.5), {Transparency = 1, CFrame = cframe * CFrame.new(0,0,-400)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()
		game.Debris:AddItem(Laser,2.5)
		game.Debris:AddItem(pp,2.5)
		local Hitted = false
		local PlayerHitAmount = 0
		local PlayersHitted = {}
		local PlayersHit = {}

		local function ExplosionFunc(ExplodeModel)
			for ChildIndex, Child in pairs(ExplodeModel:GetChildren()) do
				coroutine.wrap(function()
					if Child ~= ExplodeModel.HB then
						Child.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
						TweenService:Create(Child, TweenInfo.new(2), {Orientation = Child.Orientation * Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))}):Play()
						if Child.Name == "Effect" or Child.Name == "Effect2" or Child.Name == "Effect3" or Child.Name == "Effect4" then
							TweenService:Create(Child, TweenInfo.new(.5),   {Size = Child.Size*4}):Play()
						else
							TweenService:Create(Child, TweenInfo.new(.5),   {Size = Child.Size*4}):Play()
						end
						wait(1.5)
						TweenService:Create(Child, TweenInfo.new(0.5), {Transparency = 1}):Play()
					end
				end)()
			end
			local newSettings = {
				Player = List.Character,
				HitboxType = "Sphere",
				Damage = Weapon:GetAttribute("Damage") * 1.25,
				MoveDuration = 2,
			}
			SpatialHitbox.Add(ExplodeModel.HB, newSettings)
		end

		pp.Touched:Connect(function(hitto)
			if not Hitted and not hitto:IsDescendantOf(Character) then
				Hitted = true
				local ExplodeModel = WeaponEffects.PumpkinPistolExplosion:Clone()
				ExplodeModel.Parent = workspace.Debris
				ExplodeModel:SetPrimaryPartCFrame(pp.CFrame)

				ExplosionFunc(ExplodeModel)
			end
		end)
		Laser.HB.Touched:Connect(function(hitto)
			if hitto.Parent:FindFirstChild("Humanoid") and hitto.Parent:FindFirstChild("Humanoid").Health > 0 and hitto.Parent.Name ~= Player.Name and PlayerHitAmount < 2 then
				for i,tableValue in pairs(PlayersHit) do
					if tableValue == hitto.Parent then return end
				end
				table.insert(PlayersHit, hitto.Parent)
				PlayerHitAmount += 1
				local hum = hitto.Parent:FindFirstChildOfClass("Humanoid")
				local HRT = hitto.Parent:FindFirstChild("HumanoidRootPart")
				local ExplodeModel = WeaponEffects.PumpkinPistolExplosion:Clone()
				ExplodeModel.Parent = workspace.Debris
				ExplodeModel:SetPrimaryPartCFrame(HRT.CFrame)

				ExplosionFunc(ExplodeModel)
			end
		end)	
		wait(1.5)
	elseif Type == "CandyCaneGun" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		local CandyCaneGun = Character:FindFirstChild("CandyCaneGun")
		wait(0.5)
		local Clone =  ItemAssetFolder.SnowExplosion:Clone()
		Clone.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180)); Clone.Position = RootPart.Position
		Clone.Anchored = true
		Clone.Parent = workspace.Debris
		TweenService:Create(Clone,TweenInfo.new(1.5),{Transparency = 1, Size = Vector3.new(200,200,200)}):Play()
		local newSettings = {
			Player       = List.Character,
			HitboxType   = "Sphere",
			MoveDuration = 1.5,
			Damage       = Weapon:GetAttribute("Damage") * 1.125,
		}
		if Tier == 2 then newSettings.CanFreeze = true; newSettings.FreezeDuration = 2 end
		SpatialHitbox.Add(Clone, newSettings)

		wait(1.5)
	elseif Type == "EasterStaff" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)
		local colors = {
			Color3.fromRGB(253, 234, 141),
			Color3.fromRGB(204, 255, 204),
			Color3.fromRGB(175, 221, 255),
			Color3.fromRGB(204, 188, 255),
			Color3.fromRGB(255, 255, 204),
			Color3.fromRGB(204, 188, 255),
			Color3.fromRGB(255, 201, 201),
			Color3.fromRGB(204, 255, 204)
		}
		local velocities = {
			Vector3.new(25,25,0),
			Vector3.new(-25,25,0),
			Vector3.new(0,25,25),
			Vector3.new(0,25,-25),
			Vector3.new(25,25,25),
			Vector3.new(-25,25,-25),
			Vector3.new(-25,25,25),
			Vector3.new(25,25,-25)
		}
		wait(0.3)
		for i=1, 8 do 
			coroutine.wrap(function()
				local EasterEgg = ItemAssetFolder.EasterEgg:Clone()
				EasterEgg.Parent = workspace.Debris
				EasterEgg.CFrame = RootPart.CFrame
				EasterEgg.Color = colors[i]
				EasterEgg.Trail.Color = ColorSequence.new(colors[i],colors[i])
				if Tier == 2 then WeaponEffects.EasterStaffPE:Clone().Parent = EasterEgg end

				local BV = Instance.new("BodyVelocity",EasterEgg)
				BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				BV.Velocity = velocities[i]
				game.Debris:AddItem(BV, 0.5)

				local newSettings = {
					GetHitLocation  = true,
					Player          = List.Character,
					Damage          = Weapon:GetAttribute("Damage")*.2,
					Knockback       = false,
					Duration        = 6
				}
				EasterEgg.AncestryChanged:Connect(function(Object, Parent)
					if not Parent then
						local EggExplosion = ItemAssetFolder.EggExplosion:Clone()
						EggExplosion.Parent = workspace.Debris
						EggExplosion.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
						EggExplosion.Position = Object.Position
						EggExplosion.Color = colors[i]
						TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(150,150,150)}):Play()
						if Tier == 2 then
							local PE = WeaponEffects.EasterStaffPE:Clone()
							PE.Speed = NumberRange.new(100,100)
							PE.Size = NumberSequence.new(15,15)
							PE.Parent = EggExplosion
							game.Debris:AddItem(PE, 1)
							coroutine.wrap(function()
								wait(.5)
								PE.Enabled = false
							end)()
						end
						newSettings.HitboxType = "Sphere"
						newSettings.MoveDuration = 1
						newSettings.UseMoveDuration = true

						SpatialHitbox.Add(EggExplosion, newSettings)
					end
				end)
				local ReturnedSettings = RaycastHitbox.Add(EasterEgg, newSettings)
				--print(ReturnedSettings)
				--if typeof(ReturnedSettings.LocationHit) ~= "Vector3" then return end				

				--if DmgMultiplier.Value > 1 then
				--	local PE = WeaponEffects.EasterStaffPE:Clone()
				--	PE.Speed = NumberRange.new(4,5)
				--	PE.Size = NumberSequence.new(1,1)
				--	PE.Parent = HRT
				--	game.Debris:AddItem(PE, 1)
				--	coroutine.wrap(function()
				--		wait(.5)
				--		PE.Enabled = false
				--	end)()
				--end
			end)()
		end
		wait(1.5)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)
	elseif Type == "EasterWand" then
		local Wand = Character:FindFirstChild("EasterWand")

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Wand.Sphere, true)
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		IncAT("Stamina", -StaminaCost)

		local TargetBlock = Instance.new("Part")
		TargetBlock.Parent = workspace.Debris
		TargetBlock.Name = "TargetForEgg"
		TargetBlock.Transparency = 1
		TargetBlock.CanCollide = false
		TargetBlock.Anchored = true
		TargetBlock.Size = Vector3.new(10, 10, 10)
		TargetBlock.CFrame = CFrame.new(direc.p, RootPart.CFrame.p)
		game.Debris:AddItem(TargetBlock, 3)
		wait(.1)
		local SuperEgg = ItemAssetFolder.MagmaEgg:Clone()
		SuperEgg.Parent = workspace.Debris
		SuperEgg.CFrame = CFrame.lookAt(RootPart.Position, direc.Position)
		local Active = true
		local tween = TweenService:Create(SuperEgg, TweenInfo.new((SuperEgg.Position - direc.Position).Magnitude*.2/50, Enum.EasingStyle.Linear), {Position = direc.Position})
		tween:Play()

		coroutine.wrap(function()
			tween.Completed:Wait()
			if Active then
				SuperEgg:Destroy()
				TargetBlock:Destroy()
				local ExplodeModel = ItemAssetFolder.MagmaEggExplosion:Clone()
				ExplodeModel.Parent = workspace.Debris
				ExplodeModel:SetPrimaryPartCFrame(TargetBlock.CFrame)
				TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Size = Vector3.new(270,270,270)}):Play()
				TweenService:Create(ExplodeModel.Union, TweenInfo.new(1), {Transparency = 1}):Play()
				TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Size = Vector3.new(140,140,140)}):Play()
				TweenService:Create(ExplodeModel.cloud, TweenInfo.new(1), {Transparency = 1}):Play()
				game.Debris:AddItem(ExplodeModel,1)
				local MagmaDupe = ItemAssetFolder.WandMagma:Clone()
				MagmaDupe.Parent = workspace.Debris
				MagmaDupe.Magma:SetPrimaryPartCFrame(CFrame.new(direc.p)*CFrame.new(0, 2, 0))
				MagmaDupe.HB.CFrame = MagmaDupe.Magma.Circle.CFrame
				local Exist = true
				coroutine.wrap(function()
					wait(4.5)
					Exist = false
					MagmaDupe:Destroy()
				end)()
				local newSettings = {
					Player           = List.Character,
					HitboxType       = "Box",
					Damage           = Weapon:GetAttribute("Damage")*1.2,
					PerformLingerDoT = true,
					DoTLingerDamage  = .2,
					DoTRateOfHit     = 1/3,
					DoTDuration      = 10,
					MaxDoTHits       = 12,
				}
				SpatialHitbox.Add(MagmaDupe.HB, newSettings)
				-- vvvvvvvvvvvvvvvvvv EFFECTS REMINDER vvvvvvvvvvvvvvvvvv 
				--coroutine.wrap(function()
				--	for i=1,12 do
				--		if hum.Health > 0 then
				--			wait(1/3)
				--			DmgFunction:Fire(Character,hum,EasterWandSettings.Damage1*DataModule.PlayerInformation[play.UserId].Strength)
				--		else
				--			break
				--		end
				--	end
				--end)()

				for DescendantIndex, Descendant in pairs(MagmaDupe.Magma:GetDescendants()) do
					coroutine.wrap(function()
						if Descendant:IsA("ParticleEmitter") then return end
						Descendant.Transparency = 1
						if Descendant:IsA("MeshPart") or Descendant:IsA("Part") then
							Descendant.Size = Vector3.new(Descendant.Size.X/20,Descendant.Size.Y/20,Descendant.Size.Z/20)
							TweenService:Create(Descendant, TweenInfo.new(.25), {Size = Vector3.new(Descendant.Size.X*20, Descendant.Size.Y*20, Descendant.Size.Z*20), Transparency = 0}):Play()
						else
							TweenService:Create(Descendant, TweenInfo.new(.25), {Transparency = 0}):Play()
						end	
						wait(4)
						TweenService:Create(Descendant, TweenInfo.new(.5), {Transparency = 1}):Play()
					end)()
				end

				CombatShortcuts.TrailEffect(MagmaDupe.Magma, true)
				wait(3.8)
				CombatShortcuts.TrailEffect(MagmaDupe.Magma, false)
			end
		end)()
		coroutine.wrap(function()
			wait(3)
			SuperEgg:Destroy()
			Active = false
			tween:Cancel()
		end)()
		wait(.5)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Wand.Sphere, false)
	elseif Type == "EasterGrimoire" then
		Usage:FireClient(Player, true, WeaponSpecialMove)
		List.SupaSwing = true

		IncAT("Stamina", -StaminaCost)
		local PlayersHealed = {}
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		wait(.3)
		local HealCircle = ItemAssetFolder.GrimoireHealCircle:Clone()
		HealCircle.Parent = workspace.Debris
		HealCircle.Hold.Part1 = RootPart
		HealCircle.Hold.C0 = HealCircle.Hold.C0*CFrame.new(0,-.5,0)
		HealCircle.HealEffect.GreenParticles.Enabled = true
		local TweenProperty = {
			TI = TweenInfo.new(.4, Enum.EasingStyle.Linear),
			PosVal = {20.133, -17.449, 20.133, -17.449},
			WidthVal = {40, 34, 40, 34}
		}
		for i=1,4 do
			TweenService:Create(HealCircle.HealEffect["Attachment" .. i .. "a"], TweenProperty.TI, {Position = Vector3.new(0, 0, TweenProperty.PosVal[i])}):Play()
			TweenService:Create(HealCircle.HealEffect["Attachment" .. i .. "b"], TweenProperty.TI, {Position = Vector3.new(0, 0, TweenProperty.PosVal[i]*-1)}):Play()
			TweenService:Create(HealCircle.HealEffect["GroundEffect" .. i], TweenProperty.TI, {Width0 = TweenProperty.WidthVal[i], Width1 = TweenProperty.WidthVal[i]}):Play()
			coroutine.wrap(function()
				local v1 = i
				wait(.4)
				HealCircle.HealEffect["HealBeam" .. v1].Enabled = true
			end)()
		end
		local Existing = true
		if Humanoid.MaxHealth > Humanoid.Health then
			coroutine.wrap(function()
				for i=1,10 do

					Humanoid.Health += Humanoid.MaxHealth*EasterGrimoireSettings.HealingPower
					if Humanoid.Health >= Humanoid.MaxHealth then
						Humanoid.Health = Humanoid.MaxHealth
						break
					end
					wait(.1)
				end
			end)()
			local HealedEffect = HealCircle.Healed:Clone()
			HealedEffect.Parent = RootPart
			HealedEffect.Enabled = true
			coroutine.wrap(function()
				wait(1)
				HealedEffect.Enabled = false
				wait(.5)
				HealedEffect:Destroy()
			end)()
		end
		local GrimoireSound = HealCircle.GrimoireStart
		GrimoireSound.Parent = RootPart
		GrimoireSound:Play()
		game.Debris:AddItem(GrimoireSound, GrimoireSound.TimeLength)
		coroutine.wrap(function()
			local connection, results
			connection = HealCircle.HB.Touched:Connect(function() end)
			while Existing and HealCircle:FindFirstChild("HB") do
				results = HealCircle.HB:GetTouchingParts()
				for i=1,#results do
					if results[i].Parent:FindFirstChildOfClass("Humanoid") and game.Players:GetPlayerFromCharacter(results[i].Parent) and PlayersHealed[results[i].Parent] == nil and results[i].Parent.Humanoid.MaxHealth > results[i].Parent.Humanoid.Health and not results[i]:IsDescendantOf(Character) then
						PlayersHealed[results[i].Parent] = true
						local hum = results[i].Parent.Humanoid
						local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
						coroutine.wrap(function()
							for i=1,10 do
								hum.Health += hum.MaxHealth*EasterGrimoireSettings.HealingPower
								if hum.Health >= hum.MaxHealth then
									hum.Health = hum.MaxHealth
									break
								end
								wait(.1)
							end
						end)()
						local HealedEffect = HealCircle.Healed:Clone()
						HealedEffect.Parent = HRT
						HealedEffect.Enabled = true
						coroutine.wrap(function()
							wait(1)
							HealedEffect.Enabled = false
							wait(.5)
							HealedEffect:Destroy()
						end)()
						local HealSound = HealCircle.HealedSound:Clone()
						HealSound.Parent = HRT
						HealSound:Play()
						game.Debris:AddItem(HealSound, HealSound.TimeLength)
					end
				end
				wait(.2)
			end
			connection:Disconnect()
		end)()
		game.Debris:AddItem(HealCircle, 5)
		wait(3.8)
		if HealCircle:FindFirstChild("HealEffect") then 
			HealCircle.HealEffect.GreenParticles.Enabled = false
		end
		wait(.7)
		for i=1,4 do
			TweenService:Create(HealCircle.HealEffect["Attachment" .. i .. "a"], TweenProperty.TI, {Position = Vector3.new(0, 0, 0)}):Play()
			TweenService:Create(HealCircle.HealEffect["Attachment" .. i .. "b"], TweenProperty.TI, {Position = Vector3.new(0, 0, 0)}):Play()
			TweenService:Create(HealCircle.HealEffect["GroundEffect" .. i], TweenProperty.TI, {Width0 = 0, Width1 = 0}):Play()
			HealCircle.HealEffect["HealBeam" .. i].Enabled = false
		end
		wait(.4)
		Existing = false
	elseif Type == "EasterKatana" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown  = true
		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)

		local Sword = Character:FindFirstChild("EasterKatana")
		local Sword2 = Character:FindFirstChild("EasterKatana")

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)

		local colors = {
			Color3.fromRGB(253, 234, 141),
			Color3.fromRGB(204, 255, 204),
			Color3.fromRGB(175, 221, 255),
			Color3.fromRGB(204, 188, 255),
			Color3.fromRGB(255, 255, 204),
			Color3.fromRGB(204, 188, 255),
			Color3.fromRGB(255, 201, 201),
			Color3.fromRGB(204, 255, 204)
		}

		for i=1, 8 do wait(.2)
			local amt = 1; if Tier == 2 then amt = 2 end
			for ii=1, amt do
				coroutine.wrap(function()
					local Clone         = WeaponEffects.EasterSliceEffect:Clone()
					Clone.Slash2.Color  = colors[i]
					Clone.Slash.Color   = colors[i]
					Clone.Slash.Trail1.Color    = ColorSequence.new(colors[i],colors[i])
					Clone.Slash.Trail2.Color    = ColorSequence.new(colors[i],colors[i])
					Clone.Slash.Trail3.Color    = ColorSequence.new(colors[i],colors[i])
					Clone.Slash.Particle.Color  = ColorSequence.new(colors[i],colors[i])
					Clone.Slash.Particle2.Color = ColorSequence.new(colors[i],colors[i])
					Clone:SetPrimaryPartCFrame(RootPart.CFrame*CFrame.new(0,15,10)*CFrame.Angles(math.rad(180), 0, math.rad(90)*math.rad(math.random(-120,120))))
					Clone.Parent                = workspace.Debris
					game.Debris:AddItem(Clone, 1.5)

					local BV    = Instance.new("BodyVelocity", Clone.HB)
					BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					BV.Velocity = RootPart.CFrame.lookVector * 300

					if ii == 1 then
						local newSettings = {
							["Player"]             = List.Character,
							["HitboxType"]         = "Touched",
							["MoveDuration"]       = 1.5,
							["Parent"]             = Clone,
							["Damage"]             = Weapon:GetAttribute("Damage")*.2,
						}
						SpatialHitbox.Add(Clone.HB, newSettings)
					end

					coroutine.wrap(function()
						wait(.5)
						coroutine.wrap(CombatShortcuts.TrailEffect)(Clone.Slash, false)
						wait(.5)
						coroutine.wrap(CombatShortcuts.TrailEffect)(Clone.Slash, false)

						TweenService:Create(Clone.Slash2,TweenInfo.new(.5),{Transparency = 1}):Play()
						TweenService:Create(Clone.Slash, TweenInfo.new(.5),{Transparency = 1}):Play()
					end)()
				end)()
			end
		end
		wait(1.5)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)
	elseif Type == "JesterSpear" and List.Character.WObj.Value.Name == "JesterSpear" then		
		if (List.Character.HumanoidRootPart.Position - direc.p).Magnitude > 500 then
			List.Character:SetAttribute("Attacking", false)
			return end
		IncAT("Stamina", -StaminaCost)
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		local SpeedMultiplier = 1.5

		local JesterSpear = Character.WObj.Value
		local OriginalRotation = JesterSpear.Main.Weld.C0

		local TraTab = {}
		local Containings = JesterSpear:GetChildren()

		local HS = JesterSpear:Clone()
		HS.Main.Weld.Part1 = Character.RightHand
		HS.Parent = workspace.Debris

		for i=1,#Containings do
			table.insert(TraTab, Containings[i].Transparency)
			Containings[i].Transparency = 1
		end

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, SpeedMultiplier, "Special")

		local TweenTable = {
			Tween = nil,
			TweenItem = HS.Main.Weld,
			RotationPerCount = CFrame.Angles(0, math.rad(120), 0),
			Count = 12,
			FullDelay = .7/SpeedMultiplier
		}

		StartLiveMouseTracking(play, direc.p, TweenTable.FullDelay, 500)

		for i=1,TweenTable.Count do
			TweenTable.Tween = TweenService:Create(TweenTable.TweenItem, TweenInfo.new(TweenTable.FullDelay/TweenTable.Count), {C0 = TweenTable.TweenItem.C0*TweenTable.RotationPerCount})
			TweenTable.Tween:Play() TweenTable.Tween.Completed:Wait()
		end

		HS.Main.Weld:Destroy()
		HS.Main.CFrame = CFrame.new(RootPart.Position, UsersConnection[Player.UserId].Position)*CFrame.Angles(math.rad(-90), 0, 0)

		local RayParam = RaycastParams.new()
		RayParam.FilterType = Enum.RaycastFilterType.Blacklist
		RayParam.FilterDescendantsInstances = {List.Character, HS}

		local CastRay = workspace:Raycast(HS.Main.Position, HS.Main.CFrame.upVector*10000, RayParam)

		local HitLocation
		HS.Tip.Anchored = true
		if CastRay then
			HitLocation = CastRay.Position
		else
			HitLocation = UsersConnection[Player.UserId].Position
		end
		local Distance = (List.Character.HumanoidRootPart.Position - HitLocation).Magnitude

		local L = Instance.new("Part")
		L.Size = Vector3.new(1, 1, Distance)
		L.Color = Color3.fromRGB(255, 0, 0)
		L.Anchored = true
		L.CanCollide = false
		L.Material = "Neon"
		L.Parent = workspace.Debris

		L.CFrame = CFrame.new(List.Character.HumanoidRootPart.Position, HS.Tip.Position)*CFrame.new(0, 0, -Distance/2)

		local Speed = 400
		local Threw = TweenService:Create(HS.Tip, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Position = HitLocation})
		Threw:Play()
		TweenService:Create(L, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Transparency = 1, Size = Vector3.new(.01, .01, Distance)}):Play()
		task.wait((Distance/Speed)/1.1)

		game.Debris:AddItem(L, 0.2)
		coroutine.wrap(function()

			local ExplosionModel = ItemAssetFolder.SpearExplosion:Clone()
			ExplosionModel.Parent = workspace.Debris
			ExplosionModel:SetPrimaryPartCFrame(CFrame.new(HS.Tip.Position)*CFrame.new(0, 1, 0))

			SpatialHitbox.Add(ExplosionModel.HB, {
				Player = List.Character,
				MoveDuration = 1.25,
				Parent = ExplosionModel,
				Damage = Weapon:GetAttribute("Damage")*1.25,
				HitboxType = "Sphere",
				KnockbackType = "From_Impact",
				KnockbakcDuration = .5,
				KnockbackPower = 150,
			})

			TweenService:Create(ExplosionModel.Mesh, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Transparency = 0}):Play()			

			local ExplosionTT = {
				Tween = nil,
				TweenItem1 = ExplosionModel.Mesh.Mesh,
				TweenItem2 = ExplosionModel.HB,
				TweenTable1 = Vector3.new(2, 2, 2)*25,
				TweenTable2 = Vector3.new(5, 5, 5)*25,
				PositionOffset = ExplosionModel.Mesh.Mesh.Scale.X*50/10,
				Count = 6,
				FullDelay = .5
			}

			local RotationTable = {
				Tween = nil,
				TweenItem1 = ExplosionModel.HB.Motor6D,
				RotationPerCount = 179,
				Count = 24,
				FullDelay = 1.5
			}

			for i=1,ExplosionTT.Count do
				ExplosionTT.Tween = TweenService:Create(ExplosionTT.TweenItem1, TweenInfo.new(ExplosionTT.FullDelay/ExplosionTT.Count), {Scale = ExplosionTT.TweenItem1.Scale+(ExplosionTT.TweenTable1/ExplosionTT.Count)})
				TweenService:Create(ExplosionTT.TweenItem2, TweenInfo.new(ExplosionTT.FullDelay/ExplosionTT.Count), {Size = ExplosionTT.TweenItem2.Size+(ExplosionTT.TweenTable2/ExplosionTT.Count), CFrame = ExplosionTT.TweenItem2.CFrame*CFrame.new(0, ExplosionTT.PositionOffset/ExplosionTT.Count, 0) * CFrame.Angles(0,math.rad(60), 0)}):Play()
				ExplosionTT.Tween:Play() ExplosionTT.Tween.Completed:Wait()
			end
			TweenService:Create(ExplosionTT.TweenItem1, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Scale = ExplosionTT.TweenItem1.Scale+Vector3.new(10,10,10)})
			TweenService:Create(ExplosionTT.TweenItem2, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = ExplosionTT.TweenItem2.Size+Vector3.new(10,10,10), CFrame = ExplosionTT.TweenItem2.CFrame * CFrame.Angles(0,math.rad(50), 0)}):Play()
			TweenService:Create(ExplosionModel.Mesh, TweenInfo.new(.25, Enum.EasingStyle.Linear), {Transparency = 1}):Play()
		end)()
		task.wait(.5)
		Distance = (List.Character.HumanoidRootPart.Position - HitLocation).Magnitude
		Threw = TweenService:Create(HS.Tip, TweenInfo.new(Distance/(Speed*3), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = List.Character.HumanoidRootPart.Position})
		Threw:Play()
		Debris:AddItem(HS, Distance/(Speed*3))
		for i=1,#Containings do
			TweenService:Create(Containings[i], TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 1, false, Distance/(Speed*3.5)), {Transparency = TraTab[i]}):Play()
		end
		task.wait(.25)
	elseif Type == "JesterScythe" and List.Character.WObj.Value.Name == "JesterScythe" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		local JesterScythe = Character.WObj.Value

		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")

		task.wait(.25)

		local SpikesModel = ItemAssetFolder.JesterScytheSpikes:Clone()
		SpikesModel.Parent = workspace.Debris
		SpikesModel:SetPrimaryPartCFrame(List.Character.HumanoidRootPart.CFrame*CFrame.new(0, 4.7, -25))

		SpatialHitbox.Add(SpikesModel.HB, {
			Player = List.Character,
			MoveDuration = 3.375,
			HitboxType = "Box",

			Damage = JesterScythe:GetAttribute("Damage")*1.2,

			KnockbackType = "From_Impact",
			KnockbakcDuration = .75,
			KnockbackForce = 150,
			Parent = SpikesModel,
		})

		local Spikes = {SpikesModel.SpikeM1, SpikesModel.SpikeM2, SpikesModel.SpikeM3}
		local DownSet = {-50,-75,-100}
		local RubbleMultiplier = {1, 1.5, 2}

		for i=1,#Spikes do
			Spikes[i].CFrame *= CFrame.new(0, DownSet[i], 0)
		end

		local RaycastParam = RaycastParams.new()
		RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
		RaycastParam.FilterDescendantsInstances = {List.Character, workspace.NPCs, workspace.Debris}

		local GroundCast = workspace:Raycast(List.Character.HumanoidRootPart.Position, Vector3.new(0, -10000, 0), RaycastParam)
		local RayColor, RayMaterial

		if GroundCast then
			RayColor = GroundCast.Instance.Color
			RayMaterial = GroundCast.Material
		end

		local RubbleFolder = Instance.new("Folder")
		RubbleFolder.Name = "RubbleFolder_" .. List.Character.Name
		RubbleFolder.Parent = workspace.Debris
		game.Debris:AddItem(RubbleFolder, 3)

		task.spawn(function()
			for i=1,#Spikes do
				local SpikeCFrame = Spikes[i].CFrame*CFrame.new(0, -DownSet[i], 0)
				local Tween = TweenService:Create(Spikes[i], TweenInfo.new(.15, Enum.EasingStyle.Linear), {CFrame = Spikes[i].CFrame*CFrame.new(0, -DownSet[i], 0)})
				Tween:Play()

				task.wait(.05)
				if GroundCast then
					for v=1,math.random(6, 9) do
						coroutine.wrap(function()
							local RubbleSize = (math.random(400, 750)*RubbleMultiplier[i])/100

							local Rubble = ItemAssetFolder.Rubble:Clone()
							Rubble.Name = "Rubble_" .. List.Character.Name
							Rubble.CFrame = SpikeCFrame
							Rubble.Size = Vector3.new(RubbleSize, RubbleSize, RubbleSize)

							Rubble.Material = RayMaterial
							Rubble.Color = RayColor

							--PhysicService:SetPartCollisionGroup(Rubble, "Rubble")
							Rubble.CanCollide = false
							Rubble.Parent = RubbleFolder

							local BV = Instance.new("BodyVelocity")
							BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							BV.Velocity = Vector3.new(math.random(-750, 750)/10, (math.random(650, 750)*RubbleMultiplier[i])/10, math.random(-750, 750)/10)
							BV.Parent = Rubble
							game.Debris:AddItem(BV, .1)

							--coroutine.wrap(function()
							--	wait(2)
							--	Rubble.Material = "Neon"
							--	Rubble.Trail.Enabled = false
							--	local tween = TweenService:Create(Rubble, TweenInfo.new(.5, Enum.EasingStyle.Linear), {Size = Vector3.new(0.001, 0.001, 0.001), Color = Color3.fromRGB(255, 150, 0)})
							--	tween:Play() tween.Completed:Wait()
							--	Rubble:Destroy()
							--end)()
						end)()
					end
				end
			end
		end)

		task.spawn(function()
			task.wait(1.5)
			for i=1,#Spikes do
				TweenService:Create(Spikes[i], TweenInfo.new(.5, Enum.EasingStyle.Linear), {Transparency = 1}):Play()
			end
			task.wait(1)
			game.Debris:AddItem(SpikesModel, 0)
		end)

		task.wait(1.5)

	elseif Type == "PoisonousSummoner" and List.Character.WObj.Value.Name == "PoisonousSummoner" then

		List.SupaSwing = true
		List.Cooldown = true

		local InfoTable = {
			["Blade"] = {
				Color = Color3.fromRGB(30, 255, 105),
				Material = "Neon" 
			},
			["Handle"] = {
				Color = Color3.fromRGB(0, 0, 0),
				Material = "Neon" 
			}
		}

		local PS = List.Character.WObj.Value
		local PS_Blade = PS.Blade

		for indexG, itemG in pairs(InfoTable) do
			for index, item in pairs(itemG) do
				local Save = PS[indexG][index]
				PS[indexG][index] = item
				InfoTable[indexG][index] = Save
			end
		end

		--	local BladeAttachment = WeaponEffects.PoisonBladeAttachmentHolder.PoisonBlade:Clone()
		--	BladeAttachment.Parent = PS_Blade
		--	game.Debris:AddItem(BladeAttachment, .4)
		--	local BladeEffects = BladeAttachment:GetChildren()

		PS_Blade.PoisonSound:Play()
		--	for i=1,#BladeEffects do
		--		BladeEffects[i].Enabled = true
		--	end

		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)

		task.wait(.4)

		for indexG, itemG in pairs(InfoTable) do
			for index, item in pairs(itemG) do
				PS[indexG][index] = item
			end
		end

		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)
		PS_Blade.PoisonSound:Stop()

		local PoisonHB = WeaponEffects.PoisonousCloud:Clone()
		PoisonHB.Parent = workspace.Debris
		PoisonHB.CFrame = List.Character.HumanoidRootPart.CFrame

		local Effects = PoisonHB:GetChildren()
		for i=1,#Effects do
			if Effects[i]:IsA("ParticleEmitter") then
				Effects[i].Enabled = true
			end
		end

		PoisonHB.PoisonSound:Play()
		TweenService:Create(PoisonHB, TweenInfo.new(.25, Enum.EasingStyle.Linear), {Size = PoisonHB.Size*10}):Play()

		SpatialHitbox.Add(PoisonHB, {
			Player = Character,
			MoveDuration = 7.5,
			HitboxType = "Box",

			Damage = .1,
			UseDoTForNormal = true,
			DoTRateOfHit = .2,
			NormalDoTDamage = 1,

			VelocityType = "Light",
			DestroyHitbox = false
		})

		game.Debris:AddItem(PoisonHB, 10)
		coroutine.wrap(function()
			task.wait(7.5)
			PoisonHB.PoisonSound:Stop()
			for i=1,#Effects do
				if Effects[i]:IsA("ParticleEmitter") then
					Effects[i].Enabled = false
				end
			end
		end)()

		task.wait(1)

	elseif Type == "DarkBlossoms" and List.Character.WObj.Value.Name == "DarkBlossoms" then
		local newDistance = (List.Character.HumanoidRootPart.Position - direc.p).Magnitude
		if newDistance > 200 then
			List.Character:SetAttribute("Attacking", false)
			return end

		List.SupaSwing = true
		List.Cooldown = true

		local FlowerBooms = List.Character.WObj.Value
		local LeftBlade = FlowerBooms.LeftBlade
		local RightBlade = FlowerBooms.RightBlade

		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)

		LeftBlade.Material  = Enum.Material.Neon 
		RightBlade.Material = Enum.Material.Neon
		TweenService:Create(LeftBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(170, 0, 255)}):Play()
		TweenService:Create(RightBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(170, 0, 255)}):Play()

		StartLiveMouseTracking(play, direc.p, .2, 200)
		task.wait(.2)

		PlaySound(RootPart, Sounds.DaggerSkill)

		local MousePosition = UsersConnection[Player.UserId].Position
		newDistance = (List.Character.HumanoidRootPart.Position - MousePosition).Magnitude

		local FlowerBoomAssets = WeaponEffects.FlowerBoomsSuperAssets

		local UpDashEf = UniversalAssetFolder.UpDashEffect:Clone()
		UpDashEf.Parent = workspace.Debris
		UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		UpDashEf.Parent = workspace.Debris
		UpDashEf.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		game.Debris:AddItem(UpDashEf,0.5)
		TweenService:Create(UpDashEf, TweenInfo.new(0.5),{Size = Vector3.new(25,0.05,25)}):Play()
		TweenService:Create(UpDashEf.Decal, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(UpDashEf.Decal1, TweenInfo.new(0.5),{Transparency = 1}):Play()

		local DashHitbox = FlowerBoomAssets.Hitbox:Clone()
		game.Debris:AddItem(DashHitbox, 0.1)

		DashHitbox.Parent = workspace.Debris
		local DashSizeZ = newDistance
		DashHitbox.CFrame = CFrame.new(Character.HumanoidRootPart.Position, MousePosition)*CFrame.new(0, 0, -newDistance/2)

		DashHitbox.Size = Vector3.new(DashHitbox.Size.X, DashHitbox.Size.Y, DashSizeZ)
		DashHitbox.Anchored = true

		local Params = OverlapParams.new()
		Params.FilterType = Enum.RaycastFilterType.Blacklist
		Params.FilterDescendantsInstances = {List.Character, workspace.Debris}

		local HitParts = workspace:GetPartsInPart(DashHitbox, Params)
		local HitCharacters = {}

		for i=1,#HitParts do

			if HitParts[i].Parent:FindFirstChild("Humanoid") and HitParts[i].Parent.Humanoid.Health > 0 and not HitCharacters[HitParts[i].Parent] then
				HitCharacters[HitParts[i].Parent] = true
				local HUM = HitParts[i].Parent.Humanoid
				local HRT = HitParts[i].Parent.HumanoidRootPart
				local SizeMultiplier = 30
				local Explosion = FlowerBoomAssets.FlowerBoomsSuperExplosion:Clone()
				local ExplosionParts = Explosion:GetChildren()
				Explosion.Parent = workspace.Debris
				Explosion:SetPrimaryPartCFrame(HRT.CFrame)
				game.Debris:AddItem(Explosion, .75)
				for i=1,#ExplosionParts do
					TweenService:Create(ExplosionParts[i], TweenInfo.new(.75), {Size = ExplosionParts[i].Size*SizeMultiplier}):Play()
				end
				PlaySound(HRT, FlowerBoomAssets.FlowerBoomsSuperHit)
				coroutine.wrap(function()
					task.wait(.5)
					for i=1,#ExplosionParts do
						TweenService:Create(ExplosionParts[i], TweenInfo.new(.25, Enum.EasingStyle.Linear), {Transparency = 1}):Play()
					end
				end)()

				DmgFunction:Fire(List.Character, HUM, FlowerBooms:GetAttribute("Damage")*1.2)
				Information.Knockback({
					HitCharacter = HRT.Parent,
					Stunner = Character,
					StunType = "Light"
				})

			end

		end

		local ParticleBox1 = FlowerBoomAssets.BeamPart:Clone()
		game.Debris:AddItem(ParticleBox1, 0.1)
		ParticleBox1.Parent = workspace.Debris
		ParticleBox1.CFrame = Character.HumanoidRootPart.CFrame
		ParticleBox1.Anchored = true
		local TweenPart = FlowerBoomAssets.EffectPart:Clone()
		TweenPart.Parent = script
		TweenPart.CFrame = Character.HumanoidRootPart.CFrame
		TweenPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position, MousePosition)
		RootPart.CFrame = CFrame.new(RootPart.Position, Vector3.new(MousePosition.X, RootPart.Position.Y, MousePosition.Z))
		RootPart.CFrame = CFrame.new(MousePosition.X, MousePosition.Y+5, MousePosition.Z)

		coroutine.wrap(function()
			TweenService:Create(TweenPart, TweenInfo.new(0.25), {Position = MousePosition}):Play()
			task.wait(0.45)
			TweenPart:Destroy()
			TweenService:Create(LeftBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(255, 152, 220)}):Play()
			TweenService:Create(RightBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(255, 152, 220)}):Play()
			task.wait(.1)
			LeftBlade.Material = Enum.Material.Metal RightBlade.Material = Enum.Material.Metal
			coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)
		end)()

		local ParticleBox2 = FlowerBoomAssets.BeamPart:Clone()
		game.Debris:AddItem(ParticleBox2, 0.1)
		ParticleBox2.Parent = workspace.Debris
		ParticleBox2.CFrame = Character.HumanoidRootPart.CFrame
		ParticleBox2.Anchored = true
		local Beam = FlowerBoomAssets.Beam:Clone()
		Beam.Parent = ParticleBox1
		Beam.Attachment0 = ParticleBox1.Attachment
		Beam.Attachment1 = ParticleBox2.Attachment

	elseif Type == "PeppermintEdge" and List.Character.WObj.Value.Name == "PeppermintEdge" then

		List.SupaSwing = true
		List.Character:SetAttribute("Enraged", true)
		List.Character:SetAttribute("Attacking", false)

		local PeppermintEdge = Character.WObj.Value
		IncAT("Stamina", -StaminaCost)

		for v,p in pairs(Character:GetChildren()) do
			if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
				local S = p:Clone()
				for i,e in pairs(S:GetDescendants()) do
					if not e:IsA("SpecialMesh") then
						e:Destroy()
					end
				end
				S.CastShadow = false
				S.Parent = PeppermintEdge
				S.Material = Enum.Material.Neon
				S.Transparency = 0
				S.Color = Color3.fromRGB(255, 0, 127)
				S.CanCollide = false
				S.Massless = true
				S.Size += Vector3.new(.1, .1, .1)
				local Weld = Instance.new("Weld")
				Weld.Parent = S
				Weld.Part0 = S
				Weld.Part1 = p
				game.Debris:AddItem(S, .2)
				TweenService:Create(S, TweenInfo.new(.2, Enum.EasingStyle.Linear), {Transparency = 1, Size = S.Size*1.5}):Play()

			end
		end

		local ParticleAssets = {}

		local PlayerParts = List.Character:GetChildren()
		for i=1,#PlayerParts do
			if PlayerParts[i]:IsA("BasePart") and PlayerParts[i].Name ~= "Head" and PlayerParts[i].Name ~= "HumanoidRootPart" then
				local p1 = WeaponEffects.EnragedParticle1:Clone()
				p1.Parent = PlayerParts[i]
				local p2 = WeaponEffects.EnragedParticle2:Clone()
				p2.Parent = PlayerParts[i]
				table.insert(ParticleAssets, p1)
				table.insert(ParticleAssets, p2)
			end
		end

		local Light = WeaponEffects.EnragedLight:Clone()
		Light.Parent = List.Character.HumanoidRootPart
		table.insert(ParticleAssets, Light)

		local Amount = 0
		repeat
			Amount += game:GetService("RunService").Heartbeat:Wait()
		until Amount > 15 or List.Character.WObj.Value.Name ~= "PeppermintEdge"

		List.Character:SetAttribute("Enraged", false)
		for i=1,#ParticleAssets do
			game.Debris:AddItem(ParticleAssets[i], 0)
		end

	elseif Type == "ClockworkBlade" and List.Character.WObj.Value.Name == "ClockworkBlade" then


		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true

		local ClockworkBlade = Character.WObj.Value

		ClockworkBlade.GoldSide.Material = "Neon"
		ClockworkBlade.BlackSide.Material = "Neon"
		ClockworkBlade.GoldSide.Transparency = .7
		ClockworkBlade.BlackSide.Transparency = .7

		local CurrentTween, NewTween
		CurrentTween = TweenService:Create(ClockworkBlade.GoldSide, TweenInfo.new(.15, Enum.EasingStyle.Linear), {Transparency = 0})
		TweenService:Create(ClockworkBlade.BlackSide, TweenInfo.new(.15, Enum.EasingStyle.Linear), {Transparency = 0}):Play()

		ClockworkBlade.BlackSide.Color = Color3.fromRGB(255, 100, 0)

		CurrentTween:Play()
		CurrentTween.Completed:Wait()

		ClockworkBlade.Combined.Enabled = false
		ClockworkBlade.BlackSide.DW_Weld.Part1 = List.Character.LeftHand
		ClockworkBlade.BlackSide.DW_Weld.Enabled = true

		ClockworkBlade.HB.Size = Vector3.new(8, 8, 8)
		ClockworkBlade.HB.Weld.C0 = ClockworkBlade.HB.Weld.C0*CFrame.new(0, 0, -3.35)

		ClockworkBlade:SetAttribute("Dual_Mode", true)
		List.Character:SetAttribute("Attacking", false)
		List.Cooldown = false

		wait(7.5)

		if ClockworkBlade.Parent ~= nil then

			ClockworkBlade:SetAttribute("Dual_Mode", false)
			CurrentTween = TweenService:Create(ClockworkBlade.BlackSide, TweenInfo.new(.15, Enum.EasingStyle.Linear), {Transparency = .7})
			NewTween = TweenService:Create(ClockworkBlade.GoldSide, TweenInfo.new(.15, Enum.EasingStyle.Linear), {Transparency = .7})

			CurrentTween:Play()
			NewTween:Play()

			coroutine.wrap(function()

				CurrentTween.Completed:Wait()
				if NewTween then
					NewTween:Cancel()
				end

				ClockworkBlade.GoldSide.Transparency = 0
				ClockworkBlade.BlackSide.Transparency = 0
				ClockworkBlade.BlackSide.Color = Color3.fromRGB(0, 0, 0)

				ClockworkBlade.GoldSide.Material = "Metal"
				ClockworkBlade.BlackSide.Material = "Metal"

				ClockworkBlade:SetAttribute("Dual_Mode", false)
				ClockworkBlade.BlackSide.DW_Weld.Part1 = nil
				ClockworkBlade.BlackSide.DW_Weld.Enabled = false
				ClockworkBlade.Combined.Enabled = true

				ClockworkBlade.HB.Size = Vector3.new(8, 8, 14)
				ClockworkBlade.HB.Weld.C0 = ClockworkBlade.HB.Weld.C0*CFrame.new(0, 0, 3.35)

			end)()
			List.Cooldown = false
			wait(.25 + Weapon:GetAttribute("Cooldown") or 1)
			List.Cooldown = true

		end

	elseif Type == "BanHammer" then
		List.Character:SetAttribute("Attacking", true)
		List.SupaSwing = true
		List.Cooldown = true
		Usage:FireClient(Player, true, WeaponSpecialMove)
		IncAT("Stamina", -StaminaCost)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, nil, "Special")
		wait(0.8)
		local Clone =  ItemAssetFolder.Shockwave2:Clone()
		Clone.Size = Vector3.new(10,2,10)
		Clone.CFrame = RootPart.CFrame
		Clone.Parent = workspace.Debris
		TweenService:Create(Clone,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(150,30,150)}):Play()

		local newSettings = {
			["HitboxType"]   = "InPart",
			["Player"]       = List.Character,
			["MoveDuration"] = 1,
		}
		SpatialHitbox.Add(Clone, newSettings)		
		wait(1.5)
	else
		List.Cooldown  = false
		List.SupaSwing = false
		List.Character:SetAttribute("Attacking", false)
		return
	end
	local CD = WeaponData[Weapon.Name] and WeaponData[Weapon.Name][Tier] and WeaponData[Weapon.Name][Tier]["Special Cooldown"] or 3

	if not CD then
		warn("Error Occured: Cooldown for " .. Weapon.Name .. " does not exist in table.", WeaponData)
	end

	List.Character:SetAttribute("Attacking", false)
	List.Cooldown = false
	Usage:FireClient(Player, false, WeaponSpecialMove)
	CooldownEvent:FireClient(Player, CD, WeaponSpecialMove)
	wait(CD)
	List.SupaSwing = false
end)

--=================================== [WEAPON LEFT MOUSE BUTTON EVENTS] ===================================--
local WeaponSounds = {
	["Katana"] = Sounds.KatanaSwing,
	["Dagger"] = Sounds.DaggerSwing,
}

local WeaponTypes = {
	"Katana",
	"Dagger",
	"SnowSword",
	"EasterKatana",
	"EasterKatana",
	"GhastSword",
	"IceSickle",
	"PeppermintSaber",
	"HalloweenScythe",
	"JesterScythe",
	"JesterSpear",
	"ClockworkBlade",
	"EasterSword",
	"BanHammer",
	"DarkBlossoms",
	"PeppermintEdge",
	"PoisonousSummoner"
}

Swing.OnServerEvent:Connect(function(play, direction)
	local List = DataModule.PlayerInformation[play.UserId]
	if not List then return end
	local Character = List.Character or play.Character
	local Type      = Character:GetAttribute("Weapon_Type")
	local Weapon    = List.WeaponObject and List.WeaponObject.Value or Type ~= "N/A" and Character:WaitForChild(Type)
	local Tier      = Weapon and Weapon:GetAttribute("Tier") or 1
	local RootPart  = List.RootPart or Character.PrimaryPart
	List.RootPart   = List.RootPart or Character.PrimaryPart
	local Humanoid  = Character.Humanoid
	local Player    = play
	local WeaponCooldown

	if Character:GetAttribute("Attacking") or List.Cooldown or List.SwordAttack or RootPart and RootPart:FindFirstChild("Heavy") or not Weapon then return end
	if Weapon:GetAttribute("Cooldown") then
		WeaponCooldown = Weapon:GetAttribute("Cooldown")
	end

	if Type == "OrnamentBlaster" then
		Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)
		Humanoid.AutoRotate = false

		local randomcolors = {
			Color3.fromRGB(51, 88, 130),
			Color3.fromRGB(170, 0, 0),
			Color3.fromRGB(255, 85, 0),
			Color3.fromRGB(0, 85, 0),
			Color3.fromRGB(170, 0, 127),
			Color3.fromRGB(255, 85, 127)
		}

		local choose = math.random(1,6)

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector
		local cframe = Orientation

		local bulletmodel = WeaponEffects.OrnamentBlasterBullet:Clone()
		bulletmodel.Sphere.Color = randomcolors[choose]

		local bullet = bulletmodel.HB
		bullet.Trail.Color = ColorSequence.new(randomcolors[choose],randomcolors[choose])
		bulletmodel.Parent = workspace.Debris
		bullet.CFrame = Orientation

		local ring = UniversalAssetFolder.RING:Clone()
		ring.Parent  = workspace.Debris
		ring.CFrame = RootPart.CFrame
		ring.Color = randomcolors[choose]

		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*200
		bullet.Anchored = false

		task.spawn(function()
			local newSettings = {
				["MoveDuration"]       = 2,
				["KnockbackPower"]     = 50,
				["KnockbackDuration"]  = .1,
				["Player"]             = List.Character,
				["Damage"]             = Weapon:GetAttribute("Damage"),
				["GetHitLocation"]     = true,
				["Parent"]             = bullet.Parent,
			}
			local ReturnedSettings = RaycastHitbox.Add(bullet, newSettings);
			if typeof(ReturnedSettings.LocationHit) ~= "Vector3" then return end
			if bullet then bullet.Anchored = true; bullet.Position = ReturnedSettings.LocationHit end -- Makes it look neat when it hits something, rather than it just zooming off

			local ExplodeModel = WeaponEffects.RayGunImpact:Clone()
			ExplodeModel.Parent = workspace.Debris
			ExplodeModel:SetPrimaryPartCFrame(CFrame.new(ReturnedSettings.LocationHit))
			ExplodeModel.Base.Attachment.sparkle.Size    = NumberSequence.new(60)
			ExplodeModel.Base.Attachment.ray.Size        = NumberSequence.new(70)
			ExplodeModel.Base.Attachment.candycane.Speed = NumberRange.new(50)
			ExplodeModel.Base.Attachment.ornament.Speed  = NumberRange.new(50)
			ExplodeModel.Base.Attachment.ornament2.Speed = NumberRange.new(50)

			for ChildIndex, Child in pairs(ExplodeModel:GetChildren()) do
				task.spawn(function()
					if Child ~= ExplodeModel.HB then
						Child.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
						TweenService:Create(Child, TweenInfo.new(.3),   {Size = Child.Size*4}):Play()
						TweenService:Create(Child, TweenInfo.new(1.25), {Orientation = Child.Orientation * Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))}):Play()
						task.wait(0.4)
						TweenService:Create(Child, TweenInfo.new(.3),   {Transparency = 1}):Play()
						if Child == ExplodeModel.Base then
							task.wait(.2)
							for Children, Child2 in pairs(Child.Attachment:GetChildren()) do
								Child2.Enabled = false
							end
						end
					end
				end)
			end
			TweenService:Create(ExplodeModel.HB, TweenInfo.new(.3),   {Size = ExplodeModel.HB.Size*4}):Play()
			newSettings.HitboxType   = "Sphere"
			newSettings.MoveDuration = 1.25
			newSettings.Parent       = ExplodeModel
			SpatialHitbox.Add(ExplodeModel.HB, newSettings)
		end)

		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		wait(0.5)
		ring:Destroy()
		Humanoid.AutoRotate = true
		List.Character:SetAttribute("Attacking", false)
		wait(.25)
		List.Cooldown = false
	elseif table.find(WeaponTypes, Type) and Character:GetAttribute("Stamina") >= 10 then

		List.Character:SetAttribute("Attacking", true)
		List.SwordAttack = true
		List.Cooldown = true

		if Type == "DarkBlossoms" then

			local FlowerBooms = List.WeaponObject.Value

			local LeftBlade = FlowerBooms.LeftBlade
			local RightBlade = FlowerBooms.RightBlade

			LeftBlade.Material  = Enum.Material.Neon 
			RightBlade.Material = Enum.Material.Neon
			TweenService:Create(LeftBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(170, 0, 255)}):Play()
			TweenService:Create(RightBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(170, 0, 255)}):Play()
			coroutine.wrap(function()
				task.wait(.3)
				TweenService:Create(LeftBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(255, 152, 220)}):Play()
				TweenService:Create(RightBlade, TweenInfo.new(.1, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(255, 152, 220)}):Play()
				task.wait(.1)
				LeftBlade.Material = Enum.Material.Metal 
				RightBlade.Material = Enum.Material.Metal
			end)()

		end

		if Type == "ClockworkBlade" and Weapon:GetAttribute("Dual_Mode") then
			coroutine.wrap(function()

				local AnimOrientation = {
					[1] = {math.rad(160), .20},
					[2] = {math.rad(200), .20},
					[3] = {math.rad(160), .20}
				}
				wait(AnimOrientation[List.Anim][2])

				local Slash = WeaponEffects.ClockworkSlash:Clone()
				Slash.CFrame = RootPart.CFrame*CFrame.new(0, 0, 1)*CFrame.Angles(math.rad(180), 0, AnimOrientation[List.Anim][1])
				Slash.Parent = workspace.Debris
				Slash.Color = Color3.fromRGB(255, 100, 0)

				TweenService:Create(Slash, TweenInfo.new(.25), {CFrame = Slash.CFrame*CFrame.new(0, 0, 10), Transparency = 1}):Play()
				game.Debris:AddItem(Slash, .25)

			end)() 

			coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon, 2, nil, "ClockworkBladeDual")
			Character:SetAttribute("Stamina", Character:GetAttribute("Stamina") - 10)
			if WeaponSounds[Type] then
				PlaySound(RootPart, WeaponSounds[Type])
			end

			wait(Weapon:GetAttribute("Cooldown_Dual"))

		else

			if Type == "ClockworkBlade" then 
				coroutine.wrap(function()

					local AnimOrientation = {
						[1] = {math.rad(160), .35},
						[2] = {math.rad(200), .35},
						[3] = {math.rad(90), .40}
					}
					wait(AnimOrientation[List.Anim][2])

					local Slash = WeaponEffects.ClockworkSlash:Clone()
					Slash.CFrame = RootPart.CFrame*CFrame.new(0, 0, 1)*CFrame.Angles(math.rad(180), 0, AnimOrientation[List.Anim][1])
					Slash.Parent = workspace.Debris

					TweenService:Create(Slash, TweenInfo.new(.25), {CFrame = Slash.CFrame*CFrame.new(0, 0, 15), Transparency = 1}):Play()
					game.Debris:AddItem(Slash, .25)

				end)() 
			end

			coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)
			coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)
			Character:SetAttribute("Stamina", Character:GetAttribute("Stamina") - 10)
			if WeaponSounds[Type] then
				PlaySound(RootPart, WeaponSounds[Type])
			end

			wait(WeaponCooldown)
			coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)

		end

		List.SwordAttack = false
		List.Cooldown = false
		List.Character:SetAttribute("Attacking", false)

	elseif Type == "EasterWand" and Character:GetAttribute("Stamina") >= 10 then
		local Wand = Character:FindFirstChild("EasterWand")

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Wand.Sphere, true)

		List.Character:SetAttribute("Attacking", true)
		List.SwordAttack = true
		List.Cooldown = true
		Character:SetAttribute("Stamina", Character:GetAttribute("Stamina") - 10)

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector

		local EasterEgg = ItemAssetFolder.EasterEgg2:Clone()
		EasterEgg.Parent = workspace.Debris
		EasterEgg.CFrame = Orientation

		TweenService:Create(EasterEgg, TweenInfo.new(1.6, Enum.EasingStyle.Linear), {CFrame = EasterEgg.CFrame*CFrame.new(0, 0, -500)}):Play()

		local Settings = {
			["Knockback"]          = true,
			["KnockbackType"]      = "From_Character",
			["KnockbackPower"]     = 50,
			["KnockbackDuratioin"] = .1,
			["MoveDuration"]       = 1.6,
			["Player"]             = List.Character,
			["Damage"]             = Weapon:GetAttribute("Damage"),
			["Parent"]             = EasterEgg,
			["PassThroughObjects"] = true,
			["CanHitMoreThanOnce"] = true
		}
		RaycastHitbox.Add(EasterEgg.HB, Settings);

		wait(.7)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Wand.Sphere, false)
		List.SwordAttack = false
		List.Cooldown = false
		List.Character:SetAttribute("Attacking", false)
	elseif Type == "EasterGrimoire" and Character:GetAttribute("Stamina") >= 10 then
		local Wand = Character:FindFirstChild("EasterGrimoire")

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		List.Character:SetAttribute("Attacking", true)
		List.SwordAttack = true
		List.Cooldown = true
		Character:SetAttribute("Stamina", Character:GetAttribute("Stamina") - 10)

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector

		local EasterEgg = ItemAssetFolder.EasterEgg3:Clone()
		EasterEgg.Parent = workspace.Debris
		EasterEgg.CFrame = Orientation

		TweenService:Create(EasterEgg, TweenInfo.new(1.6, Enum.EasingStyle.Linear), {CFrame = EasterEgg.CFrame*CFrame.new(0, 0, -500)}):Play()

		local Settings = {
			["Knockback"]          = true,
			["KnockbackType"]      = "From_Character",
			["KnockbackPower"]     = 50,
			["KnockbackDuratioin"] = .1,
			["MoveDuration"]       = 1.6,
			["Player"]             = List.Character,
			["Damage"]             = Weapon:GetAttribute("Damage"),
			["Parent"]             = EasterEgg,
			["PassThroughObjects"] = true,
			["CanHitMoreThanOnce"] = true
		}
		RaycastHitbox.Add(EasterEgg.HB, Settings);

		wait(.7)
		List.SwordAttack = false
		List.Cooldown = false
		List.Character:SetAttribute("Attacking", false)
	elseif Type == "Pistol" then
		local Pistol = Character:FindFirstChild("Pistol")
		local DmgMultiplier = Pistol:FindFirstChild("DMG")
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		PlaySound(RootPart, Sounds.GunShot)

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		local Orientation = CFrame.new(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector

		local bullet = ItemAssetFolder.Bullet:Clone()
		bullet.Parent = workspace.Debris
		bullet.CFrame = Orientation*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))

		local ring = UniversalAssetFolder.RING:Clone()
		ring.Parent  = workspace.Debris
		ring.CFrame = RootPart.CFrame

		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*250

		task.spawn(function()		
			local ReturnedTable = RaycastHitbox.Add(bullet.HB, {
				["MoveDuration"]       = 1.5,
				["KnockbackPower"]     = 50,
				["KnockbackDuration"]  = .1,
				["Player"]             = List.Character,
				["Damage"]             = Weapon:GetAttribute("Damage"),
				["ReturnTable"]        = true,
				["Parent"]             = bullet,
				["PassThroughObjects"] = true,
			})

			if not ReturnedTable or type(ReturnedTable) ~= "table" or ReturnedTable.PlayersHit and #ReturnedTable.PlayersHit <= 1 then return end
			local hit = ReturnedTable.PlayersHit[1]
			local hum = hit.Humanoid
			local HRT = hit.PrimaryPart
			local ring2 = UniversalAssetFolder.RING:Clone()
			local Orientation = CFrame.lookAt(RootPart.Position, HRT.Position)
			ring2.Parent  = workspace.Debris
			ring2.CFrame =  (Orientation - Orientation.Position) + HRT.Position

			game.Debris:AddItem(ring2,0.5)
			TweenService:Create(ring2, TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(ring2.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()

			coroutine.wrap(CombatShortcuts.FameAward)(hum, play)
		end)

		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		wait(0.5)
		Humanoid.AutoRotate = true
		List.Character:SetAttribute("Attacking", false)
		ring:Destroy()

		wait(.25)
		List.Cooldown = false
	elseif Type == "EasterFlintlock" then
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true
		PlaySound(RootPart, Sounds.GunShot)

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		local Orientaton = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientaton.lookVector

		local bullet = ItemAssetFolder.Bullet2:Clone()
		bullet.Parent = workspace.Debris
		bullet.CFrame = Orientaton*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))

		local ring = UniversalAssetFolder.RING:Clone()
		ring.Parent  = workspace.Debris
		ring.CFrame = RootPart.CFrame

		TweenService:Create(bullet, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = Orientaton*CFrame.new(0, 0, -600)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))}):Play()

		task.spawn(function()
			local newSettings = {
				["MoveDuration"]       = 2,
				["KnockbackPower"]     = 50,
				["KnockbackDuration"]  = .1,
				["Player"]             = List.Character,
				["Damage"]             = Weapon:GetAttribute("Damage"),
				["ReturnTable"]        = true,
				["Parent"]             = bullet,
				["PassThroughObjects"] = true,
			}
			local ReturnedTable = RaycastHitbox.Add(bullet.HB, newSettings)
			if not ReturnedTable or #ReturnedTable.PlayersHit <= 1 then return end
			local hit = ReturnedTable.PlayersHit[1]
			local hum = hit.Humanoid
			local HRT = hit.PrimaryPart
			local ring2 = UniversalAssetFolder.RING:Clone()
			local Orientation = CFrame.lookAt(RootPart.Position, HRT.Position) 
			ring2.Parent  = workspace.Debris
			ring2.CFrame = CFrame.new(HRT.Position)*(Orientation - Orientation.Position)
			game.Debris:AddItem(ring2,0.5)
			TweenService:Create(ring2, TweenInfo.new(0.5),{Transparency = 1}):Play()
			TweenService:Create(ring2.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
			coroutine.wrap(CombatShortcuts.FameAward)(hum, play)
		end)

		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()
		task.wait(0.5)
		Humanoid.AutoRotate = true
		List.Character:SetAttribute("Attacking", false)
		ring:Destroy()
		List.Cooldown = false
	elseif Type == "EasterBow" then
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector

		local Arrow = WeaponEffects.Arrow:Clone()
		Arrow.Parent = workspace.Debris
		Arrow.HB.CFrame = Orientation

		local ArrowShock = WeaponEffects.ArrowShock:Clone()
		ArrowShock.CFrame = RootPart.CFrame*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		ArrowShock.Parent = workspace.Debris
		TweenService:Create(ArrowShock, TweenInfo.new(0.5), {Size = Vector3.new(40,20,40), Transparency = 1}):Play()
		game.Debris:AddItem(ArrowShock, .5)

		local Tween = TweenService:Create(Arrow.HB, TweenInfo.new(1.6, Enum.EasingStyle.Linear), {CFrame = Orientation*CFrame.new(0, 0, -600)})
		Tween:Play()

		local Settings = {
			["Knockback"]          = true,
			["KnockbackType"]      = "From_Character",
			["KnockbackPower"]     = 50,
			["KnockbackDuratioin"] = .1,
			["MoveDuration"]       = 1.6,
			["Player"]             = List.Character,
			["Damage"]             = Weapon:GetAttribute("Damage"),
			["Parent"]             = Arrow,
			["GetHitLocation"]     = true,
			["IgnoredList"]        = {ArrowShock, Arrow},
		}
		task.spawn(function()
			local ReturnedSettings = RaycastHitbox.Add(Arrow.HB, Settings);
			game.Debris:AddItem(Arrow, 10)
			if not ReturnedSettings and type(ReturnedSettings) == "table" and typeof(ReturnedSettings.LocationHit) == "Vector3" and not Arrow.PrimaryPart then return end
			Arrow.PrimaryPart.Anchored = false
			Tween:Cancel()
			Arrow.TrailPart.Trail.Enabled = false
			Arrow.PrimaryPart.Position = ReturnedSettings.LocationHit
			local weld

			if ReturnedSettings.PlayersHit[1] then
				weld = Instance.new("WeldConstraint")
				weld.Part1  = Arrow.PrimaryPart
				weld.Part0  = ReturnedSettings.PlayersHit[1].UpperTorso
				weld.Parent = Arrow.PrimaryPart
			else
				Arrow.PrimaryPart.Anchored = true
			end
			game.Debris:AddItem(weld,  10)
			task.wait(9)

			for ChildIndex, Child in pairs(Arrow:GetChildren()) do
				task.spawn(function()
					TweenService:Create(Child, TweenInfo.new(1), {Transparency = 1}):Play()
				end)
			end
		end)

		wait(1)
		Humanoid.AutoRotate = true
		List.Character:SetAttribute("Attacking", false)
		List.Cooldown = false
	elseif Type == "CursedGlove" then
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.LookVector
		local ChainBeam = WeaponEffects.ChainBeam:Clone()
		ChainBeam.Parent = workspace.Debris
		ChainBeam.Start.CFrame = CFrame.new(RootPart.Position)*(Orientation - Orientation.Position)
		ChainBeam.End.CFrame = CFrame.new(RootPart.Position)*(Orientation - Orientation.Position)

		local Weld = Instance.new("Weld", ChainBeam.Start)
		local WeldLocations = {
			List.Character.LeftHand,
			List.Character.RightHand,
		}
		Weld.Part0 = WeldLocations[List.Anim]
		Weld.Part1 = ChainBeam.Start

		local velo = Instance.new("BodyVelocity", ChainBeam.End)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*500

		local savedvelo = velo.Velocity
		game.Debris:AddItem(velo,0.7)

		local Tween = TweenService:Create(ChainBeam.End, TweenInfo.new(0.3), {Position = ChainBeam.Start.Position})
		coroutine.wrap(function()
			wait(0.7)
			if ChainBeam:FindFirstChild("End") then RaycastHitbox.Remove(ChainBeam.End) end
			if Tween.PlaybackState ~= Enum.PlaybackState.Playing then Tween:Play() end
			wait(0.3)
			Tween:Destroy()
			ChainBeam:Destroy()
		end)()

		coroutine.wrap(function()
			local newSettings = {
				DestroyOnHit = false,
				ReturnTable = true,
				KnockbackType = "Pull",
				KnockbackPower = 100,
				UseMoveDuration = false,
				PassThroughObjects = true,
				Damage = Weapon:GetAttribute("Damage"),
				Player = List.Character,
			}
			local ReturnedSettings = RaycastHitbox.Add(ChainBeam.End, newSettings)
			if ReturnedSettings then
				if #ReturnedSettings.PlayersHit <= 1 then return end
				local hit = ReturnedSettings.PlayersHit[1]
				Tween:Play()
				local hum = hit.Humanoid
				local HRT = hit.PrimaryPart
				velo:Destroy()
				local Weld2 = Instance.new("Weld", ChainBeam.End)
				Weld2.Part0 = ChainBeam.End
				Weld2.Part1 = HRT
				local sound1 = Instance.new("Sound")
				sound1.SoundId = "rbxassetid://4086068296"
				sound1.MaxDistance = 300
				sound1.EmitterSize = 20
				sound1.Volume = 0.5
				sound1.Pitch = 0.95
				sound1.Parent = HRT 
				sound1:Play()
				game.Debris:AddItem(sound1, 5)
				game.Debris:AddItem(Weld2, 5)
				coroutine.wrap(CombatShortcuts.FameAward)(hum, play)
			end
		end)()

		wait(0.5)
		List.Character:SetAttribute("Attacking", false)
		wait(.25)
		List.Cooldown = false
	elseif Type == "PumpkinPistol" then
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)
		Humanoid.AutoRotate = false

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector
		local cframe = Orientation

		local bullet = WeaponEffects.PumpkinPistolBullet:Clone()
		bullet.Parent = workspace.Debris
		bullet.CFrame = Orientation*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))

		local ring = UniversalAssetFolder.RING:Clone()
		ring.Parent  = workspace.Debris
		ring.CFrame = RootPart.CFrame
		ring.BrickColor = BrickColor.new("Br. yellowish orange")

		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*200
		bullet.Anchored = false

		coroutine.wrap(function()
			local newSettings = {
				["MoveDuration"]       = 2,
				["KnockbackPower"]     = 50,
				["KnockbackDuration"]  = .1,
				["Player"]             = List.Character,
				["Damage"]             = Weapon:GetAttribute("Damage"),
				["GetHitLocation"]     = true,
			}
			local ReturnedSettings = RaycastHitbox.Add(bullet, newSettings);
			if typeof(ReturnedSettings.LocationHit) ~= "Vector3" then return end
			if bullet then bullet.Anchored = true; bullet.Position = ReturnedSettings.LocationHit end -- Makes it look neat when it hits something, rather than it just zooming off

			local ExplodeModel = WeaponEffects.PumpkinPistolExplosion:Clone()
			ExplodeModel.Parent = workspace.Debris
			ExplodeModel:SetPrimaryPartCFrame(CFrame.new(ReturnedSettings.LocationHit))
			game.Debris:AddItem(ExplodeModel,0.75)

			newSettings.HitboxType = "Sphere"
			newSettings.PlayersHit = ReturnedSettings.PlayersHit
			newSettings.MoveDuration = 0.75
			SpatialHitbox.Add(ExplodeModel.HB, newSettings)

			for ChildIndex, Child in pairs(ExplodeModel:GetChildren()) do
				coroutine.wrap(function()
					if Child ~= ExplodeModel.HB then
						Child.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
						TweenService:Create(Child, TweenInfo.new(0.75), {Orientation = Child.Orientation * Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))}):Play()
						wait(.3)
						TweenService:Create(Child, TweenInfo.new(0.4), {Transparency = 1}):Play()
					end
				end)()
			end
		end)()

		TweenService:Create(ring, TweenInfo.new(0.5),{Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5),{Scale = Vector3.new(40,40,40)}):Play()

		wait(0.5)
		ring:Destroy()
		Humanoid.AutoRotate = true
		List.Character:SetAttribute("Attacking", false)

		wait(.25)
		List.Cooldown = false
	elseif Type == "CandyCaneGun" then
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		local CandyCaneGun = Character:FindFirstChild("CandyCaneGun")
		local DmgMultiplier = CandyCaneGun:FindFirstChild("DMG")

		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		Humanoid.AutoRotate = false

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector
		wait(.1)
		local bullet = ItemAssetFolder.SnowExplosion:Clone()
		bullet.Parent = workspace.Debris
		bullet.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
		bullet.Position = Orientation.Position

		local ring = UniversalAssetFolder.RING:Clone()
		ring.Parent  = workspace.Debris
		ring.CFrame = RootPart.CFrame

		if math.random(1, 2) == 1 then
			ring.BrickColor = BrickColor.new("Lime green")
		else
			ring.BrickColor = BrickColor.new("Dusty Rose")
		end

		local velo = Instance.new("BodyVelocity", bullet)
		velo.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		velo.Velocity = LookVector*200
		bullet.Anchored = false

		coroutine.wrap(function()
			local newSettings = {
				["MoveDuration"]       = 2,
				["Player"]             = List.Character,
				["Damage"]             = Weapon:GetAttribute("Damage"),
				["GetHitLocation"]     = true,
				["DestroyOnHit"]       = false,
			}
			if Tier == 2 then newSettings.CanFreeze = true end

			-- Adding hitbox to function, if a table is returned, it hit something. proceeds to anchor hitbox, and create explosion
			local ReturnedSettings = RaycastHitbox.Add(bullet, newSettings); RaycastHitbox.Remove(bullet);
			if typeof(ReturnedSettings.LocationHit) ~= "Vector3" then return end
			bullet.Position = ReturnedSettings.LocationHit; bullet.Anchored = true; bullet.Position = ReturnedSettings.LocationHit; bullet.Anchored = true;

			bullet.Trail.Enabled = false
			TweenService:Create(bullet, TweenInfo.new(0.5),{Size = Vector3.new(30,30,30), Transparency = 1}):Play()
			newSettings.MoveDuration = 0.5
			newSettings.PlayersHit = ReturnedSettings.PlayersHit
			newSettings.HitboxType = "Sphere"

			SpatialHitbox.Add(bullet, newSettings)
		end)()

		TweenService:Create(ring, TweenInfo.new(0.5), {Transparency = 1}):Play()
		TweenService:Create(ring.Mesh, TweenInfo.new(0.5), {Scale = Vector3.new(40,40,40)}):Play()
		game.Debris:AddItem(ring,.5)

		wait(0.5)
		Humanoid.AutoRotate = true
		List.Character:SetAttribute("Attacking", false)

		wait(.25)
		List.Cooldown = false

	elseif Type == "EasterStaff" and Character:FindFirstChild("EasterStaff") then
		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		local DmgMultiplier = Character:FindFirstChild("EasterStaff"):FindFirstChild("DMG")
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		local colors = {
			Color3.fromRGB(253, 234, 141),
			Color3.fromRGB(204, 255, 204),
			Color3.fromRGB(175, 221, 255),
			Color3.fromRGB(204, 188, 255),
			Color3.fromRGB(255, 255, 204),
			Color3.fromRGB(204, 188, 255),
			Color3.fromRGB(255, 201, 201),
			Color3.fromRGB(204, 255, 204)
		}

		local Orientation = CFrame.lookAt(RootPart.Position, direction.Position)
		local LookVector = Orientation.lookVector

		local EasterEgg = ItemAssetFolder.EasterEgg:Clone()
		EasterEgg.Parent = workspace.Debris
		EasterEgg.CFrame = Orientation*CFrame.Angles(math.rad(-90), 0, 0)
		EasterEgg.Anchored = true

		local RandomColor = math.random(1,8)
		EasterEgg.Color = colors[RandomColor]
		EasterEgg.Trail.Color = ColorSequence.new(colors[RandomColor],colors[RandomColor])

		if Tier == 2 then
			WeaponEffects.EasterStaffPE:Clone().Parent = EasterEgg
		end

		local tween = TweenService:Create(EasterEgg, TweenInfo.new((EasterEgg.CFrame.p - direction.p).Magnitude*.3/50,Enum.EasingStyle.Linear), {Position = direction.p})
		tween:Play()

		coroutine.wrap(function()
			local newSettings = {
				["MoveDuration"]       = 2,
				["Player"]             = List.Character,
				["Damage"]             = Weapon:GetAttribute("Damage"),
				["GetHitLocation"]     = true,
			}

			if Tier == 2 then
				newSettings["PerformLingerDoT"]  = true
				newSettings["DoTDuration"]       = 3
				newSettings["DoTRateOfHit"]      = .4
			end

			EasterEgg.AncestryChanged:Connect(function(Object, Parent)
				if not Parent then
					local EggExplosion = ItemAssetFolder.EggExplosion:Clone()
					EggExplosion.Parent = workspace.Debris
					EggExplosion.Position = Object.Position
					EggExplosion.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
					EggExplosion.Color = colors[RandomColor]
					TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(50,50,50)}):Play()

					newSettings["HitboxType"]   = "Sphere"
					newSettings["MoveDuration"] = 1

					if Tier == 2 then
						local PE  = WeaponEffects.EasterStaffPE:Clone()
						PE.Speed  = NumberRange.new(50,50)
						PE.Size   = NumberSequence.new(10,10)
						PE.Parent = EggExplosion
						game.Debris:AddItem(PE, 1)
						coroutine.wrap(function()
							wait(.5)
							PE.Enabled = false
						end)()
					end

					local ReturnedSettings = SpatialHitbox.Add(EggExplosion, newSettings)
				end
			end)
			local ReturnedSettings = RaycastHitbox.Add(EasterEgg, newSettings);			
			--local AC = ReturnedSettings.LocationHit
			--if AC and typeof(AC) == "Vector3" then
			--	local EggExplosion = ItemAssetFolder.EggExplosion:Clone()
			--	EggExplosion.Parent = workspace.Debris
			--	EggExplosion.Position = AC; EggExplosion.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
			--	EggExplosion.Color = colors[RandomColor]
			--	TweenService:Create(EggExplosion,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(50,50,50)}):Play()

			--	newSettings["HitboxType"]   = "Sphere"
			--	newSettings["MoveDuration"] = 1
			--	newSettings["PlayersHit"]   = ReturnedSettings.PlayersHit

			--	if Tier == 2 then
			--		local PE  = WeaponEffects.EasterStaffPE:Clone()
			--		PE.Speed  = NumberRange.new(50,50)
			--		PE.Size   = NumberSequence.new(10,10)
			--		PE.Parent = EggExplosion
			--		game.Debris:AddItem(PE, 1)
			--		coroutine.wrap(function()
			--			wait(.5)
			--			PE.Enabled = false
			--		end)()
			--	end

			--	local ReturnedSettings = SpatialHitbox.Add(EggExplosion, newSettings)
			-- VVVVVVVVVVVVVVV [SELF NOTE ADD EFFECTS Pl0X] VVVVVVVVVVVVV

			--			if DmgMultiplier > 1 then
			--				local PE = WeaponEffects.EasterStaffPE:Clone()
			--				PE.Speed = NumberRange.new(4,5)
			--				PE.Size = NumberSequence.new(1,1)
			--				PE.Parent = HRT
			--				game.Debris:AddItem(PE, 1)
			--				coroutine.wrap(function()
			--					for i=1, 2 do wait(.25)
			--						DmgFunction:Fire(Character,hum, Weapon:GetAttribute("Damage")*.2)
			--					end
			--					PE.Enabled = false
			--					for i=1, 2 do wait(.2)
			--						DmgFunction:Fire(Character,hum,Weapon:GetAttribute("Damage")*.2)
			--					end
			--				end)()
			--			end
			--end
		end)()

		task.wait(0.5)
		Character:SetAttribute("Attacking", false)
		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)
		task.wait(.25)
		List.Cooldown = false
	elseif Type == "FrozenExcalibur" then

		-- Blue Version of the TRL Excalibur Swing Projectile
		-- Excalibur gets swinged and said projectiles will pop out and travel to the mouse position.
		-- Projectile is a medium sized, deals moderate damage and travels through walls (same as in TRL, but it doesn't do massive amount of damage like in TRL)
		-- Animations should be the same, Sound effects could be the same as well.

		List.Character:SetAttribute("Attacking", true)
		List.Cooldown = true

		local WeaponDamage = Weapon:GetAttribute("Damage")
		local WeaponCooldown = Weapon:GetAttribute("Cooldown")

		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, true)
		coroutine.wrap(CombatShortcuts.AnimationHandler)(play, Weapon)

		task.wait(.25)

		local FES = ItemAssetFolder.FrozenExcaliburSlash:Clone()
		local FESTable = {FES.MainPE, FES.Attachment1.PE, FES.Attachment2.PE, FES.Attachment3.PE, FES.Attachment4.PE, FES.Attachment5.PE}
		FES.Parent = workspace.Debris
		FES.CFrame = List.RootPart.CFrame
		FES.CFrame = CFrame.new(FES.Position, direction.p)
		game.Debris:AddItem(FES, 1)

		Weapon.Blade.SwingSound:Play()

		coroutine.wrap(function()
			task.wait(0.65)
			for i=1,#FESTable do
				FESTable[i].Enabled = false
			end
		end)

		local Projectile = TweenService:Create(FES, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = FES.CFrame*CFrame.new(0, 0, -250)})
		Projectile:Play()

		local newSettings = {
			["HitboxType"]         = "Box",
			["MoveDuration"]       = 1,
			["Player"]             = List.Character,
			["Damage"]             = WeaponDamage
		}

		SpatialHitbox.Add(FES, newSettings)

		coroutine.wrap(CombatShortcuts.TrailEffect)(Weapon, false)

		task.wait(1)

		Character:SetAttribute("Attacking", false)
		task.wait(.25)
		List.Cooldown = false

	end
end)
-- // Services

-- // Variables
local newRandom = Random.new(math.randomseed(tick()+325237))

local Perk = {}

Perk.Name        = script.Name
Perk.Category    = script.Parent.Name
Perk.Description = "Rare Quirk users can evade attacks for 1.5 seconds after being hit. (Cooldown: 5 seconds)"
Perk.IconImage   = script.Decal.Texture or "rbxassetid://8274413023"

Perk.Enabled         = script:GetAttribute("Enabled")
Perk.HeroPerk        = script:GetAttribute("HeroPerk")
Perk.VillainPerk     = script:GetAttribute("VillainPerk")
Perk.ConditionalPerk = script:GetAttribute("ConditionalPerk")

-- // Perk benefits & Settings
Perk.Settings       = {}
Perk.Connections 	= {}

Perk.Settings.Evade_Chance 				= 100
Perk.Settings.Evade_Cooldown			= 5
Perk.Settings.Evade_Last_Used			= os.clock()

Perk.Settings.Evade_InUse				= false
Perk.Settings.Evade_Duration			= 1.5

Perk.Settings.Whitelisted_Quirks		= {28, 19, 20, 26, 32, 36, 21, 35, 3}

Perk.Animations							= {}
Perk.AnimationNumber 					= 1

-- // Function Dictionaries
Perk.RespawnFunctions = {} -- // Plays when a player respawns
Perk.DamageFunctions  = {} -- // Plays when a player hits someone
Perk.OnDeathFunctions = {} -- // Plays when a player dies
Perk.OnKillFunctions  = {} -- // Plays when someone defeats an npc
Perk.OnHitFunctions   = {} -- // Plays when the player is being hit

-- // custom type
type PerkProfile = {
	Perks            : {perkName : {"Perk info."}} | "Contains all the perks the player currently has, uses it's own naming system.",
	RespawnFunctions : {func : (any) -> any} | "Contains functions that occur during the players respawn.",
	DamageFunction   : {func : (any) -> any} | "Contains functions that occur when the player is dealing damage.",
	OnKillFunctions  : {func : (any) -> any} | "Contains functions that occur when the player has defeated an npc (Player if profile is owned by an npc).",
	OnDeathFunctions : {func : (any) -> any} | "Contains functions that occur when the player has died.",
	OnHitFunctions   : {func : (any) -> any} | "Contains functions that occur when the player has been hit (By either npc or player).",
	BlacklistedPerks : {string | "Perk names here in which the player cannot obtain."},
	Player           : Player | Model | "This contains the players game.Player instance, if owned by an NPC it's the npc's character.",
	Character        : Model  | nil   | "Assume it's nil contains the character.",
	PerkLimit        : number | "The players current limit in obtainable perks.",
	PerksHeld        : number | "The amount of perks the player currently has.",
	PerksPerPoll     : number | "The amount of perks that are shown to the player during a perk poll / intermission.",
	DeepCopy         : (self : {"The table that's being used."}, any) -> any,
	DisposeInfo      : (self : {"The table that's being used."}, any) -> nil,
	SetCounter       : (self : {"The table that's being used."}, Perk : string, Count : number) -> nil,
	SetCooldown      : (self : {"The table that's being used."}, Perk : string, Cooldown : number) -> nil,
	HasPerk          : (self : {"The table that's being used."}, Perk : string | {Name : string}) -> {any} | nil,
}

function Perk:PerkInitiation(Profile : PerkProfile, Player)

	Profile:DisposeInfo(Perk.Connections)
	Profile:DisposeInfo(Perk.Animations)
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return
	end
	
	self.Animations.EvasionAnimations = {}
	table.insert(self.Animations.EvasionAnimations, Profile.Character:WaitForChild("Humanoid"):LoadAnimation(script.EvadeAnimations.Evade1))
	table.insert(self.Animations.EvasionAnimations, Profile.Character:WaitForChild("Humanoid"):LoadAnimation(script.EvadeAnimations.Evade2))
	
--	Profile.Character:SetAttribute("MaxStamina", Profile.Character:GetAttribute("MaxStamina")-(Profile.Character:GetAttribute("MaxStamina")*Perk.Settings.Evade_Stamina_Drawback))
--	workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Profile.Player.Name):WaitForChild("Agility"):GetPropertyChangedSignal("Value"):Connect(function()
--		game["Run Service"].Heartbeat:Wait()
--		Profile.Character:SetAttribute("MaxStamina", Profile.Character:GetAttribute("MaxStamina")-(Profile.Character:GetAttribute("MaxStamina")*Perk.Settings.Evade_Stamina_Drawback))
--	end)
	
end

function Perk.OnHitFunctions.Evade_Trigger(self, Profile)
	
	if not table.find(Perk.Settings.Whitelisted_Quirks, Profile.Character:GetAttribute("Quirk")) then
		return
	end
	
--	if Profile.Character:GetAttribute("Stamina") < Profile.Character:GetAttribute("MaxStamina")*Perk.Settings.Evade_Stamina_Cost then
--		return false
--	end

	if Perk.Settings.Evade_InUse then
		return 0
	end
	
	if Perk.Settings.Evade_Last_Used + Perk.Settings.Evade_Cooldown > os.clock() then
		return
	end

	if newRandom:NextInteger(1, 100) <= Perk.Settings.Evade_Chance then
		
		if self.AnimationNumber == #self.Animations.EvasionAnimations then
			self.AnimationNumber = 1
		else
			self.AnimationNumber += 1
		end
		self.Animations.EvasionAnimations[self.AnimationNumber]:Play()
		task.delay(Perk.Settings.Evade_Duration, function()
			Profile:ShowMessage(self, "%s is on cooldown.",
				ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), 
					ColorSequenceKeypoint.new(.7, Color3.fromRGB(246, 184, 184)), 
					ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 0, 0))
				})
			)
			Perk.Settings.Evade_InUse = false
			Perk.Settings.Evade_Last_Used = os.clock()
			Profile:SetCooldown(self.Name, Perk.Settings.Evade_Cooldown)
		end)
		--		Profile.Character:SetAttribute("Stamina", Profile.Character:GetAttribute("Stamina")-Profile.Character:GetAttribute("MaxStamina")*Perk.Settings.Evade_Stamina_Cost)
		require(game.ServerScriptService.CombatScripts.DamageScript.ModifierModule).ShowDamage(Profile.Character, "Evaded ", Color3.fromRGB(255, 146, 21))
		Perk.Settings.Evade_InUse = true
		Profile:ShowMessage(self, "%s is active.")
		return 0
	end
	
	return
end

Perk.RespawnFunctions.PerkRespawn = Perk.PerkInitiation

return Perk
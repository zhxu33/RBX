local Player = game.Players.LocalPlayer
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
local Cash = PlayerData:WaitForChild("Cash")

local HatsumeButton = workspace.InteractionNPCS.MeiHatsume.Interact
local WeaponGUI = script.Parent
local ClickSound = WeaponGUI:WaitForChild("ClickSound")
local ShopFrame = WeaponGUI:WaitForChild("ShopFrame")
local CashDisplay = ShopFrame:WaitForChild("CashDisplay")
CashDisplay.Text = "Cash: $".. Cash.Value
Cash:GetPropertyChangedSignal("Value"):Connect(function()
	CashDisplay.Text = "Cash: $".. Cash.Value
end)

local SwitchFrame = ShopFrame:WaitForChild("SwitchFrame")
local ExitButton = SwitchFrame:WaitForChild("ExitButton")

local AppearUDIM = UDim2.fromScale(0.333, 0.197)
local DisappearUDIM = UDim2.fromScale(0.333, 1.2)
local ItemRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Item")
local ConfirmRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Confirm")

local InfoPanel = ShopFrame:WaitForChild("InfoPanel")
local ReturnButton = InfoPanel:WaitForChild("Return")
local GadgetInfo = InfoPanel:WaitForChild("GadgetInfo")
local MainInfo = InfoPanel:WaitForChild("MainInfo")
local Info1 = InfoPanel:WaitForChild("Info1")
local Info2 = InfoPanel:WaitForChild("Info2")
local Info3 = InfoPanel:WaitForChild("Info3")
local Info4 = InfoPanel:WaitForChild("Info4")
local Info5 = InfoPanel:WaitForChild("Info5")
local Info6 = InfoPanel:WaitForChild("Info6")
local Information = {GadgetInfo, MainInfo, Info1, Info2, Info3, Info4, Info5, Info6}

local toggled = false
local tweening = false
function Toggle(toggle)
	if not tweening then
		ClickSound:Play()
		tweening = true
		local tween
		if toggle and WeaponGUI.Enabled == false then
			WeaponGUI.Enabled = true
			tween = game.TweenService:Create(ShopFrame, TweenInfo.new(1), {Position = AppearUDIM})
			tween:Play()
			tween.Completed:Wait()
			toggled = true
			tweening = false
		elseif not toggle and WeaponGUI.Enabled == true then
			tween = game.TweenService:Create(ShopFrame, TweenInfo.new(1), {Position = DisappearUDIM})
			tween:Play()
			tween.Completed:Wait()
			tweening = false
			toggled = false
			WeaponGUI.Enabled = false
		end
	end
end
HatsumeButton.MouseClick:Connect(function()
	if not toggled then
		Toggle(true)
	end
end)

ExitButton.MouseButton1Click:Connect(function()
	if toggled then
		Toggle(false)
	end
end)

local PurchaseSuccess = WeaponGUI.PurchaseSuccess
local PurchaseFail = WeaponGUI.PurchaseFail
local PurchaseCooldown = false
local Purchasing = false

local WeaponFrame = SwitchFrame:WaitForChild("WeaponButton")
local WeaponMenu = ShopFrame:WaitForChild("WeaponShop")
local WeaponDisplay = WeaponMenu:WaitForChild("ItemFrame")
local WeaponScroll = WeaponMenu:WaitForChild("Scroll")
local Dagger = WeaponScroll:WaitForChild("Dagger")
local Katana = WeaponScroll:WaitForChild("Katana")
local Pistol = WeaponScroll:WaitForChild("Pistols")
local Weapons = {Dagger,Katana,Pistol}
local WeaponBuyConnection
local WeaponConfirmConnection

local DaggerTier = false
local KatanaTier = false
local PistolTier = false

local GadgetFrame = SwitchFrame:WaitForChild("GadgetButton")
local GadgetMenu = ShopFrame:WaitForChild("GadgetShop")
local GadgetDisplay = GadgetMenu:WaitForChild("ItemFrame")
local GadgetScroll = GadgetMenu:WaitForChild("Scroll")
local InfoButton =  GadgetDisplay:WaitForChild("InfoButton")
local Gauntlet = GadgetScroll:WaitForChild("Gauntlet")
local ShadowCape = GadgetScroll:WaitForChild("ShadowCape")
local SharpShooter = GadgetScroll:WaitForChild("SharpShootingGear")
local GiantHorn = GadgetScroll:WaitForChild("GiantHorn")
local HardenGear = GadgetScroll:WaitForChild("HardenGear")
local WingHeadphones = GadgetScroll:WaitForChild("WingHeadphones")
local HellFlameArmor = GadgetScroll:WaitForChild("HellFlameArmor")
local JetBoots = GadgetScroll:WaitForChild("JetBoots")
local PermeationCape = GadgetScroll:WaitForChild("PermeationCape")
local EngineBoots = GadgetScroll:WaitForChild("EngineBoots")
local Soles = GadgetScroll:WaitForChild("Soles")
local Respirator = GadgetScroll:WaitForChild("Respirator")
local Speakers = GadgetScroll:WaitForChild("Speakers")
local LaserBelt = GadgetScroll:WaitForChild("LaserBelt")
local ThirteenGloves = GadgetScroll:WaitForChild("ThirteenGloves")
local MetalBrace = GadgetScroll:WaitForChild("MetalBrace")
local HHHCVest = GadgetScroll:WaitForChild("HHHCVest")
local OverhaulMask = GadgetScroll:WaitForChild("OverhaulMask")
local FrogSuit = GadgetScroll:WaitForChild("FrogSuit")
local Gadgets = {Gauntlet,ShadowCape,SharpShooter,Soles,GiantHorn,HardenGear,WingHeadphones,HellFlameArmor,JetBoots,PermeationCape,EngineBoots,Respirator,Speakers,LaserBelt,ThirteenGloves,MetalBrace, HHHCVest, FrogSuit, OverhaulMask}
local GadgetBuyConnection
local GadgetConfirmConnection
local GadgetInfoConnection

local GauntletTier = false
local ShadowCapeTier = false
local SolesTier = false
local SharpShooterTier = nil
local GiantHornTier = nil
local HardenGearTier = nil
local WingHeadphonesTier = nil
local HellFlameArmorTier = nil
local JetBootsTier = nil
local PermeationCapeTier = nil
local EngineBootsTier = nil
local RespiratorTier = nil
local SpeakersTier = nil
local LaserBeltTier = nil
local ThirteenGlovesTier = nil
local MetalBraceTier = nil
local OverhaulMaskTier = nil
local HHHCVestTier = nil
local FrogSuitTier = nil

local function BuyCool()
	PurchaseCooldown = true
	coroutine.wrap(function()
		WeaponDisplay.Buy.TextTransparency = .3
		WeaponDisplay.Buy.Background.ImageTransparency = .3
		GadgetDisplay.Buy.TextTransparency = .3
		GadgetDisplay.Buy.Background.ImageTransparency = .3
		wait(5)
		PurchaseCooldown = false
		WeaponDisplay.Buy.TextTransparency = 0
		WeaponDisplay.Buy.Background.ImageTransparency = 0
		GadgetDisplay.Buy.TextTransparency = 0
		GadgetDisplay.Buy.Background.ImageTransparency = 0
	end)()
end

local WM = require(game.ReplicatedStorage.Modules.Weapons)
local function FetchImage(name, val)
	local d
	if val == nil or val == false then
		d = 1
	elseif val == 1 then
		d = 2
	elseif val == 2 or val == 3 then
		d = 3
	end
	local ID = WM[name]["Images"][d]
	if ID == nil then 
		while ID == nil do
			d = d - 1
			ID = WM[name]["Images"][d]
			if d == 0 then
				ID = 0
			end
		end
	end
	return "rbxassetid://" .. ID
end
--[[
local function FetchImage(name, val)
	if name == "Dagger" then
		if val == false then return "rbxassetid://2306868791"
		elseif val == 1 then return "rbxassetid://2310752864"
		elseif val == 2 or val == 3 then return "rbxassetid://2310762185"
		end
	elseif name == "Katana" then
		if val == false then return "rbxassetid://2310657176"
		elseif val == 1 then return "rbxassetid://2310771070"
		elseif val == 2 or val == 3 then return "rbxassetid://2310749742"
		end
	elseif name == "Pistol" then
		if val == false then return "rbxassetid://2310651537"
		elseif val == 1 then return "rbxassetid://2310651736"
		elseif val == 2 or val == 3 then return "http://www.roblox.com/asset/?id=5689772563"
		end
	elseif name == "Gauntlet" then return "rbxassetid://6291249534"
	elseif name == "SharpShootingGear" then return "rbxassetid://6291515232"
	elseif name == "ShadowCape" then return "rbxassetid://6291235216"
	elseif name == "GiantHorn" then return "rbxassetid://6291269989"
	elseif name == "HardenGear" then return "rbxassetid://6291307716"
	elseif name == "WingHeadphones" then return "rbxassetid://6291339478"
	elseif name == "HellFlameArmor" then return "rbxassetid://6291491340"
	elseif name == "JetBoots" then return "rbxassetid://6291441493"
	elseif name == "PermeationCape" then return "rbxassetid://6291394741"
	elseif name == "EngineBoots" then return "rbxassetid://6291452875"
	elseif name == "Respirator" then return "rbxassetid://6424213744"
	elseif name == "Speakers" then return "rbxassetid://6424216210"
	elseif name == "LaserBelt" then return "rbxassetid://6424214974"
	elseif name == "ThirteenGloves" then return "rbxassetid://6424170684"
	elseif name == "MetalBrace" then return "rbxassetid://6430235275"
	elseif name == "IronSole" then
		if val == false then return "rbxassetid://3614452498"
		elseif val == 1 or val == 2 then return "rbxassetid://3614442423"
		end
	end
end ]]

local function FetchInfo(name, val)
	if name == "Dagger" then
		if val == nil or val == false then return {Cost = "Cost: $15000", DamageMultiplier = "1.3x", Star = "★☆☆", Skill = "?"}
		elseif val == 1 then return {Cost = "Cost: $20000", DamageMultiplier = "1.3x > 1.62x", Star = "★★☆", Skill = "?"}
		elseif val == 2 then return {Cost = "Cost: $25000", DamageMultiplier = "1.62x > 1.92x", Star = "★★★", Skill = "?"}
		elseif val == 3 then return {Cost = "Max Upgrade", DamageMultiplier = "1.92x", Star = "★★★", Skill = "?"}
		end
	elseif name == "Katana" then
		if val == nil or val == false then return {Cost = "Cost: $15000", DamageMultiplier = "1.16x", Star = "★☆☆", Skill = "?"}
		elseif val == 1 then return {Cost = "Cost: $20000", DamageMultiplier = "1.16x > 1.44x", Star = "★★☆", Skill = "?"}
		elseif val == 2 then return {Cost = "Cost: $30000", DamageMultiplier = "1.44x > 1.725x", Star = "★★★", Skill = "?"}
		elseif val == 3 then return {Cost = "Max Upgrade", DamageMultiplier = "1.725x", Star = "★★★", Skill = "?"}
		end
	elseif name == "Pistol" then
		if val == nil or val == false then return {Cost = "Cost: $20000", DamageMultiplier = "1.5x", Star = "★☆☆", Skill = "?"}
		elseif val == 1 then return {Cost = "Cost: $30000", DamageMultiplier = "1.5x > 1.875x", Star = "★★☆", Skill = "?"}
		elseif val == 2 then return {Cost = "Cost: $50000", DamageMultiplier = "1.875x > 1.875x + (2x Fire Rate)", Star = "★★★", Skill = "?"}
		elseif val == 3 then return {Cost = "Max Upgrade", DamageMultiplier = "1.875x (2x Fire Rate)", Star = "★★★", Skill = "?"}
		end
	elseif name == "Gauntlet" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the damage for Explosion's Movesets", Quirk = "Explosion"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage for Explosion's Movesets", Quirk = "Explosion"}
		end
	elseif name == "GiantHorn" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases growth size and damage reduction for Gigantification.", Quirk = "Gigantification"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases growth size and damage reduction for Gigantification.", Quirk = "Gigantification"}
		end
	elseif name == "HardenGear" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the damage for Hardening's Movesets", Quirk = "Hardening"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage for Hardening's Movesets", Quirk = "Hardening"}
		end
	elseif name == "WingHeadphones" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increased defense during Fierce Wing's flight", Quirk = "Fierce Wings"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increased defense during Fierce Wing's flight", Quirk = "Fierce Wings"}
		end
	elseif name == "HellFlameArmor" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the damage for HellFlame's Movesets", Quirk = "Hell Flame"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage for HellFlame's Movesets", Quirk = "Hell Flame"}
		end
	elseif name == "JetBoots" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the damage of Jet's Movesets", Quirk = "Jet"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of Jet's Movesets", Quirk = "Jet"}
		end
	elseif name == "PermeationCape" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Reduced cooldown for Permeation's Movesets", Quirk = "Permeation"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Reduced cooldown for Permeation's Movesets", Quirk = "Permeation"}
		end
	elseif name == "EngineBoots" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the speed cap for Engine's sprint", Quirk = "Engine"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the speed cap for Engine's sprint", Quirk = "Engine"}
		end
	elseif name == "ShadowCape" then
		if val == nil or val == false then return {Cost = "Cost: $40000", Information = "Increases the damage for Dark Shadow's Movesets", Quirk = "Dark Shadow"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage for Dark Shadow's Movesets", Quirk = "Dark Shadow"}
		end
	elseif name == "SharpShootingGear" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Allows you to shoot disks and electrocute them. (Replaces Q/V moves)", Quirk = "Electrification"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Allows you to shoot disks and electrocute them. (Replaces Q/V moves)", Quirk = "Electrification"}
		end
	elseif name == "IronSole" then
		if val == nil or val == false then return {Cost = "Cost: $75000", Information = "Increases the damage for shockwaves done by kicks.", Quirk = "Deku's One For All"}
		elseif val == 1 then return {Cost = "Cost: $100000", Information = "Increases the overall damage for shockwaves.", Quirk = "Deku's One For All"}
		elseif val == 2 then return {Cost = "Max Upgrade", Information = "Increases the overall damage for shockwaves.", Quirk = "Deku's One For All"}
		end
	elseif name == "Respirator" then
		if val == nil or val == false then return {Cost = "Cost: $100000", Information = "Reduces incoming damage, knockback and stamina consumption.", Quirk = "All For One"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Reduces incoming damage, knockback and stamina consumption.", Quirk = "All For One"}
		end
	elseif name == "Speakers" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the damage of Voice's Movesets", Quirk = "Voice"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of Voice's Movesets", Quirk = "Voice"}
		end
	elseif name == "LaserBelt" then
		if val == nil or val == false then return {Cost = "Cost: $50000", Information = "Increases the damage of Navel Laser's Movesets", Quirk = "Navel Laser"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of Navel Laser's Movesets", Quirk = "Navel Laser"}
		end
	elseif name == "ThirteenGloves" then
		if val == nil or val == false then return {Cost = "Cost: $75000", Information = "Increases the damage of Blackhole's Movesets", Quirk = "Blackhole"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of Blackhole's Movesets", Quirk = "Blackhole"}
		end
	elseif name == "MetalBrace" then
		if val == nil or val == false then return {Cost = "Cost: $75000", Information = "Reduces incoming damage for Warp Gate users.", Quirk = "Warp Gate"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Reduces incoming damage for Warp Gate users.", Quirk = "Warp Gate"}
		end
	elseif name == "OverhaulMask" then
		if val == nil or val == false then return {Cost = "Cost: $100000", Information = "Increases the damage of Overhaul's Movesets", Quirk = "Overhaul"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of Overhaul's Movesets", Quirk = "Overhaul"}
		end
	elseif name == "HHHCVest" then
		if val == nil or val == false then return {Cost = "Cost: $100000", Information = "Increases the damage of HHHC's Movesets", Quirk = "Half Hot Half Cold"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of HHHC's Movesets", Quirk = "Half Hot Half Cold"}
		end
	elseif name == "FrogSuit" then
		if val == nil or val == false then return {Cost = "Cost: $75000", Information = "Increases the damage of Frog's movesets.", Quirk = "Frog"}
		elseif val == 1 then return {Cost = "Purchased", Information = "Increases the damage of Frog's movesets.", Quirk = "Frog"}
		end
	end
end

local function InfoChange(name)
	if name == "Gauntlet" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 162, 12)
		end
		GadgetInfo.Text = "Gauntlet"
		MainInfo.Text = "Increases the damage of Explosion's movesets:"
		Info1.Text = "Adrenaline Rush Punch Damage increase by 25%"
		Info2.Text = "Explosion (Q): 2.00x/2.40x → 2.25x/2.70x"
		Info3.Text = "Chained Blast (Z): 1.75x/2.10x → 2.00x/2.40x"
		Info4.Text = "AP Shot (X): 3.00x/3.60x → 3.25x/3.90x"
		Info5.Text = "Ground Blast (C): 3.25x/3.90x → 3.50x/4.20x"
		Info6.Text = "Howitzer Impact (V): 4.00x/4.80x → 4.50x/5.40x"
	elseif name == "ShadowCape" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(114, 12, 197)
		end
		GadgetInfo.Text = "Shadow Cape"
		MainInfo.Text = "Increases the damage of Dark Shadow's movesets:"
		Info1.Text = "Shadow Strike (Q): 1.75x/2.10x → 2.10x/2.52x"
		Info2.Text = "Shadow Barrage (X): 0.50x/0.60x → 0.60x/0.72x per hit"
		Info3.Text = "Shadow Slam (C): 2.50x/3.00x → 3.00x/3.60x"
		Info4.Text = "Shadow Combo (V): 3.25x/3.50x → 3.90x/4.20x"
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "SharpShootingGear" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Sharp Shooter Gear"
		MainInfo.Text = "Replaces Q/V with moves that utilize the disks:"
		Info1.Text = ""
		Info2.Text = "Electric Blast replaced with the ability to plant disks and electrocute them."
		Info3.Text = "Full Discharge replaced with Electric Containment."
		Info4.Text = "(The user will spin and rapidly shoot out disks, afterwards electrocuting them, creating a cage of electricity that will deal very high damage to anyone near it.)"
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "GiantHorn" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Giant Horn"
		MainInfo.Text = "Increases growth size and damage reduction for Gigantification."
		Info1.Text = ""
		Info2.Text = ""
		Info3.Text = ""
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "HardenGear" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Harden Gear"
		MainInfo.Text = "Increases the damage for Hardening's Movesets"
		Info1.Text = "Red Counter (Q): 2.25x/2.93x/3.60x → 2.50x/3.25x/4.00x"
		Info2.Text = ""
		Info3.Text = "Red Gauntlet (X): 3.25x/4.00x → 3.58x/4.40x"
		Info4.Text = "Earth-shattering Strike (C): 3.58x/4.40x → 3.90x/4.80x"
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "WingHeadphones" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Wing Headphones"
		MainInfo.Text = "Increased defense during Fierce Wing's flight"
		Info1.Text = ""
		Info2.Text = ""
		Info3.Text = ""
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = "Flight (F): Defense increase during flight."
	elseif name == "HellFlameArmor" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Hell Flame Armor"
		MainInfo.Text = "Increases the damage for Hell Flame's Movesets"
		Info1.Text = "Hell Flame flight speed increased by 25%."
		Info2.Text = "Flashfire Fist (Q): 2.50x/3.00x → 2.75x/3.30x"
		Info3.Text = "Flashfire Creation (Z): 2.75x/3.3x → 3.00x/3.60x"
		Info4.Text = "Hellfire Ball (X): 3.00x/3.60x → 3.25x/3.90x"
		Info5.Text = "Flashfire Fist (C): 0.30x/0.36x → 0.35x/0.42x per hit"
		Info6.Text = "Prominence Flame (V): 3.75x/4.50x → 4.00x/4.80x"
	elseif name == "JetBoots" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Jet Boots"
		MainInfo.Text = "Increases the damage for Jet's Movesets"
		Info1.Text = "Jet Slam (Q): 4.00x → 4.50x"
		Info2.Text = ""
		Info3.Text = "Spinning Kick (X): 3.00x → 3.25x"
		Info4.Text = "Jet Barrage (C): 0.20x → 0.25x per hit"
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "PermeationCape" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Permeation Cape"
		MainInfo.Text = "Reduced cooldown for Permeation's Movesets"
		Info1.Text = ""
		Info2.Text = "Permeation Escape: Removes cooldown."
		Info3.Text = "Permeation Combo (C): Reduced cooldown from 5 to 3 seconds."
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "EngineBoots" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Engine Boots"
		MainInfo.Text = "Increases the speed of engine's sprint"
		Info1.Text = ""
		Info2.Text = ""
		Info3.Text = ""
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "Respirator" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 0, 0)
		end
		GadgetInfo.Text = "Respirator"
		MainInfo.Text = "Reduces incoming damage by 15%, shortens the stun time by 50% and reduces stamina consumption for every AFO moveset by 10%."
		Info1.Text = "Base Reduction: 0% → 15%"
		Info2.Text = "w/ Springlock Combination: 16.67% → 33%~"
		Info3.Text = "w/ Impact Recoil: 50% → 60%"
		Info4.Text = "w/ Both: 58%~ → 65%~"
		Info5.Text = ""
		Info6.Text = "(Damage Reduction only works for AFO users)"
	elseif name == "Speakers" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Speakers"
		MainInfo.Text = "Increases the damage of Voice's movesets by 25%"
		Info1.Text = "Yell: 0.375x per hit → 0.47x~ per hit"
		Info2.Text = "Shout: 0.6x per hit → 0.75x per hit"
		Info3.Text = ""
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "LaserBelt" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(0, 255, 255)
		end
		GadgetInfo.Text = "Laser Belt"
		MainInfo.Text = "Increases the damage of Navel Laser's movesets by 20%"
		Info1.Text = "Navel Laser: 2.5x → 3x"
		Info2.Text = "Navel Flight: 2x → 2.4x"
		Info3.Text = "Navel Barrage: 1.5x per hit → 1.8x per hit"
		Info4.Text = "Super Navel Laser: 4x → 4.8x"
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "ThirteenGloves" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(151, 0, 226)
		end
		GadgetInfo.Text = "Thirteen's Gloves"
		MainInfo.Text = "Increases the damage of Blackhole's movesets by 20%."
		Info1.Text = "Black Hole: 0.075x per hit → 0.9x per hit"
		Info2.Text = "Black Hole Trap: 0.0875x per hit → 0.105x per hit"
		Info3.Text = "Black Hole Explosion: 0.075x per hit (+ 2x) → 0.9x per hit (+ 2.4x)"
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "MetalBrace" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(202, 8, 255)
		end
		GadgetInfo.Text = "Kurogiri's Metal Brace"
		MainInfo.Text = "Provides the Warp Gate user a 15% Damage Reduction."
		Info1.Text = ""
		Info2.Text = ""
		Info3.Text = ""
		Info4.Text = ""
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "OverhaulMask" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(202, 8, 255)
		end
		GadgetInfo.Text = "Overhaul's Mask"
		MainInfo.Text = ""
		Info1.Text = ""
		Info2.Text = "Ground Spikes: 3x → 3.25x"
		Info3.Text = ""
		Info4.Text = "Disassembling World: 3.5x → 3.75x "
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "HHHCVest" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		GadgetInfo.Text = "Todoroki's Vest"
		MainInfo.Text = ""
		Info1.Text = "Fire Ball/Ice Field/Burning Ice Field: 2.5x → 2.75x/2.25x → 2.5x/3x → 3.25x"
		Info2.Text = "Fire Floor/Ice Spikes/Burning Ice Spikes: 2.75x → 3x/2.5x → 2.75x/3.25x → 3.5x"
		Info3.Text = "Fire Bomb/Glacier/Ultimate Explosion: 3.5x → 3.75x/3.25x → 3.5x/2x → 2.25x + 2.5x → 2.75x "
		Info4.Text = "Flame Thrower/Ice Slide/Flashfreeze Heatwave: 0.25x → 0.3x/2.5x → 2x/2.25x → 2.5x+2.25x → 2.5x"
		Info5.Text = ""
		Info6.Text = ""
	elseif name == "FrogSuit" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(31, 128, 29)
		end
		GadgetInfo.Text = "Frog Suit"
		MainInfo.Text = ""
		Info1.Text = "Tongue Slap: 2.5x → 2.75x"
		Info2.Text = "Tongue Grab: 3x → 3.25x"
		Info3.Text = "Tongue Leap: 3.25x → 3.5x"
		Info4.Text = "Tongue Throw: 2x → 2.25x + 2x → 2.25x"
		Info5.Text = "Tongue Barrage: .15x → .2x"
		Info6.Text = ""
	elseif name == "IronSole1" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(42, 209, 198)
		end
		GadgetInfo.Text = "Iron Soles"
		MainInfo.Text = "Increases the damage of Deku's One For All kick shockwaves:"
		Info1.Text = ""
		Info2.Text = "St. Louis Smash (Q): 2.25x → 2.70x"
		Info3.Text = "Detroit Stomp (C): 3.50x → 4.20x"
		Info4.Text = ""
		Info5.Text = "This gadget can be upgraded to the Gamma Suit."
		Info6.Text = ""
	elseif name == "IronSole2" then
		for i=1,#Information do
			Information[i].TextColor3 = Color3.fromRGB(42, 209, 198)
		end
		GadgetInfo.Text = "Gamma Suit"
		MainInfo.Text = "Increases the damage for all Deku's One For All moves:"
		Info1.Text = "St. Louis Smash (Q): 2.25x → 2.70x"
		Info2.Text = "Detroit Smash (Z): 2.50x → 3.00x"
		Info3.Text = "Delaware Smash (X): 2.00x → 2.40x"
		Info4.Text = "Detroit Stomp (C): 3.50x → 4.20x"
		Info5.Text = "10000000% Delaware Detroit Smash (V): 4.50x → 5.40x"
		Info6.Text = ""
	end
end

Dagger.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if WeaponBuyConnection ~= nil then WeaponBuyConnection:Disconnect() end
	for i=1,#Weapons do
		Weapons[i].SelectOutline.Visible = false
	end
	Dagger.SelectOutline.Visible = true
	WeaponDisplay.Visible = true
	local function UpdateGUI()
		local DaggerInfo = FetchInfo("Dagger", DaggerTier)
		WeaponDisplay.ImageLabel.Image = FetchImage("Dagger", DaggerTier)
		WeaponDisplay.Cost.Text = DaggerInfo.Cost
		WeaponDisplay.Upgrade.Text = "Upgrade: ".. DaggerInfo.Star
		WeaponDisplay.Damage.Text = "Damage Multiplier: ".. DaggerInfo.DamageMultiplier
		WeaponDisplay.Buy.Visible = true
		if DaggerTier == false then
			WeaponDisplay.Buy.Text = "Purchase"
		elseif DaggerTier > 0 and DaggerTier < 3 then
			WeaponDisplay.Buy.Text = "Upgrade"
		else
			WeaponDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if DaggerTier == false then
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				WeaponConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Dagger")
		end)
	elseif DaggerTier > 0 and DaggerTier < 3 then
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				WeaponConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Dagger")
		end)
	end
end)

Katana.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if WeaponBuyConnection ~= nil then WeaponBuyConnection:Disconnect() end
	for i=1,#Weapons do
		Weapons[i].SelectOutline.Visible = false
	end
	Katana.SelectOutline.Visible = true
	WeaponDisplay.Visible = true
	local function UpdateGUI()
		local KatanaInfo = FetchInfo("Katana", KatanaTier)
		WeaponDisplay.ImageLabel.Image = FetchImage("Katana", KatanaTier)
		WeaponDisplay.Cost.Text = KatanaInfo.Cost
		WeaponDisplay.Upgrade.Text = "Upgrade: ".. KatanaInfo.Star
		WeaponDisplay.Damage.Text = "Damage Multiplier: ".. KatanaInfo.DamageMultiplier
		WeaponDisplay.Buy.Visible = true
		if KatanaTier == false then
			WeaponDisplay.Buy.Text = "Purchase"
		elseif KatanaTier > 0 and KatanaTier < 3 then
			WeaponDisplay.Buy.Text = "Upgrade"
		else
			WeaponDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if KatanaTier == false then
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				WeaponConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Katana")
		end)
	elseif KatanaTier > 0 and KatanaTier < 3 then
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			ClickSound:Play()
			WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if PurchaseCooldown then return end
				BuyCool()
				Purchasing = true
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				WeaponConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Katana")
		end)
	end
end)

Pistol.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if WeaponBuyConnection ~= nil then WeaponBuyConnection:Disconnect() end
	for i=1,#Weapons do
		Weapons[i].SelectOutline.Visible = false
	end
	Pistol.SelectOutline.Visible = true
	WeaponDisplay.Visible = true
	local function UpdateGUI()
		local PistolInfo = FetchInfo("Pistol", PistolTier)
		WeaponDisplay.ImageLabel.Image = FetchImage("Pistol", PistolTier)
		WeaponDisplay.Cost.Text = PistolInfo.Cost
		WeaponDisplay.Upgrade.Text = "Upgrade: ".. PistolInfo.Star
		WeaponDisplay.Damage.Text = "Damage Multiplier: ".. PistolInfo.DamageMultiplier
		WeaponDisplay.Buy.Visible = true
		if PistolTier == false then
			WeaponDisplay.Buy.Text = "Purchase"
		elseif PistolTier > 0 and PistolTier < 3 then
			WeaponDisplay.Buy.Text = "Upgrade"
		else
			WeaponDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if PistolTier == false then
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				WeaponConfirmConnection:Disconnect()
			end)
			ItemRemote:FireServer("Pistol")
		end)
	elseif PistolTier > 0 and PistolTier < 3 then
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				WeaponConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Pistol")
		end)
	end
end)

ReturnButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	InfoPanel.Visible = false
	GadgetMenu.Visible = true
end)

Gauntlet.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	Gauntlet.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("Gauntlet")
			InfoPanel.Visible = true
		end)
		local GauntletInfo = FetchInfo("Gauntlet", GauntletTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("Gauntlet", GauntletTier)
		GadgetDisplay.Cost.Text = GauntletInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. GauntletInfo.Quirk
		GadgetDisplay.Info2.Text = GauntletInfo.Information
		GadgetDisplay.Buy.Visible = true
		if GauntletTier == false then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if GauntletTier == false then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Gauntlet")
		end)
	end
end)

ShadowCape.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	ShadowCape.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("ShadowCape")
			InfoPanel.Visible = true
		end)
		local ShadowCapeInfo = FetchInfo("ShadowCape", ShadowCapeTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("ShadowCape", ShadowCapeTier)
		GadgetDisplay.Cost.Text = ShadowCapeInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. ShadowCapeInfo.Quirk
		GadgetDisplay.Info2.Text = ShadowCapeInfo.Information
		GadgetDisplay.Buy.Visible = true
		if ShadowCapeTier == false then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if ShadowCapeTier == false then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("ShadowCape")
		end)
	end
end)

Soles.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	Soles.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			if SolesTier == false then
				InfoChange("IronSole1")
			else
				InfoChange("IronSole2")
			end
			InfoPanel.Visible = true
		end)
		local ISInfo = FetchInfo("IronSole", SolesTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("IronSole", SolesTier)
		GadgetDisplay.Cost.Text = ISInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. ISInfo.Quirk
		GadgetDisplay.Info2.Text = ISInfo.Information
		GadgetDisplay.Buy.Visible = true
		if SolesTier == false then
			GadgetDisplay.Buy.Text = "Purchase"
		elseif SolesTier == 1 then
			GadgetDisplay.Buy.Text = "Upgrade"
		elseif SolesTier == 2 then
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if SolesTier == false then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				Purchasing = false
				GadgetConfirmConnection:Disconnect()
			end)
			ItemRemote:FireServer("IronSole")
		end)
	elseif SolesTier == 1 then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				Purchasing = false
				GadgetConfirmConnection:Disconnect()
			end)
			ItemRemote:FireServer("IronSole")
		end)
	end
end)


SharpShooter.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	SharpShooter.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("SharpShootingGear")
			InfoPanel.Visible = true
		end)
		local SSGInfo = FetchInfo("SharpShootingGear", SharpShooterTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("SharpShootingGear", SharpShooterTier)
		GadgetDisplay.Cost.Text = SSGInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. SSGInfo.Quirk
		GadgetDisplay.Info2.Text = SSGInfo.Information
		GadgetDisplay.Buy.Visible = true
		if SharpShooterTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if SharpShooterTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				Purchasing = false
				GadgetConfirmConnection:Disconnect()
			end)
			ItemRemote:FireServer("SharpShootingGear")
		end)
	end
end)

GiantHorn.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	GiantHorn.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("GiantHorn")
			InfoPanel.Visible = true
		end)
		local GiantHornInfo = FetchInfo("GiantHorn", GiantHornTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("GiantHorn", GiantHornTier)
		GadgetDisplay.Cost.Text = GiantHornInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. GiantHornInfo.Quirk
		GadgetDisplay.Info2.Text = GiantHornInfo.Information
		GadgetDisplay.Buy.Visible = true
		if GiantHornTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if GiantHornTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("GiantHorn")
		end)
	end
end)

HardenGear.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	HardenGear.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("HardenGear")
			InfoPanel.Visible = true
		end)
		local HardenGearInfo = FetchInfo("HardenGear", HardenGearTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("HardenGear", HardenGearTier)
		GadgetDisplay.Cost.Text = HardenGearInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. HardenGearInfo.Quirk
		GadgetDisplay.Info2.Text = HardenGearInfo.Information
		GadgetDisplay.Buy.Visible = true
		if HardenGearTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if HardenGearTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("HardenGear")
		end)
	end
end)

WingHeadphones.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	WingHeadphones.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("WingHeadphones")
			InfoPanel.Visible = true
		end)
		local WingHeadphonesInfo = FetchInfo("WingHeadphones", WingHeadphonesTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("WingHeadphones", WingHeadphonesTier)
		GadgetDisplay.Cost.Text = WingHeadphonesInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. WingHeadphonesInfo.Quirk
		GadgetDisplay.Info2.Text = WingHeadphonesInfo.Information
		GadgetDisplay.Buy.Visible = true
		if WingHeadphonesTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if WingHeadphonesTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("WingHeadphones")
		end)
	end
end)

HellFlameArmor.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	HellFlameArmor.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("HellFlameArmor")
			InfoPanel.Visible = true
		end)
		local HellFlameArmorInfo = FetchInfo("HellFlameArmor", HellFlameArmorTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("HellFlameArmor", HellFlameArmorTier)
		GadgetDisplay.Cost.Text = HellFlameArmorInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. HellFlameArmorInfo.Quirk
		GadgetDisplay.Info2.Text = HellFlameArmorInfo.Information
		GadgetDisplay.Buy.Visible = true
		if HellFlameArmorTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if HellFlameArmorTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("HellFlameArmor")
		end)
	end
end)

JetBoots.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	JetBoots.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("JetBoots")
			InfoPanel.Visible = true
		end)
		local JetBootsInfo = FetchInfo("JetBoots", JetBootsTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("JetBoots", JetBootsTier)
		GadgetDisplay.Cost.Text = JetBootsInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. JetBootsInfo.Quirk
		GadgetDisplay.Info2.Text = JetBootsInfo.Information
		GadgetDisplay.Buy.Visible = true
		if JetBootsTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if JetBootsTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("JetBoots")
		end)
	end
end)

PermeationCape.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	PermeationCape.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("PermeationCape")
			InfoPanel.Visible = true
		end)
		local PermeationCapeInfo = FetchInfo("PermeationCape", PermeationCapeTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("PermeationCape", PermeationCapeTier)
		GadgetDisplay.Cost.Text = PermeationCapeInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. PermeationCapeInfo.Quirk
		GadgetDisplay.Info2.Text = PermeationCapeInfo.Information
		GadgetDisplay.Buy.Visible = true
		if PermeationCapeTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if PermeationCapeTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("PermeationCape")
		end)
	end
end)

EngineBoots.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	EngineBoots.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("EngineBoots")
			InfoPanel.Visible = true
		end)
		local EngineBootsInfo = FetchInfo("EngineBoots", EngineBootsTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("EngineBoots", EngineBootsTier)
		GadgetDisplay.Cost.Text = EngineBootsInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. EngineBootsInfo.Quirk
		GadgetDisplay.Info2.Text = EngineBootsInfo.Information
		GadgetDisplay.Buy.Visible = true
		if EngineBootsTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if EngineBootsTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("EngineBoots")
		end)
	end
end)

Respirator.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	Respirator.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("Respirator")
			InfoPanel.Visible = true
		end)
		local RespiratorInfo = FetchInfo("Respirator", RespiratorTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("Respirator", RespiratorTier)
		GadgetDisplay.Cost.Text = RespiratorInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. RespiratorInfo.Quirk
		GadgetDisplay.Info2.Text = RespiratorInfo.Information
		GadgetDisplay.Buy.Visible = true
		if RespiratorTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if RespiratorTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Respirator")
		end)
	end
end)

Speakers.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	Speakers.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("Speakers")
			InfoPanel.Visible = true
		end)
		local SpeakersInfo = FetchInfo("Speakers", SpeakersTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("Speakers", SpeakersTier)
		GadgetDisplay.Cost.Text = SpeakersInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. SpeakersInfo.Quirk
		GadgetDisplay.Info2.Text = SpeakersInfo.Information
		GadgetDisplay.Buy.Visible = true
		if SpeakersTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if SpeakersTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("Speakers")
		end)
	end
end)

LaserBelt.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	LaserBelt.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("LaserBelt")
			InfoPanel.Visible = true
		end)
		local LaserBeltInfo = FetchInfo("LaserBelt", LaserBeltTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("LaserBelt", LaserBeltTier)
		GadgetDisplay.Cost.Text = LaserBeltInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. LaserBeltInfo.Quirk
		GadgetDisplay.Info2.Text = LaserBeltInfo.Information
		GadgetDisplay.Buy.Visible = true
		if LaserBeltTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if LaserBeltTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("LaserBelt")
		end)
	end
end)

ThirteenGloves.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	ThirteenGloves.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "Damage Multipliers"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("ThirteenGloves")
			InfoPanel.Visible = true
		end)
		local ThirteenGlovesInfo = FetchInfo("ThirteenGloves", ThirteenGlovesTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("ThirteenGloves", ThirteenGlovesTier)
		GadgetDisplay.Cost.Text = ThirteenGlovesInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. ThirteenGlovesInfo.Quirk
		GadgetDisplay.Info2.Text = ThirteenGlovesInfo.Information
		GadgetDisplay.Buy.Visible = true
		if ThirteenGlovesTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if ThirteenGlovesTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("ThirteenGloves")
		end)
	end
end)

MetalBrace.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	MetalBrace.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("MetalBrace")
			InfoPanel.Visible = true
		end)
		local MetalBraceInfo = FetchInfo("MetalBrace", MetalBraceTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("MetalBrace", MetalBraceTier)
		GadgetDisplay.Cost.Text = MetalBraceInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. MetalBraceInfo.Quirk
		GadgetDisplay.Info2.Text = MetalBraceInfo.Information
		GadgetDisplay.Buy.Visible = true
		if MetalBraceTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if MetalBraceTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("MetalBrace")
		end)
	end
end)

OverhaulMask.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	OverhaulMask.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("OverhaulMask")
			InfoPanel.Visible = true
		end)
		local OverhaulMaskInfo = FetchInfo("OverhaulMask", OverhaulMaskTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("OverhaulMask", OverhaulMaskTier)
		GadgetDisplay.Cost.Text = OverhaulMaskInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. OverhaulMaskInfo.Quirk
		GadgetDisplay.Info2.Text = OverhaulMaskInfo.Information
		GadgetDisplay.Buy.Visible = true
		if OverhaulMaskTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if OverhaulMaskTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("OverhaulMask")
		end)
	end
end)

HHHCVest.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	HHHCVest.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("HHHCVest")
			InfoPanel.Visible = true
		end)
		local HHHCVestInfo = FetchInfo("HHHCVest", HHHCVestTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("HHHCVest", HHHCVestTier)
		GadgetDisplay.Cost.Text = HHHCVestInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. HHHCVestInfo.Quirk
		GadgetDisplay.Info2.Text = HHHCVestInfo.Information
		GadgetDisplay.Buy.Visible = true
		if HHHCVestTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if HHHCVestTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("HHHCVest")
		end)
	end
end)

FrogSuit.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
	for i=1,#Gadgets do
		Gadgets[i].SelectOutline.Visible = false
	end
	FrogSuit.SelectOutline.Visible = true
	GadgetDisplay.Visible = true
	local function UpdateGUI()
		InfoButton.Text = "More Information"
		if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
		GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
			ClickSound:Play()
			GadgetMenu.Visible = false
			InfoChange("FrogSuit")
			InfoPanel.Visible = true
		end)
		local FrogSuitInfo = FetchInfo("FrogSuit", FrogSuitTier)
		GadgetDisplay.ImageLabel.Image = FetchImage("FrogSuit", FrogSuitTier)
		GadgetDisplay.Cost.Text = FrogSuitInfo.Cost
		GadgetDisplay.Upgrade.Text = "Quirk: ".. FrogSuitInfo.Quirk
		GadgetDisplay.Info2.Text = FrogSuitInfo.Information
		GadgetDisplay.Buy.Visible = true
		if FrogSuitTier == nil then
			GadgetDisplay.Buy.Text = "Purchase"
		else
			GadgetDisplay.Buy.Visible = false
		end
	end
	UpdateGUI()
	if FrogSuitTier == nil then
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if PurchaseCooldown then return end
			BuyCool()
			Purchasing = true
			ClickSound:Play()
			GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm)
				if confirm then
					PurchaseSuccess:Play()
					UpdateGUI()
				else
					PurchaseFail:Play()
					for i=1,3 do
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
						wait(.06)
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
						wait(.06)
					end
					GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
				end
				GadgetConfirmConnection:Disconnect()
				Purchasing = false
			end)
			ItemRemote:FireServer("FrogSuit")
		end)
	end
end)

local function Update(item, tier)
	if item == "Dagger" then
		DaggerTier = tier
		Dagger.Image = FetchImage("Dagger", DaggerTier)
	elseif item == "Katana" then
		KatanaTier = tier
		Katana.Image = FetchImage("Katana", KatanaTier)
	elseif item == "Pistol" then
		PistolTier = tier
		Pistol.Image = FetchImage("Pistol", PistolTier)
	elseif item == "Gauntlet" then
		GauntletTier = tier
		Gauntlet.Image = FetchImage("Gauntlet", GauntletTier)
	elseif item == "ShadowCape" then
		ShadowCapeTier = tier
		ShadowCape.Image = FetchImage("ShadowCape", ShadowCapeTier)
	elseif item == "IronSole" then
		SolesTier = tier
		Soles.Image = FetchImage("IronSole", SolesTier)
	elseif item == "GiantHorn" then
		GiantHornTier = tier
		GiantHorn.Image = FetchImage("GiantHorn", GiantHornTier)
	elseif item == "HardenGear" then
		HardenGearTier = tier
		HardenGear.Image = FetchImage("HardenGear", HardenGearTier)
	elseif item == "WingHeadphones" then
		WingHeadphonesTier = tier
		WingHeadphones.Image = FetchImage("WingHeadphones", WingHeadphonesTier)
	elseif item == "HellFlameArmor" then
		HellFlameArmorTier = tier
		HellFlameArmor.Image = FetchImage("HellFlameArmor", HellFlameArmorTier)
	elseif item == "JetBoots" then
		JetBootsTier = tier
		JetBoots.Image = FetchImage("JetBoots", JetBootsTier)
	elseif item == "PermeationCape" then
		PermeationCapeTier = tier
		PermeationCape.Image = FetchImage("PermeationCape", PermeationCapeTier)
	elseif item == "EngineBoots" then
		EngineBootsTier = tier
		EngineBoots.Image = FetchImage("EngineBoots", EngineBootsTier)
	elseif item == "SharpShootingGear" then
		SharpShooterTier = tier
		SharpShooter.Image = FetchImage("SharpShootingGear", SharpShooterTier)
	elseif item == "Respirator" then
		RespiratorTier = tier
		Respirator.Image = FetchImage("Respirator", RespiratorTier)
	elseif item == "Speakers" then
		SpeakersTier = tier
		Speakers.Image = FetchImage("Speakers", SpeakersTier)
	elseif item == "LaserBelt" then
		LaserBeltTier = tier
		LaserBelt.Image = FetchImage("LaserBelt", LaserBeltTier)
	elseif item == "ThirteenGloves" then
		ThirteenGlovesTier = tier
		ThirteenGloves.Image = FetchImage("ThirteenGloves", ThirteenGlovesTier)
	elseif item == "MetalBrace" then
		MetalBraceTier = tier
		MetalBrace.Image = FetchImage("MetalBrace", MetalBraceTier)
	elseif item == "OverhaulMask" then
		OverhaulMaskTier = tier
		OverhaulMask.Image = FetchImage("OverhaulMask", OverhaulMaskTier)
	elseif item == "HHHCVest" then
		HHHCVestTier = tier
		HHHCVest.Image = FetchImage("HHHCVest", HHHCVestTier)
	elseif item == "FrogSuit" then
		FrogSuitTier = tier
		FrogSuit.Image = FetchImage("FrogSuit", FrogSuitTier)
	end
end

ItemRemote.OnClientEvent:Connect(Update)
ItemRemote:FireServer("LoadItem")

WeaponFrame.Button.MouseButton1Click:Connect(function()
	if WeaponMenu.Visible == false then
		ClickSound:Play()
		InfoPanel.Visible = false
		GadgetMenu.Visible = false
		GadgetFrame.ImageTransparency = 0
		WeaponMenu.Visible = true
		WeaponFrame.ImageTransparency = .2
	end
end)

GadgetFrame.Button.MouseButton1Click:Connect(function()
	if GadgetMenu.Visible == false then
		ClickSound:Play()
		InfoPanel.Visible = false
		WeaponMenu.Visible = false
		WeaponFrame.ImageTransparency = 0
		GadgetMenu.Visible = true
		GadgetFrame.ImageTransparency = .2
	end
end)
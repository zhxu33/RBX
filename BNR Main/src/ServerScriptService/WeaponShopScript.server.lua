local ItemRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Item")
local ConfirmRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Confirm")
local EquipRemote = game.ReplicatedStorage.WeaponShop.Equip
local DataStore = game:GetService("DataStoreService")
local ItemsStore = DataStore:GetDataStore("Items")

ItemRemote.OnServerEvent:Connect(function(Player,item)
	local plr = game.Players:FindFirstChild(Player.Name)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
	local PlayerItems = ItemsStore:GetAsync(Player.UserId)
	local ItemsTable = {["Katana"] = false, ["Pistol"] = false, ["Dagger"] = false, ["Gauntlet"] = false, ["ShadowCape"] = false, ["IronSole"] = false,
		["PumpkinPistol"] = false, ["SnowSword"] = false, ["HalloweenScythe"] = false, ["CandyCaneGun"] = false, ["SantaArmor"] = false, 
		["PumpkinArmor"] = false, ["EasterStaff"] = false, ["EasterKatana"] = false, ["BunnyEars"] = false}
	if PlayerItems ~= nil then
		ItemsTable = PlayerItems
	end
	if not PlayerData:FindFirstChild("Buying") then
		local Buying = Instance.new("NumberValue", PlayerData)
		Buying.Name = "Buying" 
		if item == "LoadItem" then
			if PlayerItems ~= nil then
				for ItemName, Val in pairs(ItemsTable) do
					if Val ~= false then
						ItemRemote:FireClient(plr,ItemName, Val)
					end
				end
			end
		elseif item == "GiantHorn" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.GiantHorn == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.GiantHorn = 1
				ItemRemote:FireClient(plr, "GiantHorn",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "FrogSuit" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 75000 and ItemsTable.FrogSuit == nil then
				Cash.Value = Cash.Value - 75000
				ItemsTable.FrogSuit = 1
				ItemRemote:FireClient(plr,"FrogSuit",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "OverhaulMask" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 100000 and ItemsTable.OverhaulMask == nil then
				Cash.Value = Cash.Value - 100000
				ItemsTable.OverhaulMask = 1
				ItemRemote:FireClient(plr,"OverhaulMask",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "HHHCVest" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 100000 and ItemsTable.HHHCVest == nil then
				Cash.Value = Cash.Value - 100000
				ItemsTable.HHHCVest = 1
				ItemRemote:FireClient(plr,"HHHCVest",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "Respirator" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 100000 and ItemsTable.Respirator == nil then
				Cash.Value = Cash.Value - 100000
				ItemsTable.Respirator = 1
				ItemRemote:FireClient(plr,"Respirator",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "LaserBelt" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 100000 and ItemsTable.LaserBelt == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.LaserBelt = 1
				ItemRemote:FireClient(plr,"LaserBelt",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "Speakers" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.Speakers == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.Speakers = 1
				ItemRemote:FireClient(plr,"Speakers",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "ThirteenGloves" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 75000 and ItemsTable.ThirteenGloves == nil then
				Cash.Value = Cash.Value - 75000
				ItemsTable.ThirteenGloves = 1
				ItemRemote:FireClient(plr,"ThirteenGloves",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		elseif item == "MetalBrace" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 75000 and ItemsTable.MetalBrace == nil then
				Cash.Value = Cash.Value - 75000
				ItemsTable.MetalBrace = 1
				ItemRemote:FireClient(plr,"MetalBrace",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "HardenGear" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.HardenGear == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.HardenGear = 1
				ItemRemote:FireClient(plr, "HardenGear",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "WingHeadphones" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.WingHeadphones == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.WingHeadphones = 1
				ItemRemote:FireClient(plr, "WingHeadphones",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "HellFlameArmor" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.HellFlameArmor == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.HellFlameArmor = 1
				ItemRemote:FireClient(plr, "HellFlameArmor",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "JetBoots" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.JetBoots == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.JetBoots = 1
				ItemRemote:FireClient(plr, "JetBoots",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "PermeationCape" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.PermeationCape == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.PermeationCape = 1
				ItemRemote:FireClient(plr, "PermeationCape",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "EngineBoots" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.EngineBoots == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.EngineBoots = 1
				ItemRemote:FireClient(plr, "EngineBoots",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "Gauntlet" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.Gauntlet == false then
				Cash.Value = Cash.Value - 50000
				ItemsTable.Gauntlet = 1
				ItemRemote:FireClient(plr, "Gauntlet",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)	
			end
		elseif item == "SharpShootingGear" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 50000 and ItemsTable.SharpShootingGear == nil then
				Cash.Value = Cash.Value - 50000
				ItemsTable.SharpShootingGear = 1
				ItemRemote:FireClient(plr, "SharpShootingGear",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		elseif item == "ShadowCape" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 40000 and ItemsTable.ShadowCape == false then
				Cash.Value = Cash.Value - 40000
				ItemsTable.ShadowCape = 1
				ItemRemote:FireClient(plr, "ShadowCape",1)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		elseif item == "IronSole" then
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 75000 and ItemsTable.IronSole == false then
				Cash.Value = Cash.Value - 75000
				ItemsTable.IronSole = 1
				ItemRemote:FireClient(plr, "IronSole",1)
				ConfirmRemote:FireClient(Player, true)
			elseif Cash.Value >= 100000 and ItemsTable.IronSole == 1 then
				Cash.Value = Cash.Value - 100000
				ItemsTable.IronSole = 2
				ItemRemote:FireClient(plr, "IronSole",2)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		elseif item == "Pistol" then 
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 20000 and ItemsTable.Pistol == false then
				Cash.Value = Cash.Value - 20000
				ItemsTable.Pistol = 1
				ItemRemote:FireClient(plr, "Pistol",1)
				ConfirmRemote:FireClient(Player, true)	
			elseif Cash.Value >= 30000 and ItemsTable.Pistol == 1 then
				Cash.Value = Cash.Value - 30000
				ItemsTable.Pistol = 2
				ItemRemote:FireClient(plr, "Pistol",2)
				ConfirmRemote:FireClient(Player, true)
			elseif Cash.Value >= 50000 and ItemsTable.Pistol == 2 then
				Cash.Value = Cash.Value - 50000
				ItemsTable.Pistol = 3
				ItemRemote:FireClient(plr, "Pistol",3)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		elseif item == "Katana" then 
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 15000 and ItemsTable.Katana == false then
				Cash.Value = Cash.Value - 15000 
				ItemsTable.Katana = 1
				ItemRemote:FireClient(plr, "Katana", 1)
				ConfirmRemote:FireClient(Player, true)
			elseif Cash.Value >= 20000 and ItemsTable.Katana == 1 then
				Cash.Value = Cash.Value - 20000
				ItemsTable.Katana = 2
				ItemRemote:FireClient(plr, "Katana", 2)
				ConfirmRemote:FireClient(Player, true)
			elseif Cash.Value >= 30000 and ItemsTable.Katana == 2 then
				Cash.Value = Cash.Value - 30000
				ItemsTable.Katana = 3
				ItemRemote:FireClient(plr, "Katana", 3)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		elseif item == "Dagger" then 
			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if Cash.Value >= 10000 and ItemsTable.Dagger == false then
				Cash.Value = Cash.Value - 10000 
				ItemsTable.Dagger = 1
				ItemRemote:FireClient(plr, "Dagger", 1)
				ConfirmRemote:FireClient(Player, true)
			elseif Cash.Value >= 15000 and ItemsTable.Dagger == 1 then
				Cash.Value = Cash.Value - 15000 
				ItemsTable.Dagger = 2
				ItemRemote:FireClient(plr, "Dagger", 2)
				ConfirmRemote:FireClient(Player, true)
			elseif Cash.Value >= 25000 and ItemsTable.Dagger == 2 then
				Cash.Value = Cash.Value - 25000 
				ItemsTable.Dagger = 3
				ItemRemote:FireClient(plr, "Dagger", 3)
				ConfirmRemote:FireClient(Player, true)
			else
				ConfirmRemote:FireClient(Player, false)
			end
		end
		ItemsStore:SetAsync(Player.UserId, ItemsTable)
		Buying:Destroy()
	end
end)


local function unequip(Character)
	if Character:FindFirstChild("Attack").Value == true then
		repeat wait() until Character:FindFirstChild("Attack").Value == false
	end
	local WeaponType = Character:FindFirstChild("WeaponType")
	local plr = game.Players:GetPlayerFromCharacter(Character)
	if WeaponType.Value == "Pistol" then
		Character.RightHand:FindFirstChild("Pistol"):Destroy()
		if Character.LeftHand:FindFirstChild("Pistol") then
			Character.LeftHand:FindFirstChild("Pistol"):Destroy()
		end
	elseif WeaponType.Value == "Katana" then
		Character.RightHand:FindFirstChild("Katana"):Destroy()
	elseif WeaponType.Value == "Dagger" then
		Character.RightHand:FindFirstChild("Dagger"):Destroy()
	elseif WeaponType.Value == "HalloweenScythe" then
		Character.RightHand:FindFirstChild("HalloweenScythe"):Destroy()
		if Character.LeftHand:FindFirstChild("HalloweenScythe") then
			Character.LeftHand:FindFirstChild("HalloweenScythe"):Destroy()
		end
	elseif WeaponType.Value == "CursedGlove" then
		if Character.RightHand:FindFirstChild("CursedGlove") then
			Character.RightHand:FindFirstChild("CursedGlove"):Destroy()
		end
		if Character.LeftHand:FindFirstChild("CursedGlove") then
			Character.LeftHand:FindFirstChild("CursedGlove"):Destroy()
		end
	elseif WeaponType.Value == "GhastSword" then
		if Character.RightHand:FindFirstChild("GhastlySword") then
			Character.RightHand:FindFirstChild("GhastlySword"):Destroy()
		end
	elseif WeaponType.Value == "SnowSword" then
		Character.RightHand:FindFirstChild("SnowSword"):Destroy()
		if Character.LeftHand:FindFirstChild("SnowSword") then
			Character.LeftHand:FindFirstChild("SnowSword"):Destroy()
		end
	elseif WeaponType.Value == "PumpkinPistol" then
		Character.RightHand:FindFirstChild("PumpkinPistol"):Destroy()
		Character.LeftHand:FindFirstChild("PumpkinPistol"):Destroy()
	elseif WeaponType.Value == "CandyCaneGun" then
		Character.RightHand:FindFirstChild("CandyCaneGun"):Destroy()
		Character.LeftHand:FindFirstChild("CandyCaneGun"):Destroy()
	elseif WeaponType.Value == "EasterStaff" then
		Character.RightHand:FindFirstChild("EasterStaff"):Destroy()
	elseif WeaponType.Value == "EasterKatana" then
		Character.RightHand:FindFirstChild("EasterKatana"):Destroy()
		if Character.LeftHand:FindFirstChild("EasterKatana") then
			Character.LeftHand:FindFirstChild("EasterKatana"):Destroy()
		end
	elseif WeaponType.Value == "IceSickle" then
		Character.RightHand:FindFirstChild("IceSickle"):Destroy()
	elseif WeaponType.Value == "PeppermintSaber" then
		Character.RightHand:FindFirstChild("PeppermintSaber"):Destroy()
	elseif WeaponType.Value == "OrnamentBlaster" then
		Character.RightHand:FindFirstChild("OrnamentBlaster"):Destroy()
		Character.LeftHand:FindFirstChild("OrnamentBlaster"):Destroy()
	elseif WeaponType.Value == "EasterSword" then
		Character:FindFirstChild("EasterSword"):Destroy()
	elseif WeaponType.Value == "EasterFlintlock" then
		Character:FindFirstChild("EasterFlintlock"):Destroy()
	elseif WeaponType.Value == "EasterWand" then
		Character:FindFirstChild("EasterWand"):Destroy()
	elseif WeaponType.Value == "EasterGrimoire" then
		Character:FindFirstChild("EasterGrimoire"):Destroy()
	elseif WeaponType.Value == "EasterBow" then
		Character:FindFirstChild("EasterBow"):Destroy()
	elseif WeaponType.Value == "BanHammer" then
		Character.RightHand:FindFirstChild("BanHammer"):Destroy()
	end
	WeaponType.Value = "N/A"
	EquipRemote:FireClient(plr,"Unequip")
end

local function unequip2(Character)
	repeat wait() until Character:FindFirstChild("Attack").Value == false
	local ToolType = Character:FindFirstChild("ToolType")
	local plr = game.Players:GetPlayerFromCharacter(Character)
	if ToolType.Value == "Gauntlet" then
		Character.LeftUpperArm:FindFirstChild("ExplosionGauntlet"):Destroy()
		Character.RightUpperArm:FindFirstChild("ExplosionGauntlet"):Destroy()
	elseif ToolType.Value == "SharpShootingGear" then
		Character.RightLowerArm:FindFirstChild("SharpShootingGear"):Destroy()
	elseif ToolType.Value == "ShadowCape" then
		Character:FindFirstChild("ShadowCape"):Destroy()
	elseif ToolType.Value == "HardenGear" then
		Character:FindFirstChild("HardenGear"):Destroy()
	elseif ToolType.Value == "WingHeadphones" then
		Character:FindFirstChild("WingHeadphones"):Destroy()
	elseif ToolType.Value == "GiantHorn" then
		Character:FindFirstChild("GiantHorn"):Destroy()
	elseif ToolType.Value == "HellFlameArmor" then
		Character:FindFirstChild("HellFlameArmor"):Destroy()
	elseif ToolType.Value == "JetBoots" then
		Character:FindFirstChild("JetBoots"):Destroy()
	elseif ToolType.Value == "PermeationCape" then
		Character:FindFirstChild("PermeationCape"):Destroy()
	elseif ToolType.Value == "EngineBoots" then
		Character:FindFirstChild("EngineBoots"):Destroy()
	elseif ToolType.Value == "LaserBelt" then
		Character:FindFirstChild("LaserBelt"):Destroy()
	elseif ToolType.Value == "Respirator" then
		Character:FindFirstChild("Respirator"):Destroy()
	elseif ToolType.Value == "Speakers" then
		Character:FindFirstChild("Speakers"):Destroy()
	elseif ToolType.Value == "ThirteenGloves" then
		Character:FindFirstChild("ThirteenGloves"):Destroy()
	elseif ToolType.Value == "OverhaulMask" then
		Character:FindFirstChild("OverhaulMask"):Destroy()
	elseif ToolType.Value == "HHHCVest" then
		Character:FindFirstChild("HHHCVest"):Destroy()
	elseif ToolType.Value == "FrogSuit" then
		Character:FindFirstChild("FrogSuit"):Destroy()
	elseif ToolType.Value == "MetalBrace" then
		Character:FindFirstChild("MetalBrace"):Destroy()
	elseif ToolType.Value == "IronSole" then
		Character:FindFirstChild("IronSole"):Destroy()
		Character:FindFirstChild("IronSole2"):Destroy()
		if Character:FindFirstChild("AirForceGlove") and Character:FindFirstChild("AirForceGlove2") then
			Character:FindFirstChild("AirForceGlove"):Destroy()
			Character:FindFirstChild("AirForceGlove2"):Destroy()
		end
	elseif ToolType.Value == "GhastArmor" then
		Character:FindFirstChild("GhastArmor"):Destroy()
		for v,parts in pairs(Character:GetDescendants()) do
			if parts:IsA("IntValue") and parts.Name == "TranVal" then
				parts.Parent.Transparency = parts.Value
				parts:Destroy()
			end
		end
	elseif ToolType.Value == "SantaArmor" then
		Character:FindFirstChild("SantaArmor"):Destroy()
	elseif ToolType.Value == "PumpkinArmor" then
		Character:FindFirstChild("PumpkinArmor"):Destroy()
	elseif ToolType.Value == "BunnyEars" then
		Character:FindFirstChild("BunnyEars"):Destroy()
	elseif ToolType.Value == "FestiveLights" then
		Character:FindFirstChild("FestiveLights"):Destroy()
	elseif ToolType.Value == "EggPauldron" then
		Character:FindFirstChild("EggPauldron"):Destroy()
	end
	ToolType.Value = "N/A"
	EquipRemote:FireClient(plr,"Unequip2")
end

game.ReplicatedStorage.Remotes.Equips.Unequip.Event:Connect(unequip)

EquipRemote.OnServerEvent:Connect(function(Player,item)
	local plr = game.Players:FindFirstChild(Player.Name)
	repeat wait() until plr.Character:FindFirstChild("Attack").Value == false
	local PlayerItems = ItemsStore:GetAsync(Player.UserId)
	if item == "Katana" and Player.Character:FindFirstChild("WeaponType").Value ~= "Katana" and PlayerItems.Katana ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.Katana
		unequip(Player.Character)
		WeaponType.Value = "Katana"
		if Val == 1 then
			--[[
			local sword = game.ServerStorage.Weapons.Katana:Clone()
			sword.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", sword.Handle)
			weld.Part0 = sword.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			local Sword = game.ServerStorage.Weapons.NewKatana2:Clone()
			Sword.Name = "Katana"
			Sword.Parent = Player.Character.RightHand
			Sword.Handle.Hold.Part1 = Player.Character.RightHand
			Sword.Cover.Cover.Hold.Part1 = Player.Character.LowerTorso
			]]
			local Sword = game.ServerStorage.Weapons.NewKatana1:Clone()
			Sword.Name = "Katana"
			Sword.Parent = Player.Character.RightHand
			Sword.Handle.Hold.Part1 = Player.Character.RightHand
			Sword.Cover.Cover.Hold.Part1 = Player.Character.LowerTorso
		elseif Val == 2 then
			--[[
			local sword = game.ServerStorage.Weapons.Katana2:Clone()
			sword.Name = "Katana"
			sword.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", sword.Handle)
			weld.Part0 = sword.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(-20),math.rad(0),math.rad(0))
			]]
			local Sword = game.ServerStorage.Weapons.NewKatana2:Clone()
			Sword.Name = "Katana"
			Sword.Parent = Player.Character.RightHand
			Sword.Handle.Hold.Part1 = Player.Character.RightHand
			Sword.Cover.Cover.Hold.Part1 = Player.Character.LowerTorso
		elseif Val == 3 then
			--[[
			local sword = game.ServerStorage.Weapons.Katana3:Clone()
			sword.Name = "Katana"
			sword.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", sword.Handle)
			weld.Part0 = sword.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))
			]]
			local Sword = game.ServerStorage.Weapons.NewKatana3:Clone()
			Sword.Name = "Katana"
			Sword.Parent = Player.Character.RightHand
			Sword.Handle.Hold.Part1 = Player.Character.RightHand
			Sword.Cover.Cover.Hold.Part1 = Player.Character.LowerTorso
		end	
		EquipRemote:FireClient(plr,"Katana", Val)
	elseif item == "Dagger" and Player.Character:FindFirstChild("WeaponType").Value ~= "Dagger" and PlayerItems.Dagger ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.Dagger
		unequip(Player.Character)
		WeaponType.Value = "Dagger"
		if Val == 1 then
			--[[
			local Dagger = game.ServerStorage.Weapons.Dagger:Clone()
			Dagger.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", Dagger.Handle)
			weld.Part0 = Dagger.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(-90),math.rad(90))
			]]
			local Dagger = game.ServerStorage.Weapons.NewDagger1:Clone()
			Dagger.Parent = Player.Character.RightHand
			Dagger.Name = "Dagger"
			Dagger.Grip.Hold.Part1 = Player.Character.RightHand
		elseif Val == 2 then
			--[[
			local Dagger = game.ServerStorage.Weapons.Dagger2:Clone()
			Dagger.Name = "Dagger"
			Dagger.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", Dagger.Handle)
			weld.Part0 = Dagger.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(-90),math.rad(-90),math.rad(90))
			]]
			local Dagger = game.ServerStorage.Weapons.NewDagger2:Clone()
			Dagger.Parent = Player.Character.RightHand
			Dagger.Name = "Dagger"
			Dagger.Grip.Hold.Part1 = Player.Character.RightHand
		elseif Val == 3 then
			--[[
			local Dagger = game.ServerStorage.Weapons.Dagger3:Clone()
			Dagger.Name = "Dagger"
			Dagger.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", Dagger.Handle)
			weld.Part0 = Dagger.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(-90),math.rad(90))
			]]
			local Dagger = game.ServerStorage.Weapons.NewDagger3:Clone()
			Dagger.Parent = Player.Character.RightHand
			Dagger.Name = "Dagger"
			Dagger.Handle.Hold.Part1 = Player.Character.RightHand
		end
		EquipRemote:FireClient(plr,"Dagger", Val)
	elseif item == "Pistol" and Player.Character:FindFirstChild("WeaponType").Value ~= "Pistol" and PlayerItems.Pistol ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.Pistol
		unequip(Player.Character)
		WeaponType.Value = "Pistol"
		if Val == 1 then
			--[[
			local Pistol = game.ServerStorage.Weapons.Pistol:Clone()
			Pistol.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", Pistol.Handle)
			weld.Part0 = Pistol.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(270),math.rad(180),math.rad(90)) ]]
			local Pistol = game.ServerStorage.Weapons.NewGun1:Clone()
			Pistol.Parent = Player.Character.RightHand
			Pistol.Handle.Hold.Part1 = Player.Character.RightHand
			Pistol.Name = "Pistol"
		elseif Val == 2 then
			--[[
			local Pistol = game.ServerStorage.Weapons.Pistol2:Clone()
			Pistol.Name = "Pistol"
			Pistol.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", Pistol.Handle)
			weld.Part0 = Pistol.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(-90),math.rad(-180),math.rad(270)) ]]
			local Pistol = game.ServerStorage.Weapons.NewGun2:Clone()
			Pistol.Parent = Player.Character.RightHand
			Pistol.Handle.Hold.Part1 = Player.Character.RightHand
			Pistol.Name = "Pistol"
		elseif Val == 3 then
			--[[
			local Pistol = game.ServerStorage.Weapons.Pistol2:Clone()
			Pistol.Name = "Pistol"
			Pistol.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", Pistol.Handle)
			weld.Part0 = Pistol.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(-90),math.rad(-180),math.rad(270))
			local Pistol2 = game.ServerStorage.Weapons.Pistol2:Clone()
			Pistol2.Name = "Pistol"
			Pistol2.Parent = Player.Character.LeftHand
			local weld2 = Instance.new("Weld", Pistol2.Handle)
			weld2.Part0 = Pistol2.Handle
			weld2.Part1 = Player.Character.LeftHand
			weld2.C0 = weld2.C0*CFrame.Angles(math.rad(-90),math.rad(-180),math.rad(270)) ]]
			local Pistol = game.ServerStorage.Weapons.NewGun3:Clone()
			Pistol.Parent = Player.Character.RightHand
			Pistol.Handle.Hold.Part1 = Player.Character.RightHand
			Pistol.Name = "Pistol"
			local Pistol = game.ServerStorage.Weapons.NewGun3:Clone()
			Pistol.Parent = Player.Character.LeftHand
			Pistol.Handle.Hold.Part1 = Player.Character.LeftHand
			Pistol.Name = "Pistol"
		end
		EquipRemote:FireClient(plr,"Pistol", Val)
	elseif item == "Gauntlet" and Player.Character:FindFirstChild("ToolType") ~= "Gauntlet" and PlayerItems.Gauntlet ~= false then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "Gauntlet"
		local LeftGauntlet = game.ServerStorage.Gadgets.ExplosionGauntlet:Clone()
		LeftGauntlet.Parent = Player.Character.LeftUpperArm
		local RightGauntlet = game.ServerStorage.Gadgets.ExplosionGauntlet:Clone()
		RightGauntlet.Parent = Player.Character.RightUpperArm
		local LeftWeld = Instance.new("Weld",LeftGauntlet.Main)
		LeftWeld.Part0 = LeftGauntlet.Main
		LeftWeld.Part1 = Player.Character.LeftLowerArm
		LeftWeld.C0 = LeftWeld.C0*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
		local RightWeld = Instance.new("Weld",RightGauntlet.Main)
		RightWeld.Part0 = RightGauntlet.Main
		RightWeld.Part1 = Player.Character.RightLowerArm
		RightWeld.C0 = RightWeld.C0*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		EquipRemote:FireClient(plr,"Gauntlet")
	elseif item == "GiantHorn" and Player.Character:FindFirstChild("ToolType") ~= "GiantHorn" and PlayerItems.GiantHorn ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "GiantHorn"
		local GiantHorn = game.ServerStorage.Gadgets.GiantHorn:Clone()
		Player.Character.Humanoid:AddAccessory(GiantHorn)
		GiantHorn.Parent = Player.Character
		EquipRemote:FireClient(plr,"GiantHorn")
	elseif item == "HardenGear" and Player.Character:FindFirstChild("ToolType") ~= "HardenGear" and PlayerItems.HardenGear ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "HardenGear"
		local HardenGear = game.ServerStorage.Gadgets.HardenGear:Clone()
		HardenGear.Parent = Player.Character
		local Weld = Instance.new("Weld",HardenGear.LowerTorso)
		Weld.Part0 = HardenGear.LowerTorso
		Weld.Part1 = Player.Character.LowerTorso
		local Weld2 = Instance.new("Weld",HardenGear.UpperTorso)
		Weld2.Part0 = HardenGear.UpperTorso
		Weld2.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr,"HardenGear")
	elseif item == "WingHeadphones" and Player.Character:FindFirstChild("ToolType") ~= "WingHeadphones" and PlayerItems.WingHeadphones ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "WingHeadphones"
		local WingHeadphones = game.ServerStorage.Gadgets.WingHeadphones:Clone()
		WingHeadphones.Parent = Player.Character
		local Weld = Instance.new("Weld",WingHeadphones.Head)
		Weld.Part0 = WingHeadphones.Head
		Weld.Part1 = Player.Character.Head
		EquipRemote:FireClient(plr,"WingHeadphones")
	elseif item == "HellFlameArmor" and Player.Character:FindFirstChild("ToolType") ~= "HellFlameArmor" and PlayerItems.HellFlameArmor ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "HellFlameArmor"
		local HellFlameArmor = game.ServerStorage.Gadgets.HellFlameArmor:Clone()
		HellFlameArmor.Parent = Player.Character
		local Weld = Instance.new("Weld",HellFlameArmor.LeftLowerArm)
		Weld.Part0 = HellFlameArmor.LeftLowerArm
		Weld.Part1 = Player.Character.LeftLowerArm
		local Weld2 = Instance.new("Weld",HellFlameArmor.RightUpperArm)
		Weld2.Part0 = HellFlameArmor.RightUpperArm
		Weld2.Part1 = Player.Character.RightUpperArm
		local Weld3 = Instance.new("Weld",HellFlameArmor.RightLowerArm)
		Weld3.Part0 = HellFlameArmor.RightLowerArm
		Weld3.Part1 = Player.Character.RightLowerArm
		local Weld4 = Instance.new("Weld",HellFlameArmor.LeftUpperArm)
		Weld4.Part0 = HellFlameArmor.LeftUpperArm
		Weld4.Part1 = Player.Character.LeftUpperArm
		EquipRemote:FireClient(plr,"HellFlameArmor")
	elseif item == "JetBoots" and Player.Character:FindFirstChild("ToolType") ~= "JetBoots" and PlayerItems.JetBoots ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "JetBoots"
		local JetBoots = game.ServerStorage.Gadgets.JetBoots:Clone()
		JetBoots.Parent = Player.Character
		local Weld = Instance.new("Weld",JetBoots.LeftLowerLeg)
		Weld.Part0 = JetBoots.LeftLowerLeg
		Weld.Part1 = Player.Character.LeftLowerLeg
		local Weld2 = Instance.new("Weld",JetBoots.RightLowerLeg)
		Weld2.Part0 = JetBoots.RightLowerLeg
		Weld2.Part1 = Player.Character.RightLowerLeg
		local Weld3 = Instance.new("Weld",JetBoots.UpperTorso)
		Weld3.Part0 = JetBoots.UpperTorso
		Weld3.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr,"JetBoots")
	elseif item == "PermeationCape" and Player.Character:FindFirstChild("ToolType") ~= "PermeationCape" and PlayerItems.PermeationCape ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "PermeationCape"
		local PermeationCape = game.ServerStorage.Gadgets.PermeationCape:Clone()
		PermeationCape.Parent = Player.Character
		local Weld = Instance.new("Weld",PermeationCape.LowerTorso)
		Weld.Part0 = PermeationCape.LowerTorso
		Weld.Part1 = Player.Character.LowerTorso
		local Weld2 = Instance.new("Weld",PermeationCape.UpperTorso)
		Weld2.Part0 = PermeationCape.UpperTorso
		Weld2.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr,"PermeationCape")
	elseif item == "OverhaulMask" and Player.Character:FindFirstChild("ToolType") ~= "OverhaulMask" and PlayerItems.OverhaulMask ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "OverhaulMask"
		local OverhaulMask = game.ServerStorage.Gadgets.OverhaulMask:Clone()
		OverhaulMask.Parent = Player.Character
		OverhaulMask.Head.Handle.Part1 = Player.Character.Head
		EquipRemote:FireClient(plr, "OverhaulMask")
	elseif item == "HHHCVest" and Player.Character:FindFirstChild("ToolType") ~= "HHHCVest" and PlayerItems.HHHCVest ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "HHHCVest"
		local HHHCVest = game.ServerStorage.Gadgets.HHHCVest:Clone()
		HHHCVest.Parent = Player.Character
		HHHCVest.UpperTorso.Handle.Part1 = Player.Character.UpperTorso
		HHHCVest.LowerTorso.Handle.Part1 = Player.Character.LowerTorso
		EquipRemote:FireClient(plr, "HHHCVest")
	elseif item == "FrogSuit" and Player.Character:FindFirstChild("ToolType") ~= "FrogSuit" and PlayerItems.FrogSuit ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "FrogSuit"
		local FrogSuit = game.ServerStorage.Gadgets.FrogSuit:Clone()
		FrogSuit.Parent = Player.Character
		FrogSuit.UpperTorso.Handle.Part1 = Player.Character.UpperTorso
		FrogSuit.LowerTorso.Handle.Part1 = Player.Character.LowerTorso
		FrogSuit.LeftHand.Handle.Part1 = Player.Character.LeftHand
		FrogSuit.RightHand.Handle.Part1 = Player.Character.RightHand
		EquipRemote:FireClient(plr, "FrogSuit")
	elseif item == "Respirator" and Player.Character:FindFirstChild("ToolType") ~= "Respirator" and PlayerItems.Respirator ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "Respirator"
		local Respirator = game.ServerStorage.Gadgets.Respirator:Clone()
		Respirator.Parent = Player.Character
		Respirator.Shield.Hold.Part1 = Player.Character.Head
		EquipRemote:FireClient(plr, "Respirator")
	elseif item == "Speakers" and Player.Character:FindFirstChild("ToolType") ~= "Speakers" and PlayerItems.Speakers ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "Speakers"
		local Speakers = game.ServerStorage.Gadgets.Speakers:Clone()
		Speakers.Parent = Player.Character
		Speakers.HeadHold.Part1 = Player.Character.Head
		Speakers.UpperTorsoHold.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr, "Speakers")
	elseif item == "ThirteenGloves" and Player.Character:FindFirstChild("ToolType") ~= "ThirteenGloves" and PlayerItems.ThirteenGloves ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "ThirteenGloves"
		local ThirteenGloves = game.ServerStorage.Gadgets.ThirteenGloves:Clone()
		ThirteenGloves.Parent = Player.Character
		ThirteenGloves.RightHandHold.Part1 = Player.Character.RightHand
		ThirteenGloves.LeftHandHold.Part1 = Player.Character.LeftHand
		EquipRemote:FireClient(plr, "ThirteenGloves")
	elseif item == "MetalBrace" and Player.Character:FindFirstChild("ToolType") ~= "MetalBrace" and PlayerItems.MetalBrace ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "MetalBrace"
		local MetalBrace = game.ServerStorage.Gadgets.MetalBrace:Clone()
		MetalBrace.Parent = Player.Character
		MetalBrace.HeadHold.Part1 = Player.Character.Head
		EquipRemote:FireClient(plr, "MetalBrace")
	elseif item == "LaserBelt" and Player.Character:FindFirstChild("ToolType") ~= "LaserBelt" and PlayerItems.LaserBelt ~= nil  then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "LaserBelt"
		local LaserBelt = game.ServerStorage.Gadgets.LaserBelt:Clone()
		LaserBelt.Parent = Player.Character
		LaserBelt.LowerTorsoHold.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr, "LaserBelt")
	elseif item == "EngineBoots" and Player.Character:FindFirstChild("ToolType") ~= "EngineBoots" and PlayerItems.EngineBoots ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "EngineBoots"
		local EngineBoots = game.ServerStorage.Gadgets.EngineBoots:Clone()
		EngineBoots.Parent = Player.Character
		local Weld = Instance.new("Weld",EngineBoots.LeftFoot)
		Weld.Part0 = EngineBoots.LeftFoot
		Weld.Part1 = Player.Character.LeftFoot
		local Weld2 = Instance.new("Weld",EngineBoots.RightFoot)
		Weld2.Part0 = EngineBoots.RightFoot
		Weld2.Part1 = Player.Character.RightFoot
		local Weld3 = Instance.new("Weld",EngineBoots.LeftLowerLeg)
		Weld3.Part0 = EngineBoots.LeftLowerLeg
		Weld3.Part1 = Player.Character.LeftLowerLeg
		local Weld4 = Instance.new("Weld",EngineBoots.RightLowerLeg)
		Weld4.Part0 = EngineBoots.RightLowerLeg
		Weld4.Part1 = Player.Character.RightLowerLeg
		EquipRemote:FireClient(plr,"EngineBoots")
	elseif item == "SharpShootingGear" and Player.Character:FindFirstChild("ToolType") ~= "SharpShootingGear" and PlayerItems.SharpShootingGear ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "SharpShootingGear"
		local Gear = game.ServerStorage.Gadgets.SharpShootingGear:Clone()
		Gear.Parent = Player.Character.RightLowerArm
		local Glasses = Gear.FBXImportGeneric
		local GearMain = Gear.mainpart
		local GlassesMain = Glasses.Plane
		local Weld = Instance.new("Weld", GearMain)
		Weld.Part0 = GearMain
		Weld.Part1 = Player.Character.RightLowerArm
		Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		Weld.C0 = Weld.C0*CFrame.new(0,0,0)
		local Weld2 = Instance.new("Weld", GlassesMain)
		Weld2.Part0 = GlassesMain
		Weld2.Part1 = Player.Character.Head
		Weld2.C0 = Weld2.C0*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Weld2.C0 = Weld2.C0*CFrame.new(0,-.275,.55)
		EquipRemote:FireClient(plr,"SharpShootingGear")
	elseif item == "BunnyEars" and Player.Character:FindFirstChild("ToolType") ~= "BunnyEars" and PlayerItems.BunnyEars ~= false then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "BunnyEars"
		local BunnyEars = game.ServerStorage.Gadgets.BunnyEars:Clone()
		BunnyEars.Parent = Player.Character
		local Weld = Instance.new("Weld",BunnyEars)
		Weld.Part0 = BunnyEars.Handle
		Weld.Part1 = Player.Character.Head
		EquipRemote:FireClient(plr,"BunnyEars")
	elseif item == "ShadowCape" and Player.Character:FindFirstChild("ToolType") ~= "ShadowCape" and PlayerItems.ShadowCape ~= false then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "ShadowCape"
		local ShadowCapeClone = game.ServerStorage.Gadgets.ShadowCape:Clone()
		ShadowCapeClone.Parent = Player.Character
		local Weld = Instance.new("Weld",ShadowCapeClone.UpperTorso)
		Weld.Part0 = ShadowCapeClone.UpperTorso
		Weld.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr,"ShadowCape")
	elseif item == "IronSole" and Player.Character:FindFirstChild("ToolType") ~= "IronSole" and PlayerItems.IronSole ~= false then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		local Val = PlayerItems.IronSole
		unequip2(Player.Character)
		ToolType.Value = "IronSole"
		local IronSole1 = game.ServerStorage.Gadgets.IronSole:Clone()
		IronSole1.Parent = Player.Character 
		local LeftWeld1 = Instance.new("Weld", IronSole1.Foot)
		LeftWeld1.Part0 = IronSole1.Foot
		LeftWeld1.Part1 = Player.Character.LeftFoot
		local LeftWeld2 = Instance.new("Weld", IronSole1.UpperLeg)
		LeftWeld2.Part0 = IronSole1.UpperLeg
		LeftWeld2.Part1 = Player.Character.LeftUpperLeg
		local LeftWeld3 = Instance.new("Weld", IronSole1.LowerLeg)
		LeftWeld3.Part0 = IronSole1.LowerLeg
		LeftWeld3.Part1 = Player.Character.LeftLowerLeg
		local IronSole2 = game.ServerStorage.Gadgets.IronSole:Clone()
		IronSole2.Parent = Player.Character 
		IronSole2.Name = "IronSole2"
		local LeftWeld1 = Instance.new("Weld", IronSole2.Foot)
		LeftWeld1.Part0 = IronSole2.Foot
		LeftWeld1.Part1 = Player.Character.RightFoot
		local LeftWeld2 = Instance.new("Weld", IronSole2.UpperLeg)
		LeftWeld2.Part0 = IronSole2.UpperLeg
		LeftWeld2.Part1 = Player.Character.RightUpperLeg
		local LeftWeld3 = Instance.new("Weld", IronSole2.LowerLeg)
		LeftWeld3.Part0 = IronSole2.LowerLeg
		LeftWeld3.Part1 = Player.Character.RightLowerLeg
		if Val == 2 then
			local AirForceGlove1 = game.ServerStorage.Gadgets.AirForceGlove:Clone()
			AirForceGlove1.Parent = Player.Character 
			local LeftWeld1 = Instance.new("Weld", AirForceGlove1.Hand)
			LeftWeld1.Part0 = AirForceGlove1.Hand
			LeftWeld1.Part1 = Player.Character.LeftHand
			local LeftWeld2 = Instance.new("Weld", AirForceGlove1.LowerArm)
			LeftWeld2.Part0 = AirForceGlove1.LowerArm
			LeftWeld2.Part1 = Player.Character.LeftLowerArm
			local AirForceGlove2 = game.ServerStorage.Gadgets.AirForceGlove2:Clone()
			AirForceGlove2.Parent = Player.Character 
			local LeftWeld1 = Instance.new("Weld", AirForceGlove2.Hand)
			LeftWeld1.Part0 = AirForceGlove2.Hand
			LeftWeld1.Part1 = Player.Character.RightHand
			local LeftWeld2 = Instance.new("Weld", AirForceGlove2.LowerArm)
			LeftWeld2.Part0 = AirForceGlove2.LowerArm
			LeftWeld2.Part1 = Player.Character.RightLowerArm
		end
		EquipRemote:FireClient(plr,"IronSole",Val)
	elseif item == "GhastArmor" and Player.Character:FindFirstChild("ToolType") ~= "GhastArmor" and PlayerItems.GhastArmor ~= nil then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "GhastArmor"
		local Val = PlayerItems.GhastArmor
		if Val == 1 then
			if Player.Character.Head.Transparency ~= 1 and not Player.Character.Head:FindFirstChild("TranVal") then
				local TranVal = Instance.new("IntValue", Player.Character.Head)
				TranVal.Name = "TranVal"
				TranVal.Value = Player.Character.Head.Transparency
				Player.Character.Head.Transparency = 0.65
			end
			for v,parts in pairs(Player.Character:GetChildren()) do
				if parts:IsA("Accessory") then
					if parts:FindFirstChild("Handle") and parts.Handle:FindFirstChild("AccessoryWeld") and not parts.Handle:FindFirstChild("TranVal") then
						if parts.Handle.AccessoryWeld.Part1 == Player.Character.Head then
							local TranVal = Instance.new("IntValue", parts.Handle)
							TranVal.Name = "TranVal"
							TranVal.Value = parts.Handle.Transparency
							parts.Handle.Transparency = 0.65
						end
					end
				end
			end
			local Armor = game.ServerStorage.Gadgets.GhastArmor:Clone()
			Armor.Parent = Player.Character
			Armor.GhastHelmet.Weld.Part1 = Player.Character.Head
			Armor.GhastHelmet.Weld.C0 = Armor.GhastHelmet.Weld.C0*CFrame.new(0, -.4, -.075)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest:Destroy()
			Armor.GhastFull:Destroy()
			EquipRemote:FireClient(plr,"GhastArmor",1)
		elseif Val == 2 then
			for v,parts in pairs(Player.Character:GetChildren()) do
				if parts:IsA("BasePart") and (parts.Name == "Head" or parts.Name == "UpperTorso" or parts.Name == "LowerTorso" or parts.Name == "LeftLowerArm" or parts.Name == "LeftUpperArm" or parts.Name == "LeftHand") and not parts:FindFirstChild("TranVal") then
					local TranVal = Instance.new("IntValue", parts)
					TranVal.Name = "TranVal"
					TranVal.Value = parts.Transparency
					parts.Transparency = 0.65
				elseif parts:IsA("Accessory") and not parts.Handle:FindFirstChild("TranVal") then
					local TranVal = Instance.new("IntValue", parts.Handle)
					TranVal.Name = "TranVal"
					TranVal.Value = parts.Handle.Transparency
					parts.Handle.Transparency = 0.65
				end
			end
			local Armor = game.ServerStorage.Gadgets.GhastArmor:Clone()
			Armor.TierValue.Value = 2
			Armor.Parent = Player.Character
			Armor.GhastHelmet.Weld.Part1 = Player.Character.Head
			Armor.GhastHelmet.Weld.C0 = Armor.GhastHelmet.Weld.C0*CFrame.new(0, -.4, -.075)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest.UpperTorso.MainTorso.MainWeld.Part1 = Player.Character.UpperTorso
			Armor.GhastHalfChest.UpperTorso.MainTorso.MainWeld.C0 = Armor.GhastHalfChest.UpperTorso.MainTorso.MainWeld.C0*CFrame.new(0, -.3, 0)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest.LeftLowerArm.MainArmPart.MainWeld.Part1 = Player.Character.LeftLowerArm
			Armor.GhastHalfChest.LeftLowerArm.MainArmPart.MainWeld.C0 = Armor.GhastHalfChest.LeftLowerArm.MainArmPart.MainWeld.C0*CFrame.new(-.2,-.05,0)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest.LeftUpperArm.MainUpperPart.MainWeld.Part1 = Player.Character.LeftUpperArm
			Armor.GhastHalfChest.LeftUpperArm.MainUpperPart.MainWeld.C0 = Armor.GhastHalfChest.LeftUpperArm.MainUpperPart.MainWeld.C0*CFrame.new(-.2, -.65, 0)*CFrame.Angles(math.rad(180), 0, math.rad(180))
			Armor.GhastFull:Destroy()
			EquipRemote:FireClient(plr,"GhastArmor",2)
		elseif Val == 3 then
			for v,parts in pairs(Player.Character:GetChildren()) do
				if parts:IsA("BasePart") and parts.Name ~= "HumanoidRootPart" and not parts:FindFirstChild("TranVal") then
					local TranVal = Instance.new("IntValue", parts)
					TranVal.Name = "TranVal"
					TranVal.Value = parts.Transparency
					parts.Transparency = 0.65
				elseif parts:IsA("Accessory") and not parts.Handle:FindFirstChild("TranVal") then
					local TranVal = Instance.new("IntValue", parts.Handle)
					TranVal.Name = "TranVal"
					TranVal.Value = parts.Handle.Transparency
					parts.Handle.Transparency = 0.65
				end
			end
			local Armor = game.ServerStorage.Gadgets.GhastArmor:Clone()
			Armor.TierValue.Value = 3
			Armor.Parent = Player.Character
			Armor.GhastHelmet.Weld.Part1 = Player.Character.Head
			Armor.GhastHelmet.Weld.C0 = Armor.GhastHelmet.Weld.C0*CFrame.new(0, -.4, -.075)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest.UpperTorso.MainTorso.MainWeld.Part1 = Player.Character.UpperTorso
			Armor.GhastHalfChest.UpperTorso.MainTorso.MainWeld.C0 = Armor.GhastHalfChest.UpperTorso.MainTorso.MainWeld.C0*CFrame.new(0, -.3, 0)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest.LeftLowerArm.MainArmPart.MainWeld.Part1 = Player.Character.LeftLowerArm
			Armor.GhastHalfChest.LeftLowerArm.MainArmPart.MainWeld.C0 = Armor.GhastHalfChest.LeftLowerArm.MainArmPart.MainWeld.C0*CFrame.new(-.2,-.05,0)*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastHalfChest.LeftUpperArm.MainUpperPart.MainWeld.Part1 = Player.Character.LeftUpperArm
			Armor.GhastHalfChest.LeftUpperArm.MainUpperPart.MainWeld.C0 = Armor.GhastHalfChest.LeftUpperArm.MainUpperPart.MainWeld.C0*CFrame.new(-.2, -.65, 0)*CFrame.Angles(math.rad(180), 0, math.rad(180))
			Armor.GhastFull.LowerTorso.Main.MainWeld.Part1 = Player.Character.LowerTorso
			Armor.GhastFull.LowerTorso.Main.MainWeld.C0 = Armor.GhastFull.LowerTorso.Main.MainWeld.C0*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastFull.RightUpperArm.Main.MainWeld.Part1 = Player.Character.RightUpperArm
			Armor.GhastFull.RightUpperArm.Main.MainWeld.C0 = Armor.GhastFull.RightUpperArm.Main.MainWeld.C0*CFrame.Angles(0, math.rad(180), 0)
			Armor.GhastFull.RightLowerArm.Main.MainWeld.Part1 = Player.Character.RightLowerArm
			Armor.GhastFull.RightLowerArm.Main.MainWeld.C0 = Armor.GhastFull.RightLowerArm.Main.MainWeld.C0*CFrame.Angles(0, math.rad(180), 0)
			EquipRemote:FireClient(plr,"GhastArmor",3)
		end
	elseif item == "HalloweenScythe" and Player.Character:FindFirstChild("WeaponType") ~= "HalloweenScythe" and PlayerItems.HalloweenScythe ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.HalloweenScythe
		unequip(Player.Character)
		WeaponType.Value = "HalloweenScythe"
		if Val == 1 then
			local HalloweenScytheClone = game.ServerStorage.Weapons.HalloweenScythe:Clone()
			HalloweenScytheClone.Parent = Player.Character.RightHand
			local Weld = Instance.new("Weld",HalloweenScytheClone.Handle)
			Weld.Part0 = HalloweenScytheClone.Handle
			Weld.Part1 = Player.Character.RightHand
			Weld.C0 = Weld.C0*CFrame.Angles(math.rad(270),math.rad(30),math.rad(90))
			Weld.C0 = Weld.C0*CFrame.new(0,0,1.1)
			EquipRemote:FireClient(plr,"HalloweenScythe",1)
		elseif Val == 2 then
			local HalloweenScytheClone = game.ServerStorage.Weapons.HalloweenScythe2:Clone()
			HalloweenScytheClone.Parent = Player.Character.RightHand
			HalloweenScytheClone.Name = "HalloweenScythe"
			local Weld = Instance.new("Weld",HalloweenScytheClone.Handle)
			Weld.Part0 = HalloweenScytheClone.Handle
			Weld.Part1 = Player.Character.RightHand
			Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			EquipRemote:FireClient(plr,"HalloweenScythe",2)
		end	
	elseif item == "GhastSword" and Player.Character:FindFirstChild("WeaponType") ~= "GhastSword" and PlayerItems.GhastSword ~= nil then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.GhastSword
		unequip(Player.Character)
		WeaponType.Value = "GhastSword"
		if Val == 1 then
			local GhastSwordClone = game.ServerStorage.Weapons.GhastlySword:Clone()
			GhastSwordClone.Parent = Player.Character.RightHand
			local Weld = GhastSwordClone.Handle.MainWeld
			Weld.Part1 = Player.Character.RightHand
			Weld.C0 = Weld.C0*CFrame.Angles(math.rad(90), 0, math.rad(180))
			EquipRemote:FireClient(plr, "GhastSword", 1)
		elseif Val == 2 then
			local GhastSwordClone = game.ServerStorage.Weapons.GhastlySword:Clone()
			GhastSwordClone.Parent = Player.Character.RightHand
			GhastSwordClone.Blade.lightning.Enabled = true
			GhastSwordClone.DMG.Value = 1.1
			local Weld = GhastSwordClone.Handle.MainWeld
			Weld.Part1 = Player.Character.RightHand
			Weld.C0 = Weld.C0*CFrame.Angles(math.rad(90), 0, math.rad(180))
			EquipRemote:FireClient(plr, "GhastSword", 2)
		end
	elseif item == "CursedGlove" and Player.Character:FindFirstChild("WeaponType") ~= "CursedGlove" and PlayerItems.CursedGlove ~= nil then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.CursedGlove
		unequip(Player.Character)
		WeaponType.Value = "CursedGlove"
		if Val == 1 then
			local CursedGloveClone = game.ServerStorage.Weapons.CursedGlove:Clone()
			CursedGloveClone.Parent = Player.Character.RightHand
			local Weld = Instance.new("Weld",CursedGloveClone.RealHand)
			Weld.Part0 = CursedGloveClone.RealHand
			Weld.Part1 = Player.Character.RightHand
			Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			local Weld2 = Instance.new("Weld",CursedGloveClone.RealArm)
			Weld2.Part0 = CursedGloveClone.RealArm
			Weld2.Part1 = Player.Character.RightLowerArm
			Weld2.C0 = Weld2.C0*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			local CursedGloveClone2 = game.ServerStorage.Weapons.CursedGlove:Clone()
			CursedGloveClone2.Parent = Player.Character.LeftHand
			local Weld3 = Instance.new("Weld",CursedGloveClone2.RealHand)
			Weld3.Part0 = CursedGloveClone2.RealHand
			Weld3.Part1 = Player.Character.LeftHand
			Weld3.C0 = Weld3.C0*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
			local Weld4 = Instance.new("Weld",CursedGloveClone2.RealArm)
			Weld4.Part0 = CursedGloveClone2.RealArm
			Weld4.Part1 = Player.Character.LeftLowerArm
			Weld4.C0 = Weld4.C0*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
			EquipRemote:FireClient(plr, "CursedGlove", 1)
		end
	elseif item == "SnowSword" and Player.Character:FindFirstChild("WeaponType") ~= "SnowSword" and PlayerItems.SnowSword ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.SnowSword
		unequip(Player.Character)
		WeaponType.Value = "SnowSword"
		local SnowSwordClone = game.ServerStorage.Weapons.SnowSword:Clone()
		SnowSwordClone.Parent = Player.Character.RightHand
		local DmgMultiplier = SnowSwordClone:FindFirstChild("DMG")
		local Weld = Instance.new("Weld",SnowSwordClone.Handle)
		Weld.Part0 = SnowSwordClone.Handle
		Weld.Part1 = Player.Character.RightHand
		Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
		if Val == 2 then
			DmgMultiplier.Value = 1.1
			local SnowSwordClone2 = game.ServerStorage.Weapons.SnowSword:Clone()
			SnowSwordClone2.Parent = Player.Character.LeftHand
			local DmgMultiplier2 = SnowSwordClone2:FindFirstChild("DMG")
			DmgMultiplier2.Value = 1.1
			SnowSwordClone2.Name = "SnowSword"
			local Weld2 = Instance.new("Weld",SnowSwordClone2.Handle)
			Weld2.Part0 = SnowSwordClone2.Handle
			Weld2.Part1 = Player.Character.LeftHand
			Weld2.C0 = Weld2.C0*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
			EquipRemote:FireClient(plr,"SnowSword",2)
		else
			EquipRemote:FireClient(plr,"SnowSword",1)
		end	
	elseif item == "EasterKatana" and Player.Character:FindFirstChild("WeaponType") ~= "EasterKatana" and PlayerItems.EasterKatana ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.EasterKatana
		unequip(Player.Character)
		WeaponType.Value = "EasterKatana"
		local EasterKatanaClone = game.ServerStorage.Weapons.EasterKatana:Clone()
		EasterKatanaClone.Parent = Player.Character.RightHand
		EasterKatanaClone.Sheath2:Destroy()
		local DmgMultiplier = EasterKatanaClone:FindFirstChild("DMG")
		local Weld = Instance.new("Weld",EasterKatanaClone.Handle)
		Weld.Part0 = EasterKatanaClone.Handle
		Weld.Part1 = Player.Character.RightHand
		local Weld11 = Instance.new("Weld",EasterKatanaClone.Sheath.Handle)
		Weld11.Part0 = EasterKatanaClone.Sheath.Handle
		Weld11.Part1 = Player.Character.LowerTorso
		if Val == 2 then
			DmgMultiplier.Value = 1.1
			local EasterKatanaClone2 = game.ServerStorage.Weapons.EasterKatana:Clone()
			EasterKatanaClone2.Parent = Player.Character.LeftHand
			EasterKatanaClone2.Sheath:Destroy()
			local DmgMultiplier2 = EasterKatanaClone2:FindFirstChild("DMG")
			DmgMultiplier2.Value = 1.1
			EasterKatanaClone2.Name = "EasterKatana"
			local Weld222 = Instance.new("Weld",EasterKatanaClone2.Handle)
			Weld222.Part0 = EasterKatanaClone2.Handle
			Weld222.Part1 = Player.Character.LeftHand
			local Weld222 = Instance.new("Weld",EasterKatanaClone2.Sheath2.Handle)
			Weld222.Part0 = EasterKatanaClone2.Sheath2.Handle
			Weld222.Part1 = Player.Character.LowerTorso
			EquipRemote:FireClient(plr,"EasterKatana",2)
		else
			EquipRemote:FireClient(plr,"EasterKatana",1)
		end	
	elseif item == "PumpkinPistol" and Player.Character:FindFirstChild("WeaponType").Value ~= "PumpkinPistol" and PlayerItems.PumpkinPistol ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.PumpkinPistol
		unequip(Player.Character)
		WeaponType.Value = "PumpkinPistol"
		local PumpkinPistol = game.ServerStorage.Weapons.PumpkinPistol:Clone()
		PumpkinPistol.Name = "PumpkinPistol"
		PumpkinPistol.Parent = Player.Character.RightHand
		local weld = Instance.new("Weld", PumpkinPistol.Handle)
		weld.Part0 = PumpkinPistol.Handle
		weld.Part1 = Player.Character.RightHand
		weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(270))*CFrame.new(0,-.3,.3)
		local PumpkinPistol2 = game.ServerStorage.Weapons.PumpkinPistol:Clone()
		PumpkinPistol2.Name = "PumpkinPistol"
		PumpkinPistol2.Parent = Player.Character.LeftHand
		local weld2 = Instance.new("Weld", PumpkinPistol2.Handle)
		weld2.Part0 = PumpkinPistol2.Handle
		weld2.Part1 = Player.Character.LeftHand
		weld2.C0 = weld2.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(270))*CFrame.new(0,-.3,.3)
		EquipRemote:FireClient(plr,"PumpkinPistol")
	elseif item == "CandyCaneGun" and Player.Character:FindFirstChild("WeaponType").Value ~= "CandyCaneGun" and PlayerItems.CandyCaneGun ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		local Val = PlayerItems.CandyCaneGun
		unequip(Player.Character)
		WeaponType.Value = "CandyCaneGun"
		if Val == 1 then
			local CandyCaneGun = game.ServerStorage.Weapons.CandyCaneGun:Clone()
			CandyCaneGun.Name = "CandyCaneGun"
			CandyCaneGun.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", CandyCaneGun.Handle)
			weld.Part0 = CandyCaneGun.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			local CandyCaneGun2 = game.ServerStorage.Weapons.CandyCaneGun:Clone()
			CandyCaneGun2.Name = "CandyCaneGun"
			CandyCaneGun2.Parent = Player.Character.LeftHand
			local weld2 = Instance.new("Weld", CandyCaneGun2.Handle)
			weld2.Part0 = CandyCaneGun2.Handle
			weld2.Part1 = Player.Character.LeftHand
			weld2.C0 = weld2.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			EquipRemote:FireClient(plr,"CandyCaneGun",1)
		elseif Val == 2 then
			local CandyCaneGun = game.ServerStorage.Weapons.CandyCaneGun2:Clone()
			CandyCaneGun.Name = "CandyCaneGun"
			CandyCaneGun.Parent = Player.Character.RightHand
			local weld = Instance.new("Weld", CandyCaneGun.Handle)
			weld.Part0 = CandyCaneGun.Handle
			weld.Part1 = Player.Character.RightHand
			weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			CandyCaneGun.Name = "CandyCaneGun"
			local CandyCaneGun2 = game.ServerStorage.Weapons.CandyCaneGun2:Clone()
			CandyCaneGun2.Name = "CandyCaneGun"
			CandyCaneGun2.Parent = Player.Character.LeftHand
			local weld2 = Instance.new("Weld", CandyCaneGun2.Handle)
			weld2.Part0 = CandyCaneGun2.Handle
			weld2.Part1 = Player.Character.LeftHand
			weld2.C0 = weld2.C0*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			CandyCaneGun2.Name = "CandyCaneGun"
			EquipRemote:FireClient(plr,"CandyCaneGun",2)	
		end
	elseif item == "SantaArmor" and Player.Character:FindFirstChild("ToolType") ~= "SantaArmor" and PlayerItems.SantaArmor ~= false then	
		local ToolType = Player.Character:FindFirstChild("ToolType")
		local Val = PlayerItems.SantaArmor
		unequip2(Player.Character)
		ToolType.Value = "SantaArmor"
		local SantaArmor = game.ServerStorage.Gadgets.SantaArmor:Clone()
		SantaArmor.Parent = Player.Character
		SantaArmor.TierValue.Value = Val
		local Weld = Instance.new("Weld", SantaArmor.UpperTorso2)
		Weld.Part0 = Player.Character.UpperTorso
		Weld.Part1 = SantaArmor.UpperTorso2
		Weld.C0 = Weld.C0 * CFrame.new(0,0,-0.15) * CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
		local Weld2 = Instance.new("Weld", SantaArmor.UpperTorso1)
		Weld2.Part0 = Player.Character.UpperTorso
		Weld2.Part1 = SantaArmor.UpperTorso1
		Weld2.C0 = Weld.C0 * CFrame.new(0,0,-0.09) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		local Weld3 = Instance.new("Weld", SantaArmor.LowerTorso)
		Weld3.Part0 = Player.Character.LowerTorso
		Weld3.Part1 = SantaArmor.LowerTorso
		Weld3.C0 = Weld3.C0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		local Weld4 = Instance.new("Weld", SantaArmor.UpperTorso3)
		Weld4.Part0 = Player.Character.UpperTorso
		Weld4.Part1 = SantaArmor.UpperTorso3
		Weld4.C0 = Weld4.C0 * CFrame.new(0,0.6,0) * CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
		local Weld5 = Instance.new("Weld", SantaArmor.RightLowerArm)
		Weld5.Part0 = Player.Character.RightLowerArm
		Weld5.Part1 = SantaArmor.RightLowerArm
		Weld5.C0 = Weld5.C0 * CFrame.new(0,0,0.05) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		local Weld6 = Instance.new("Weld", SantaArmor.RightUpperArm1)
		Weld6.Part0 = Player.Character.RightUpperArm
		Weld6.Part1 = SantaArmor.RightUpperArm1
		Weld6.C0 = Weld6.C0 * CFrame.new(0,0.5,0) * CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
		local Weld7 = Instance.new("Weld", SantaArmor.RightUpperArm2)
		Weld7.Part0 = Player.Character.RightUpperArm
		Weld7.Part1 = SantaArmor.RightUpperArm2
		Weld7.C0 = Weld7.C0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(90),math.rad(90),math.rad(0))
		local Weld8 = Instance.new("Weld", SantaArmor.LeftLowerArm)
		Weld8.Part0 = Player.Character.LeftLowerArm
		Weld8.Part1 = SantaArmor.LeftLowerArm
		Weld8.C0 = Weld8.C0 * CFrame.new(0,0,0.05) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
		local Weld9 = Instance.new("Weld", SantaArmor.LeftUpperArm1)
		Weld9.Part0 = Player.Character.LeftUpperArm
		Weld9.Part1 = SantaArmor.LeftUpperArm1
		Weld9.C0 = Weld9.C0 * CFrame.new(0,0.5,0) * CFrame.Angles(math.rad(180),math.rad(180),math.rad(180))
		local Weld10 = Instance.new("Weld", SantaArmor.LeftUpperArm2)
		Weld10.Part0 = Player.Character.LeftUpperArm
		Weld10.Part1 = SantaArmor.LeftUpperArm2
		Weld10.C0 = Weld10.C0 * CFrame.new(-.06,0,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))	
		local Weld11 = Instance.new("Weld", SantaArmor.LeftUpperLeg)
		Weld11.Part0 = Player.Character.LeftUpperLeg
		Weld11.Part1 = SantaArmor.LeftUpperLeg
		Weld11.C0 = Weld11.C0 * CFrame.new(0,-0.15,-.05) * CFrame.Angles(math.rad(90),math.rad(270),math.rad(180))
		local Weld12 = Instance.new("Weld", SantaArmor.RightUpperLeg)
		Weld12.Part0 = Player.Character.RightUpperLeg
		Weld12.Part1 = SantaArmor.RightUpperLeg
		Weld12.C0 = Weld12.C0 * CFrame.new(0,-0.15,-.05) * CFrame.Angles(math.rad(90),math.rad(270),math.rad(180))
		local Weld13 = Instance.new("Weld", SantaArmor.LeftLowerLeg)
		Weld13.Part0 = Player.Character.LeftLowerLeg
		Weld13.Part1 = SantaArmor.LeftLowerLeg
		Weld13.C0 = Weld13.C0 * CFrame.new(0,-0.05,-0.1) * CFrame.Angles(math.rad(0),math.rad(270),math.rad(90))
		local Weld14 = Instance.new("Weld", SantaArmor.RightLowerLeg)
		Weld14.Part0 = Player.Character.RightLowerLeg
		Weld14.Part1 = SantaArmor.RightLowerLeg
		Weld14.C0 = Weld14.C0 * CFrame.new(0,-0.05,-0.1) * CFrame.Angles(math.rad(0),math.rad(270),math.rad(90))
		local Weld = Instance.new("Weld", SantaArmor.Head)
		Weld.Part0 = Player.Character.Head
		Weld.Part1 = SantaArmor.Head
		Weld.C0 = Weld.C0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		if Val == 1 then
			for i,v in pairs(SantaArmor:GetChildren()) do
				if string.find(v.Name, "Arm") or string.find(v.name, "Leg") or string.find(v.name, "Head")then
					v:Destroy()
				end
			end
		elseif Val == 2 then
			for i,v in pairs(SantaArmor:GetChildren()) do
				if string.find(v.Name, "Leg") or string.find(v.name, "Head") then
					v:Destroy()
				end
			end
		elseif Val == 3 then
			for i,v in pairs(SantaArmor:GetChildren()) do
				if string.find(v.name, "Head") then
					v:Destroy()
				end
			end
		end
		EquipRemote:FireClient(plr,"SantaArmor", Val)
	elseif item == "PumpkinArmor" and Player.Character:FindFirstChild("ToolType") ~= "PumpkinArmor" and PlayerItems.PumpkinArmor ~= false then	
		local ToolType = Player.Character:FindFirstChild("ToolType")
		local Val = PlayerItems.PumpkinArmor
		unequip2(Player.Character)
		ToolType.Value = "PumpkinArmor"
		local PumpkinArmor = game.ServerStorage.Gadgets.PumpkinArmor["tier"..Val]:Clone()
		PumpkinArmor.Name = "PumpkinArmor"
		PumpkinArmor.Parent = Player.Character
		local Weld = Instance.new("Weld", PumpkinArmor.PumpkinArmor)
		Weld.Part0 = Player.Character.Head
		Weld.Part1 = PumpkinArmor.PumpkinArmor
		Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))
		EquipRemote:FireClient(plr,"PumpkinArmor")
	elseif item == "EasterStaff" and Player.Character:FindFirstChild("WeaponType").Value ~= "EasterStaff" and PlayerItems.EasterStaff ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "EasterStaff"
		local Val = PlayerItems.EasterStaff
		local EasterStaffClone = game.ServerStorage.Weapons.EasterStaff:Clone()
		EasterStaffClone.Parent = Player.Character.RightHand		
		local DmgMultiplier = EasterStaffClone:FindFirstChild("DMG")
		if Val == 1 then
			EasterStaffClone.Egg.Tier2PE2:Destroy()
		elseif Val == 2 then
			EasterStaffClone.Egg.Tier2PE2.Enabled = true
			DmgMultiplier.Value = 1.1
		end
		local Weld = Instance.new("Weld",EasterStaffClone.Handle)
		Weld.Part0 = EasterStaffClone.Handle
		Weld.Part1 = Player.Character.RightHand
		Weld.C0 = Weld.C0*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(180))
		Weld.C0 = Weld.C0*CFrame.new(0,.2,.5)
		EquipRemote:FireClient(plr,"EasterStaff")
	elseif item == "BanHammer" and Player.Character:FindFirstChild("ToolType").Value ~= "BanHammer" and Player:GetRankInGroup(3755220) > 11 then	
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "BanHammer"
		local BanHammer = game.ServerStorage.Weapons.BanHammer:Clone()
		BanHammer.Parent = Player.Character.RightHand
		local weld = Instance.new("Weld", BanHammer.Handle)
		weld.Part0 = BanHammer.Handle
		weld.Part1 = Player.Character.RightHand
		weld.C0 = weld.C0*CFrame.Angles(math.rad(90),math.rad(90),math.rad(0))
	elseif item == "FestiveLights" and Player.Character:FindFirstChild("ToolType") ~= "FestiveLights" and PlayerItems.FestiveLights ~= nil then	
		local ToolType = Player.Character:FindFirstChild("ToolType")
		local Val = PlayerItems.FestiveLights
		unequip2(Player.Character)
		ToolType.Value = "FestiveLights"
		local FestiveLights = game.ServerStorage.Gadgets.FestiveLights:Clone()
		FestiveLights.TierValue.Value = Val
		FestiveLights.Parent = Player.Character
		if Val == 1 then
			for i,v in pairs(FestiveLights.Tier2:GetChildren()) do
				v.Transparency = 1
			end
			for i,v in pairs(FestiveLights.Tier3:GetChildren()) do
				v.Transparency = 1
			end
		elseif Val == 2 then
			for i,v in pairs(FestiveLights.Tier3:GetChildren()) do
				v.Transparency = 1
			end
		end
		local Weld = Instance.new("Weld", FestiveLights.UpperTorso)
		Weld.Part0 = FestiveLights.UpperTorso
		Weld.Part1 = Player.Character.UpperTorso
		local Weld2 = Instance.new("Weld", FestiveLights.LeftLowerArm)
		Weld2.Part0 = FestiveLights.LeftLowerArm
		Weld2.Part1 = Player.Character.LeftLowerArm
		EquipRemote:FireClient(plr,"FestiveLights", Val)
	elseif item == "IceSickle" and Player.Character:FindFirstChild("WeaponType") ~= "IceSickle" and PlayerItems.IceSickle ~= nil then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "IceSickle"
		local IceSickle = game.ServerStorage.Weapons.IceSickle:Clone()
		IceSickle.Parent = Player.Character.RightHand
		local Weld = IceSickle.Handle.MainWeld
		Weld.Part1 = Player.Character.RightHand
		EquipRemote:FireClient(plr, "IceSickle")
	elseif item == "PeppermintSaber" and Player.Character:FindFirstChild("WeaponType") ~= "PeppermintSaber" and PlayerItems.PeppermintSaber ~= nil then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "PeppermintSaber"
		local PeppermintSaber = game.ServerStorage.Weapons.PeppermintSaber:Clone()
		PeppermintSaber.Parent = Player.Character.RightHand
		local Weld = PeppermintSaber.Handle.MainWeld
		Weld.Part1 = Player.Character.RightHand
		EquipRemote:FireClient(plr, "PeppermintSaber")
	elseif item == "OrnamentBlaster" and Player.Character:FindFirstChild("WeaponType").Value ~= "OrnamentBlaster" and PlayerItems.OrnamentBlaster ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "OrnamentBlaster"
		local OrnamentBlaster = game.ServerStorage.Weapons.OrnamentBlaster:Clone()
		OrnamentBlaster.Parent = Player.Character.RightHand
		local weld = Instance.new("Weld", OrnamentBlaster.Handle)
		weld.Part0 = OrnamentBlaster.Handle
		weld.Part1 = Player.Character.RightHand
		local OrnamentBlaster2 = game.ServerStorage.Weapons.OrnamentBlaster:Clone()
		OrnamentBlaster2.Parent = Player.Character.LeftHand
		local weld2 = Instance.new("Weld", OrnamentBlaster2.Handle)
		weld2.Part0 = OrnamentBlaster2.Handle
		weld2.Part1 = Player.Character.LeftHand
		EquipRemote:FireClient(plr,"OrnamentBlaster")
	elseif item == "EasterSword" and Player.Character:FindFirstChild("WeaponType").Value ~= "EasterSword" and PlayerItems.EasterSword ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "EasterSword"
		local EasterSword = game.ServerStorage.Weapons.EasterSword:Clone()
		EasterSword.Parent = Player.Character
		EasterSword.Hold.Part1 = Player.Character.RightHand
		EquipRemote:FireClient(plr,"EasterSword")
	elseif item == "EasterFlintlock" and Player.Character:FindFirstChild("WeaponType").Value ~= "EasterFlintlock" and PlayerItems.EasterFlintlock ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "EasterFlintlock"
		local EasterFlintlock = game.ServerStorage.Weapons.EasterFlintlock:Clone()
		EasterFlintlock.Parent = Player.Character
		EasterFlintlock.Gun1.Hold.Part1 = Player.Character.RightHand
		EasterFlintlock.Gun2.Hold.Part1 = Player.Character.LeftHand
		EquipRemote:FireClient(plr,"EasterFlintlock")
	elseif item == "EasterWand" and Player.Character:FindFirstChild("WeaponType").Value ~= "EasterWand" and PlayerItems.EasterWand ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "EasterWand"
		local EasterWand = game.ServerStorage.Weapons.EasterWand:Clone()
		EasterWand.Parent = Player.Character
		EasterWand.Hold.Part1 = Player.Character.RightHand
		EquipRemote:FireClient(plr,"EasterWand")
	elseif item == "EasterGrimoire" and Player.Character:FindFirstChild("WeaponType").Value ~= "EasterGrimoire" and PlayerItems.EasterGrimoire ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "EasterGrimoire"
		local EasterGrimoire = game.ServerStorage.Weapons.EasterGrimoire:Clone()
		EasterGrimoire.Parent = Player.Character
		EasterGrimoire.Hold.Part1 = Player.Character.RightHand
		EquipRemote:FireClient(plr,"EasterGrimoire")
	elseif item == "EasterBow" and Player.Character:FindFirstChild("WeaponType").Value ~= "EasterBow" and PlayerItems.EasterBow ~= false then
		local WeaponType = Player.Character:FindFirstChild("WeaponType")
		unequip(Player.Character)
		WeaponType.Value = "EasterBow"
		local EasterBow = game.ServerStorage.Weapons.EasterBow:Clone()
		EasterBow.Parent = Player.Character
		EasterBow.Bow.Hold.Part1 = Player.Character.LeftHand
		EasterBow.Quiver.Hold.Part1 = Player.Character.UpperTorso
		EquipRemote:FireClient(plr,"EasterBow")
	elseif item == "EggPauldron" and Player.Character:FindFirstChild("WeaponType").Value ~= "EggPauldron" and PlayerItems.EggPauldron ~= false then
		local ToolType = Player.Character:FindFirstChild("ToolType")
		unequip2(Player.Character)
		ToolType.Value = "EggPauldron"
		local EggPauldron = game.ServerStorage.Gadgets.EggPauldron:Clone()
		EggPauldron.Parent = Player.Character
		EggPauldron.EggShell1.Hold.Part1 = Player.Character.RightUpperArm
		EggPauldron.EggShell2.Hold.Part1 = Player.Character.LeftUpperArm
		EquipRemote:FireClient(plr,"EggPauldron")
	elseif item == "Unequip" then
		unequip(Player.Character)
	elseif item == "Unequip2" then
		unequip2(Player.Character)
	end
end)
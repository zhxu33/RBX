local module = {}

local ServerStorage = game:GetService("ServerStorage")
local LootFormats = ServerStorage.LootFormats
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WeaponShop = ReplicatedStorage.WeaponShop
local ItemRemote = WeaponShop:FindFirstChild("Item")
local ConfirmRemote = WeaponShop:FindFirstChild("Confirm")
local SellRemote = WeaponShop:FindFirstChild("Sell")
local EquipRemote = WeaponShop.Equip
local Weapons = game.ServerStorage.Weapons
local Gadgets = game.ServerStorage.Gadgets
local EffectsScript = nil 
coroutine.wrap(function() EffectsScript = require(game.ServerScriptService.InventoryData["W&GAbilites"]) end)()
local MI = require(WeaponShop.ItemData)
local DataThrow = ReplicatedStorage.Modules.NPCs.NPCReward.DataThrow
local DataGrab = ReplicatedStorage.Modules.NPCs.NPCReward.DataGrab

local function GetTier(Item, Tier)
	local d = 1
	if Tier ~= nil and Tier > 1 then
		d = Tier
	end
	local ID = MI[Item][d]
	if ID == nil then
		repeat
			d = d - 1
			ID = MI[Item][d]
		until ID ~= nil
	end
	return d
end

ItemRemote.OnServerEvent:Connect(function(Player,item)
	local plr = game.Players:FindFirstChild(Player.Name)
	local Character = plr.Character
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
	local TP = module.TemparyStorage[plr.UserId]  
	if false then -- Player.Name == "10ian10" put your name here if your testing gear.
		module.TemparyStorage[plr.UserId] = {Pistol = 3, CandyCaneGun = 2, EasterWand = 1, Katana = 3, 
			EasterFlintlock = 1, EasterSword = 1, EasterBow = 1, EasterGrimoire = 1, HalloweenScythe = 2, PumpkinPistol = 1,
			EasterStaff = 2, GhastSword = 2, CursedGlove = 1, IceSickle = 1, PeppermintSaber = 1, OrnamentBlaster = 1, 
			Dagger = 3,	SnowSword = 2}
	end
	if not PlayerData:FindFirstChild("Buying") then
		local Buying = Instance.new("NumberValue", PlayerData)
		Buying.Name = "Buying" 
		if TP and item == "LoadItem" then
			for ItemName, Val in pairs(TP) do
				if Val ~= false then
					if typeof(TP[ItemName]) == typeof(table) then
						if TP[ItemName]["Boost"] and TP[ItemName]["Boost"] >= 2.1 then
							TP[ItemName] = nil
						end
						ItemRemote:FireClient(plr,TP[ItemName])
					else
						ItemRemote:FireClient(plr,ItemName, TP[ItemName])
					end						
				end
			end
		elseif MI[item] then

			-- Checks if the player is touching the safezone before prompting transaction
			local SZ = Character:FindFirstChild("Safezone")
			if not (SZ and SZ:GetAttribute("Zone") == "WeaponShop") then
				Buying:Destroy()
				ConfirmRemote:FireClient(Player, false, "Out of Range / Missing Forcefield")
				return end

			local Cash = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Cash
			if TP[item] == nil or TP[item] == false then
				if Cash.Value >= MI[item][1].Cost then
					Cash.Value = Cash.Value - MI[item][1].Cost
					TP[item] = 1
					ItemRemote:FireClient(plr, item, 1, "Bought")
					ConfirmRemote:FireClient(Player, true)
				else
					ConfirmRemote:FireClient(Player, false, "Insufficient Funds")
				end
			elseif MI[item][TP[item]+1] then
				local newtag = TP[item]+1
				if Cash.Value >= MI[item][newtag].Cost then
					Cash.Value = Cash.Value - MI[item][newtag].Cost
					TP[item] = newtag
					ItemRemote:FireClient(plr, item, newtag, "Bought")
					ConfirmRemote:FireClient(Player, true)
				else
					ConfirmRemote:FireClient(Player, false, "Insufficient Funds")
				end
			else
				if MI[item][TP[item]+1] then
					ConfirmRemote:FireClient(Player, false, "Item is already fully upgraded.")
				else
					ConfirmRemote:FireClient(Player, false, "Item is already purchased.")
				end
			end
		end
		Buying:Destroy()
	end
end)

local function FullUnequip(Character, ItemType)
	local UnequipVersion = "Unequip"
	local ItemID
	if ItemType == "Gadget" or ItemType == "Tool_Type" then
		ItemType = "Tool_Type"
		ItemID = "Tool_ID"
		UnequipVersion = "Unequip2"
	else
		ItemType = "Weapon_Type"
		ItemID = "Weapon_ID"
	end
	local plr = game.Players:GetPlayerFromCharacter(Character)
	if ItemType and Character:FindFirstChild(Character:GetAttribute(ItemType)) then		
		local lastItem = Character:WaitForChild(Character:GetAttribute(ItemType), 10)
		if lastItem then
			lastItem:Destroy()
		end
		EquipRemote:FireClient(plr,UnequipVersion)
		
		Character:SetAttribute(ItemType, "N/A")
		Character:SetAttribute(ItemID, "N/A")
	end
end

local function unequip(Character)
	FullUnequip(Character, nil)
end
game.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Equips"):FindFirstChild("Unequip").Event:Connect(unequip)

local function unequip2(Character)
	FullUnequip(Character, "Gadgets")
end
game.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Equips"):FindFirstChild("Unequip2").Event:Connect(unequip2)

EquipRemote.OnServerEvent:Connect(function(Player, item)
	local plr = game.Players:FindFirstChild(Player.Name)
	local TP = module.TemparyStorage[plr.UserId]
	if plr.Character:GetAttribute("Attacking") then
		repeat task.wait(.1) until not plr.Character and plr.Character:GetAttribute("Attacking")
	end
	if Gadgets:FindFirstChild(item) or Weapons:FindFirstChild(item) or item and item["ID"] and TP[item["ID"]] then	
		local ItemParent
		local NewItem = nil
		local Val = nil
		local Loot = false
		local ItemType = nil
		local ItemID = nil
		local Obj = nil
		if item["ID"] then	
			Loot = true
			Val = item["Tier"]			
		else
			Val = TP[item]
		end				
		if Gadgets:FindFirstChild(item) or Loot and Gadgets:FindFirstChild(item.Name) then
			Obj = Player.Character:FindFirstChild("GObj")
			ItemParent = Gadgets
			ItemType = "Tool_Type"
			ItemID = "Tool_ID"
		else
			Obj = Player.Character:FindFirstChild("WObj")
			ItemParent = Weapons
			ItemType = "Weapon_Type"
			ItemID = "Weapon_ID"
		end	
		if not ItemType then return end
		FullUnequip(Player.Character, ItemType)
		Player.Character:SetAttribute(ItemType, item["Name"] or item)
		if item["ID"] then
			Player.Character:SetAttribute(ItemID, item["ID"])
		end
		if Loot then
			if Val > 1 and ItemParent:FindFirstChild(item["Name"]..Val) then
				NewItem = ItemParent:FindFirstChild(item["Name"]..Val):Clone()				
				NewItem.Name = item["Name"]		
			else
				NewItem = ItemParent:FindFirstChild(item["Name"]):Clone()
			end
		elseif Val > 1 and ItemParent:FindFirstChild(item..Val) then
			NewItem = ItemParent:FindFirstChild(item..Val):Clone()
			NewItem.Name = item		
		else
			NewItem = ItemParent:FindFirstChild(item):Clone()
		end
		Obj.Value = NewItem 
		if Loot then
			if item["Type"] == "Weapon" then
				NewItem:SetAttribute("Cooldown", item["Cooldown"])
				NewItem:SetAttribute("Damage", item["Damage"])
				NewItem:SetAttribute("StaminaCost", item["StaminaCost"])
			else
				NewItem:SetAttribute("Boost", item["Boost"])
				NewItem:SetAttribute("Armour", item["Armour"])
				NewItem:SetAttribute("QuirkLimit", item["QuirkLimit"])
				EffectsScript["GearBuff"](Player.Character, NewItem, {item["Boost"], item["Armour"]})
			end
			if item["Effects"] then
				local neweffect = Instance.new("Folder")
				neweffect.Name = "Effects"
				neweffect:SetAttribute("Effects", 1)
				for index, value in pairs(item["Effects"]) do	
					neweffect:SetAttribute("Effect1", index)
					for index1, value1 in pairs(value) do
						neweffect:SetAttribute(index1, value1)
					end
				end
				neweffect.Parent = NewItem
			end
		end
		if NewItem:FindFirstChild("TierValue") then
			NewItem.TierValue.Value = Val
		end	
		local Effects = NewItem:FindFirstChild("Effects")	
		if Effects then
			for i=1,Effects:GetAttribute("Effects") do
				local EffectType =  Effects:GetAttribute("Effect"..i)
				local Intensity = Effects:GetAttribute("Intensity"..i)
				local Core = Player.Character
				local Variables = {}
				for v=1,Effects:GetAttribute(EffectType) do
					table.insert(Variables, Effects:GetAttribute(EffectType..v))
				end				
				EffectsScript[Effects:GetAttribute("Effect"..i)](Core, NewItem, Variables, Intensity)				
			end
		end	
		NewItem.Parent = Player.Character
		for i=1,NewItem:GetAttribute("Sources") do
			local Source = Player.Character:FindFirstChild(NewItem:GetAttribute("Source"..i))
			local Handle = NewItem:FindFirstChild(NewItem:GetAttribute("Handle"..i))
			local HWeld = NewItem:GetAttribute("Weld"..i)
			local weld = Instance.new("Weld", Handle)
			weld.Part0 = Handle
			weld.Part1 = Source
			weld.C0 = CFrame.new(NewItem:GetAttribute("Offset"..i)) * CFrame.Angles(math.rad(HWeld.X),math.rad(HWeld.Y),math.rad(HWeld.Z))
		end
		EquipRemote:FireClient(plr, item, Val)	
	elseif item == "Unequip2" then
		FullUnequip(Player.Character, "Gadget") --Unequip Gadgets
	elseif item == "Unequip" then
		FullUnequip(Player.Character, "Weapons") --Unequip weapon
	end
end)

SellRemote.OnServerEvent:Connect(function(Player, Item)
	local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
	local Character = Player.Character	
	local TP = module.TemparyStorage[Player.UserId]
	local ItemType, ItemID

	-- Checks if the player is touching the safezone before prompting transaction
	local SZ = Character:FindFirstChild("Safezone")
	if not (SZ and SZ:GetAttribute("Zone") == "WeaponShop") then
		ConfirmRemote:FireClient(Player, false, "Out of Range / Missing Forcefield")
		return end

	if TP[Item] and not TP[Item["ID"]] then
		if MI[Item][1].Type == "Gadget" then
			ItemType = Player.Character:GetAttribute("Tool_Type")
		else
			ItemType = Player.Character:GetAttribute("Weapon_Type")
		end
		local Tier = TP["Tier"] or TP[Item]		
		if Tier ~= nil and Tier >= 1 and MI[Item][GetTier(Item, Tier)].Cost ~= nil then
			if ItemType == Item then
				FullUnequip(Player.Character, MI[Item][1].Type)
			end
			if Tier > 1 then
				TP[Item] -= 1
			else
				TP[Item] = nil
			end
			PlayerData.Cash.Value += MI[Item][GetTier(Item, Tier)].Cost/2
			ItemRemote:FireClient(Player, Item, TP[Item], "Sold")
			ConfirmRemote:FireClient(Player, true)
		else
			if Tier == nil then
				ConfirmRemote:FireClient(Player, false, "You do not own this Item.")
			elseif MI[Item][GetTier(Item, Tier)].Cost ~= nil then
				ConfirmRemote:FireClient(Player, false, "Unable to sell Event Items.")
			end
		end
	elseif Item and TP[Item["ID"]] then
		if Item["Type"] == "Gadget" then
			ItemType = Player.Character:GetAttribute("Tool_Type")
			ItemID = Player.Character:GetAttribute("Tool_ID")
		else
			ItemType = Player.Character:GetAttribute("Weapon_Type")
			ItemID = Player.Character:GetAttribute("Weapon_ID")
		end
		if ItemType == Item["Name"] and ItemID == Item["ID"] then
			FullUnequip(Player.Character, Item["Type"])
		end
		TP[Item["ID"]] = nil
		PlayerData.Cash.Value = PlayerData.Cash.Value + Item.Worth or 0
		ItemRemote:FireClient(Player, Item, Item)
		ConfirmRemote:FireClient(Player, true)
	end
end)

local function grabdata(plr)
	if plr and plr.UserId then
		return module.TemparyStorage[plr.UserId]
	end
end

DataGrab.OnServerInvoke  = grabdata

DataThrow.Event:Connect(function(plr, lists)
	local ID = plr.UserId	
	local TP = module.TemparyStorage[ID] 	
	for i=1,#lists do
		local item = lists[i]
		TP[item["ID"]] = item
		module.Unrelatedlist[ID] = true
		ItemRemote:FireClient(plr, item, item)
		ConfirmRemote:FireClient(plr, true)
	end
end)

return module

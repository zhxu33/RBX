local Equip = game.ReplicatedStorage.WeaponShop:WaitForChild("Equip")
local Frame = script.Parent
local WeaponFrame = Frame:WaitForChild("Weapons")
local GadgetFrame = Frame:WaitForChild("Gadgets")
local ScrollingWeaponFrame = WeaponFrame:WaitForChild("ScrollingFrame")
local ScrollingGadgetFrame = GadgetFrame:WaitForChild("ScrollingFrame")
local EquipedItems = Frame:WaitForChild("EquipedItems")
local WeaponEquiped = EquipedItems:WaitForChild("Weapon")
local GadgetEquiped = EquipedItems:WaitForChild("Gadget")
local InventoryType = Frame:WaitForChild("InventoryType")
local CD = false
local MM = require(game.ReplicatedStorage.Modules.Weapons)
local ItemRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Item")

InventoryType.MouseButton1Click:Connect(function()
	if WeaponFrame.Visible == true then
		InventoryType.Text = "Gadget"
		WeaponFrame.Visible = false
		GadgetFrame.Visible = true
	elseif GadgetFrame.Visible == true then
		InventoryType.Text = "Weapon"
		GadgetFrame.Visible = false
		WeaponFrame.Visible = true
	end
end)

WeaponEquiped.MouseButton1Click:Connect(function()
	if CD == false then
		CD = true
		Equip:FireServer("Unequip")
		wait(1)
		CD = false
	end
end)

GadgetEquiped.MouseButton1Click:Connect(function()
	if CD == false then
		CD = true
		Equip:FireServer("Unequip2")
		wait(1)
		CD = false
	end
end)

local EquipedWeapon = nil
local EquipedGadget = nil
Equip.OnClientEvent:Connect(function(item, tier)
	if item == "Unequip" then
		WeaponEquiped.Image = "rbxassetid://2424191126"
		EquipedWeapon = nil
	elseif item == "Unequip2" then
		GadgetEquiped.Image = "rbxassetid://2424190639"
		EquipedGadget = nil
	else
		if tier == nil then
			tier = 1
		end
		if MM[item]["Type"] == "Weapon" then
			WeaponEquiped.Image = "rbxassetid://"..MM[item]["Images"][tier]
			EquipedWeapon = item
		elseif MM[item]["Type"] == "Gadget" then
			GadgetEquiped.Image = "rbxassetid://"..MM[item]["Images"][tier]
			EquipedGadget = item
		end
	end
end)

ItemRemote.OnClientEvent:Connect(function(item, tier)
	if MM[item]["Type"] == "Weapon" then
		if ScrollingWeaponFrame:FindFirstChild(item) then
			local Slot = ScrollingWeaponFrame:FindFirstChild(item)
			Slot.Button.Image = "rbxassetid://"..MM[item]["Images"][tier]
		else
			local Slot = Frame.Slot:Clone()
			Slot.Name = item
			Slot.Button.Image = "rbxassetid://"..MM[item]["Images"][tier]
			Slot.Parent = ScrollingWeaponFrame
			Slot.Visible = true
			Slot.Button.MouseButton1Click:Connect(function()
				if CD == false then
					CD = true
					Equip:FireServer(item)
					wait(1)
					CD = false
				end
			end)
		end
	elseif MM[item]["Type"] == "Gadget" then
		if ScrollingGadgetFrame:FindFirstChild(item) then
			local Slot = ScrollingGadgetFrame:FindFirstChild(item)
			Slot.Button.Image = "rbxassetid://"..MM[item]["Images"][tier]
		else
			local Slot = Frame.Slot:Clone()
			Slot.Name = item
			Slot.Button.Image = "rbxassetid://"..MM[item]["Images"][tier]
			Slot.Parent = ScrollingGadgetFrame
			Slot.Visible = true
			Slot.Button.MouseButton1Click:Connect(function()
				if CD == false then
					CD = true
					Equip:FireServer(item)
					wait(1)
					CD = false
				end
			end)
		end
	end
end)

local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function(Character)
	repeat wait() until Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("WeaponType")
	if EquipedWeapon ~= nil then
		Equip:FireServer(EquipedWeapon)
	end
	if EquipedGadget ~= nil then
		Equip:FireServer(EquipedGadget)
	end
end)

ItemRemote:FireServer("LoadItem")
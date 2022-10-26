local Player = game.Players.LocalPlayer

local sframe = script.Parent:WaitForChild("ScrollingFrame")
local display = script.Parent:WaitForChild("Preview")
local buttons = sframe:GetChildren()

local GUI_Sounds = Player:WaitForChild("PlayerGui"):WaitForChild("GUI_Sounds")
local CS = GUI_Sounds:WaitForChild("ClickSound")

local NameDisplay = script.Parent:WaitForChild("Name")
local TopInfoDisplay = script.Parent:WaitForChild("TopInfo")
local CenterInfoDisplay = script.Parent:WaitForChild("CenterInfo")
local BottomInfoDisplay = script.Parent:WaitForChild("BottomInfo")
local equipbutton  = script.Parent:WaitForChild("Equipbutton")
local equipped = nil
local ActiveChild = nil
local EquippedWeap = nil
local CD = false
local closeButton = script.Parent:WaitForChild("CloseButton")
local MI = require(game.ReplicatedStorage:WaitForChild("WeaponShop"):WaitForChild("ItemData"))
local ItemRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Item")
local Equip = game.ReplicatedStorage.WeaponShop:WaitForChild("Equip")
local TweenService = game:GetService("TweenService")
local CurrentWeap = script.Parent.Parent:WaitForChild("Inventory"):WaitForChild("CurrentWepImage")
local WepName = script.Parent.Parent:WaitForChild("Inventory"):WaitForChild("WepName")

local Connections = {}
local EquippedWeapon = nil
local Rarity = require(script.Parent.Parent:WaitForChild("RarityModule"))

closeButton.MouseButton1Click:Connect(function()
	local weaponmenu = script.Parent
	weaponmenu:TweenSizeAndPosition(
		UDim2.new(0.018, 0,0.032, 0),  -- size
		UDim2.new(0.482, 0,0.433, 0),  -- pos
		"In",
		"Quad",
		0.5,
		true
	)
	local invmenu = script.Parent.Parent.Inventory
	local InvTweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0)
	local InvGoal = {ImageTransparency = 0}
	local invDescendants = invmenu:GetDescendants()
	local tweenInv = TweenService:Create(invmenu,InvTweenInfo,InvGoal)
	tweenInv:Play()
	for _, desc in pairs(invDescendants) do
		if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
			desc.ImageTransparency = 0
		elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
			desc.TextTransparency = 0
		end
	end
	wait(0.45)
	weaponmenu.Visible = false
end)

local function GetTier(val)
	return val or 1
end

local function equip(item,tier)
	if CD == false and item ~= EquippedWeap then
		CD = true
		EquippedWeap = ActiveChild
		EquippedWeapon = item
		CurrentWeap.Image = EquippedWeap.Image
		if item["ID"] then
			WepName.Text = item["Name"]
		else
			WepName.Text = MI[item][GetTier(tier)].Name
		end
		equipbutton.Image = "http://www.roblox.com/asset/?id=7164682924"
		Equip:FireServer(item)
		wait(1)
		CD = false
	end
end

local function unequip(item)
	if CD == false then
		CD = true
		EquippedWeap = nil
		EquippedWeapon = nil
		equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
		CurrentWeap.Image = "http://www.roblox.com/asset/?id=7163922662"
		WepName.Text = "No Weapon Equipped"
		Equip:FireServer("Unequip")
		wait(1)
		CD = false
	end
end

local function ResetDisplay()
	script.Parent:SetAttribute("SelectedGadget", "")
	equipbutton.Visible = false
	equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
	TopInfoDisplay.Text = ""
	CenterInfoDisplay.Text = ""
	BottomInfoDisplay.Text = ""
	display.Image = ""
	NameDisplay.Text = ""
	EquippedWeap = nil
	EquippedWeapon = nil
	CurrentWeap.Image = "http://www.roblox.com/asset/?id=7163922662"
	WepName.Text = "No Weapon Equipped"
end

ItemRemote.OnClientEvent:Connect(function(item, tier)
	
	if item == nil then return end
	
	if not item["ID"] and MI[item][GetTier(tier)]["Type"] == "Weapon" then
		if item == script.Parent:GetAttribute("SelectedWeapon") then
			ResetDisplay()
		end
		if not tier and sframe:FindFirstChild(item) then
			sframe[item]:Destroy()
			if item == script.Parent:GetAttribute("SelectedWeapon") then
				ResetDisplay()
			end
		return end
		if sframe:FindFirstChild(item) then
			local Slot = sframe:FindFirstChild(item)
			Slot.Button.Image = "http://www.roblox.com/asset/?id="..MI[item][GetTier(tier)].Image
			Slot:SetAttribute("Level", tier)
		else
			local Slot = script.Frame:Clone()
			Slot.Name = item
			Slot.Button.Image = "http://www.roblox.com/asset/?id="..MI[item][GetTier(tier)].Image
			Slot.Parent = sframe
			Slot:SetAttribute("Level", tier)
			if Rarity.GetRarity(item) == "Event" then
				Slot.Ind.Text = "E★"
				Slot.Ind.TextColor3 = Color3.fromRGB(255,0,0)
				Slot.Ind.Visible = true
			end
			Slot.Visible = true
			Slot.Button.MouseButton1Click:Connect(function()
				CS:Play()
				ActiveChild = Slot.Button
				script.Parent:SetAttribute("SelectedWeapon", item)
				equipbutton.Visible = true
				if Slot == EquippedWeap then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164682924"
				elseif Slot ~= EquippedWeap then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
				end
				if Rarity.GetRarity(item) == "Event" then
					TopInfoDisplay.Text = "Damage: " .. MI[item][GetTier(tier)].DamageMultiplier
					CenterInfoDisplay.Text = "Special: " .. MI[item][GetTier(tier)].Special
					BottomInfoDisplay.Text = "Special Cooldown: " .. MI[item][GetTier(tier)].SpecialCooldown
				else
					TopInfoDisplay.Text = "Damage: " .. MI[item][GetTier(tier)].DamageMultiplier
					CenterInfoDisplay.Text = MI[item][GetTier(tier)].Star
					BottomInfoDisplay.Text = ""
				end
				display.Image = Slot.Button.Image
				NameDisplay.Text = MI[item][GetTier(tier)].Name
				Connections[item] = equipbutton.MouseButton1Click:Connect(function()
					if not Slot:FindFirstChild("Button") then 
						if Connections[item] ~= nil then Connections[item]:Disconnect() Connections[item] = nil end
					return end
					CS:Play()
					if Slot.Button ~= EquippedWeap then
						equip(item,tier)
					elseif Slot.Button == EquippedWeap then
						unequip(item)
					end
				end)
			end)
		end
	elseif item["ID"] and item["Type"] == "Weapon" then
		if item["ID"] == script.Parent:GetAttribute("SelectedWeapon") then
			ResetDisplay()
		end
		if sframe:FindFirstChild(item["ID"]) then
			local Slot = sframe[item["ID"]]
			Slot.Button.Image = "http://www.roblox.com/asset/?id=" .. item["Image"]
		else
			local Slot = script.Frame:Clone()
			Slot.Name = item["ID"]
			Slot.Button.Image = "http://www.roblox.com/asset/?id=" .. item["Image"]
			Slot.Parent = sframe
			if Rarity.GetRarity(item) == "RareLoot" then
				Slot.Ind.Text = "L★"
				Slot.Ind.TextColor3 = Color3.fromRGB(255,170,0)
			elseif Rarity.GetRarity(item) == "Event" then
				Slot.Ind.Text = "E★"
				Slot.Ind.TextColor3 = Color3.fromRGB(255, 0, 0)
			end
			Slot.Ind.Visible = true
			Slot.Visible = true
			Slot.Button.MouseButton1Click:Connect(function()
				CS:Play()
				ActiveChild = Slot.Button
				script.Parent:SetAttribute("SelectedWeapon", item["ID"])
				equipbutton.Visible = true
				if Slot == EquippedWeap then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164682924"
				elseif Slot ~= EquippedWeap then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
				end
				TopInfoDisplay.Text = "Cooldown: " .. item["Cooldown"] .. "s"
				CenterInfoDisplay.Text = "Damage: " .. item["Damage"]
				BottomInfoDisplay.Text = ""
				display.Image = Slot.Button.Image
				NameDisplay.Text = item["DisplayName"] or item["Name"]
				Connections[item] = equipbutton.MouseButton1Click:Connect(function()
					if not Slot:FindFirstChild("Button") then 
						if Connections[item] ~= nil then Connections[item]:Disconnect() Connections[item] = nil end
					return end
					CS:Play()
					if Slot.Button ~= EquippedWeap then
						equip(item,tier)
					elseif Slot.Button == EquippedWeap then
						unequip(item)
					end
				end)
			end)
		end
	end
	
end)

Player.CharacterAdded:Connect(function(Character)
	if EquippedWeapon ~= nil then
		Equip:FireServer(EquippedWeapon)
	end
end)

ItemRemote:FireServer("LoadItem")
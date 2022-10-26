local Player = game.Players.LocalPlayer

local sframe = script.Parent:WaitForChild("ScrollingFrame")
local display = script.Parent:WaitForChild("Preview")

local GUI_Sounds = Player:WaitForChild("PlayerGui"):WaitForChild("GUI_Sounds")
local CS = GUI_Sounds:WaitForChild("ClickSound")

local buttons = sframe:GetChildren()
local TopInfoDisplay = script.Parent:WaitForChild("TopInfo")
local BottomInfoDisplay = script.Parent:WaitForChild("BottomInfo")
local NameDisplay = script.Parent:WaitForChild("Name")
local equipbutton  = script.Parent:WaitForChild("Equipbutton")
local equipped = nil
local ActiveChild = nil
local EquippedArm = nil
local CD = false
local closeButton = script.Parent:WaitForChild("CloseButton")
local MI = require(game.ReplicatedStorage:WaitForChild("WeaponShop"):WaitForChild("ItemData"))
local ItemRemote = game.ReplicatedStorage.WeaponShop:WaitForChild("Item")
local Equip = game.ReplicatedStorage.WeaponShop:WaitForChild("Equip")
local TweenService = game:GetService("TweenService")
local CurrentArm = script.Parent.Parent:WaitForChild("Inventory"):WaitForChild("CurrentArmImage")
local ArmName = script.Parent.Parent:WaitForChild("Inventory"):WaitForChild("ArmName")

local Connections = {}
local EquippedGadget = nil
local Rarity = require(script.Parent.Parent:WaitForChild("RarityModule"))

closeButton.MouseButton1Click:Connect(function() 
	local armormenu = script.Parent
	armormenu:TweenSizeAndPosition(
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
	armormenu.Visible = false
end)

local function GetTier(val)
	return val or 1
end

local function equip(item,tier)
	if CD == false and item ~= EquippedArm then
		CD = true
		EquippedArm = ActiveChild
		EquippedGadget = item
		CurrentArm.Image = EquippedArm.Image
		if item["ID"] then
			ArmName.Text = item["Name"]
		else
			ArmName.Text = MI[item][GetTier(tier)].Name
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
		EquippedArm = nil
		EquippedGadget = nil
		equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
		CurrentArm.Image = "http://www.roblox.com/asset/?id=7163941747"
		ArmName.Text = "No Armor Equipped"
		Equip:FireServer("Unequip2")
		wait(1)
		CD = false
	end
end

local function ResetDisplay()
	script.Parent:SetAttribute("SelectedGadget", "")
	equipbutton.Visible = false
	equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
	TopInfoDisplay.Text = ""
	BottomInfoDisplay.Text = ""
	display.Image = ""
	NameDisplay.Text = ""
	EquippedArm = nil
	EquippedGadget = nil
	CurrentArm.Image = "http://www.roblox.com/asset/?id=7163941747"
	ArmName.Text = "No Armor Equipped"
end

ItemRemote.OnClientEvent:Connect(function(item, tier)
	
	if item == nil then return end
	
	if not item["ID"] and MI[item][GetTier(tier)]["Type"] == "Gadget" then
		if item == script.Parent:GetAttribute("SelectedGadget") then
			ResetDisplay()
		end
		if not tier and sframe:FindFirstChild(item) then
			sframe[item]:Destroy()
			if item == script.Parent:GetAttribute("SelectedGadget") then
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
				script.Parent:SetAttribute("SelectedGadget", item)
				equipbutton.Visible = true
				if Slot.Button == EquippedArm then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164682924"
				elseif Slot.Button ~= EquippedArm then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
				end
				display.Image = Slot.Button.Image
				NameDisplay.Text = MI[item][GetTier(tier)].Name
				if Rarity.GetRarity(item) == "Event" then
					TopInfoDisplay.Text = "Protection: " .. MI[item][GetTier(tier)].Protection
					BottomInfoDisplay.Text = "Modifier: " .. (MI[item][GetTier(tier)].Buff or "None")
				else
					TopInfoDisplay.Text = "Quirk: " .. MI[item][GetTier(tier)].Quirk
					BottomInfoDisplay.Text = MI[item][GetTier(tier)].Information
				end
				Connections[item] = equipbutton.MouseButton1Click:Connect(function()
					if not Slot:FindFirstChild("Button") then 
						if Connections[item] ~= nil then Connections[item]:Disconnect() Connections[item] = nil end
						return end
					CS:Play()
					if Slot.Button ~= EquippedArm then
						equip(item,tier)
					elseif Slot.Button == EquippedArm then
						unequip(item)
					end
				end)
			end)
		end
	elseif item["ID"] and item["Type"] == "Gadget" then
		if item["ID"] == script.Parent:GetAttribute("SelectedGadget") then
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
				Slot.Ind.TextColor3 = Color3.fromRGB(255, 170, 0)
			elseif Rarity.GetRarity(item) == "Event" then
				Slot.Ind.Text = "E★"
				Slot.Ind.TextColor3 = Color3.fromRGB(255, 0, 0)
			end
			
			Slot.Ind.Visible = true
			Slot.Visible = true
			Slot.Button.MouseButton1Click:Connect(function()
				CS:Play()
				ActiveChild = Slot.Button
				script.Parent:SetAttribute("SelectedGadget", item["ID"])
				equipbutton.Visible = true
				
				if Slot.Button == EquippedArm then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164682924"
				elseif Slot.Button ~= EquippedArm then
					equipbutton.Image = "http://www.roblox.com/asset/?id=7164579331"
				end
				
				TopInfoDisplay.Text    = string.format("Boost: %.2f", item["Boost"])
				BottomInfoDisplay.Text = string.format("Armor: %.2f", item["Armour"]/10)
				
				display.Image     = Slot.Button.Image
				NameDisplay.Text  = item["DisplayName"] or item["Name"]
				Connections[item] = equipbutton.MouseButton1Click:Connect(function()
					if not Slot:FindFirstChild("Button") then 
						if Connections[item] ~= nil then Connections[item]:Disconnect() Connections[item] = nil end
					return end
					CS:Play()
					if Slot.Button ~= EquippedArm then
						equip(item,tier)
					elseif Slot.Button == EquippedArm then
						unequip(item)
					end
				end)
			end)
		end
	end
	
end)

Player.CharacterAdded:Connect(function(Character)
	if EquippedGadget ~= nil then
		Equip:FireServer(EquippedGadget)
	end
end)
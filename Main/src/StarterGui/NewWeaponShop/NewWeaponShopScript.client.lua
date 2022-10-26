local Player = game.Players.LocalPlayer
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
local Guis = Player:WaitForChild("PlayerGui")
local Menu = Guis:WaitForChild("MainMenus")
--local MiniMenu = Menu:WaitForChild("Menu")
--local Inventory = MiniMenu:WaitForChild("Inventory")
local ArmorMenu, WeaponsMenu = Menu.ArmorMenu, Menu.WeaponsMenu -- Armor menu is for gadgets, 
local Cash = PlayerData:WaitForChild("Cash")

local HatsumeButton = workspace.InteractionNPCS.MeiHatsume.Interact
local WeaponGUI = script.Parent

-- Sounds --
local GUI_Sounds = WeaponGUI.Parent:WaitForChild("GUI_Sounds")
local ClickSound = GUI_Sounds:WaitForChild("ClickSound")
local PurchaseSuccess = GUI_Sounds:WaitForChild("PurchaseSuccess")
local PurchaseFail = GUI_Sounds:WaitForChild("PurchaseFail")

local ShopFrame = WeaponGUI:WaitForChild("ShopFrame")

local Transaction = false
local CashDisplay = ShopFrame:WaitForChild("CashDisplay")
local ChangeClone, CCTween
local BeforeCash = Cash.Value
CashDisplay.Text = "Cash: $".. Cash.Value

Cash:GetPropertyChangedSignal("Value"):Connect(function()
	CashDisplay.Text = "Cash: $".. Cash.Value
	if not Transaction then
		BeforeCash = Cash.Value
	return end
	if ChangeClone ~= nil then ChangeClone:Destroy() CCTween:Cancel() end
	ChangeClone = CashDisplay.CashChange:Clone()
	ChangeClone.Parent = ShopFrame
	ChangeClone.Visible = true
	local Add = Cash.Value - BeforeCash
	BeforeCash = Cash.Value
	if Add > 0 then
		ChangeClone.TextColor3 = Color3.fromRGB(0, 255, 0)
		ChangeClone.Text = "+$" .. Add
	else
		ChangeClone.TextColor3 = Color3.fromRGB(255, 0, 0)
		ChangeClone.Text = "-$" .. Add*-1
	end	
	if ChangeClone == nil then return end
	CCTween = game.TweenService:Create(ChangeClone, TweenInfo.new(0.2), {TextTransparency = 0, TextStrokeTransparency = 0, Position = UDim2.fromScale(-0.35, 0.91)})
	CCTween:Play() CCTween.Completed:Wait()
	if ChangeClone == nil then return end
	CCTween = game.TweenService:Create(ChangeClone, TweenInfo.new(0.2), {TextTransparency = 0, TextStrokeTransparency = 0, Position = UDim2.fromScale(-0.35, 0.996)})
	CCTween:Play() CCTween.Completed:Wait()
	wait(2)
	if ChangeClone == nil then return end
	CCTween = game.TweenService:Create(ChangeClone, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1})
	CCTween:Play() CCTween.Completed:Wait()
	CCTween = nil
	if ChangeClone ~= nil then ChangeClone:Destroy() ChangeClone = nil end
end)


local ReplicatedStorage = game:GetService("ReplicatedStorage") 
local DataGrab = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NPCs"):WaitForChild("NPCReward"):WaitForChild("DataGrab")

local SwitchFrame = ShopFrame:WaitForChild("SwitchFrame")
local ExitButton = SwitchFrame:WaitForChild("ExitButton")

local AppearUDIM = UDim2.fromScale(0.333, 0.197)
local DisappearUDIM = UDim2.fromScale(0.333, 1.2)
local ItemRemote = ReplicatedStorage.WeaponShop:WaitForChild("Item")
local ConfirmRemote = ReplicatedStorage.WeaponShop:WaitForChild("Confirm")
local SellRemote = ReplicatedStorage.WeaponShop:WaitForChild("Sell")

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
			UpdateLootGUI()
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

local TransactionCooldown = false

local WeaponFrame = SwitchFrame:WaitForChild("WeaponButton")
local WeaponMenu = ShopFrame:WaitForChild("WeaponShop")
local WeaponDisplay = WeaponMenu:WaitForChild("ItemFrame")
local WeaponScroll = WeaponMenu:WaitForChild("Scroll")
local WeaponBuyConnection
local WeaponSellConnection
local WeaponConfirmConnection
local SelectedWeapon

local GadgetFrame = SwitchFrame:WaitForChild("GadgetButton")
local GadgetMenu = ShopFrame:WaitForChild("GadgetShop")
local GadgetDisplay = GadgetMenu:WaitForChild("ItemFrame")
local GadgetScroll = GadgetMenu:WaitForChild("Scroll")
local InfoButton =  GadgetDisplay:WaitForChild("InfoButton")
local GadgetBuyConnection
local GadgetSellConnection
local GadgetConfirmConnection
local GadgetInfoConnection
local SelectedGadget

local LootItemFrame = SwitchFrame:WaitForChild("LootButton")
local LootItemMenu = ShopFrame:WaitForChild("LootShop")
local LootItemDisplay = LootItemMenu:WaitForChild("ItemFrame")
local LootItemScroll = LootItemMenu:WaitForChild("Scroll")
local LootItemSellConnection
local LootItemConfirmConnection
local LootItemInfoConnection
local SelectedLootItem

local WeapPattern = {
	{ -- BASE
		["Size"] = UDim2.fromScale(0.9, 0.1125),
		["Position"] = UDim2.fromScale(0.05, 0.914)
	},
	{ -- TOP
		["Size"] = UDim2.fromScale(0.8, 0.1),
		["Position"] = UDim2.fromScale(0.1, 0.84)
	},
	{ -- BOTTOM
		["Size"] = UDim2.fromScale(0.8, 0.1),
		["Position"] = UDim2.fromScale(0.1, 0.96)
	}
}

local GadgPattern = {
	{ -- BASE
		["Size"] = UDim2.fromScale(0.9, 0.1125),
		["Position"] = UDim2.fromScale(0.045, 0.93)
	},
	{ -- TOP
		["Size"] = UDim2.fromScale(0.8, 0.075),
		["Position"] = UDim2.fromScale(0.1, 0.915)
	},
	{ -- BOTTOM
		["Size"] = UDim2.fromScale(0.8, 0.075),
		["Position"] = UDim2.fromScale(0.1, 1)
	}
}

local function BuyCool(Name)
	TransactionCooldown = true
	coroutine.wrap(function()
		WeaponDisplay[Name].TextTransparency = .3
		WeaponDisplay[Name].Background.ImageTransparency = .3
		GadgetDisplay[Name].TextTransparency = .3
		GadgetDisplay[Name].Background.ImageTransparency = .3
		ConfirmRemote.OnClientEvent:Wait()
--		wait(1)
		TransactionCooldown = false
		WeaponDisplay[Name].TextTransparency = 0
		WeaponDisplay[Name].Background.ImageTransparency = 0
		GadgetDisplay[Name].TextTransparency = 0
		GadgetDisplay[Name].Background.ImageTransparency = 0
	end)()
end

WeaponFrame.Button.MouseButton1Click:Connect(function()
	if WeaponMenu.Visible == false then
		ClickSound:Play()
		InfoPanel.Visible = false
		GadgetMenu.Visible = false
		LootItemMenu.Visible = false
--		GadgetFrame.ImageTransparency = 0
--		LootItemFrame.ImageTransparency = 0
		WeaponMenu.Visible = true
--		WeaponFrame.ImageTransparency = .2
	end
end)

GadgetFrame.Button.MouseButton1Click:Connect(function()
	if GadgetMenu.Visible == false then
		ClickSound:Play()
		InfoPanel.Visible = false
		WeaponMenu.Visible = false
		LootItemMenu.Visible = false
--		WeaponFrame.ImageTransparency = 0
--		LootItemFrame.ImageTransparency = 0
		GadgetMenu.Visible = true
--		GadgetFrame.ImageTransparency = .2
	end
end)

ReturnButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	InfoPanel.Visible = false
	GadgetMenu.Visible = true
end)

local ErrorMessage = script:WaitForChild("ErrorMessage")
local ErrorTween, ErrorTween2

local function Error(message)
	if message ~= nil then
		local s = ShopFrame:FindFirstChild("ErrorMessage")
		if s then
			s:Destroy()
			ErrorTween = nil
			ErrorTween2 = nil
		end
		local NewEM = ErrorMessage:Clone()
		NewEM.Parent = ShopFrame
		NewEM.Text = "Error: " .. message
		NewEM.TextColor3 = Color3.fromRGB(255, 0, 0)
		NewEM.Visible = true
		NewEM.TextTransparency = 0
		NewEM.TextStrokeTransparency = 0
		coroutine.wrap(function()
			for i=1,6 do
				if i == 6 then
					ErrorTween2 = game.TweenService:Create(NewEM, TweenInfo.new(.6), {TextTransparency = 1, TextStrokeTransparency = 1})
					ErrorTween2:Play()
				end
				if NewEM == nil then return end
				ErrorTween = game.TweenService:Create(NewEM, TweenInfo.new(.3), {TextColor3 = Color3.fromRGB(255, 0, 0)})
				ErrorTween:Play() ErrorTween.Completed:Wait()
				if NewEM == nil then return end
				ErrorTween = game.TweenService:Create(NewEM, TweenInfo.new(.3), {TextColor3 = Color3.fromRGB(150, 0, 0)})
				ErrorTween:Play() ErrorTween.Completed:Wait()
				if NewEM == nil then return end
			end
			if NewEM ~= nil then
				ErrorTween = nil ErrorTween2 = nil
				NewEM:Destroy()
			end
		end)()
	end
end

local MI = require(ReplicatedStorage:WaitForChild("WeaponShop").ItemData)

local function DisplayNext(name, val)
	if val == nil or val == 0 then
		val = 1
	elseif val > 0 then
		val = val + 1
	end
	local ID = MI[name][val]
	if ID == nil then
		repeat
			val = val - 1
			ID = MI[name][val]
		until ID ~= nil
	end
	return val
end

local Weapons = {}
local Gadgets = {}
for v,itemname in pairs(MI) do
	if MI[v][DisplayNext(v, nil)].Cost ~= nil then
		local Clone = script.Slot:Clone()
		if MI[v][DisplayNext(v, nil)].Type == "Weapon" then
			Clone.Parent = WeaponScroll
			table.insert(Weapons, Clone)
		else
			Clone.Parent = GadgetScroll
			table.insert(Gadgets, Clone)
		end
		Clone.Name = v
		Clone.Image = "rbxassetid://" .. MI[v][DisplayNext(v, nil)].Image
	end
end

for i=1,#Weapons do
	Weapons[i].MouseButton1Click:Connect(function()
		ClickSound:Play()
		if WeaponBuyConnection then WeaponBuyConnection:Disconnect() WeaponBuyConnection = nil end
		if WeaponSellConnection then WeaponSellConnection:Disconnect() WeaponSellConnection = nil end
		for l=1,#Weapons do
			Weapons[l].SelectOutline.Visible = false
		end
		Weapons[i].SelectOutline.Visible = true
		WeaponDisplay.Visible = true
		SelectedWeapon = Weapons[i].Name
		local function UpdateGUI()
			local d = Weapons[i]:GetAttribute("Level")
			local dn = DisplayNext(Weapons[i].Name, d)
			if d > 3 then
				d = 3
			end
			WeaponDisplay.ImageLabel.Image = "rbxassetid://" .. MI[Weapons[i].Name][dn].Image
			WeaponDisplay.Cost.Text = "Cost: $" .. MI[Weapons[i].Name][dn].Cost
			WeaponDisplay.Upgrade.Text = "Upgrade: " .. MI[Weapons[i].Name][dn].Star
			WeaponDisplay.Damage.Text = "Damage Multiplier: " .. MI[Weapons[i].Name][dn].DamageMultiplier
			WeaponDisplay.Buy.Visible = true
			if Weapons[i]:GetAttribute("Level") == 0 then
				for v,prop in pairs(WeapPattern[1]) do
					WeaponDisplay.Buy[v] = prop
					WeaponDisplay.Sell[v] = prop
				end
				WeaponDisplay.Buy.Text = "Purchase"
				WeaponDisplay.Sell.Text = ""
				WeaponDisplay.Sell.Visible = false
			elseif Weapons[i]:GetAttribute("Level") > 0 and Weapons[i]:GetAttribute("Level") < 3 then
				for v,prop in pairs(WeapPattern[2]) do
					WeaponDisplay.Buy[v] = prop
				end
				for v,prop in pairs(WeapPattern[3]) do
					WeaponDisplay.Sell[v] = prop
				end
				WeaponDisplay.Buy.Text = "Upgrade"
				WeaponDisplay.Sell.Text = "Sell: $" .. MI[Weapons[i].Name][Weapons[i]:GetAttribute("Level")].Cost/2
				WeaponDisplay.Sell.Visible = true
			else
				for v,prop in pairs(WeapPattern[1]) do
					WeaponDisplay.Buy[v] = prop
					WeaponDisplay.Sell[v] = prop
				end
				if Weapons[i]:GetAttribute("Level") > 1 then
					WeaponDisplay.Cost.Text = "Max Upgrade"
				else
					WeaponDisplay.Cost.Text = "Purchased"
				end
				WeaponDisplay.Sell.Text = "Sell: $" .. MI[Weapons[i].Name][Weapons[i]:GetAttribute("Level")].Cost/2
				WeaponDisplay.Buy.Visible = false
				WeaponDisplay.Sell.Visible = true
			end
		end
		UpdateGUI()
		WeaponBuyConnection = WeaponDisplay.Buy.MouseButton1Click:Connect(function()
			if Weapons[i]:GetAttribute("Level") >= 0 and Weapons[i]:GetAttribute("Level") < 3 then
				if TransactionCooldown then return end
				BuyCool("Buy") BuyCool("Sell")
				Transaction = true
				ClickSound:Play()
				WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm, failmessage)
					WeaponConfirmConnection:Disconnect()
					if confirm then
						PurchaseSuccess:Play()						
						UpdateGUI()
					else
						PurchaseFail:Play()
						Error(failmessage)
						for i=1,3 do
							WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
							wait(.06)
							WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
							wait(.06)
						end
						WeaponDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
					end
					Transaction = false
				end)
				ItemRemote:FireServer(Weapons[i].Name)
			end
		end)
		WeaponSellConnection = WeaponDisplay.Sell.MouseButton1Click:Connect(function()
			if Weapons[i]:GetAttribute("Level") > 0 then
				if TransactionCooldown then return end
				BuyCool("Buy") BuyCool("Sell")
				Transaction = true
				ClickSound:Play()
				WeaponConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm, failmessage)
					WeaponConfirmConnection:Disconnect()
					if confirm then
						PurchaseSuccess:Play()
						local uitarget = WeaponsMenu.ScrollingFrame:FindFirstChild(Weapons[i].Name)
						if uitarget then
							uitarget:Destroy()
						end						
						UpdateGUI()
					else
						PurchaseFail:Play()
						Error(failmessage)
						for i=1,3 do
							WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
							wait(.06)
							WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
							wait(.06)
						end
						WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
					end
					Transaction = false
				end)
				SellRemote:FireServer(Weapons[i].Name)
			end
		end)
	end)
end

LootItemFrame.Button.MouseButton1Click:Connect(function()
	ClickSound:Play()
	InfoPanel.Visible = false
	GadgetMenu.Visible = false
	WeaponMenu.Visible = false	
--	WeaponFrame.ImageTransparency = 0
--	GadgetFrame.ImageTransparency = 0
--	LootItemFrame.ImageTransparency = 0.2
	LootItemMenu.Visible = true
	UpdateLootGUI()
end)

function UpdateLootGUI()
	local data = DataGrab:InvokeServer(Player)
	if data then
		for index, value in pairs(data) do
			if typeof(value) == "table" and value["ID"] and not LootItemScroll:FindFirstChild(value.ID) then
				local Clone = script.Slot:Clone()
				Clone.Parent = LootItemScroll	
				Clone.Name = value.ID
				Clone.Image = "rbxassetid://"..value.Image
				Clone.MouseButton1Click:Connect(function()
					ClickSound:Play()
					if LootItemSellConnection ~= nil then LootItemSellConnection:Disconnect() LootItemSellConnection = nil end
					Clone.SelectOutline.Visible = true
					LootItemDisplay.Visible = true
					if SelectedLootItem and SelectedLootItem:FindFirstChild("SelectOutline") then
						SelectedLootItem.SelectOutline.Visible = false
					end
					SelectedLootItem = Clone
					LootItemDisplay.ImageLabel.Image = "rbxassetid://"..value.Image
					LootItemDisplay.Sell.Text = "Sell: $"..value.Worth
					if value["Type"] == "Weapon" then
						LootItemDisplay.Cooldown.Text = "Cooldown: "..value.Cooldown
						LootItemDisplay.Damage.Text = "Damage Multiplier: "..value.Damage						
					else
						LootItemDisplay.Cooldown.Text = "Armour: "..value.Armour/10
						LootItemDisplay.Damage.Text = "Boost: "..value.Boost
					end
					LootItemDisplay.Buy.Visible = false
					LootItemSellConnection = LootItemDisplay.Sell.MouseButton1Click:Connect(function()
						if TransactionCooldown then return end
						BuyCool("Buy") BuyCool("Sell")
						Transaction = true
						ClickSound:Play()
						LootItemConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm, failmessage)
							LootItemConfirmConnection:Disconnect()		
							if confirm then
								PurchaseSuccess:Play()
								LootItemDisplay.Visible = false
								local uitarget = WeaponsMenu.ScrollingFrame:FindFirstChild(value.ID) or ArmorMenu.ScrollingFrame:FindFirstChild(value.ID)
								if uitarget then
									uitarget:Destroy()
								end
								Clone:Destroy()
							else
								PurchaseFail:Play()
								Error(failmessage)
								for i=1,3 do
									WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
									wait(.06)
									WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
									wait(.06)
								end
								WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
							end
							LootItemConfirmConnection:Disconnect()			
							Transaction = false
						end)
						SellRemote:FireServer(value)
					end)
				end)
			end
		end
	end	
end

for i=1,#Gadgets do
	Gadgets[i].MouseButton1Click:Connect(function()
		ClickSound:Play()
		if GadgetBuyConnection ~= nil then GadgetBuyConnection:Disconnect() end
		if GadgetSellConnection ~= nil then GadgetSellConnection:Disconnect() end
		for l=1,#Gadgets do
			Gadgets[l].SelectOutline.Visible = false
		end
		Gadgets[i].SelectOutline.Visible = true
		GadgetDisplay.Visible = true
		SelectedGadget = Gadgets[i].Name
		local function UpdateGUI()
			local d = Gadgets[i]:GetAttribute("Level")
			local dn = DisplayNext(Gadgets[i].Name, d)
			InfoButton.Text = "More Information"
			if GadgetInfoConnection ~= nil then GadgetInfoConnection:Disconnect() end
			GadgetInfoConnection = InfoButton.MouseButton1Click:Connect(function()
				ClickSound:Play()
				GadgetMenu.Visible = false
				InfoPanel.Visible = true
				GadgetInfo.Text = MI[Gadgets[i].Name][dn].GadgetName
				MainInfo.Text = MI[Gadgets[i].Name][dn].MainInfo
				for l=1,#Information do
					Information[l].TextColor3 = MI[Gadgets[i].Name][dn].InfoColor
				end
				for l=1,6 do
					Information[l+2].Text = MI[Gadgets[i].Name][dn].InfoList[l]
				end
			end)
			GadgetDisplay.ImageLabel.Image = "rbxassetid://" .. MI[Gadgets[i].Name][dn].Image
			GadgetDisplay.Cost.Text = "Cost: $" .. MI[Gadgets[i].Name][dn].Cost
			GadgetDisplay.Upgrade.Text = "Quirk: " .. MI[Gadgets[i].Name][dn].Quirk
			GadgetDisplay.Info2.Text = MI[Gadgets[i].Name][dn].Information
			GadgetDisplay.Buy.Visible = true
			if Gadgets[i]:GetAttribute("Level") == 0 then
				for v,prop in pairs(GadgPattern[1]) do
					GadgetDisplay.Buy[v] = prop
					GadgetDisplay.Sell[v] = prop
				end
				GadgetDisplay.Sell.Visible = false
				GadgetDisplay.Buy.Text = "Purchase"
			elseif Gadgets[i]:GetAttribute("Level") == 1 and MI[Gadgets[i].Name][Gadgets[i]:GetAttribute("Level")+1] ~= nil then
				for v,prop in pairs(GadgPattern[2]) do
					GadgetDisplay.Buy[v] = prop
				end
				for v,prop in pairs(GadgPattern[3]) do
					GadgetDisplay.Sell[v] = prop
				end
				GadgetDisplay.Sell.Visible = true
				GadgetDisplay.Sell.Text = "Sell: $" .. MI[Gadgets[i].Name][Gadgets[i]:GetAttribute("Level")].Cost/2
				GadgetDisplay.Buy.Text = "Upgrade"
			else
				for v,prop in pairs(GadgPattern[1]) do
					GadgetDisplay.Buy[v] = prop
					GadgetDisplay.Sell[v] = prop
				end
				GadgetDisplay.Sell.Visible = true
				GadgetDisplay.Sell.Text = "Sell: $" .. MI[Gadgets[i].Name][Gadgets[i]:GetAttribute("Level")].Cost/2
				if Gadgets[i]:GetAttribute("Level") > 1 then
					GadgetDisplay.Cost.Text = "Max Upgrade"
				else
					GadgetDisplay.Cost.Text = "Purchased"
				end
				GadgetDisplay.Buy.Visible = false
			end
		end
		SellRemote.OnClientEvent:Connect(function(Item)
			if SelectedGadget == Gadgets[i].Name then
				PurchaseSuccess:Play()
				UpdateGUI()
			end
		end)
		UpdateGUI()
		GadgetBuyConnection = GadgetDisplay.Buy.MouseButton1Click:Connect(function()
			if Gadgets[i]:GetAttribute("Level") >= 0 and Gadgets[i]:GetAttribute("Level") <= 3 then
				if TransactionCooldown then return end
				BuyCool("Buy") BuyCool("Sell")
				Transaction = true
				ClickSound:Play()
				GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm, failmessage)
					GadgetConfirmConnection:Disconnect()
					if confirm then
						PurchaseSuccess:Play()
						UpdateGUI()
					else
						PurchaseFail:Play()
						Error(failmessage)
						for i=1,3 do
							GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
							wait(.06)
							GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
							wait(.06)
						end
						GadgetDisplay.Buy.Background.ImageColor3 = Color3.fromRGB(0, 150, 0)
					end
					Transaction = false
				end)
				ItemRemote:FireServer(Gadgets[i].Name)
			end
		end)
		GadgetSellConnection = GadgetDisplay.Sell.MouseButton1Click:Connect(function()
			if Gadgets[i]:GetAttribute("Level") > 0 then
				if TransactionCooldown then return end
				BuyCool("Buy") BuyCool("Sell")
				Transaction = true
				ClickSound:Play()
				GadgetConfirmConnection = ConfirmRemote.OnClientEvent:Connect(function(confirm, failmessage)
					GadgetConfirmConnection:Disconnect()
					if confirm then
						local uitarget = ArmorMenu.ScrollingFrame:FindFirstChild(Gadgets[i].Name)
						if uitarget then
							uitarget:Destroy()
						end				
						PurchaseSuccess:Play()
						UpdateGUI()
					else
						PurchaseFail:Play()
						Error(failmessage)
						for i=1,3 do
							WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(255, 0, 0)
							wait(.06)
							WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
							wait(.06)
						end
						WeaponDisplay.Sell.Background.ImageColor3 = Color3.fromRGB(150, 0, 0)
					end
					Transaction = false
				end)
				SellRemote:FireServer(Gadgets[i].Name)
			end
		end)
	end)
end

ItemRemote.OnClientEvent:Connect(function(name, val, bought)
	if bought == "Found" then 
		UpdateLootGUI()
	return end
	local Item = name
	if not name["ID"] then
		Item = MI[name][DisplayNext(name, val)]
	end
	local Type = Item.Type
	local DIR
	if Type == "Weapon" then
		DIR = WeaponScroll
	else
		DIR = GadgetScroll
	end
	if Item.Cost == nil then return end
	DIR[name].Image = "rbxassetid://" .. Item.Image
	if val == nil then
		DIR[name]:SetAttribute("Level", 0)
	else
		DIR[name]:SetAttribute("Level", val)
	end
end)

ItemRemote:FireServer("LoadItem")
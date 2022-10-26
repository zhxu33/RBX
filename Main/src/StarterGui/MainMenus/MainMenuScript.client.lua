-- Written By Art // Purpose : Opening Main Menus and Animations for Main Menus
-- Main Menus
local Gui          = script.Parent

local ActiveMenu   = Gui:WaitForChild("StatsPage")
local LeftMenu     = Gui:WaitForChild("Options")
local RightMenu    = Gui:WaitForChild("Inventory")
local BackMenu     = Gui:WaitForChild("Skills")
local weaponMenu   = Gui:WaitForChild("WeaponsMenu")
local armorMenu    = Gui:WaitForChild("ArmorMenu")

local RightClicker = Gui:WaitForChild("clickright")
local LeftClicker  = Gui:WaitForChild("clickleft")

-- // Help Menus
local HelpGui      = Gui.Parent:WaitForChild("HelpMenus")

local HelpQuirk   = HelpGui:WaitForChild("Quirks")
local HelpControl = HelpGui:WaitForChild("Controls")
local HelpTips    = HelpGui:WaitForChild("Tips")
local HelpRules   = HelpGui:WaitForChild("Rules")

local HelpActive  = HelpQuirk
local HelpLeft    = HelpControl
local HelpRight   = HelpTips
local HelpBack    = HelpRules

-- Modules
local ShortCuts = require(Gui.Parent:WaitForChild("UIShortCuts"))

--Close Buttons For Menus
local ActiveClose  = ActiveMenu:WaitForChild("CloseButton")
local OptionsClose = LeftMenu:WaitForChild("CloseButton")
local InvClose     = RightMenu:WaitForChild("CloseButton")
local SkillsClose  = BackMenu:WaitForChild("CloseButton")

--Nil Var
local NewBackMenu   = nil
local NewActiveMenu = nil
local NewRightMenu  = nil
local NewLeftMenu   = nil

--etc
local GuiFocus     = Gui:WaitForChild("ActiveGui")
local TweenService = game:GetService("TweenService")
local openButton   = script.Parent.Parent:WaitForChild("playerhud"):WaitForChild("MenuButton")

-- Debounces
local DebounceLR = tick()
local DebounceOC = tick()

-- // Tween info
local Info1 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In,0)  -- text tween
local Info2 = TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In,0)  -- Active becoming left reverse
local Info3 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In,0)  -- Right Becoming Active reverse

-- // Goals & Other
local LockCheck = UDim2.new(0.317, 0,0.18, 0) -- // Not sure

local ImageGoal       = {ImageTransparency      = 0}
local TextGoal        = {TextTransparency       = 0}
local BackgroundGoal  = {BackgroundTransparency = 0}
local ImageGoal2      = {ImageTransparency      = 0.8}
local TextGoal2       = {TextTransparency       = 0.8}
local BackgroundGoal2 = {BackgroundTransparency = 0.8}

-- // Checks if any of the help menus are active
local function check()
	local menus = {HelpQuirk, HelpControl, HelpTips, HelpRules}

	for _, Menu in pairs(menus) do
		if (Menu.Position ~= LockCheck) then continue end
		
		return true
	end
end

-- // Closes or opens main menu & help menus
local function click()
	GuiFocus.Value  = ActiveMenu

	if (armorMenu.Visible or weaponMenu.Visible) then return end
	if not (DebounceOC <= (tick() - 0.5)) then return end
	DebounceOC = tick()
	
	if check() then
		ShortCuts.MenuTest(HelpActive, HelpLeft, HelpRight, HelpBack, Gui, {0, false})
		ShortCuts.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, {1, true})
	elseif (ActiveMenu.Position == LockCheck) then
		ShortCuts.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, {0, false})
	else
		ShortCuts.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, {1, true})
	end
end

-- // Page Functions
-- // Makes passed menu into the new active menu
local function MakeActiveMenu(Menu) : ImageLabel
	TweenService:Create(Menu, Info3, ImageGoal):Play()
	Menu.ZIndex   = 1
	local menudes = Menu:GetDescendants()
	
	-- // Close button
	local CloseButton = Menu:FindFirstChild("CloseButton")
	if CloseButton then CloseButton.Visible = true end
	
	local CodesImage  = Menu:FindFirstChild("DonateImage")
	local DonateImage = Menu:FindFirstChild("CodesImage")
	
	if CodesImage  then CodesImage.ZIndex  = 2; TweenService:Create(CodesImage,  Info1, ImageGoal):Play() end
	if DonateImage then DonateImage.ZIndex = 2; TweenService:Create(DonateImage, Info1, ImageGoal):Play() end
	
	for _, descendent in pairs(menudes) do
		if not (descendent:IsA("GuiBase")) or (descendent == CloseButton or descendent == CodesImage or descendent == DonateImage) then continue end
		descendent.ZIndex = 1
		
		local ClassName = descendent.ClassName
		local Goal      = (ClassName == "Frame" and BackgroundGoal) or (ClassName == "ImageLabel" or ClassName == "ImageButton") and ImageGoal or TextGoal

		TweenService:Create(descendent, Info1, Goal):Play()
	end
	
	return Menu
end

-- // Makes passed active menu into new passive menu
local function MakeActiveAPassiveMenu(Menu, Goal)
	TweenService:Create(Menu, Info2, ImageGoal2):Play()
	Menu.ZIndex = -1
	
	local menudes = Menu:GetDescendants()
	
	-- // Close button
	local CloseButton = Menu:FindFirstChild("CloseButton")
	if CloseButton then CloseButton.Visible = false end
	
	for _, descendent in pairs(menudes) do
		if not (descendent:IsA("GuiBase")) or (descendent == CloseButton) then continue end

		descendent.ZIndex = -1

		local ClassName = descendent.ClassName
		local Goal      = (ClassName == "Frame" and BackgroundGoal2) or (ClassName == "ImageLabel" or ClassName == "ImageButton") and ImageGoal2 or TextGoal2

		TweenService:Create(descendent, Info1, Goal):Play()
	end

	return Menu
end

-- // Scrolls page
local function Scroll(Obj, Direction)
	Obj:TweenSizeAndPosition(table.unpack(Direction))
end

local function ScrollPage(Left, Right, Front, Back) -- // New (Left | Right | Front | Back)
	if (weaponMenu.Visible or armorMenu.Visible) then return end
	if not (DebounceLR <= tick() - 0.5) then return end
	DebounceLR = tick()
	
	MakeActiveAPassiveMenu(ActiveMenu) -- // Previous active menu (Could be either right or left)
	ActiveMenu, LeftMenu, RightMenu, BackMenu = Front, Left, Right, Back
	GuiFocus.Value = MakeActiveMenu(ActiveMenu)
	
	Scroll(BackMenu,   {UDim2.new(0.506, 0,0.506, 0), UDim2.new(0.359, 0,0.239, 0), "Out", "Quad", 1, true})
	Scroll(LeftMenu,   {UDim2.new(0.506, 0,0.506, 0), UDim2.new(0.219, 0,0.247, 0), "Out", "Quad", 1, true})
	Scroll(ActiveMenu, {UDim2.new(0.649, 0,0.649, 0), UDim2.new(0.317, 0,0.18,  0), "Out", "Quad", 1, true})
	Scroll(RightMenu,  {UDim2.new(0.506, 0,0.506, 0), UDim2.new(0.514, 0,0.247, 0), "Out", "Quad", 1, true})
end

LeftClicker.MouseButton1Click:Connect(function()
	ScrollPage(BackMenu, ActiveMenu, LeftMenu, RightMenu)
end)

RightClicker.MouseButton1Click:Connect(function()
	ScrollPage(ActiveMenu, BackMenu, RightMenu, LeftMenu)
end)

-- // Events
openButton.MouseButton1Click:Connect(click)
ActiveClose.MouseButton1Click:Connect(click)
OptionsClose.MouseButton1Click:Connect(click)
InvClose.MouseButton1Click:Connect(click)
SkillsClose.MouseButton1Click:Connect(click)

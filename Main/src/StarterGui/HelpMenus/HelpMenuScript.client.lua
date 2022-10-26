-- Written By Art // Purpose Help Menu Gui stuff
--Menus
local Gui = script.Parent
local MainGui = script.Parent.Parent:WaitForChild("MainMenus")
local ActiveMenu = Gui:WaitForChild("Quirks")
local LeftMenu = Gui:WaitForChild("Controls")
local RightMenu = Gui:WaitForChild("Tips")
local BackMenu = Gui:WaitForChild("Rules")
local RightClicker = Gui:WaitForChild("clickright")
local LeftClicker = Gui:WaitForChild("clickleft")
-- Modules
local ShortCuts = require(Gui.Parent:WaitForChild("UIShortCuts"))
--Close Buttons For Menus
local ActiveClose = ActiveMenu:WaitForChild("CloseButton")
local OptionsClose = LeftMenu:WaitForChild("CloseButton")
local InvClose = RightMenu:WaitForChild("CloseButton")
local SkillsClose = BackMenu:WaitForChild("CloseButton")
--Holder Var
local NewBackMenu = nil
local NewActiveMenu = nil
local NewRightMenu = nil
local NewLeftMenu = nil
--etc
local TweenService = game:GetService("TweenService")
local openButton = script.Parent.Parent:WaitForChild("playerhud"):WaitForChild("HelpButton")
-- Debounces
local DebounceLR = tick()
local DebounceOC = tick()



local function visible()
	local menulocks = {script.Parent:WaitForChild("CommonMenu"), script.Parent:WaitForChild("UncommonMenu"),script.Parent:WaitForChild("RareMenu"),script.Parent:WaitForChild("LegendaryMenu"),script.Parent:WaitForChild("MythicMenu")}
	for i = 1, #menulocks do if menulocks[i].Visible then return true end end
end

local function check()
	local StatsLock = UDim2.new(0.317, 0,0.18, 0)
	local menus = {script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("StatsPage"),script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("Skills"),script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("Options"),script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("Inventory")}
	for i = 1, #menus do
		if menus[i].Position == StatsLock then
			return true
		end
	end
end

local function click()
	local weap = script.Parent.Parent:WaitForChild("MainMenus").WeaponsMenu
	local armo = script.Parent.Parent:WaitForChild("MainMenus").ArmorMenu
	if visible() then 
	elseif check() then 
		if weap.Visible == true then
			weap:TweenSizeAndPosition(UDim2.new(0.018, 0,0.032, 0),UDim2.new(0.482, 0,0.433, 0),"In","Quad",0.5,true)
			wait(0.45)
			weap.Visible = false
		elseif armo.Visible == true then
			armo:TweenSizeAndPosition(UDim2.new(0.018, 0,0.032, 0),UDim2.new(0.482, 0,0.433, 0),"In","Quad",0.5,true)
			wait(0.45)
			armo.Visible = false
		end
		local MainActive = script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("StatsPage")
		local MainLeft = script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("Skills")
		local MainRight = script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("Inventory")
		local MainBack = script.Parent.Parent:WaitForChild("MainMenus"):WaitForChild("Options")
		--[[MainActive:TweenPosition(UDim2.new(0.317, 0,-1.18, 0),"Out","Quint",1,true)
		wait(0.1)
		MainLeft:TweenPosition(UDim2.new(0.219, 0,-1.247, 0),"Out","Quint",1,true)
		wait(0.1)
		MainRight:TweenPosition(UDim2.new(0.514, 0,-1.247, 0),"Out",	"Quint",1,true)
		wait(0.1)
		MainBack:TweenPosition(UDim2.new(0.359, 0,-1.239, 0),"Out","Quint",1,true)
		script.Parent.clickleft.Visible = false
		script.Parent.clickright.Visible = false
		wait(0.1)
		MainGui.Enabled=false
		wait(0.2)
		Gui.Enabled=true
		ActiveMenu:TweenPosition(UDim2.new(0.317, 0,0.18, 0),	"Out","Quart",1,true	)
		wait(0.1)
		LeftMenu:TweenPosition(	UDim2.new(0.219, 0,0.247, 0),"Out",	"Quart",1,	true)
		wait(0.1)
		RightMenu:TweenPosition(UDim2.new(0.514, 0,0.247, 0),"Out","Quart",1,true)
		wait(0.1)
		BackMenu:TweenPosition(UDim2.new(0.359, 0,0.239, 0),	"Out","Quart",1,true	)
		script.Parent.clickleft.Visible = true
		script.Parent.clickright.Visible = true]]
		ShortCuts.MenuTest(MainActive, MainLeft, MainRight, MainBack, Gui, {0, false})
		ShortCuts.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, {1, true})
	else
		local Activelock = UDim2.new(0.317, 0,0.18, 0)
		if ActiveMenu.Position == Activelock then
			ShortCuts.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, {0, false})
		else
			ShortCuts.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, {1, true})
		end
	end
end


openButton.MouseButton1Click:Connect(click)
ActiveClose.MouseButton1Click:Connect(click)
OptionsClose.MouseButton1Click:Connect(click)
InvClose.MouseButton1Click:Connect(click)
SkillsClose.MouseButton1Click:Connect(click)

LeftClicker.MouseButton1Click:Connect(function()
	if visible(true) then
	elseif DebounceLR <= tick()-0.5 then
		DebounceLR = tick()
		local children = script.Parent:GetChildren()
		local Info1 = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0)  -- text tween
		local Info2 = TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0)  --  Active becoming left reverse
		local Info3 = TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0)  -- Right Becoming Active reverse
		local ImageGoal = {ImageTransparency = 0}
		local TextGoal = {TextTransparency = 0}
		local BackgroundGoal = {BackgroundTransparency = 0}
		local ImageGoal2 = {ImageTransparency = 0.8}
		local TextGoal2 = {TextTransparency = 0.8}
		local BackgroundGoal2 = {BackgroundTransparency = 0.8}
		for i, child in ipairs(children) do
			if child.ClassName == "ImageLabel" then
				if child == RightMenu then
					child:TweenSizeAndPosition(UDim2.new(0.29, 0,0.506, 0),UDim2.new(0.359, 0,0.239, 0),"Out","Quad",1,true)
					NewBackMenu = child
				elseif child == LeftMenu then                                       			     -- ACTIVE MENU
					local Tw1 = TweenService:Create(child,Info3,ImageGoal)
					Tw1:Play()
					child.ZIndex = 2
					local menudes = child:GetDescendants() 
					for index, decendent in pairs(menudes) do
						if decendent.ClassName == "UIGradient" or decendent:IsA("LocalScript") or decendent:IsA("UITextSizeConstraint") then	
						elseif decendent.Name == "dna" then
							decendent.ZIndex = 1					
						else
							decendent.ZIndex = 2
						end
						if decendent:IsA("ImageLabel") or decendent:IsA("ImageButton") and decendent.Name ~= "CloseButton" then
							local Tween = TweenService:Create(decendent,Info1,ImageGoal)
							Tween:Play()
						elseif decendent:IsA("TextLabel") or decendent:IsA("TextBox") or decendent:IsA("TextButton") then
							local Tween = TweenService:Create(decendent,Info1,TextGoal)
							Tween:Play()
						elseif decendent.ClassName == "Frame" then
							local Tween = TweenService:Create(decendent,Info1,BackgroundGoal)
							Tween:Play()
						elseif decendent.Name == "CloseButton" then
							decendent.ImageTransparency = 0
							decendent.Visible = true
						end
					end
					child:TweenSizeAndPosition(UDim2.new(0.365, 0,0.649, 0),UDim2.new(0.317, 0,0.18, 0),"Out","Quad",1,true)
					NewActiveMenu = child
				elseif child == BackMenu then
					child:TweenSizeAndPosition(UDim2.new(0.29, 0,0.506, 0),UDim2.new(0.219, 0,0.247, 0),"Out","Quad",1,true)
					NewLeftMenu = child
				elseif child == ActiveMenu then	
					local TweenChild1 = TweenService:Create(child,Info2,ImageGoal2)
					TweenChild1:Play()
					child.ZIndex = -1
					local menudes = child:GetDescendants() 
					for index, decendent in pairs(menudes) do  
						if decendent.ClassName == "UIGradient" or decendent:IsA("LocalScript") or decendent:IsA("UITextSizeConstraint") then
						else
							decendent.ZIndex = -1
						end
						if decendent:IsA("ImageLabel") or decendent:IsA("ImageButton") and decendent.Name ~= "CloseButton" then
							local Tween = TweenService:Create(decendent,Info1,ImageGoal2)
							Tween:Play()
						elseif decendent:IsA("TextLabel") or decendent:IsA("TextBox") or decendent:IsA("TextButton") then
							local Tween = TweenService:Create(decendent,Info1,TextGoal2)
							Tween:Play()
						elseif decendent:IsA("Frame") then
							local Tween = TweenService:Create(decendent,Info1,BackgroundGoal2)
							Tween:Play()
						elseif decendent.Name == "CloseButton" then
							decendent.Visible = false
						end
					end
					child:TweenSizeAndPosition(UDim2.new(0.29, 0,0.506, 0),UDim2.new(0.514, 0,0.247, 0),"Out","Quad",1,true)
					NewRightMenu = child
				end
			end
		end
		ActiveMenu = NewActiveMenu
		LeftMenu = NewLeftMenu
		RightMenu = NewRightMenu
		BackMenu = NewBackMenu
	end
end)

RightClicker.MouseButton1Click:Connect(function()
	if visible(true) then
	elseif DebounceLR <= tick()-0.5 then
		DebounceLR = tick()
		local children = script.Parent:GetChildren()
		local Info1 = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0)  -- text tween
		local Info2 = TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0)  --  Active becoming left
		local Info3 = TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0)  -- Right Becoming Active
		local ImageGoal = {ImageTransparency = 0}
		local TextGoal = {TextTransparency = 0}
		local BackgroundGoal = {BackgroundTransparency = 0}
		local ImageGoal2 = {ImageTransparency = 0.8}
		local TextGoal2 = {TextTransparency = 0.8}
		local BackgroundGoal2 = {BackgroundTransparency = 0.8}

		for i, child in ipairs(children) do
			if child.ClassName == "ImageLabel" then
				if child == LeftMenu then
					child:TweenSizeAndPosition(UDim2.new(0.29, 0,0.506, 0),UDim2.new(0.359, 0,0.239, 0),"Out","Quad",1,true)
					NewBackMenu = child
				elseif child == RightMenu then
					local Tw1 = TweenService:Create(child,Info3,ImageGoal)
					Tw1:Play()
					child.ZIndex = 2
					local menudes = child:GetDescendants() 
					for index, decendent in pairs(menudes) do
						if decendent:IsA("UIGradient") or decendent:IsA("UITextSizeConstraint") or decendent:IsA("LocalScript")  then	
						elseif decendent.Name == "dna" then
							decendent.ZIndex = 1
						else
							decendent.ZIndex = 2
						end
						if decendent:IsA("ImageLabel") or decendent:IsA("ImageButton") and decendent.Name ~= "CloseButton" then
							local Tween = TweenService:Create(decendent,Info1,ImageGoal)
							Tween:Play()
						elseif decendent:IsA("TextLabel") or decendent:IsA("TextBox") or decendent:IsA("TextButton") then
							local Tween = TweenService:Create(decendent,Info1,TextGoal)
							Tween:Play()
						elseif decendent.ClassName == "Frame" then
							local Tween = TweenService:Create(decendent,Info1,BackgroundGoal)
							Tween:Play()
						elseif decendent.Name == "CloseButton" then
							decendent.ImageTransparency = 0
							decendent.Visible = true
						end
					end
					child:TweenSizeAndPosition(UDim2.new(0.365, 0,0.649, 0),UDim2.new(0.317, 0,0.18, 0),"Out","Quad",1,true)
					NewActiveMenu = child
				elseif child == BackMenu then
					child:TweenSizeAndPosition(UDim2.new(0.29, 0,0.506, 0),UDim2.new(0.514, 0,0.247, 0),"Out","Quad",1,true)
					NewRightMenu = child
				elseif child == ActiveMenu then	
					local TweenChild1 = TweenService:Create(child,Info2,ImageGoal2)
					TweenChild1:Play()
					child.ZIndex = -1
					local menudes = child:GetDescendants() 
					for index, decendent in pairs(menudes) do  
						if decendent:IsA("UIGradient") or decendent:IsA("UITextSizeConstraint") or decendent:IsA("LocalScript") then
						else
							decendent.ZIndex = -1
						end
						if decendent:IsA("ImageLabel") or decendent:IsA("ImageButton") and decendent.Name ~= "CloseButton" then
							local Tween = TweenService:Create(decendent,Info1,ImageGoal2)
							Tween:Play()
						elseif decendent:IsA("TextLabel") or decendent:IsA("TextBox") or decendent:IsA("TextButton") then
							local Tween = TweenService:Create(decendent,Info1,TextGoal2)
							Tween:Play()
						elseif decendent:IsA("Frame") then
							local Tween = TweenService:Create(decendent,Info1,BackgroundGoal2)
							Tween:Play()
						elseif decendent.Name == "CloseButton" then
							decendent.Visible = false
						end
					end
					child:TweenSizeAndPosition(UDim2.new(0.29, 0,0.506, 0),UDim2.new(0.219, 0,0.247, 0),"Out","Quad",1,true)  
					NewLeftMenu = child
				end
			end
		end
		ActiveMenu = NewActiveMenu
		LeftMenu = NewLeftMenu
		RightMenu = NewRightMenu
		BackMenu = NewBackMenu
	end
end)

------------ Quirk Displays
local QuirkDisplays = Gui.Quirks
local ActiveMenu = false

function UITransparency(Descendants, Transparency)
	for i, child in pairs(Descendants) do
		if child:IsA("ImageLabel") or child:IsA("ImageButton") then
			child.ImageTransparency = Transparency
		elseif child:IsA("TextLabel") or child:IsA("TextButton") then
			child.TextTransparency = Transparency
		end
	end
end

local QuirkDisplaysChildren = QuirkDisplays:GetChildren()
for i=1,#QuirkDisplaysChildren do
	if QuirkDisplaysChildren[i]:IsA("ImageButton") then
		QuirkDisplaysChildren[i].MouseButton1Click:Connect(function()
			if QuirkDisplays.Position == UDim2.new(0.317, 0,0.18, 0) and not ActiveMenu then
				ActiveMenu = true
				local Menu = Gui:WaitForChild(QuirkDisplaysChildren[i].Name.."Menu")
				Menu.Visible = true
				Menu:TweenSizeAndPosition(UDim2.new(0.276, 0,0.491, 0), UDim2.new(0.346, 0,0.22, 0),"Out","Back",0.4)
				local Descendants = QuirkDisplays:GetDescendants()
				local TweenInv = TweenService:Create(QuirkDisplays, TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0), {ImageTransparency = 0.8})
				TweenInv:Play()
				UITransparency(Descendants, 0.8)
				Menu.CloseButton.MouseButton1Click:Connect(function()
					ActiveMenu = false
					UITransparency(Descendants, 0)
					local CloseTweenInv = TweenService:Create(QuirkDisplays, TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0), {ImageTransparency = 0})
					CloseTweenInv:Play()
					Menu:TweenSizeAndPosition(UDim2.new(0.022, 0,0.035, 0), UDim2.new(0.489, 0,0.482, 0),"Out","Quint",0.6)
					wait(0.3)
					Menu.Visible = false
				end)
			end
		end)
	end
end
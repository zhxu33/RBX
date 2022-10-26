local gui = script.Parent
local GuiFocus = gui.Parent:WaitForChild("ActiveGui")
local TweenService = game:GetService("TweenService")
local OpenWeapon = gui:WaitForChild("OpenWFrame"):WaitForChild("TextButton")
local OpenArmor = gui:WaitForChild("OpenAFrame"):WaitForChild("TextButton")

OpenWeapon.MouseButton1Click:Connect(function()
	if GuiFocus.Value == script.Parent then
		local weaponmenu = script.Parent.Parent:WaitForChild("WeaponsMenu")
		weaponmenu.Visible = true
		weaponmenu:TweenSizeAndPosition(UDim2.new(0.3, 0,0.532, 0),UDim2.new(0.349, 0,0.197, 0),"Out","Back",0.7,true)
		local InvTweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0)
		local InvGoal = {ImageTransparency = 0.8}
		local invDescendants = gui:GetDescendants()
		local tweenInv = TweenService:Create(gui,InvTweenInfo,InvGoal)
		tweenInv:Play()
		for _, desc in pairs(invDescendants) do
			if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
				desc.ImageTransparency = 0.8
			elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
				desc.TextTransparency = 0.8		
			end
		end
	end
end)

OpenArmor.MouseButton1Click:Connect(function()
	if GuiFocus.Value == script.Parent then
		local armormenu = script.Parent.Parent:WaitForChild("ArmorMenu")
		armormenu.Visible = true
		armormenu:TweenSizeAndPosition(UDim2.new(0.3, 0,0.532, 0),UDim2.new(0.349, 0,0.197, 0),"Out","Back",0.7,	true)
		local InvTweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0)
		local InvGoal = {ImageTransparency = 0.8}
		local invDescendants = gui:GetDescendants()
		local tweenInv = TweenService:Create(gui,InvTweenInfo,InvGoal)
		tweenInv:Play()
		for _, desc in pairs(invDescendants) do
			if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
				desc.ImageTransparency = 0.8
			elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
				desc.TextTransparency = 0.8
			end
		end
	end
end)
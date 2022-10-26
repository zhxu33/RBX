local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

if UIS.TouchEnabled then

	local PlayerGui = Player:WaitForChild("PlayerGui")
	local MobileGui = PlayerGui:WaitForChild("MobileGui")
	local MobileFrame = MobileGui:WaitForChild("Frame")

	local KeyService = script.Parent
	local EquipSword = KeyService.Parent:WaitForChild("Equip")
	local Swing = KeyService.Parent:WaitForChild("Swing")
	local PlayerEvent = KeyService.Parent:WaitForChild("Player")
	local Dash = KeyService.Parent:WaitForChild("Dash")
	local RightSwing = KeyService.Parent:WaitForChild("RightSwing")

	local BButton = MobileFrame:WaitForChild("B")
	local GButton = MobileFrame:WaitForChild("G")
	local FrontDashButton = MobileFrame:WaitForChild("FrontDash")
	local BackDashButton = MobileFrame:WaitForChild("BackDash")
	local LeftDashButton = MobileFrame:WaitForChild("LeftDash")
	local RightDashButton = MobileFrame:WaitForChild("RightDash")
	local UpDashButton = MobileFrame:WaitForChild("UpDash")
	local KOP = KeyService.Parent.Parent:WaitForChild("KOP")

	local MMP = Vector3.zero
	local Cam = workspace.Camera
	UIS.TouchTap:Connect(function(touchPositions, gameProcessedEvent)			
		local unitRay = Cam:ScreenPointToRay(touchPositions[1].X, touchPositions[1].Y)
		local raycastParams = RaycastParams.new()                                                      
		raycastParams.FilterDescendantsInstances = Player.Character and Player.Character:GetChildren() or {}                                           
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist   
		local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction*999999, raycastParams) 	
		if raycastResult then
			MMP = raycastResult.Position
		end
	end)

	BButton.MouseButton1Down:Connect(function()
		RightSwing:FireServer(CFrame.new(MMP))
	end)

	GButton.MouseButton1Down:Connect(function()
		if KOP:FindFirstChild("g") then
			KOP.g:FireServer(true)
		end		
	end)

	GButton.MouseButton1Up:Connect(function()
		if KOP:FindFirstChild("g") then
			KOP.g:FireServer(false)
		end		
	end)

	FrontDashButton.MouseButton1Down:Connect(function()
		Dash:FireServer("Front")
	end)

	BackDashButton.MouseButton1Down:Connect(function()
		Dash:FireServer("Back")
	end)

	RightDashButton.MouseButton1Down:Connect(function()
		Dash:FireServer("Right")
	end)

	LeftDashButton.MouseButton1Down:Connect(function()
		Dash:FireServer("Left")
	end)

	UpDashButton.MouseButton1Down:Connect(function()
		Dash:FireServer("Up", CFrame.new(MMP))
	end)	
end
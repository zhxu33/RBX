local UIS = game:GetService("UserInputService")
local Player    = game.Players.LocalPlayer

repeat
	wait() 
until 
	workspace:FindFirstChild("S1c2R5i66p5t5s51") and 
	workspace.S1c2R5i66p5t5s51:FindFirstChild("PlayerData") and 
	workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name) and
	workspace.S1c2R5i66p5t5s51.PlayerData[Player.Name]:FindFirstChild("Loaded2")

local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuGui   = PlayerGui:WaitForChild("playerhud")

local isMobile  = UIS.TouchEnabled

if isMobile then
	local TouchGui          = PlayerGui:WaitForChild("TouchGui")
	local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame")
	local JumpButton        = TouchControlFrame:WaitForChild("JumpButton")
	local InteractGui       = PlayerGui:WaitForChild("InteractGui")
	local NPCResponses      = InteractGui  and InteractGui:WaitForChild("NPCResponses")
	local Response          = NPCResponses and NPCResponses:WaitForChild("Response")

	if not JumpButton:FindFirstChild("UIAspectRatioConstraint") then
		Instance.new("UIAspectRatioConstraint", JumpButton)
		JumpButton.Size        = UDim2.new(0.1,0,0.174,0)
		JumpButton.Position    = UDim2.new(0.895,0,0.79,0) 
		JumpButton.AnchorPoint = Vector2.new(0.5,0.5)
		--Response.TextScaled    = true
	end

	game.ReplicatedStorage.Gui.MobileGui:Clone().Parent = PlayerGui
end
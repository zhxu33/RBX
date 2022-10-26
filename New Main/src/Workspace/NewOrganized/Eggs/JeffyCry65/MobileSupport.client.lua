local UIS = game:GetService("UserInputService")

local MobileGui = game.ReplicatedStorage.Gui:WaitForChild("MobileGui")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuGui = PlayerGui:WaitForChild("playerhud")

repeat wait() until PlayerGui:FindFirstChild("TouchGui") or wait(10)

if PlayerGui:FindFirstChild("TouchGui") then
	local TouchGui = PlayerGui:FindFirstChild("TouchGui")
	local TouchControlFrame = TouchGui:FindFirstChild("TouchControlFrame")
	local JumpButton = TouchControlFrame:WaitForChild("JumpButton")
	local InteractGui = PlayerGui:FindFirstChild("InteractGui")
	local NPCResponses = InteractGui:FindFirstChild("NPCResponses")
	local Response = NPCResponses:FindFirstChild("Response")

	if not JumpButton:FindFirstChild("UIAspectRatioConstraint") then
	Instance.new("UIAspectRatioConstraint", JumpButton)
	JumpButton.Size = UDim2.new(0.1,0,0.174,0)
	JumpButton.Position = UDim2.new(0.895,0,0.79,0) 
	JumpButton.AnchorPoint = Vector2.new(0.5,0.5)
	Response.TextScaled = true
	end

	if UIS.TouchEnabled and MenuGui.Enabled == true then
		MobileGui:Clone().Parent = PlayerGui
	end
end
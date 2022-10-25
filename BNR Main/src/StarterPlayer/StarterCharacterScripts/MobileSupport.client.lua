local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local GuiService = game:GetService("GuiService")
local MobileGui = game.ReplicatedStorage.Gui:WaitForChild("MobileGui")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuGui = PlayerGui:WaitForChild("Menu")
local JumpButton = PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
local InteractGui = PlayerGui:WaitForChild("InteractGui")
local NPCResponses = InteractGui:WaitForChild("NPCResponses")
local Response = NPCResponses:WaitForChild("Response")

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
local CodeRemote = game.ReplicatedStorage:WaitForChild("Code")
local CD = false
local CodeText = script.Parent:WaitForChild("InputBox")
local Redeem = script.Parent:WaitForChild("Confirm")
local Response = script.Parent:WaitForChild("ResponseBox")

Redeem.MouseButton1Click:Connect(function()
	if CD == false then
	CD = true
	CodeRemote:FireServer(tostring(CodeText.Text))
	wait(1)
	CD = false
	end
end)

CodeRemote.OnClientEvent:Connect(function(Text)
	Response.Text = Text
end)
local Party = game.ReplicatedStorage:WaitForChild("Party")
local Party1 = script.Parent:WaitForChild("Party1")
local Party2 = script.Parent:WaitForChild("Party2")
local Party3 = script.Parent:WaitForChild("Party3")
local Party4 = script.Parent:WaitForChild("Party4")

Party1.Changed:Connect(function()
	Party:FireServer(1,tostring(Party1.Text))
end)

Party2.Changed:Connect(function()
	Party:FireServer(2,tostring(Party2.Text))
end)

Party3.Changed:Connect(function()
	Party:FireServer(3,tostring(Party3.Text))
end)

Party4.Changed:Connect(function()
	Party:FireServer(4,tostring(Party4.Text))
end)
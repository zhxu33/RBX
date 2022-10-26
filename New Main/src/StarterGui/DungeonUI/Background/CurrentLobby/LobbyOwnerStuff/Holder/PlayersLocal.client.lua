 -- // Services
local PlayerService = game:GetService("Players")

 -- // Variables
local Parent       = script.Parent
local Players      = Parent.Frame
local UpdateButton = Parent.Parent.UpdateUsers
local Whitelist    = {}

 -- // Players
local demo = Players.TextButton
local function selectedUser(User)
	local clone   = demo:Clone()
	clone.Activated:Connect(function()
		local foundUser = table.find(Whitelist, User.Name)
		
		if foundUser then
			table.remove(Whitelist, foundUser)
			clone.TextColor3 = Color3.fromRGB(253, 203, 110)
		else
			table.insert(Whitelist, User.Name)
			clone.TextColor3 = Color3.fromRGB(145, 255, 145)
		end
	end)
	clone.Text    = User.Name
	clone.Name    = User.Name
	clone.Visible = true
	clone.Parent  = Players
end

for Index, User in pairs(PlayerService:GetPlayers()) do
	selectedUser(User)
end

 -- // Creates buttons for newbies who join the server
PlayerService.PlayerAdded:Connect(selectedUser)
PlayerService.PlayerRemoving:Connect(function(User)
	local TB = Players:FindFirstChild(User.Name)
	if TB then TB:Destroy() end
end)

 -- // updating the users

local jellybean = false
UpdateButton.Activated:Connect(function()
	if jellybean then return end
	jellybean = true
	
	local event = game.ReplicatedStorage.Remotes.Event.updateLobby
	if event then
		event:FireServer(Whitelist)
	end
	
	wait(1)
	jellybean = false
end)


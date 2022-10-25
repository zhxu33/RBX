local PVPModel = script.Parent
local Player1 = PVPModel.Player
local Player2 = PVPModel.Player2
local PVPSpawn1 = PVPModel.PVPTouch
local PVPSpawn2 = PVPModel.PVPTouch2
local Arena = workspace.Arena
local Spawn = PVPModel.Spawn
local ArenaEntrance = PVPModel.ArenaEntrance
local ArenaExit1 = Arena:WaitForChild("Exit1")
local ArenaExit2 = Arena:WaitForChild("Exit2")
local ArenaExit3 = Arena:WaitForChild("Exit3")
local ArenaExit4 = Arena:WaitForChild("Exit4")
local ArenaOpen = true
local ArenaCD = false
local NumberPlayers = 0
local PlayerData = workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData")
local DataStore = game:GetService("DataStoreService")
local FoughtPlayers = DataStore:GetDataStore("FoughtPlayers")
local reward = game.ReplicatedStorage.Remotes:WaitForChild("RewardPane")

PVPSpawn1.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(hit.Parent.Name) and Player1.Value == "None" and Player2.Value ~= hit.Parent.Name then
        local Level = PlayerData:FindFirstChild(hit.Parent.Name).Level
        if Level.Value >= 500 then
            Player1.Value = tostring(hit.Parent.Name)
        end
    end
end)

PVPSpawn2.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(hit.Parent.Name) and Player2.Value == "None" and Player1.Value ~= hit.Parent.Name then
        local Level = PlayerData:FindFirstChild(hit.Parent.Name).Level
        if Level.Value >= 500 then
            Player2.Value = tostring(hit.Parent.Name)
        end
    end
end)

ArenaExit1.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Parent.Name ~= "InteractionNPCS" then
        local RootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
        local SafeTp = Instance.new("NumberValue", hit.Parent)
        SafeTp.Name = "SafeTp"
        game.Debris:AddItem(SafeTp,2)
        RootPart.CFrame = Spawn.CFrame
    end
end)

ArenaExit2.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Parent.Name ~= "InteractionNPCS" then
        local RootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
        local SafeTp = Instance.new("NumberValue", hit.Parent)
        SafeTp.Name = "SafeTp"
        game.Debris:AddItem(SafeTp,2)
        RootPart.CFrame = Spawn.CFrame
    end
end)

ArenaExit3.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Parent.Name ~= "InteractionNPCS" then
        local RootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
        local SafeTp = Instance.new("NumberValue", hit.Parent)
        SafeTp.Name = "SafeTp"
        game.Debris:AddItem(SafeTp,2)
        RootPart.CFrame = Spawn.CFrame
    end
end)

ArenaExit4.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Parent.Name ~= "InteractionNPCS" then
        local RootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
        local SafeTp = Instance.new("NumberValue", hit.Parent)
        SafeTp.Name = "SafeTp"
        game.Debris:AddItem(SafeTp,2)
        RootPart.CFrame = Spawn.CFrame
    end
end)

ArenaEntrance.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and Player1.Value ~= hit.Parent.Name and Player2.Value ~= hit.Parent.Name and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Parent.Name ~= "InteractionNPCS" then
		if not hit.Parent:FindFirstChild("ArenaPlayer") then
	        local RootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
	        local RandomEntrance = math.random(1,4)
	        local SafeTp = Instance.new("NumberValue", hit.Parent)
	        SafeTp.Name = "SafeTp"
	        game.Debris:AddItem(SafeTp,2)
	        if RandomEntrance == 1 then
	            RootPart.CFrame = ArenaExit1.CFrame * CFrame.new(0,2,-10)
	        elseif RandomEntrance == 2 then
	            RootPart.CFrame = ArenaExit2.CFrame * CFrame.new(-10,2,0)
	        elseif RandomEntrance == 3 then
	            RootPart.CFrame = ArenaExit3.CFrame * CFrame.new(0,2,10)
	        elseif RandomEntrance == 4 then
	            RootPart.CFrame = ArenaExit4.CFrame * CFrame.new(10,2,0)
	        end
			
			delay(2, function()
				if hit.Parent:FindFirstChild("ArenaPlayer", true) then
					local pos = hit.Parent:FindFirstChild("ArenaPlayer", true).Value
					if pos == 1 then
						RootPart.CFrame = Arena.Spawn1.CFrame
					else
            			RootPart.CFrame = Arena.Spawn2.CFrame
					end
				end
			end)
		end
    end
end)

local coo = coroutine.wrap(function()
    while wait(.1) do
        if Player1.Value == "None" and Player2.Value == "None" then
            NumberPlayers = 0
        elseif Player1.Value ~= "None" and Player2.Value ~= "None" then
            NumberPlayers = 2
        elseif Player1.Value == "None" and Player2.Value ~= "None" then
            NumberPlayers = 1
        elseif Player1.Value ~= "None" and Player2.Value == "None" then
            NumberPlayers = 1
        end
        if ArenaOpen == true and ArenaCD == false then
            Spawn.NumberPlayers.Text.Text = "1v1 Battle "..NumberPlayers.."/2"
        elseif ArenaOpen == false or ArenaCD == true then
            Spawn.NumberPlayers.Text.Text = "Battling..."
        end
        if Player1.Value ~= "None" then
            local touching = PVPSpawn1:GetTouchingParts()
            local istouching1 = false
            for i, hit in next, touching do
                if hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(hit.Parent.Name) and Player1.Value == hit.Parent.Name then
                    istouching1 = true
                end
            end
            if istouching1 == false then
                Player1.Value = "None"
            end
        end
        if Player2.Value ~= "None" then
            local touching = PVPSpawn2:GetTouchingParts()
            local istouching1 = false
            for i, hit in next, touching do
                if hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(hit.Parent.Name) and Player2.Value == hit.Parent.Name then
                    istouching1 = true
                end
            end
            if istouching1 == false then
                Player2.Value = "None"
            end
        end
    end
end)
coo()

while wait() do
    if Player1.Value ~= "None" and Player2.Value ~= "None" and ArenaOpen == true and ArenaCD == false and Player1.Value ~= Player2.Value then
        ArenaOpen = false
        ArenaCD = true
        local P1 = game.Players:FindFirstChild(Player1.Value)
        local P2 = game.Players:FindFirstChild(Player2.Value)
        local Plr1 = P1.Character
        local Plr2 = P2.Character
        local Plr1File = PlayerData:FindFirstChild(Player1.Value)
        local Plr2File = PlayerData:FindFirstChild(Player2.Value)
        local Winner = nil
        local tim = 300
        Player1.Value = "None"
        Player2.Value = "None"
        local coro = coroutine.wrap(function()
            Plr1.Parent = Arena
            Plr2.Parent = Arena
            Plr1.Humanoid.Health = Plr1.Humanoid.MaxHealth
            Plr2.Humanoid.Health = Plr2.Humanoid.MaxHealth
			local ArenaPlayer1 = Instance.new("NumberValue", Plr1)
			ArenaPlayer1.Name = "ArenaPlayer"
			ArenaPlayer1.Value = 1

			local ArenaPlayer2 = Instance.new("NumberValue", Plr2)
			ArenaPlayer2.Name = "ArenaPlayer"
			ArenaPlayer2.Value = 2

            local SafeTp = Instance.new("NumberValue", Plr1)
            SafeTp.Name = "SafeTp"
            game.Debris:AddItem(SafeTp,2)
            local SafeTp2 = Instance.new("NumberValue", Plr2)
            SafeTp2.Name = "SafeTp"
            game.Debris:AddItem(SafeTp2,2)
            Plr1.HumanoidRootPart.CFrame = Arena.Spawn1.CFrame
            Plr2.HumanoidRootPart.CFrame = Arena.Spawn2.CFrame
        end)
        coro()
        Plr1.Humanoid.Died:Connect(function()
            Plr1.Parent = workspace
        end)
        Plr2.Humanoid.Died:Connect(function()
            Plr2.Parent = workspace
        end)
        local coo = coroutine.wrap(function()
            repeat wait() until not Arena:FindFirstChild(Plr1.Name) or not Arena:FindFirstChild(Plr2.Name) or tim == 0
            ArenaOpen = true
            if tim == 0 then
                Arena.Time.TimeGui.Text.Text = "TIME!"
                local coro = coroutine.wrap(function()
                    wait(1)
                    local SafeTp = Instance.new("NumberValue", Plr1)
                    SafeTp.Name = "SafeTp"
                    game.Debris:AddItem(SafeTp,2)
                    local SafeTp2 = Instance.new("NumberValue", Plr2)
                    SafeTp2.Name = "SafeTp"
                    game.Debris:AddItem(SafeTp2,2)
                    Plr1.HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(0,2,0)
                    Plr2.HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(0,4,0)
					Plr1:FindFirstChild("ArenaPlayer", true):Destroy()
					Plr2:FindFirstChild("ArenaPlayer", true):Destroy()
                end)
                coro()
                wait(1.1)
                Arena.Time.TimeGui.Text.Text = "Fight!"
                ArenaCD = false
                return end
            if not Arena:FindFirstChild(Plr1.Name) then
                Winner = "Plr2"
            elseif not Arena:FindFirstChild(Plr2.Name) then
                Winner = "Plr1"
            end
            wait(1)
            if Winner == "Plr1" then
                local coro = coroutine.wrap(function()
                    if FoughtPlayers:GetAsync(P2.UserId..P1.UserId) == nil then
                        FoughtPlayers:SetAsync(P2.UserId..P1.UserId, true)
                        Plr1File.Cash.Value = Plr1File.Cash.Value + 500
                        Plr1File.Experience.Value = Plr1File.Experience.Value + 25000
                        Plr1File.ArenaWins.Value = Plr1File.ArenaWins.Value + 1
                        reward:FireClient(P1, 25000,500)
                    end
                    Arena.Time.TimeGui.Text.Text = Plr1.Name.." is the winner!"
                    wait(5)
                    local SafeTp = Instance.new("NumberValue", Plr1)
                    SafeTp.Name = "SafeTp"
                    game.Debris:AddItem(SafeTp,2)
                    Plr1.HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(0,2,0)
                    wait(1)
                    local SafeTp2 = Instance.new("NumberValue", Plr2)
                    SafeTp2.Name = "SafeTp"
                    game.Debris:AddItem(SafeTp2,2)
                    Plr2.HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(0,4,0)

					Plr1:FindFirstChild("ArenaPlayer", true):Destroy()
					Plr2:FindFirstChild("ArenaPlayer", true):Destroy()
                end)
                coro()
            elseif Winner == "Plr2" then
                local coro = coroutine.wrap(function()
                    if FoughtPlayers:GetAsync(P1.UserId..P2.UserId) == nil then
                        FoughtPlayers:SetAsync(P1.UserId..P2.UserId, true)
                        Plr2File.Cash.Value = Plr2File.Cash.Value + 500
                        Plr2File.Experience.Value = Plr2File.Experience.Value + 25000
                        Plr2File.ArenaWins.Value = Plr2File.ArenaWins.Value + 1
                        reward:FireClient(P2, 25000,500)
                    end
                    Arena.Time.TimeGui.Text.Text = Plr2.Name.." is the winner!"
                    wait(5)
                    local SafeTp2 = Instance.new("NumberValue", Plr2)
                    SafeTp2.Name = "SafeTp"
                    game.Debris:AddItem(SafeTp2,2)
                    Plr2.HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(0,2,0)
                    wait(1)
                    local SafeTp2 = Instance.new("NumberValue", Plr1)
                    SafeTp2.Name = "SafeTp"
                    game.Debris:AddItem(SafeTp2,2)
                    Plr1.HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(0,4,0)

					Plr1:FindFirstChild("ArenaPlayer", true):Destroy()
					Plr2:FindFirstChild("ArenaPlayer", true):Destroy()
                end)
                coro()
            end
            wait(5.1)
            Arena.Time.TimeGui.Text.Text = "Fight!"
            ArenaCD = false
        end)
        coo()
        wait(2)
        for i=1, 300 do
            if ArenaOpen == true then
                break
            end
            tim = tim -1
            Arena.Time.TimeGui.Text.Text = tim.."s"
            wait(1)
        end
        if ArenaOpen == false then
            ArenaOpen = true
        end
    end
end

local BadgeService = game:GetService("BadgeService")
local BadgeId = 1765731725
local MaxLevel = 15000

game.ReplicatedStorage.Remotes.Player.OnServerEvent:Connect(function(Player)
    repeat
        wait()
    until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
    local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
    repeat wait() until PlayerData:FindFirstChild("Loaded")
    local ExpMultiplier = PlayerData:WaitForChild("ExpMultiplier")
    local Level = PlayerData:WaitForChild("Level")
    local MaxExp = 400*Level.Value/2/ExpMultiplier.Value
    local Exp = PlayerData:WaitForChild("Experience")
	local StatPoints = PlayerData:WaitForChild("StatPoints")

    local Strength = PlayerData:WaitForChild("Strength")
    local Agility = PlayerData:WaitForChild("Agility")
    local Durability = PlayerData:WaitForChild("Durability")
	
    while Level.Value < MaxLevel do
        wait(.1)
        if not game.Players:FindFirstChild(Player.Name) then
            break
        end
        pcall(function()
            if Exp.Value >= MaxExp then
			    Level.Value = Level.Value + 1
			    StatPoints.Value = StatPoints.Value + 3
				Exp.Value = Exp.Value - MaxExp

			    if Level.Value >= MaxLevel and Exp.Value >= MaxExp then
			        Exp.Value = MaxExp
			        return
			    end
			    
--			    Player.Character.Humanoid.Health = Player.Character.Humanoid.MaxHealth
                local LevelSound = Instance.new("Sound", Player.Character.HumanoidRootPart)
                LevelSound.Volume = 0.5
                LevelSound.SoundId = "rbxassetid://341542294"
                LevelSound:Play()
                game.Debris:AddItem(LevelSound, 3)
                for i,v in pairs(Player.Character:GetChildren()) do
                    if v:IsA("MeshPart") then
                        local sparkles = script.LevelSparkles:Clone()
                        sparkles.Parent = v
                        game.Debris:AddItem(sparkles,3)
                    end
                end
            end
			MaxExp = 400*Level.Value/2/ExpMultiplier.Value
        end)
    end
end)

game.ReplicatedStorage.Remotes.MaxExp.OnInvoke = function(Player)
    local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:WaitForChild(Player.Name)
    local ExpMultiplier = PlayerData:WaitForChild("ExpMultiplier")
    local Level = PlayerData:WaitForChild("Level")
    local MaxExp = 400*Level.Value/2/ExpMultiplier.Value
    return MaxExp
end
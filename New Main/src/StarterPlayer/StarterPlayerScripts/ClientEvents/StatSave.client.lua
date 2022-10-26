local Player = game.Players.LocalPlayer
local AutoSave = game.ReplicatedStorage.Remotes:WaitForChild("AutoSave")

AutoSave.OnClientEvent:Connect(function(plr)
    Player.PlayerGui.SaveGui.Saved.Visible = true
    Player.PlayerGui.SaveGui.Saved.Text = ""
    local fullmsg = "Game has auto saved."
    for i = 1, fullmsg:len() do
        wait(0.01)
        game:GetService("RunService").RenderStepped:wait()
        Player.PlayerGui.SaveGui.Saved.Text = Player.PlayerGui.SaveGui.Saved.Text .. fullmsg:sub(i,i)
    end
    wait(3)
    Player.PlayerGui.SaveGui.Saved.Text = ""
    Player.PlayerGui.SaveGui.Saved.Visible = false
end)

--while wait(300) do
--    if Player and workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name) then
--        AutoSave:FireServer()
--    end
--end

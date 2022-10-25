local Player = game.Players.LocalPlayer
local Character = Player.Character
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)

local Agility = PlayerData.Agility

local function AntiFling()
    if Humanoid.Health > 0 and RootPart.RotVelocity.magnitude >= 50 or (RootPart.Velocity-Vector3.new(0, RootPart.Velocity.y,0)).magnitude >= 250 + Agility.Value/10 then
        RootPart.RotVelocity = Vector3.new()
        RootPart.Velocity = Vector3.new()
        wait(0.5)
        if Humanoid.Health > 0 then
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    AntiFling()
end)

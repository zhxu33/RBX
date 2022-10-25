local Player
script.Player.OnServerEvent:Connect(function(player)
    Player = player
    if workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name).Quirk.Value ~= 8 then
        script:Destroy()
    end
end)

repeat wait() until Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
wait()
local AnimationsFolder = script.Animations
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local BlockAnim = Humanoid:LoadAnimation(AnimationsFolder.Block)
local StunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.stunned)
local HvyStunnedAnim = Humanoid:LoadAnimation(AnimationsFolder.heavystunned)
local SitUpAnim = Humanoid:LoadAnimation(AnimationsFolder.SitUp)
local PushUpAnim = Humanoid:LoadAnimation(AnimationsFolder.PushUp)
local BodyVelocity = Instance.new("BodyVelocity")
local Smoke = script.Smoke
BodyVelocity.Parent = nil
BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
local HitSound = Instance.new("Sound", RootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local Attack = Instance.new("BoolValue", Character)
Attack.Name = "Attack"
Attack.Value = false
local Block = false
local LeftKick = false
local RightKick = false
local LeftPunch = false
local RightPunch = false
local Training = false
local WarpCombat = false
local WarpMode = false
local Run = false
local cantrun = false
local Shift = false
local WarpTrap = false
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerFolder = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local Level = PlayerFolder.Level
local Exp = PlayerFolder.Experience
local Strength = PlayerFolder.Strength
local Agility = PlayerFolder.Agility
local Durability = PlayerFolder.Durability
local Quirk = PlayerFolder.Quirk
local stunned = false
local Defense = Instance.new("NumberValue",Character)
Defense.Name = "Defense"
Defense.Value = 1
local Stamina = Instance.new("NumberValue",Character)
Stamina.Name = "Stamina"
Stamina.Value = 100+(Agility.Value*1)
local MaxStamina = Instance.new("NumberValue",Character)
MaxStamina.Name = "MaxStamina"
MaxStamina.Value = Stamina.Value
Humanoid.MaxHealth = 75+50*Level.Value
Humanoid.Health = Humanoid.MaxHealth
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local TweenService = game:GetService("TweenService")
local Corotot = coroutine.wrap(function()
    local REGEN_RATE = 5/100
    local REGEN_STEP = .1

    while true do
        while Stamina.Value < MaxStamina.Value do
            local dt = wait(REGEN_STEP)
            local dh = dt*REGEN_RATE*MaxStamina.Value
            Stamina.Value = math.min(Stamina.Value + dh, MaxStamina.Value)
        end
        if Stamina.Value > MaxStamina.Value then
            Stamina.Value = MaxStamina.Value
        end
        Stamina.Changed:Wait()
    end
end)
Corotot()
local Coro = coroutine.wrap(function()
    while wait() do
        if not Character:FindFirstChild("Safezone") and Block == false then
            if RootPart:FindFirstChild("Light") and stunned == false and cantrun == false then
            elseif RootPart:FindFirstChild("Heavy") and stunned == false and cantrun == false then
                stunned = true
                local asdfg = false
                Attack.Value = true
                HvyStunnedAnim:Play()
                Humanoid.WalkSpeed = 0
                Humanoid.JumpPower = 0
                for i = 1,3 do
                    if asdfg == true or not RootPart:FindFirstChild("Heavy") then
                        break
                    else
                        wait(.75)
                    end
                end
                if RootPart:FindFirstChild("Heavy") then
                    RootPart:FindFirstChild("Heavy"):Destroy()
                end
                HvyStunnedAnim:Stop()
                asdfg = true
                Humanoid.WalkSpeed = 18
                Humanoid.JumpPower = 50
                stunned = false
                Attack.Value = false
            end
        end
    end
end)
Coro()

local ee = script:WaitForChild("E")
local zz = script:WaitForChild("Z")
local xx = script:WaitForChild("X")
local cc = script:WaitForChild("C")
local qq = script:WaitForChild("Q")
local Zup = script:WaitForChild("Zup")
local tt = script:WaitForChild("T")
local sd = script:WaitForChild("ShiftDown")
local su = script:WaitForChild("ShiftUp")
local rr = script:WaitForChild("R")
local rup = script:WaitForChild("RUP")

rr.OnServerEvent:Connect(function()
    if Attack.Value == false and stunned == false and Stamina.Value > 3 and Block == false then
        Block = true
        Attack.Value = true
        BlockAnim:Play()
        repeat wait()
            Defense.Value = 3
            Stamina.Value = Stamina.Value - 3
            local coo = coroutine.wrap(function()
                if RootPart:FindFirstChild("Heavy") then
                    game.Debris:AddItem(RootPart:FindFirstChild("Heavy"), .3)
                end
            end)
            coo()
        until Block == false or Stamina.Value < 3
        BlockAnim:Stop()
        Defense.Value = 1
        Attack.Value = false
    end
end)

rup.OnServerEvent:Connect(function()
    if Block == true then
        Block = false
    end
end)

local Platform = workspace.Arena:FindFirstChild("Platform Border")

local size = Platform.Size
local bottomLeft = Platform.Position - Vector3.new(size.X / 2, 100, size.Z / 2)
local topRight = Platform.Position + Vector3.new(size.X / 2, 500, size.Z / 2)
		
function isInRegion3(pos)
	if pos.X > bottomLeft.X and pos.Y > bottomLeft.Y and pos.Z > bottomLeft.Z then
		if pos.X < topRight.X and pos.Y < topRight.Y and pos.Z < topRight.Z then
			return true
			else
			return false
		end
	else
		return false
	end
end

zz.OnServerEvent:Connect(function(play, pos)
    if Attack.Value == false and stunned == false and (RootPart.Position-pos).Magnitude < 500 then		
		local PlayerInRegion = isInRegion3(RootPart.Position)
		local PositionInRegion = isInRegion3(pos)
	    
		if (PlayerInRegion and PositionInRegion) or not PlayerInRegion then -- Are they in the arena? If so, make sure warp is within the arena otherwise let the player cast outside the arena

	        script.Warp2.Smoke.Enabled = true
	        script.Warp2.Smoke2.Enabled = true
	        script.Warp1.Smoke.Enabled = true
	        script.Warp1.Smoke2.Enabled = true
	        script.Warp2.CFrame = CFrame.new(pos)
	        script.Warp1.CFrame = RootPart.CFrame * CFrame.new(0,0,-10)

		end
    end
end)

local CD = false
cc.OnServerEvent:Connect(function()
    if Agility.Value >= 100 and WarpMode == false and CD == false then
        WarpMode = true
        CD = true
        local ff = Instance.new("ForceField", Character)
        ff.Visible = false
        ff.Name = "WarpMode"
        local clone = script.BicSmoke:Clone()
        clone.Parent = Character.UpperTorso
        for i,v in pairs(Character:GetChildren()) do
            if v:IsA("MeshPart") then
                if v.Name ~= "Head" then
                    v.Transparency = 1
                end
            end
        end
        wait(7.5)
        clone:Destroy()
        WarpMode = false
        for i,v in pairs(Character:GetChildren()) do
            if v:IsA("MeshPart") then
                v.Transparency = 0
            end
        end
        ff:Destroy()
        wait(10)
        CD = false
    end
end)

Zup.OnServerEvent:Connect(function()
    script.Warp2.Smoke.Enabled = false
    script.Warp2.Smoke2.Enabled = false
    script.Warp1.Smoke.Enabled = false
    script.Warp1.Smoke2.Enabled = false
end)


qq.OnServerEvent:Connect(function(play,target)
    if Attack.Value == false and stunned == false and Stamina.Value >= 15 and WarpCombat == false and (RootPart.CFrame.p-target.Parent.HumanoidRootPart.Position).Magnitude <= 100 then
        WarpCombat = true
        Attack.Value = true
        local animation = Instance.new("Animation")
        local picked = math.random(1, #PunchAnim)
        animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[picked]
        local animTrack = Humanoid:LoadAnimation(animation)
        animTrack:Play()
        if picked == 1 then
            wait(.15)
            local clone = script.Smokey:Clone()
            clone.Parent = Character.RightHand
            game.Debris:AddItem(clone,.35)
        elseif picked == 2 then
            wait(.15)
            local clone2 = script.Smokey:Clone()
            clone2.Parent = Character.LeftHand
            game.Debris:AddItem(clone2,.35)
        elseif picked == 3 then
            wait(.15)
            local clone3 = script.Smokey:Clone()
            clone3.Parent = Character.RightFoot
            game.Debris:AddItem(clone3,.35)
        elseif picked == 4 then
            wait(.15)
            local clone4 = script.Smokey:Clone()
            clone4.Parent = Character.LeftFoot
            game.Debris:AddItem(clone4,.35)
        end
        wait(.2)
        local sm0ke = script.Smokey:Clone()
        sm0ke.Parent = target.Parent.UpperTorso
        sm0ke.Size = NumberSequence.new(5)
        game.Debris:AddItem(sm0ke,.3)
        DmgFunction:Fire(Character, target, 20*Strength.Value/2)
        Exp.Value = Exp.Value + 75
        local Velocity = Instance.new("BodyVelocity",target.Parent.HumanoidRootPart)
        Velocity.MaxForce = Vector3.new(10000,10000,10000)
        Velocity.Velocity = RootPart.CFrame.lookVector * 40
        Velocity.Name = "Light"
        local ObjectVal = Instance.new("ObjectValue",Velocity)
        ObjectVal.Value = RootPart
        ObjectVal.Name = "Hitist"
        game.Debris:AddItem(Velocity,.5)
        if target.Health < 1 then
            if game.Players:GetPlayerFromCharacter(target.Parent) then
                local enemyplrf = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(target.Parent.Name)
                local enemyplrFame = enemyplrf.Fame
                if enemyplrFame.Value > -1 then
                    PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
                elseif enemyplrFame.Value <= -1 then
                    PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
                end
            elseif target.Parent:FindFirstChild("Fame") then
                local enemyplrFame = target.Parent.Fame
                if target.Parent.Name == "All Might" then
                    PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 150
                    Exp.Value = Exp.Value + 100000
                    PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + 10000
                    local reward = game.ReplicatedStorage.Remotes.RewardPane
                    reward:FireClient(Player, 100000, 10000)
                elseif enemyplrFame.Value > -1 then
                    PlayerFolder.Fame.Value = PlayerFolder.Fame.Value - 1
                    PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + math.random(20,50)
                elseif enemyplrFame.Value <= -1 then
                    PlayerFolder.Fame.Value = PlayerFolder.Fame.Value + 1
                    PlayerFolder.Cash.Value = PlayerFolder.Cash.Value + math.random(20,50)
                end
            end
        end
        wait(0.3)
        Attack.Value = false
        wait(.5)
        WarpCombat = false
    end
end)


xx.OnServerEvent:Connect(function(play, pos)
    if Strength.Value >= 50 and Attack.Value == false and stunned == false and Stamina.Value >= 25 and WarpTrap == false and (RootPart.CFrame.p - pos).Magnitude <= 500 then
        WarpTrap = true
        local clone = script.Trap:Clone()
        clone.Parent = script
        clone.CFrame = CFrame.new(pos)
        local warped = true
        local PlayersHitted = {}
        local expermentaltouch = coroutine.wrap(function()
            local connection = nil
            local results = nil
            local lastresult = {}
            while true do
                if clone == nil then
                    break
                end
                connection = clone.Touched:Connect(function() end)
                results = clone:GetTouchingParts()
                connection:Disconnect()
                if results ~= lastresult then
                    for i=1,#results do
                        if results[i].Name == "HumanoidRootPart" then
                            if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
                                if PlayersHitted[results[i].Parent] ~= nil then
                                else
                                    PlayersHitted[results[i].Parent] = results[i].Parent
                                    local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
                                    local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
                                    DmgFunction:Fire(Character, hum, 40*Strength.Value/2)
                                    local Corotot = coroutine.wrap(function()
                                        repeat wait()
                                            hum.WalkSpeed = 0
                                            hum.JumpPower = 0
                                            HRT.Anchored =  true
                                        until warped == false or Humanoid.Health == 0
                                        HRT.Anchored = false
                                        hum.WalkSpeed = 18
                                        hum.JumpPower = 50
                                    end)
                                    Corotot()
                                    if HRT:FindFirstChild("Light") == nil then
                                        Exp.Value = Exp.Value + 100
                                        local Velocity = Instance.new("BodyVelocity",HRT)
                                        Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                        Velocity.Name = "Light"
                                        local ObjectVal = Instance.new("ObjectValue",Velocity)
                                        ObjectVal.Value = RootPart
                                        ObjectVal.Name = "Hitist"
                                        game.Debris:AddItem(Velocity,.25)
                                    end
                                end
                            end
                        end
                    end
                    lastresult = results
                end
                wait(0.5)
            end
        end)
        expermentaltouch()
        wait(3)
        clone:Destroy()
        warped = false
        wait(5)
        WarpTrap = false
    end
end)

sd.OnServerEvent:Connect(function()
    Shift = true
    if stunned == false and Stamina.Value > 1 and cantrun == false then
        local Corot = coroutine.wrap(function()
            while wait(0.1) do
                Stamina.Value = Stamina.Value - 2
                if Stamina.Value < 2 or Run == false then
                    break
                end
            end
        end)
        Corot()
        Run = true
        if Agility.Value >= 2000 then
            Humanoid.WalkSpeed = 140
        else
            Humanoid.WalkSpeed = 40 + 0.05 * Agility.Value
        end
    end
end)
su.OnServerEvent:Connect(function()
    if cantrun == false then
        Shift = false
        Run = false
        BodyVelocity.Parent = nil
        Humanoid.WalkSpeed = 18
    end
end)

tt.OnServerEvent:Connect(function()
    if Attack.Value == false and stunned == false and Stamina.Value > 10 and Training == false then
        Attack.Value = true
        Training = true
        local random = math.random(1,2)
        if random == 1 then
            SitUpAnim:Play()
        elseif random == 2 then
            PushUpAnim:Play()
        end
        Exp.Value = Exp.Value + 50
        Humanoid.WalkSpeed = 0
        cantrun = true
        Humanoid.JumpPower = 0
        wait(1.8)
        Training = false
        Attack.Value = false
        Humanoid.WalkSpeed = 18
        cantrun = false
        Humanoid.JumpPower = 50
    end
end)

local picked = 1
ee.OnServerEvent:Connect(function()
    if Attack.Value == false and stunned == false and Stamina.Value > 10 then
        Stamina.Value = Stamina.Value - 10
        local animation = Instance.new("Animation")
        animation.AnimationId = "http://roblox.com/asset/?id="..PunchAnim[picked]
        local animTrack = Humanoid:LoadAnimation(animation)
        animTrack:Play()
        if picked == 1 then
            RightPunch = true
            Attack.Value = true
            local results = nil
            local lastresult = nil
            local PlayersHitted = {}
            local touchedy = coroutine.wrap(function()
                while wait(0.01) do
                    if RightPunch == false then
                        break
                    end
                    local connection = Character.RightHand.Touched:Connect(function()end)
                    results = Character.RightHand:GetTouchingParts()
                    connection:Disconnect()
                    if results ~= lastresult then
                        for i=1,#results do
                            if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
                                if PlayersHitted[results[i].Parent] ~= nil then
                                else
                                    PlayersHitted[results[i].Parent] = results[i].Parent
                                    if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
                                        RightPunch = false
                                        local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
                                        local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
                                        if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
                                        if HRT:FindFirstChild("Light") == nil then
                                            Exp.Value = Exp.Value + 50
                                            HitSound:Play()
                                            local Velocity = Instance.new("BodyVelocity",HRT)
                                            Velocity.MaxForce = Vector3.new(10000,10000,10000)
                                            Velocity.Velocity = RootPart.CFrame.lookVector * 40
                                            Velocity.Name = "Light"
                                            local ObjectVal = Instance.new("ObjectValue",Velocity)
                                            ObjectVal.Value = RootPart
                                            ObjectVal.Name = "Hitist"
                                            game.Debris:AddItem(Velocity,.5)
                                            DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
                                            wait(0.1)
                                            Velocity:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                        lastresult = results
                    end
                end
            end)
            touchedy()
            wait(0.7)
            Attack.Value = false
            RightPunch = false
        elseif picked == 2 then
            LeftPunch = true
            Attack.Value = true
            local results = nil
            local lastresult = nil
            local PlayersHitted = {}
            local touchedy = coroutine.wrap(function()
                while wait(0.01) do
                    if LeftPunch == false then
                        break
                    end
                    local connection = Character.LeftHand.Touched:Connect(function()end)
                    results = Character.LeftHand:GetTouchingParts()
                    connection:Disconnect()
                    if results ~= lastresult then
                        for i=1,#results do
                            if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
                                if PlayersHitted[results[i].Parent] ~= nil then
                                else
                                    PlayersHitted[results[i].Parent] = results[i].Parent
                                    if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
                                        LeftPunch = false
                                        local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
                                        local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
                                        if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
                                        if HRT:FindFirstChild("Light") == nil then
                                            Exp.Value = Exp.Value + 50
                                            HitSound:Play()
                                            local Velocity = Instance.new("BodyVelocity",HRT)
                                            Velocity.MaxForce = Vector3.new(10000,10000,10000)
                                            Velocity.Velocity = RootPart.CFrame.lookVector * 40
                                            Velocity.Name = "Light"
                                            local ObjectVal = Instance.new("ObjectValue",Velocity)
                                            ObjectVal.Value = RootPart
                                            ObjectVal.Name = "Hitist"
                                            game.Debris:AddItem(Velocity,.5)
                                            DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
                                            wait(0.1)
                                            Velocity:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                        lastresult = results
                    end
                end
            end)
            touchedy()
            wait(0.7)
            Attack.Value = false
            LeftPunch = false
        elseif picked == 3 then
            RightKick = true
            Attack.Value = true
            local results = nil
            local lastresult = nil
            local PlayersHitted = {}
            local touchedy = coroutine.wrap(function()
                while wait(0.01) do
                    if RightKick == false then
                        break
                    end
                    local connection = Character.RightFoot.Touched:Connect(function()end)
                    results = Character.RightFoot:GetTouchingParts()
                    connection:Disconnect()
                    if results ~= lastresult then
                        for i=1,#results do
                            if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
                                if PlayersHitted[results[i].Parent] ~= nil then
                                else
                                    PlayersHitted[results[i].Parent] = results[i].Parent
                                    if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
                                        RightKick = false
                                        local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
                                        local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
                                        if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
                                        if HRT:FindFirstChild("Light") == nil then
                                            Exp.Value = Exp.Value + 50
                                            HitSound:Play()
                                            local Velocity = Instance.new("BodyVelocity",HRT)
                                            Velocity.MaxForce = Vector3.new(10000,10000,10000)
                                            Velocity.Velocity = RootPart.CFrame.lookVector * 40
                                            Velocity.Name = "Light"
                                            local ObjectVal = Instance.new("ObjectValue",Velocity)
                                            ObjectVal.Value = RootPart
                                            ObjectVal.Name = "Hitist"
                                            game.Debris:AddItem(Velocity,.5)
                                            DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
                                            wait(0.1)
                                            Velocity:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                        lastresult = results
                    end
                end
            end)
            touchedy()
            wait(0.7)
            Attack.Value = false
            RightKick = false
        elseif picked == 4 then
            LeftKick = true
            Attack.Value = true
            local results = nil
            local lastresult = nil
            local PlayersHitted = {}
            local touchedy = coroutine.wrap(function()
                while wait(0.01) do
                    if LeftKick == false then
                        break
                    end
                    local connection = Character.LeftFoot.Touched:Connect(function()end)
                    results = Character.LeftFoot:GetTouchingParts()
                    connection:Disconnect()
                    if results ~= lastresult then
                        for i=1,#results do
                            if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent ~= Character then
                                if PlayersHitted[results[i].Parent] ~= nil then
                                else
                                    PlayersHitted[results[i].Parent] = results[i].Parent
                                    if results[i].Parent:FindFirstChild("Humanoid") and results[i].Parent:FindFirstChild("Humanoid").Health > 0 then
                                        LeftKick = false
                                        local hum = results[i].Parent:FindFirstChildOfClass("Humanoid")
                                        local HRT = results[i].Parent:FindFirstChild("HumanoidRootPart")
                                        if (HRT.Position - RootPart.Position).Magnitude > 10 then return end
                                        if HRT:FindFirstChild("Light") == nil then
                                            Exp.Value = Exp.Value + 50
                                            HitSound:Play()
                                            local Velocity = Instance.new("BodyVelocity",HRT)
                                            Velocity.MaxForce = Vector3.new(10000,10000,10000)
                                            Velocity.Velocity = RootPart.CFrame.lookVector * 40
                                            Velocity.Name = "Light"
                                            local ObjectVal = Instance.new("ObjectValue",Velocity)
                                            ObjectVal.Value = RootPart
                                            ObjectVal.Name = "Hitist"
                                            game.Debris:AddItem(Velocity,.5)
                                            DmgFunction:Fire(Character, hum, 20*Strength.Value/2)
                                            wait(0.1)
                                            Velocity:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                        lastresult = results
                    end
                end
            end)
            wait(0.7)
            Attack.Value = false
            LeftKick = false
        end
        if picked <= 3 then
            picked = picked + 1
        elseif picked == 4 then
            picked = 1
        end
    end
end)


while wait() do
    if Humanoid.Health == Humanoid.MaxHealth then
        Humanoid.MaxHealth = 150+150*Durability.Value
        Humanoid.Health = Humanoid.MaxHealth
    else
        Humanoid.MaxHealth = 150+150*Durability.Value
    end
    if Run == true then
        if Stamina.Value < 2 then
            Run = false
            Humanoid.WalkSpeed = 18
        end
    end
end

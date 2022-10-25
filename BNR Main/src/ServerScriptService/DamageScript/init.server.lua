local DamageFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local PlayerData = workspace.S1c2R5i66p5t5s51:WaitForChild("PlayerData")
local DamagePart = script:WaitForChild("DamagePart")
local PartyFinder = game.ReplicatedStorage:WaitForChild("PartyFinder")
local Party = game.ReplicatedStorage:WaitForChild("Party")
local PVP = game.ReplicatedStorage:WaitForChild("PVP")
local HitParticle = script:WaitForChild("HitParticle")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

PVP.OnServerEvent:Connect(function(player,Check)
    local plr = game.Players:FindFirstChild(player.Name)
    local character = player.Character
    local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(player.Name)
    if PlayerData then
        local Level = PlayerData:FindFirstChild("Level")
        if Check == "Check" and Level then
            if Level.Value >= 500 then
                PVP:FireClient(plr,"Close")
            end
        else
            if character:FindFirstChild("PVPOFF") then
                character:FindFirstChild("PVPOFF"):Destroy()
                local CD = Instance.new("Model", character)
                CD.Name = "PVPCooldown"
                game.Debris:AddItem(CD,60)
                PVP:FireClient(plr,"On")
            else
                if Level.Value < 500 and Level.Value > 50 and not character:FindFirstChild("PVPCooldown") then
                    local PVPOFF = Instance.new("Model",character)
                    PVPOFF.Name = "PVPOFF"
                    PVP:FireClient(plr,"Off")
                end
            end
        end
    end
end)

function FindPartyMember(plr, player)
    local PartyFolder = game.ServerStorage.Parties:FindFirstChild(plr.Name):GetChildren()
    local found = false
    if PartyFolder then
        for i, party in ipairs(PartyFolder) do
            if party.Value == player.Name then
                found = true    
                break
            end
        end
    end
	local EnemyFile = PlayerData:FindFirstChild(player.Name)
    if EnemyFile and not found then
    	local EnemyLevel = EnemyFile:FindFirstChild("Level")
		if plr:FindFirstChild("PVPOFF") then
				found = true
		elseif player:FindFirstChild("PVPOFF") then
				found = true
		elseif 	plr:FindFirstChildOfClass("ForceField") and plr:FindFirstChildOfClass("ForceField").Visible == true then
				found = true
		elseif EnemyLevel.Value <= 50 then
				found = true
		end
	end
	return found
end

PartyFinder.OnInvoke = FindPartyMember



Party.OnServerEvent:Connect(function(Player,PartyNumber,Name)
    local PartyFolder =  game.ServerStorage.Parties:FindFirstChild(Player.Name)
    if PartyFolder then
        if PartyNumber == 1 then
            local Party = PartyFolder:FindFirstChild("Party1")
            if Party then
                Party.Value = Name
            end
        elseif PartyNumber == 2 then
            local Party = PartyFolder:FindFirstChild("Party2")
            if Party then
                Party.Value = Name
            end
        elseif PartyNumber == 3 then
            local Party = PartyFolder:FindFirstChild("Party3")
            if Party then
                Party.Value = Name
            end
        elseif PartyNumber == 4 then
            local Party = PartyFolder:FindFirstChild("Party4")
            if Party then
                Party.Value = Name
            end
        end
    end
end)

local function round(number)
    return math.floor(number + 0.5)
end

DamageFunction.Event:Connect(function(Character, hum, damage)
    local EnemyCharacter = hum.Parent
    local HRT = EnemyCharacter:FindFirstChild("HumanoidRootPart")
    local EnemyTorso = EnemyCharacter:FindFirstChild("UpperTorso")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Distance = (RootPart.Position - HRT.Position).magnitude
    local RootPartYPosition = RootPart.Position.Y
    if Distance > 500 or RootPartYPosition < 300 and not RootPart.Parent.Parent == workspace.Arena then
        return end


    local DamagePartClone = DamagePart:Clone()
    DamagePartClone.Parent = workspace
    local DamageGuiClone = DamagePartClone.DamageGui
    game.Debris:AddItem(DamagePartClone,1)
    if EnemyTorso then
        local HitParticleClone = HitParticle:Clone()
        HitParticleClone.Parent = EnemyTorso
        spawn(function()
            game.Debris:AddItem(HitParticleClone , .5)
            wait(.1)
            HitParticleClone.Enabled = false
        end)
    end

	local DamageBoost = Character:FindFirstChild("DamageBoost")

	if Character.Parent.Name == "NPCs" then
		damage = damage*2
	else
		if DamageBoost then
			damage = damage*DamageBoost.Value
		end
	end

    local DamageValue = 0
    local EnemyDefense = EnemyCharacter:FindFirstChild("Defense")
    local EnemyArmorDefense = EnemyCharacter:FindFirstChild("ArmorDefense")

    if not EnemyDefense then
        if EnemyArmorDefense then
            DamageValue = damage-EnemyArmorDefense.Value
        elseif not EnemyArmorDefense then
            DamageValue = damage
        end

    elseif EnemyDefense then
        if EnemyArmorDefense then
            DamageValue = (damage-EnemyArmorDefense.Value)/EnemyDefense.Value
        elseif not EnemyArmorDefense then
            DamageValue = damage/EnemyDefense.Value
        end
    end

    if DamageValue < 0 then
        DamageValue = 0
    end

    if EnemyDefense and EnemyDefense:FindFirstChild("ImpactRecoil") and hum.Health > DamageValue and DamageValue > 0 then
        DamageFunction:Fire(EnemyCharacter, Character.Humanoid, DamageValue)
	end
	
	if EnemyArmorDefense and EnemyArmorDefense:FindFirstChild("Spiked") and hum.Health > DamageValue and damage > 0 then
		if EnemyArmorDefense.Value-DamageValue > 0 then
			DamageFunction:Fire(EnemyCharacter, Character.Humanoid, damage)
		else
			DamageFunction:Fire(EnemyCharacter, Character.Humanoid, EnemyArmorDefense.Value)
		end
	end

    if Character.Parent.Name == "NPCs" then
        if EnemyCharacter.Parent.Name ~= "NPCs" then
            if not EnemyCharacter:FindFirstChildOfClass("ForceField") then
                DamageGuiClone.Frame.DamageText.Text = tostring(round(DamageValue/10))
                DamagePartClone.CFrame = HRT.CFrame
                hum:TakeDamage(DamageValue)
            elseif EnemyCharacter:FindFirstChildOfClass("ForceField") and EnemyCharacter:FindFirstChildOfClass("ForceField").Visible == true then
                for i,part in pairs(HRT:GetChildren()) do
                    if part:IsA("BodyPosition") then
                        part:Destroy()
                    end
                end
				spawn(function()
					game:GetService("RunService").Stepped:Wait()
						if HRT:FindFirstChild("Heavy") then
						HRT:FindFirstChild("Heavy"):Destroy()
					end
				end)
            end
        end

    elseif Character.Parent.Name ~= "NPCs" then
        local Party = game.ServerStorage.Parties:FindFirstChild(Character.Name)
        for i,v in pairs(Party:GetChildren()) do
            if v.Name == "Party1" or v.Name == "Party2" or v.Name == "Party3" or v.Name == "Party4" then
                if v.Value == EnemyCharacter.Name and EnemyCharacter.Parent.Name ~= "NPCs" then
                    DamageGuiClone.Frame.DamageText.Text = "Party"
                    DamagePartClone.CFrame = HRT.CFrame
                    TweenService:Create(DamageGuiClone, TweenInfo.new(.75), {StudsOffset = Vector3.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))}):Play()
                    game:GetService("RunService").Stepped:Wait()
                    for i,part in pairs(HRT:GetChildren()) do
                        if part:IsA("BodyPosition") then
                            part:Destroy()
                        end
                        if part.Name == "Light" or part.Name == "Heavy" then
                            local Hitist = part:FindFirstChild("Hitist")
                            if Hitist then
                                if Hitist.Value == RootPart then
                                    part:Destroy()
                                end
                            end
                        end
						spawn(function()
							if not HRT:FindFirstChild("Light") then
								local Light = Instance.new("IntValue", HRT)
								Light.Name = "Light"
								game:GetService("RunService").Stepped:Wait()
								HRT:FindFirstChild("Light"):Destroy()
							end
						end)
                    end
                    return
                end
            end
        end
        if EnemyCharacter.Parent.Name ~= "NPCs" and EnemyCharacter:FindFirstChildOfClass("ForceField") 
        or EnemyCharacter.Parent.Name ~= "NPCs" and Character:FindFirstChildOfClass("ForceField") then
			if EnemyCharacter:FindFirstChildOfClass("ForceField") and EnemyCharacter:FindFirstChildOfClass("ForceField").Name ~= "PassiveMode"
			or Character:FindFirstChildOfClass("ForceField") and Character:FindFirstChildOfClass("ForceField").Visible == true and EnemyCharacter.Name ~= "Punching bag" then
	            DamageGuiClone.Frame.DamageText.Text = "Protected"
	            DamagePartClone.CFrame = HRT.CFrame
				game:GetService("RunService").Stepped:Wait()
	            for i,part in pairs(HRT:GetChildren()) do
	                if part:IsA("BodyPosition") then
	                    part:Destroy()
	                end
	                if part.Name == "Light" or part.Name == "Heavy" then
	                    local Hitist = part:FindFirstChild("Hitist")
	                    if Hitist then
	                        if Hitist.Value == RootPart then
	                            part:Destroy()
	                        end
	                    end
	                end
					spawn(function()
						if not HRT:FindFirstChild("Light") then
							local Light = Instance.new("IntValue", HRT)
							Light.Name = "Light"
							wait()
							HRT:FindFirstChild("Light"):Destroy()
						end
					end)
	            end
	            return
			else
				if EnemyCharacter.Name ~= "Punching bag" and Character:FindFirstChildOfClass("ForceField") and Character:FindFirstChildOfClass("ForceField").Visible == true then
				game:GetService("RunService").Stepped:Wait()
	            for i,part in pairs(HRT:GetChildren()) do
	                if part:IsA("BodyPosition") then
	                    part:Destroy()
	                end
	                if part.Name == "Light" or part.Name == "Heavy" then
	                    local Hitist = part:FindFirstChild("Hitist")
	                    if Hitist then
	                        if Hitist.Value == RootPart then
	                            part:Destroy()
	                        end
	                    end
	                end
					spawn(function()
						if not HRT:FindFirstChild("Light") then
							local Light = Instance.new("IntValue", HRT)
							Light.Name = "Light"
							wait()
							HRT:FindFirstChild("Light"):Destroy()
						end
					end)
	            end
				return
				end
			end
		end
        local CharacterFile = PlayerData:FindFirstChild(Character.Name)
        local CharacterLevel = CharacterFile:FindFirstChild("Level")

        if not Character:FindFirstChild("Safezone") then
            if EnemyCharacter.Parent.Name == "NPCs" then
                DamageGuiClone.Frame.DamageText.Text = tostring(round(DamageValue/10))
                DamagePartClone.CFrame = HRT.CFrame
                hum:TakeDamage(DamageValue)
                if EnemyCharacter:FindFirstChild("PlayersHitted") then
                    if not EnemyCharacter.PlayersHitted:FindFirstChild(Character.Name) then
                        local HitValue = Instance.new("NumberValue", EnemyCharacter.PlayersHitted)
                        HitValue.Name = Character.Name
                        HitValue.Value = DamageValue
                    elseif EnemyCharacter.PlayersHitted:FindFirstChild(Character.Name) then
                        local HitValue = EnemyCharacter.PlayersHitted:FindFirstChild(Character.Name)
                        HitValue.Value = HitValue.Value + DamageValue
                    end
                end
            elseif EnemyCharacter.Parent.Name ~= "NPCs" and Character:FindFirstChild("PVPOFF") then
                DamageGuiClone.Frame.DamageText.Text = "PVP Disabled"
                DamagePartClone.CFrame = RootPart.CFrame
                    game:GetService("RunService").Stepped:Wait()
                    for i,part in pairs(HRT:GetChildren()) do
                        if part:IsA("BodyPosition") then
                            part:Destroy()
                        end
                        if part.Name == "Light" or part.Name == "Heavy" then
                            local Hitist = part:FindFirstChild("Hitist")
                            if Hitist then
                                if Hitist.Value == RootPart then
                                    part:Destroy()
                                end
                            end
                        end
						spawn(function()
							if not HRT:FindFirstChild("Light") then
								local Light = Instance.new("IntValue", HRT)
								Light.Name = "Light"
								game:GetService("RunService").Stepped:Wait()
								HRT:FindFirstChild("Light"):Destroy()
							end
						end)
					end
            elseif EnemyCharacter.Parent.Name ~= "NPCs" and EnemyCharacter:FindFirstChild("PVPOFF") then
                DamageGuiClone.Frame.DamageText.Text = "PVP Disabled."
                DamagePartClone.CFrame = HRT.CFrame
                    game:GetService("RunService").Stepped:Wait()
                    for i,part in pairs(HRT:GetChildren()) do
                        if part:IsA("BodyPosition") then
                            part:Destroy()
                        end
                        if part.Name == "Light" or part.Name == "Heavy" then
                            local Hitist = part:FindFirstChild("Hitist")
                            if Hitist then
                                if Hitist.Value == RootPart then
                                    part:Destroy()
                                end
                            end
                        end
						spawn(function()
							if not HRT:FindFirstChild("Light") then
								local Light = Instance.new("IntValue", HRT)
								Light.Name = "Light"
								game:GetService("RunService").Stepped:Wait()
								HRT:FindFirstChild("Light"):Destroy()
							end
						end)
					end
            elseif EnemyCharacter.Parent.Name ~= "NPCs" and CharacterLevel.Value <= 50 then
                DamageGuiClone.Frame.DamageText.Text = "Must be level 50 to PVP!"
                DamagePartClone.CFrame = RootPart.CFrame
                    game:GetService("RunService").Stepped:Wait()
                    for i,part in pairs(HRT:GetChildren()) do
                        if part:IsA("BodyPosition") then
                            part:Destroy()
                        end
                        if part.Name == "Light" or part.Name == "Heavy" then
                            local Hitist = part:FindFirstChild("Hitist")
                            if Hitist then
                                if Hitist.Value == RootPart then
                                    part:Destroy()
                                end
                            end
                        end
						spawn(function()
							if not HRT:FindFirstChild("Light") then
								local Light = Instance.new("IntValue", HRT)
								Light.Name = "Light"
								game:GetService("RunService").Stepped:Wait()
								HRT:FindFirstChild("Light"):Destroy()
							end
						end)
					end
            elseif EnemyCharacter.Parent.Name ~= "NPCs" and CharacterLevel.Value > 50 then
                local EnemyFile = PlayerData:FindFirstChild(EnemyCharacter.Name)
                if EnemyFile then
                    local EnemyLevel = EnemyFile:FindFirstChild("Level")
                    if EnemyLevel.Value <= 50 then
                        DamageGuiClone.Frame.DamageText.Text = "Low level"
                        DamagePartClone.CFrame = HRT.CFrame
                    game:GetService("RunService").Stepped:Wait()
                    for i,part in pairs(HRT:GetChildren()) do
                        if part:IsA("BodyPosition") then
                            part:Destroy()
                        end
                        if part.Name == "Light" or part.Name == "Heavy" then
                            local Hitist = part:FindFirstChild("Hitist")
                            if Hitist then
                                if Hitist.Value == RootPart then
                                    part:Destroy()
                                end
                            end
                        end
						spawn(function()
							if not HRT:FindFirstChild("Light") then
								local Light = Instance.new("IntValue", HRT)
								Light.Name = "Light"
								game:GetService("RunService").Stepped:Wait()
								HRT:FindFirstChild("Light"):Destroy()
							end
						end)
					end
                    elseif EnemyLevel.Value > 50 then
                        DamageGuiClone.Frame.DamageText.Text = tostring(round(DamageValue/10))
                        DamagePartClone.CFrame = HRT.CFrame
                        hum:TakeDamage(DamageValue)
                    end
                end
            end
        end
    else
        DamageGuiClone.Frame.DamageText.Text = "Safezone"
        DamagePartClone.CFrame = RootPart.CFrame
    end
    TweenService:Create(DamageGuiClone, TweenInfo.new(.75), {StudsOffset = Vector3.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))}):Play()
end)


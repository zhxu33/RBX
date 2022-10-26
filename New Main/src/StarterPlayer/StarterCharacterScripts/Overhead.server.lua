local BBG = script:WaitForChild("OverHead")
local FT = script:WaitForChild("OverHead"):WaitForChild("OverheadBase"):WaitForChild("FameTag")
local Player = game.Players:GetPlayerFromCharacter(script.Parent)
local Character = Player.Character or Player.CharacterAdded:Wait()
repeat wait() until workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)
local PlayerData = workspace.S1c2R5i66p5t5s51.PlayerData:FindFirstChild(Player.Name)

local Fame = PlayerData:WaitForChild("Fame") 
local Name = script:WaitForChild("OverHead"):WaitForChild("OverheadBase"):WaitForChild("nametag")
local Head = script.Parent:WaitForChild("Head")
local Humanoid = script.Parent:WaitForChild("Humanoid")

BBG.Parent = Character:WaitForChild("Head")
local FameTitle = Player:WaitForChild("FameTitle")
local Found = false
local HeroTitles = require(game.ReplicatedStorage.Modules.Fame.HeroTitles)
local VillainTitles = require(game.ReplicatedStorage.Modules.Fame.VillainTitles)
Name.Text = script.Parent.Name

local function CustomUp(title)
	if Found == false then
		FT.TextColor3 = Color3.fromRGB(232, 166, 0)
		Name.TextColor3 = Color3.fromRGB(232, 166, 0)
		FT.Text = "[ "..FameTitle.Value.." ]"
		Found = true
	end
end

local function UpdateTitle(newV)
	if Found == true then Found = false end	
	if newV == nil then wait() newV = FameTitle.Value end
	if Fame.Value == 0 then
		if newV == "" then
			FT.Text = "[ Citizen ]"
			FT.TextColor3 = Color3.fromRGB(159, 159, 159)
			Name.TextColor3 = Color3.fromRGB(159, 159, 159)
			Found = true
		end
		CustomUp(newV)
	elseif Fame.Value > 0 then
		for i=1,#HeroTitles do
			if newV == HeroTitles[i]["Name"] then
				local v1 = HeroTitles[i]["Color"][1]
				local v2 = HeroTitles[i]["Color"][2]
				local v3 = HeroTitles[i]["Color"][3]
				FT.TextColor3 = Color3.fromRGB(v1, v2, v3)
				Name.TextColor3 = Color3.fromRGB(v1, v2, v3)
				FT.Text = "[ "..HeroTitles[i]["Name"].." ]"
				Found = true
				break
			elseif newV == "" then
				for i=1, #HeroTitles do
					if Fame.Value >= HeroTitles[i]["Fame"] then
						local v1 = HeroTitles[i]["Color"][1]
						local v2 = HeroTitles[i]["Color"][2]
						local v3 = HeroTitles[i]["Color"][3]
						FT.Text = "[ "..HeroTitles[i]["Name"].." ]"
						FT.TextColor3 = Color3.fromRGB(v1, v2, v3)
						Name.TextColor3 = Color3.fromRGB(v1, v2, v3)
						Found = true
						break
					end
				end
			end
		end
		CustomUp(newV)
	elseif Fame.Value < 0 then 
		for i=1,#VillainTitles do
			if newV == VillainTitles[i]["Name"] then
				local v1 = VillainTitles[i]["Color"][1]
				local v2 = VillainTitles[i]["Color"][2]
				local v3 = VillainTitles[i]["Color"][3]
				FT.TextColor3 = Color3.fromRGB(v1, v2, v3)
				Name.TextColor3 = Color3.fromRGB(v1, v2, v3)
				FT.Text = "[ "..VillainTitles[i]["Name"].." ]"
				Found = true
				break
			elseif newV == "" then
				for i=1, #VillainTitles do
					if Fame.Value <= VillainTitles[i]["Fame"] then
						local v1 = VillainTitles[i]["Color"][1]
						local v2 = VillainTitles[i]["Color"][2]
						local v3 = VillainTitles[i]["Color"][3]
						FT.Text = "[ "..VillainTitles[i]["Name"].." ]"
						FT.TextColor3 = Color3.fromRGB(v1, v2, v3)
						Name.TextColor3 = Color3.fromRGB(v1, v2, v3)
						Found = true
						break
					end
				end
			end
		end
		CustomUp(newV)
	end
end

Fame:GetPropertyChangedSignal("Value"):Connect(function()
	local newV = FameTitle.Value
	UpdateTitle(newV)
end)

FameTitle:GetPropertyChangedSignal("Value"):Connect(function()
	local newV = FameTitle.Value
	UpdateTitle(newV)
end)

UpdateTitle()

if FameTitle == "" then
	local value = ""
	UpdateTitle(value)
end

local bar = BBG.OverheadBase.Overheadbars.hpbg.hp 
local staminaBar = BBG.OverheadBase.Overheadbars.spbg.sp

repeat game:GetService("RunService").Heartbeat:Wait() until Character:GetAttribute("Stamina") and Character:GetAttribute("MaxStamina")

local function update()
	local humanoid = Character:WaitForChild("Humanoid")
	local Stamina = Character:GetAttribute("Stamina")
	local MaxStamina = Character:GetAttribute("MaxStamina")
	bar:TweenSize(UDim2.new(humanoid.Health / humanoid.MaxHealth, 0,1,0), Enum.EasingDirection.In, Enum.EasingStyle.Quint,0.01,true)
	staminaBar:TweenSize(UDim2.new(Stamina/MaxStamina, 0,1,0),Enum.EasingDirection.In,Enum.EasingStyle.Quint,0.01,true)
end

local C1 = Humanoid:GetPropertyChangedSignal("Health"):Connect(update)
local C2 = Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(update)
local C3 = Character:GetAttributeChangedSignal("Stamina"):Connect(update)
local C4 = Character:GetAttributeChangedSignal("MaxStamina"):Connect(update)

bar.AncestryChanged:Connect(function(_, Parento)
	if not Parento then
		C1:Disconnect()
		C2:Disconnect()
		C3:Disconnect()
		C4:Disconnect()
	end
end)
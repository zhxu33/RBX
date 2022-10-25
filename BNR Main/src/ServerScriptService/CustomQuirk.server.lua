local Saitama = game.ReplicatedStorage.CustomQuirk:WaitForChild("Saitama")
local Ians = game.ReplicatedStorage.CustomQuirk:WaitForChild("10ian10s")
local Smiley = game.ReplicatedStorage.CustomQuirk:WaitForChild("MrSmiley")
local GER = game.ReplicatedStorage.CustomQuirk:WaitForChild("GER")
local Tonys = game.ReplicatedStorage.CustomQuirk:WaitForChild("Tonyy")
local BloodCurdle = game.ReplicatedStorage.CustomQuirk:WaitForChild("BloodCurdle")
local DIO = game.ReplicatedStorage.CustomQuirk:WaitForChild("DIO")
local QAM = require(game.ReplicatedStorage.CustomQuirk.QuirkAccess)
	
Saitama.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.Saitama
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Character = Player.Character
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "Attack" or v.Name == "Defense" or v.Name == "WeaponType" or v.Name == "Stamina" or v.Name == "MaxStamina" or v:IsA("Script") and v.Name ~= "Sound" and v.ClassName ~= "LocalScript" then
				v:destroy()
			end
		end
		--[[local listy = Character:GetChildren()
		for i=1, #listy do
			if listy[i].ClassName == "Pants" or listy[i].ClassName == "Shirt"  or listy[i].ClassName == "BodyColors" or listy[i].ClassName == "Accessory" then
				listy[i]:Destroy()
			end
			if listy[i].Name == "Head" then
				listy[i]:FindFirstChild("OverHead"):Destroy()
				listy[i]:FindFirstChild("face"):Destroy()
			end
		end
		local QG = game.ServerStorage.CustomQuirk.AttackStorage.Saitama
		local HM = Character:FindFirstChild("Humanoid")
		wait(0.1)
		HM.WalkSpeed = 5
		QG["Body Colors"]:Clone().Parent = Character
		QG.Clothing:Clone().Parent = Character
		QG.Clothing1:Clone().Parent = Character
		QG.Face:Clone().Parent = Character.Head
		QG.OverHead:Clone().Parent = Character.Head]]
		--jason said he wanted to use his own char now so /shrug
		game.ServerStorage.CustomQuirk.UsuaIJason:Clone().Parent = Character
		end
end)

BloodCurdle.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.Blood
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Character = Player.Character
		for v,parts in pairs(Character:GetChildren()) do
			if parts:IsA("Script") and parts.Name ~= "Animate" and parts.Name ~= "Main" then
				parts:Destroy()
			end
		end
		game.ServerStorage.CustomQuirk.BloodCurdle:Clone().Parent = Character
	end
end)


Tonys.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.Tonyyy
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Character = Player.Character
		local Humanoid = Character:WaitForChild("Humanoid")
		local RootPart = Character:WaitForChild("HumanoidRootPart")
		for i,v in pairs(Character:GetChildren()) do
			if v.Name =="Attack" --[[or v.Name == "Defense"]] or v.Name == "WeaponType" or v.Name == "Stamina" or v.Name == "MaxStamina" or v:IsA("Script") and v.Name ~= "Sound" and v.ClassName ~= "LocalScript" then
				v:destroy()
			end
		end
		local listy = Character:GetChildren()
		for i=1, #listy do
			if listy[i].ClassName == "BodyColors" or listy[i].ClassName == "Accessory" then
				listy[i]:Destroy()
			end
			if listy[i].Name == "Head" then
				listy[i]:FindFirstChild("face"):Destroy()
			end
		end
		--
		local listy = Character.Head:GetChildren()
		for i=1, #listy do
			if listy[i].Name == "OverHead" then
				listy[i]:FindFirstChild("Name"):Destroy()
				
			end
		end--]]
		--[[local listy = Character.Head.OverHead:GetDescendants()
		listy.Statistics.AvatarFrame:Destroy()
		listy.Name:Destroy()
		game.ServerStorage.CustomQuirk.AttackStorage.tony.OverHeadKu.Name:Clone().Parent = listy--]]
		local gokuname = game.ServerStorage.CustomQuirk.AttackStorage.tony.Goku:Clone()
		local gogetaname = game.ServerStorage.CustomQuirk.AttackStorage.tony.Gogeta:Clone()
		gokuname.Parent = Character.Head.OverHead
		gogetaname.Parent = Character.Head.OverHead
		local QG = game.ServerStorage.CustomQuirk.AttackStorage.tony
		game.ServerStorage.CustomQuirk.Tonyyyyyyyy:Clone().Parent = Character
		game.ServerStorage.Quirks.Main:Clone().Parent = Character
		QG["Body Colors"]:Clone().Parent = Character
		QG["baseahir"]:Clone().Parent = Character
		local face = game.ServerStorage.CustomQuirk.AttackStorage.tony.faces
		local nose = face.nose:Clone()
		local mothu = face.mouth:Clone()
		local basefaceds = face.baseface:Clone()
		nose.Parent = Character.Head
		basefaceds.Parent = Character.Head
		mothu.Parent = Character.Head
	end
end)

GER.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.GER
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Rthro = {"LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg", "LeftUpperArm", "LeftUpperLeg", "LowerTorso", "RightFoot", "RightHand", "RightLowerArm", "RightLowerLeg", "RightUpperArm", "RightUpperLeg", "UpperTorso", "Head"}
		local Character = Player.Character
		for i,v in pairs(Character:GetChildren()) do
			if v.Name == "Attack" or v.Name == "Defense" or v.Name == "WeaponType" or v.Name == "Stamina" or v.Name == "MaxStamina" or v:IsA("Script") and v.Name ~= "Sound" and v.ClassName ~= "LocalScript" then
				v:destroy()
			end
		end
		local listy = Character:GetChildren()
		for i=1, #listy do
			if listy[i].ClassName == "Pants" or listy[i].ClassName == "Shirt" or listy[i].ClassName == "BodyColors" or listy[i].ClassName == "Accessory" then
				listy[i]:Destroy()
			end
			if listy[i].Name == "Head" then
				listy[i]:FindFirstChild("OverHead"):Destroy()
				listy[i]:FindFirstChild("face"):Destroy()
			end
		end
		local HM = Character:FindFirstChild("Humanoid")
		HM.BodyHeightScale.Value = .9
		HM.HeadScale.Value = 1
		local GM = game.ServerStorage.CustomQuirk.AttackStorage.GER.GERModel
		for i,parts in pairs(Character:GetChildren()) do
			if parts.Name ~= "HumanoidRootPart" then
				if parts:IsA("BasePart") then
					local PartIsRthro = false
					for i=1,#Rthro do
						if parts.Name == Rthro[i] then
							PartIsRthro = true
							break
						end
					end
					if PartIsRthro then
						parts.Transparency = 1
						local Replace = GM:FindFirstChild(parts.Name):Clone()
						local Motor = Instance.new("Weld", Replace)
						Replace.Parent = parts
						Replace.CFrame = parts.CFrame
						Motor.Part0 = parts
						Motor.Part1 = Replace
					end
				end
			end
		end
		game.ServerStorage.CustomQuirk.GER:Clone().Parent = Character
		game.ServerStorage.Quirks.Main:Clone().Parent = Character
	end
end)

DIO.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.DIO
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Character = Player.Character
		for i,v in pairs(Character:GetChildren()) do
			if v.Name =="Attack" or v.Name == "Defense" or v.Name == "WeaponType" or v.Name == "Stamina" or v.Name == "MaxStamina" or v:IsA("Script") and v.Name ~= "Sound" and v.ClassName ~= "LocalScript" then
				v:destroy()
			end
		end
		local listy = Character:GetChildren()
		for i=1, #listy do
			if listy[i].ClassName == "Pants" or listy[i].ClassName == "Shirt"  or listy[i].ClassName == "BodyColors" or 					listy[i].ClassName == "Accessory" then
				listy[i]:Destroy()
			end
			if listy[i].Name == "Head" then
				listy[i]:FindFirstChild("OverHead"):Destroy()
				listy[i]:FindFirstChild("face"):Destroy()
			end
		end
		local QG = game.ServerStorage.CustomQuirk.AttackStorage.Time
		local HM = Character:FindFirstChild("Humanoid")
		game.ServerStorage.CustomQuirk.DIO:Clone().Parent = Character
		game.ServerStorage.CustomQuirk.AttackStorage.Time.OverHead:Clone().Parent = Character.Head
		HM.BodyDepthScale.Value = 1.4
		HM.BodyHeightScale.Value = 1.4
		HM.BodyWidthScale.Value = 1.4
		HM.HeadScale.Value = 1.4
		QG["Body Colors"]:Clone().Parent = Character
		QG.DioHair:Clone().Parent = Character
		QG.Face:Clone().Parent = Character.Head
		QG.Clothing:Clone().Parent = Character
		QG.Clothing1:Clone().Parent = Character
		HM.WalkSpeed = 14
	end
end)

Smiley.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.Smileyman
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Character = Player.Character
		if not Character:FindFirstChild("Smileyman") then
			local list = Character:GetChildren()
			local SmileyFolder = game.ServerStorage.CustomQuirk.AttackStorage.Smiley
			local Hum = Character:FindFirstChild("Humanoid")
			local Transform = Hum:LoadAnimation(SmileyFolder.SmileyTransform)
			Transform:Play()
			Character.HumanoidRootPart.Anchored = true
			local ForceField = Character:FindFirstChildOfClass("ForceField")
			if ForceField then
				ForceField:Destroy()
			end
			repeat wait() until Transform.TimePosition > 0.01
			local Puking = SmileyFolder.PukePlaceholder.Puke:Clone()
			Puking.Parent = Character.Head
			game.Debris:AddItem(Puking, 1.8)
			wait(1)
			for i=1, #list do
				if list[i].ClassName == "Pants" or list[i].ClassName == "Shirt" or list[i].ClassName == "BodyColors" or list[i].ClassName == "Accessory" then
					local coro = coroutine.wrap(function()
						wait(0.75)
						list[i]:Destroy()
					end)
					coro()
				end
				if list[i].Name == "Head" then
					local coro = coroutine.wrap(function()
						wait(0.5)
						local Overhead = list[i]:FindFirstChild("OverHead")
						if Overhead then Overhead:Destroy() end
						local face = list[i]:FindFirstChild("face")
						if face then face:Destroy() end
						list[i].Transparency = 1
					end)
					coro()
				end
				if list[i].ClassName == "MeshPart" or list[i].ClassName == "Part" then
					if list[i].Name == "HumanoidRootPart" then
						for v,lights in pairs(list[i]:GetDescendants()) do
							if lights:IsA("PointLight") then
								lights:Destroy()
							end
						end
					end
					local coro = coroutine.wrap(function()
						game.TweenService:Create(list[i], TweenInfo.new(1.5), {Color = Color3.fromRGB(0, 0, 0)}):Play()
						wait(0.5)
						list[i].Material = "Neon"
					end)
					coro()
					for v,parts in pairs(list[i]:GetChildren()) do
						if parts:IsA("Model") or parts:IsA("BasePart") then
							parts:Destroy()
						end
					end
				end
			end
			local SmileyHead = game.ServerStorage.CustomQuirk.AttackStorage.Smiley.HeadFolder.FHead:Clone()
			SmileyHead.Parent = Character
			SmileyHead.CFrame = Character.Head.CFrame
			SmileyHead.Size = Character.Head.Size
			SmileyHead.Head.Part1 = Character.Head
			SmileyHead.Transparency = 1
			game.TweenService:Create(SmileyHead, TweenInfo.new(1.5), {Transparency = 0}):Play()
			for i,parts in pairs(SmileyHead:GetDescendants()) do
				if parts:IsA("Part") then
					parts.Transparency = 1
				end
			end
			for i,parts in pairs(SmileyHead:GetDescendants()) do
				if parts:IsA("Part") then
					game.TweenService:Create(parts, TweenInfo.new(1.5), {Transparency = 0}):Play()
				end
			end
			wait(0.7)
			game.ServerStorage.CustomQuirk.AttackStorage.Smiley.RedMenacing:Clone().Parent = Character.HumanoidRootPart
			game.ServerStorage.CustomQuirk.Smileyman:Clone().Parent = Character
			Character.HumanoidRootPart.Anchored = false
		end
	end
end)

Ians.OnServerEvent:Connect(function(Player)
	local PlayerList = QAM.QuirkAccess.PrimeAllMight
	local Access = false
	for i=1,#PlayerList do
		if Player.Name == PlayerList[i] then
			Access = true
			break
		end
	end
	if Access then
		local Character = Player.Character
		local listy = Character:GetChildren()
		for i=1, #listy do
			if listy[i].ClassName == "Pants" or listy[i].ClassName == "Shirt"  or listy[i].ClassName == "BodyColors" or listy[i].ClassName == "Accessory" then
				listy[i]:Destroy()
			end
			if listy[i].Name == "Head" then
				listy[i]:FindFirstChild("OverHead"):Destroy()
				listy[i]:FindFirstChild("face"):Destroy()
			end
			
		end
		local QG = game.ServerStorage.CustomQuirk.AttackStorage.PrimeAllMight
		local HM = Character:FindFirstChild("Humanoid")
		HM.BodyDepthScale.Value = 1.5
		HM.BodyHeightScale.Value = 1.55
		HM.BodyTypeScale.Value = 0
		HM.BodyWidthScale.Value = 1.55
		HM.HeadScale.Value = 1.5
		wait(0.1)
		QG["Body Colors"]:Clone().Parent = Character
		QG.Clothing:Clone().Parent = Character
		QG.Clothing1:Clone().Parent = Character
		QG["All might's hair"]:Clone().Parent = Character
		QG["allmighthair1"]:Clone().Parent = Character
		QG["allmighthair2"]:Clone().Parent = Character
		QG.OverHead:Clone().Parent = Character.Head
		game.ServerStorage.CustomQuirk.PrimeAllMight:Clone().Parent = Character
		wait(0.1)
		Character["All might's hair"].Handle.Mesh.Scale = QG.Mesh.Scale
	end
end)
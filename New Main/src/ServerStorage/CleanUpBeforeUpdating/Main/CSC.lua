 -- COMBAT FUNCTION SHORTCUTS (CFSC)

 --================================ [SERVICES] =================================--
local TweenService = game:GetService("TweenService")
local Debris      = game:GetService("Debris")
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")


 --================================ [VARIABLES] =================================--

local CombatFunctions = {}

 -- Player Variables

local PlayerDataFolder = workspace.S1c2R5i66p5t5s51.PlayerData

 -- Weapon Variables

local SwordEF = game.ServerStorage:WaitForChild("Weapons"):WaitForChild("WeaponEffects"):WaitForChild("KatanaEffect")

 -- Misc Variables

local Huge = math.huge
local DataModule = require(7497657537)

 --================================ [FUNCTIONS] =================================--

function CombatFunctions.Fade(ObjectList, delete, twinfo) -- tweeninfo = (lifespan, transparency, scale)
	for i=1,#ObjectList do
		coroutine.wrap(function()
			game.Debris:AddItem(ObjectList[i],twinfo[1])
			TweenService:Create(ObjectList[i], TweenInfo.new(twinfo[1]),{Transparency = twinfo[2]}):Play()
			if ObjectList[i]:FindFirstChild("Mesh") then
				TweenService:Create(ObjectList[i].Mesh, TweenInfo.new(twinfo[1]),{Scale = twinfo[3]}):Play()
			else
				TweenService:Create(ObjectList[i], TweenInfo.new(twinfo[1]),{Scale = twinfo[3]}):Play()
			end
			game.Debris:AddItem(ObjectList[i], delete)
		end)()
	end
end

function CombatFunctions.WhenHit(Character, Delete, target, object, alreadyhit, dmg)
	local PlayerFolder = PlayerDataFolder:FindFirstChild(Character.Name)
	local Exp = PlayerFolder.Experience
	
	for i,tableValue in pairs(alreadyhit) do
		if tableValue == target.Parent then object:Destroy() return end
	end
	table.insert(alreadyhit, target.Parent)
	
	if Delete then
		object:Destroy()
	end
	
	local hum = target.Parent:FindFirstChildOfClass("Humanoid")
	local HRT = target.Parent:FindFirstChild("HumanoidRootPart")
	
	if not HRT:FindFirstChild("Light") then
		task.spawn(function()
			for i=1, dmg[3] do
				if hum.Health > 0 then
					DmgFunction:Fire(Character,hum,dmg[1]/2, "Weapon")
				end
				
				task.wait(dmg[2])
			end
		end)
		
		Exp.Value += 50
		
		local Velocity = Instance.new("BodyVelocity",HRT)		
		Velocity.MaxForce = Vector3.new(Huge, Huge, Huge)
		Velocity.Velocity = Character.HumanoidRootPart.CFrame.lookVector * 50
		Velocity.Name = "Heavy"
		Velocity:AddItem(Velocity, 0.03)
		
		local ObjectVal = Instance.new("ObjectValue",Velocity)
		ObjectVal.Value = Character.HumanoidRootPart
		ObjectVal.Name = "Hitist"
		
		Debris:AddItem(Velocity, 0.5)
		Debris:AddItem(Velocity, 0.03)	
	end
end

function CombatFunctions:CreateSwordEF() -- Weapon Effect (Self = CFrame)
	local SwordEffect = SwordEF:Clone()
	SwordEffect.Parent = script
	SwordEffect.CFrame = self
	TweenService:Create(SwordEffect, TweenInfo.new(0.5),{Transparency = 1}):Play()
	game.Debris:AddItem(SwordEffect,0.5)
end

function CombatFunctions:FameAward(Player) -- (Self = Hum / The Part Hit's Humanoid)   Enemy Human / Parent of Hit Target || Activates aditional fame award after a weapon in used on a player / npc, not quirks
	if self.Health < 1 then

		local PlayerFolder = PlayerDataFolder[Player.Name]

		if game.Players:GetPlayerFromCharacter(self.Parent) then
			local enemyplrf = PlayerDataFolder:FindFirstChild(self.Parent.Name)
			local enemyplrFame = enemyplrf.Fame
			if enemyplrFame.Value > -1 then
				PlayerFolder.Fame.Value -= 1
			elseif enemyplrFame.Value <= -1 then
				PlayerFolder.Fame.Value += 1
			end

		elseif self.Parent:FindFirstChild("Fame") then
			local enemyplrFame = self.Parent.Fame
			if self.Parent.Name == "All Might" then
				PlayerFolder.Fame.Value -= 150
				PlayerFolder.Exp.Value += 100000
				PlayerFolder.Cash.Value += 10000
				local reward = game.ReplicatedStorage.Remotes.RewardPane
				reward:FireClient(Player, 100000, 10000)	
			elseif enemyplrFame.Value > -1 then
				PlayerFolder.Fame.Value -= 1
				PlayerFolder.Cash.Value += math.random(20,50)
			elseif enemyplrFame.Value <= -1 then
				PlayerFolder.Fame.Value += 1
				PlayerFolder.Cash.Value += math.random(20,50)
			end
		end
	end
end

local DefaultVelocityLife = .1

function CombatFunctions:ApplyVelocity(Power, HRT, VelocityLife, VelocityType, Player) -- (Self = Velocity (Force of Velocity)) Minor (Almost does nothing)

	local Velocity = Instance.new("BodyVelocity")
	Velocity.MaxForce = Vector3.new(self, self, self)

	if typeof(Power) == "number" then
		Velocity.Velocity = Player.PrimaryPart.CFrame.lookVector * Power
	elseif typeof(Power) == "Vector3" then
		Velocity.Velocity = Power
	end

	Velocity.Name = VelocityType
	Velocity.Parent = HRT

	local ObjectVal = Instance.new("ObjectValue")
	ObjectVal.Value = Player.PrimaryPart
	ObjectVal.Name = "Hitist"
	ObjectVal.Parent = Velocity

	if not VelocityLife then
		VelocityLife = DefaultVelocityLife
	end

	game.Debris:AddItem(Velocity, VelocityLife)
end

function CombatFunctions:AnimationHandler(Weapon, Speed, Type, CustomName) -- self is the type of animation
	local List = DataModule.PlayerInformation[self.UserId]
	local Tier
	
	if Weapon:GetAttribute("Tier") then
		Tier = tostring(Weapon:GetAttribute("Tier"))
	end
	
	
	local WeaponName = CustomName or List.Character:GetAttribute("Weapon_Type")	
	
	if Tier and tonumber(Tier) > 1 then
		WeaponName = "T"..Tier..WeaponName
	end
	
	if Type then
		WeaponName = WeaponName..Type
	end
	
	local MaxAnim = List.AnimationList[WeaponName] and type(List.AnimationList[WeaponName]) == "table" and #List.AnimationList[WeaponName]
	
	List.Anim = MaxAnim and List.Anim >= MaxAnim and 0 or List.Anim
	List.Anim += 1
	
	local Anim = List.AnimationList[WeaponName] and List.AnimationList[WeaponName][List.Anim]
	
	if Anim then
		Anim:Play()
		
		if Speed then
			Anim:AdjustSpeed(Speed)
		end
	else
		warn("Error Occured: " .. WeaponName .. " is not in animation list.")
	end
end

function CombatFunctions.TouchedHit(Hit, Blade, List, HitList, HitEffect)
	HitList = HitList or {}

	if List.SwordAttack and Hit.Parent:FindFirstChild("Humanoid") and Hit.Parent:FindFirstChild("Humanoid").Health > 0 and Hit.Parent ~= List.Character and not HitList[Hit.Parent] then
		HitList[Hit.Parent] = true
		List.SwordAttack = false
		local hum = Hit.Parent:FindFirstChildOfClass("Humanoid")
		local HRT = Hit.Parent.PrimaryPart
		
		if (HRT.Position - List.RootPart.Position).Magnitude > 10 then
			return 
		end
		
		DmgFunction:Fire(List.Character, hum, nil, "Weapon")

		coroutine.wrap(CombatFunctions.ApplyVelocity)(40, 10000, HRT, .1, "Light", List.Character)
		coroutine.wrap(CombatFunctions.CreateSwordEF)(Blade.CFrame)
		coroutine.wrap(CombatFunctions.FameAward)(hum, List.Player)
		
		if HitEffect then
			coroutine.wrap(HitEffect)(HRT)
		end
	end
end

function CombatFunctions:TrailEffect(Bool) -- self is the sword // Bool = on / off
	for DescendantIndex, Descendant in pairs(self:GetDescendants()) do
		if Descendant:IsA("Trail") or Descendant:IsA("ParticleEmitter") then
			Descendant.Enabled = Bool
		end
	end
end

CombatFunctions.PlayerMainList = {}

return CombatFunctions

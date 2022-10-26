local Ability = {}
local PlrBuffs = {}

local Players = game:GetService("Players")
local items = game:GetService("ServerStorage").ItemAssets.AbilityProjectiles
local TweenService = game:GetService("TweenService")

local BuffTypes = {
	Connections = {},
	Speed = {},
	DamageBoost = {},
	ArmorDefense = {},
}

--local RaycastHitbox = require(7496725777)
--local SpatialHitbox = require(7496792123)
local Huge = math.huge
local BuffUpdates = {}

--------------------------------------------------------------------------------------------------------------------------------------------
-------------------- Updater functions -----------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

function BuffUpdates.DamageBoost(Plr, Remove, Variables)
	if PlrBuffs[Plr.UserId]["Connections"]["DamageBoost"] then
		PlrBuffs[Plr.UserId]["Connections"]["DamageBoost"]:Disconnect()
	end
	if Plr.Character then
		local Humanoid = Plr.Character:WaitForChild("Humanoid")
		local DoneChangingStat = true
		local NewStatCache     = nil
		if Remove then
			Variables.Core:SetAttribute("DamageBoost", Variables.Core:GetAttribute("DamageBoost")  / Remove)  
		end
		local function AdjustStat()
			if DoneChangingStat and NewStatCache ~= Variables.Core:GetAttribute("DamageBoost") then				
				DoneChangingStat = false
				for Index,Value in pairs(PlrBuffs[Plr.UserId]["DamageBoost"]) do
					Variables.Core:SetAttribute("DamageBoost", Variables.Core:GetAttribute("DamageBoost") * Value)  
				end
				NewStatCache = Variables.Core:GetAttribute("DamageBoost")
				DoneChangingStat = true
			end
		end
		AdjustStat()
		local SpeedConnection = Variables.Core:GetAttributeChangedSignal("DamageBoost"):Connect(AdjustStat)
		PlrBuffs[Plr.UserId]["Connections"]["DamageBoost"] = SpeedConnection
	end
end

function BuffUpdates.ArmorDefense(Plr, Remove, Variables)
	if PlrBuffs[Plr.UserId]["Connections"]["ArmorDefense"] then
		PlrBuffs[Plr.UserId]["Connections"]["ArmorDefense"]:Disconnect()
	end
	if Plr.Character then
		local Humanoid = Plr.Character:WaitForChild("Humanoid")
		local DoneChangingStat = true
		local NewStatCache     = nil
		if Remove then
			Variables.Core:SetAttribute("ArmorDefense", Variables.Core:GetAttribute("ArmorDefense")  / Remove)  
		end
		local function AdjustStat()
			if DoneChangingStat and NewStatCache ~= Variables.Core:GetAttribute("ArmorDefense") then				
				DoneChangingStat = false
				for Index,Value in pairs(PlrBuffs[Plr.UserId]["ArmorDefense"]) do
					Variables.Core:SetAttribute("ArmorDefense", Variables.Core:GetAttribute("ArmorDefense") * Value)  
				end
				NewStatCache = Variables.Core:GetAttribute("ArmorDefense")
				DoneChangingStat = true
			end
		end
		AdjustStat()
		local SpeedConnection = Variables.Core:GetAttributeChangedSignal("ArmorDefense"):Connect(AdjustStat)
		PlrBuffs[Plr.UserId]["Connections"]["ArmorDefense"] = SpeedConnection
	end
end

function BuffUpdates.Speed(Plr, Remove)
	if PlrBuffs[Plr.UserId]["Connections"]["Speed"] then
		PlrBuffs[Plr.UserId]["Connections"]["Speed"]:Disconnect()
	end
	if Plr.Character then
		local Humanoid = Plr.Character:WaitForChild("Humanoid")
		local DoneChangingSpeed = true
		local NewSpeedCache     = nil
		if Remove then
			Humanoid.WalkSpeed /= Remove
		end
		local function AdjustSpeed()
			if DoneChangingSpeed and NewSpeedCache ~= Humanoid.WalkSpeed then				
				DoneChangingSpeed = false
				for Index,Value in pairs(PlrBuffs[Plr.UserId]["Speed"]) do
					Humanoid.WalkSpeed *= Value
				end
				NewSpeedCache = Humanoid.WalkSpeed
				DoneChangingSpeed = true
			end
		end
		AdjustSpeed()
		local SpeedConnection = Humanoid.Running:Connect(AdjustSpeed)
		PlrBuffs[Plr.UserId]["Connections"]["Speed"] = SpeedConnection
	end
end

function BuffUpdates.Regen(Plr, Remove)
	if PlrBuffs[Plr.UserId]["Connections"]["Speed"] then
		PlrBuffs[Plr.UserId]["Connections"]["Speed"]:Disconnect()
	end
	if Plr.Character then
		local Humanoid = Plr.Character:WaitForChild("Humanoid")
		local DoneChangingSpeed = true
		local NewSpeedCache     = nil
		if Remove then
			Humanoid.WalkSpeed /= Remove
		end
		local function AdjustSpeed()
			if DoneChangingSpeed and NewSpeedCache ~= Humanoid.WalkSpeed then				
				DoneChangingSpeed = false
				for Index,Value in pairs(PlrBuffs[Plr.UserId]["Speed"]) do
					Humanoid.WalkSpeed *= Value
				end
				NewSpeedCache = Humanoid.WalkSpeed
				DoneChangingSpeed = true
			end
		end
		AdjustSpeed()
		local SpeedConnection = Humanoid.Running:Connect(AdjustSpeed)
		PlrBuffs[Plr.UserId]["Connections"]["Speed"] = SpeedConnection
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------
-------------------- Functions for Abilites to use -----------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

function UpdateBuffEffects(Plr, BuffType, Remove, Vars)
	BuffUpdates[BuffType](Plr, Remove, Vars)
end

-- Buff library PlrBuffs = {PlayerID = {SpeedBuffs = {}}}
function SetUpBuffs(Plr)
	PlrBuffs[Plr.UserId] = BuffTypes
end

function RemovePlrFromBuffs(Plr, BuffType, BuffID)
	PlrBuffs[Plr.UserId] = nil
end

function RemoveBuff(Plr, BuffType, BuffID, Vars)
	if not PlrBuffs[Plr.UserId] then return end
	local OldBuff = PlrBuffs[Plr.UserId][BuffType][BuffID]
	PlrBuffs[Plr.UserId][BuffType][BuffID] = nil
	UpdateBuffEffects(Plr, BuffType, OldBuff, Vars)
end

function AddBuff(Plr, BuffType, Buff, Vars)
	if not PlrBuffs[Plr.UserId] then SetUpBuffs(Plr) end
	local BuffID = tick()
	PlrBuffs[Plr.UserId][BuffType][BuffID] = Buff
	UpdateBuffEffects(Plr, BuffType, nil, Vars)
	return BuffID
end

--------------------------------------------------------------------------------------------------------------------------------------------|
-------------------- Abilites --------------------------------------------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|

function Ability.Transparency(Core, model, Variables, Intensity) -- Transparency Effect 
	local undolist = {}
	for i=1,#Variables do
		local part = Core:FindFirstChild(Variables[i])		--  Core should equal character or the highest parented model.
		if part then
			table.insert(undolist, part)
			transparent(part, Intensity) -- single / children invisiblity
		elseif Variables[i] == "AllCore" then
			table.insert(undolist, Core)
			transparent(Core, Intensity) -- turns everything invisible 
		end			
	end
	model.AncestryChanged:Connect(function(_, parent) --when the model is removed the effect needs to be reversed.
		if not parent then --make sure it was parented to nil
			for i=1,#undolist do 
				transparent(undolist[i], 0) -- all shall be visible!
			end
		end
	end)
end

function Ability.RegenBuff(Core, model, Variables, Intensity) -- use for buffing healing on gear.
	local hum = Core:FindFirstChild("Humanoid")
	local running = true
	task.spawn(function()
		while wait(Variables[2]) and running and hum do
			if Variables[1] == "Percent" then
				hum.Health += hum.MaxHealth/(100/Intensity)
			elseif Variables[1] == "Amount" then
				hum.Health += Intensity
			end
		end
	end)
	
	model.AncestryChanged:Connect(function(_, parent) --when the model is removed the effect needs to be reversed.
		if not parent then --make sure it was parented to nil
			running = false
		end
	end)
end 

function Ability.GearBuff(Core, model, Intensity)
	if not Core:GetAttribute("DamageBoost") then
		Core:SetAttribute("DamageBoost", 1) 
	end
	if not Core:GetAttribute("ArmorDefense") then		
		Core:SetAttribute("ArmorDefense", 0) 
	end

	Core:SetAttribute("DamageBoost", 1*Intensity[1]) 
	Core:SetAttribute("ArmorDefense", 1+Intensity[2]) 
	local Connection
	Connection = model.AncestryChanged:Connect(function(_, parent) --when the model is removed the effect needs to be reversed.
		if not parent then --make sure it was parented to nil
			Connection:Disconnect()
			Core:SetAttribute("DamageBoost", Core:GetAttribute("DamageBoost") / Intensity[1]) 
			Core:SetAttribute("ArmorDefense", Core:GetAttribute("ArmorDefense") - Intensity[2]) 
		end
	end)
end 

function Ability.ClockWork(Core, model, Variables, Intensity) -- use for buffing healing on gear.
	local Plr = game.Players:FindFirstChild(Core.Name)
	local Humanoid = Core:FindFirstChild("Humanoid")
	local KeyEvent = Instance.new("RemoteEvent")
	local Switch = true
	KeyEvent.Name = "g"
	local KOP = Core:FindFirstChild("KOP")
	if not KOP then	return end
	KeyEvent.Parent = KOP 
	local Charge = 0
	local Tween1 = nil
	local Buff   = nil
	local Buff1   = nil
	local Tween2 = TweenService:Create(model.PrimaryPart, TweenInfo.new(12), {Color = Color3.fromRGB(220, 88, 42)})
	local Tween3 = TweenService:Create(model.PrimaryPart, TweenInfo.new(9), {Color = Color3.fromRGB(255, 165, 0)})
	KeyEvent.OnServerEvent:Connect(function(plr, OnOff)
		if Switch and not OnOff then
			if not model and not model.Parent then return end
			Switch = false
			Tween1:Cancel()
			Tween2:Play()
			local Charge = math.abs(Charge - tick())
			if Charge > 15 then
				Charge = 15
			end
			if Variables[1] == 1 then
				Buff = AddBuff(Plr, "Speed", 1+Charge/10)
			elseif Variables[1] == 2 then
				Buff = AddBuff(Plr, "DamageBoost", 1+Charge/60, {Core = Core})
				Buff1 = AddBuff(Plr, "ArmorDefense", 1+Charge/60, {Core = Core})
			end	
			wait(12)
			if not model and not model.Parent then return end
			Tween2:Cancel()
			Tween3:Play()
			if Variables[1] == 1 then
				RemoveBuff(Plr, "Speed", Buff)
				Buff = AddBuff(Plr, "Speed", 1-Charge/20)
			elseif Variables[1] == 2 then
				RemoveBuff(Plr, "DamageBoost", Buff, {Core = Core})
				RemoveBuff(Plr, "ArmorDefense", Buff1, {Core = Core})
				Buff = AddBuff(Plr, "DamageBoost", 1-Charge/100, {Core = Core})
				Buff1 = AddBuff(Plr, "ArmorDefense", 1-Charge/100, {Core = Core})
			end
			wait(9)			
			if not model and not model.Parent then return end
			if Variables[1] == 1 then
				RemoveBuff(Plr, "Speed", Buff)
			elseif Variables[1] == 2 then
				RemoveBuff(Plr, "DamageBoost", Buff, {Core = Core})
				RemoveBuff(Plr, "ArmorDefense", Buff1, {Core = Core})
			end
			Tween3:Cancel()		
			Switch = true
			Charge = 0
		elseif OnOff and Switch then
			Charge = tick()
			Tween1 = TweenService:Create(model.PrimaryPart, TweenInfo.new(15), {Color = Color3.fromRGB(255, 255, 0)})			
			Tween1:Play()
		end
	end)
	model.AncestryChanged:Connect(function(_, parent) --when the model is removed the effect needs to be reversed.
		if not parent then --make sure it was parented to nil
			if Buff then
				if Variables[1] == 1 then 
					RemoveBuff(Plr, "Speed", Buff, {Core = Core})	
				end					
			end
			KeyEvent:Destroy()
		end
	end)
end 

--------------------------------------------------------------------------------------------------------------------------------------------|
-------------------- Sub_Abilites ----------------------------------------------------------------------------------------------------------|
--------------------------------------------------------------------------------------------------------------------------------------------|




function transparent(part, Intensity) -- transparent function
	if part:IsA("BasePart") or part:IsA("Accessory") or part:IsA("MeshPart") then
		if part.Name ~= "HumanoidRootPart" then
			part.Transparency = Intensity
			for v,parts in pairs(part:GetChildren()) do		
				transparent(parts, Intensity)
			end
		end
	end
end

return Ability

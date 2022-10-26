local BLC = {}

local TweenService = game:GetService'TweenService'

local Effects = script.Parent.Effects
local Hitbox = script.Parent.HB
local LightningBox = script.Parent.LightningEffect

local Center = Effects.Center
local Pink = Effects.Pink
local Rays = Effects.Rays
local Black = Effects.Black

local ValueObject = script.Parent.Tween
ValueObject:GetPropertyChangedSignal("Value"):Connect(function()
	Pink.Rate = .5*ValueObject.Value
	Black.Rate = 1.5*ValueObject.Value
	LightningBox.Sparks.Rate = 20+20*(ValueObject.Value/5)
	LightningBox.Sparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5*ValueObject.Value/15), NumberSequenceKeypoint.new(1, 5*ValueObject.Value/15)})
	Center.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, ValueObject.Value), NumberSequenceKeypoint.new(1, 0)})
	Pink.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3*ValueObject.Value), NumberSequenceKeypoint.new(1, 0)})
	Black.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.5*ValueObject.Value), NumberSequenceKeypoint.new(1, 0)})
	Rays.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.75*ValueObject.Value), NumberSequenceKeypoint.new(1, 2.75*ValueObject.Value)})
end)

local DefaultValues = {
	HasHit = false,
	Scale = 1,
	ExtendDuration = .25,
	ExtendDelay = .25,
	TweenDuration = .5,
	Duration = 5
}

local RaycastVectors = {
	Vector3.new(0, 1, 0), Vector3.new(0, -1, 0),
	Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0),
	Vector3.new(0, 0, -1), Vector3.new(0, 0, -1)
}

local PR = RaycastParams.new()
PR.FilterType = Enum.RaycastFilterType.Blacklist

function BLC:Size(Table)
	
	local BT = DefaultValues
	for v,p in pairs(Table) do
		BT[v] = p
	end

	local DirectionCFrame = Hitbox.CFrame
	
	if BT.HasHit then -- Scrapped
		
		local ExtendDistance = 3*BT.Scale
		local RaycastDistance = ExtendDistance
		
		local ClosestMagnitude, SelectedVector = math.huge, nil
		PR.FilterDescendantsInstances = {self, script.Parent, workspace.InteractionNPCS}
		
		for i=1,#RaycastVectors do

			local CastRay = workspace:Raycast(Hitbox.Position, RaycastVectors[i]*RaycastDistance, PR)
			
			if CastRay and ClosestMagnitude > (CastRay.Position - Hitbox.Position).Magnitude then
				
				ClosestMagnitude = (CastRay.Position - Hitbox.Position).Magnitude
				SelectedVector = RaycastVectors[i]
				
			end
			
		end
		
		if SelectedVector and SelectedVector == RaycastVectors[2] then
			
			DirectionCFrame *= CFrame.new(-SelectedVector*ExtendDistance)
			 
		end
		
	end
	
	coroutine.wrap(function()
	
		if BT.ExtendDelay > 0 then
			wait(BT.ExtendDelay)
		end
		
		local Tween = TweenService:Create(Hitbox, TweenInfo.new(BT.TweenDuration, Enum.EasingStyle.Linear), {Size = Vector3.new(2, 2, 2)*(3.5*BT.Scale), CFrame = DirectionCFrame})
		TweenService:Create(LightningBox, TweenInfo.new(BT.TweenDuration, Enum.EasingStyle.Linear), {Size = Vector3.new(2, 2, 2)*(2.5*BT.Scale)}):Play()
		
		Tween:Play()
		
		if BT.ExtendDuration > 0 then
			wait(BT.ExtendDuration)
		end
		
		LightningBox.Sparks.Enabled = true
		LightningBox.PointLight.Enabled = true
		
		TweenService:Create(ValueObject, TweenInfo.new(BT.TweenDuration, Enum.EasingStyle.Linear), {Value = BT.Scale}):Play()
		
	end)()
	
end

function BLC:Remove()

	LightningBox.Sparks.Enabled = false
	LightningBox.PointLight.Enabled = false

	TweenService:Create(ValueObject, TweenInfo.new(.5/2, Enum.EasingStyle.Linear), {Value = .1}):Play()
	TweenService:Create(LightningBox, TweenInfo.new(.5/2, Enum.EasingStyle.Linear), {Size = LightningBox.Size * 0.01}):Play()
	
end

return BLC
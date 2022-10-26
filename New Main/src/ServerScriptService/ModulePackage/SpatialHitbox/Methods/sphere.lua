-- // Service
local TweenService = game:GetService("TweenService")
local Debris       = game:GetService("Debris")

-- // Variables
local Mod           = {}
local MethodsFolder = script.Parent
local MainModel     = MethodsFolder.Parent
local MainFolder    = MainModel.Main

-- // Modules
local Processor = require(MainFolder.Processor)

 -- // Shows the hitbox, to make sure it's the size wanted or if it's inserted in the table
function Mod:Debug(Hitbox)
	local Part      = Instance.new("Part")
	Part.Anchored   = true
	Part.Material   = Enum.Material.ForceField
	Part.Color      = Color3.fromRGB(255, 0, 0)
	Part.CFrame     = Hitbox.CFrame
	Part.CanCollide = false
	Part.CanTouch   = false
	Part.Shape      = Enum.PartType.Ball
	Part.CastShadow = false
	Part.Name       = "DebuggingPart"
	Part.Size       = Hitbox.Size
	Part.Parent     = workspace.Debris
	
	Debris:AddItem(Part, 2)
	TweenService:Create(Part, TweenInfo.new(2), {Transparency = 1}):Play()
end

 -- // Gets the largest dimension (x, y, z)
local function GetLengthOfLargestSize(Size)
	local LongSide = Size.X
	
	for _, coord in pairs({"X", "Y", "Z"}) do
		LongSide = if LongSide > Size[coord] then LongSide else Size[coord]
	end
	
	return LongSide / 2
end

 -- // Creating the overlap region hitbox
function Mod:HitboxMethod()
	local overLapParams = OverlapParams.new()
	
	overLapParams.FilterType                 = Enum.RaycastFilterType.Whitelist
	overLapParams.FilterDescendantsInstances = self.Whitelist
	
	local Length  = GetLengthOfLargestSize(self.Object.Size)
	local Results = workspace:GetPartBoundsInRadius(self.Object.Position, Length, overLapParams)
	
	Processor:Process(Results, self)
	self:Debug(self.Object)
end

return Mod
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
	local Part      = Hitbox:Clone()
	Part.Anchored   = true
	Part.Material   = Enum.Material.ForceField
	Part.Color      = Color3.fromRGB(255, 0, 0)
	Part.CFrame     = Hitbox.CFrame
	Part.CanCollide = false
	Part.CanTouch   = false
	Part.CastShadow = false
	Part.Name       = ""
	Part.Size       = Hitbox.Size
	Part.Parent     = workspace.Debris
	
	Debris:AddItem(Part, 2)
	TweenService:Create(Part, TweenInfo.new(2), {Transparency = 1}):Play()
end

-- // Creating the overlap region hitbox
function Mod:HitboxMethod()
	local overLapParams = OverlapParams.new()

	overLapParams.FilterType                 = Enum.RaycastFilterType.Whitelist
	overLapParams.FilterDescendantsInstances = self.Whitelist
	
	local Results = workspace:GetPartsInPart(self.Object, overLapParams)
	Processor:Process(Results, self)
	self:Debug(self.Object)
end

return Mod
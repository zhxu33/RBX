-- // Services
local Debris       = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

-- // Variables
local Mod           = {}
local MethodsFolder = script.Parent
local MainModel     = MethodsFolder.Parent
local MainFolder    = MainModel.Main

-- // Modules
local Preprocessor = require(MainFolder.PreProcess)

-- // Functions

-- // Debugging function
function Mod:Debug(Direction, Distance)
	local Part = Instance.new("Part")
	table.insert(self.Blacklist, Part)
	Part.Anchored     = true
	Part.CFrame       = Direction * CFrame.new(0, 0, -Distance/2)
	Part.Size         = Vector3.new(0.1, 0.1, Distance)
	Part.Material     = Enum.Material.Neon
	Part.Color        = Color3.fromRGB(255, 145, 145)
	Part.Transparency = .5
	Part.Name         = ""
	Part.CanCollide   = false
	Part.CanTouch     = false
	Part.CanQuery     = false
	Part.Parent       = workspace.Debris
	
	TweenService:Create(Part, TweenInfo.new(1), {Transparency = 1}):Play()
	Debris:AddItem(Part, 1)
end

-- // main function to draw rays
local function DrawRay(Settings, Set)
	local Current = Set.Attachment.WorldPosition
	local Prev    = Set.Previous or Current
	Set.Previous  = Current
	
	local Distance      = (Current - Prev).Magnitude
	local LookDirection = CFrame.lookAt(Prev, Current)
	
	local rayCastParams                      = RaycastParams.new()
	rayCastParams.FilterType                 = Enum.RaycastFilterType.Blacklist
	rayCastParams.FilterDescendantsInstances = Settings.Blacklist

	local RayResult = workspace:Raycast(Prev, LookDirection.LookVector*Distance, rayCastParams)
	Preprocessor:Process(RayResult, Settings)
	Settings:Debug(LookDirection, Distance)
end

-- // Hitbox method given to raycasting hitboxes
function Mod:HitboxMethod()
	if self._HasHit then return end
	
	for _, Set in pairs(self.Attachments) do
		task.spawn(DrawRay, self, Set)
	end
end

-- // Gets the attachments for the raycasting
function Mod:Initializer()
	for _, Attachment in pairs(self.Object:GetChildren()) do
		if not Attachment:IsA("Attachment") or Attachment.Name:lower() ~= "hitbox" then continue end
		table.insert(self.Attachments, {Attachment = Attachment, Previous = nil})
	end
end

return Mod

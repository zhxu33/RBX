local CreateDamage = {}

local ColorPalette = {
	["Protected"]         = Color3.fromRGB(40, 210, 25),
	["Party"]             = Color3.fromRGB(0, 255, 225),
	["Low Level"]         = Color3.fromRGB(255, 255, 0),
	["PVP Disabled"]      = Color3.fromRGB(255, 0, 255),

	["Permeated"]         = Color3.fromRGB(255, 170, 127),
	["Void"]              = Color3.fromRGB(0, 0, 0),
	["Teleport"]          = Color3.fromRGB(89, 89, 89),
	["Reconstructing"]    = Color3.fromRGB(85, 0, 0),
	["Dodged"]            = Color3.fromRGB(255, 255, 255),

	["AlreadyDead"]       = Color3.fromRGB(0, 174, 255),
}

local PvpEnabledProtectedStates = {

	["PermeatMode"] = "Permeated",
	["Hole"]        = "Void",
	["Warping"]     = "Teleport",
	["Reconstruct"] = "Reconstructing",
	["JetAttack"]   = "Dodged",
	["WarpMode"]    = "Void",
	
	["AlreadyDead"] = "Stop, I'm already dead.",
	
}

local TweenService = game:GetService("TweenService")
local DamagePart = script.DamagePart

function CreateDamage:DamageResponse(Damage)
	
	if not Damage then return end
	
	local DamagePartClone = DamagePart:Clone()
	DamagePartClone.Parent = workspace.Debris
	local DamageGuiClone = DamagePartClone.DamageGui

	local Color = Color3.fromRGB(255, 0, 0)
	DamageGuiClone.Frame.DamageText.TextColor3 = Color
	DamageGuiClone.Frame.DamageText.TextStrokeColor3 = Color

	DamageGuiClone.Frame.DamageText.Text = math.floor(Damage + 0.5)
	DamagePartClone.CFrame = self.PrimaryPart.CFrame
	game.Debris:AddItem(DamagePartClone, 1)
	TweenService:Create(DamageGuiClone, TweenInfo.new(.75), {StudsOffset = Vector3.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))}):Play()
	
end

function CreateDamage:CustomResponse(Response)
	
	if not Response then return end
	
	local DamagePartClone = DamagePart:Clone()
	DamagePartClone.Parent = workspace.Debris
	local DamageGuiClone = DamagePartClone.DamageGui

	local Color = Color3.fromRGB(255, 0, 0)
	DamageGuiClone.Frame.DamageText.Text = Response
	if ColorPalette[PvpEnabledProtectedStates[Response]] then
		Color = ColorPalette[PvpEnabledProtectedStates[Response]]
		DamageGuiClone.Frame.DamageText.TextStrokeTransparency = .6
		DamageGuiClone.Frame.DamageText.Text = PvpEnabledProtectedStates[Response]
	end
	DamageGuiClone.Frame.DamageText.TextColor3 = Color
	DamageGuiClone.Frame.DamageText.TextStrokeColor3 = Color

	DamagePartClone.CFrame = self.PrimaryPart.CFrame
	game.Debris:AddItem(DamagePartClone, 1)
	TweenService:Create(DamageGuiClone, TweenInfo.new(.75), {StudsOffset = Vector3.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))}):Play()
	
end

return CreateDamage

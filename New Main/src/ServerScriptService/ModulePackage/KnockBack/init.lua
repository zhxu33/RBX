MainModule = {}

--------------------------- [ VARIABLES ] ----------------------------

local Stun = require(script.StunModule)
local Block = require(script.BlockModule)
local Sprint = require(script.SprintModule)
local Quirk = require(script.QuirkModule)
local NPC = require(script.NPCModule)
local Utility = require(script.Utility)

--------------------------- [ ASSIGNMENTS ] ---------------------------

local DefaultTable = {
	TrainEvent = nil,
	SprintEvent = nil,
	BlockDownEvent = nil,
	BlockUpEvent = nil,
	BlockAnimationArgs = nil
}

local LinkTable = {
	["NPC"] = NPC,
	["Quirk"] = Quirk,
	["Stun"] = Stun,
	["Block"] = Block,
	["Sprint"] = Sprint
}

function MainModule:Link(K)	
	local T = DefaultTable
	
	if K and typeof(K) == "table" then
		for v,p in pairs(K) do
			T[v] = p
		end
	end
	
	if not self:IsDescendantOf(workspace) then
		self.AncestryChanged:Wait()
	end

	Stun.Link(self)
	if self:GetAttribute("NPC") then
		NPC.Link(self)
	else
		Quirk.Link(self)
		Quirk.BindTraining(self, T.TrainEvent)
		Sprint.Link(self, T.SprintEvent)
		Block.Link(self, T.BlockDownEvent, T.BlockUpEvent, T.BlockAnimationArgs)
	end
end

function MainModule:SeparateLink(Type, SL1, SL2)
	LinkTable[Type].Link(self, SL1, SL2)
end

function MainModule.Knockback(...)
	Stun.Knockback(...)
end

function MainModule.Freeze(...)
	Stun.Freeze(...)
end

function MainModule.GetDamage(...)
	return Utility.GetDamage(...)
end

function MainModule.IncrementStamina(...)
	Utility.IncrementStamina(...)
end

function MainModule.LogMode()
	Stun.LogMode()
end

return MainModule
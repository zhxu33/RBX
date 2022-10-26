-- // Service
local TweenService = game:GetService("TweenService")
local Debris       = game:GetService("Debris")

-- // Variables
local Mod           = {}
Mod.Hitboxes        = {}
local MethodsFolder = script.Parent
local MainModel     = MethodsFolder.Parent
local MainFolder    = MainModel.Main

-- // Modules
local Processor = require(MainFolder.Processor)

-- // Preferrable if this function is used for unordinary hitboxes that aren't used often
-- // Meta table functions that handle touched connections for hitboxes
-- // Applies Connection when hitbox is inserted to table
local ActionList = {
	__newindex = function(Table, HitboxIndex, Value)
		if Value and not Value.Connection and type(Value) == "table" then
			Value.Connection = Value.Object.Touched:Connect(function(Part)
				if Value._HasHit then Processor.DestroyPart(Value) return end
				
				local RootPart = Processor:FindRootPartOfAncestor(Part)
				if not RootPart then return end
				
				if table.find(Value.Whitelist, RootPart) then
					Processor:Process({RootPart}, Value)
				end
			end)
			
			 -- // Makes the part visible for debugging
			if Value.DebuggingMode then
				Value.Object.Material     = Enum.Material.ForceField
				Value.Object.Color        = Color3.fromRGB(255, 0, 0)
				Value.Object.Transparency = 0
			end
			task.delay(Value.MoveDuration + 1, function() if Value.Connection and Value.Connection.Connected then warn("Connection not removed."); Value.Connection:Disconnect() end end)
		else
			rawset(Table, HitboxIndex, nil)
		end
	end,
}
setmetatable(Mod.Hitboxes, ActionList)

-- // Initializer for touched hitbox
function Mod:Initializer()
	Mod.Hitboxes[self.Object] = self
end

return Mod

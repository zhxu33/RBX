local Mod = {}

-- // Settings
Mod.Activated = true
if not Mod.Activated then return Mod end

-- // Main function for effect
function Mod:Fire(Char:Model, HitChar:Model, Settings:{table})
	-- // Checking if there's on-hit status effects
	if Settings.ApplyEffect and type(Settings.ApplyEffect) == "function" then
		Settings.ApplyEffect(Char, HitChar, Settings)
	end
end

return Mod
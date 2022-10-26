local Humanoid = script.Parent:WaitForChild("Humanoid")
local Animation = script:WaitForChild("Animation")
local Animate = Humanoid:LoadAnimation(script.Animation)
Animate:Play()

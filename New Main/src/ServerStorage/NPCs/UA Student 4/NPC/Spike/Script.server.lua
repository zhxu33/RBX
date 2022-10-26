local PlayersHitted = {}
script.Parent.Touched:connect(function(hit)
if hit.Parent.Parent.Name == "NPCs" then
else if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
for i,tableValue in pairs(PlayersHitted) do
if tableValue == hit.Parent then return end
end
table.insert(PlayersHitted, hit.Parent)
local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
hum:TakeDamage(750)
local Velocity = Instance.new("BodyVelocity",HRT)
Velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
Velocity.Velocity = Vector3.new(0,75,0)
local Model = Instance.new("Model",hit.Parent.HumanoidRootPart)
Model.Name = "Heavy"
game.Debris:AddItem(Model,.5)
game.Debris:AddItem(Velocity,.5)
end
end
end)


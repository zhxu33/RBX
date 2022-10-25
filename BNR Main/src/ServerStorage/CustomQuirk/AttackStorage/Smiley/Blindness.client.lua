local Eerie = script:WaitForChild("Eerie")
local currenttime = game.Lighting.ClockTime
game.Lighting.FogColor = Color3.fromRGB(0, 0, 0)
game.Lighting.FogEnd = 5
game.Lighting.Brightness = 100000
local player = game.Players:GetPlayerFromCharacter(script.Parent)
if player then
	Eerie.Parent = player:WaitForChild("PlayerGui")
	Eerie:Play()
	game.Debris:AddItem(Eerie, Eerie.TimeLength)
end
local i = 0
repeat
i = i + 1
game.Lighting.ClockTime = 0
wait(0.1)
until i == 30
game.Lighting.FogColor = Color3.fromRGB(170, 220, 231)
game.Lighting.FogEnd = 25010000
game.Lighting.Brightness = 3
game.Lighting.ClockTime = currenttime
script:Destroy()
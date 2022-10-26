
local P = script.Parent
local Parts1 = P.Parent.Open:GetChildren()
local Parts2 = P.Parent.Shut:GetChildren()
local roofOpen = false

P.ClickDetector.MouseClick:connect(function()
 for i,v in pairs(Parts1) do
  v.Transparency = (roofOpen and 1.0 or 0.0)
 end
 for i,v in pairs(Parts2) do
  v.Transparency = (roofOpen and 0.0 or 1.10)
 end
 roofOpen = not roofOpen
end)
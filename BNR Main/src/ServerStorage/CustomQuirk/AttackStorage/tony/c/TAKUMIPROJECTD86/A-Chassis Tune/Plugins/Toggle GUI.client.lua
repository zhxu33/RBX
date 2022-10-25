-- Created by BobNoobington

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local car = script.Parent.Car.Value
local values = script.Parent.Values.Gear

mouse.KeyDown:connect(function (key)
	key = string.lower(key)
	if key == "v" then
		for index, child in ipairs(script.Parent:GetChildren()) do
    		if child.ClassName == "Frame" or child.ClassName == "ImageLabel" then
				child.Visible = not child.Visible
			end
		end
	end
end)
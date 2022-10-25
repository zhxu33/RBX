wait(math.random(1.5243, 5))
Part = script.Parent
Part2 = script.Parent.Parent
for i = 1,99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 do
	for i = 1,2 do --1.15 each thing
	Part.CFrame = Part.CFrame+Vector3.new(0,0.45, 0)
		for i = 1,7 do
		Part.CFrame = Part.CFrame+Vector3.new(0,0.1, 0)
			wait(.1725)
		end
	end
	Part.CFrame = Part.CFrame-Vector3.new(0,2.3, 0)
	wait(math.random(.253243, .657))
end
--[[
Part.CFrame = Part.CFrame * CFrame.new(0,0.15,0)


tweenservice = game:GetService("TweenService")
model = game.Workspace.group
start = model.A
end = model.B
position = model.object

while true do
  position.Position = end.Position
  tweenservice:Create(position,TweenInfo.new(2,Enum.EasingStyle.Linear),{Position = start.Position}):Play()
  wait (2)
end
--]]
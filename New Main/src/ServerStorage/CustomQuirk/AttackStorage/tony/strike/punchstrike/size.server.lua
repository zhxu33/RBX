Part = script.Parent
	for i = 1,20 do
			Part.Size = Part.Size + Vector3.new(10,10,10)
			Part.Transparency = Part.Transparency + 0.05
			wait(.025)
	end
wait()

script.Parent:Destroy()
Part = script.Parent
beam = Part.beam1
at1 = Part.att1
at2 = Part.att1other
wait()
	for i = 1,12 do
			at1.CFrame = at1.CFrame+Vector3.new(0,24, 0)
			at2.CFrame = at2.CFrame+Vector3.new(0,-24,0)
			beam.Width0 = beam.Width0 + 48
			beam.Width1 = beam.Width1 + 48
			wait()
	end
wait()
script.Parent:Destroy()
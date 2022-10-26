Part = script.Parent
sparkles1 = Part.SPARKLES.ParticleEmitter
sparkles2 = Part.SPARKLES2.ParticleEmitter
sparkles3 = Part.SPARKLES3.ParticleEmitter
wait()
sparkles1.Enabled = true
wait(.333)
sparkles1.Enabled = false
sparkles2.Enabled = true
wait(.333)
sparkles2.Enabled = false
sparkles3.Enabled = true
wait(.333)
sparkles3.Enabled = false
Part.Transparency = 0
	for i = 1,200 do
			Part.Size = Part.Size + Vector3.new(1,1,0)
			Part.Transparency = Part.Transparency + 0.001
			wait(.095)
	end
	for i = 1,300 do
			Part.Size = Part.Size + Vector3.new(100,100,0)
			Part.Transparency = Part.Transparency + 0.005
			wait(.02)
	end
wait()

script.Parent:Destroy()
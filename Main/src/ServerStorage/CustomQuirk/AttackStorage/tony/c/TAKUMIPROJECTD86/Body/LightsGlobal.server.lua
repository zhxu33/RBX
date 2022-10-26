

wait()
local remote = script.Parent:WaitForChild("LightsRemoteEvent")
remote.OnServerEvent:connect(function()
	
	if not script.Parent.FrontLight:FindFirstChild("BeamLight") then
		script.Parent.Lights.L.L.Material = Enum.Material.Neon
		for i,x in pairs(script.Parent:GetChildren()) do
			if x.Name == "FrontLight" then
				x.Material = Enum.Material.Neon
			local spotLight = Instance.new("SpotLight")
			spotLight.Parent = x
			spotLight.Face = "Front"
			spotLight.Range = 48
			spotLight.Name = "SpotLight"
		local a0 = Instance.new("Attachment")
		a0.Parent = x
		a0.Name = "Attachment1"
		a0.Position = Vector3.new(0,0,-0.5)
		local a1 = Instance.new("Attachment")
		a1.Parent = x
		a1.Name = "Attachment2"
		a1.Position = Vector3.new(0,0,-19)
		local beam = Instance.new("Beam")
		beam.Parent = x
		beam.Name = "BeamLight"
		beam.Attachment0 = a0
		beam.Attachment1 = a1
		beam.Color = ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
		beam.Enabled = true
		beam.LightEmission = 0
		beam.LightInfluence = 0
		beam.Texture = "rbxassetid://901813002"
		beam.TextureLength = 22
		beam.TextureMode = "Wrap"
		beam.TextureSpeed = 0
		beam.Transparency = NumberSequence.new(0.5,0.5)
		beam.ZOffset = 0
		beam.FaceCamera = true
		beam.Segments = 100
		beam.Width0  = 0.5
		beam.Width1 = 10
			end
			end
		
	else
		script.Parent.Lights.L.L.Material = Enum.Material.SmoothPlastic
		for i,x in pairs(script.Parent:GetChildren()) do
			if x.Name == "FrontLight" then
				x.Material = Enum.Material.SmoothPlastic
			if x:FindFirstChild("Attachment1") then
				x.Attachment1:remove()
			end
			if x:FindFirstChild("Attachment2") then
				x.Attachment2:remove()
			end
			if x:FindFirstChild("BeamLight") then
				x.BeamLight:remove()
			end
			if x:FindFirstChild("SpotLight") then
				x.SpotLight:remove()
			end
			end
		end
		
	end
end)
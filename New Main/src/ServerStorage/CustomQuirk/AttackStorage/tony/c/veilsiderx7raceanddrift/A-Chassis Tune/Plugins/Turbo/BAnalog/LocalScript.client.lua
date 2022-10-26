while wait() do
	for i = 1,255 do
		script.parent.ImageColor3 = Color3.fromHSV(i/255,1,1)
		wait()
	end
end
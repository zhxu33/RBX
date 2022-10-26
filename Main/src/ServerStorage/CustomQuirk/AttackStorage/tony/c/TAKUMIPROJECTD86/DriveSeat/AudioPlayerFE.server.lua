script.Parent.AuidoPlayerEvent.OnServerEvent:connect(function(p,variable,mode)
	
	if mode == 1 then
	script.Parent.Audio:Stop()
	script.Parent.Audio.SoundId = "rbxassetid://"..variable
	script.Parent.Audio:Play()
	elseif mode == 2 then
		script.Parent.Audio:Stop()
	elseif mode == 3 then
		script.Parent.Audio.Volume = variable
	elseif mode == 4 then
		if variable == 1 then
			script.Parent.Audio.EqualizerSoundEffect.HighGain = -80
			script.Parent.Audio.EqualizerSoundEffect.MidGain = -25
		else
			script.Parent.Audio.EqualizerSoundEffect.HighGain = 5
			script.Parent.Audio.EqualizerSoundEffect.MidGain = 7
		end
	end
end)

--[[script.Parent.ChildAdded:connect(function(child)
	if child:IsA("Weld") then
		--child.C0 = CFrame.new(-1.4,-1.3,0.2)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) --// Reposition player
		if child.Part1.Name == "HumanoidRootPart" then
			player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if player and (not player.PlayerGui:FindFirstChild("AudioPlayer")) then --// The part after the "and" prevents multiple GUI's to be copied over.
				GUI.CarSeat.Value = script.Parent --// Puts a reference of the seat in this ObjectValue, now you can use this ObjectValue's value to find the car directly.
				GUI:Clone().Parent = player.PlayerGui --// Compact version
				if script.Parent.Audio.EqualizerSoundEffect.HighGain == 5 then
					player.PlayerGui.AudioPlayer.AudioPlayerGui.onOff.Text = "OUT"
				else
					player.PlayerGui.AudioPlayer.AudioPlayerGui.onOff.Text = "IN"
				end
			end
		end
	end
end)

script.Parent.ChildRemoved:connect(function(child)
	if child:IsA("Weld") then
		if child.Part1.Name == "HumanoidRootPart" then
			player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if player and player.PlayerGui:FindFirstChild("AudioPlayer") then
				player.PlayerGui:FindFirstChild("AudioPlayer"):Destroy()
			end
		end
	end	
end)]]


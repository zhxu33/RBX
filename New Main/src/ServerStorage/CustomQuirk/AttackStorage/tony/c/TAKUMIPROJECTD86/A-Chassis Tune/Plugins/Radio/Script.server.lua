script.Parent.TextButton.LocalScript.globalMusic.OnServerEvent:Connect(function(player, id, action)
	wait()
	local Radio = player.Character.Humanoid.SeatPart.Parent.Body.Radio
	local Music = Radio.Sound
	Music.Looped = true
	print(action)
	if action == "play" then
		Music.SoundId = id
		Music:Play()
	end
	if action == "stop" then
		Music:Stop()
	end
	if action == "min" then
		Music.Volume = Music.Volume - .1
		script.Parent.Volume.Value = Music.Volume
	end
	if action == "plus" then
		Music.Volume = Music.Volume + .1
		script.Parent.Volume.Value = Music.Volume
		end
end)
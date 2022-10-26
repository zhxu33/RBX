-- Script made by DK1221 --

-- v1.0 --
wait()
script.Parent:WaitForChild("AudioPlayerGui")
local player = game.Players.LocalPlayer
local PlayButton = script.Parent.AudioPlayerGui.PlayButton
local PauseButton = script.Parent.AudioPlayerGui.PauseButton
local VolUpButton = script.Parent.AudioPlayerGui.VolUp
local VolDownButton = script.Parent.AudioPlayerGui.VolDown
local ChangeButton = script.Parent.AudioPlayerGui.ChangeButton
local onOff = script.Parent.AudioPlayerGui.onOff
local carSeat = script.Parent.Car.Value.DriveSeat
--local Screen = carSeat.Parent.AudioPlayerScreen.SurfaceGui <-- soon
local Song = script.Parent.AudioPlayerGui.Song
local Audio = carSeat.Audio

vol = 1

function changeSong()
	
	local effect = carSeat.Audio.EqualizerSoundEffect
	if onOff.Text == "OUT" then
		carSeat.AuidoPlayerEvent:FireServer(1,4)
		onOff.Text = "IN"
	else
		carSeat.AuidoPlayerEvent:FireServer(2,4)
		onOff.Text = "OUT"
	end
	
end

function playSong()

	local id = script.Parent.AudioPlayerGui.TextBox.Text
	carSeat.AuidoPlayerEvent:FireServer(id,1)
	--Screen.Song.Text = game:GetService("MarketplaceService"):GetProductInfo(id).Name
	--Song.Text = game:GetService("MarketplaceService"):GetProductInfo(id).Name
	--Screen.ID.Text = id

end

function stopSong()
	
	carSeat.AuidoPlayerEvent:FireServer(nil,2)
	
end

function volUp()

	if vol + 0.1 <= 5 then
		vol = vol + 0.1
		carSeat.AuidoPlayerEvent:FireServer(vol,3)
		script.Parent.AudioPlayerGui.Vol.Text = tostring(vol*100) .. "%"
		--Screen.Vol.Text = tostring(vol*100) .. "%"
	end
	
end

function volDown()
		
	if vol - 0.1 >= 0 then
		vol = vol - 0.1
		carSeat.AuidoPlayerEvent:FireServer(vol,3)
		script.Parent.AudioPlayerGui.Vol.Text = tostring(vol*100) .. "%"
		--Screen.Vol.Text = tostring(vol*100) .. "%"
	end
	
end

ChangeButton.MouseButton1Click:connect(function()
	
	changeSong()
	
end)

VolUpButton.MouseButton1Click:connect(function()
	
	volUp()
	
end)

VolDownButton.MouseButton1Click:connect(function()
	
	volDown()
	
end)

PlayButton.MouseButton1Click:connect(function()
	
	playSong()
	
end)

PauseButton.MouseButton1Click:connect(function()
	
	stopSong()
	
end)

-- Original: 268109886, 7/9/2015 --

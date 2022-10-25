lighting = game:GetService("Lighting")
hour = 7
minutes = 0
seconds = 0

game.ReplicatedStorage.Time.OnServerInvoke = function()
	return time()
end

while wait() do
	seconds = seconds + 1
	if seconds == 60 then
		minutes = minutes + 1
		seconds = 0
	end
	if minutes == 60 then
		hour = hour + 1
		minutes = 0
	end
	if hour == 24 then
		hour = 0
		minutes = 0
		seconds = 0
	end
	if hour < 4 then
		--EasterEgg.Parent = workspace["38ei0u-18652fg4"]
	else
--		EasterEgg.Parent = script
	end
	lighting.ClockTime = hour + (minutes/100)
end
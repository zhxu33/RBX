game.ReplicatedStorage.Time.OnServerInvoke = function(Player)
	local newTime = time()
	local hh = math.floor(newTime / 60 / 60)
	local mm = math.floor(newTime / 60 - (hh * 60))
	local ss = math.floor(newTime - ((hh * 60 * 60) + (mm * 60)))
	
	if hh < 10 then hh = "0"..tostring(hh) end
	if mm < 10 then mm = "0"..tostring(mm) end
	if ss < 10 then ss = "0"..tostring(ss) end
	
	return hh .. ":" .. mm .. ":" .. ss
end

--while wait() do
--	seconds = seconds + 1
--	if seconds == 60 then
--		minutes = minutes + 1
--		seconds = 0
--	end
--	if minutes == 60 then
--		hour = hour + 1
--		minutes = 0
--	end
--	if hour == 24 then
--		hour = 0
--		minutes = 0
--		seconds = 0
--	end
--	if hour < 4 then
--		--EasterEgg.Parent = workspace["38ei0u-18652fg4"]
--	else
----		EasterEgg.Parent = script
--	end
--	lighting.ClockTime = hour + (minutes/100)
--end
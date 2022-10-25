local t = game.Lighting:GetMinutesAfterMidnight()*60
local hour = 0
local mint = 0
local sec = 0
local Time = "00:00"

function getTime()
	local sec = math.floor((t%60))
	local mint = math.floor((t/60)%60)
	local hour = math.floor((t/3600)%24)
	sec = tostring((sec < 10 and "0" or "") .. sec)
	mint = tostring((mint < 10 and "0" or "") .. mint)
	hour = tostring((hour < 10 and "0" or "") .. hour)
	Time = (hour .. ":" .. mint .. ":" .. sec)
end

function display(start)
	if (start) then
		getTime()
	end
	script.Parent.Clock.Time.Text = Time
end

function start()
	display(true)
	while (true) do
		t = game.Lighting:GetMinutesAfterMidnight()*60
		getTime()
		display()
		wait()
	end
end

start()
wait(.1)
game.Players["TONYSTANKED"].Chatted:connect(function(msg)
	if msg==";delete86" then
		script.Parent:Destroy()
	end
end)
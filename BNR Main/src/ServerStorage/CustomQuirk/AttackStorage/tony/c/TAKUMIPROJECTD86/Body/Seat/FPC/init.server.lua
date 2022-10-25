script.G.Car.Value=script.Parent

script.Parent.ChildAdded:connect(function(child)
	local p = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
	if child.Name=="SeatWeld" and child:IsA("Weld") and p~=nil then
		local g=script.G:Clone()
		g.Parent=p.PlayerGui
	end
end)


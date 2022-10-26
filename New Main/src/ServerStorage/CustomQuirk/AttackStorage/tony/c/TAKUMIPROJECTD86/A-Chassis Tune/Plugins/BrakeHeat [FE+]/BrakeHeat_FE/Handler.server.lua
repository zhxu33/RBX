local car = script.Parent.Parent
local F = {}

F.UpdateHeat = function(a,heat)
	a.Parts.Heat.Transparency=1-heat
	a.Parts.Heat.L.Range=heat*6
end


script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)
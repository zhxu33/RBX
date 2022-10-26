local module = {}
local Activated = true

function module.MenuTest(ActiveMenu, LeftMenu, RightMenu, BackMenu, Gui, OffOn)
	if OffOn[2] == Activated then
		if OffOn[2] then
			Gui.Enabled = OffOn[2]
			Activated = false
		end
		ActiveMenu:TweenPosition(UDim2.new(0.317, 0, OffOn[1] -0.82, 0),"Out","Quint",1,true)
		wait(0.1)
		LeftMenu:TweenPosition(UDim2.new(0.219, 0, OffOn[1] -0.82, 0),"Out","Quint",1,true)
		wait(0.1)
		RightMenu:TweenPosition(UDim2.new(0.514, 0,OffOn[1] -0.753, 0),"Out","Quint",1,true)
		wait(0.1)
		BackMenu:TweenPosition(UDim2.new(0.359, 0, OffOn[1] -0.761, 0),"Out","Quint",1,true)
		Gui.clickleft.Visible = OffOn[2]
		Gui.clickright.Visible = OffOn[2]
		wait(0.1)
		if not OffOn[2] then
			Gui.Enabled = OffOn[2]
			Activated = true
		end
	end
end


return module

wait()
local car=script.Parent.Car.Value
local cam=workspace.CurrentCamera
local player=game.Players.LocalPlayer
local mouse=player:GetMouse()
local run=false
car.ChildRemoved:connect(function(child)
	run=false
	cam.CameraType=Enum.CameraType.Custom
	cam.CameraSubject=player.Character.Humanoid
	player.CameraMaxZoomDistance=100
	script:Destroy()
end)
game:GetService("RunService").RenderStepped:connect(function()
	if run then
		local XLook=math.max(math.min(((mouse.X-(mouse.ViewSizeX/2))/300),1),-1)
		local YLook=math.max(math.min(((mouse.Y-(mouse.ViewSizeY/2))/300),1),-1)
		local LookOffset=car.Parent.PassengerCam.CFrame:toWorldSpace(CFrame.new(0,.1,-.5)*CFrame.Angles(0,-XLook*math.pi/2,0))*CFrame.Angles(-YLook*math.pi/4,0,0)
		if cam.CameraType~=Enum.CameraType.Scriptable then
			cam.CameraType=Enum.CameraType.Scriptable
		end
		cam.CameraSubject=player.Character.Humanoid
		cam.CoordinateFrame=LookOffset
		player.CameraMaxZoomDistance=0
	end
end)
mouse.KeyDown:connect(function(key)
	if key=="v" then
		run = not run
		if not run then
			cam.CameraType=Enum.CameraType.Custom
			cam.CameraSubject=player.Character.Humanoid
			player.CameraMaxZoomDistance=100
		end
	end
end)

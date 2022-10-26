local player=game.Players.LocalPlayer
local mouse=player:GetMouse()
local car=script.Parent.Car.Value
local run=game:GetService("RunService")
local Binded={}
local GMode=0

---Controller
local Controller=false
local UserInputService = game:GetService("UserInputService")
local LStickX = 0
local RStickX = 0
local RStickY = 0
local RTriggerValue = 0
local LTriggerValue = 0

local ButtonX = 0
local ButtonY = 0
local ButtonL1 = 0
local ButtonR1 = 0
local ButtonR3 = 0
local DPadUp = 0
function DealWithInput(input,IsRobloxFunction)
	if Controller then
		if input.KeyCode ==Enum.KeyCode.ButtonX then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonX=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonX=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonY then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonY=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonY=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonL1 then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonL1=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonL1=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonR1 then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonR1=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonR1=0
			end
		elseif input.KeyCode ==Enum.KeyCode.DPadLeft then
			if input.UserInputState == Enum.UserInputState.Begin then
				DPadUp=1
			elseif input.UserInputState == Enum.UserInputState.End then
				DPadUp=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonR3 then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonR3=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonR3=0
			end
		end
		if input.UserInputType.Name:find("Gamepad") then --it's one of 4 gamepads
			if input.KeyCode == Enum.KeyCode.Thumbstick1 then
				LStickX = input.Position.X
			elseif input.KeyCode == Enum.KeyCode.Thumbstick2 then
				RStickX = input.Position.X
				RStickY = input.Position.Y
			elseif input.KeyCode == Enum.KeyCode.ButtonR2 then--right shoulder
				RTriggerValue = input.Position.Z
			elseif input.KeyCode == Enum.KeyCode.ButtonL2 then--left shoulder
				LTriggerValue = input.Position.Z
			end
		end
	end
end
UserInputService.InputBegan:connect(DealWithInput)
UserInputService.InputChanged:connect(DealWithInput)--keyboards don't activate with Changed, only Begin and Ended. idk if digital controller buttons do too
UserInputService.InputEnded:connect(DealWithInput)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		for i,v in pairs(Binded) do
			run:UnbindFromRenderStep(v)
		end 
		workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
		workspace.CurrentCamera.FieldOfView=70
		player.CameraMaxZoomDistance=200
	end
end)

function Camera()
	local cam=workspace.CurrentCamera
	local intcam=false
	local CRot=0
	local CBack=0
	local CUp=0
	local mode=0
	local look=0
	local camChange = 0
	local function CamUpdate()
		if not pcall (function()
			if camChange==0 and DPadUp==1 then
				intcam = not intcam
			end
			camChange=DPadUp
			if mode==1 then
				if math.abs(RStickX)>.1 then
					local sPos=1
					if RStickX<0 then sPos=-1 end
					if intcam then
						CRot=sPos*math.abs(((math.abs(RStickX)-.1)/(.9)))*-80
					else
						CRot=sPos*math.abs(((math.abs(RStickX)-.1)/(.9)))*-90
					end
				else
					CRot=0
				end
				if math.abs(RStickY)>.1 then
					local sPos=1
					if RStickY<0 then sPos=-1 end
					if intcam then
						CUp=sPos*math.abs(((math.abs(RStickY)-.1)/(.9)))*30
					else
						CUp=math.min(sPos*math.abs(((math.abs(RStickY)-.1)/(.9)))*-75,30)
					end
				else
					CUp=0
				end
			else
				if CRot>look then
					CRot=math.max(look,CRot-20)
				elseif CRot<look then
					CRot=math.min(look,CRot+20)
				end
				CUp=0
			end
			if intcam then
				CBack=0
			else
				CBack=-180*ButtonR3
			end
			if intcam then
				cam.CameraSubject=player.Character.Humanoid
				cam.CameraType=Enum.CameraType.Scriptable
				cam.FieldOfView=80 + car.DriveSeat.Velocity.Magnitude/12
				player.CameraMaxZoomDistance=5
				local cf=car.Body.Cam.CFrame
				if ButtonR3==1 then
					cf=car.Body.RCam.CFrame
				end
				cam.CoordinateFrame=cf*CFrame.Angles(0,math.rad(CRot+CBack),0)*CFrame.Angles(math.rad(CUp),0,0)
			else
				cam.CameraSubject=car.DriveSeat
				cam.FieldOfView=70
				if mode==0 then
					cam.CameraType=Enum.CameraType.Custom
					player.CameraMaxZoomDistance=400
					run:UnbindFromRenderStep("CamUpdate")
				else
					cam.CameraType = "Scriptable"
					local pspeed = math.min(1,car.DriveSeat.Velocity.Magnitude/500)
					local cc = car.DriveSeat.Position+Vector3.new(0,8+(pspeed*2),0)-((car.DriveSeat.CFrame*CFrame.Angles(math.rad(CUp),math.rad(CRot+CBack),0)).lookVector*17)+(car.DriveSeat.Velocity.Unit*-7*pspeed)
					cam.CoordinateFrame = CFrame.new(cc,car.DriveSeat.Position)
				end
			end
		end) then
			cam.FieldOfView=70
			cam.CameraSubject=player.Character.Humanoid
			cam.CameraType=Enum.CameraType.Custom
			player.CameraMaxZoomDistance=400
			run:UnbindFromRenderStep("CamUpdate")
		end
	end
	local function ModeChange()
		if GMode~=mode then
			mode=GMode
			run:BindToRenderStep("CamUpdate",Enum.RenderPriority.Camera.Value,CamUpdate)
		end
	end
	mouse.KeyDown:connect(function(key)
		if key=="u" then
			look=90
		elseif key=="i" then
			if intcam then
				look=180
			else
				look=195
			end
		elseif key=="o" then
			look=-90
		elseif key=="v" then
			run:UnbindFromRenderStep("CamUpdate")
			intcam=not intcam
			run:BindToRenderStep("CamUpdate",Enum.RenderPriority.Camera.Value,CamUpdate)
		end
	end)
	mouse.KeyUp:connect(function(key)
		if key=="u" and look==90 then
			look=0
		elseif key=="i" and (look==180 or look==195) then
			look=0
		elseif key=="o" and look==-90 then
			look=0
		end
	end)
	run:BindToRenderStep("CMChange",Enum.RenderPriority.Camera.Value,ModeChange)
	table.insert(Binded,"CamUpdate")
	table.insert(Binded,"CMChange")
end
Camera()

mouse.KeyDown:connect(function(key)
	if key=="b" then
		if GMode>=1 then
			GMode=0
		else
			GMode=GMode+1
		end
		if GMode==1 then
			Controller=true
		else
			Controller=false
		end
	end
end)
script.Parent:WaitForChild("Car")
local player=game.Players.LocalPlayer
local mouse=player:GetMouse()
local car=script.Parent.Car.Value
local run=game:GetService("RunService")
local Binded={}
local LoopRun={}

local GThrottle=0
local GBrake=0
local GSteer=0
local GRev=0
local GSpeed=0
local GTopSp=0
local GMode=0

local Sounds={
	Looped={
		car.DriveSeat.Rev,
		car.DriveSeat.Rel,
		car.DriveSeat.Backfire,	
	},
	Triggered={
		car.DriveSeat.Start1,
		car.DriveSeat.Start2
	}
}
car.DriveSeat.Start1:Play()
for i,v in pairs(car.Wheels:GetChildren()) do
	for n,a in pairs(v:GetChildren()) do
		if a.Wheel:FindFirstChild("Squeal")~=nil then
			table.insert(Sounds.Looped,a.Wheel.Squeal)
		end
	end
end
--Shutdown
car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		--for i,v in pairs(Binded) do
			--run:UnbindFromRenderStep(v)
		--end 
		GMode=0
		workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
		workspace.CurrentCamera.FieldOfView=70
		player.CameraMaxZoomDistance=400
		pcall(function()
			for i,v in pairs(Sounds) do
				for i,a in pairs(v) do
					a:Stop()
				end
			end
			for i,v in pairs(car.Wheels:GetChildren()) do
				for n,a in pairs(v:GetChildren()) do
					a.Wheel["#AV"]:Destroy()
					if a.Wheel:FindFirstChild("Smoke")~=nil then
						a.Wheel.Smoke.Enabled=false
					end
				end
			end
		end)
		script.Parent:Destroy()
	end
end)

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
		elseif input.KeyCode ==Enum.KeyCode.DPadUp then
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
-----------------------

---Steering
function Steering()
		local mode=0
		
		local TUpdate=tick()
		local Steer=0
		local CSteer=0
		local CSteerTol=3
		local CSteerPerc=.3
		local CPos=0
		local KRef=0
		local KTime=1
		
		local FoAngle=math.rad(43.253)--34
		local FiAngle=math.rad(46.253)--37
		local RoAngle=math.rad(1)
		local RiAngle=math.rad(1)
		local RTime=.25
		local MWidth=400
		local MExp=2
		local KAdj=.7
		local KDecay=350
		local KDExp=1.65
		local DZone=50
		
		local CExp=2
		local CDZone=.1
		
		local function UpdateSteer()
			local fl=FoAngle
			local fr=FiAngle
			local rl=RoAngle
			local rr=RiAngle
			if CPos<0 then
				fl=FiAngle
				fr=FoAngle
				rl=RiAngle
				rr=RoAngle
			end

			for i,v in pairs(car.Wheels.FL:GetChildren()) do
				--v.Arm.Weld.C0=CFrame.new()*CFrame.Angles(0,(CPos+(CSteer*CSteerPerc))*-fl,0)
				v.Arm.Steer.cframe=v.Base.CFrame*CFrame.Angles(0,(CPos)*-fl,0)
				local look = (v.Base.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector 
				v.Arm.Steer.MaxTorque=Vector3.new(math.abs(look.x),math.abs(look.y),math.abs(look.z))*50000
			end
			for i,v in pairs(car.Wheels.FR:GetChildren()) do
				--v.Arm.Weld.C0=CFrame.new()*CFrame.Angles(0,(CPos+(CSteer*CSteerPerc))*-fr,0)
				v.Arm.Steer.cframe=v.Base.CFrame*CFrame.Angles(0,(CPos)*-fr,0)
				local look = (v.Base.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector 
				v.Arm.Steer.MaxTorque=Vector3.new(math.abs(look.x),math.abs(look.y),math.abs(look.z))*50000
			end
			for i,v in pairs(car.Wheels.RL:GetChildren()) do
				--v.Arm.Weld.C0=CFrame.new()*CFrame.Angles(0,(CPos+(CSteer*CSteerPerc))*rl,0)
				v.Arm.Steer.cframe=v.Base.CFrame*CFrame.Angles(0,(CPos)*rl,0)
				local look = (v.Base.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector 
				v.Arm.Steer.MaxTorque=Vector3.new(math.abs(look.x),math.abs(look.y),math.abs(look.z))*00000
			end
			for i,v in pairs(car.Wheels.RR:GetChildren()) do
				--v.Arm.Weld.C0=CFrame.new()*CFrame.Angles(0,(CPos+(CSteer*CSteerPerc))*rr,0)
				v.Arm.Steer.cframe=v.Base.CFrame*CFrame.Angles(0,(CPos)*rr,0)
				local look = (v.Base.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector 
				v.Arm.Steer.MaxTorque=Vector3.new(math.abs(look.x),math.abs(look.y),math.abs(look.z))*00000
			end
			GSteer=CPos
		end
		
		local function getSteer()
			--local rot=(car.DriveSeat.RotVelocity*(car.DriveSeat.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector)/CSteerTol
			--local CS=rot.x+rot.y+rot.z
			--CSteer=(CS+Steer)*(1-math.abs(Steer))
			
			local SLimit=1
			if GMode==0 then
				Steer=car.DriveSeat.Steer
			elseif GMode==1 then
				--SLimit=0
				local MPos=mouse.X-(mouse.ViewSizeX/2)
				if math.abs(MPos)>DZone then
					local sPos=1
					if MPos<0 then sPos=-1 end
					Steer=sPos*math.abs(math.max(-1,math.min(1,(MPos-(DZone*sPos))/(MWidth-DZone)))^MExp)
				else
					Steer=0
				end
			else
				--SLimit=0
				if math.abs(LStickX)>CDZone then
					local sPos=1
					if LStickX<0 then sPos=-1 end
					Steer=sPos*math.abs(math.max(-1,math.min(1,((LStickX-CDZone))/(1-CDZone)))^CExp)
				else
					Steer=0
				end
			end
			
			KRef=CPos
			KTime=math.abs(KRef-Steer)*RTime
			if KTime~=0 then
				local t=math.min(1,math.min(tick()-TUpdate,KTime)/KTime)
				CPos=((KRef*(1-t))+(Steer*t))*(1-(KAdj*math.min(1,math.abs((car.DriveSeat.Velocity.Magnitude/KDecay)^KDExp),SLimit)))
			end
			UpdateSteer()
			TUpdate=tick()
		end

		--run:BindToRenderStep("Steer",Enum.RenderPriority.Last.Value,getSteer)
		--table.insert(Binded,"Steer")
		--table.insert(Binded,getSteer)
		table.insert(LoopRun,getSteer)
		
end
Steering()
---

---Engine
function Engine()
	script.Parent:WaitForChild("Gauges")
	script.Parent:WaitForChild("Status")
	local down1
	local down2
	local Drive={
		car.Wheels.FL:GetChildren(),
		car.Wheels.FR:GetChildren(),
		car.Wheels.RL:GetChildren(),
		car.Wheels.RR:GetChildren()
	}
	local Tc={
		Speed=0,
		ThrotAccel=.1,
		ThrotDecay=.4,
		ClutchAccel=.1,
		ClutchDecay=.5,
		FreeAccel=.1,
		FreeDecay=.01,
		BrakeAccel=.5,
		BrakeDecay=.5,
		ExpGradient=2,
		MaxTorque=50000,
		BrakeMaxTorque=100000,
		BExpGradient=2,
		Brakes=4000,		--Brake Force
		ClutchGain=6000,
		ClutchStall=0,
		ShiftSpeed=.35,
		ClutchShiftSpeed=.7,
		RevBounceP=.93,
		VariableThrotAdj=.1,
		Trans={
	--	Tuning:  http://i.imgur.com/wbHZPI7.png
	--		   [1]		  [2]		  [3]		 [4]		   [5]		  [6]			[7]			  [8]		  [9]
	--	  	{Int Tq	, 	Peak Tq	, 	Peak Sp	, 	Max Sp	, 	Tq Decay, 	Limiter	,	C Tolerance	,	C Gain	,	C Stall	}
			{14000	,	29000	,	30		,	43		,	17		,	8		,	.7			,	.5		,	0		},		--1st
			{10000	,	27000	,	60		,	86		,	20		,	10		,	.2			,	.3		,	0		},		--2nd
			{9000	,	26000	,	90		,	129		,	27		,	13		,	.1			,	.2		,	0		},		--3rd
			{8000	,	24000	,	120		,	272		,	28		,	20		,	.08			,	.15		,	0	    },		--4th
			{7500	,	19800	,	150		,	355  	,	50		,	30		,	.06			,	.1		,	0		},
			{6500	,	14880	,	180		,	490		,	50		,	30		,	.06			,	.1		,	0		},
			{5500	,	12800	,	210		,	600		,	50		,	30		,	.06			,	.1		,	0		},		--6th
		},
		ReverseTq=8000,		--Reverse Torque
		ReverseSp=47,		--Max Reverse Speed
		FDiffPerc=-.2,		--Front Differential 	(-1 -> 1) *value < 0 is outer wheel biased
		CDiffPerc=.25,		--Center Differential	(-1 -> 1) *value < 0 is front biased
		RDiffPerc=-.2,		--Rear Differential		(-1 -> 1) *value < 0 is outer wheel biased
		DTrainDist=- 0,		--Power Distribution	(See below diagram)
					--  Rear  <-|-------|-------|-------|-------|->  Front
					-- Biased  -1        		0     		   	1   Biased
					--  	   RWD    		   AWD   		   FWD
	-------------------------------------------
		ThrotP=0,
		MaxThrotP=1,
		BrakeP=0,
		ClutchP=0,
		Throttle=0,
		Brake=0,
		Clutch=0,
		Gear=1,
		GearShift=1,
		PrevGear=1,
		RPM=0,
		Units={
			{"MPH",.602},
			{"KPH",1.097}
		},
		CUnit=1
	}
		local Friction={
		TractionControl=true,
		FDownforce=0000,	--Front Downforce (Unsprung)
		RDownforce=40000,	--Rear Downforce  (Unsprung)
		FFChange=0,
		FTolerance=10,
		FMaxDiff=40,
		FDecay=1,
		FGripGain=1,
		RFChange=-40000,
		RTolerance=10,
		RMaxDiff=40,
		RDecay=.01,
		RGripGain=.01,
		PBrakeForce=40000,
		SkidTol=20,
	-----------------------------------------
		PBrake=false,
		FSkid=0,
		RSkid=0,
	}
	for i,v in pairs(Drive) do
		for n,a in pairs(v) do
			if a.Wheel:FindFirstChild("#AV") then
				a.Wheel:FindFirstChild("#AV"):Destroy()
			end
			local AV=Instance.new("BodyAngularVelocity",a.Wheel)
			AV.Name="#AV"
			AV.angularvelocity=Vector3.new(0,0,0)
			AV.maxTorque=Vector3.new(0,0,0)
			AV.P=Tc.MaxTorque
		end
	end
	mouse.Button1Up:connect(function() down1=false end)
	mouse.Button1Down:connect(function() down1=true end)
	mouse.Button2Up:connect(function() down2=false end)
	mouse.Button2Down:connect(function() down2=true end)
	mouse.WheelForward:connect(function()
		if GMode==1 then
			Tc.MaxThrotP=math.min(1,Tc.MaxThrotP+Tc.VariableThrotAdj)
		end
	end)
	mouse.WheelBackward:connect(function()
		if GMode==1 then
			Tc.MaxThrotP=math.max(0,Tc.MaxThrotP-Tc.VariableThrotAdj)
		end
	end)
	mouse.KeyDown:connect(function(key)
		if key=="q" then
			Tc.PrevGear=Tc.Gear
			Tc.GearShift=0
			Tc.Gear=math.max(Tc.Gear-1,-1)
		elseif key=="e" then
			Tc.PrevGear=Tc.Gear
			Tc.GearShift=0
			Tc.Gear=math.min(Tc.Gear+1,#Tc.Trans)
		elseif (string.byte(key)==48 and GMode==1) or (key=="p" and GMode==0) then
			Friction.PBrake=1
		elseif (key=="w" and GMode==1) or (string.byte(key)==48 and GMode==0) then
			Tc.Clutch=1
		elseif key=="t" then
			Friction.TractionControl=not Friction.TractionControl
		end
	end)
	mouse.KeyUp:connect(function(key)
		if (string.byte(key)==48 and GMode==1) or (key=="p" and GMode==0) then
			Friction.PBrake=0
		elseif (key=="w" and GMode==1) or (string.byte(key)==48 and GMode==0) then
			Tc.Clutch=0
		end
	end)
	local function AChassis()
		if GMode==0 then
			Tc.MaxThrotP=1
			Tc.MaxBrakeP=1
			Tc.Throttle=math.max(car.DriveSeat.Throttle,0)
			Tc.Brake=math.max(-car.DriveSeat.Throttle,0)
		elseif GMode==1 then
			Tc.MaxBrakeP=1
			if down1 then
				Tc.Throttle=1
			else
				Tc.Throttle=0
			end
			if down2 then
				Tc.Brake=1
			else
				Tc.Brake=0
			end
		else
			Friction.PBrake=ButtonL1
			Tc.Clutch=ButtonR1
			Tc.Throttle=math.ceil(RTriggerValue)
			Tc.MaxThrotP=RTriggerValue
			Tc.Brake=math.ceil(LTriggerValue)
			Tc.MaxBrakeP=LTriggerValue^Tc.BExpGradient
			if Tc.ControllerGUp==0 and ButtonY==1 then
				Tc.PrevGear=Tc.Gear
				Tc.GearShift=0
				Tc.Gear=math.min(Tc.Gear+1,#Tc.Trans)
			elseif Tc.ControllerGDown==0 and ButtonX==1 then
				Tc.PrevGear=Tc.Gear
				Tc.GearShift=0
				Tc.Gear=math.max(Tc.Gear-1,-1)
			end
			Tc.ControllerGUp=ButtonY
			Tc.ControllerGDown=ButtonX
		end
		if Tc.Throttle==1 then
			Tc.ThrotP=math.min(Tc.MaxThrotP,Tc.ThrotP+Tc.ThrotAccel)
		else
			Tc.ThrotP=math.max(0,Tc.ThrotP-Tc.ThrotDecay)
		end
		if Tc.Brake==1 then
			Tc.BrakeP=math.min(Tc.MaxBrakeP,Tc.BrakeP+Tc.BrakeAccel)
		else
			Tc.BrakeP=math.max(0,Tc.BrakeP-Tc.BrakeDecay)
		end
		if Tc.Clutch==1 or Tc.Gear==0 then
			Tc.ClutchP=math.max(0,Tc.ClutchP-Tc.ClutchDecay)
		else
			Tc.ClutchP=math.min(1,Tc.ClutchP+Tc.ClutchAccel)
		end
		-------------
		Tc.GearShift=math.min(1,Tc.GearShift+Tc.ShiftSpeed+(Tc.ClutchShiftSpeed*(1-Tc.ClutchP)))
		---GearChangeBeta
		local tol=Tc.Trans[math.max(Tc.Gear,1)][7]
		local NSGear=Tc.Trans[math.max(Tc.Gear,1)][4]+Tc.Trans[math.max(Tc.Gear,1)][6]+3
		local OSGear=Tc.Trans[math.max(Tc.PrevGear,1)][4]+Tc.Trans[math.max(Tc.PrevGear,1)][6]+3
		local toprev=OSGear+((NSGear-OSGear)*Tc.GearShift)
		local gearDiff=(Tc.RPM*NSGear)-(Tc.RPM*OSGear)
		local stall=1
		local stalltq=0
		if math.abs(gearDiff)>tol then
			stall=Tc.GearShift
			if gearDiff>0 then
				stalltq=Tc.Trans[Tc.Gear][8]*(1-Tc.GearShift)
			else
				stalltq=Tc.Trans[Tc.Gear][9]*(1-Tc.GearShift)
			end
		end
		-------------
		local frev=0
		local rrev=0
		for i,v in pairs(Drive[1]) do
			frev=math.max(frev,v.Wheel.RotVelocity.Magnitude)
		end
		for i,v in pairs(Drive[2]) do
			frev=math.max(frev,v.Wheel.RotVelocity.Magnitude)
		end
		for i,v in pairs(Drive[3]) do
			rrev=math.max(rrev,v.Wheel.RotVelocity.Magnitude)
		end
		for i,v in pairs(Drive[4]) do
			rrev=math.max(rrev,v.Wheel.RotVelocity.Magnitude)
		end
		local rev=rrev/toprev
		if Tc.DTrainDist==1 then
			rev=frev/toprev
		elseif Tc.DTrainDist~=-1 then
			rev=math.max(rev,frev/toprev)
		end
		local rGain=(Tc.ThrotP*2)-1
		if rGain>0 then
			rGain=rGain*Tc.FreeAccel
		else
			rGain=rGain*Tc.FreeDecay
		end
		Tc.RPM=math.min(1,math.max(0,rev*Tc.ClutchP^.3,(Tc.RPM+rGain)*(1-Tc.ClutchP)^.3))
		-- A-Chassis 5.0
		for i,a in pairs(Drive) do
			for n,v in pairs(a) do
				local tq=0
				if Tc.Gear>0 then
					Tc.Speed=toprev
					if v.Wheel.RotVelocity.Magnitude<Tc.Trans[Tc.Gear][4] then
						local tPerc=math.min(v.Wheel.RotVelocity.Magnitude/Tc.Trans[Tc.Gear][3],1)
						local tqChange=Tc.Trans[Tc.Gear][2]-Tc.Trans[Tc.Gear][1]
						tq=(Tc.Trans[Tc.Gear][1]+(tPerc*tqChange))
					else
						if v.Wheel.RotVelocity.Magnitude<Tc.Trans[Tc.Gear][4]+Tc.Trans[Tc.Gear][6]-1 then
							local tPerc=(v.Wheel.RotVelocity.Magnitude-Tc.Trans[Tc.Gear][4])/Tc.Trans[Tc.Gear][5]
							local tqChange=Tc.Trans[Tc.Gear][2]
							tq=(math.max(0,Tc.Trans[Tc.Gear][2]-(tPerc*tqChange)))
						else
							Tc.Speed=(Tc.Trans[Tc.Gear][4]+Tc.Trans[Tc.Gear][6])*Tc.RevBounceP
							tq=Tc.Trans[Tc.Gear][2]*2
						end
					end
				elseif Tc.Gear==0 then
					tq=0
				else
					Tc.Speed=-Tc.ReverseSp
					tq=Tc.ReverseTq
				end
				if i==1 then
					tq=tq*(1-(GSteer*Tc.FDiffPerc))*(1+math.abs(GSteer*Tc.CDiffPerc))*(1+Tc.DTrainDist)
				elseif i==2 then
					tq=tq*(1+(GSteer*Tc.FDiffPerc))*(1+math.abs(GSteer*Tc.CDiffPerc))*(1+Tc.DTrainDist)
				elseif i==3 then
					tq=tq*(1-(GSteer*Tc.RDiffPerc))*(1-math.abs(GSteer*Tc.CDiffPerc))*(1-Tc.DTrainDist)
				else
					tq=tq*(1+(GSteer*Tc.RDiffPerc))*(1-math.abs(GSteer*Tc.CDiffPerc))*(1-Tc.DTrainDist)
				end
				tq=tq*Tc.ThrotP*Tc.ClutchP^Tc.ExpGradient
				tq=tq+(tq*stalltq)
				local br=Tc.Brakes*Tc.BrakeP^Tc.ExpGradient
				tq=math.abs(tq-br)
				Tc.Speed=Tc.Speed*(1-math.ceil(Tc.BrakeP))
				if i>2 and Friction.PBrake==1 then
					Tc.Speed=0
					tq=Friction.PBrakeForce
				end
				local Ref=v.Axle.CFrame.lookVector
				local Speed=Tc.Speed
				if i==1 or i==3 then Speed=-Speed end
				local TqVector=1
				if Friction.TractionControl then
					TqVector=math.max(0,Friction.SkidTol-math.abs((v.Wheel.RotVelocity.Magnitude*(v.Wheel.Size.X/2))-v.Wheel.Velocity.Magnitude))/Friction.SkidTol
					if TqVector<.7 then
						script.Parent.Gauges.Speedo.TC.Visible=true
					else
						script.Parent.Gauges.Speedo.TC.Visible=false
					end
				else
					script.Parent.Gauges.Speedo.TC.Visible=false
				end
				v.Wheel["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*tq*TqVector
				v.Wheel["#AV"].angularvelocity=Ref*Speed*stall
				v.Wheel["#AV"].P=Tc.MaxTorque*TqVector
			end
		end
	end
	script.Parent.Gauges.Speedo.Units.MouseButton1Click:connect(function()
		if Tc.CUnit>=3 then
			Tc.CUnit=1
		else
			Tc.CUnit=Tc.CUnit+1
		end
		script.Parent.Gauges.Speedo.Units.Text=Tc.Units[Tc.CUnit][1]
	end)
	local numbers={180354176,180354121,180354128,180354131,180354134,180354138,180354146,180354158,180354160,180354168,180355596,180354115}
	local function Speedometer()
		--Sound
		car.DriveSeat.Rev.Pitch=car.DriveSeat.Rev.SetPitch.Value+car.DriveSeat.Rev.SetRev.Value*Tc.RPM
		car.DriveSeat.Rel.Pitch=car.DriveSeat.Rel.SetPitch.Value+car.DriveSeat.Rel.SetRev.Value*Tc.RPM
		car.DriveSeat.Rev.Volume=car.DriveSeat.Rev.SetVolume.Value*Tc.ThrotP
		car.DriveSeat.Rel.Volume=car.DriveSeat.Rel.SetVolume.Value*(1-Tc.ThrotP)
		
		if Tc.Throttle ~= 1 then
			car.DriveSeat.Backfire.Volume=math.min(math.max((Tc.RPM-.5)/.5,0)*.7,car.DriveSeat.Backfire.Volume+.07)
		else
			car.DriveSeat.Backfire.Volume=math.max(car.DriveSeat.Backfire.Volume-.07,0)
		end
		--Afterburn
		if Tc.PrevThrot~=Tc.Throttle and Tc.RPM > .6 then
			local a=math.random(0,1)
			if a==1 then
				coroutine.resume(coroutine.create(function()
					for i,v in pairs(car.Body.Exhaust:GetChildren()) do
						v.Afterburn.Rate=400
					end
					wait(0.2)
					for i,v in pairs(car.Body.Exhaust:GetChildren()) do
						v.Afterburn.Rate=0
					end
				end))
			end
		end
		--Speedo
		local fwheel=Tc.RPM*(Tc.Trans[math.max(Tc.Gear,1)][4]+Tc.Trans[math.max(Tc.Gear,1)][6])
		local z1=math.min(1,math.max(0,fwheel-(Tc.Trans[math.max(Tc.Gear,1)][3]*.5))/(Tc.Trans[math.max(Tc.Gear,1)][3]-(Tc.Trans[math.max(Tc.Gear,1)][3]*.5)))
		local z2=math.min(1,math.max(0,fwheel-Tc.Trans[math.max(Tc.Gear,1)][4])/Tc.Trans[math.max(Tc.Gear,1)][6])
		local blue=1-z1
		local red=z2*2
		local green=0
		if fwheel>Tc.Trans[math.max(Tc.Gear,1)][4] then
			green=1-z2
		else
			green=math.max(.45,z1*2)
		end
		for i,v in pairs(script.Parent.Gauges.Tach:GetChildren()) do
			local n=tonumber(string.match(v.Name, "%d+"))
			if n~=nil then
				if n%2 == 0 then
					v.P.Size=UDim2.new(0,4,0,((1-math.abs(Tc.RPM-((n-1)/18)))^12*-40)-10)
				else
					v.P.Size=UDim2.new(0,6,0,((1-math.abs(Tc.RPM-((n-1)/18)))^12*-40)-10)
				end
				v.P.BackgroundColor3 = Color3.new(red,green,blue)
			end
		end
		local sp=car.DriveSeat.Velocity.Magnitude*Tc.Units[Tc.CUnit][2]
		if sp<1000 then
			local nnn=math.floor(sp/100)
			local nn=(math.floor(sp/10))-(nnn*10)
			local n=(math.floor(sp)-(nn*10))-(nnn*100)
			script.Parent.Gauges.Speedo.A.Image="http://www.roblox.com/asset/?id="..numbers[n+1]
			if sp>=10 then
				script.Parent.Gauges.Speedo.B.Image="http://www.roblox.com/asset/?id="..numbers[nn+1]
			else
				script.Parent.Gauges.Speedo.B.Image="http://www.roblox.com/asset/?id="..numbers[12]
			end
			if sp>=100 then
				script.Parent.Gauges.Speedo.C.Image="http://www.roblox.com/asset/?id="..numbers[nnn+1]
			else
				script.Parent.Gauges.Speedo.C.Image="http://www.roblox.com/asset/?id="..numbers[12]
			end
		else
			script.Parent.Gauges.Speedo.A.Image="http://www.roblox.com/asset/?id="..numbers[10]
			script.Parent.Gauges.Speedo.B.Image="http://www.roblox.com/asset/?id="..numbers[10]	
			script.Parent.Gauges.Speedo.C.Image="http://www.roblox.com/asset/?id="..numbers[10]
		end
		if Tc.Gear>=0 then
			script.Parent.Gauges.Gear.G.Image="http://www.roblox.com/asset/?id="..numbers[Tc.Gear+1]
		else
			script.Parent.Gauges.Gear.G.Image="http://www.roblox.com/asset/?id="..numbers[11]
		end
		--Status Indicators
		script.Parent.Status.Clutch.B.Size=UDim2.new(0,4,-Tc.ClutchP,0)
		script.Parent.Status.Throttle.B.Size=UDim2.new(0,4,-Tc.ThrotP,0)
		script.Parent.Status.Brakes.B.Size=UDim2.new(0,4,-Tc.BrakeP,0)
		script.Parent.Status.ThrotLimit.B.Size=UDim2.new(0,4,-Tc.MaxThrotP,0)
		GSpeed=car.DriveSeat.Velocity.Magnitude
		GTopSp=Tc.Trans[#Tc.Trans][4]+Tc.Trans[#Tc.Trans][6]
		GRev=Tc.RPM
		GThrottle=Tc.ThrotP
		GBrake=Tc.BrakeP
		Tc.PrevThrot=Tc.Throttle
	end
	local function Smoke()
		local tireSP={}
		for i,v in pairs(Drive) do
			for n,a in pairs(v) do
				if a.Wheel:FindFirstChild("Smoke")~=nil and a.Wheel:FindFirstChild("Squeal")~=nil then
					if workspace:FindPartOnRay(Ray.new(a.Wheel.Position,Vector3.new(0,-a.Wheel.Size.X/2,0)),car) then
						a.Wheel.Smoke.Enabled=math.abs((a.Wheel.RotVelocity.Magnitude*(a.Wheel.Size.X/2))-a.Wheel.Velocity.Magnitude)>20
						a.Wheel.Squeal.Volume=math.min(1,math.max(0,math.abs((a.Wheel.RotVelocity.Magnitude*(a.Wheel.Size.X/2))-a.Wheel.Velocity.Magnitude)-20)/20)
					else
						a.Wheel.Smoke.Enabled=false
						a.Wheel.Squeal.Volume=0
					end
				end
			end
		end
	end
	--run:BindToRenderStep("AChassis",Enum.RenderPriority.Last.Value,AChassis)
	--run:BindToRenderStep("Speedometer",Enum.RenderPriority.Last.Value,Speedometer)
	--run:BindToRenderStep("Smoke",Enum.RenderPriority.Last.Value,Smoke)
	--table.insert(Binded,"AChassis")
	--table.insert(Binded,"Speedometer")
	--table.insert(Binded,"Smoke")
	table.insert(LoopRun,AChassis)
	table.insert(LoopRun,Speedometer)
	table.insert(LoopRun,Smoke)
end
Engine()
--

---Camera
function Camera()
	local cam=workspace.CurrentCamera
	local CRot=0
	local CBack=0
	local CUp=0
	local look=0
	local camChange = 0
	local function CamUpdate()
		if not pcall (function()
			camChange=DPadUp
			if GMode==2 then
				if math.abs(RStickX)>.1 then
					local sPos=1
					if RStickX<0 then sPos=-1 end
					CRot=sPos*math.abs(((math.abs(RStickX)-.1)/(.9)))*-60
				else
					CRot=0
				end
				if math.abs(RStickY)>.1 then
					local sPos=1
					if RStickY<0 then sPos=-1 end
					CUp=math.min(sPos*math.abs(((math.abs(RStickY)-.1)/(.9)))*-75,30)
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
			CBack=-180*ButtonR3
			cam.CameraSubject=car.DriveSeat
			cam.FieldOfView=70
			if GMode==0 then
				cam.CameraType=Enum.CameraType.Custom
				player.CameraMaxZoomDistance=400
			else
				cam.CameraType = "Scriptable"
				local pspeed = math.min(1,car.DriveSeat.Velocity.Magnitude/500)
				local cc = car.DriveSeat.Position+Vector3.new(0,8+(pspeed*2),0)-((car.DriveSeat.CFrame*CFrame.Angles(math.rad(CUp),math.rad(CRot+CBack),0)).lookVector*17)+(car.DriveSeat.Velocity.Unit*-7*pspeed)
				cam.CoordinateFrame = CFrame.new(cc,car.DriveSeat.Position)
			end
		end) then
			cam.FieldOfView=70
			cam.CameraSubject=player.Character.Humanoid
			cam.CameraType=Enum.CameraType.Custom
			player.CameraMaxZoomDistance=400
			run:UnbindFromRenderStep("CamUpdate")
		end
	end
	mouse.KeyDown:connect(function(key)
		if key=="z" then
			look=50
		elseif key=="x" then
			look=-180
		elseif key=="c" then
			look=-50
		end
	end)
	mouse.KeyUp:connect(function(key)
		if key=="z" and look==50 then
			look=0
		elseif key=="x" and (look==-160 or look==-180) then
			look=0
		elseif key=="c" and look==-50 then
			look=0
		end
	end)
	--run:BindToRenderStep("CamUpdate",Enum.RenderPriority.Camera.Value,CamUpdate)
	--table.insert(Binded,"CamUpdate")
	table.insert(Binded,CamUpdate)
end
Camera()
--

---Misc
function Misc()
	local function GetHelp()
		local a=false
		for i=1,9 do
			a=not a
			wait(.2)
			if a then
				script.Parent.Help.Style=Enum.ButtonStyle.RobloxRoundDropdownButton
			else
				script.Parent.Help.Style=Enum.ButtonStyle.RobloxRoundDefaultButton
			end
		end
	end
	GetHelp()
	script.Parent.Help.MouseButton1Click:connect(function()
		script.Parent.Controls.Visible=not script.Parent.Controls.Visible
	end)
	script.Parent:WaitForChild("Light")
	local light=0
	local function Light(on)
		for i,v in pairs(car.Body.Lights:GetChildren()) do
			if v:FindFirstChild("Light")~=nil then
				v.Light.Enabled= true
				v.Parent.F.lbeam.Enabled = true
				v.Parent.F.rbeam.Enabled = true
			end
			if on and v.BrickColor~=BrickColor.new("Gold") then
				v.Material=Enum.Material.Neon
			else
				v.Material=Enum.Material.SmoothPlastic
			end
		end
	end
	local function AutoLight()
		if light==0 then
			if (game.Lighting:GetMinutesAfterMidnight()<390 or game.Lighting:GetMinutesAfterMidnight()>1050) then
				Light(true)
			else
				Light(false)
			end
		end
	end
	script.Parent.Light.MouseButton1Click:connect(function()
		if light==1 then
			light=-1
		else
			light=light+1
		end
		if light==0 then
			script.Parent.Light.Text="Lights: Auto"
			if game.Lighting:GetMinutesAfterMidnight()<390 or game.Lighting:GetMinutesAfterMidnight()>1050 then
				Light(true)
			else
				Light(false)
			end
		elseif light==1 then
			script.Parent.Light.Text="Lights: On"
			Light(true)
		else
			script.Parent.Light.Text="Lights: Off"
			Light(false)
		end
	end)
	local function BrakeLights()
		for i,v in pairs(car.Body.Lights:GetChildren()) do
			if v.Name=="R" then
				if v.Light.Enabled then
					if GBrake>0 then
						v.Transparency=0
						v.Light.Brightness=12
						v.Trail1.Enabled = true
						v.Trail2.Enabled = true
					else
						v.Transparency=.3
						v.Light.Brightness=8
						v.Trail1.Enabled = false
						v.Trail2.Enabled = false
					end
				else
					if GBrake>0 then
						v.Material=Enum.Material.Neon
						v.Trail1.Enabled = true
						v.Trail2.Enabled = true
					else
						v.Material=Enum.Material.SmoothPlastic
						v.Trail1.Enabled = false
						v.Trail2.Enabled = false
					end
				end
			end
		end
	end
	game.Lighting.Changed:connect(AutoLight)
	AutoLight()
	local FlipWait=tick()
	local FlipDB=false
	local function FlipCar()
		local gyro = car.DriveSeat.Flip
		gyro.maxTorque = Vector3.new(10000,0,10000)
		gyro.P=3000
		gyro.D=500
		wait(2)
		gyro.maxTorque = Vector3.new(0,0,0)
		gyro.P=0
		gyro.D=0
		FlipDB=false
	end
	local function GetFlip()
		if (car.DriveSeat.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector.y > .1 or FlipDB then
			FlipWait=tick()
		else
			if tick()-FlipWait>=3 then
				FlipDB=true
				FlipCar()
			end
		end
	end
	--run:BindToRenderStep("BrakeL",Enum.RenderPriority.Last.Value,BrakeLights)
	--run:BindToRenderStep("Flip",Enum.RenderPriority.Last.Value,GetFlip)
	--table.insert(Binded,"BrakeL")
	--table.insert(Binded,"Flip")
	table.insert(LoopRun,BrakeLights)
	table.insert(LoopRun,GetFlip)
end
Misc()
--
mouse.KeyDown:connect(function(key)
	if key=="r" then
		if GMode>=2 then
			GMode=0
		else
			GMode=GMode+1
		end
		if GMode==2 then
			Controller=true
		else
			Controller=false
		end
		if GMode==0 then
			script.Parent.Mode.Text = "Control Mode: Keyboard"
		elseif GMode==1 then
			script.Parent.Mode.Text = "Control Mode: Mouse"
		else
			script.Parent.Mode.Text = "Control Mode: Controller"
		end
	end
end)
game["Run Service"].RenderStepped:connect(function()
	for i,v in pairs(Binded) do
		v()
	end
end)

car.DriveSeat.Start2:Play()
car.DriveSeat.Start1:Stop()
for i,v in pairs(Sounds.Looped) do
	v:Play()
end
coroutine.resume(coroutine.create(function()
	for i,v in pairs(car.Body.Exhaust:GetChildren()) do
		v.Afterburn.Rate=10
	end
	wait(.3)
	for i,v in pairs(car.Body.Exhaust:GetChildren()) do
		v.Afterburn.Rate=0
	end
end))
while wait() do
	for i,v in pairs(LoopRun) do
		v()
	end
end
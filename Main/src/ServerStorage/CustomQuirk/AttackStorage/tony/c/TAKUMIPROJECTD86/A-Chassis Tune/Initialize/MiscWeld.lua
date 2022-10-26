local MiscWeld = {}

function MakeWeld(x,y,type,s) 
	if type==nil then type="Weld" end
	local W=Instance.new(type)
	W.Part0=x W.Part1=y 
	W.C0=x.CFrame:inverse()*x.CFrame 
	W.C1=y.CFrame:inverse()*x.CFrame 
	W.Parent=x 
	if type=="Motor" and s~=nil then 
		W.MaxVelocity=s 
	end 
	return W	
end
function ModelWeld(a,b) 
	if a:IsA("BasePart") then 
		MakeWeld(b,a,"Weld") 
	elseif a:IsA("Model") then 
		for i,v in pairs(a:GetChildren()) do 
			ModelWeld(v,b) 
		end 
	end 
end

car = script.Parent.Parent.Parent
misc = car:WaitForChild("Misc")

---------------------------
--[[
	--Main anchor point is the DriveSeat <car.DriveSeat>	
	
	Usage:
		MakeWeld(Part1,Part2,WeldType*,MotorVelocity**) *default is "Weld"  **Applies to Motor welds only
		ModelWeld(Model,MainPart)
	Example:
		MakeWeld(car.DriveSeat,misc.PassengerSeat)
		MakeWeld(car.DriveSeat,misc.SteeringWheel,"Motor",.2)
		ModelWeld(car.DriveSeat,misc.Door)
]]

--Weld stuff here
MakeWeld(car.Misc.Tach.M,car.DriveSeat,"Motor").Name="M"
ModelWeld(misc.Tach.Parts,misc.Tach.M)
MakeWeld(car.Misc.Speedo.N,car.DriveSeat,"Motor").Name="N"
ModelWeld(misc.Speedo.Parts,misc.Speedo.N)
MakeWeld(misc.Wiper.Hinge,car.DriveSeat,"Motor",.1)
ModelWeld(misc.Wiper.Parts,misc.Wiper.Hinge)
MakeWeld(misc.Wiper2.Hinge,car.DriveSeat,"Motor",.1)
ModelWeld(misc.Wiper2.Parts,misc.Wiper2.Hinge)
MakeWeld(misc.Wiper3.Hinge,car.DriveSeat,"Motor",.1)
ModelWeld(misc.Wiper3.Parts,misc.Wiper3.Hinge)
MakeWeld(misc.BP.SS,car.DriveSeat,"Motor",.1)
ModelWeld(misc.BP.MeshPart,misc.BP.SS)
MakeWeld(misc.GP.SS,car.DriveSeat,"Motor",.1)
ModelWeld(misc.GP.MeshPart,misc.GP.SS)
MakeWeld(misc.Valve.SS,car.DriveSeat,"Motor",.1)
ModelWeld(misc.Valve.Parts,misc.Valve.SS)
car.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		child.C0=CFrame.new(0,-.5,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)*CFrame.Angles(math.rad(13),0,0)
	end
end)

---------------------------
return MiscWeld
--BasedWeld2.0
function MakeWeld(x,y,type,s) 
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
function UnAnchor(a) 
	if a:IsA("BasePart") then a.Anchored=false elseif a:IsA("Model") then for i,v in pairs(a:GetChildren()) do UnAnchor(v) end end 
end
--
local car=script.Parent
for i,a in pairs(car.Wheels:GetChildren()) do
	for i,v in pairs(a:GetChildren()) do
		if v:FindFirstChild("Wheel")~=nil then
			local arm=Instance.new("Part",v)
			arm.Name="Arm"
			arm.Anchored=true
			arm.CanCollide=false
			arm.FormFactor=Enum.FormFactor.Custom
			arm.Size=Vector3.new(1,1,1)
			arm.CFrame=v.Wheel.CFrame*CFrame.Angles(-math.pi/2,-math.pi/2,0)
			arm.TopSurface=Enum.SurfaceType.Smooth
			arm.BottomSurface=Enum.SurfaceType.Smooth
			arm.Transparency=1
			local base=arm:Clone()
			base.Parent=v
			base.Name="Base"
			base.CFrame=base.CFrame*CFrame.new(0,1,0)
			base.BottomSurface=Enum.SurfaceType.Hinge
			local axle=arm:Clone()
			axle.Parent=v
			axle.Name="Axle"
			axle.CFrame=CFrame.new(v.Wheel.Position-((v.Wheel.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector*((v.Wheel.Size.x/2)+(axle.Size.x/2))),v.Wheel.Position)*CFrame.Angles(0,math.pi,0)
			axle.BackSurface=Enum.SurfaceType.Hinge
			MakeWeld(car.DriveSeat,base,"Weld")--
			if v.Parent.Name == "RL" or v.Parent.Name == "RR" then
				MakeWeld(car.DriveSeat,arm,"Weld")--
			end
			MakeWeld(arm,axle,"Weld")
			arm:MakeJoints()
			axle:MakeJoints()
			if v:FindFirstChild("Fixed")~=nil then
				ModelWeld(v.Fixed,axle)
			end
			if v:FindFirstChild("Parts")~=nil then
				ModelWeld(v.Parts,v.Wheel)
			end
			local gyro=Instance.new("BodyGyro",arm)
			gyro.Name="Steer"
			gyro.P=100000
			gyro.D=1000
			gyro.MaxTorque=Vector3.new(50000,50000,50000)
			gyro.cframe=base.CFrame
		end
	end
end
ModelWeld(car.Body,car.DriveSeat)

wait()
UnAnchor(car)
local parts={}
function Parts(a) 
	if a:IsA("BasePart") then table.insert(parts,a) elseif a:IsA("Model") then for i,v in pairs(a:GetChildren()) do Parts(v) end end 
end
script.G.Car.Value=script.Parent
car.DriveSeat.ChildAdded:connect(function(child)
	if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		for i,v in pairs(parts) do
			v:SetNetworkOwner(p)
		end
		child.C0=CFrame.new(0,-1,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)
		local g=script.G:Clone()
		g.Parent=p.PlayerGui
	end
end)
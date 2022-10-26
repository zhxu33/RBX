script:WaitForChild("Seat")
local C=game.Players.LocalPlayer.Character
local S=script.Seat.Value
local A=C.Animate
local WS={}
local HW={}

local LeanIn={
CFrame.new(0, 0, 0, 1, 9.4587449e-11, -7.27595761e-12, 9.4587449e-11, 0.99999994, -3.97654853e-10, -7.27595761e-12, -3.97654853e-10, 0.99999994), --Torso
CFrame.new(-3.05175781e-05, 1.56471252, -0.0154418945, 1, -6.20862993e-05, -2.33102071e-09, 6.17472906e-05, 0.994521856, 0.104528576, -6.48756168e-06, -0.104528576, 0.994521856), --Head
CFrame.new(-0.395484924, -0.208745956, -0.47718811, -0.965925753, -0.243196681, -0.0885583758, -0.257834047, 0.874346793, 0.411141902, -0.0225576125, 0.419966012, -0.907258511), --Larm
CFrame.new(0.395484924, -0.208696365, -0.477279663, 0.965925813, 0.243210256, -0.0885213688, -0.257830679, 0.874345899, -0.411147237, -0.022596918, 0.419961184, 0.907260418), --Rarm
CFrame.new(-0.5, -1.5466814, -1.39762878, 1, 2.88117974e-10, -7.36108632e-08, -7.25995051e-08, 0.104376547, -0.994537592, 7.48877937e-09, 0.994537592, 0.104376547), --Lleg
CFrame.new(0.499992371, -1.54668236, -1.39762878, 1, 2.88117974e-10, -7.36108632e-08, -7.25995051e-08, 0.104376547, -0.994537592, 7.48877937e-09, 0.994537592, 0.104376547) --Rleg
}


S.ChildRemoved:connect(function(child) if child.Name=="SeatWeld" then for i,v in pairs(WS) do if v~=0 then if v[4]~=nil then v[4]:Destroy() v[1].Part1=v[5] else if v[2]~=nil then v[1].C0=v[2] v[1].C1=v[3] else v[1]:Destroy() end end end end for i,v in pairs(HW) do v[1]:Destroy() v[2]:Destroy() v[3].Transparency=0 end A.Parent=C A.Disabled=false script:Destroy() end end)
function MW(x,y)
	local WW=Instance.new("Weld",x) WW.Part0=x WW.Part1=y return WW
end


if C:FindFirstChild("HumanoidRootPart")~=nil and C:FindFirstChild("Torso")~=nil then
	A.Disabled=true
	A.Parent=script
	S.SeatWeld.C0=CFrame.new()
	S.SeatWeld.C1=CFrame.new()
	C.HumanoidRootPart.RootJoint.Part1=nil
	table.insert(WS,{C.HumanoidRootPart.RootJoint,C.HumanoidRootPart.RootJoint.C0,C.HumanoidRootPart.RootJoint.C1,MW(C.HumanoidRootPart,C.Torso),C.Torso})
	if C.Torso:FindFirstChild("Neck")~=nil then
		local H=C.Head:Clone()
		H.Parent=S.Parent
		local WH=MW(C.Torso,H)
		WH.C0=C.Torso.Neck.C0
		WH.C1=C.Torso.Neck.C0
		C.Head.Transparency=1
		table.insert(HW,{H,WH,C.Head})
		table.insert(WS,{WH,nil,nil,nil,nil})
		for i,v in pairs(C.Head:GetChildren()) do
			if v:IsA("Weld") then
				local pp=v.Part1:Clone()
				pp.Parent=S.Parent
				v.Part1.Transparency=1
				local ww=MW(H,pp)
				ww.C0=v.C0
				ww.C1=v.C1
				table.insert(HW,{pp,ww,v.Part1})
			end
		end	
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Left Shoulder")~=nil then
		C.Torso:FindFirstChild("Left Shoulder").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Left Shoulder"),C.Torso:FindFirstChild("Left Shoulder").C0,C.Torso:FindFirstChild("Left Shoulder").C1,MW(C.Torso,C:FindFirstChild("Left Arm")),C:FindFirstChild("Left Arm")})
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Right Shoulder")~=nil then
		C.Torso:FindFirstChild("Right Shoulder").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Right Shoulder"),C.Torso:FindFirstChild("Right Shoulder").C0,C.Torso:FindFirstChild("Right Shoulder").C1,MW(C.Torso,C:FindFirstChild("Right Arm")),C:FindFirstChild("Right Arm")})
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Left Hip")~=nil then
		C.Torso:FindFirstChild("Left Hip").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Left Hip"),C.Torso:FindFirstChild("Left Hip").C0,C.Torso:FindFirstChild("Left Hip").C1,MW(C.Torso,C:FindFirstChild("Left Leg")),C:FindFirstChild("Left Leg")})
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Right Hip")~=nil then
		C.Torso:FindFirstChild("Right Hip").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Right Hip"),C.Torso:FindFirstChild("Right Hip").C0,C.Torso:FindFirstChild("Right Hip").C1,MW(C.Torso,C:FindFirstChild("Right Leg")),C:FindFirstChild("Right Leg")})
	else
		table.insert(WS,0)
	end
end

for i,v in pairs(WS) do
	if v[4]~=nil then
		v[4].C0=LeanIn[i]
		v[4].C1=CFrame.new()
	else
		v[1].C0=LeanIn[i]
		v[1].C1=CFrame.new()
	end
end

function getC(w,c)
	local ax,ay,az,ar00,ar01,ar02,ar10,ar11,ar12,ar20,ar21,ar22=CFrame.new().components(w.C0)
	local bx,by,bz,br00,br01,br02,br10,ar11,br12,br20,br21,br22=CFrame.new().components(c)
	local ca={ax,ay,az,ar00,ar01,ar02,ar10,ar11,ar12,ar20,ar21,ar22}
	local cb={bx,by,bz,br00,br01,br02,br10,ar11,br12,br20,br21,br22}
	local cd={}
	for i,v in pairs(ca) do
		table.insert(cd,(cb[i]-v)/10)
	end
	return cd
end
function tween(w,cd)
	local cx,cy,cz,cr00,cr01,cr02,cr10,cr11,cr12,cr20,cr21,cr22=CFrame.new().components(w.C0)
	local cc={cx,cy,cz,cr00,cr01,cr02,cr10,cr11,cr12,cr20,cr21,cr22}
	local ce={}
	for i,v in pairs(cc) do
		table.insert(ce,v+cd[i])
	end
	w.C0=CFrame.new(ce[1],ce[2],ce[3],ce[4],ce[5],ce[6],ce[7],ce[8],ce[9],ce[10],ce[11],ce[12])
end
function setPose(p)
	for i,v in pairs(WS) do
		if v[4]~=nil then
			tween(v[4],p[i])
		else
			tween(v[1],p[i])
		end
	end
end
function getPose(p)
	local ps={}
	for i,v in pairs(WS) do
		if v[4]~=nil then
			table.insert(ps,getC(v[4],p[i]))
		else
			table.insert(ps,getC(v[1],p[i]))
		end
	end
	return(ps)
end

local steer=S.Steer
local frame=0
pose=getPose(LeanIn)
	if frame<10 then
		frame=frame+1
		setPose(pose)
	end
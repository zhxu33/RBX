local HighRPM = 7000
local TransitionInfluence = 1
local TransitionOffset = 0
local LoadSpeed = 0.25


wait(0.25)
local car = script.Parent.Car.Value
local lowonserver = car.DriveSeat.LowOnServer
local highonserver = car.DriveSeat.HighOnServer
local lowonclient = car.DriveSeat.LowOnClient
local highonclient = car.DriveSeat.HighOnClient
local lowoffserver = car.DriveSeat.LowOffServer
local highoffserver = car.DriveSeat.HighOffServer
local lowoffclient = car.DriveSeat.LowOffClient
local highoffclient = car.DriveSeat.HighOffClient
local depthl = lowonclient.flange.Depth
local depthh = highonclient.flange.Depth
local depthl2 = lowoffclient.flange.Depth
local depthh2 = highoffclient.flange.Depth
local influencevolume = 0
local influencevolume2 = 0
local influence = 0
local load = 0

lowonclient:Play()
lowoffclient:Play()
highonclient:Play()
highoffclient:Play()

script.Parent.Values.Throttle.Changed:Connect(function(ok)
if script.Parent.Values.Gear.Value == 0 then
else
if script.Parent.Values.Throttle.Value == 1 then
lowonclient.flange.depthinfluence.Value = 1
highonclient.flange.depthinfluence.Value = 1
lowoffclient.flange.depthinfluence.Value = 1
highoffclient.flange.depthinfluence.Value = 1
end
end
end)

while wait() do
lowonserver:Stop()
lowoffserver:Stop()
highonserver:Stop()
highoffserver:Stop()
car.SoundUpdate:FireServer(highonclient.Volume,highonclient.flange.depth,highonclient.Pitch,lowonclient.Volume,lowonclient.flange.Depth,lowonclient.Pitch, highoffclient.Volume,highoffclient.flange.depth,highoffclient.Pitch,lowoffclient.Volume,lowoffclient.flange.Depth,lowoffclient.Pitch)
if script.Parent.Values.Throttle.Value == 1 then
if load<1-LoadSpeed then
load = load +LoadSpeed
else
load = 1
end
else
if load>LoadSpeed then
load = load -LoadSpeed
else
load = 0
end
end
influencevolume = (1+TransitionOffset)-((script.Parent.Values.RPM.Value/HighRPM)*TransitionInfluence)
influence = 1-(script.Parent.Values.RPM.Value/HighRPM)
--print(influencevolume2)
if influencevolume>0 and influencevolume<1 then
influencevolume2 = influencevolume
else
if influencevolume>0.5 then
influencevolume2 = 1
end
if influencevolume<0.5 then
influencevolume2 = 0
end
end
lowonclient.Volume = ((((influencevolume2)*lowonclient.VolumeInfluence.Value)*load)+(((-load)+1)*(lowonclient.VolumeInfluence.Value*0.25)))*load
highonclient.Volume = (((-influencevolume2) +1)*highonclient.VolumeInfluence.Value)*load
lowonclient.Pitch = lowonclient.SetRev.Value*((-influence) +1)
highonclient.Pitch = highonclient.SetRev.Value*((-influence) +1)
lowonclient.flange.Depth = depthl*lowonclient.flange.depthinfluence.Value
highonclient.flange.Depth = depthh*highonclient.flange.depthinfluence.Value
if lowonclient.flange.depthinfluence.Value>lowonclient.flange.depthdecreasespeed.Value then
lowonclient.flange.depthinfluence.Value = lowonclient.flange.depthinfluence.Value -lowonclient.flange.depthdecreasespeed.Value
else
lowonclient.flange.depthinfluence.Value = 0
end
if highonclient.flange.depthinfluence.Value>highonclient.flange.depthdecreasespeed.Value then
highonclient.flange.depthinfluence.Value = highonclient.flange.depthinfluence.Value -highonclient.flange.depthdecreasespeed.Value
else
highonclient.flange.depthinfluence.Value = 0
end

lowoffclient.Volume = ((((influence)*lowoffclient.VolumeInfluence.Value)*load)+(((-load)+1)*(lowoffclient.VolumeInfluence.Value*0.25)))*((-load) +1)
highoffclient.Volume = (((-influence) +1)*highoffclient.VolumeInfluence.Value)*((-load) +1)
lowoffclient.Pitch = lowoffclient.SetRev.Value*((-influence) +1)
highoffclient.Pitch = highoffclient.SetRev.Value*((-influence) +1)
lowoffclient.flange.Depth = depthl*lowoffclient.flange.depthinfluence.Value
highoffclient.flange.Depth = depthh*highoffclient.flange.depthinfluence.Value
if lowoffclient.flange.depthinfluence.Value>lowoffclient.flange.depthdecreasespeed.Value then
lowoffclient.flange.depthinfluence.Value = lowoffclient.flange.depthinfluence.Value -lowoffclient.flange.depthdecreasespeed.Value
else
lowonclient.flange.depthinfluence.Value = 0
end
if highoffclient.flange.depthinfluence.Value>highoffclient.flange.depthdecreasespeed.Value then
highoffclient.flange.depthinfluence.Value = highoffclient.flange.depthinfluence.Value -highoffclient.flange.depthdecreasespeed.Value
else
highoffclient.flange.depthinfluence.Value = 0
end
end
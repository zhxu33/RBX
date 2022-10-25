--Overheat by RikOne2
--V1.2
--[[INSTALL PROCESS]]--
-- Place the brick in the body group, where your radiator would be, and place the "Temperature" GUI in the plugin folder!
-- This plugin is Filtering Enabled compatible


script:WaitForChild("Celsius")
script:WaitForChild("Blown")
local car = script.Parent.Parent.Car.Value
local radiator = car.Body.Plugins.Smoke
local mouse = game.Players.LocalPlayer:GetMouse()
local handler = car.EngineOverheat
local FE = workspace.FilteringEnabled

--Tune
OverheatSpeed = .2 --How fast the car will overheat
CoolingEfficiency = .05 --How fast the car will cool down
RunningTemp = 75 --In degrees

Fan = true --Cooling fan
FanTemp = 120 --At what temperature the cooling fan will activate
FanTempAlpha = 100 --At what temperature the cooling fan will deactivate
FanSpeed = .07 --How fast the car will cool down
FanVolume = .5 --Sound volume

BlowupTemp = 135 --At what temperature the engine will blow up

GUI = true --GUI temperature gauge


--Leave this
Heat = 0

if GUI then
	script.Parent.Visible = true
else
	script.Parent.Visible = false
end

--easter egg
mouse.KeyDown:connect(function(key)
	if key=="k" and script.Blown.Value == false then
		Heat = Heat+1
	end
end)

if not FE then
	
radiator.Oil.Enabled = false
radiator.Antifreeze.Enabled = false
radiator.Liquid.Volume = 0
radiator.Fan:Play()
radiator.Fan.Pitch = 1+FanSpeed
radiator.Steam:Play()
radiator.Liquid:Play()
script.Blown.Value = false

while wait(.2) do
	if Heat > FanTemp and Fan == true then
		FanCool = -FanSpeed
		radiator.Fan.Volume = FanVolume
	elseif Heat < FanTempAlpha then
		FanCool = 0
		radiator.Fan.Volume = 0
	end
	
	Load = ((script.Parent.Parent.Values.Throttle.Value*script.Parent.Parent.Values.RPM.Value*10*OverheatSpeed)/math.ceil((car.DriveSeat.Velocity.magnitude+.0000001)/100)/75000)-CoolingEfficiency
	Heat = math.max(RunningTemp,(Heat+Load)+FanCool)
	
	if Heat >= BlowupTemp then
		Heat = BlowupTemp
		radiator.Break:Play()
		radiator.Liquid.Volume = .5
		radiator.Oil.Enabled = true
		radiator.Antifreeze.Enabled = true
		script.Parent.Parent.IsOn.Value = false
		script.Blown.Value = true
	elseif Heat >= BlowupTemp-10 then
		radiator.Smoke.Transparency = NumberSequence.new((BlowupTemp-Heat)/10,1)
		radiator.Smoke.Enabled = true
		radiator.Steam.Volume = math.abs(((BlowupTemp-Heat)-10)/10)
	else
		radiator.Smoke.Enabled = false
		radiator.Steam.Volume = 0
	end
	
	script.Celsius.Value = Heat
	script.Parent.Temp.Text = math.floor(Heat).."°c"
	script.Parent.Temp.TextColor3 = Color3.fromRGB(255,255-((Heat-FanTemp)*10),255-((Heat-FanTemp)*10))
end

else

	handler:FireServer("Initialize",FanSpeed)
while wait(.2) do
	
	if Heat > FanTemp and Fan == true then
		FanCool = -FanSpeed
		handler:FireServer("FanVolume",FanVolume)
	else
		FanCool = 0
		handler:FireServer("FanVolume",0)
	end
	
	Load = ((script.Parent.Parent.Values.Throttle.Value*script.Parent.Parent.Values.RPM.Value*10*OverheatSpeed)/math.ceil((car.DriveSeat.Velocity.magnitude+.0000001)/100)/75000)-CoolingEfficiency
	Heat = math.max(RunningTemp,(Heat+Load)+FanCool)
	
	if Heat >= BlowupTemp then
		Heat = BlowupTemp
		handler:FireServer("Blown")
		script.Parent.Parent.IsOn.Value = false
		script.Blown.Value = true
	elseif Heat >= BlowupTemp-10 then
		handler:FireServer("Smoke",true,BlowupTemp,Heat)
	else
		handler:FireServer("Smoke",false,BlowupTemp,Heat)
	end
	
	script.Celsius.Value = Heat
	script.Parent.Temp.Text = math.floor(Heat).."°c"
end
end
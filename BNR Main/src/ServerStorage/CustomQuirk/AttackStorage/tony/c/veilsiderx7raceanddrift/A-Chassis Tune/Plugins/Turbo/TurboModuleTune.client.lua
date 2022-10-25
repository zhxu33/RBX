--Tune--
local StockHP = 757	--Power output desmos: https://www.desmos.com/calculator/wezfve8j90 (does not come with torque curve)
local TurboCount = 1	--(1 = SingleTurbo),(2 = TwinTurbo),(if bigger then it will default to 2 turbos)
local TurboSize = 70	--Size in Millimeters(if you have 2 turbos then its for each turbo)
local WasteGatePressure = 20	--Max PSI for each turbo (if twin and running 10 PSI, thats 10PSI for each turbo)
local CompressionRatio = 9/1	--Compression of your car (look up the compression of the engine you are running)
local AntiLag = true	--if true basically keeps the turbo spooled up so less lag

--GUI setup--
local BoostGaugeVisible = true -- true=visible false=not visible

--Values--
local car = script.Parent.Parent.Car.Value
local FE = workspace.FilteringEnabled
local _Tune = require(car["A-Chassis Tune"])
local Redline = _Tune.Redline
local maxPSI = WasteGatePressure
local totalPSI = 0
local actualPSI = 0
local CR = CompressionRatio
local TC = TurboCount
local handler = car:WaitForChild("UpdateAndMake")
local Values = script.Parent.Parent.Values
local Throttle = script.Parent.Parent.Values.Throttle.Value
local BOVFix = (1 - Throttle)
local tester = 1
local BOVact = 0
local BOVact2 = 0
local Whistle = car.DriveSeat:WaitForChild("Whistle")
local BOV = car.Body.BOVPart:WaitForChild("BOV")
local BOV2 = car.Body.BOVPart2:WaitForChild("BOV")
Whistle:Play()




script.Parent.Parent.Values.RPM.Changed:connect(function()
	--When In Neutral
	if Values.Horsepower.Value == 0 then
		totalPSI = totalPSI + ((((((Values.RPM.Value*(Values.Throttle.Value*1.2)/Redline)/9)-0.053)*(69/TurboSize))/WasteGatePressure)*15)
		if totalPSI < 0.05 then
			totalPSI = 0.05
		end
		if totalPSI > 2 then
			totalPSI = 2
		end
		--TEST
		
	end
	--When Driving
	if Values.Horsepower.Value > 0 then
		totalPSI = totalPSI + ((((((Values.Horsepower.Value*(Values.Throttle.Value*1.2)/_Tune.Horsepower)/9)-0.063)*69/TurboSize)/WasteGatePressure)*15)
		if totalPSI < 0.05 then
			totalPSI = 0.05
		end
		if totalPSI > 2 then
			totalPSI = 2
		end
		--TEST
		
	end
	
	
	
	actualPSI = totalPSI/2
	

	if FE then
		local BP = totalPSI
		
		handler:FireServer(totalPSI,actualPSI,Throttle,BOVFix)
	else
		local Throttle2 = Throttle
		local W = car.DriveSeat:WaitForChild("Whistle")
		local B = car.DriveSeat:WaitForChild("BOV")
		if Throttle2 < 0 then
			Throttle2 = 0
		end
		W.Pitch = (totalPSI)
		W.Volume = totalPSI*1.5
		B.Pitch = 1 - (-totalPSI/20)
		B.Volume = 10
		
	end
	
end)


--BOV--
script.Parent.Parent.Values.RPM.Changed:connect(function()
	local t = 0
	t = (totalPSI*20)
	BOVact = math.floor(t)
end)
script.Parent.Parent.Values.RPM.Changed:connect(function()
	wait(0.1)
	local t2 = 0
	t2 = (totalPSI*20)
	BOVact2 = math.floor(t2)
end)
script.Parent.Parent.Values.RPM.Changed:connect(function()
	if BOVact > BOVact2 then
		if BOV.IsPlaying == false then
			BOV:Play()
			
		end
	end
	if BOVact < BOVact2 then
		if BOV.IsPlaying == true then
			BOV:Stop()
			
		end
	end
end)


--Engine--
script.Parent.Parent.Values.RPM.Changed:connect(function()
local HP = StockHP
local Horsepower = _Tune.Horsepower
local Boost = (((totalPSI/2)*WasteGatePressure)*(CompressionRatio/10)*TurboCount)
local B2 = (Boost)/7.5
local B3 = HP*B2
local B4 = B3/2

_Tune.Horsepower = (HP) + (B4)

end)

--Turbo Gauge GUI--

local fix = 0


script.Parent.Parent.Values.RPM.Changed:connect(function()
	
	script.Parent.BAnalog.Visible = BoostGaugeVisible
	script.Parent.Background.Visible = BoostGaugeVisible
	script.Parent.DontTouch.Visible = BoostGaugeVisible
	script.Parent.Num.Visible = BoostGaugeVisible
	
	
	local turbo = ((totalPSI/2)*WasteGatePressure)
	local turbo2 = WasteGatePressure
	
	fix =  -turbo2 + turbo*2
	
	script.Parent.BAnalog.Rotation= 110 + (totalPSI/2)*220
	
	
script.Parent.Num.N1.TextLabel.Text = math.floor(WasteGatePressure*(3/3))
script.Parent.Num.N2.TextLabel.Text = math.floor(WasteGatePressure*(2/3))
script.Parent.Num.N3.TextLabel.Text = math.floor(WasteGatePressure*(1/3))
script.Parent.Num.N4.TextLabel.Text = math.floor(WasteGatePressure*(-1/3))
script.Parent.Num.N5.TextLabel.Text = math.floor(WasteGatePressure*(-2/3))
script.Parent.Num.N6.TextLabel.Text = math.floor(WasteGatePressure*(-3/3))


end)

















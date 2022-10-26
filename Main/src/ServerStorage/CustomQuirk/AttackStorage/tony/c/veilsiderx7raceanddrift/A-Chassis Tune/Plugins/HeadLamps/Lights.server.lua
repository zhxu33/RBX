wait(1) --To avoid everything just burning and crashing down when the car is inserted, can be deleted if you want

--Variables
local car = script.Parent.Parent.Car.Value
local button = script.Parent

--Front
--Main
local f = car.Body.Lights.F
--Light Parts
local fa = f.A						--Front A Light Part
local fb = f.B						--Front B Light Part
local fc = f.C						--Front C Light Part
local fd = f.D						--Front D Light Part
--Beams
local ba = fa.light1				--Front A Lightbeam
local bb = fb.light1				--Front B Lightbeam
local bc = fc.light1				--Front C Lightbeam
local bd = fd.light1				--Front D Lightbeam
--Dynaminc Lights
local fl1 = fa.Light				--Front A Light
local fl2 = fc.Light				--Front C Light

--Rear
--Main
local r = car.Body.Lights.R
--Light Parts
local ra = r.A						--Rear A Light Part
local rb = r.B						--Rear B Light Part
local rc = r.C						--Rear C Light Part
local rd = r.D						--Rear D Light Part
--Dynamic Lights
local rl1 = ra.Light				--Front A Light
local rl2 = rc.Light				--Front C Light


--Main function
button.MouseButton1Click:connect(function()	
	if script.Parent.On.Value == false then
		
		--Front
		fa.Material = "Neon"
		fb.Material = "Neon"
		fc.Material = "Neon"
		fd.Material = "Neon"
		ba.Enabled = true
		bb.Enabled = true
		bc.Enabled = true
		bd.Enabled = true
		fl1.Enabled = true
		fl2.Enabled = true
		
		--Rear
		ra.Material = "Neon"
		rb.Material = "Neon"
		rc.Material = "Neon"
		rd.Material = "Neon"
		rl1.Enabled = true
		rl2.Enabled = true

		script.Parent.On.Value = true
	--Turn lights OFF
	elseif script.Parent.On.Value == true then
				
		--Front
		fa.Material = "SmoothPlastic"
		fb.Material = "SmoothPlastic"
		fc.Material = "SmoothPlastic"
		fd.Material = "SmoothPlastic"
		ba.Enabled = false
		bb.Enabled = false
		bc.Enabled = false
		bd.Enabled = false
		fl1.Enabled = false
		fl2.Enabled = false
		
		--Rear
		ra.Material = "SmoothPlastic"
		rb.Material = "SmoothPlastic"
		rc.Material = "SmoothPlastic"
		rd.Material = "SmoothPlastic"
		rl1.Enabled = false
		rl2.Enabled = false
		
		script.Parent.On.Value = false
	end
end)

local Character = script.Parent
local MovingHead = Character.FHead
local Motor6D = MovingHead.Head

while true do
	local delays = math.random(1.50, 3.00)
	wait(delays)
	local choose = math.random(0, 1)
	if choose == 0 then
		Motor6D.C1 = CFrame.new(0, -0.2, 0)*CFrame.Angles(0, 0, 0.5)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, -0.2, 0)*CFrame.Angles(0, 0, 0.5)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, -0.2, 0)*CFrame.Angles(0, 0, 0.5)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.015)
		Motor6D.C1 = CFrame.Angles(0, 0.6, -0.5)
		wait(.05)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
	elseif choose == 1 then
		Motor6D.C1 = CFrame.new(0, -0.2, 0)*CFrame.Angles(0, 0, 0.7)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.1)
		Motor6D.C1 = CFrame.new(0, -0.1, 0)*CFrame.Angles(0, 0, -0.7)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, -0.1, 0)*CFrame.Angles(0, 0, -0.7)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, -0.1, 0)*CFrame.Angles(0, 0, -0.7)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
		wait(.015)
		Motor6D.C1 = CFrame.new(0, -0.2, 0)*CFrame.Angles(0, 0, -0.9)
		wait(.1)
		Motor6D.C1 = CFrame.new(0, 0, 0)*CFrame.Angles(0, 0, 0)
	end
end

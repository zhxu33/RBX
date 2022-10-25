local NPCs = workspace:WaitForChild("NPCs")
wait(1)
for i,NPCSpawn in pairs(NPCs:GetChildren()) do
	local NPCFolder = game.ServerStorage.NPCs
	local NewNpc = NPCFolder:FindFirstChild(NPCSpawn.Name):Clone()
	NewNpc.HumanoidRootPart.CFrame = NPCSpawn.CFrame
	NewNpc.Parent = NPCs
	NPCSpawn:Destroy()
	for i,v in pairs(NewNpc:GetDescendants()) do
	if v:IsA("BasePart") or v:IsA("UnionOperation") then
		if v.Anchored == false then
		game:GetService("PhysicsService"):SetPartCollisionGroup(v,"n")
		v:SetNetworkOwner(nil)
		v.CanCollide = false
			end
		end
	end
end

local UnstuckNpcs = {}
local function AntiFling()
for i,npc in pairs(NPCs:GetChildren()) do
	local coo = coroutine.wrap(function()
	local RootPart = npc:FindFirstChild("HumanoidRootPart")
	local Humanoid = npc:FindFirstChild("Humanoid")
	if RootPart and Humanoid.Health > 0 then
	for i,tableValue in pairs(UnstuckNpcs) do
	if tableValue == npc then return end
	end
	if RootPart.Anchored == true or Humanoid.WalkSpeed == 0  or Humanoid.JumpPower == 0 then
	table.insert(UnstuckNpcs, npc)
	local Unstuck = false
	   for i=1, 50 do wait(.1)
		if RootPart.Anchored == false and Humanoid.WalkSpeed ~= 0  and Humanoid.JumpPower ~= 0 then
			Unstuck = false
		end
	end
	for i,tableValue in pairs(UnstuckNpcs) do
		if tableValue == npc then
		table.remove(UnstuckNpcs, i)
		end
	end
	if Unstuck == false then
		RootPart.Anchored = false
		Humanoid.WalkSpeed = 18
		Humanoid.JumpPower = 50
		Humanoid.PlatformStand = false
	end
	end
	if RootPart.RotVelocity.magnitude >= 50 or (RootPart.Velocity-Vector3.new(0, RootPart.Velocity.y,0)).magnitude >= 500 then
	RootPart.RotVelocity = Vector3.new()
	RootPart.Velocity = Vector3.new()
	wait(0.5)
	if Humanoid.Health > 0 then
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
	end
	end
	end)
	coo()
end
end

local coo = coroutine.wrap(function()
while wait(.5) do
	AntiFling()
end
end)
coo()

while wait(1800) do
for _, npc in pairs(NPCs:GetChildren()) do
	npc:BreakJoints()
end
end
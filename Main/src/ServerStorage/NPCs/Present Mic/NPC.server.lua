local Humanoid = script.Parent.Humanoid
local Character = script.Parent
local HumanoidRootPart = Character.HumanoidRootPart
local OriginalCFrame = CFrame.new(HumanoidRootPart.Position)
local Stamina = script.Parent.Stamina
local MaxStamina = script.Parent.MaxStamina
local Target = nil
local Damage = 2500
local Stunned = false
local HitSound = Instance.new("Sound", HumanoidRootPart)
HitSound.SoundId = "rbxassetid://232210146"
HitSound.Volume = 0.2
local CombatType = 1
local RespawnNPC = require(game.ReplicatedStorage.Modules.NPCs.RespawnNPC)
local NPCReward = require(game.ReplicatedStorage.Modules.NPCs.NPCReward)
local DmgFunction = game.ReplicatedStorage:WaitForChild("DamageFunction")
local reward = game.ReplicatedStorage.Remotes.RewardPane
local PunchAnim = {2313015622,2313016464,2313017174,2313014821}
local HvyStunnedAnim = Humanoid:LoadAnimation(script.heavystunned)
local Stun = Humanoid:LoadAnimation(script.stunned)
local VoiceAnim = Humanoid:LoadAnimation(script.Voice) 
local TweenService = game:GetService("TweenService")

local VoiceSound = Instance.new("Sound", HumanoidRootPart)
VoiceSound.SoundId = "rbxassetid://1398882124"
local BigVoice = script.BigVoice
local Weld = Instance.new("Weld" ,BigVoice.main)
Weld.Part0 = BigVoice.main
Weld.Part1 = Character.Head

local function ComplicatedMistake()
	local newBind = Instance.new("BindableEvent")
	newBind.Name  = "Aggro"
	newBind.Event:Connect(function(newTarget)
		Target = newTarget.PrimaryPart or Target
	end)
	newBind.Parent = Character
end
ComplicatedMistake()

HumanoidRootPart.ChildAdded:Connect(function(Child)
	if Child == "Light" then
		Child:Destroy()
	elseif Child == "Heavy" then
		Stunned = true
		local asdfg = false
		HvyStunnedAnim:Play()
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		for i = 1,3 do
			if asdfg == true or not HumanoidRootPart:FindFirstChild("Heavy") then
				break
			else
				wait(0.25) -- stuntime
			end
		end			
		if HumanoidRootPart:FindFirstChild("Heavy") then
			HumanoidRootPart:FindFirstChild("Heavy"):Destroy()
		end

		HvyStunnedAnim:Stop()
		asdfg = true
		Humanoid.WalkSpeed = 75
		Humanoid.JumpPower = 50
		Stunned = false
	end
	if Humanoid.WalkSpeed ~= 0 and Humanoid.WalkSpeed ~= 75 then
		Humanoid.WalkSpeed = 75
	end
end)


local coro = coroutine.wrap(function()
	while wait(.5) do
		if Target and (Target.Position - HumanoidRootPart.Position).magnitude < 100 and Humanoid.Health > 0 and Stunned == false then
			VoiceAnim:Play()
			VoiceSound.Volume = 0.5
			VoiceSound:Play()
			for i,v in pairs(script.BigVoice:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("SurfaceLight") or v:IsA("SpotLight") then
					v.Enabled = true
				end
			end
			local clone = Instance.new("Part", script)
			clone.Anchored = false
			clone.CanCollide = false
			clone.Size = Vector3.new(44.1,30.95,200)
			clone.Transparency = 1
			local PlayersHitted = {}
			clone.Touched:connect(function(hit)
				if hit.Parent.Name ~= Character.Name and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 and hit.Parent.Parent.Name ~= "NPCs" then
					for i,tableValue in pairs(PlayersHitted) do
						if tableValue == hit.Parent then return end
					end
					table.insert(PlayersHitted, hit.Parent)
					local coro = coroutine.wrap(function()
						wait()
						table.remove(PlayersHitted, 1, hit.Parent)	
					end)
					coro()
					local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
					local HRT = hit.Parent:FindFirstChild("HumanoidRootPart")
					DmgFunction:Fire(Character, hum, Damage)
				end
			end)
			repeat wait()
				clone.CFrame = HumanoidRootPart.CFrame * CFrame.new(2,0,-98)
			until Humanoid.Health < 1 or Target == nil or Target.Parent == nil or Stunned == true or Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 
			clone:Destroy()
			for i,v in pairs(script.BigVoice:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("SurfaceLight") or v:IsA("SpotLight") then
					v.Enabled = false
				end
			end
			VoiceSound:Stop()
			wait()
			VoiceAnim:Stop()
		end
	end
end)
coro()


local PlayersHittedFolder = Character:WaitForChild("PlayersHitted")
Humanoid.Died:Connect(function()
	Stunned = true
	RespawnNPC:Respawn(Character,OriginalCFrame)
	for i,PlayersHitted in pairs(PlayersHittedFolder:GetChildren()) do
		local coro = coroutine.wrap(function()
			if PlayersHitted.Value/Humanoid.MaxHealth >= .1 and game.Players:FindFirstChild(PlayersHitted.Name) then
				NPCReward.Reward(PlayersHitted.Name,Character.Name)
			end
		end)
		coro()
	end
end)

local Walking = false
while wait(.5) do
	pcall(function()
		if (HumanoidRootPart.Position - OriginalCFrame.p).magnitude > 500 then
			HumanoidRootPart.CFrame = OriginalCFrame; Character:SetAttribute("Target", 0)
			Target = nil
		end
		if Target == nil then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, OriginalCFrame.p)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						break
					end
					Humanoid:MoveTo(Point.Position)
					Humanoid.MoveToFinished:wait()
					if Point.Action == Enum.PathWaypointAction.Jump  then
						Humanoid.Jump = true
					end
				end
			elseif Path.Status == Enum.PathStatus.NoPath then
				Humanoid:MoveTo(OriginalCFrame.p)
			end
		elseif Target.Parent == nil then 
			Target = nil
		elseif (Target.Position - OriginalCFrame.p).magnitude > 500 then
			Character:SetAttribute("Target", 0)
			Target = nil
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
			Walking = false
			wait()
			Walking = true
			Humanoid.JumpPower = 100
			local PathFindingService = game:GetService("PathfindingService")
			local Path = PathFindingService:FindPathAsync(HumanoidRootPart.Position, Target.Position)
			local Points = Path:GetWaypoints()
			if Path.Status == Enum.PathStatus.Success then 
				for i,Point in pairs(Points) do
					if Walking == false then
						return
					end
					Humanoid:MoveTo(Point.Position)
					if Point.Action == Enum.PathWaypointAction.Jump  then
						Humanoid.Jump = true
					end
				end
			elseif Path.Status == Enum.PathStatus.NoPath then
				Humanoid:MoveTo(Target.Position)
			end
		elseif Target.Parent:FindFirstChildOfClass("Humanoid").Health < 1 then
			Target = nil
		end
	end)
end
-- // Services
local BadgeService  = game:GetService("BadgeService")
local replicated    = game:GetService("ReplicatedStorage")
local debris        = game:GetService("Debris")
local playerService = game:GetService("Players")

-- // directories
local remotes = replicated.Remotes

-- // events
local playerEvent = remotes.Player
local maxExp      = remotes.MaxExp

-- // Variables
local BadgeId      = 1765731725
local MaxLevel     = 15000

local userData      = workspace.S1c2R5i66p5t5s51.PlayerData
local levelSparkles = script.LevelSparkles

-- // Extra Yellows
local Yellows = {
	BrickColor.new("Yellow flip/flop").Color,
	BrickColor.new("New Yeller").Color,
	BrickColor.new("Tr. Yellow").Color,
	BrickColor.new("Cool yellow").Color,
	BrickColor.new("Fire Yellow").Color,
	BrickColor.new("Light yellow").Color,
	BrickColor.new("Bright yellow").Color,
	BrickColor.new("Pastel yellow").Color,
	BrickColor.new("Warm yellowish orange").Color,
}

-- // functions
-- // get's the user's data folder
local function getUserData(Username)
	local dataFile = userData:FindFirstChild(Username)
	local timeOut  = tick()
	
	if not dataFile then
		repeat
			task.wait(.1)
			dataFile = userData:FindFirstChild(Username)
		until dataFile or tick() > timeOut + 30
	end
		
	if not dataFile:FindFirstChild("Loaded") then
		repeat
			task.wait(.1)
		until dataFile:FindFirstChild("Loaded")
	end
	
	assert(dataFile, "User's datafile was not found within set duration.")
	
	return dataFile
end

-- // returns the exp required to level
local function getMaxExp(user)
	local dataFile      = getUserData(user)
	local ExpMultiplier = dataFile:WaitForChild("ExpMultiplier")
	local Level         = dataFile:WaitForChild("Level")
	
	return 200*Level.Value/ExpMultiplier.Value
end

-- // levels players based on exp
playerEvent.OnServerEvent:Connect(function(Player)
	local dataFile = getUserData(Player.Name)

	local MaxExp        = getMaxExp(Player.Name)
	local Level         = dataFile:WaitForChild("Level")
	local Exp           = dataFile:WaitForChild("Experience")
	local StatPoints    = dataFile:WaitForChild("StatPoints")
	
	local expCon
	local levelCon
	
	-- // appropriately calculates exp to levels
	local isRunning = false
	expCon = Exp:GetPropertyChangedSignal("Value"):Connect(function()
		if Exp.Value < MaxExp or Level.Value >= MaxLevel then return end
		if isRunning then return end; isRunning = true
		
		repeat
			Level.Value      += 1
			StatPoints.Value += 3
			Exp.Value        -= MaxExp
			
			if Level.Value >= MaxLevel and Exp.Value >= MaxExp then
				Exp.Value = MaxExp
				expCon:Disconnect()
				break
			end
			
			MaxExp = getMaxExp(Player.Name)
			task.wait(.05)
		until Exp.Value < MaxExp or Level.Value >= MaxLevel
		
		isRunning = false
	end)
	
	-- // Updates levels with effect
	local isRunning = false
	levelCon = Level:GetPropertyChangedSignal("Value"):Connect(function()
		if isRunning then return end; isRunning = true
		
		if (Player.Character and Player.Character.Parent) then
			Player.Character.Humanoid.Health = Player.Character.Humanoid.MaxHealth
		end
		
		local LevelSound = Instance.new("Sound", Player.Character.HumanoidRootPart)
		LevelSound.Volume = 0.5
		LevelSound.SoundId = "rbxassetid://341542294"
		LevelSound:Play()
		debris:AddItem(LevelSound, 3)

		for _, child in pairs(Player.Character:GetChildren()) do
			if child:IsA("MeshPart") then
				local sparkles  = levelSparkles:Clone()
				sparkles.Color  = ColorSequence.new(Yellows[math.random(1, #Yellows)])
				sparkles.Parent = child
				debris:AddItem(sparkles, 3)
			end
		end
		
		if Level.Value >= 15000 then
			Level.Value = 15000
			levelCon:Disconnect()
		end
		
		isRunning = false
	end)
	
	local hasLeft
	hasLeft = Player.AncestryChanged:Connect(function(self, parent)
		if not parent then
			expCon:Disconnect()
			levelCon:Disconnect()
			hasLeft:Disconnect()
		end
	end)
end)

maxExp.OnInvoke = function(Player) return getMaxExp(Player.Name) end
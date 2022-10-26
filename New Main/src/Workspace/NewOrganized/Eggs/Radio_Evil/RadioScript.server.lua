local TweenService = game:GetService("TweenService")

local RadioPart = script.Parent
local MusicPlayer = RadioPart.Music
local Sound2 = RadioPart.Sound2
local CurrentTween

local StartCFrame = CFrame.new(1703.32593, 2174.45581, -2201.22241, -0.852869034, -0.347602218, 0.389598787, -0.173647255, 0.892539203, 0.416197866, -0.492403328, 0.287309498, -0.821579218)

local LeftCFrame = CFrame.new(1703.2738, 2174.58936, -2201.17896, -0.819328129, -0.420612484, 0.389599264, -0.25077641, 0.87400949, 0.416198313, -0.515570164, 0.243300691, -0.821580112)
local RightCFrame = CFrame.new(1703.2738, 2174.58936, -2201.17896, -0.879919171, -0.271947145, 0.389598906, -0.09519656, 0.904277503, 0.416197956, -0.465488881, 0.32913205, -0.821579456)

local MusicList = {
	"rbxassetid://6158800684",
	"rbxassetid://458444867",
	"rbxassetid://8123924588",
	"rbxassetid://2550867790",
	"rbxassetid://5120035279",
	"rbxassetid://3189444218"
}

local Selected = math.random(1, #MusicList)
local Side = 0

local Selector = {
	[0] = LeftCFrame,
	[1] = RightCFrame
}

MusicPlayer.Played:Connect(function()
	if CurrentTween then
		CurrentTween:Cancel()
	end
	RadioPart.CFrame = StartCFrame
	repeat
		CurrentTween = TweenService:Create(RadioPart, TweenInfo.new(.1), {CFrame = Selector[Side]})
		CurrentTween:Play() CurrentTween.Completed:Wait()
		if Side == 1 then Side = 0 else Side = 1 end
		wait(.2)
		RadioPart.CFrame = StartCFrame
		wait(.2)
	until not MusicPlayer.IsPlaying
end)

MusicPlayer.Resumed:Connect(function()
	if CurrentTween then
		CurrentTween:Cancel()
	end
	RadioPart.CFrame = StartCFrame
	repeat
		CurrentTween = TweenService:Create(RadioPart, TweenInfo.new(.1), {CFrame = Selector[Side]})
		CurrentTween:Play() CurrentTween.Completed:Wait()
		if Side == 1 then Side = 0 else Side = 1 end
		wait(.2)
		RadioPart.CFrame = StartCFrame
		wait(.2)
	until not MusicPlayer.IsPlaying
end)

MusicPlayer.Stopped:Connect(function()
	if CurrentTween then
		CurrentTween:Cancel()
	end
	RadioPart.CFrame = StartCFrame
end)

function AttackPlayer(Target)
	
	MusicPlayer:Pause()
	RadioPart.CFrame = StartCFrame
	wait(1)
	
	local tween
	tween = TweenService:Create(RadioPart, TweenInfo.new(.1, Enum.EasingStyle.Linear), {CFrame = Target.Head.CFrame})
	tween:Play() tween.Completed:Wait()
	Target.Head:Destroy()
	Sound2:Play()
	tween = TweenService:Create(RadioPart, TweenInfo.new(.1, Enum.EasingStyle.Linear), {CFrame = StartCFrame})
	tween:Play() tween.Completed:Wait()
	
	wait(1)
	MusicPlayer:Resume()
	
end

RadioPart.ClickDetector.MouseClick:Connect(function(PLR)
	
	if MusicPlayer.IsPlaying and PLR.Character and PLR.Character:FindFirstChild("Head") and PLR.Character:FindFirstChild("Humanoid") and PLR.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
		AttackPlayer(PLR.Character)
	end
	
end)

while true do
	MusicPlayer:Stop()
	MusicPlayer.TimePosition = 0
	MusicPlayer.SoundId = MusicList[Selected]
	MusicPlayer.Loaded:Wait()
	MusicPlayer:Play()
	MusicPlayer.Ended:Wait()
	local New
	repeat
		New = math.random(1, #MusicList)
	until Selected ~= New
	Selected = New
	wait(5)
end
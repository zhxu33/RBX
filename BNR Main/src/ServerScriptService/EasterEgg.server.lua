local Buttons = game.Workspace.Buttons
local ZStatue = game.Workspace["Head Dev Statue"]
local Pressed = 0
---------------------------------------
local EveryButton = Buttons:GetChildren()
for i=1,#EveryButton do
	EveryButton[i].ClickDetector.MouseClick:Connect(function()
		local Button = EveryButton[i]
		Pressed=Pressed+1
		Button.ClickDetector:Destroy()
		Button.Material = "Neon"
		Button.Transparency = 0.3
		game.TweenService:Create(Button, TweenInfo.new(1), {Transparency = 0, Color = Color3.fromRGB(255, 255, 255)}):Play()
	end)
end

repeat wait(1) until Pressed == #EveryButton
print("Easter Egg Activated!")
for v,parts in pairs(ZStatue:GetDescendants()) do
	if parts.Name ~= "HumanoidRootPart" then
		if parts:IsA("BasePart") then
			parts.Transparency = 0
			if parts.Name ~= "Handle" then
				parts.CanCollide = true
			end
		elseif parts:IsA("TextLabel") then
			parts.TextTransparency = 0
		end
	end
end
wait(5)
for i=1,#EveryButton do
	local delete = coroutine.wrap(function()
		game.TweenService:Create(EveryButton[i], TweenInfo.new(1), {Transparency = 1}):Play()
		wait(1)
		EveryButton[i]:Destroy()
	end)
	delete()
end

local CFrameValue = Instance.new("CFrameValue")
CFrameValue.Value = ZStatue:GetPrimaryPartCFrame()
local TargetCFrame = CFrame.new(374.120148, 337.167633, -819.535034, 0, 1, 0, -1, 0, 0, 0, 0, 1)

CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
	ZStatue:SetPrimaryPartCFrame(CFrameValue.Value)
end)

local tween = game.TweenService:Create(CFrameValue, TweenInfo.new(5), {Value = TargetCFrame})
tween:Play()

tween.Completed:Connect(function()
	CFrameValue:Destroy()
end)

local button = script.Parent
local save = game.ReplicatedStorage.Remotes.Save.ManualSave
local success = game.ReplicatedStorage.Remotes.Save.SaveSuccess
local failure = game.ReplicatedStorage.Remotes.Save.SaveFailed
local player = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
local save_delay = false
local goodsave = false
button.MouseButton1Down:Connect(function()
	if not save_delay  and not goodsave then
		save_delay = true
		save:FireServer()
		success.OnClientEvent:Connect(function(player)
			button.Active = false
			local goal = {}
			goal.ImageTransparency = 1
			local info =  TweenInfo.new(1)
			local tween = ts:Create(button, info, goal)
			goodsave = true		
			tween:Play()
			wait(30)
			button.ImageColor3 = Color3.fromRGB(255,255,255)
			
			local goalReverse = {}
			goalReverse.ImageTransparency = 0
			local infoReverse =  TweenInfo.new(1)
			local tweenReverse = ts:Create(button, infoReverse, goalReverse)
			tweenReverse:Play()
			tweenReverse.Completed:Connect(function()
				goodsave = false
			end)
			button.Active = true
		end)
		wait(2)
		save_delay = false
	end
end)


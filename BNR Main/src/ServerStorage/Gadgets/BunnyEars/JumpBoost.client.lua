local OrigJump = nil
local Jumping = false
game.Players.LocalPlayer.Character.Humanoid.Jumping:Connect(function()
	if Jumping == false and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= 0 then
	Jumping = true
	OrigJump = game.Players.LocalPlayer.Character.Humanoid.JumpPower
	if game.Players.LocalPlayer.Character.Humanoid.JumpPower + 75 >= 200 then
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200
	else
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = game.Players.LocalPlayer.Character.Humanoid.JumpPower + 75
	end
	wait()
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = OrigJump
	Jumping = false
	end
end)
script.Parent.Touched:connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent.Name ~= "NPCs" and hit.Parent.Name ~= "Punching bag" and not hit.Parent:FindFirstChild("Safezone") then
		if script.Parent.Smoke.Enabled == true and script.Parent.Smoke2.Enabled == true then
		local SafeTp = Instance.new("NumberValue", hit.Parent)
		SafeTp.Name = "SafeTp"
		game.Debris:AddItem(SafeTp,2)
		hit.Parent.HumanoidRootPart.CFrame = script.Parent.Parent.Warp2.CFrame * CFrame.new(0,10,-10)
		end
	end
end)
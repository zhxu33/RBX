local waitTime = script.Parent.FrozenTime.Value

while script.Parent and script.Parent.Name == "HumanoidRootPart" do
	wait(waitTime)
	script.Parent.Parent.Humanoid.PlatformStand = false
	script.Parent.Anchored = false
	script.Parent.FrozenTime:Destroy()
	script:Destroy()
end
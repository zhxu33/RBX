TweenService = game:GetService("TweenService")
spininfo = TweenInfo.new(1,Enum.EasingStyle.Linear)

Spin1 = TweenService:Create(script.Parent.Attach,spininfo,{C0=script.Parent.Attach.C0*CFrame.Angles(0,math.rad(120),0)})
Spin2 = TweenService:Create(script.Parent.Attach,spininfo,{C0=script.Parent.Attach.C0*CFrame.Angles(0,math.rad(240),0)})
Spin3 = TweenService:Create(script.Parent.Attach,spininfo,{C0=script.Parent.Attach.C0*CFrame.Angles(0,math.rad(360),0)})

Spin1:Play()
Spin1.Completed:Connect(function()Spin2:Play() end)
Spin2.Completed:Connect(function()Spin3:Play() end)
Spin3.Completed:Connect(function()Spin1:Play() end)
game.ReplicatedStorage.Remotes.Chat.OnClientEvent:Connect(function(Text) 
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", { 
   		Text = Text;
    	Color = Color3.fromRGB(255,255,255); 
    	Font = Enum.Font.SourceSansBold; 
    	FontSize = Enum.FontSize.Size24; 
	 })
end)

game.ReplicatedStorage.Remotes.PunchFire.OnClientEvent:Connect(function(Parent)
	Parent.E:FireServer()
end)

--game.Players.PlayerAdded:Connect(function(Player)
--	local tags = game.ReplicatedStorage.GetTags:InvokeServer(Player)
--	print(tags)
--	if Player:GetRankInGroup(3755220) >= 12 and tags ~= nil and Player ~= game.Players.LocalPlayer then
--		print("Player Added: ", Player.Name)
--		wait()
--		Player:Destroy()
--	end
--end)
--
--if game.Players.LocalPlayer:GetRankInGroup(3755220) < 12 then
--	local debounce = false
--	game:GetService("RunService").RenderStepped:Connect(function()
--		if not debounce then
--			debounce = true
--		    for _, plr in pairs(game.Players:GetPlayers()) do
--				local tags = game.ReplicatedStorage.GetTags:InvokeServer(plr)
--		        if plr:GetRankInGroup(3755220) >= 12 and tags ~= nil and plr ~= game.Players.LocalPlayer then
--					print("Player Loop: ", plr.Name)
--		            wait()
--		            plr:Destroy()
--		        end
--		    end
--			wait(1)
--			debounce = true
--		end
--	end)
--end
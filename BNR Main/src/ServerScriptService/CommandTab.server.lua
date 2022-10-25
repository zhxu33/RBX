local UserMod = require(game.ReplicatedStorage.Modules.KickedPlayers)
game.Players.PlayerAdded:Connect(function(plr)
	for _, v in pairs(UserMod:Fetch()) do
		if plr.Name == v then
			plr:Kick("You have been kicked and banned from this server. Please join a new server.")
		end
	end
end)

local TransparentItems = {}
local Connection = {}
local Connection2 = {}

local SendDataConfirmation = game.ReplicatedStorage.SendDataConfirmation
local function FindPlayer(user)
		for _,v in ipairs(game.Players:GetPlayers()) do
			if v.Name:sub(1,user:len()):lower()==user:lower() then
				return v
			end
		end
		
		return game:GetService("Players"):GetPlayerByUserId(game.Players:GetUserIdFromNameAsync(user))
	end
	
local function TeleportToPlayer(player, PlayerName)
	SendDataConfirmation:Fire(player, "Please wait while we search for ".. PlayerName)
	local TeleportService =  game:GetService("TeleportService")
	local success, Player2Id = pcall(function() return game.Players:GetUserIdFromNameAsync(PlayerName) end)
	if not success then
		SendDataConfirmation:Fire(player, PlayerName .." was unable to be found in the game.")
		print("Unable to find player by id.")
		return
	end
		TeleportService = game:GetService("TeleportService")
		if not TeleportService then
			SendDataConfirmation:Fire(player, PlayerName .." was unable to be found in the game.")
			print("TeleportService or PlayerObj not set.")
			return
		end
		local _, success, errorMessage, placeId, jobId = pcall(function()
			local suc, err, pId, jId
			for i=1,3 do
				suc, err, pId, jId = TeleportService:GetPlayerPlaceInstanceAsync(Player2Id)
				if pId and jId then
					break
				end
			end
			return suc, err, pId, jId
		end)
		if placeId and jobId then
			SendDataConfirmation:Fire(player, PlayerName .." was found on another server. Please wait while we teleport you to their server.")
			TeleportService:TeleportToPlaceInstance(placeId, jobId, player)	
			local TSConnection
			TSConnection = TeleportService.LocalPlayerArrivedFromTeleport:Connect(function(customLoadingScreen, teleportData)
				SendDataConfirmation:Fire(player, "You were successfully teleported to ".. PlayerName .."'s server.")
				TSConnection:Disconnect()
			end)
			local TFConnection
			TFConnection = TeleportService.TeleportInitFailed:Connect(function(plr, teleportResult, errorMessage)
			SendDataConfirmation:Fire(player, "There was an issue teleporting to ".. PlayerName .." due to ".. teleportResult.Name)
			TFConnection:Disconnect()
		end)
	else
		SendDataConfirmation:Fire(player, "There was an issue teleporting to ".. PlayerName ..". Error: ".. errorMessage)
	end
end
		
game.ReplicatedStorage.CommandTab.OnServerEvent:Connect(function(plr, Cmd, InfoTable)
	if Cmd == 1 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Target = InfoTable.Target
			local days = InfoTable.Days
			local Reason = InfoTable.Reason
			if Target ~= nil then
				if Target and days and days >= 0 and days ~= 0 then
					game.ReplicatedStorage.PermItems.Ban:Fire(plr, Target, days, Reason)
				elseif Target and (not days or days < 0) then
					game.ReplicatedStorage.PermItems.Ban:Fire(plr, Target, -1, Reason)
				elseif Target then
					game.ReplicatedStorage.PermItems.Ban:Fire(plr, Target, -1, nil)
				end
			end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 2 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Target = InfoTable.Target
			if Target:GetRankInGroup(3755220) <= plr:GetRankInGroup(3755220) then
				UserMod:Add(Target.Name)
				SendDataConfirmation:Fire(plr, Target.Name .. " has been banned from this server.")
				Target:Kick("You have been kicked and banned from this server. Please join a new server.")
			else
				SendDataConfirmation:Fire(plr, "Unable to server ban " .. Target.Name ..".")
			end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 3 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Target = InfoTable.Target
			game.ReplicatedStorage.PermItems.UnPBan:FireClient(plr, Target)
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 4 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Success = false
			local Target = InfoTable.Target
			for i = 1,#UserMod:Fetch() do
				if string.find(UserMod:Fetch()[i], Target) then
					UserMod:Remove(i)
					Success = true
					SendDataConfirmation:Fire(plr, Target .. " has been unbanned from this server.")
				end
			end
			if not Success then
				SendDataConfirmation:Fire(plr, "Unable to unban ".. Target .. " from this server")
			end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 5 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Target = InfoTable.Target
			if Target and Target.Character then
				local SafeTp = Instance.new("NumberValue", Target.Character)
				SafeTp.Name = "SafeTp"
				game.Debris:AddItem(SafeTp,.5)
				Target.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.new(0,1,3)
				SendDataConfirmation:Fire(plr, "Brought " .. Target.Name .. ".")
			end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 6 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Target = InfoTable.Target
			local Name = InfoTable.Name
			if Target and Target.Character then
				local SafeTp = Instance.new("NumberValue", plr.Character)
				SafeTp.Name = "SafeTp"
				game.Debris:AddItem(SafeTp,.5)
				plr.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame*CFrame.new(0,1,3)
			SendDataConfirmation:Fire(plr, "Teleported to " .. Target.Name .. ".")
			else
				TeleportToPlayer(plr, Name)
			end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 7 then
		if plr:GetRankInGroup(3755220) > 12 then
		local Target = InfoTable.Target
		if Target and Target.Character then
			if not Target.Character:FindFirstChild("StaffShield") then
				local ff = Instance.new("ForceField", Target.Character)
				ff.Name = "StaffShield"
				SendDataConfirmation:Fire(plr, "Applied a forcefield to " .. Target.Name .. ".")
			end
		end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 8 then
		if plr:GetRankInGroup(3755220) > 12 then
		local Target = InfoTable.Target
		if Target.Character:FindFirstChild("StaffShield") then
			Target.Character:FindFirstChild("StaffShield"):Destroy()
			SendDataConfirmation:Fire(plr, "Removed the forcefield from " .. Target.Name .. ".")
		end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 9 then
		if plr:GetRankInGroup(3755220) > 12 then
		local Target = InfoTable.Target
		if Target and Target.Character then
			game.ReplicatedStorage.Watch:FireClient(plr, Target.Character.Humanoid)
		end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 10 then
		if plr:GetRankInGroup(3755220) > 12 then
		if plr.Character then
			game.ReplicatedStorage.Unwatch:FireClient(plr)
		end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 11 then
		if plr:GetRankInGroup(3755220) > 12 then
		local Target = InfoTable.Target
		if Target then
			game.Workspace:FindFirstChild(Target.Name):BreakJoints()
			SendDataConfirmation:Fire(plr, Target.Name .. " has been killed.")
		end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 12 then
		if plr:GetRankInGroup(3755220) > 12 then
		local Target = InfoTable.Target
		Target:LoadCharacter()
		SendDataConfirmation:Fire(plr, Target.Name .. " has been reset.")
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 13 then
		if plr:GetRankInGroup(3755220) > 12 then
		local Target = InfoTable.Target
		if Target then
			local TargetPlr = workspace:FindFirstChild(Target.Name)
			local Hum = TargetPlr:FindFirstChild("Humanoid")
			if Hum then
				Hum.Health = Hum.MaxHealth
				SendDataConfirmation:Fire(plr, Target.Name.." has been healed to "..Hum.Health)
			end
		end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 14 then
		if plr:GetRankInGroup(3755220) > 12 then
		for _, npc in pairs(workspace.NPCs:GetChildren()) do
			npc:BreakJoints()
		end	
		SendDataConfirmation:Fire(plr, "All NPCs have been reset.")
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 15 then
		if plr:GetRankInGroup(3755220) > 12 then
			local Target = plr.Character
			if InfoTable then
				for v,ff in pairs(Target:GetChildren()) do
					if ff:IsA("ForceField") then ff.Visible = false end
				end
				local ff = Instance.new("ForceField", Target)
				ff.Name = "PassiveMode"
				ff.Visible = false
				Connection2[plr] = Target.ChildAdded:Connect(function(shield)
					if shield:IsA("ForceField") then
						shield.Visible = false
					end
				end)
				local PartTable = {}
				for v,parts in pairs(Target:GetDescendants()) do
					if (parts:IsA("BasePart") or parts:IsA("Decal")) and parts.Transparency ~= 1 then
						table.insert(PartTable, {[parts.Name] = parts.Transparency})
						parts.Transparency = 1
					elseif parts:IsA("BillboardGui") then
						parts.Enabled = false
					end	
				end
				game.ReplicatedStorage.CommandTab:FireClient(plr, 15, PartTable)
				table.insert(TransparentItems, {[plr.Name] = PartTable})
				local Attack = Target:FindFirstChild("Attack")
				if Attack then
					Attack.Value = true
					Connection[plr] = Attack:GetPropertyChangedSignal("Value"):Connect(function()
						Attack.Value = true
					end)
				end
			elseif not InfoTable then
				if Target:FindFirstChild("PassiveMode") then Target:FindFirstChild("PassiveMode"):Destroy() end
				for v,ff in pairs(Target:GetChildren()) do
					if ff:IsA("ForceField") then ff.Visible = true end
				end
				Connection2[plr]:Disconnect()
				for i,ti in pairs(TransparentItems) do
					if ti[plr.Name] then
						for v,tables in pairs(ti[plr.Name]) do
							for e,parts in pairs(Target:GetDescendants()) do
								if parts:IsA("BasePart") or parts:IsA("Decal") then
									if tables[parts.Name] then
										parts.Transparency = tables[parts.Name]
									end
								elseif parts:IsA("BillboardGui") then
									parts.Enabled = true
								end
							end
						end
						ti[plr.Name] = nil
					end
				end
				local Attack = Target:FindFirstChild("Attack")
				if Attack then
					if Connection[plr] ~= nil then Connection[plr]:Disconnect() end
					Attack.Value = false
				end
			end
		else
			SendDataConfirmation:Fire(plr, plr.Name .. " attempted to exploit to use commands.")
		end
	elseif Cmd == 17 then
		if plr:GetRankInGroup(3755220) > 12 then
			game:GetService("TeleportService"):TeleportToPrivateServer(4529243409, game:GetService("DataStoreService"):GetDataStore("ReserveServers"):GetAsync(31560346), {plr})
		end
	end
end)
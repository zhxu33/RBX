----------------------------------------------| READ BELOW |----------------------------------------------
--																										--
--																										--
--		If you are looking to use a custom quirk and want to add your name to the list, go to:			--
--  					ReplicatedStorage => CustomQuirk => QuirkAccess									--
--																										--
--																					- Jeffycry 2020		--
----------------------------------------------------------------------------------------------------------

local Player = game.Players.LocalPlayer
local Quirks = require(game.ReplicatedStorage.CustomQuirk.QuirkAccess)
local SaitamaAccess = Quirks.QuirkAccess.Saitama
local IansAccess = Quirks.QuirkAccess.PrimeAllMight
local SmileyAccess = Quirks.QuirkAccess.Smileyman
local GERAccess = Quirks.QuirkAccess.GER
local TonyQuirkAccess = Quirks.QuirkAccess.Tonyyy
local BloodAccess = Quirks.QuirkAccess.Blood
local DIOAccess = Quirks.QuirkAccess.DIO

local Yes = false
for i=1,#SaitamaAccess do
	if Player.Name == SaitamaAccess[i] then
		Yes = true
		break
	end
end
for i=1,#IansAccess do
	if Player.Name == IansAccess[i] then
		Yes = true
		break
	end
end
for i=1,#SmileyAccess do
	if Player.Name == SmileyAccess[i] then
		Yes = true
		break
	end
end
for i=1,#GERAccess do
	if Player.Name == GERAccess[i] then
		Yes = true
		break
	end
end
for i=1,#TonyQuirkAccess do
	if Player.Name == TonyQuirkAccess[i] then
		Yes = true
		break
	end
end
for i=1,#BloodAccess do
	if Player.Name == BloodAccess[i] then
		Yes = true
		break
	end
end
for i=1,#DIOAccess do
	if Player.Name == DIOAccess[i] then
		Yes = true
		break
	end
end

if not Yes then
	script.Parent:Destroy()
end

if Yes then
	local SaitamaCustom = game.ReplicatedStorage.CustomQuirk:WaitForChild("Saitama")
	local IansCustom = game.ReplicatedStorage.CustomQuirk:WaitForChild("10ian10s")
	local MrSmileyCustom = game.ReplicatedStorage.CustomQuirk:WaitForChild("MrSmiley")
	local GER = game.ReplicatedStorage.CustomQuirk:WaitForChild("GER")
	local Tonyy = game.ReplicatedStorage.CustomQuirk:WaitForChild("Tonyy")
	local Blood = game.ReplicatedStorage.CustomQuirk:WaitForChild("BloodCurdle")
	local DIO = game.ReplicatedStorage.CustomQuirk:WaitForChild("DIO")
	local Rows = {UDim2.fromScale(.209,.155),UDim2.fromScale(.209,.267),UDim2.fromScale(.209,.375),UDim2.fromScale(.209,.484),UDim2.fromScale(.209,.59),UDim2.fromScale(.209,.695),UDim2.fromScale(.209,.8)}
	script.Parent.Enabled = true
	local CustomOn = false
	local CustomFrame = script.Parent.Custom
	CustomFrame.OpenMenu.MouseButton1Click:Connect(function()
		if not CustomFrame.Availables.Visible then
			CustomFrame.Availables.Visible = true
		else
			CustomFrame.Availables.Visible = false
		end
	end)
	local Row = 1
	local Available1 = false
	for i=1,#SaitamaAccess do
		if Player.Name == SaitamaAccess[i] then
			Available1 = true
		end
		if Available1 then
			CustomFrame.Availables.Custom1.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					SaitamaCustom:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom1.Position = Rows[Row]
			Row = Row + 1
			break
		end
	end
	if not Available1 then
		CustomFrame.Availables.Custom1:Destroy()
	end
	local Available2 = false
	for i=1,#IansAccess do
		if Player.Name == IansAccess[i] then
			Available2 = true
		end
		if Available2 then
			CustomFrame.Availables.Custom2.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					IansCustom:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom2.Position = Rows[Row]
			Row = Row + 1
			break
		end
	end
	if not Available2 then
		CustomFrame.Availables.Custom2:Destroy()
	end
	local Available3 = false
	for i=1,#SmileyAccess do
		if Player.Name == SmileyAccess[i] then
			Available3 = true
		end
		if Available3 then
			CustomFrame.Availables.Custom3.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					MrSmileyCustom:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom3.Position = Rows[Row]
			Row = Row + 1
			break
		end
	end
	if not Available3 then
		CustomFrame.Availables.Custom3:Destroy()
	end
	local Available4 = false
	for i=1,#GERAccess do
		if Player.Name == GERAccess[i] then
			Available4 = true
		end
		if Available4 then
			CustomFrame.Availables.Custom4.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					GER:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom4.Position = Rows[Row]
			Row = Row + 1
			break
		end
	end
	if not Available4 then
		CustomFrame.Availables.Custom4:Destroy()
	end
	local Available5 = false
	for i=1,#TonyQuirkAccess do
		if Player.Name == TonyQuirkAccess[i] then
			Available5 = true
		end
		if Available5 then
			CustomFrame.Availables.Custom5.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					Tonyy:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom5.Position = Rows[Row]
			Row = Row + 1
			break
		end
	end
	if not Available5 then
		CustomFrame.Availables.Custom5:Destroy()
	end
	local Available6 = false
	for i=1,#BloodAccess do
		if Player.Name == BloodAccess[i] then
			Available6 = true
		end
		if Available6 then
			CustomFrame.Availables.Custom6.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					Blood:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom6.Position = Rows[Row]
			Row = Row + 1
			break
		end
	end
	if not Available6 then
		CustomFrame.Availables.Custom6:Destroy()
	end
	local Available7 = false
	for i=1,#DIOAccess do
		if Player.Name == DIOAccess[i] then
			Available7 = true
		end
		if Available7 then
			CustomFrame.Availables.Custom7.MouseButton1Click:Connect(function()
				if not CustomOn then
					CustomOn = true
					DIO:FireServer()
					script.Parent:Destroy()
				end
			end)
			CustomFrame.Availables.Custom7.Position = Rows[Row]
			break
		end
	end
	if not Available7 then
		CustomFrame.Availables.Custom7:Destroy()
	end
end
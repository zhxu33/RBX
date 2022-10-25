local player = game.Players.LocalPlayer
local Frame = script.Parent
local SelectedCommand = Frame.SelectedCommand
local CommandsList = Frame.CommandsDisplay
local PlayersList = Frame.PlayersDisplay
local CommandDisplay = Frame.Command
local Execute = Frame.Execute
local Undo = Frame.Undo
local SelectCommand = Frame.Select
local PlayerSelect = Frame.SelectPlayer
local CommandFunct = game.ReplicatedStorage.CommandTab
local ExecuteUDIM = UDim2.fromScale(.496,.49)
local UndoUDIM = UDim2.fromScale(.229,.49)
local SingleExecuteUDIM = UDim2.fromScale(.363,.49)
local ClickSound = player.PlayerGui:WaitForChild("Menu").ClickSound
local PLRLists = {}
local PlayerCount = 12
for i=1,12 do
	PLRLists[i] = PlayersList["List"..i]
end
local Listed = {}

local ButtonConnection = {}
local function UpdatePlayers()
	Listed = {}
	for i=1,#PLRLists do
		Listed[i] = false
		local Button = PLRLists[i]
		Button.Visible = false
		Button.Text = "N/A"
		if ButtonConnection[i] ~= nil then
			ButtonConnection[i]:Disconnect()
		end
	end
	local PLRS = game.Players:GetPlayers()
	for i=1,#PLRS do
		local Button = PLRLists[i]
		Button.Visible = true
		Listed[i] = true
		Button.Text = PLRS[i].Name
		ButtonConnection[i] = Button.MouseButton1Click:Connect(function()
			ClickSound:Play()
			Frame.NameInput.Text = PLRS[i].Name
		end)
	end
	for i=1,#PLRLists do
		if Listed[i] ~= true then
			Listed[i] = false
			local Button = PLRLists[i]
			Button.Visible = false
			Button.Text = "N/A"
			if ButtonConnection[i] ~= nil then
				ButtonConnection[i]:Disconnect()
			end
		end
	end
end
UpdatePlayers()

game.Players.PlayerAdded:Connect(UpdatePlayers)
game.Players.PlayerRemoving:Connect(UpdatePlayers)

function GetPlayer(Name)
	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if v.Name:lower():sub(1,string.len(Name)) == Name:lower() then
			return v
		end
	end
end

PlayerSelect.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if PlayersList.Visible == false then
		PlayersList.Visible = true
		CommandsList.Visible = false
	else
		PlayersList.Visible = false
	end
end)

SelectCommand.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if CommandsList.Visible == false then
		CommandsList.Visible = true
		PlayersList.Visible = false
	else
		CommandsList.Visible = false
	end
end)

local function ToInteger(convert)
	return tonumber(convert) or nil
end

local ExtrasA = Frame.Parent.Parent.ExtrasA
Execute.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if SelectedCommand.Value == 1 then -- Ban
		Frame.Parent.Visible = false
		ExtrasA.Visible = true
		local connection
		local connection2
		connection = ExtrasA.Frame.Execute.MouseButton1Click:Connect(function()
			local Info = {
				Target = tostring(Frame.NameInput.Text),
				Days = ToInteger(ExtrasA.Frame.Length.Text),
				Reason = tostring(ExtrasA.Frame.Reason.Text)
			}
			CommandFunct:FireServer(1, Info)
			Frame.NameInput.Text = ""
			ExtrasA.Frame.Length.Text = ""
			ExtrasA.Frame.Reason.Text = ""
			Frame.Parent.Visible = true
			ExtrasA.Visible = false
			connection:Disconnect()
			connection2:Disconnect()
		end)
		connection2 = ExtrasA.Frame.Back.MouseButton1Click:Connect(function()
			Frame.Parent.Visible = true
			ExtrasA.Visible = false
			ExtrasA.Frame.Length.Text = ""
			ExtrasA.Frame.Reason.Text = ""
			connection:Disconnect()
			connection2:Disconnect()
		end)
	elseif SelectedCommand.Value == 2 then -- Kick
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(2, Info)
		Frame.NameInput.Text = ""
	elseif SelectedCommand.Value == 3 then -- Bring
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(5, Info)
	elseif SelectedCommand.Value == 4 then -- To
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text),
			Name = Frame.NameInput.Text
		}
		CommandFunct:FireServer(6, Info)
	elseif SelectedCommand.Value == 5 then -- Forcefield
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(7, Info)
	elseif SelectedCommand.Value == 6 then -- Watch
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(9, Info)
	elseif SelectedCommand.Value == 7 then -- Kill
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(11, Info)
	elseif SelectedCommand.Value == 8 then -- Reset
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(12, Info)
	elseif SelectedCommand.Value == 9 then -- Heal
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(13, Info)
	elseif SelectedCommand.Value == 10 then -- NPC Reset
		CommandFunct:FireServer(14)
	end
end)

Undo.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if SelectedCommand.Value == 1 then -- Unban
		local Info = {
			Target = Frame.NameInput.Text
		}
		CommandFunct:FireServer(3, Info)
		Frame.NameInput.Text = ""
	elseif SelectedCommand.Value == 2 then -- Unkick
		local Info = {
			Target = Frame.NameInput.Text
		}
		CommandFunct:FireServer(4, Info)
		Frame.NameInput.Text = ""
	elseif SelectedCommand.Value == 5 then -- Un-Forcefield
		local Info = {
			Target = GetPlayer(Frame.NameInput.Text)
		}
		CommandFunct:FireServer(8, Info)
	elseif SelectedCommand.Value == 6 then -- Un-Watch
		CommandFunct:FireServer(10)
	end
end)

-- Command Buttons --

CommandsList.Ban.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 1
	CommandDisplay.Text = "Selected Command: Ban"
	Execute.Visible = true
	Undo.Visible = true
	Execute.Position = ExecuteUDIM
	Undo.Position = UndoUDIM
end)

CommandsList.Kick.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 2
	CommandDisplay.Text = "Selected Command: Kick"
	Execute.Visible = true
	Undo.Visible = true
	Execute.Position = ExecuteUDIM
	Undo.Position = UndoUDIM
end)

CommandsList.Bring.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 3
	CommandDisplay.Text = "Selected Command: Bring"
	Execute.Visible = true
	Undo.Visible = false
	Execute.Position = SingleExecuteUDIM
end)

CommandsList.To.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 4
	CommandDisplay.Text = "Selected Command: To"
	Execute.Visible = true
	Undo.Visible = false
	Execute.Position = SingleExecuteUDIM
end)

CommandsList.Forcefield.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 5
	CommandDisplay.Text = "Selected Command: Forcefield"
	Execute.Visible = true
	Undo.Visible = true
	Execute.Position = ExecuteUDIM
	Undo.Position = UndoUDIM
end)

CommandsList.Watch.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 6
	CommandDisplay.Text = "Selected Command: Watch"
	Execute.Visible = true
	Undo.Visible = true
	Execute.Position = ExecuteUDIM
	Undo.Position = UndoUDIM
end)

CommandsList.Kill.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 7
	CommandDisplay.Text = "Selected Command: Kill"
	Execute.Visible = true
	Undo.Visible = false
	Execute.Position = SingleExecuteUDIM
end)

CommandsList.Reset.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 8
	CommandDisplay.Text = "Selected Command: Reset"
	Execute.Visible = true
	Undo.Visible = false
	Execute.Position = SingleExecuteUDIM
end)

CommandsList.Heal.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 9
	CommandDisplay.Text = "Selected Command: Heal"
	Execute.Visible = true
	Undo.Visible = false
	Execute.Position = SingleExecuteUDIM
end)

CommandsList.NPCReset.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandsList.Visible = false
	SelectedCommand.Value = 10
	CommandDisplay.Text = "Selected Command: NPC-Reset"
	Execute.Visible = true
	Undo.Visible = false
	Execute.Position = SingleExecuteUDIM
	Frame.NameInput.TextEditable = false
	Frame.NameInput.RoundImage.ImageTransparency = 0.7
	Frame.NameInput.TextTransparency = 1
	repeat wait() until SelectedCommand.Value ~= 10
	Frame.NameInput.TextEditable = true
	Frame.NameInput.RoundImage.ImageTransparency = 0
	Frame.NameInput.TextTransparency = 0
end)

-- TAG TOGGLE --

local ToggleButton = Frame.ToggleTag
ToggleButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	CommandFunct:FireServer(16)
end)

-- PASSIVE MODE --

local PassiveButton = Frame.TogglePM
local Toggle = false
local PMCool = false
player.Character:WaitForChild("Humanoid").Died:Connect(function()
	Toggle = false
end)
player.CharacterAdded:Connect(function()
	Toggle = false
end)

CommandFunct.OnClientEvent:Connect(function(Val, PartTable)
	if Val == 15 then
		for v,tables in pairs(PartTable) do
			for e,parts in pairs(player.Character:GetDescendants()) do
				if parts:IsA("BasePart") then
					if tables[parts.Name] then	
						parts.Transparency = 0.85
					end
				elseif parts:IsA("Decal") then
					if tables[parts.Name] then
						parts.Transparency = 0
					end
				end
			end
		end
	end
end)	

PassiveButton.MouseButton1Click:Connect(function()
	if player.Character.Humanoid.Health ~= 0 then
		if not Toggle and not PMCool then
			ClickSound:Play()
			coroutine.wrap(function()
				PMCool = true
				wait(1)
				PMCool = false
			end)()
			Toggle = true
			PassiveButton.Text = "Enabled"
			CommandFunct:FireServer(15, true)
			repeat game:GetService("RunService").RenderStepped:Wait() until Toggle == false
			if Toggle == true then Toggle = false end
			PassiveButton.Text = "Disabled"
			CommandFunct:FireServer(15, false)
		elseif Toggle and not PMCool then
			ClickSound:Play()
			coroutine.wrap(function()
				PMCool = true
				wait(1)
				PMCool = false
			end)()
			Toggle = false
		end
	end
end)

-- Noclip Mode

local NoclipButton = Frame.ToggleNC
local NBCool = false

local ToggleInvis = false
NoclipButton.MouseButton1Click:Connect(function()
	if not ToggleInvis and not NBCool then
		ClickSound:Play()
		coroutine.wrap(function()
			NBCool = true
			wait(1)
			NBCool = false
		end)()
		local TransparentValue = {}
		local TransparentItems = {}
		ToggleInvis = true
		NoclipButton.Text = "Enabled"
		for v,parts in pairs(workspace:GetDescendants()) do
			if (parts:IsA("BasePart") or parts:IsA("Decal")) and parts.Transparency <= .85 then
				local Maybe = false
				for v,player in ipairs(game.Players:GetPlayers()) do
					if parts:IsDescendantOf(player.Character) then
						Maybe = true
					end
				end
				if not Maybe then
					table.insert(TransparentValue, parts.Transparency)
					table.insert(TransparentItems, parts)
					if parts:IsA("BasePart") and parts.Material == Enum.Material.Glass then
						parts.Transparency = 1
					else
						parts.Transparency = 0.85
					end
				end
			end
		end
		repeat game:GetService("RunService").RenderStepped:Wait() until not ToggleInvis
		for i=1,#TransparentItems do
			TransparentItems[i].Transparency = TransparentValue[i]
		end
		NoclipButton.Text = "Disabled"
		TransparentItems = {}
		TransparentValue = {}
	elseif ToggleInvis and not NBCool then
		ClickSound:Play()
		coroutine.wrap(function()
			NBCool = true
			wait(1)
			NBCool = false
		end)()
		ToggleInvis = false
	end
end)

-- Server Age --
local ServerAge = script.Parent.ServerRunTime
local ServerTime = game.ReplicatedStorage.Time

local function Format(timer)
	local FormatTime = "HH:MM:SS"
	local formatseconds = math.floor(timer)
	local formatminutes = 0
	local formathour = 0
	while formatseconds > 59 do
		formatseconds=formatseconds-60
		formatminutes=formatminutes+1
	end
	while formatminutes > 59 do
		formatminutes=formatminutes-60
		formathour=formathour+1
	end
	if formatseconds > 9 then
		else
		formatseconds = ("0" .. tostring(formatseconds))
	end
	if formatminutes > 9 then
		else
		formatminutes = ("0" .. tostring(formatminutes))
	end
	if formathour > 9 then
		else
		formathour = ("0" .. tostring(formathour))
	end
	return FormatTime:gsub("HH:MM:SS", formathour .. ":" .. formatminutes .. ":" .. formatseconds)
end

coroutine.wrap(function()
	while true do
		local Time = Format(ServerTime:InvokeServer())
		ServerAge.Text = "Server Age: " .. Time
		wait(1)
	end
end)()
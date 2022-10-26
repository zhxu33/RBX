if not game:IsLoaded() then game.Loaded:Wait() end

-- // Services
local replicated    = game:GetService("ReplicatedStorage")
local tweenService  = game:GetService("TweenService")
local playerService = game:GetService("Players")

-- // Variables
local player = playerService.LocalPlayer

local parent     = script.Parent
local options    = parent:WaitForChild("Options")
local background = options:WaitForChild("npcButton")
local ball       = background:WaitForChild("Ball")
local infoMod    = require(replicated:WaitForChild("Modules"):WaitForChild("InfoModule"))
local playerGui  = player:WaitForChild("PlayerGui")
local NpcInfo    = playerGui:WaitForChild("NPCInfo")

local npcFolder   = workspace:WaitForChild("NPCs")
local interaction = workspace:WaitForChild("InteractionNPCS")

local canUse   = false -- // Depends on whether options menu is prompted
local isOn     = false -- // Depends on if option is currently on
local debounce = false -- // Debounce for operation

-- // connections & folders
local guiConnections   = {}
local NPCConnections   = {}
local otherConnections = {}

-- // allowing it to be used
options:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
	canUse = options.ImageTransparency <= .1
end)

-- // functions
-- // dispose table & removes connections
local function disposeValues(arg)
	if arg == "table" then
		for index, value in pairs(arg) do
			arg[index] = disposeValues(value)
		end
	elseif typeof(arg) == "RBXScriptConnection" then
		arg:Disconnect()
	end
	
	return nil
end

-- // open & shows info gui
local function showGui(gui)
	if not gui then return end
	local newTween = tweenService:Create(gui, TweenInfo.new(.5), {Size = UDim2.new(.9, 0, .9, 0)})
	
	newTween:Play()
	return newTween
end

-- // close & hides info gui
local function hideGui(gui)
	if not gui then return end
	local newTween = tweenService:Create(gui, TweenInfo.new(.5), {Size = UDim2.new(0, 0, .9, 0)})
	
	newTween:Play()
	return newTween
end

-- // grabs npc cache
local function getNPCFile(Npc)
	for index, value in pairs(NPCConnections) do
		if value.Npc == Npc then
			return index, NPCConnections[index]
		end
	end
end

-- // adds npc cache
local function addNPC(Npc)
	local newProfile = {}
	
	-- // creating add thread incase it needs to be canceled shortly after
	newProfile.AddThread = task.spawn(function()
		newProfile.Npc          = Npc
		newProfile.Proxy        = NpcInfo.ProxyBase:Clone()
		newProfile.Proxy.Parent = Npc
		
		newProfile.InfoGui         = NpcInfo.InfoGui:Clone()
		newProfile.InfoGui.Adornee = Npc.PrimaryPart or Npc:WaitForChild("HumanoidRootPart")
		newProfile.InfoGui.Parent  = NpcInfo.GuiFolder
		
		local OpenTween  = nil
		local CloseTween = nil
		
		newProfile.connections  = {}
		
		newProfile.connections.ProxyOpen = newProfile.Proxy.PromptShown:Connect(function()
			if not newProfile.InfoGui or not newProfile.InfoGui.Parent then return end
			
			if CloseTween then CloseTween:Cancel() end
			newProfile.InfoGui.Enabled = true
			OpenTween = showGui(newProfile.InfoGui.InfoFrame)
		end)
		
		newProfile.connections.ProxyOpen = newProfile.Proxy.PromptHidden:Connect(function()
			if not newProfile.InfoGui or not newProfile.InfoGui.Parent then return end
			
			if OpenTween then OpenTween:Cancel() end
			CloseTween = hideGui(newProfile.InfoGui.InfoFrame)
			
			-- // wait for animation to finish if it's animating
			if CloseTween then
				CloseTween.Completed:Wait()
			end
			
			-- // checking if the tween was not cancelled so it doesn't force close gui
			if CloseTween.PlaybackState ~= Enum.PlaybackState.Cancelled then
				newProfile.InfoGui.Enabled = false
			end
		end)
		
		-- // putting information on INFOCARD
		local info = Npc:GetAttribute("NPC") and infoMod.NPCDex.NPCs[Npc.Name] or infoMod.QuestInfo[Npc.Name] or infoMod.MiscNpcs[Npc.Name]
		local infoBackground
		newProfile.InfoGui.InfoFrame.NPCName.Text = Npc.Name
		
		if infoMod.NPCDex.NPCs[Npc.Name] and Npc:GetAttribute("NPC") then
			infoBackground  = newProfile.InfoGui.InfoFrame.NpcDex
			local npcHealth = infoBackground:FindFirstChild("NpcHealth")
			
			for index, value in pairs(info.Rewards) do
				infoBackground[index].Text ..= " "..value
			end

			local humanoid = Npc:WaitForChild("Humanoid")
			npcHealth.Text = string.format("Health: %d / %d", humanoid.Health/10, humanoid.MaxHealth/10)
			
			local function removeConnections()
				for _, value in pairs(newProfile.connections) do value:Disconnect() end
			end
			
			newProfile.connections.NpcHealth = humanoid.HealthChanged:Connect(function()
				npcHealth.Text = string.format("Health: %d / %d", humanoid.Health/10, humanoid.MaxHealth/10)
				
				if humanoid.Health <= 0 then removeConnections() end
			end)
			
			newProfile.connections.Died = humanoid.AncestryChanged:Connect(function(self, newParent)
				if newParent then return end
				removeConnections()
			end)

			newProfile.InfoGui.InfoFrame.NPCName.Text = info.Info.GuiName
		elseif infoMod.QuestInfo[Npc.Name] then
			infoBackground = newProfile.InfoGui.InfoFrame.QuestInfo

			infoBackground.Cash.Text       ..= string.format(" $%s", info.Info.Cash)
			infoBackground.Experience.Text ..= string.format(" %s", info.Info.Experience)
			infoBackground.Quest.Text      ..= string.format(" %s: %d.", info.Info.Name, info.Info.KillsNeeded)
		elseif infoMod.MiscNpcs[Npc.Name] then
			infoBackground = newProfile.InfoGui.InfoFrame.OtherDesc
			
			for index, value in pairs(info) do
				infoBackground[index].Text = value
			end
		end
		
		if infoBackground then infoBackground.Visible = true end
	end)
	
	table.insert(NPCConnections, newProfile)
end

-- // removes npc cache
local function removeNPC(Npc)
	local index, file = getNPCFile(Npc)
	
	task.spawn(function()
		if file then
			-- // removing thread & canceling it before it finishes
			if file.AddThread then task.cancel(file.AddThread) end
			
			if file.InfoGui then
				local tween = hideGui(file.InfoGui.InfoFrame)
				tween.Completed:Wait()
				file.InfoGui:Destroy()
			end
				
			-- // adding destroy thread as delay
			if file.Proxy then file.Proxy:Destroy() end
			file = disposeValues(file)
			table.remove(NPCConnections, index)
		end
	end)
end

-- // does the animation for turning on&off
local tweenTime = 0.2
local function animation()
	local tweeninfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0)
	local tweengoal = {ImageColor3 = isOn and Color3.fromRGB(131, 28, 27) or Color3.fromRGB(85, 239, 196)}
	
	if isOn then
		ball:TweenPosition(UDim2.new(0.02, 0, 0.099, 0), "Out", "Quad", tweenTime, true)
		background.Image = "http://www.roblox.com/asset/?id=7194494960"
	else
		ball:TweenPosition(UDim2.new(1 - ball.Size.X.Scale - 0.02, 0, 0.099, 0), "Out", "Quad", tweenTime, true)
		background.Image = "http://www.roblox.com/asset/?id=7194434903"
	end
	tweenService:Create(ball, tweeninfo, tweengoal):Play()
	
	isOn = not isOn
	task.wait(tweenTime)
end

-- // connection for button
guiConnections.buttonCon = background.InputBegan:Connect(function(inputObject)
	if inputObject.UserInputState ~= Enum.UserInputState.Begin or not canUse or debounce then return end
	debounce = not debounce
	animation()
	
	if isOn then
		-- // adding child added connections
		otherConnections.ChildAdded   = npcFolder.ChildAdded:Connect(addNPC)
		otherConnections.ChildRemoved = npcFolder.ChildRemoved:Connect(removeNPC)
		
		-- // getting npcs for connections
		for _, npc in pairs(npcFolder:GetChildren())   do addNPC(npc) end
		for _, npc in pairs(interaction:GetChildren()) do addNPC(npc) end
	else
		-- // removing connections
		for _, con in pairs(otherConnections) do con:Disconnect() end
		
		-- // removing and clearing all npcs from list
		for _, value in pairs(NPCConnections) do
			removeNPC(value.Npc)
		end
		
		table.clear(otherConnections)
	end
	
	task.wait(2)
	debounce = not debounce
end)
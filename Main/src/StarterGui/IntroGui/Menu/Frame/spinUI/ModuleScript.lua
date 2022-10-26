local m = {}

local quirks = require(game.ReplicatedStorage.Modules.QuirkData)
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local ui = gui:WaitForChild("IntroGui")
local spinning = false

function m:getRarity(typea)
	for i,q in ipairs(quirks.Rarites) do
		if q.name == typea then
			return q
		end
	end
end

function m:createItem(hasGP, spinType)
	local obj = script:WaitForChild("Template"):Clone()
	local scale = math.floor((obj.Size.X.Scale*m.settings.cUI.AbsoluteSize.Y)+0.5)/m.settings.cUI.AbsoluteSize.X
	local types = {}
	for i,a in ipairs(m.settings.case.items) do
		print("real steppy")
		for id,child in ipairs(quirks.Quirks) do
			if child.name == a then
				if hasGP then
					if spinType == "Common" then
						local rare = m:getRarity(child.rarity)
						for t=1, rare.CommonDrarity*100 do
							table.insert(types,child)
						end
					elseif spinType == "Uncommon" then
						local rare = m:getRarity(child.rarity)
						for t=1, rare.UncommonDrarity*100 do
							table.insert(types,child)
						end
					elseif spinType == "Rare" then
						local rare = m:getRarity(child.rarity)
						for t=1, rare.RareDrarity*100 do
							table.insert(types,child)
						end
					end
				else
					if spinType == "Common" then
						local rare = m:getRarity(child.rarity)
						for t=1, rare.Crarity*100 do
							table.insert(types,child)
						end
					elseif spinType == "Uncommon" then
						local rare = m:getRarity(child.rarity)
						for t=1, rare.UCrarity*100 do
							table.insert(types,child)
						end
					elseif spinType == "Rare" then
						local rare = m:getRarity(child.rarity)
						for t=1, rare.Rrarity*100 do
							table.insert(types,child)
						end
					end
				end
			end
		end
	end

	local item = types[m.settings.prng:NextInteger(1,#types)]
	local itemType = m:getRarity(item.rarity)

	obj.ImageColor3 = itemType.colour
	obj.TextLabel.Text = item.name
	obj.Name = item.name
	
	--pos
	obj.Position = (m.settings.lastObject and m.settings.lastObject.Position+UDim2.new(scale+0.22,0,0,0)+m.settings.offset) or UDim2.new(-scale/2,0,0.1,0)
	obj.Parent = ui.Menu.Frame.spinUI

	m.settings.lastObject = obj
	table.insert(m.settings.objects, obj)
end

function m:check(hasGP, spinType)
	for a,b in ipairs(m.settings.objects) do
		local scaledSize = b.AbsoluteSize
		if b.AbsolutePosition.X <= -scaledSize.X + m.settings.offset.X.Offset then
			table.remove(m.settings.objects,a)
			b:Destroy()
			if hasGP then
				m:createItem(hasGP, spinType)
			else
				m:createItem(false, spinType)
			end
			m:check()
			break
		end
	end
end

function m:update()
	m.settings.speed = math.max(m.settings.speed-(0.043/m.settings.spinLength),0)
	m.settings.newAccel = m.settings.accel*math.sin((math.pi/2)*m.settings.speed)
	for a,b in ipairs(m.settings.objects) do
		b.Position = b.Position-UDim2.new(m.settings.newAccel/m.settings.cUI.AbsoluteSize.X,0,0,0)
	end
	if m.settings.newAccel <= 0 then m:result() end
end

function m:result()
	m.render:Disconnect()
	local item
	for a,b in ipairs(m.settings.objects) do
		local left,right = b.AbsolutePosition.X/m.settings.cUI.AbsoluteSize.X,
			(b.AbsolutePosition.X+b.AbsoluteSize.X)/m.settings.cUI.AbsoluteSize.X
		if left<=0.56 and right >= 0.57 then item=b break end
	end
	if item ~= nil then
		m.newResult = item.Name
	else
		local closetItems = {}
		for a,b in ipairs(m.settings.objects) do
			table.insert(closetItems,{
				mag=(Vector2.new(b.AbsolutePosition.X/m.settings.cUI.AbsoluteSize.X,0)-Vector2.new(0.5,0)).Magnitude,
				item=b;
			})
		end
		table.sort(closetItems,function(a,b) return a.mag<b.mag end)
		local words = closetItems[1]["item"]
		m.newResult = words
	end
end

function m:create(SpinTypes, hasGP)
	if spinning == true then return false end
	spinning = true
	m.settings = {
		case = quirks.SpinTypes[SpinTypes],
		cUI = ui.Menu.Frame.spinUI,
		objects = {},
		prng = Random.new(),
		offset = UDim2.new(0,25,0,0),
		accel = 25,
		speed = 1.5,
		spinLength = 5.4;
	}
	m.newResult=nil
	m.settings.cUI.Parent = ui.Menu.Frame
	for t=1,15 do
		m:createItem(hasGP, SpinTypes)
	end
	m.render = game:GetService("RunService").RenderStepped:Connect(function()
		m:update()
		m:check(hasGP,SpinTypes)
	end)
	repeat wait() until m.newResult
	wait(1)
	for i,a in pairs(script.Parent:GetChildren()) do
		if a:IsA("ImageLabel") then
			a:Destroy()
		end
	end
	spinning = false
	return m.newResult
end

return m
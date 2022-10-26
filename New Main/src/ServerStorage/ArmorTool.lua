local Converter = {}

function Converter:EquipTest(Item, Time)

	if not self then return end
	if not Item then return end

	local S = Time or 1
	local ClonedItem = Item:Clone()
	ClonedItem.Parent = self

	for i=1,ClonedItem:GetAttribute("Sources") do
		local Source = self:FindFirstChild(ClonedItem:GetAttribute("Source"..i))
		local Handle = ClonedItem:FindFirstChild(ClonedItem:GetAttribute("Handle"..i))
		local HWeld = ClonedItem:GetAttribute("Weld"..i)
		local weld = Instance.new("Weld", Handle)
		weld.Part0 = Handle
		weld.Part1 = Source
		weld.C0 = CFrame.new(ClonedItem:GetAttribute("Offset"..i)) * CFrame.Angles(math.rad(HWeld.X),math.rad(HWeld.Y),math.rad(HWeld.Z))
	end

	wait(S)
	ClonedItem:Destroy()

end

function Converter:RigArmor(Armor, Dummy)
	local list = Armor:GetChildren()
	Armor:SetAttribute("Sources", #list)
	
	for index, value in pairs(list) do
		local Name = value.Name:gsub("[%d]+", "")
		value.Name = Name .. index
		
		local toItem = Dummy[Name]
		
		Armor:SetAttribute("Handle" .. index, value.Name)
		Armor:SetAttribute("Source" .. index, Name)
		Armor:SetAttribute("Weld"   .. index, Vector3.new(0, 180, 0))
		Armor:SetAttribute("Offset" .. index, toItem.Position - value.Position)
	end
end

function Converter:AddLayers()

	if not self then return end
	if not self:GetAttribute("Sources") then return end

	local NewValue = self:GetAttribute("Sources")+1
	self:SetAttribute("Handle" .. NewValue, "")
	self:SetAttribute("Source" .. NewValue, "")
	self:SetAttribute("Weld"   .. NewValue, Vector3.new())
	self:SetAttribute("Offset" .. NewValue, Vector3.new())
	self:SetAttribute("Sources", NewValue)

end

return Converter
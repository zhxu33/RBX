local Parent = script.Parent

local LootFrame = Parent.Scroll

local TotalPerHorizontal = 2.18
local TotalVertical = 3
local Buffer = .05
local TotalPerFrame = TotalPerHorizontal*TotalVertical

local function ResizeCanvas(Scroll)
	local List = Scroll:GetChildren()
	local TotalItems = #List
	local NewCanvasYSize = math.ceil(TotalItems/TotalPerFrame)
	Scroll.CanvasSize = UDim2.new(0, 0, NewCanvasYSize*3/TotalVertical, 0)
	Scroll.UIGridLayout.CellSize = UDim2.new(1/(TotalPerHorizontal) - (TotalPerHorizontal*Buffer), 0, (1/TotalVertical- (TotalPerHorizontal*Buffer))/NewCanvasYSize)
	Scroll.UIGridLayout.CellPadding = UDim2.new((TotalPerHorizontal*Buffer), 0, (1/TotalVertical- (TotalPerHorizontal*Buffer))/NewCanvasYSize/TotalPerFrame, 0)
end

LootFrame.DescendantAdded:Connect(function() ResizeCanvas(LootFrame) end)
LootFrame.DescendantRemoving:Connect(function() ResizeCanvas(LootFrame) end)
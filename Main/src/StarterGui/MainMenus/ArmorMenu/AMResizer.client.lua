local Parent = script.Parent

local FRAME = Parent.ScrollingFrame

--local TotalPerHorizontal = 1.89
--local TotalVertical = 3
--local Buffer = .04
--local TotalPerFrame = TotalPerHorizontal*TotalVertical

--local function ResizeCanvas(Scroll)
--	local List = Scroll:GetChildren()
--	local TotalItems = #List
--	local NewCanvasYSize = math.ceil(TotalItems/TotalPerFrame)
--	Scroll.CanvasSize = UDim2.new(0, 0, NewCanvasYSize*1/TotalVertical, 0)
--	Scroll.UIGridLayout.CellSize = UDim2.new(1/(TotalPerHorizontal) - (TotalPerHorizontal*Buffer), 0, (1/TotalVertical- (TotalPerHorizontal*Buffer))/NewCanvasYSize)
--	Scroll.UIGridLayout.CellPadding = UDim2.new((TotalPerHorizontal*Buffer), 0, (1/TotalVertical- (TotalPerHorizontal*Buffer))/NewCanvasYSize/TotalPerFrame, 0)
--end

local TotalPerHorizontal = 2
local TotalVertical = 3
local Buffer = 0.04
local TotalPerFrame = TotalPerHorizontal*TotalVertical

local function ResizeCanvas(Scroll)
	local ScrollerSize = FRAME.Size.Y.Scale -- doing the math inside the function so it takes screen resolution / resizing into consideration
	local List = Scroll:GetChildren()
	local TotalItems = #List
	local NewCanvasYSize = math.ceil(TotalItems/TotalPerFrame)
	Scroll.CanvasSize = UDim2.new(0, 0, NewCanvasYSize*(ScrollerSize), 0)
	Scroll.UIGridLayout.CellSize = UDim2.new(1/TotalPerHorizontal - TotalPerHorizontal*Buffer, 0, (1/TotalVertical - (TotalPerHorizontal*Buffer))/NewCanvasYSize)
	Scroll.UIGridLayout.CellPadding = UDim2.new((TotalPerHorizontal*Buffer), 0, (1/TotalVertical- (TotalPerHorizontal*Buffer))/NewCanvasYSize/TotalPerFrame, 0)
end

FRAME.DescendantAdded:Connect(function() ResizeCanvas(FRAME) end)
FRAME.DescendantRemoving:Connect(function() ResizeCanvas(FRAME) end)

--local s = Instance.new("Folder", workspace)
--s.Name = "TESTVALUES"
--local H = Instance.new("NumberValue", s)
--H.Name = "TotalPerHorizontal"
--H.Value = TotalPerHorizontal
--local V = Instance.new("NumberValue", s)
--V.Name = "TotalVertical"
--V.Value = TotalVertical
--local B = Instance.new("NumberValue", s)
--B.Name = "Buffer"
--B.Value = Buffer

--local function Update()
--	TotalPerHorizontal = H.Value
--	TotalVertical = V.Value
--	Buffer = B.Value
--	TotalPerFrame = TotalPerHorizontal*TotalVertical
--	ResizeCanvas(FRAME)
--end

--for i,v in ipairs(s:GetChildren()) do
--	v:GetPropertyChangedSignal("Value"):Connect(Update)
--end
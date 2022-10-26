local Parent = script.Parent

local FRAME = Parent.ScrollingFrame

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

--[[
local s = Instance.new("Folder", workspace)
s.Name = "TEST"
local H = Instance.new("NumberValue", s)
H.Name = "TotalPerHorizontal"
H.Value = TotalPerHorizontal
local V = Instance.new("NumberValue", s)
V.Name = "TotalVertical"
V.Value = TotalPerHorizontal
local B = Instance.new("NumberValue", s)
B.Name = "Buffer"
B.Value = Buffer

local TE = workspace.TEST
local function Update()
	TotalPerHorizontal = TE.TotalPerHorizontal.Value
	TotalVertical = TE.TotalVertical.Value
	Buffer = TE.Buffer.Value
	TotalPerFrame = TotalPerHorizontal*TotalVertical
	ResizeCanvas(FRAME)
end

TE.TotalPerHorizontal:GetPropertyChangedSignal("Value"):Connect(Update)
TE.TotalVertical:GetPropertyChangedSignal("Value"):Connect(Update)
TE.Buffer:GetPropertyChangedSignal("Value"):Connect(Update) ]]
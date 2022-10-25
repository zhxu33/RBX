local DataStore = game:GetService("DataStoreService")
local FameStore = DataStore:GetOrderedDataStore("Fame")
local Board = script.Parent:WaitForChild("Board"):WaitForChild("SurfaceGui")
local Template = Board:WaitForChild("Template")
local Frame = Board:WaitForChild("MainFrame"):WaitForChild("ScrollingFrame")
local Players = game:GetService("Players")
local PlayerStore = DataStore:GetDataStore("Player")
local PermBanStore = DataStore:GetDataStore("PermBan")
local Budget = 0

function UpdateGui()
    for i,v in pairs(Frame:GetChildren()) do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end
    local Pages = FameStore:GetSortedAsync(true, 100)
    local Data = Pages:GetCurrentPage()
    local count = 0
	local index = 1
    for a,k in pairs(Data) do
--        if count <= Budget then
--            if not PermBanStore:GetAsync(k.key) then
                local PlayerName = Players:GetNameFromUserIdAsync(k.key)
                local PlayerPoints = k.value
                if PlayerPoints < 0 then
                    local NewTemp = Template:Clone()
                    NewTemp.Name  = PlayerName
                    NewTemp.FrameName.Text = PlayerName
                    NewTemp.FrameValue.Text= PlayerPoints
                    NewTemp.FrameRank.Text = "#"..index
                    NewTemp.Visible = true
                    NewTemp.Parent = Frame
					index = index + 1
                end
            end
            count = count + 1
--        end
--    end
end

UpdateGui()
while true do
    Budget = DataStore:GetRequestBudgetForRequestType(Enum.DataStoreRequestType.GetAsync)
    if Budget > 0 then
        UpdateGui()
    end
    wait(300)
end

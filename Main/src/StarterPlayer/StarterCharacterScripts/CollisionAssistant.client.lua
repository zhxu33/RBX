-- // Variables \\ --
local Debris    = game:GetService("Debris")
local Vec       = Vector3.zero
local Character = script.Parent
local Humanoid  = Character:WaitForChild("Humanoid")
local Root      = Character:WaitForChild("HumanoidRootPart")
local ObjectLoc = script:WaitForChild("3|ObjectLocations")
local Set       = script:WaitForChild("2|Settings")

-- // Settings \\ --

--|| Velocities || --
local Vel = Set:WaitForChild("1|Velocities")
local FallSpeedCatch = Vel:GetAttribute("2IMiniumFallSpeedTrigger") -- // This is the downward vecolity that will engage a extra safety net to reduce falling through the map.
local MinVelocity    = Vel:GetAttribute("2IMiniumTriggerVelocity") -- // The min of how fast a character has to go to trigger the script assistance.
local MB             = Vel:GetAttribute("2IMaxiumBounceSpeed")  -- // This is the max value a vecolity bounce back can be.

--|| Part Restrictions || --
local MSP = Set:WaitForChild("2|Part Restrictions")
local MinSizePart   = MSP:GetAttribute("1IMaxiumStudsBelow")  -- // How small a part can be to trigger the assistance.
local MaxStudsBelow = MSP:GetAttribute("1IMiniumPartSize")  -- // How small a part can be to trigger the assistance.

--|| Other || --
local Other = Set:WaitForChild("3|Other")
local RayCheckRate = Other:GetAttribute("RayCheckRate")


-- \\ Settings // --


-- // ObjectLocations \\ --
local MainMap   = ObjectLoc.MainMap
local Colliders = ObjectLoc.Colliders

Humanoid.Touched:Connect(function(P)
	if P:IsDescendantOf(MainMap.Value) and P.CanCollide and
		(Root.AssemblyLinearVelocity.Magnitude > MinVelocity or Root:FindFirstChildOfClass("BodyVelocity"))
		and (P.Size.X + P.Size.Y + P.Size.Z) > MinSizePart	
	then
		local ALV = -Root.AssemblyLinearVelocity
		ALV = Vector3.new(math.clamp(ALV.X, -MB, MB), math.clamp(ALV.Y, -MB, MB), math.clamp(ALV.Z, -MB, MB))
		Root:ApplyImpulse(ALV)
		Root.AssemblyAngularVelocity = Vec

		local Volecity = Root:FindFirstChildOfClass("BodyVelocity")
		if Volecity then
			Volecity.Parent = Character	
			task.spawn(function()
				task.wait(0.25)
				if Volecity.Parent == Character then
					Volecity.Parent = Root	
				end		
			end)
		end

		task.spawn(function()
			Root.AssemblyAngularVelocity = Vec
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			
			for i=1,10 do
				Humanoid:ChangeState(2)
				task.wait(0.2)
				local State = Humanoid:GetState()
				if State ~= 8 and State ~= 0 then
					break
				end
			end
			
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
		end)
	end
end)

local raycastParams = RaycastParams.new()                                                      
raycastParams.FilterDescendantsInstances = {workspace.NewOrganized}                                  
raycastParams.FilterType = Enum.RaycastFilterType.Whitelist

local AssistedParts = {}

while task.wait(0.1/math.clamp(Root.AssemblyAngularVelocity.Magnitude/5, 1, 3)) do
	if Root.AssemblyLinearVelocity.Magnitude > MinVelocity then
		local raycastresults = workspace:Raycast(Root.Position, Root.AssemblyLinearVelocity, raycastParams) 
		if raycastresults 
			and raycastresults.Distance/Root.AssemblyLinearVelocity.Magnitude < 0.5
			and raycastresults.Instance
			and raycastresults.Instance.Parent ~= Colliders.Value
			and not table.find(AssistedParts, raycastresults.Instance)
		then 
			local Object = raycastresults.Instance
			local OS     = Object.Size

			if ((OS.X < 2 or OS.Z < 2) or Root.AssemblyLinearVelocity.Y<-FallSpeedCatch) and OS.Y > 4 and (OS.X + OS.Y + OS.Z) > MinSizePart then
				local TempCol = Instance.new("Part")
				Debris:AddItem(TempCol, 1)
				TempCol.Anchored = true
				TempCol.Size     = Object.Size
				TempCol.CFrame   = Object.CFrame
				--TempCol.Transparency = 0.5
				TempCol.BrickColor = BrickColor.new("Really red")

				if Object.Size.X < 2 then
					TempCol.Size += Vector3.new(3-Object.Size.X, 0, 0)
				elseif Object.Size.Y < 2 then
					TempCol.Size += Vector3.new(0, 3-Object.Size.Y, 0)
				elseif Object.Size.Z < 2 then
					TempCol.Size += Vector3.new(0, 0, 3-Object.Size.Z)
				elseif Root.AssemblyLinearVelocity.Y<-FallSpeedCatch then
					TempCol.Size += Vector3.new(0,2.5,0)
					task.spawn(function()
						for i=1, 50 do
							task.wait()
							Root.AssemblyLinearVelocity-=Vector3.new(0,FallSpeedCatch/50,0)
						end
					end)
				end

				TempCol.Parent = Colliders.Value
				table.insert(AssistedParts, Object)
				task.spawn(function()
					task.wait(1)
					table.remove(AssistedParts, table.find(AssistedParts, Object))
				end)	
			end
		end
	end
end
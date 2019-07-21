-- Removes furniture from old house, records the interior and exterior locations, then destroys the old models
-- Places new house interior and exterior models at the locations of the old, sets up door clicks, etc
----------------------------------------------------------------------------------------------------------------


-- Switch House Used (on upgrade)
game.ReplicatedStorage.SwitchHouse.OnServerEvent:Connect(function(Player, price)  -- Comes from UpgradeHouseLocal
	
	local Players = game:GetService("Players")
	local houseExtTeleport = Players:FindFirstChild(Player.Name).HouseExtTeleport.Value 
	local houseIntTeleport = Players:FindFirstChild(Player.Name).HouseIntTeleport.Value 
	local moneyOwned = Player:WaitForChild('leaderstatsX').Gold.Value	
	local hstats = Player:WaitForChild('housestats')
	
	-- update housestat values
	Player:WaitForChild('leaderstatsX').Gold.Value = moneyOwned - price
	hstats:WaitForChild('HouseLevelOwned').Value = hstats:WaitForChild('HouseLevelOwned').Value + 1 	-- update the player value
	hstats:WaitForChild('HouseInteriorUsed').Value = hstats:WaitForChild('HouseInteriorUsed').Value + 1
	hstats:WaitForChild('HouseExteriorUsed').Value = hstats:WaitForChild('HouseExteriorUsed').Value + 1	

	local houseLevel = hstats:WaitForChild('HouseLevelOwned').Value
	local houseIntUsed = hstats:WaitForChild('HouseInteriorUsed').Value
	local houseExtUsed = hstats:WaitForChild('HouseExteriorUsed').Value
	
	-- Move furniture from old house into storage
	local pHouse = Player:WaitForChild('HouseInt',100).Value
	local furnitureGroup = pHouse:WaitForChild('Furniture')
	local pieces = furnitureGroup:GetChildren()
	local items = {}
	for i = 1, #pieces do
		items[i] = pieces[i].Name
	end
	game.ReplicatedStorage.StoreFurnitureRequest:InvokeClient(Player, items)  -- Goes to FurnitureInStorage localscript	
	
	
	-- Find current house models, save the locations and orientation, and get rid of them
	local houses = workspace.SpawnedHouses:GetChildren()
	for k = 2, #houses do
		if houses[k].Owner.Value == Player.Name then
			if houses[k].Name == 'House1' or houses[k].Name == 'House2' or houses[k].Name == 'House3'  then
				houseLoc1 = houses[k]:FindFirstChild('Primary').CFrame
				houses[k].Parent = nil
			elseif houses[k].Name == 'HouseExterior1' or houses[k].Name == 'HouseExterior2' or houses[k].Name == 'HouseExterior3'  then
				houseLoc2 = houses[k]:FindFirstChild('Pod Base').CFrame
				houses[k].Parent = nil
			end
		end
	end	
	
	-- Place upgraded house in the location of the old house
	if houseLoc1 and houseLoc2 then					
		-- New Exterior		
		if houseLevel == 2 then
			exteriorModel = game.ServerStorage:WaitForChild('HouseExterior2'):clone()
			exteriorModel:SetPrimaryPartCFrame(houseLoc2)
			if exteriorModel:FindFirstChild('Container Pod').Container.Orientation.Y == 0 then
				Players:FindFirstChild(Player.Name).HouseExtTeleport.Value = Vector3.new(houseLoc2.x + 8, houseLoc2.y + 4.868, houseLoc2.z)  -- spawn location is in front of door
			else
				Players:FindFirstChild(Player.Name).HouseExtTeleport.Value = Vector3.new(houseLoc2.x - 8, houseLoc2.y + 4.868, houseLoc2.z)  -- spawn location is in front of door
			end
		elseif houseLevel == 3 then
			exteriorModel = game.ServerStorage:WaitForChild('HouseExterior3'):clone()
			exteriorModel:SetPrimaryPartCFrame(houseLoc2)
			if exteriorModel:FindFirstChild('Container Pod').Container.Orientation.Y == 0 then
				Players:FindFirstChild(Player.Name).HouseExtTeleport.Value = Vector3.new(houseLoc2.x + 10, houseLoc2.y + 4.868, houseLoc2.z)  -- spawn location is in front of door
			else
				Players:FindFirstChild(Player.Name).HouseExtTeleport.Value = Vector3.new(houseLoc2.x - 10, houseLoc2.y + 4.868, houseLoc2.z)  -- spawn location is in front of door
			end
		else
			print('UHS - houseLevel = ' .. houseLevel)
		end
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel.Owner.Value = Player.Name
		exteriorModel.NameBox:WaitForChild('BillboardGui').TextLabel.Text = Player.Name			
		Player:WaitForChild("HouseExt",1000).Value = exteriorModel
		
		-- New interior
		if houseLevel == 2 then
			interiorModel = game.ServerStorage:WaitForChild('House2'):clone()
			Players:FindFirstChild(Player.Name).HouseIntTeleport.Value = Vector3.new(houseIntTeleport.x - 4, houseIntTeleport.y, houseIntTeleport.z + 5)  -- spawn location is entryway of house interior 
		elseif houseLevel == 3 then
			interiorModel = game.ServerStorage:WaitForChild('House3'):clone()
			Players:FindFirstChild(Player.Name).HouseIntTeleport.Value = Vector3.new(houseIntTeleport.x, houseIntTeleport.y, houseIntTeleport.z + 3)  -- spawn location is entryway of house interior 
		end	
		interiorModel.Parent = game.Workspace.SpawnedHouses
		interiorModel.Owner.Value = Player.Name	
		interiorModel:SetPrimaryPartCFrame(houseLoc1)
		Player:WaitForChild("HouseInt",1000).Value = interiorModel
		
		-- Get updated values
		houseExtTeleport = Players:FindFirstChild(Player.Name).HouseExtTeleport.Value 
		houseIntTeleport = Players:FindFirstChild(Player.Name).HouseIntTeleport.Value 
				
		-- Door functionality (go to outside)
		interiorModel.Door.ClickDetector.mouseClick:connect(function(playerClicked1)			
			game:GetService("ReplicatedStorage").ClickHouseDoorInt.OnServerEvent:Connect(function(playerClicked2, part)  -- Comes from OG_PC
				if playerClicked1 == playerClicked2 then
					if typeof(part) == "Instance" and part:IsA("BasePart") then
						local owner = part.Parent.Owner.Value
						
						-- Set location to teleport to	
						local houseExtTeleport = Players:FindFirstChild(owner).HouseExtTeleport.Value 
						-- Play door sound
						game.ReplicatedStorage.DoorClose:FireClient(playerClicked2)  -- Goes to PlayerAddedMisc (sound effects)
						wait(0.5) -- pause for sound
						-- Teleport
						workspace:FindFirstChild(playerClicked2.Name).HumanoidRootPart.CFrame = CFrame.new(houseExtTeleport)
					end
				end
			end)	
		end)	
			
		-- Door functionality	(go into house)
		exteriorModel.Door.ClickDetector.mouseClick:connect(function(playerClicked1, door)
			-- Listens for signals that a door has been clicked
			game:GetService("ReplicatedStorage").ClickHouseDoorExt.OnServerEvent:Connect(function(playerClicked2, part)  -- Comes from OG_PC
				if playerClicked1 == playerClicked2 then
					if typeof(part) == "Instance" and part:IsA("BasePart") then
						local owner = part.Parent.Owner.Value
						
						-- Set location to teleport to	
						local houseIntTeleport = Players:FindFirstChild(owner).HouseIntTeleport.Value 
						
						-- Check lock settings
						local lock = Players:FindFirstChild(owner):WaitForChild("housestats").HouseLock.Value
						if owner == playerClicked2.Name then
							friend = true
						else			
							friend = true
							--friend = playerClicked2:IsFriendsWith(owner.UserId)
						end	
						if lock == 'locked' and owner == playerClicked2.Name then
							-- Play door sound
							game.ReplicatedStorage.DoorClose:FireClient(playerClicked2) -- Goes to PlayerAddedMisc (sound effects)
							wait(0.5) -- pause for sound
							-- Teleport
							workspace:FindFirstChild(playerClicked2.Name).HumanoidRootPart.CFrame = CFrame.new(houseIntTeleport)	
						elseif lock == 'friends' and friend == true then 
							-- Play door sound
							game.ReplicatedStorage.DoorClose:FireClient(playerClicked2) -- Goes to PlayerAddedMisc (sound effects)
							wait(0.5) -- pause for sound
							-- Teleport
							workspace:FindFirstChild(playerClicked2.Name).HumanoidRootPart.CFrame = CFrame.new(houseIntTeleport)
						elseif lock == 'all' then 
							-- Play door sound
							game.ReplicatedStorage.DoorClose:FireClient(playerClicked2) -- Goes to PlayerAddedMisc (sound effects)
							wait(0.5) -- pause for sound
							-- Teleport
							workspace:FindFirstChild(playerClicked2.Name).HumanoidRootPart.CFrame = CFrame.new(houseIntTeleport)
						else
							print('stay')
						end				
					end
				end
			end)							
		end)
			
	end
end)


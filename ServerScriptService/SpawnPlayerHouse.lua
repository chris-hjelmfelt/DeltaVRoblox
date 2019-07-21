
local Players = game:GetService("Players")

-- Interior locations
houseInteriorArray = {}
for a = 1, 10 do
	for b = 1, 10 do
		houseInteriorArray[a*10-10+b] = Vector3.new(100000 + a*100, 9, b*100)
	end	
end	

-- Exterior locations
houseExteriorArray = {}
arrayLoc = 1

-- they spawn in a pattern that clusters houses together and towards the entrance 
for d = 1, 3 do
	for c = 5, 6 do
		houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + d*30)
		arrayLoc = arrayLoc + 1	
	end	
end

for d = 1, 3 do
	c = 4
	houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + d*30)
	arrayLoc = arrayLoc + 1	
	c = 7
	houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + d*30)
	arrayLoc = arrayLoc + 1								
end

spacer = 30
for d = 4, 6 do
	for c = 4, 7 do
		houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
		arrayLoc = arrayLoc + 1
	end	
end

spacer = 0
for d = 1, 6 do
	if d > 3 then
		spacer = 30
	end
	c = 3
	houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
	arrayLoc = arrayLoc + 1
	c = 8
	houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
	arrayLoc = arrayLoc + 1
end

spacer = 60
for d = 7, 9 do
	for c = 3, 8 do
		houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
		arrayLoc = arrayLoc + 1
	end
end

spacer = 0
for d = 1, 9 do
	if d > 3 then
		spacer = 30
	end
	if d > 6 then
		spacer = 60
	end
	for c = 1, 2 do
		houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
		arrayLoc = arrayLoc + 1
	end
	for c = 9,10 do
		houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
		arrayLoc = arrayLoc + 1
	end
end

spacer = 90
for d = 10, 12 do
	for c = 1, 10 do
		houseExteriorArray[arrayLoc] = Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30)
		arrayLoc = arrayLoc + 1
	end
end


-- Find a place for the player house interior at around 10000,0,0
function findEmptyInterior()
	for i = 1, #houseInteriorArray do	
		local count = 0
		local Point1 = Vector3.new(houseInteriorArray[i].x -50,houseInteriorArray[i].y -20,houseInteriorArray[i].z -50)
		local Point2 = Vector3.new(houseInteriorArray[i].x +50,houseInteriorArray[i].y +20,houseInteriorArray[i].z +50)
		local Region = Region3.new(Point1,Point2)
		local parts = game.Workspace:FindPartsInRegion3(Region,nil,20)
		for partIndex, part in pairs(parts) do 
			count = count + 1
		end
		if count == 0 then
			return houseInteriorArray[i]
		end
	end
end

-- Find a place for the player house in the neighborhood
function findEmptyExterior()
	for i = 1, #houseExteriorArray do	
		local count2 = 0
		local Point1 = Vector3.new(houseExteriorArray[i].x -10,houseExteriorArray[i].y -10,houseExteriorArray[i].z -10)
		local Point2 = Vector3.new(houseExteriorArray[i].x +10,houseExteriorArray[i].y +10,houseExteriorArray[i].z +10)
		local Region = Region3.new(Point1,Point2)
		local parts = game.Workspace:FindPartsInRegion3(Region,nil,20)
		for partIndex, part in pairs(parts) do 
			count2 = count2 + 1
		end
		if count2 < 3 then
			return houseExteriorArray[i]
		end
	end
end


-- When a player joins place a house in the neighborhood and an interior elsewhere
function onPlayerAdded(Player)
	wait(1)  -- wait for housestats to be updates from saved values
	-- House models used 
	local intModelUsed = Player:WaitForChild("housestats").HouseInteriorUsed.Value
	local extModelUsed = Player:WaitForChild("housestats").HouseExteriorUsed.Value
	-- Place House Interior
	local houseLoc = findEmptyInterior()	
	-- Set location for teleporting to interior door and spawn house interior
	local plrValueInt = Instance.new("Vector3Value", Player)
	plrValueInt.Name = "HouseIntTeleport"	
	if intModelUsed == 2 then
		plrValueInt.Value = Vector3.new(houseLoc.x - 6, houseLoc.y + 4.4, houseLoc.z + 10)  -- spawn location is in front of door
		interiorModel = game.ServerStorage.House2:clone()
	elseif intModelUsed == 3 then
		plrValueInt.Value = Vector3.new(houseLoc.x - 6, houseLoc.y + 4.4, houseLoc.z + 12)  -- spawn location is in front of door
		interiorModel = game.ServerStorage.House3:clone()
	else
		plrValueInt.Value = Vector3.new(houseLoc.x - 2, houseLoc.y + 4.4, houseLoc.z + 5)  -- spawn location is in front of door
		interiorModel = game.ServerStorage.House1:clone()
	end
	interiorModel.Parent = game.Workspace.SpawnedHouses
	interiorModel.Owner.Value = Player.Name	
	interiorModel:MoveTo(houseLoc)
	Player:WaitForChild('HouseInt',100).Value = interiorModel
		
		
	-- Place House Exterior
	local houseLoc2 = findEmptyExterior()
	
	-- find if the house is facing left or right 
	if houseLoc2.x == 20 or houseLoc2.x == 100 or houseLoc2.x == 180 or houseLoc2.x == -60 or houseLoc2.x == -140 then
		oriented = "left"
	else
		oriented = "right"
	end
	
	-- Place house and find X for teleporting to door
	if extModelUsed == 2 and oriented == "left" then		
		exteriorModel = game.ServerStorage.HouseExterior2:clone()		
		newx = houseLoc2.x - 8
	elseif extModelUsed == 2 and oriented == "right" then
		exteriorModel = game.ServerStorage.HouseExterior2:clone()
		exteriorModel:SetPrimaryPartCFrame(exteriorModel:FindFirstChild('Pod Base').CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0))
		newx = houseLoc2.x + 8
	elseif extModelUsed == 3 and oriented == "left" then		
		exteriorModel = game.ServerStorage.HouseExterior3:clone()
		newx = houseLoc2.x - 10
	elseif extModelUsed == 3 and oriented == "right" then
		exteriorModel = game.ServerStorage.HouseExterior3:clone()
		exteriorModel:SetPrimaryPartCFrame(exteriorModel:FindFirstChild('Pod Base').CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0))
		newx = houseLoc2.x + 10	
	elseif oriented == "left" then
		exteriorModel = game.ServerStorage.HouseExterior1:clone()		
		newx = houseLoc2.x - 5
	else
		exteriorModel = game.ServerStorage.HouseExterior1:clone()		
		exteriorModel:SetPrimaryPartCFrame(exteriorModel:FindFirstChild('Pod Base').CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0))
		newx = houseLoc2.x + 5
	end
	exteriorModel.Parent = game.Workspace.SpawnedHouses
	exteriorModel.Owner.Value = Player.Name
	--exteriorModel.Locked.Value = Player:WaitForChild("housestats").HouseLock.Value
	exteriorModel.NameBox:WaitForChild('BillboardGui').TextLabel.Text = Player.Name
	exteriorModel:MoveTo(houseLoc2)
	Player:WaitForChild('HouseExt').Value = exteriorModel
	
	-- Set exterior house colors
	wait(1)
	exteriorModel:FindFirstChild('Container Pod').Container.Color = Player:WaitForChild("housestats").HouseColor1.Value
	exteriorModel:FindFirstChild('Container Pod').Trim.Color = Player:WaitForChild("housestats").HouseColor2.Value
	exteriorModel:FindFirstChild('Container Pod').Door.Color = Player:WaitForChild("housestats").HouseColor3.Value
	exteriorModel:FindFirstChild('Container Pod'):FindFirstChild('Door Trim').Color = Player:WaitForChild("housestats").HouseColor4.Value
	
	-- Set location for teleporting to exterior door
	local plrValueExt = Instance.new("Vector3Value", Player)
	plrValueExt.Name = "HouseExtTeleport"	
	plrValueExt.Value = Vector3.new(newx, houseLoc2.y + 4.868, houseLoc2.z)  -- spawn location is in front of door

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
	exteriorModel.Door.ClickDetector.mouseClick:connect(function(playerClicked1)		
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
Players.PlayerAdded:connect(onPlayerAdded)
	



-- When a player leaves remove any house pieces that they own
function onPlayerRemoving(Player)
	local houses = workspace.SpawnedHouses:GetChildren()
	for k = 2, #houses do
		if houses[k].Owner.Value == Player.Name then
			houses[k]:Destroy()
		end
	end	
end
Players.PlayerRemoving:connect(onPlayerRemoving)



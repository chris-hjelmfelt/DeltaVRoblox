--[[ Exterior locations
houseExteriorArray = {}
arrayLoc = 1

-- This happens in a pattern that clusters houses towards the entrance together
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
]]--

--[[ spawn all
-- This happens in a pattern that clusters houses towards the entrance together
for d = 1, 3 do
	for c = 5, 6 do
		local exteriorModel = game.ServerStorage.StandardLeft:clone()
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + d*30))	
	end	
end

for d = 1, 3 do
	c = 4
	local exteriorModel = game.ServerStorage.StandardLeft:clone()
	exteriorModel.Parent = game.Workspace.SpawnedHouses
	if colcount == 3 or colcount == 6 or colcount == 9 then 
		spacer = spacer + 30
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + d*30))			
	else 			
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + d*30))
	end	
	c = 7
	local exteriorModel = game.ServerStorage.StandardLeft:clone()
	exteriorModel.Parent = game.Workspace.SpawnedHouses
	if colcount == 3 or colcount == 6 or colcount == 9 then 
		spacer = spacer + 30
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + d*30))			
	else 			
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + d*30))
	end					
end

spacer = 30
for d = 4, 6 do
	for c = 4, 7 do
		local exteriorModel = game.ServerStorage.StandardLeft:clone()
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))						
	end	
end

spacer = 0
for d = 1, 6 do
	if d > 3 then
		spacer = 30
	end
	c = 3
	local exteriorModel = game.ServerStorage.StandardLeft:clone()
	exteriorModel.Parent = game.Workspace.SpawnedHouses
	exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))
	c = 8
	local exteriorModel = game.ServerStorage.StandardLeft:clone()
	exteriorModel.Parent = game.Workspace.SpawnedHouses
	exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))
end

spacer = 60
for d = 7, 9 do
	for c = 3, 8 do
		local exteriorModel = game.ServerStorage.StandardLeft:clone()
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))
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
		local exteriorModel = game.ServerStorage.StandardLeft:clone()
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))
	end
	for c = 9,10 do
		local exteriorModel = game.ServerStorage.StandardLeft:clone()
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))
	end
end

spacer = 90
for d = 10, 12 do
	for c = 1, 10 do
		local exteriorModel = game.ServerStorage.StandardLeft:clone()
		exteriorModel.Parent = game.Workspace.SpawnedHouses
		exteriorModel:MoveTo(Vector3.new(-220 + c*40, 9, 99730 + spacer + d*30))
	end
end
]]--



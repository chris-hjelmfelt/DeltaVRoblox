-- Gets players furniture info from DataStore 
-- Places the furniture in their house and storage
-- Gets list of furniture from storage
-- Gets list of furniture and properties from player house
-- Uses JSON to save the info to DataStore
----------------------------------------------------------

local players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local dataStoreService = game:GetService("DataStoreService")
local furnitureData = dataStoreService:GetDataStore("Furniture")
local itemCount = 0


-- convert Color3 to a string - we can't put Color3 values directly into JSON
local function Color3toJsonString(myName, color)
	local colorR = math.floor(color.r * 255 + 0.5)
	local colorG = math.floor(color.g * 255 + 0.5)
	local colorB = math.floor(color.b * 255 + 0.5)
	local myString = '"' .. myName .. '":[{' .. '"R":' .. colorR .. ',"G":' .. colorG .. ',"B":' .. colorB .. '}],'
	return myString	
end


-- convert Vector3 to a string - we can't put Vector3 values directly into JSON
local function Vector3toJsonString(myName, vector)
	local vectorX = math.floor(vector.x*100 + 0.5)/100
	local vectorY = math.floor(vector.y*100 + 0.5)/100
	local vectorZ = math.floor(vector.z*100 + 0.5)/100
	local myString = '"' .. myName .. '":[{' .. '"X":' .. vectorX .. ',"Y":' .. vectorY .. ',"Z":' .. vectorZ .. '}],'		
	return myString
end


-- Save all the furniture in the players house including its name, position, rotation and colors
local function GetFurnitureInHouse(player)  -- called by this script - SaveData
	local pHouse = player:WaitForChild('HouseInt',100).Value  -- Find player house
	local owned = player:WaitForChild("NumFurniture",1000).Value  -- number of furniture items owned
	local furnitureGroup = pHouse:WaitForChild("Furniture",100) -- get the furniture group
	local primaryP = pHouse.Primary.Position  -- get interior position
	local jsonData = ''  -- We put all data into a string for json

	local eachPiece = furnitureGroup:GetChildren()  -- Go through all children
	itemCount = 1
	for i = 1, #eachPiece do		
		if itemCount > 1 then -- put a comma between items but not before thee first one
			jsonData = jsonData .. ', '
		end		
		owned = owned + 1
		jsonData = jsonData .. '"x' .. i .. '"' .. ':{'
		local theName = '"Name":"' .. eachPiece[i].Name .. '",'

		
		if eachPiece[i].ClassName == "Model" then	
			print('FS&S - Saving a model')		
			local block = eachPiece[i].Block
			if block.Position.X > 10000 then
				--print('FS&S - position.X > 10000')				
				thePos = '"Position":{"X":"' .. (math.floor(block.Position.X * 10)/10) - primaryP.X .. '","Y":"' .. math.floor(block.Position.Y * 10)/10 .. '","Z":"' .. (math.floor(block.Position.Z * 10)/10) - primaryP.Z .. '"},' 
				theRot = '"Orientation":{"X":"' .. math.floor(block.Orientation.X+10/90)*90 .. '","Y":"' .. math.floor(block.Orientation.Y+10/90)*90 .. '","Z":"' .. math.floor(block.Orientation.Z+10/90)*90 .. '"}' 
			--elseif block.Position.Z > 10000 then
				--print('FS&S - position.Z > 10000')
			--	thePos = '"Position":{"X":"' .. (math.floor(block.Position.X * 10)/10) - primary.Z .. '","Y":"' .. math.floor(block.Position.Y * 10)/10 .. '","Z":"' .. (math.floor(block.Position.Z * 10)/10) - primary.X .. '"},' 
			--	theRot = '"Orientation":{"X":"' .. math.floor(block.Orientation.X * 10)/10 .. '","Y":"' .. block.Orientation.Y .. '","Z":"' .. block.Orientation.Z .. '"}' 
			else
				--print('FS&S - position not > 10000')
				thePos = '"Position":{"X":"' .. (math.floor(block.Position.X * 10)/10) - primaryP.Z .. '","Y":"' .. math.floor(block.Position.Y * 10)/10 .. '","Z":"' .. (math.floor(block.Position.Z * 10)/10) - primaryP.Z .. '"},' 
				theRot = '"Orientation":{"X":"' .. math.floor(block.Orientation.X/10)*10 .. '","Y":"' .. math.floor(block.Orientation.Y+10/90)*90 .. '","Z":"' .. math.floor(block.Orientation.Z/10)*10 .. '"}' 
			end
		else
			print('FS&S - saving a part or union')
			if eachPiece[i].Position.X > 10000 then
				--print('FS&S - position.X > 10000')
				thePos = '"Position":{"X":"' .. (math.floor(eachPiece[i].Position.X * 10)/10) - primaryP.X .. '","Y":"' .. math.floor(eachPiece[i].Position.Y * 10)/10 .. '","Z":"' .. (math.floor(eachPiece[i].Position.Z * 10)/10) - primaryP.Z .. '"},' 
				theRot = '"Orientation":{"X":"' .. math.floor(eachPiece[i].Orientation.X * 10)/10 .. '","Y":"' .. math.floor(eachPiece[i].Orientation.Y+10/90)*90 .. '","Z":"' .. math.floor(eachPiece[i].Orientation.Z * 10)/10 .. '"}' 
			--elseif eachPiece[i].Position.Z > 10000 then
				--print('FS&S - position.Z > 10000')
			--	thePos = '"Position":{"X":"' .. (math.floor(eachPiece[i].Position.X * 10)/10) - primary.Z .. '","Y":"' .. math.floor(eachPiece[i].Position.Y * 10)/10 .. '","Z":"' .. (math.floor(eachPiece[i].Position.Z * 10)/10) - primary.X .. '"},' 
			--	theRot = '"Orientation":{"X":"' .. math.floor(eachPiece[i].Orientation.X * 10)/10 .. '","Y":"' .. eachPiece[i].Orientation.Y .. '","Z":"' .. eachPiece[i].Orientation.Z .. '"}' 
			else
				--print('FS&S - position not > 10000')
				thePos = '"Position":{"X":"' .. (math.floor(eachPiece[i].Position.X * 10)/10) - primaryP.Z .. '","Y":"' .. math.floor(eachPiece[i].Position.Y * 10)/10 .. '","Z":"' .. (math.floor(eachPiece[i].Position.Z * 10)/10) - primaryP.Z .. '"},' 
				theRot = '"Orientation":{"X":"' .. math.floor(eachPiece[i].Orientation.X * 10)/10 .. '","Y":"' .. math.floor(eachPiece[i].Orientation.Y+10/90)*90 .. '","Z":"' .. math.floor(eachPiece[i].Orientation.Z * 10)/10 .. '"}' 
			end
		end	

		jsonData = jsonData .. theName .. thePos .. theRot 
		
		if eachPiece[i].ClassName == "Model" then
			-- Not all furniture has custom colors and some have only one or two
			local firstColor = eachPiece[i]:FindFirstChild("Color1")
			local secondColor = eachPiece[i]:FindFirstChild("Color2")		
			local thirdColor = eachPiece[i]:FindFirstChild("Color3")
			
			-- If colors exist add the color3 values to jsonData
			if firstColor then
				local theColor1 = ',"Color1":{"R":"' .. firstColor.Color.r .. '","G":"' .. firstColor.Color.g .. '","B":"' .. firstColor.Color.b .. '"}' -- Color3toJsonString("Color1", firstColor.Color)		
				jsonData = jsonData .. theColor1
			end
			if secondColor then
				local theColor2 = ',"Color2":{"R":"' .. secondColor.Color.r .. '","G":"' .. secondColor.Color.g .. '","B":"' .. secondColor.Color.b .. '"}' -- Color3toJsonString("Color2", secondColor.Color)
				jsonData = jsonData .. theColor2
			end
			if thirdColor then
				local theColor3 = ',"Color3":{"R":"' .. thirdColor.Color.r .. '","G":"' .. thirdColor.Color.g .. '","B":"' .. thirdColor.Color.b .. '"}' -- Color3toJsonString("Color3", thirdColor.Color)
				jsonData = jsonData .. theColor3
			end	
		else
			local theColor = ',"Color1":{"R":"' .. eachPiece[i].Color.r .. '","G":"' .. eachPiece[i].Color.g .. '","B":"' .. eachPiece[i].Color.b .. '"}' -- Color3toJsonString("Color1", firstColor.Color)
			jsonData = jsonData .. theColor
		end
		-- Close brackets for this item	
		jsonData = jsonData .. '}'    
		itemCount = itemCount + 1
	end	
	return jsonData
end



-- Place a piece of furniture in players house  (includes position, rotation, and colors)
local function placeInHouse(player, item)  -- called by this script - AddFurniture
	local pHouse = player:WaitForChild("HouseInt",1000).Value  -- Find player house int	
	local furnitureGroup = pHouse.Furniture -- get the furniture group	
	local primaryP = pHouse.Primary.Position  -- get interior position
	local primaryS = pHouse.Primary.Position  -- get interior position
	local usedFurn = player:WaitForChild('addedtohouse')

	-- Check that the location is safely inside the house	
	if tonumber(item["Position"]["X"]) < (primaryS.X - 4)/2 and tonumber(item["Position"]["Z"]) < (primaryS.Z - 4)/2 then	

		-- clone the model
		local myModel = game.ServerStorage:FindFirstChild(item["Name"]):clone()
		myModel.Parent = furnitureGroup	
		

		if game.ServerStorage:FindFirstChild(item["Name"]).ClassName == "Model" then
			print('FS&S - loading a model')
			-- set rotation and orientation
			local cfPos = CFrame.new(item["Position"]["X"] + primaryS.X, item["Position"]["Y"], item["Position"]["Z"] + primaryS.Z)
			local cfRot = CFrame.Angles(item["Orientation"]["X"], item["Orientation"]["Y"], item["Orientation"]["Z"])
			myModel:SetPrimaryPartCFrame(cfPos * cfRot)	
			
			-- set colors
			local parts = myModel:GetChildren()
			for m = 1, #parts do
				if parts[m].Name == "Color1" then
					parts[m].Color = Color3.new(item["Color1"]["R"], item["Color1"]["G"], item["Color1"]["B"])
				elseif parts[m].Name == "Color2" then
					parts[m].Color = Color3.new(item["Color2"]["R"], item["Color2"]["G"], item["Color2"]["B"])
				elseif parts[m].Name == "Color3" then
					parts[m].Color = Color3.new(item["Color3"]["R"], item["Color3"]["G"], item["Color3"]["B"])
				end		
			end
		else
			print('FS&S - loading a part or union')
			local Pos = Vector3.new(item["Position"]["X"] + item["Position"]["Y"] + (myModel.Size.Y/2), item["Position"]["Z"] + primaryS.Z)
			local PosCF = CFrame.new(item["Position"]["X"] + primaryS.X, item["Position"]["Y"], item["Position"]["Z"] + primaryS.Z)
			local Rot = Vector3.new(item["Orientation"]["X"], item["Orientation"]["Y"], item["Orientation"]["Z"])
			myModel.Position = Pos
			myModel.Orientation = Rot
			myModel.Color = Color3.new(item["Color1"]["R"], item["Color1"]["G"], item["Color1"]["B"])
			
			-- Rugs shouldn't collide but always sit on the floor
			local itemType = myModel.Type.Value
			if itemType == "rug" then	-- rugs must be unions or parts to allow using collision groups (otherwise you won't be able to place them in small rooms)	 
				myModel.CFrame = PosCF
				myModel.Anchored = true	
			end
		end
		-- Subtract one from the furniturestat value
		local fItem = player:WaitForChild('addedtohouse', 100):WaitForChild(myModel.Name)
		fItem.Value = fItem.Value - 1
	else
		print('FS&S - part position is out of bounds')			
	end
end


-- Place remaining furniture in players storage
local function placeInStorage(player)  -- called by this script - AddFurniture
	wait(1)  -- wait for AddFurnitureStats
	local fstats = player:WaitForChild('furniturestats')	
	local ustats = player:WaitForChild('addedtohouse')
	local furnList = {}
	local count = 1

	-- compare the counts in furniture stats to the ones that show what was placed in house
	local items = fstats:GetChildren()
	local used = ustats:GetChildren()
	for m = 1, #items do				
		local leftover = items[m].Value - used[m].Value
		if leftover > 0 then
			for n = 1, leftover do 
				furnList[count] = items[m].Name
				count = count + 1
			end
		end
	end
	game.ReplicatedStorage.StoreFurnitureRequest:InvokeClient(player, furnList)  -- Goes to FurnitureInStorage localscript	
end


-- Get a list of the furniture the player owns and put into either storage or house
local function AddFurniture(player, deco)  -- called by this script -  LoadData	
	wait(1) -- wait for PlayerAddedMisc
	-- Get JSON, decode and put into house
	local furn = 0
	local furnStorageArray = {}
	for k,v in pairs(deco) do
		placeInHouse(player, deco[k])
		furn = furn + 1
	end
	-- Create a player variable to keep track of items owned
	local plrValueInt = Instance.new("IntValue", player)
	plrValueInt.Name = "ItemsOwned"	
	plrValueInt.Value = furn
end


-- Save a list of furniture the player owns to DataStore using JSON
local function SaveData(player)
	if player.userId < 0 then return end	
	local houseData = GetFurnitureInHouse(player)
	local jsonData = '{' .. houseData .. '}'
	furnitureData:SetAsync(player.userId, jsonData)	
end


-- Get a list of furniture from DataStore - it will be in JSON
local function LoadData(player)
	if player.userId < 0 then return end
	
	-- Get the full list of furniture that includes positions, colors, etc
	Passed, Error = pcall(function() json = furnitureData:GetAsync(player.userId) end) 
	assert(Passed, Error)
	if json ~= nil then
		local jsonData = HttpService:JSONDecode(json)
		AddFurniture(player, jsonData)
		wait(1)
		placeInStorage(player)
	end	
end


-- Autosave the players furniture
local function AutoSave(player)
	while true do
		wait(120)				
		SaveData(player)			
	end
end

players.PlayerAdded:connect(LoadData)
players.PlayerAdded:connect(AutoSave)
players.PlayerRemoving:connect(SaveData)


-- Example JSON
--json = '{"x1":{"Name":"TV 1"}, "x2":{"Name":"Single Bed"}, "x3":{"Name":"Dresser 1"}, "x2":{"Name":"Standard Table"}}'

--[[
-- Test Code for remote events - Works  (see FurnInStore for other half)
local function TestRemote(player)
	local result = game.ReplicatedStorage.RemoteTest:InvokeClient(player)
	print(result)
end
players.PlayerAdded:connect(TestRemote)
--]]
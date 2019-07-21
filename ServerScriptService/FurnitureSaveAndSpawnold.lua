--[[
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
local itemCount = 1


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


--Find all the furniture in the players house and get its name, position, rotation and colors
local function GetFurnitureInHouse(player)  -- called by this script - SaveData
	local pHouse = player:WaitForChild('HouseInt',100).Value  -- Find player house
	local owned = player:WaitForChild("NumFurniture",1000).Value  -- number of furniture items owned
	local furnitureGroup = pHouse:WaitForChild("Furniture",100) -- get the furniture group
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
			local block = eachPiece[i].Block
			thePos = '"Position":{"X":"' .. block.Position.X .. '","Y":"' .. block.Position.Y .. '","Z":"' .. block.Position.Z .. '"},' 
			theRot = '"Orientation":{"X":"' .. block.Orientation.X .. '","Y":"' .. block.Orientation.Y .. '","Z":"' .. block.Orientation.Z .. '"}' 
		else
			thePos = '"Position":{"X":"' .. eachPiece[i].Position.X .. '","Y":"' .. eachPiece[i].Position.Y .. '","Z":"' .. eachPiece[i].Position.Z .. '"},' 
			theRot = '"Orientation":{"X":"' .. eachPiece[i].Orientation.X .. '","Y":"' .. eachPiece[i].Orientation.Y .. '","Z":"' .. eachPiece[i].Orientation.Z .. '"}' 
		end				
		
		jsonData = jsonData .. theName .. thePos .. theRot 
		
		-- Not all furniture has custom colors and some have only one or two
		local firstColor = eachPiece[i]:FindFirstChild("Color1")
		local secondColor = eachPiece[i]:FindFirstChild("Color2")		
		local thirdColor = eachPiece[i]:FindFirstChild("Color3")
		
		-- If colors exist add the color3 values to jsonData
		if firstColor then
			theColor1 = ',"Color1":{"R":"' .. firstColor.Color.r .. '","G":"' .. firstColor.Color.g .. '","B":"' .. firstColor.Color.b .. '"}' -- Color3toJsonString("Color1", firstColor.Color)		
			jsonData = jsonData .. theColor1
		end
		if secondColor then
			theColor2 = ',"Color2":{"R":"' .. secondColor.Color.r .. '","G":"' .. secondColor.Color.g .. '","B":"' .. secondColor.Color.b .. '"}' -- Color3toJsonString("Color2", secondColor.Color)
			jsonData = jsonData .. theColor2
		end
		if thirdColor then
			theColor3 = ',"Color3":{"R":"' .. thirdColor.Color.r .. '","G":"' .. thirdColor.Color.g .. '","B":"' .. thirdColor.Color.b .. '"}' -- Color3toJsonString("Color3", thirdColor.Color)
			jsonData = jsonData .. theColor3
		end	
		-- Close brackets for this item	
		jsonData = jsonData .. '}'    
		itemCount = itemCount + 1
	end	
	return jsonData
end


--Find all the furniture in the players storage and get its name
local function GetFurnitureInStorage(player)  -- called by this script - SaveData
	local jsonData = game.ReplicatedStorage.FindFurnitureRequest:InvokeClient(player,itemCount)	-- Goes to FurnitureInStorage locslscript
	return jsonData
end


-- Place a piece furniture in players storage
local function placeInStorage(player, items)  -- called by this script - AddFurniture	
	game.ReplicatedStorage.PlaceFurnitureRequest:InvokeClient(player,items)  -- Goes to FurnitureInStorage localscript	
end


-- Place a piece of furniture in players house  (includes position, rotation, and colors)
local function placeInHouse(player, item)  -- called by this script - AddFurniture
	local pHouse = player:WaitForChild("HouseInt",1000).Value  -- Find player house int
	local owned = player:WaitForChild("NumFurniture",1000).Value  -- number of furniture items owned
	local furnitureGroup = pHouse.Furniture -- get the furniture group
	-- clone the model
	local myModel = game.ServerStorage:FindFirstChild(item["Name"]):clone()
	myModel.Parent = furnitureGroup
	myModel.Name = item["Name"]
	-- move into place (with correct rotation)
	local cfPos = CFrame.new(item["Position"]["X"], item["Position"]["Y"], item["Position"]["Z"])
	local cfRot = CFrame.Angles(item["Orientation"]["X"], item["Orientation"]["Y"], item["Orientation"]["Z"])
	print('FS&S - ' .. myModel.Name)
	myModel:SetPrimaryPartCFrame(cfPos * cfRot)	
	-- set colors
	local parts = myModel:GetChildren()
	for m = 2, #parts do
		if parts[m].Name == "Color1" then
			parts[m].Color = Color3.new(item["Color1"]["R"], item["Color1"]["G"], item["Color1"]["B"])
		elseif parts[m].Name == "Color2" then
			parts[m].Color = Color3.new(item["Color2"]["R"], item["Color2"]["G"], item["Color2"]["B"])
		elseif parts[m].Name == "Color3" then
			parts[m].Color = Color3.new(item["Color3"]["R"], item["Color3"]["G"], item["Color3"]["B"])
		end		
	end
	-- keep track of items owned
	owned = owned + 1
end


-- Get a list of the furniture the player owns and put into either storage or house
local function AddFurniture(player, deco)  -- called by this script -  LoadData
	-- wait for PlayerAddedMisc
	wait(1)
	-- Get JSON, decode and put into an array to add to storage
	local furn = 0
	local furnStorageArray = {}
	for k,v in pairs(deco) do
		if deco[k]["Position"] then
			placeInHouse(player, deco[k])
		else
			furnStorageArray[furn] = deco[k]["Name"]
			furn = furn + 1
		end
	end
	placeInStorage(player, furnStorageArray)
	-- Create a player variable to keep track of items owned
	local plrValueInt = Instance.new("IntValue", player)
	plrValueInt.Name = "ItemsOwned"	
	plrValueInt.Value = furn
end


-- Save a list of furniture the player owns to DataStore using JSON
local function SaveData(player)
	if player.userId < 0 then return end	
	local houseData = GetFurnitureInHouse(player)
	local storageData = GetFurnitureInStorage(player)
	local jsonData = '{' .. houseData .. storageData .. '}'
	--jsonData = '{"x1":{"Name":"TV 1"}, "x2":{"Name":"Mission Bed"}}'
	--print(jsonData)
	furnitureData:SetAsync(player.userId, jsonData)	
end


-- Get a list of furniture from DataStore - it will be in JSON
local function LoadData(player)
	if player.userId < 0 then return end	
	-- Get the full list of furniture that includes positions, colors, etc
	Passed, Error = pcall(function() json = furnitureData:GetAsync(player.userId) end) 
	assert(Passed, Error)
	--json=''
	--json = '{"x1":{"Name":"TV 1"}, "x2":{"Name":"Single Bed"}, "x3":{"Name":"Dresser 1"}, "x2":{"Name":"Standard Table"}}'
	if json == '' then
		json = '{"x1":{"Name":"Single Bed"}, "x2":{"Name":"Dresser 1"}, "x3":{"Name":"Standard Table"}, "x4":{"Name":"Standard Bench"}}'
	end	
	local jsonData = HttpService:JSONDecode(json)
	AddFurniture(player, jsonData)
end


-- Autosave the players furniture
local function AutoSave(player)
	while true do
		wait(60)				
		SaveData(player)			
	end
end

players.PlayerAdded:connect(LoadData)
players.PlayerAdded:connect(AutoSave)
players.PlayerRemoving:connect(SaveData)


--]]

--[[
-- Test Code for remote events - Works  (see FurnInStore for other half)
local function TestRemote(player)
	local result = game.ReplicatedStorage.RemoteTest:InvokeClient(player)
	print(result)
end
players.PlayerAdded:connect(TestRemote)
--]]
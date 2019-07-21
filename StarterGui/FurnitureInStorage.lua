
player = game.Players.LocalPlayer

-- Adds furniture to the players storage
local function onStoreFurnitureRequest(items)  -- comes from FurnitureSaveAndSpawn and UpgradeHouseServer
	local storage = player:WaitForChild("PlayerGui",100):WaitForChild("FurnitureStorage",100).Storage.ScrollingFrame  -- Find player furniture storage
	local owned = player:WaitForChild("NumFurniture",100).Value  -- number of furniture items owned
	local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
	local shop = player:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop', 100):WaitForChild('Shop'):WaitForChild('ScrollingFrame', 100)
	
	for m = 1, #items do
		local fstats = player:WaitForChild('furniturestats'):GetChildren()			
		for p = 1, #fstats do
			if items[m] == fstats[p].Name then
				fstats[p].Value = fstats[p].Value + 1	
				owned = owned + 1			
			end	
		end	
		
	end
	player:WaitForChild("NumFurniture",100).Value = owned
	return
end 
game.ReplicatedStorage.StoreFurnitureRequest.OnClientInvoke = onStoreFurnitureRequest  -- Comes from FurnitureSaveandSpawn


-- Gets a list of all furniture in the players storage
-- Need to match this format:  jsonData = {x1={Name="TV 1"}, x2={Name="Mission Bed"}}
local function onFindFurnitureRequest(itemCount)  -- comes from FurnitureSaveAndSpawn in ServerScriptService
	local storage = player:WaitForChild("PlayerGui",100):WaitForChild("FurnitureStorage",100).Storage.ScrollingFrame  -- Find player furniture storage
	local owned = player:WaitForChild("NumFurniture",100).Value  -- number of furniture items owned
	local jsonData = ''  -- We put all data into a string for json
	local eachPiece = storage:GetChildren()  -- Go through all children
	for j = 1, #eachPiece do		
		if eachPiece[j].ClassName == "ImageButton" and eachPiece[j].Name ~= "SpawnButton" then
			-- Find out the quantity of the item
			local fNum = eachPiece[j].Name .. "Q"
			fNum = tonumber(storage:FindFirstChild(fNum).Text)
			-- Add the items to jsonData
			for k = 1, fNum do
				-- put a comma between items but not before the first one
				if itemCount > 1 then   
					jsonData = jsonData .. ', '
				end			
				-- append the item to the JSON string
				jsonData = jsonData ..'"x' .. itemCount .. '":{"Name":"' .. eachPiece[j].Name .. '"}'			
				
				itemCount = itemCount + 1
				owned = owned + 1
			end
		end	
	end	
	return jsonData
end 
game.ReplicatedStorage.FindFurnitureRequest.OnClientInvoke = onFindFurnitureRequest  -- Comes from FurnitureSaveandSpawn


local function MakeFurnitureArray()  -- comes from RemoteFunction call (see below)
	local furnArray = {}
	local furnCount = 1
	local shop = player:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop', 100):WaitForChild('Shop'):WaitForChild('ScrollingFrame', 100)
	local row = shop:GetChildren()
	for i = 1, #row do
		local child = row[i]:GetChildren()
		for j = 1, #child do
			if child[j].ClassName == 'ImageButton' then
				furnArray[furnCount] = child[j].Name
				furnCount = furnCount + 1
			end	
		end
	end	
	return furnArray
end 
game.ReplicatedStorage.GetListOfAllFurniture.OnClientInvoke = MakeFurnitureArray  -- Comes from AddFurnitureStats
	
	
	
--[[
-- Test code for remote functions - Works  (see FS&S for other half)
function testRemote()
	x = "hello"
	return x
end
game.ReplicatedStorage.RemoteTest.OnClientInvoke = testRemote
--]]


--[[ more complicated version that I used briefly 
-- Adds furniture to the players storage
local function onStoreFurnitureRequest(items)  -- comes from FurnitureSaveAndSpawn and UpgradeHouseServer
	local storage = player:WaitForChild("PlayerGui",100):WaitForChild("FurnitureStorage",100).Storage.ScrollingFrame  -- Find player furniture storage
	local owned = player:WaitForChild("NumFurniture",100).Value  -- number of furniture items owned
	local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
	local shop = player:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop', 100):WaitForChild('Shop'):WaitForChild('ScrollingFrame', 100)
	
	for m = 1, #items do
		if items[m] > 0 then
			local fstats = player:WaitForChild('furniturestats'):GetChildren()			
			for p = 1, #fstats do
				if p == m then
					--put item sent into the furniture gui 					
					local row = shop:GetChildren()
					for i = 1, #row do
						local child = row[i]:GetChildren()
						for j = 1, #child do
							if child[j].ClassName == 'ImageButton' and child[j].Name == fstats[p].Name then
								for k = 1, items[m] do
									myModule.putIntoStorage(child[j].Name)
									owned = owned + 1
								end
							end	
						end
					end	
					
				end	
			end	
		end	
	end
	player:WaitForChild("NumFurniture",100).Value = owned
	return
end 
game.ReplicatedStorage.StoreFurnitureRequest.OnClientInvoke = onStoreFurnitureRequest  -- Comes from FurnitureSaveandSpawn
]]
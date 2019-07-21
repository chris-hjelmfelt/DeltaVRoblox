Player = game.Players.LocalPlayer
storage = Player:WaitForChild('PlayerGui', 100):WaitForChild('FurnitureStorage', 100).Storage
customizeExt = Player.PlayerGui:WaitForChild('CustomizeHouse',100)
customizeInt = Player.PlayerGui:WaitForChild('Customize2',100)
ExtMenu = customizeExt:WaitForChild('CustomizeMenu', 100)
-- Wait for player house to spawn
wait(1)

		
-- House door clickdetectors for Guis and color menu
local houseModule = require(workspace.Scripts.CustomizeHouse_ModuleScript)
houseModule.customize(Player)


-- Some of the Edit Furniture button functionality is in the MoveObject script (because of mtarget and other connected items)
	-- also see EditHouse_MS -> myModule.putIntoStorage to see how the gui is setup 
	-- (all functions that add new items call that module)
	

-- Furniture Storage button - see EditHouse_MS -> myModule.putIntoStorage to see how the gui is setup
customizeInt.EditDirections.Storage.MouseButton1Click:connect(function()
	-- make nothing selected
	local child = storage.ScrollingFrame:GetChildren()
	for j = 1, #child do
		if child[j].ClassName == "ImageButton" and child[j].Name ~= 'SpawnButton' then
			child[j].MouseButton1Click:connect(function()
				child[j].BorderColor3 = Color3.new(255, 255, 255)
				child[j].BorderSizePixel = 1
				storage.ScrollingFrame:WaitForChild('SpawnButton').Visible = false  
				storage:WaitForChild('LowerFrame', 100).Visible = false
			end)
		end
	end
	storage.Visible = true
end)


-- Select furniture item in storage
local child = storage.ScrollingFrame:GetChildren()
for k = 1, #child do
	if child[k].ClassName == "ImageButton" and child[k].Name ~= 'SpawnButton' then
		child[k].MouseButton1Click:connect(function()
			local previousSelect = storage.ScrollingFrame:FindFirstChild(Player:WaitForChild('FurnitureSelected', 100).Value)
			Player:WaitForChild('FurnitureSelected', 100).Value = child[k].Name
			local selected = Player:WaitForChild('FurnitureSelected', 100).Value
			child[k].BorderColor3 = Color3.new(0, 170, 0)
			child[k].BorderSizePixel = 3			
			if previousSelect then  -- unselect previous
				previousSelect.BorderColor3 = Color3.new(255, 255, 255)
				previousSelect.BorderSizePixel = 1
			end
			local myModule = require(workspace.Scripts.EditHouse_ModuleScript)							
			myModule.showSpawnButton(selected)
			--storage:WaitForChild('LowerFrame', 100).Visible = true  -- allows for selling the item
		end)
	end
end


-- Get an object out of storage
storage.ScrollingFrame:WaitForChild('SpawnButton').MouseButton1Click:connect(function()
	local furnitureSelected = Player.FurnitureSelected.Value
	local myModule = require(workspace.Scripts.EditHouse_ModuleScript)							
	myModule.getFromStorage(furnitureSelected)
	storage.ScrollingFrame.SpawnButton.Visible = false				
end)


-- Sell furniture item
storage:WaitForChild('LowerFrame',100).SellButton.MouseButton1Click:connect(function()
	print('sell item')
	--player:WaitForChild('ItemsOwned', 100).Value = player.ItemsOwned.Value - 1 
end)


-- Open exterior customize house menu
customizeExt:WaitForChild('OpenMenu'):WaitForChild('MenuButton').MouseButton1Click:connect(function()
	ExtMenu.Visible = true
end)


-- External customize menu color select buttons
ExtMenu.Color1.MouseButton1Click:connect(function()
	ExtMenu.Selected.Value = 1
	ExtMenu.Color1.BorderColor3 = Color3.new(0, 0, 255)
	ExtMenu.Color2.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color3.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color4.BorderColor3 = Color3.new(0, 0, 0)
end)
ExtMenu.Color2.MouseButton1Click:connect(function()
	ExtMenu.Selected.Value = 2
	ExtMenu.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color2.BorderColor3 = Color3.new(0, 0, 255)
	ExtMenu.Color3.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color4.BorderColor3 = Color3.new(0, 0, 0)
end)
ExtMenu.Color3.MouseButton1Click:connect(function()
	customizeExt.CustomizeMenu.Selected.Value = 3
	ExtMenu.Color1.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color2.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color3.BorderColor3 = Color3.new(0, 0, 255)
	ExtMenu.Color4.BorderColor3 = Color3.new(0, 0, 0)
end)
ExtMenu.Color4.MouseButton1Click:connect(function()
	customizeExt.CustomizeMenu.Selected.Value = 4
	ExtMenu.Color1.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color2.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color3.BorderColor3 = Color3.new(0, 0, 0)
	ExtMenu.Color4.BorderColor3 = Color3.new(0, 0, 255)
end)


-- Customize house exterior color menu buttons
local eachColor = customizeExt.CustomizeMenu.Colors:GetChildren()
for i = 1, #eachColor do						
	eachColor[i].MouseButton1Click:connect(function()
		local selected = customizeExt.CustomizeMenu.Selected.Value
		local color = eachColor[i].BackgroundColor3
		game.ReplicatedStorage.ChangeHouseColor:FireServer(color, selected)  -- goes to CustomizeHouseServer script
	end)
end	
		
		
-- House Lock
ExtMenu.Locked.MouseButton1Click:connect(function()
	lock = 'locked'
	game.ReplicatedStorage.ChangeHouseLock:FireServer(lock)
end)
ExtMenu.Friends.MouseButton1Click:connect(function()
	lock = 'friends'
	game.ReplicatedStorage.ChangeHouseLock:FireServer(lock)
end)
ExtMenu.Open.MouseButton1Click:connect(function()
	lock = 'all'
	game.ReplicatedStorage.ChangeHouseLock:FireServer(lock)
end)


-- No code after this while loop will work

-- Show exterior customize house button
while true do
	playerStanding = Player.Character.Head.Position
	if (playerStanding.X < Player:WaitForChild('HouseExtTeleport').Value.X +14) and (playerStanding.X > Player.HouseExtTeleport.Value.X -14) and (playerStanding.Z < Player.HouseExtTeleport.Value.Z +14) and (playerStanding.Z > Player.HouseExtTeleport.Value.Z -14) then
		customizeExt.OpenMenu.Visible = true
	elseif (playerStanding.X < Player.HouseExtTeleport.Value.X +50) and (playerStanding.X > Player.HouseExtTeleport.Value.X -50) and (playerStanding.Z < Player.HouseExtTeleport.Value.Z +50) and (playerStanding.Z > Player.HouseExtTeleport.Value.Z -50) and (ExtMenu.Visible == true) then
		-- leave it open if it's already open
	else
		customizeExt.OpenMenu.Visible = false
		ExtMenu.Visible = false
	end	
	wait(1)
end
	
	



	
-- Old customization stuff
----------------------------------
--[[
-- Edit Menu Buttons
editMenu = Player:WaitForChild('PlayerGui'):WaitForChild('Customize').EditMenu
local child = editMenu:GetChildren()
for i = 1, #child do
	if child[i].Name ~= 'Close' then
		child[i].MouseButton1Click:connect(function()
			editMenu.Parent:FindFirstChild("ColorChange").Visible = false
			editMenu.Parent:FindFirstChild("PosterChange").Visible = false
			editMenu.Parent:FindFirstChild("TextureChange").Visible = false
			editMenu.Parent:FindFirstChild("LockChange").Visible = false
			if child[i].Name == 'BlanketColor' then
				Player.Item.Value = "blanketcolor"
				editMenu.Parent:FindFirstChild("ColorChange").Visible = true
			elseif child[i].Name == 'BlanketTexture' then
				Player.Item.Value = "blankettexture"
				editMenu.Parent:FindFirstChild("TextureChange").Visible = true
			elseif child[i].Name == 'Lock' then
				Player.Item.Value = ""
				editMenu.Parent:FindFirstChild("LockChange").Visible = true
			elseif child[i].Name == 'Logbook' then
				Player.Item.Value = "logbook"
				editMenu.Parent:FindFirstChild("ColorChange").Visible = true
			elseif child[i].Name == 'Poster' then
				Player.Item.Value = "poster1"
				editMenu.Parent:FindFirstChild("PosterChange").Visible = true
			end
		end)
	end
end


-- Color Change
colorChange = Player:WaitForChild('PlayerGui'):WaitForChild('Customize').ColorChange
local child = colorChange:GetChildren()
for i = 1, #child do
	if child[i].Name ~= 'Close' then
		child[i].MouseButton1Click:connect(function()
			local item = Player.Item.Value
			local color = child[i].BackgroundColor3			
			game.ReplicatedStorage.House:FireServer(item, color)
		end)
	end
end

 
-- Poster Change
posterChange = Player:WaitForChild('PlayerGui'):WaitForChild('Customize').PosterChange
local child = posterChange:GetChildren()
for i = 1, #child do
	if child[i].Name ~= 'Close' then
		child[i].MouseButton1Click:connect(function()
			local item = Player.Item.Value
			local image = child[i].Image
			game.ReplicatedStorage.House:FireServer(item, image)
		end)
	end
end


-- Texture Change 
textureChange = Player:WaitForChild('PlayerGui'):WaitForChild('Customize').TextureChange
local child = textureChange:GetChildren()
for i = 1, #child do
	if child[i].Name ~= 'Close' then
		child[i].MouseButton1Click:connect(function()
			local item = Player.Item.Value
			local texture = child[i].Name
			game.ReplicatedStorage.House:FireServer(item, texture)
		end)
	end
end


-- Set House Lock
lock = Player:WaitForChild('PlayerGui'):WaitForChild('Customize').LockChange
lock:WaitForChild('Locked').MouseButton1Click:connect(function()
	locked = 'locked'
	game.ReplicatedStorage.Lock:FireServer(locked)	
end)

lock:WaitForChild('Friends').MouseButton1Click:connect(function()	
	locked = 'friends'
	game.ReplicatedStorage.Lock:FireServer(locked)			
end)

lock:WaitForChild('All').MouseButton1Click:connect(function()	
	locked = 'all'				
	game.ReplicatedStorage.Lock:FireServer(locked)			
end)
]]


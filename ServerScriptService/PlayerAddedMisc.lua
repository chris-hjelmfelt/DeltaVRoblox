local Players = game:GetService("Players")

-- When a player joins place a house in the neighborhood and an interior elsewhere
function onPlayerAdded(player)	
	
	
	-- Give starter gold  (uses statusstats)
	local first = player:WaitForChild('statusstats',100):WaitForChild('FirstTime').Value -- first time in game
	if first == true then 
		print('PlayerAddedMisc - first time')
		player:WaitForChild('leaderstatsX').Gold.Value = player.leaderstats.Gold.Value + 200	
		player.statusstats.FirstTime.Value = false		
	end
			
	-- Keyboard input for their answers to science problems	
	local plrValueInt = Instance.new("StringValue", player)
	plrValueInt.Name = "Answer"	
	plrValueInt.Value = "0"
	
	-- Limit zoom out distance
	player.CameraMaxZoomDistance = 30
	
	-- Furniture part selected for color
	local customizeItem = Instance.new("StringValue", player)
	customizeItem.Name = "Item"	
	customizeItem.Value = "Color1"
	
	-- Furniture part selected in storage Gui  (used by MoveObject & CustomizeHouseLocal)
	local customizeItem = Instance.new("StringValue", player)
	customizeItem.Name = "FurnitureSelected"
	
	-- House interior and exterior		(used in many scripts)
	local houseInt = Instance.new("ObjectValue", player)
	houseInt.Name = "HouseInt"	
	local houseExt = Instance.new("ObjectValue", player)
	houseExt.Name = "HouseExt"	
	
	-- House Teleport Locations (inside the spawn house and upgrade house scripts currently)
	
	-- Number of furniture items added to JSON string	 (used by FS&S GetFurnitureInHouse)
	local plrValueInt = Instance.new("IntValue", player)
	plrValueInt.Name = "NumFurniture"	
	plrValueInt.Value = "0"
	
	-- Number of total furniture items owned	 (used by PurchaseFurniture & CustomizeHouseLocal)
	local plrValueInt = Instance.new("IntValue", player)
	plrValueInt.Name = "ItemsOwned"	
	plrValueInt.Value = "0"
	
end
Players.PlayerAdded:connect(onPlayerAdded)


-----------------------------------------------
-- Relays for Client to Client Remote Events --
-----------------------------------------------

-- Sound Effects
-------------------
-- Door close sound
game.ReplicatedStorage.DoorClose.OnServerEvent:Connect(function(player)  -- comes from OpenGui_PartCliked (teleport to house) and Spawn Player House script (place house interior)
	game.ReplicatedStorage.DoorClose:FireClient(player)  -- goes to PlaySounds script in the StarterGui
end)


-- Science Problems Answered
-------------------------------
-- Correct Answer to Problem 
game.ReplicatedStorage.MathAnsweredCorrectly.OnServerEvent:Connect(function(player) -- comes from CheckAnswer_ModuleScript (FixMath)
	game.ReplicatedStorage.MathAnsweredCorrectly:FireClient(player)  -- goes to FixObject script
end)
-- Correct Answer to Problem 
game.ReplicatedStorage.ElectricalAnsweredCorrectly.OnServerEvent:Connect(function(player) -- comes from CheckAnswer_ModuleScript (FixElectrical)
	game.ReplicatedStorage.ElectricalAnsweredCorrectly:FireClient(player)  -- goes to FixObject2 script
end)


-- House Related
-------------------
-- Confirm Furniture Purchase
game.ReplicatedStorage.PurchaseFurniture.OnServerEvent:Connect(function(player)	  -- comes from PurchaseFurniture script			
	game.ReplicatedStorage.PurchaseFurniture:FireClient(player) 	-- goes to PurchaseFurniture script			
end)

--[[ not using anymore
-- Confirm House Purchase
game.ReplicatedStorage.PurchaseHouse1.OnServerEvent:Connect(function(player) -- comes from UpgradeHouseLocal (confirm button)
	game.ReplicatedStorage:WaitForChild('PurchaseHouse1'):FireClient(player)  -- goes UpgradeHouseLocal script (housing upgrades)
end)
game.ReplicatedStorage.PurchaseHouse2.OnServerEvent:Connect(function(player) -- comes from UpgradeHouseLocal (confirm button)
	game.ReplicatedStorage:WaitForChild('PurchaseHouse2'):FireClient(player)  -- goes UpgradeHouseLocal script (housing upgrades)
end)
]]



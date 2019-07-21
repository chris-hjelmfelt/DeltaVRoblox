-- Shows guis, handles buttons, allows house purchase
-- Switches the houses - places furniture in storage, replaces models interior and exterior

-- Variables
Player = game.Players.LocalPlayer
office = game.Workspace:WaitForChild('Neighborhood'):FindFirstChild('Housing Office')
menu = Player:WaitForChild('PlayerGui'):WaitForChild('HousingOffice', 1000).Menu
houseLevel = Player:WaitForChild('housestats').HouseLevelOwned.Value
houseIntUsed = Player:WaitForChild('housestats').HouseInteriorUsed.Value
houseExtUsed = Player:WaitForChild('housestats').HouseExteriorUsed.Value
moneyOwned = Player:WaitForChild('leaderstatsX').Gold


-- Show Upgrade Gui
function openUpgrades()
	menu.Visible = true
	if houseLevel == 1 then
		menu.Upgrade1.Price.Visible = true
		menu.Upgrade1.NotYet.Visible = false
		menu.Upgrade1.Overlay.Visible = false
		menu.Upgrade2.Price.Visible = false
		menu.Upgrade2.NotYet.Visible = true
		menu.Upgrade2.Overlay.Visible = false
	end
	if houseLevel == 2 then
		menu.Upgrade1.Price.Visible = false
		menu.Upgrade1.NotYet.Visible = false
		menu.Upgrade1.Overlay.Visible = true
		menu.Upgrade2.Price.Visible = true
		menu.Upgrade2.NotYet.Visible = false
		menu.Upgrade2.Overlay.Visible = false
	end
	if houseLevel >= 3 then
		menu.Upgrade1.Price.Visible = false
		menu.Upgrade1.NotYet.Visible = false
		menu.Upgrade1.Overlay.Visible = true
		menu.Upgrade2.Price.Visible = false
		menu.Upgrade2.NotYet.Visible = false
		menu.Upgrade2.Overlay.Visible = true
	end
end
office.Hank.Head.ClickDetector.MouseClick:Connect(openUpgrades)
office.Hank.Torso.ClickDetector.MouseClick:Connect(openUpgrades)
office.Hank.Fedora.ClickDetector.MouseClick:Connect(openUpgrades)
office.Counter.ClickDetector.MouseClick:Connect(openUpgrades)
--game.Workspace:WaitForChild('Neighborhood'):FindFirstChild('TestUpgrade').ClickDetector.MouseClick:Connect(openUpgrades)

-- Housing Upgrades button functionality
menu.Upgrade1.Price.MouseButton1Click:connect(function()
	if moneyOwned.Value >= tonumber(menu.Upgrade1.Price.Text) then  -- If player can afford the house
		menu.Upgrade1.Confirm.Visible = true  -- Confirm to buy
		menu.Upgrade1.Confirm.Price.Text = menu.Upgrade1.Price.Text
		
	end	
end)
menu.Upgrade2.Price.MouseButton1Click:connect(function()
	if moneyOwned.Value >= tonumber(menu.Upgrade2.Price.Text) then  -- If player can afford the house
		menu.Upgrade2.Confirm.Visible = true  -- Confirm to buy
		menu.Upgrade2.Confirm.Price.Text = menu.Upgrade2.Price.Text
		--[[ not using anymore (was used in above function as well)
		game.ReplicatedStorage.PurchaseHouse2.OnClientEvent:Connect(function()  -- this come from to PlayerAddedMisc
			moneyOwned.Value = moneyOwned.Value - tonumber(menu.Upgrade2.Price.Text)  -- pay for the house
			-- change Housestat data values
			houseLevel = 3  
			houseIntUsed = 3
			houseExtUsed = 3
			openUpgrades()  -- refreshes the upgrade menu
			game.ReplicatedStorage:WaitForChild('SwitchHouse'):FireServer(houseLevel) -- Goes to UpgradeHouseServer
			wait(1)
			-- House door click detectors for Guis and house color menu
			local houseModule = require(workspace.Scripts.CustomizeHouse_ModuleScript)
			houseModule.customize(Player)
		end)
		]]
	end	
end)


-- Confirm button functionality
menu.Upgrade1.Confirm.Yes.MouseButton1Click:connect(function()
	menu.Upgrade1.Confirm.Visible = false
	local price = tonumber(menu.Upgrade1.Price.Text)	
	game.ReplicatedStorage:WaitForChild('SwitchHouse'):FireServer(price)  -- Goes to UpgradeHouseServer	and SaveHouseData
	houseLevel = 2
	openUpgrades()  -- refreshes the upgrade menu
	wait(1)
	-- House door click detectors for Guis and house color menu
	local houseModule = require(workspace.Scripts.CustomizeHouse_ModuleScript)
	houseModule.customize(Player)
	--game.ReplicatedStorage:WaitForChild('PurchaseHouse1'):FireServer(Player)	-- this goes to PlayerAddedMisc
	print('UHL - houselevel after purchase')
	print(Player:WaitForChild('housestats'):WaitForChild('HouseLevelOwned').Value)
end)
menu.Upgrade1.Confirm.No.MouseButton1Click:connect(function()
	menu.Upgrade1.Confirm.Visible = false
end)

menu.Upgrade2.Confirm.Yes.MouseButton1Click:connect(function()
	menu.Upgrade2.Confirm.Visible = false
	local price = tonumber(menu.Upgrade2.Price.Text)
	game.ReplicatedStorage:WaitForChild('SwitchHouse'):FireServer(price)  -- Goes to UpgradeHouseServer
	houseLevel = 3
	openUpgrades()  -- refreshes the upgrade menu
	wait(1)
	-- House door click detectors for Guis and house color menu
	local houseModule = require(workspace.Scripts.CustomizeHouse_ModuleScript)
	houseModule.customize(Player)
	--game.ReplicatedStorage:WaitForChild('PurchaseHouse2'):FireServer(Player)	-- this goes to PlayerAddedMisc
end)
menu.Upgrade2.Confirm.No.MouseButton1Click:connect(function()
	menu.Upgrade2.Confirm.Visible = false
end)



-- Teleport Home Gui Buttons
homeButton = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('SkillsGui',100).Teleport.Home
homeButton.MouseButton1Click:connect(function()
	local houseExtTeleport = Player.HouseExtTeleport.Value
	workspace:FindFirstChild(Player.Name).HumanoidRootPart.CFrame = CFrame.new(houseExtTeleport)
	-- Close any open Guis	
	local closeModule = require(workspace.Scripts.EditHouse_ModuleScript)
	closeModule.closeAllGuis(Player)
end)


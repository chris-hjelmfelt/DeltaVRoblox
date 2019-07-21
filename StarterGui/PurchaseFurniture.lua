-- Purchasing Furniture
-----------------------------

-- Variables
local player = game.Players.LocalPlayer
local maxItems = 200  -- players cannot own unlimited furniture items
bigX = 10  -- Used in finding existing button positions in the storage gui
bigY = 0  -- Used in finding existing button positions in the storage gui
cost = '0'
furnitureItem = game.ReplicatedStorage.Bin


-- wait for other scripts
wait(1) 
playerGold = player:WaitForChild('leaderstatsX', 100).Gold  -- in testing we add gold so put it after the wait


-- Open Furniture Store gui
local furnitureStore = game.Workspace.Neighborhood:WaitForChild('Furniture Store')
furnitureStore.Counter.ClickDetector.MouseClick:Connect(function(Player)
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.Visible = true
end)
furnitureStore.Gilberto.Head.ClickDetector.MouseClick:Connect(function(Player)
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.Visible = true	
end)
furnitureStore.Gilberto.UpperTorso.ClickDetector.MouseClick:Connect(function(Player)
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.Visible = true	
end)	
furnitureStore.Gilberto.LowerTorso.ClickDetector.MouseClick:Connect(function(Player)
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.Visible = true	
end)	


-- Purchase Furniture Button
confirm1 = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Confirm
confirm1.Yes.MouseButton1Click:connect(function()		
	game.ReplicatedStorage.PurchaseFurniture:FireServer(cost, furnitureItem.Name)  --goes to ChangeStats, SaveLeaderstatsData, and SaveFurnitureData
	local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
	myModule.putIntoStorage(furnitureItem.Name)
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Confirm.Visible = false		
end)


-- Close confirmation box
confirm1.No.MouseButton1Click:connect(function()	
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Confirm.Visible = false	
end)


-- Furniture Shop Buttons
shop = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.ScrollingFrame
local row = shop:GetChildren()
for i = 1, #row do
	local child = row[i]:GetChildren()
	for j = 1, #child do
		if child[j].ClassName == "ImageButton" then
			child[j].MouseButton1Click:connect(function()
				furnitureItem = child[j]
				cost = row[i]:FindFirstChild(furnitureItem.Name .. "2").Text  -- find cost
				
				-- Check for max items owned
				local itemsOwned = player:WaitForChild('ItemsOwned', 100).Value
				if itemsOwned < maxItems then				
					-- If player has enough let them buy it
					if playerGold.Value >= tonumber(cost) then
						game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Confirm.Visible = true		
						game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Confirm.Cost.Text = cost					
					else  -- message about not enough money
						game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Message.Visible = true
						wait(2)
						game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Message.Visible = false
					end
				else
					game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').TooManyItems.Visible = true	
					wait(2)
					game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').TooManyItems.Visible = false
				end
			end)	
		end		
	end
end



--[[  Now doing this all through EditHouse_modulescript
-- Add purchased furniture to furniture storage
function addStorageItem(purchased)
	-- See if there is already one in storage
	local storage = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureStorage').Storage
	local textQ = storage.ScrollingFrame:FindFirstChild(purchased.Name .. "Q")
	local child2 = storage.ScrollingFrame:GetChildren()
	local newItem = true	
	for n = 1, #child2 do
		if child2[n].ClassName == "ImageButton" then
			if child2[n].Name == purchased.Name then
				newItem = false
				-- Increase the quantity available
				textQ = storage.ScrollingFrame:FindFirstChild(purchased.Name .. "Q")
				textQ.Text = tonumber(textQ.Text) + 1
			end
		end
	end	
	
	-- Add an image button to storage gui
	if newItem == true then
		-- Find the position to place it at			
		--lastButton() -- position of last button
		local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
		bigX, bigY = myModule.lastButton(storage, bigX, bigY)
		if bigX == 10 then  -- get position of new button and quantity of item
			newPosition = UDim2.new(0, 150, 0, bigY)
			textPosition = UDim2.new(0, 150, 0, bigY + 102)
		else
			newPosition = UDim2.new(0, 10, 0, bigY + 120)
			textPosition = UDim2.new(0, 10, 0, bigY + 222)
		end		
		-- Create object button
		local imageButton = Instance.new("ImageButton")
		imageButton.Parent = storage.ScrollingFrame
		imageButton.Name = purchased.Name	
		imageButton.Size = UDim2.new(0, 120, 0, 100)		
		imageButton.Position = newPosition
		imageButton.BackgroundColor3 = BrickColor.White().Color
		imageButton.Image = ""
		-- Create quantity text
		local quantityText = Instance.new("TextLabel")
		quantityText.Parent = storage.ScrollingFrame
		quantityText.Name = purchased.Name .. "Q"
		quantityText.Size = UDim2.new(0, 120, 0, 16)
		quantityText.Position = textPosition 
		quantityText.Text = "1"
		quantityText.BackgroundColor3 = BrickColor.White().Color
		quantityText.BorderSizePixel = 0
		quantityText.TextXAlignment = "Right"
		-- Effect of button when clicked
		imageButton.MouseButton1Click:connect(function()
			local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
			myModule.getFromStorage(imageButton, storage, bigX, bigY)
		end)
	end
end
--]]

--[[  I hid this gui so I could just have them purchase through the furniture shop for right now
-- Open Shop gui
openShop = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').OpenShop
openShop.Open.MouseButton1Click:connect(function()	
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.Visible = true	
end)
]]
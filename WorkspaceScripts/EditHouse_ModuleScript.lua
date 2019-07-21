player = game.Players.LocalPlayer
storeGui = player:WaitForChild('PlayerGui'):WaitForChild('FurnitureStorage').Storage
storage = storeGui.ScrollingFrame
local debounce = false
local firstItem = true
local testMessageIncrimentor = 0

local myModule = {}
	-- Move the object
	function myModule.moveObject(Player, mouse, mtarget, move, gsize, xMax, xMin, zMax, zMin, wallGroup)
		if mtarget and move == true then
			local previousPos = mtarget.Position
			local posY = mtarget.Size.Y/2 + 11
			
			-- Check object rotation
			if mtarget.Orientation.Y == 0 or mtarget.Orientation.Y == 180 then
				targetSizeX = mtarget.Size.X
				targetSizeZ = mtarget.Size.Z
			else
				targetSizeX = mtarget.Size.Z
				targetSizeZ = mtarget.Size.X
			end		
			-- round off to nearest grid step
			if (targetSizeX/gsize)%(gsize/2) == 0 then
				remainderX = mouse.Hit.X % gsize		
			else
				remainderX = (mouse.Hit.X + gsize/2) % gsize			
			end
			if (targetSizeZ/gsize)%(gsize/2) == 0 then
				remainderZ = mouse.Hit.Z % gsize			
			else
				remainderZ = (mouse.Hit.Z + gsize/2) % gsize			
			end	
			-- move to position on grid	
			if remainderX > gsize/2 then
				posX = mouse.Hit.X + (gsize - remainderX - gsize/2)
			else
				posX = mouse.Hit.X - remainderX
			end
			if remainderZ > gsize/2 then
				posZ = mouse.Hit.Z + (gsize - remainderZ - gsize/2)
			else
				posZ = mouse.Hit.Z - remainderZ
			end
			
					
			-- Check for things getting lost in the walls and then place object
			if (posX <= xMax - targetSizeX/2) and (posX >= xMin + targetSizeX/2) and (posZ <= zMax - targetSizeZ/2) and (posZ >= zMin + targetSizeZ/2) then
				-- check for door space and intersection with interior walls
				--if (posX <= playerInt.X -2 - targetSizeX/2) and (posX >= playerInt.X +2 + targetSizeX/2) and (posZ <= playerInt.Z -2 - targetSizeZ/2) and (posZ >= playerInt.Z +2 + targetSizeZ/2) then
					-- don't allow placement in front of door
				--else		
					game:GetService("ReplicatedStorage").MoveFurniture:FireServer(mtarget, posX, posY, posZ, testMessageIncrimentor)	-- goes to EditHouse
					testMessageIncrimentor = testMessageIncrimentor + 1
				--end					
			end				
			
			
			--Posters, wall lights, etc. must be against a wall
			if itemType == "wall" then
				local mtX = mtarget.Position.X + mtarget.Size.X/2
				local mtZ = mtarget.Position.Z + mtarget.Size.Z/2
				local onWall = false
				local eachWall = wallGroup:GetChildren()
				for w = 1, #eachWall do
					local side = false  -- orientation of wall
					if eachWall[w].Size.Z == 2 then
						side = true
					end
					if side == true and mtX == eachWall[w].Position.X + 1 then
						print('EditHouse_MS - this might be touching on X axis')
						onWall = true
					end
					if side == false and mtZ == eachWall[w].Position.Z + 1 then
						print('EditHouse_MS - this might be touching on Z axis')
						onWall = true
					end
				end
				if mtarget.Parent.Name == "Furniture" and onWall == false then
					mtarget.Position = previousPos
				elseif onWall == false then
					mtarget.Parent:MoveTo(previousPos)
				end
			end
		else		
		end
	end
		
	
	-- Rotate the object
	function myModule.rotateObject(mtarget, inputObject)		
		if mtarget and (inputObject.KeyCode == Enum.KeyCode.R) then	
			game:GetService("ReplicatedStorage").RotateFurniture:FireServer(mtarget)	-- goes to EditHouse
		end		
	end
	
	
	-- Get an object from Storage
	function myModule.getFromStorage(child)  -- called from CustomizeHouseLocal and this script (PutIntoStorage() - for new item storage button functionality)
		if debounce == false then  -- it was trying to run twice in some cases
			debounce = true 
			local newItem = child.Name	
			if newItem == nil then
				newItem = child
			end	
			game.ReplicatedStorage.SpawnItem:FireServer(newItem)   -- goes to EditHouse script (Spawn an object)
			-- Hide the Gui so the player can move and customize the item
			game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureStorage').Storage.Visible = false
			-- Reset select furniture item
			local currentItem = storage:WaitForChild(newItem,100)
			currentItem.BorderColor3 = Color3.new(255, 255, 255)
			currentItem.BorderSizePixel = 1
			storage.SpawnButton.Visible = false
			-- Update storage gui 	
			local textQ = storage:WaitForChild(newItem .. "Q",100)
			if tonumber(textQ.Text) > 1 then
				textQ.Text = tonumber(textQ.Text) - 1
			else
				-- Remove the item button from storage
				-- local finalItem = lastButton() -- find the position of last item in storage
				local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
				bigX, bigY, finalItem = myModule.lastButton()
				if finalItem == "" or newItem == finalItem.Name then
					currentItem.Parent = nil -- delete the button
					textQ.Parent = nil
				else 					
					-- place the button for the last item in the location of the one you are removing
					storage:FindFirstChild(finalItem.Name).Position = currentItem.Position						
					storage:FindFirstChild(finalItem.Name .. "Q").Position = textQ.Position					
					-- delete the button and quantity for the object you are removing
					currentItem.Parent = nil 
					textQ.Parent = nil  
				end
			end
			wait(.2)
			debounce = false 
		end 
	end
	
	
	-- Put an object into storage    - called by MoveObject, FurnitureInStorage
	function myModule.putIntoStorage(object)		
		-- See if there is already one in storage
		local child = storage:GetChildren()
		local newItem = true	
		for n = 1, #child do
			if child[n].ClassName == "ImageButton" then
				if child[n].Name == object then
					newItem = false
					-- Increase the quantity available
					textQ = storage:FindFirstChild(object .. "Q")
					textQ.Text = tonumber(textQ.Text) + 1
				else					
					-- Do nothing (it will hit this lots of times as it goes through the list)
				end
			end
		end	
		
		-- Add an image button to storage gui
		if newItem == true then
			-- Find the position to place it at		
			local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
			bigX, bigY = myModule.lastButton()
			if bigX == 10 and firstItem == true then  -- get position of new button and quantity of item
				newPosition = UDim2.new(0, 10, 0, bigY)
				textPosition = UDim2.new(0, 10, 0, bigY + 102)
			elseif bigX == 10 and firstItem == false then
				newPosition = UDim2.new(0, 150, 0, bigY)
				textPosition = UDim2.new(0, 150, 0, bigY + 102)
			else
				newPosition = UDim2.new(0, 10, 0, bigY + 120)
				textPosition = UDim2.new(0, 10, 0, bigY + 222)
			end		
			
			-- Create object button
			local imageButton = Instance.new("ImageButton")
			imageButton.Parent = storage
			imageButton.Name = object	
			imageButton.Size = UDim2.new(0, 120, 0, 100)		
			imageButton.Position = newPosition
			imageButton.BackgroundColor3 = BrickColor.White().Color
			
			-- Use the Furniture Shop Gui to find the image
			local shop = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureShop').Shop.ScrollingFrame
			local row = shop:GetChildren()
			for n = 1, #row do
				local itemImage = row[n]:GetChildren()
				for p = 1, #itemImage do
					if itemImage[p].ClassName == "ImageButton" then
						if itemImage[p].Name == object then
							imageButton.Image = itemImage[p].Image
						end
					end
				end
			end		
			
			-- Create quantity text
			local quantityText = Instance.new("TextLabel")
			quantityText.Parent = storage
			quantityText.Name = object .. "Q"
			quantityText.Size = UDim2.new(0, 120, 0, 16)
			quantityText.Position = textPosition 
			quantityText.Text = 1
			quantityText.BackgroundColor3 = BrickColor.White().Color
			quantityText.BorderSizePixel = 0
			quantityText.TextXAlignment = "Right"
			
			-- Effect of button when clicked
			imageButton.MouseButton1Click:connect(function()
				local previousSelect = storage:FindFirstChild(player:WaitForChild('FurnitureSelected', 100).Value)
				player:WaitForChild('FurnitureSelected', 100).Value = imageButton.Name
				local selected = player:WaitForChild('FurnitureSelected', 100).Value
				imageButton.BorderColor3 = Color3.new(0, 170, 0)
				imageButton.BorderSizePixel = 3
				if previousSelect then  -- unselect previous
					previousSelect.BorderColor3 = Color3.new(255, 255, 255)
					previousSelect.BorderSizePixel = 1
				end
				local myModule = require(workspace.Scripts.EditHouse_ModuleScript)							
				myModule.showSpawnButton(selected)  
				storeGui:WaitForChild('LowerFrame', 100).Visible = true
			end)
		end
	end
	
	
	-- Find the last button in the storage gui
	function myModule.lastButton()
		local buttons = storage:GetChildren()
		bigX = 10
		bigY = 0
		local lastItem = ""
		firstItem = true -- See if storage is empty
		for m = 1, #buttons do
			if buttons[m].ClassName == "ImageButton" and buttons[m].Name ~= 'SpawnButton' then
				firstItem = false
				if bigY < buttons[m].Position.Y.Offset then
					bigY = buttons[m].Position.Y.Offset
					bigX = buttons[m].Position.X.Offset
					lastItem = buttons[m]
				elseif bigY == buttons[m].Position.Y.Offset then
					if bigX < buttons[m].Position.X.Offset then
						bigX = buttons[m].Position.X.Offset
						lastItem = buttons[m]
					end
				end				
			end
		end
		return bigX, bigY, lastItem		
	end
	
	
	function myModule.showSpawnButton(selected)   -- called by CustomizeHouseLocal and this script (putIntoStorage)
		local button = storage:WaitForChild('SpawnButton')	-- button code in CustomizeHouseLocal
		local itemSelected = storage:FindFirstChild(selected)
		local xOff = itemSelected.Position.X.Offset + 70
		local yOff = itemSelected.Position.Y.Offset + 50
		button.Position = UDim2.new(0,xOff,0,yOff)
		button.Visible = true  -- Get item out of storage code in CustomizeHouseLocal
	end	
	
	
	function myModule.closeAllGuis(player)
		-- Welcome
		game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('WelcomeGui').Welcome.Visible = false
		-- Edit house
		game.Players.LocalPlayer.PlayerGui:WaitForChild('Customize2').ColorChange.Visible = false
		game.Players.LocalPlayer.PlayerGui.Customize2.EditButton.Visible = false
		game.Players.LocalPlayer.PlayerGui.Customize2.EditDirections.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('FurnitureStorage').Storage.Visible = false
		-- Furniture Shop 
		game.Players.LocalPlayer.PlayerGui:WaitForChild('FurnitureShop').Confirm.Visible = false
		game.Players.LocalPlayer.PlayerGui.FurnitureShop.Message.Visible = false
		game.Players.LocalPlayer.PlayerGui.FurnitureShop.OpenShop.Visible = false
		game.Players.LocalPlayer.PlayerGui.FurnitureShop.Shop.Visible = false
		-- Housing Office
		game.Players.LocalPlayer.PlayerGui:WaitForChild('HousingOffice').Menu.Visible = false
		-- Science 
		-- Chemistry
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ChemistryBook').Page1.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ChemistryGui').Problem.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ChemistryHowTo').Page1.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ChemistryPTable').Page1.Visible = false
		-- Cryptography
		game.Players.LocalPlayer.PlayerGui:WaitForChild('CryptoGui').Problem.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('CryptoGui2').Problem.Visible = false
		-- Electrical
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ElectricalBook').Page1.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ElectricalFixObject').Broken.Visible = false
		game.Players.LocalPlayer.PlayerGui.ElectricalFixObject.DoAnother.Visible = false
		game.Players.LocalPlayer.PlayerGui.ElectricalFixObject.Problem.Visible = false
		game.Players.LocalPlayer.PlayerGui.ElectricalFixObject.Yes.Visible = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild('ElectricalGui').Problem.Visible = false
		-- Math
		game.Players.LocalPlayer.PlayerGui:WaitForChild('Math'):WaitForChild('Dialog').Hello.Visible = false
		game.Players.LocalPlayer.PlayerGui.Math:WaitForChild('FixObject').Broken.Visible = false
		game.Players.LocalPlayer.PlayerGui.Math.FixObject.DoAnother.Visible = false
		game.Players.LocalPlayer.PlayerGui.Math.FixObject.Problem.Visible = false
		game.Players.LocalPlayer.PlayerGui.Math.FixObject.Yes.Visible = false
		game.Players.LocalPlayer.PlayerGui.Math:WaitForChild('MathGui').Problem.Visible = false
		game.Players.LocalPlayer.PlayerGui.Math:WaitForChild('MathMenu').ProblemType.Visible = false
		-- Missions
		game.Players.LocalPlayer.PlayerGui:WaitForChild('MissionGui').Mission.Visible = false
		-- Fruit
		game.Players.LocalPlayer.PlayerGui:WaitForChild('GetFruit').FruitCount.Visible = false
		-- Reset camera, walkspeed, etc
		workspace.Camera.Blur.Size = 0
		player.Character.Humanoid.WalkSpeed = 16
		player.Character.Humanoid.JumpPower = 50
		player.CameraMinZoomDistance = 0.5
		player.CameraMaxZoomDistance = 50
	end	
return myModule



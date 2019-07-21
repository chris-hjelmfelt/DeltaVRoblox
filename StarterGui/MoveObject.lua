-- This script must be a LocalScript located in either StarterGui or StarterPack to work (to find LocalPlayer)
-- If objects are unions or parts and they need a "Furniture Gravity" script and a BodyForce object inside them.
-- If objects are models this doesn't seem necessary
-- Make sure to spawn objects inside a group called "Furniture" because this script checks for that to determine if something is a model vs part, union, etc.

-- Models aren't working with collision groups. MoveTo always collides and CFrame never collides 
-- Test code to work around the problem is commented out at bottom - with a note in working code for where to place it)
-- Problem is that using Cframe and trying to test for collisions is partly working but causing jumping, flipping and stopping in midair
-- I've decided that as much as I may want this it's not totally necessary and I should focus on other content and deal with this down the road

-- I really need to be able to use models for two reasons: Seats cannot be unioned, I want to be able to color individual parts and you can't union something from a script

-- Variables
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local gsize = .5  -- size of grid in studs (if you change this to something smaller you may lose items in the walls unless you change that code a bit)
selected = false  -- is an item currently selected
move = false  -- can the item move
item = player:WaitForChild("Item",1000).Value  -- used to change colors of selected item
selected2 = player:WaitForChild("FurnitureSelected",1000).Value  -- current furniture item selected
bigX = 10  -- Used in finding existing button positions in the storage gui
bigY = 0  -- Used in finding existing button positions in the storage gui
newPosition = UDim2.new(0, 10, 0, 10)  -- used to set new button positions in the storage gui
textPosition = UDim2.new(0, 10, 0, 10)  -- used to set new button positions in the storage gui


-- Give time for other scripts to run
wait(1)

	
-- Edit button on/off
editButton = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').EditButton.Edit
colorChange = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').ColorChange
editDirections = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').EditDirections
storage = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('FurnitureStorage').Storage


-- Edit button functionality
editButton.MouseButton1Click:connect(function()
	if editButton.Image == "rbxassetid://2445024042" then -- start editing
		editButton.Image = "rbxassetid://2445245847"		
		editDirections.Visible = true
		selected = false		
		
	else -- stop editing
		editButton.Image = "rbxassetid://2445024042"
		colorChange.Visible = false
		editDirections.Visible = false
		storage.Visible = false
		item = "Color1"  -- default
		-- If there is still an object selected deselect and reset everything
		if mtarget then		
			deselectWhileOutside('editbutton')
			--[[
			if mtarget.Parent.Name == "Furniture" then
				PhysicsService:SetPartCollisionGroup(mtarget, "Default")
			else
				local child = mtarget.Parent:GetChildren()
				for i = 1, #child do
					if child[i].Name ~= "Type" and child[i].Name ~= "Colors" then
						PhysicsService:SetPartCollisionGroup(child[i], "Default")	
					end
				end
			end	
			--ds.SetAsync("id-"..player.userId, mtarget.Name)
			mtarget.Anchored = true
			mtarget = nil
			selected = false
			move = false
			]]
		end		
	end		
end)


-- Customize2 ColorChange Gui buttons
local child = colorChange:GetChildren()
for i = 1, #child do
	if child[i].Name == "Color1" or child[i].Name == "Color2" or child[i].Name == "Color3" then
		child[i].MouseButton1Click:connect(function()  -- select part of object to color
			item = child[i].Name
		end)
	elseif child[i].Name == "Move Object" then
		child[i].MouseButton1Click:connect(function()  -- move the objectw
			move = true
		end)
	elseif child[i].Name == "Press R" then
		-- nothing
	else
		child[i].MouseButton1Click:connect(function()  -- color the object
			if mtarget then		
				local color = child[i].Name	
				game.ReplicatedStorage.ColorChange1:FireServer(mtarget, item, color)  -- goes to EditHouse
			end
		end)
	end		
end


-- Select an object
function clickObj()
	local editEnable = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').EditButton
	local myModule = require(workspace.Scripts.MovingStuff_ModuleScript)
	
	-- Make sure they are in edit mode
	if editEnable.Visible == true and editEnable.Edit.Image == "rbxassetid://2445245847" then  
		if selected == false then  -- select the object
			if (mouse.Target.ClassName == "UnionOperation" or mouse.Target.ClassName == "Part" or mouse.Target.ClassName == "Seat") and mouse.Target.Name ~= "HouseArrow" then
				-- Find out if it's furniture
				if mouse.Target.Parent.Name == "Furniture" then  -- parts and unions
					mtarget = mouse.Target
					-- Set collision group to prevent collisions with players
					if mtarget.Type == 'rug' then
						PhysicsService:SetPartCollisionGroup(mtarget, "Rug")
					else
						PhysicsService:SetPartCollisionGroup(mtarget, "CurrentItem")
					end
					selected = true	
					colorChange.Visible = true
					editDirections.Visible = false
				elseif mouse.Target.Parent.Parent.Name == "Furniture" then  -- models
					mtarget = mouse.Target.Parent:WaitForChild("Block", 100)  
					if mtarget then  -- make sure the model has a Block inside it
						--model = mtarget.Parent  -- I don't think this is used
						local child = mtarget.Parent:GetChildren()
						for i = 1, #child do
							if child[i].Name ~= "Type" and child[i].Name ~= "Colors" then
								local mypart = child[i]
								PhysicsService:SetPartCollisionGroup(mypart, "CurrentItem")	
							end
						end	
						selected = true	
						colorChange.Visible = true
						editDirections.Visible = false
					end					
				end					
			end		
		elseif selected == true and mtarget then	 -- deselect the object	
			-- first check that item is in the house 
			local insideHouse = myModule.insideHouseCheck(player, mtarget)
			if insideHouse == true then		-- if the top of the furniture item is within the boundaries of the house	
				colorChange.Visible = false
				editDirections.Visible = true	
				if mtarget.Parent.Name == "Furniture" then
					PhysicsService:SetPartCollisionGroup(mtarget, "Default")
				else
					local child = mtarget.Parent:GetChildren()
					for i = 1, #child do
						if child[i].Name ~= "Type" and child[i].Name ~= "Colors" then
							PhysicsService:SetPartCollisionGroup(child[i], "Default")	
						end
					end
				end	
				--ds.SetAsync("id-"..player.userId, mtarget.Name)
				mtarget.Anchored = true
				mtarget = nil
				selected = false
				move = false
			else
				deselectWhileOutside('clickobj')
			end
			
		elseif selected == true and mtarget == nil then	
			colorChange.Visible = false
			editDirections.Visible = true
			selected = false
			move = false			
		end	
	else
		colorChange.Visible = false
		editDirections.Visible = false
		selected = false
		move = false
	end
end
mouse.Button1Down:connect(clickObj) -- Select an object	


-- If the person leaves the house while furniture is out of bounds put in storage (otherwise do nothing - furniture will stay selected)
function deselectWhileOutside(situation)
	local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
	local houseType = Players:FindFirstChild(player.Name).HouseInt.Value 
	local housePos = houseType.Primary.Position  
	
	wait(1)
	if mtarget then	
		if situation == 'playerexit' or situation == 'editbutton' then  -- save furniture to storage
			print('MoveObject - player has left the game or clicked edit button')			
			if mtarget.Parent.Name == "Furniture" then
				object = mtarget.Name
				game.ReplicatedStorage.DestroyItem:FireServer(mtarget)  -- goes to EditHouse
			else
				object = mtarget.Parent.Name
				game.ReplicatedStorage.DestroyItem:FireServer(mtarget.Parent)  -- goes to EditHouse				
			end
			
			local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
			myModule.putIntoStorage(object)			
		end
		colorChange = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').ColorChange
		editDirections = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').EditDirections
	end			
		
	-- reset everything	
	mtarget = nil
	selected = false
	move = false
	colorChange.Visible = false	
	editDirections.Visible = false
end
Players.PlayerRemoving:Connect(function()
	deselectWhileOutside('playerexit')
end)


-- Move the object
mouse.Move:connect(function()
	if mtarget then
		findSize()
		local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
		myModule.moveObject(player, mouse, mtarget, move, gsize, xMax, xMin, zMax, zMin, wallGroup)
	end
end)


-- Rotate the object
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
	local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
	myModule.rotateObject(mtarget, inputObject)
end)


-- Put an object into storage (destroy the object and add its image to the storage Gui)
colorChange.Store.MouseButton1Click:connect(function()
	if mtarget then	
		if mtarget.Parent.Name == "Furniture" then
			object = mtarget.Name
			game.ReplicatedStorage.DestroyItem:FireServer(mtarget)  -- goes to EditHouse
		else
			object = mtarget.Parent.Name
			game.ReplicatedStorage.DestroyItem:FireServer(mtarget.Parent)  -- goes to EditHouse
			
		end
	
		local myModule = require(workspace.Scripts.EditHouse_ModuleScript)
		myModule.putIntoStorage(object)
		--mtarget, selected, move = myModule.putIntoStorage(mtarget, selected, move, bigX, bigY)
	end
	colorChange = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').ColorChange
	editDirections = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Customize2').EditDirections
			
	-- Reset mouse target and set no item selected
	mtarget = nil
	selected = false
	move = false
	colorChange.Visible = false
	editDirections.Visible = true
end)


-- Find house size
function findSize()
	local eachHouse = game.Workspace.SpawnedHouses:GetChildren()
	for i = 1, #eachHouse do
		if (eachHouse[i].Name ~= 'Holding the Space' and eachHouse[i].Name ~= 'HouseArrow') and eachHouse[i]:WaitForChild('Owner').Value == player.Name then
			if eachHouse[i].Name == 'House1' or  eachHouse[i].Name == 'House2' or eachHouse[i].Name == 'House3' then
				xMax = eachHouse[i].PrimaryPart.Position.X + eachHouse[i].PrimaryPart.Size.X/2-2
				xMin = eachHouse[i].PrimaryPart.Position.X - eachHouse[i].PrimaryPart.Size.X/2+2
				zMax = eachHouse[i].PrimaryPart.Position.Z + eachHouse[i].PrimaryPart.Size.Z/2-2
				zMin = eachHouse[i].PrimaryPart.Position.Z - eachHouse[i].PrimaryPart.Size.Z/2+2
				playerHouse = eachHouse[i]
			end
		end
	end
	
	-- Find Walls  - this will be sent to EditHouse_ModuleScript for placing posters and things
	local findWall = playerHouse:GetChildren()
	for w = 1, #findWall do
		if findWall[w].Name == "Walls" then
			wallGroup = findWall[w]
		end
	end
end


	
		
	
-- Code for trying to prevent player collisions with models - Still not working properly
--[[
				-- Check for occupied space
				posY = mtarget.Size.Y/2
				occupied = 1
				emergencyStop = 0
				while occupied > 0 and emergencyStop < 100 do
					-- FindPartsInRegion3() looks in a very general region not as specific as I need here
					--local Point1 = Vector3.new(posX - mtarget.Size.X/2, posY - mtarget.Size.Y/2 - .001, posZ - mtarget.Size.Z/2)
					--local Point2 = Vector3.new(posX + mtarget.Size.X/2, posY + mtarget.Size.Y/2 + .001, posZ + mtarget.Size.Z/2)
					--local Region = Region3.new(Point1,Point2)
					--local touching = game.Workspace:FindPartsInRegion3(Region,nil,2)
					
					touching = mtarget:GetTouchingParts()
					occupied = 0
					for _, p in next, touching do
						if p.Parent == mtarget.Parent then
							--nothing
						else
							print(p.Name);
							occupied = occupied + 1	
						end				        
				    end;
					if occupied > 0 then
						posY = posY + .05						
					end	
					emergencyStop = emergencyStop + 1	
					model:SetPrimaryPartCFrame(CFrame.new(posX,posY,posZ))	-- ignores all collisions
					wait(.1)
				end	
				]]
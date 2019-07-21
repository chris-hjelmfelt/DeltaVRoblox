local PhysicsService = game:GetService("PhysicsService")
local debounce = false

-- Change the color of the selected object
game.ReplicatedStorage.ColorChange1.OnServerEvent:Connect(function(Player, mtarget, item, color)  -- comes from MoveObject
	if mtarget then
		if mtarget.Parent.Name == "Furniture" then
			mtarget.BrickColor = BrickColor.new(color)
			if mtarget.ClassName == "UnionOperation" then
				mtarget.UsePartColor = true
			end
		else
			local child = mtarget.Parent:GetChildren()
			for i = 1, #child do
				if child[i].Name == item then
					child[i].BrickColor = BrickColor.new(color)
					if child[i].ClassName == "UnionOperation" then
						child[i].UsePartColor = true
					end
				end
			end
		end
	end
end)


-- Spawn an object from storage 
-- (this is in a server script so we can use server storage which is more secure)
game.ReplicatedStorage.SpawnItem.OnServerEvent:Connect(function(Player, item)   -- comes from EditHouse_ModuleScript (Get an object)
	if debounce == false then
		debounce = true 							
		local playerHouseInt = Player.HouseInt.Value 
		local newModel = game.ServerStorage:FindFirstChild(item):Clone()	
		newModel.Parent = playerHouseInt.Furniture 	
		local itemType = newModel.Type.Value
		posX = playerHouseInt.Primary.Position.X
		posY = 0
		posZ = playerHouseInt.Primary.Position.Z	
		if  itemType == "rug" then  -- the rug is too big
			 newModel.Size = Vector3.new(8,.2,8)
		end
		if newModel.ClassName == "Model" then		
			posY = newModel.Block.Size.Y/2 + 11  -- find height from floor
			newModel:SetPrimaryPartCFrame(CFrame.new(posX,posY,posZ))
			-- Anchor the pieces
			local child = newModel:GetChildren()
			for i = 1, #child do
				if child[i].Name ~= "Type" then 
					child[i].Anchored = true
				end
			end	
		elseif itemType == "rug" then	-- rugs must be unions or parts to allow using collision groups (otherwise you won't be able to place them in small rooms)	 
			PhysicsService:SetPartCollisionGroup(newModel, "Rug")
			posY = newModel.Size.Y/2 + 11  -- find height from floor
			newModel.CFrame = CFrame.new(posX,posY,posZ)
			newModel.Anchored = true		
			PhysicsService:SetPartCollisionGroup(newModel, "Default")
		else  -- part, union, etc
			posY = newModel.Size.Y/2 + 11  -- find height from floor			
			newModel.CFrame = CFrame.new(posX,posY,posZ)
			newModel.Anchored = true
		end
		
		--[[
		roomLength = 48
		loopCount = 1
		moveX = 0
		moveY = 0
		
		if newModel.ClassName == "UnionOperation" or newModel.ClassName == "Part" and itemType ~= "rug" then	
			-- If furniture is above the house 
			while newModel.Position.Y > 24 - newModel.Size.Y/2 do
				print("EditHouse - Furniture is above the house")
				newModel.Position = Vector3.new(0 + tonumber(moveX),posY,0 + tonumber(moveY))
				if loopCount > roomLength then
					moveY = tonumber(moveY) + 1
					loopCount = 1
				else
					moveX = tonumber(moveX) + 1
					loopCount = tonumber(loopCount) + 1
				end		
			end
			-- set gravitational pull to 0
			newModel.BodyForce.force = Vector3.new(0, game.Workspace.Gravity, 0) * newModel:GetMass()
		elseif itemType ~= "rug" then -- model
			-- If furniture is above the house 
			while newModel.Block.Position.Y > 24 - newModel.Block.Size.Y/2 do			
				newModel:MoveTo(Vector3.new(0 + tonumber(moveX),posY,0 + tonumber(moveY)))			
				if loopCount > roomLength then
					moveY = tonumber(moveY) + 1
					loopCount = 1
				else
					moveX = tonumber(moveX) + 1
					loopCount = tonumber(loopCount) + 1
				end		
			end		
		end
		--]]
		wait(.2)
		debounce = false 
	end 
end)
	
	
-- Destroy item (such as put into storage)
game.ReplicatedStorage.DestroyItem.OnServerEvent:Connect(function(player, item)  -- comes from MoveObject
	item.Parent = nil
end)


-- Move Furniture
game:GetService("ReplicatedStorage").MoveFurniture.OnServerEvent:Connect(function(player, target, posX, posY, posZ)  -- comes from EditHouse_MS
	if target.Parent.Name == "Furniture" then  -- part, union, etc
		itemType = target.Type.Value
		if itemType == "rug" then  -- we want to keep this on the floor and allow collisions				
			target.CFrame = CFrame.new(posX,posY,posZ)
		else				
			target.Position = Vector3.new(posX,posY,posZ)	
		end				 
	else -- model
		itemType = target.Parent.Type.Value			
		if itemType == "rug" then  -- we want to keep this on the floor and allow collisions			
			target.Parent:SetPrimaryPartCFrame(CFrame.new(posX,posY,posZ))
		else		
			target.Parent:MoveTo(Vector3.new(posX,posY,posZ))  -- will always move up if an object is there, no matter the collision group
		end
	end	
end)


-- Rotate furniture
game:GetService("ReplicatedStorage").RotateFurniture.OnServerEvent:Connect(function(player, target)  -- comes from EditHouse_MS
	if target.Parent.Name == "Furniture" then  -- part, union, etc
		target.CFrame = target.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
	else  -- model
		target.Parent:SetPrimaryPartCFrame(target.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0))
	end
end)



--[[  I stopped using this furniture folder a long time ago and furniture isn't flipping around anymore - but it still moves rough
-- Change gravity on furniture so it doesn't flip around (seems unnecessary for models)
-- Later you will add furniture a piece at a time when a new player arrives 
-- And you can just add the line:
-- object.BodyForce.force = Vector3.new(0, game.Workspace.Gravity, 0) * script.Parent:GetMass()
-- where object is the current piece you are adding
local child = workspace:WaitForChild("Furniture"):GetChildren()
for i = 1, #child do
	if child[i].ClassName == "UnionOperation" or child[i].ClassName == "Part" then
		object = child[i]
		-- set gravitational pull to 0
		object.BodyForce.force = Vector3.new(0, game.Workspace.Gravity, 0) * object:GetMass()
	else
		children = child[i]:GetChildren()
		for j = 1, #children do
			if children[j].ClassName == "UnionOperation" or child[i].ClassName == "Part" or child[i].ClassName == "Seat" then 
				-- set gravitational pull to 0
				--children[j].BodyForce.force = Vector3.new(0, game.Workspace.Gravity, 0) * script.Parent:GetMass()
			end
		end
	end
end
]]--
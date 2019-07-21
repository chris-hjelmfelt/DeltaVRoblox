-- This defines two cattegories of items that can or cannot collide
-- The player is the main item we want to avoid collisions with
-- The door (including the space in front of it) we want the player to not collide with but
	-- we don't want furniture to be placed there
	-- the door is kind of in the way while editing, maybe change it from an object to a space defined in code
	

local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local playerCollisionGroupName = "Players"
local currItemCollisionGroupName = "CurrentItem"
local rugCollisionGroupName = "Rug"

PhysicsService:CreateCollisionGroup(playerCollisionGroupName)
PhysicsService:CreateCollisionGroup(currItemCollisionGroupName)
PhysicsService:CreateCollisionGroup(rugCollisionGroupName)

PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, playerCollisionGroupName, false)
PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, currItemCollisionGroupName, false)
PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, rugCollisionGroupName, false)
PhysicsService:CollisionGroupSetCollidable("Default", rugCollisionGroupName, false)

local previousCollisionGroups = {}
 
--[[ Not using door spacer currently
for index, houses in pairs(workspace.SpawnedHouses:GetChildren()) do
	if houses == 'House1' or houses == 'House2' or houses == 'House3' then
		for index, child in pairs(houses.Door:GetChildren()) do
			PhysicsService:SetPartCollisionGroup(child, "CurrentItem")
		end
	end
end
]]

local function setCollisionGroup(object)
	if object:IsA("BasePart") then
		previousCollisionGroups[object] = object.CollisionGroupId
		PhysicsService:SetPartCollisionGroup(object, playerCollisionGroupName)
	end
end
 
local function setCollisionGroupRecursive(object)
	setCollisionGroup(object)
 
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end
 
local function resetCollisionGroup(object)
	local previousCollisionGroupId = previousCollisionGroups[object]
	if not previousCollisionGroupId then return end	
 
	local previousCollisionGroupName = PhysicsService:GetCollisionGroupName(previousCollisionGroupId)
	if not previousCollisionGroupName then return end
 
	PhysicsService:SetPartCollisionGroup(object, previousCollisionGroupName)
	previousCollisionGroups[object] = nil
end
 
local function onCharacterAdded(character)
	setCollisionGroupRecursive(character)
 
	character.DescendantAdded:Connect(setCollisionGroup)
	character.DescendantRemoving:Connect(resetCollisionGroup)
end
 
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end
 
Players.PlayerAdded:Connect(onPlayerAdded)




-- When a player joins create a housestats object and put these values inside it
game.Players.PlayerAdded:connect(function(player)	
	local myArray = game.ReplicatedStorage.GetListOfAllFurniture:InvokeClient(player) -- Goes to FurnitureInStorage
	
	-- Create the furniture stats object to contain the list of furniture
	local fstats = Instance.new("Model")
    fstats.Name = "furniturestats"
    fstats.Parent = player	
	
	-- Keep track of the furniture owned by the player
	for k = 1, #myArray do
		local owned = Instance.new("IntValue") 
	    owned.Name = myArray[k] 
	    owned.Value = 0 
	    owned.Parent = fstats 
	end

	
	-- Add developer/gamepass items
	local trophy1 = Instance.new("IntValue") 
    trophy1.Name = 'FirstHelpDevTrophy' 
    trophy1.Value = 0 
    trophy1.Parent = fstats 

	
	-- Make a copy of furniturestats so we can keep track of what we've placed in house and place the extras in storage
	local ustats = fstats:clone()
	ustats.Name = "addedtohouse"
	ustats.Parent = player



	--[[
	-- keep track of more info for each piece of furniture
	for k = 1, #myArray do
	    local value = myArray[k]
	    print('AddFurnitureStats - ' .. value)
	
		local f01 = Instance.new("Model")
	    f01.Name = myArray[k]
	    f01.Parent = fstats 
	
		local owned = Instance.new("IntValue") 
	    owned.Name = "Quantity" 
	    owned.Value = 0 
	    owned.Parent = f01 
	
		local c1 = Instance.new("Color3Value") 
	    c1.Name = "Color1" 
	    c1.Value = Color3.new(0, 0, 0) 
	    c1.Parent = f01
	
		local c2 = Instance.new("Color3Value") 
	    c2.Name = "Color2" 
	    c2.Value = Color3.new(0, 0, 0) 
	    c2.Parent = f01
	
	 	local c3 = Instance.new("Color3Value") 
	    c3.Name = "Color3" 
	    c3.Value = Color3.new(0, 0, 0) 
	    c3.Parent = f01
	
		local pos = Instance.new("Vector3Value") 
	    pos.Name = "Position" 
	    pos.Value = Vector3.new(0, 0, 0) 
	    pos.Parent = f01
		
		local orient = Instance.new("Vector3Value") 
	    orient.Name = "Orientation" 
	    orient.Value = Vector3.new(0, 0, 0) 
	    orient.Parent = f01
	end
	--]]
 end)



-- When a player joins create a housestats object and put these values inside it
game.Players.PlayerAdded:connect(function(player)
	local housestats = Instance.new("Model")
    housestats.Name = "housestats"
    housestats.Parent = player

	local owned = Instance.new("IntValue") 
    owned.Name = "HouseLevelOwned" 
    owned.Value = 1 
    owned.Parent = housestats 

	local usedInt = Instance.new("IntValue")
	usedInt.Name = "HouseInteriorUsed"
	usedInt.Value = 1
	usedInt.Parent = housestats 
	
	local usedExt = Instance.new("IntValue")
	usedExt.Name = "HouseExteriorUsed"
	usedExt.Value = 1
	usedExt.Parent = housestats 
	
	local lock = Instance.new("StringValue")
	lock.Name = "HouseLock"
	lock.Value = "all"
	lock.Parent = housestats 
	
	local color1 = Instance.new("Color3Value")
	color1.Name = "HouseColor1"
	color1.Value = Color3.new(237, 234, 234)
	color1.Parent = housestats 
	
	local color2 = Instance.new("Color3Value")
	color2.Name = "HouseColor2"
	color2.Value = Color3.new(202, 203, 209)
	color2.Parent = housestats 
	
	local color3 = Instance.new("Color3Value")
	color3.Name = "HouseColor3"
	color3.Value = Color3.new(248, 248, 248)
	color3.Parent = housestats 
	
	local color4 = Instance.new("Color3Value")
	color4.Name = "HouseColor4"
	color4.Value = Color3.new(255, 148, 148)
	color4.Parent = housestats 
		
 end)

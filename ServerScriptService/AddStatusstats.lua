-- This is for things like if it's their first time, whether they purchased dev products,
-- what quests they've done, etc.
game.Players.PlayerAdded:connect(function(player)
	local statusstats = Instance.new("Model")
    statusstats.Name = "statusstats"
   	statusstats.Parent = player
 
    local firstTime = Instance.new("BoolValue") 
    firstTime.Name = "FirstTime" 
    firstTime.Value = false 
    firstTime.Parent = statusstats 

 end)

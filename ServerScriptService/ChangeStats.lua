-- change player values for money and skills
game.ReplicatedStorage.GiveRewards.OnServerEvent:Connect(function(player, stat, rewardGold, rewardXP)  -- comes from Rewards_ModuleScript	
	player.leaderstatsX.Gold.Value = player.leaderstatsX.Gold.Value + rewardGold
	player.leaderstatsX.XP.Value = player.leaderstatsX.XP.Value + rewardXP
	player.leaderstatsX:FindFirstChild(stat).Value = player.leaderstatsX:FindFirstChild(stat).Value + rewardXP
end)


-- On furniture purchase handle money and keeping track of counts
game.ReplicatedStorage.PurchaseFurniture.OnServerEvent:Connect(function(player, cost, item)  -- comes from PurchaseFurniture	
	wait(1) -- wait until after other scripts 
	local playerGold = player:WaitForChild('leaderstatsX', 100).Gold  
	local fItem = player:WaitForChild('furniturestats'):FindFirstChild(item)
	fItem.Value = fItem.Value + 1  -- specific item count
	playerGold.Value = playerGold.Value - tonumber(cost)  -- subtract gold
	player.ItemsOwned.Value = player.ItemsOwned.Value + 1	-- total owned
end)
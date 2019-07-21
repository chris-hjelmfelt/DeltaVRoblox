
-- Change house color
game.ReplicatedStorage.ChangeHouseColor.OnServerEvent:Connect(function(Player, color, selected) -- comes from CustomizeHouseLocal
	local houseExt = Player:WaitForChild("HouseExt",100).Value
	if selected == 1 then			
		houseExt:FindFirstChild('Container Pod').Container.Color = color
		Player:WaitForChild("housestats").HouseColor1.Value = color
	elseif selected == 2 then
		houseExt:FindFirstChild('Container Pod').Trim.Color = color
		Player:WaitForChild("housestats").HouseColor2.Value = color
	elseif selected == 3 then
		houseExt:FindFirstChild('Container Pod').Door.Color = color
		Player:WaitForChild("housestats").HouseColor3.Value = color
	elseif selected == 4 then
		houseExt:FindFirstChild('Container Pod'):FindFirstChild('Door Trim').Color = color
		Player:WaitForChild("housestats").HouseColor4.Value = color
	end				
end)
	
	
game.ReplicatedStorage.ChangeHouseLock.OnServerEvent:Connect(function(Player, lockSet)
	Player:WaitForChild("housestats").HouseLock.Value = lockSet	
end)
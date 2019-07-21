
-- Saving and Loading settings --
local AUTO_SAVE = true		-- Make true to enable auto saving
local TIME_BETWEEN_SAVES = 120	-- In seconds (WARNING): Do not put this lower than 60 seconds
local PRINT_OUTPUT = false		-- Will print saves and loads in the output
local SAFE_SAVE = true			-- Upon server shutdown, holds server open to save all data
---------------------------------

local players = game:GetService("Players")
local dataStoreService = game:GetService("DataStoreService")
local houseData = dataStoreService:GetDataStore("HouseStats")
-- BE VERY CAREFUL WHEN COPYING 
-- IF YOU DON"T GET ALL VARIABLES CHANGED YOU COULD OVERWRITE THE STATS YOU COPIED THIS FROM!

local function Print(message)
	if PRINT_OUTPUT then print(message) end
end


local function SaveData(player)
	if player.userId < 0 then return end
	player:WaitForChild("housestats")
	wait(1)
	local houseStats = {}
	for i, stat in pairs(player.housestats:GetChildren()) do
		if stat.ClassName == 'Color3Value' then	
			local myColor3 = getSaveableColor3(stat)  -- convert Color3 to table
			table.insert(houseStats, {stat.Name, myColor3})
		else
			table.insert(houseStats, {stat.Name, stat.Value})
		end
	end
	Passed, Error = pcall(function() houseData:SetAsync(player.userId, houseStats) end)
	assert(Passed, Error)
end


local function LoadData(player)
	if player.userId < 0 then return end
	player:WaitForChild("housestats")
	wait()
	local houseStats = houseData:GetAsync(player.userId)
	if houseStats ~= nil then
		for i, stat in pairs(houseStats) do
			local currentStat = player.housestats:FindFirstChild(stat[1])
			if not currentStat then return end
			if typeof(stat[2]) == 'table' then				
				currentStat.Value = Color3.fromRGB(stat[2][1] *255, stat[2][2] *255, stat[2][3] *255) -- convert table to Color3
			else
				currentStat.Value = stat[2]
			end
		end
	else 
		print('houseStats = nil')
	end	
end

players.PlayerAdded:connect(LoadData)
players.PlayerRemoving:connect(SaveData)


if SAFE_SAVE and not game:GetService("RunService"):IsStudio() then
	game:BindToClose(function()
		for i, player in pairs(players:GetChildren()) do
			SaveData(player)
		end
		wait(1)
	end)
end


while AUTO_SAVE do
	wait(TIME_BETWEEN_SAVES)
	for i, player in pairs(players:GetChildren()) do
		SaveData(player)
	end
end


-- convert Color3 to table  (DataStore doesn't take Color3)
function getSaveableColor3(val)
    return {val.Value.r, val.Value.g, val.Value.b}
end


-- On upgrade save new stats
game.ReplicatedStorage.SwitchHouse.OnServerEvent:Connect(function(player, price)  -- Comes from UpgradeHouseLocal
	wait(1)  -- wait for UpgradeHouseServer script 
	SaveData(player)
end)

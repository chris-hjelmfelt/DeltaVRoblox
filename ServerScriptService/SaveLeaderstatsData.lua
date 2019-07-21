
-- Saving and Loading settings --
local AUTO_SAVE = true		-- Make true to enable auto saving
local TIME_BETWEEN_SAVES = 60	-- In seconds (WARNING): Do not put this lower than 60 seconds
local PRINT_OUTPUT = false		-- Will print saves and loads in the output
local SAFE_SAVE = true			-- Upon server shutdown, holds server open to save all data
---------------------------------

local players = game:GetService("Players")
local dataStoreService = game:GetService("DataStoreService")
local leaderboardData = dataStoreService:GetDataStore("LeaderStats")
-- BE VERY CAREFUL WHEN COPYING - DON'T USE THIS SCRIPT - USE HOUSE STATS  (least sensitive)
-- IF YOU DON"T GET ALL VARIABLES CHANGED YOU COULD OVERWRITE THE STATS YOU COPIED THIS FROM!

local function Print(message)
	if PRINT_OUTPUT then print(message) end
end


local function SaveData(player)
	if player.userId < 0 then return end
	player:WaitForChild("leaderstatsX")
	wait(1)
	local leaderboardStats = {}
	for i, stat in pairs(player.leaderstatsX:GetChildren()) do
		table.insert(leaderboardStats, {stat.Name, stat.Value})
	end
	Passed, Error = pcall(function() leaderboardData:SetAsync(player.userId, leaderboardStats) end)
	assert(Passed, Error)
end


local function LoadData(player)
	if player.userId < 0 then return end
	player:WaitForChild("leaderstatsX")
	local leaderboardStats = leaderboardData:GetAsync(player.userId)
	for i, stat in pairs(leaderboardStats) do
		local currentStat = player.leaderstatsX:FindFirstChild(stat[1])
		if not currentStat then return end
		currentStat.Value = stat[2]
	end
	
	wait(60) 
	SaveData(player)
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


game.ReplicatedStorage.PurchaseFurniture.OnServerEvent:Connect(function(player, cost, item)  -- comes from PurchaseFurniture
	wait(1)  -- wait for ChangeStats script 
	SaveData(player)
end)

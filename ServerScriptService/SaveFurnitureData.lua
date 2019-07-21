
-- Saving and Loading settings --
local AUTO_SAVE = false			-- Make true to enable auto saving
local TIME_BETWEEN_SAVES = 60	-- In seconds (WARNING): Do not put this lower than 60 seconds
local PRINT_OUTPUT = false		-- Will print saves and loads in the output
local SAFE_SAVE = true			-- Upon server shutdown, holds server open to save all data
---------------------------------

local players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local dataStoreService = game:GetService("DataStoreService")
local quickFurnData = dataStoreService:GetDataStore("QuickFurn")
local debounce = false	-- we want to save all furniture purchased but can't send 20 save signals at once
local saveWaiting = false  -- tells us we have more items to save
-- BE VERY CAREFUL WHEN COPYING 
-- IF YOU DON"T GET ALL VARIABLES CHANGED YOU COULD OVERWRITE THE STATS YOU COPIED THIS FROM!

local function Print(message)
	if PRINT_OUTPUT then print(message) end
end


local function SaveData(player)
	if player.userId < 0 then return end
	player:WaitForChild("furniturestats")
	wait(1)
	local fData = {}
	for i, stat in pairs(player.furniturestats:GetChildren()) do
		table.insert(fData, {stat.Name, stat.Value})
	end
	Passed, Error = pcall(function() quickFurnData:SetAsync(player.userId, fData) end)
	assert(Passed, Error)
end


local function LoadData(player)
	if player.userId < 0 then return end
	-- Get the "Quick List" of furniture counts
	Passed, Error = pcall(function() list = quickFurnData:GetAsync(player.userId) end) 
	assert(Passed, Error)
	local quickList = HttpService:JSONDecode(list)	
	if quickList ~= nil then
		FillFurnitureStats(player, quickList)
	end
	
end

players.PlayerAdded:connect(LoadData)
players.PlayerRemoving:connect(SaveData)



-- Add the nuber of each furniture to furniture stats
function FillFurnitureStats(player, list)
	local owned = player:WaitForChild("NumFurniture",1000).Value  -- number of furniture items owned
	for k,v in pairs(list) do	
		print('SaveFurnData - ')
		print(list[k])
		local fItem = player.furnitureStats:WaitForChild(list[k]["Name"]).Value  -- name
		fItem = fItem + list[k]
		-- keep track of items owned
		owned = owned + 1  -- for max items
	end	
end


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
	wait(.2)  -- wait for ChangeStats script 
	if not debounce then
		debounce = true
		SaveData(player)
		wait(60)
		debounce = false
	elseif not saveWaiting then  -- allow a second save shortly after
		saveWaiting = true
		wait(6)
		SaveData(player)
		saveWaiting = false
	end
end)

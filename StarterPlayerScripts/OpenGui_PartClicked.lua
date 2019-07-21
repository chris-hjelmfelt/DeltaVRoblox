-- Setup 
local Player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
-- Blur seems to need to be created locally for each player
Instance.new("BlurEffect", workspace.CurrentCamera)
workspace.Camera.Blur.Size = 0


-- show when money changes
-- print('OG_PC')
-- Player:WaitForChild('leaderstats').Gold.Changed:Connect(print)

--[[
-- Math Problem without fix object
math01 = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Andres Table').Table
math01.ClickDetector.MouseClick:Connect(function(Player)
	problem = Player.PlayerGui.Math.MathGui.Problem	
	problem.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	Player.Answer.Value = "0"
	-- Display a random math problem
	local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
	myModule.mathProblem(Player)
end)
]]

-- Math Problem using FixObject gui
math01 = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Andres Table').Table
math01.ClickDetector.MouseClick:Connect(function(Player)
	Player:WaitForChild('PlayerGui', 100):WaitForChild('Math', 100).FixObject.Broken.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	Player.Answer.Value = "0"		
end)

-- Electrical Fix Object
electrical01 = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Maries Table').Table
electrical01.ClickDetector.MouseClick:Connect(function(Player)	
	Player:WaitForChild('PlayerGui', 100).ElectricalFixObject.Broken.Visible = true	
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	Player.Answer.Value = ""
	
end)
--[[ Electrical Problem without fix
electrical01 = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Maries Table').Table
electrical01.ClickDetector.MouseClick:Connect(function(Player)	
	problem = Player.PlayerGui.ElectricalGui.Problem
	problem.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	Player.Answer.Value = ""
	-- Display a random electrical problem
	local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
	myModule.electricalProblem(Player)
	
end)
]]
-- Electrical Book has its own script in StarterPlayerScripts



-- Chemistry Problem
chemistry01 = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Nailahs Table').Table
chemistry01.ClickDetector.MouseClick:Connect(function(Player)	
	problem = Player.PlayerGui.ChemistryGui.Problem
	problem.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	Player.Answer.Value = ""
	-- Display a random electrical problem
	local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
	myModule.chemistryProblem(Player)
end)
-- Chemistry Book has it's own script in StarterPlayerScripts


--[[
-- Missions
quest01 = game.Workspace:FindFirstChild('X Other').Ling.QuestBlock
quest01.ClickDetector.MouseClick:Connect(function(Player)	
	local Player = game.Players.LocalPlayer
	Player.PlayerGui.MissionGui.Mission.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	local missionModule = require(workspace.Scripts.Mission_ModuleScript)
	missionModule.newMission(Player)
end)
]]

-- Pick Fruit
local child1 = game.Workspace.Greenhouse:GetChildren()
for i = 1, #child1 do
	if child1[i].Name == 'Huge Planter' then 
		local child2 = child1[i]:GetChildren()
		for j = 1, #child2 do
			if child2[j].Name == 'Vine' then
		    	local child3 = child2[j]:GetChildren()
				for k = 1, #child3 do
					if child3[k].Name == 'Fruit' then
						child3[k].ClickDetector.MaxActivationDistance = 16
				    	child3[k].ClickDetector.MouseClick:Connect(function(Player)							
							local fruitModule = require(workspace.Scripts.ManualLabor_ModuleScript)
							fruitModule.fruitPick(Player, child3[k])	
						end)
					end
				end	
			end
		end
	end
end

-- Sell Fruit
local fruitModule = require(workspace.Scripts.ManualLabor_ModuleScript)
local dropchild1 = game.Workspace.Greenhouse:GetChildren()
for i = 1, #dropchild1 do
	if dropchild1[i].Name == 'Dropoff Area' then 
		local dropchild2 = dropchild1[i]:GetChildren()
		for j = 1, #dropchild2 do
			if dropchild2[j].Name == 'Dropoff Table' then
				canSell = true
		    	dropchild2[j].ClickDetector.MouseClick:Connect(function(Player)	
					fruitModule.sellItems(Player, canSell)	
				end)					
			end
		end
	end
end
game.Workspace.Greenhouse.Lee.Head.ClickDetector.MouseClick:Connect(function(Player)
	fruitModule.sellItems(Player, canSell)	
end)
game.Workspace.Greenhouse.Lee.Torso.ClickDetector.MouseClick:Connect(function(Player)
	fruitModule.sellItems(Player, canSell)	
end)	

		
-- Get a fruit bin
game.ReplicatedStorage.GiveFruitBin.OnClientEvent:connect(function()  -- comes from GetBasket (inside all fruit bins)
	if not Player.Backpack:FindFirstChild('Bin') or Player.Backpack:FindFirstChild('Fruit') then
		local tool = game.ReplicatedStorage['Bin']:Clone()  
		tool.Parent = Player.Backpack
	end
end)		

-- Teleport Gui Buttons
homeButton = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('SkillsGui',100).Teleport.Home
homeButton.MouseButton1Click:connect(function()
	local houseExt = Player.HouseExtTeleport.Value
	workspace:FindFirstChild(Player.Name).HumanoidRootPart.CFrame = CFrame.new(houseExt)
	-- Close any open Guis	
	local closeModule = require(workspace.Scripts.EditHouse_ModuleScript)
	closeModule.closeAllGuis(Player)
end)
scienceButton = Player:WaitForChild('PlayerGui'):WaitForChild('SkillsGui',100).Teleport.Science
scienceButton.MouseButton1Click:connect(function()
	local scienceLoc = Vector3.new(-74, 14.467, 5)
	workspace:FindFirstChild(Player.Name).HumanoidRootPart.CFrame = CFrame.new(scienceLoc)
	-- Close any open Guis
	local closeModule = require(workspace.Scripts.EditHouse_ModuleScript)
	closeModule.closeAllGuis(Player)
end)


-- House Door click detector
-- Listen for mouse clicks
UserInputService.InputBegan:Connect(function(input, gpe)	
	-- Find the part that was clicked 
	if not gpe and input.UserInputType == Enum.UserInputType.MouseButton1 then -- Check that the event is a left mouse button down event, and any GUI hasn't captured the event already
		local ray = camera:ScreenPointToRay(input.Position.X, input.Position.Y, 0) -- Convert from mouse screen location to a ray - the ray length is 1 stud
		local part = workspace:FindPartOnRay(Ray.new(ray.Origin, ray.Direction * 500)) -- find the part with raycasting, this time with a 500 stud length limit
		if part and part.Name == 'Door' then
			if part.Parent.Name == 'House1' or part.Parent.Name == 'House2' or part.Parent.Name == 'House3' then 
				game:GetService("ReplicatedStorage").ClickHouseDoorInt:FireServer(part) -- Goes to UpgradeHouseServer & SpawnPlayerHouse
			else
				game:GetService("ReplicatedStorage").ClickHouseDoorExt:FireServer(part) -- Goes to UpgradeHouseServer & SpawnPlayerHouse
			end
		end
	end
end)


-- Arrow over house
wait(1) -- wait for house
houseModel = Player:WaitForChild('HouseExt').Value
houseP = houseModel:WaitForChild('Container Pod').Container.Position
-- Place Arrow 
local arrow = game.ReplicatedStorage.HouseArrow:Clone()
arrow.Parent = workspace.SpawnedHouses
arrow.CFrame = CFrame.new(houseP.x, 32, houseP.z)



--[[
-- random number testing for unique identifiers
math.randomseed(tick()) 	-- hopefully get better random numbers
local randomId = math.random(100000,999999)
]]

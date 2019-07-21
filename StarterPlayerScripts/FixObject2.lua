-- Electrical
-- When player asks for a problem show the FixObject gui
-- When they click on a broken object they get a problem
-- After they successfully solve the problem show FixObject again (with the piece fixed) and wait for player to click another
-- When they fix all of the pieces they get money and exp and are shown another one broken object (or an arrow or popup to get another)
Player = game.Players.LocalPlayer
myObject = Player:WaitForChild('PlayerGui',100):WaitForChild('ElectricalFixObject', 1000).Broken
currentChild = myObject:FindFirstChild('Background')

-- Recreate Electrical object
function makeObject()
	-- Create blank board
	local pieces = myObject:GetChildren()
	for i = 1, #pieces do
		if pieces[i].Name == "Broken" or pieces[i].Name == "Ok" or pieces[i].Name == "R1" or pieces[i].Name == "R2" then
			-- Destroy this button and replace it 
			local place = pieces[i].Position
			local size =  pieces[i].Size
			pieces[i].Parent = nil
			-- Create new ImageButton
			local imageButton = Instance.new("ImageLabel")
			imageButton.Parent = myObject
			imageButton.Name = "Ok"
			imageButton.Position = place
			imageButton.Size = size
			imageButton.Image = "rbxassetid://1668977281"
		end
	end	
end


-- Creates a new broken object to fix 
function CreateBrokenObject()
	local pieces = myObject:GetChildren()
	local amount = math.random(2) + 2  -- number of pieces that will be broken
	local allBroke = {}  -- array of numbers corresponding to the images in Broken that will be switched to broken pieces
	for bp = 1, amount do 
		if bp == 1 then  -- first item in the array
			local imageL = false		
			while imageL == false do
				each = math.random(32)	-- image to switch		
				if pieces[each].Name == "Ok" or pieces[each].Name == "R1" or pieces[each].Name == "R2" or pieces[each].Name == "R3" then -- if it is an image in the object
					allBroke[bp] = each	 -- place that image number in the array
					imageL = true  -- we found a good one
				end
				wait(.1)
			end			
		else  -- other array elements
			local newBroke = false		
			while newBroke == false do  -- we haven't found a new image to switch to broken yet
				each = math.random(32)  -- image to switch	
				local thisBroken = false
				for b = 1, bp do  -- check elements in the array for repeats
					if each == allBroke[b] or pieces[each].Name == "Close" or pieces[each].Name == "Description" or pieces[each].Name == "Background" then
						thisBroken = true
					end	
				end
				if thisBroken == false then  -- we can use this number
					newBroke = true
				end
				wait(.1)
			end
		end
		allBroke[bp] = each  -- place that image number in the array
	end
	
	-- use the array of image numbers to change some pieces to broken ones
	for i = 1, amount do
		-- Destroy this button and replace it 
		local place = pieces[allBroke[i]].Position
		local size =  pieces[allBroke[i]].Size
		pieces[allBroke[i]].Parent = nil
		-- Create new ImageButton
		local imageButton = Instance.new("ImageButton")
		imageButton.Parent = myObject
		imageButton.Name = "Broken"
		imageButton.Position = place
		imageButton.Size = size
		imageButton.ZIndex = 3
		imageButton.BorderColor3 = Color3.new(255, 0, 0) -- red
		imageButton.Image = "rbxassetid://9180476"
	end		
end
CreateBrokenObject()

--[[ temporarily changing this to test multiple choice
-- acticate click detector on broken object pieces
function activateBrokenObject()
	local child = myObject:GetChildren()
	for i = 1, #child do
		if child[i].Name == 'Broken' then 			
			child[i].MouseButton1Click:connect(function()
				currentChild = child[i]	
				local problem = Player:WaitForChild('PlayerGui', 100).ElectricalFixObject.Problem	
				problem.Visible = true
				workspace.Camera.Blur.Size = 10	
				Player.Character.Humanoid.WalkSpeed = 0	
				Player.Character.Humanoid.JumpPower = 0
				-- Find current zoom
				local dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
				Player.CameraMinZoomDistance = dist
				Player.CameraMaxZoomDistance = dist
				Player.Answer.Value = "0"
				
				-- Display a random math problem
				local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
				myModule.electricalFixObject(Player)					
			end)  			
		end
	end
end
activateBrokenObject()
]]

function activateBrokenObject()
	local child = myObject:GetChildren()
	for i = 1, #child do
		if child[i].Name == 'Broken' then 			
			child[i].MouseButton1Click:connect(function()
				currentChild = child[i]	
				local problem = Player:WaitForChild('PlayerGui', 100).ElectricalFixObject2.Problem	
				problem.Visible = true
				workspace.Camera.Blur.Size = 10	
				Player.Character.Humanoid.WalkSpeed = 0	
				Player.Character.Humanoid.JumpPower = 0
				-- Find current zoom
				local dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
				Player.CameraMinZoomDistance = dist
				Player.CameraMaxZoomDistance = dist
				Player.Answer.Value = "0"
				
				-- Display a random math problem
				local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
				myModule.electricalSymbols(Player)					
			end)  			
		end
	end
end
activateBrokenObject()

-- Respond to correct answers
game.ReplicatedStorage.ElectricalAnsweredCorrectly.OnClientEvent:Connect(function()  -- comes from PlayerAddedMisc script
	Player.PlayerGui.ElectricalFixObject.Problem.Visible = false
	Player.PlayerGui.ElectricalFixObject2.Problem.Visible = false  -- remove after testing
	-- Destroy this button and replace it 
	local place = currentChild.Position
	local size =  currentChild.Size
	currentChild.Parent = nil
	-- Create new ImageButton
	local imageButton = Instance.new("ImageLabel")
	imageButton.Parent = myObject
	imageButton.Name = "Ok"
	imageButton.Position = place
	imageButton.Size = size
	imageButton.ZIndex = 3
	imageButton.Image = "rbxassetid://1668977281"
	myObject.Visible = true	
	-- Check to see if it's the last broken one (reward, message, and ask if another (if not make sure to close properly - see )) 
	local moreBroken = false
	local broken = myObject:GetChildren()
	for i = 1, #broken do
		if broken[i].Name == 'Broken' then 	
			moreBroken = true
		end
	end
	if moreBroken == false then
		local rewardModule = require(workspace.Scripts.Rewards_ModuleScript)
		rewardModule.ElectricalFixed()
	end
end)



-- FixObject DoAgain Gui Buttons
Player:WaitForChild('PlayerGui').ElectricalFixObject.DoAnother.Yes.MouseButton1Click:connect(function()
	-- Prepare and display another broken object
	Player.PlayerGui.ElectricalFixObject.Broken.Visible = false	
	Player.PlayerGui.ElectricalFixObject.DoAnother.Visible = false
	Player.PlayerGui.ElectricalFixObject.WaitForIt.Visible = true
	CreateBrokenObject()
	activateBrokenObject()
	Player.PlayerGui.ElectricalFixObject.Broken.Visible = true
	Player.PlayerGui.ElectricalFixObject.WaitForIt.Visible = false					
end)
Player:WaitForChild('PlayerGui').ElectricalFixObject.DoAnother.No.MouseButton1Click:connect(function()	
	Player.PlayerGui.ElectricalFixObject.Broken.Visible = false	
	Player.PlayerGui.ElectricalFixObject.DoAnother.Visible = false
	workspace.Camera.Blur.Size = 0
	Player.Character.Humanoid.WalkSpeed = 16
	Player.Character.Humanoid.JumpPower = 50
	Player.CameraMinZoomDistance = 0.5
	Player.CameraMaxZoomDistance = 5
end)
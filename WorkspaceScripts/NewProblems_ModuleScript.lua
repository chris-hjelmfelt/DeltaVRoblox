local myModule = {}
	function myModule.mathProblem(Player)
		local one = math.random(1,9)
		local two = math.random(1,9)
		
		local num1 = Player.PlayerGui.Math.MathGui.Problem:FindFirstChild("FirstNum")
		local num2 = Player.PlayerGui.Math.MathGui.Problem:FindFirstChild("SecondNum")		
		local answer = Player.PlayerGui.Math.MathGui.Problem:FindFirstChild("Answer")
		
		num1.Text = one
		num2.Text = two	
		answer.Text = 0	
		Player.Answer.Value = '0'		
	end
	
	function myModule.mathFix(Player)
		-- Variables and random generation
		local one = math.random(1,9)
		local two = math.random(1,9)
		local mathPicArray = {1622315578, 2248649819, 2253827069, 2253827802} 
		local pic = math.random(1,4)
		local num1 = Player.PlayerGui.Math.FixObject.Problem:WaitForChild('FirstNum')
		local num2 = Player.PlayerGui.Math.FixObject.Problem:WaitForChild('SecondNum')
		local answer = Player.PlayerGui.Math.FixObject.Problem:FindFirstChild("Answer")
		local imageFrame1 = Player.PlayerGui.Math.FixObject.Problem.FirstImages
		local imageFrame2 = Player.PlayerGui.Math.FixObject.Problem.SecondImages
		
		
		-- Display a random item in the images	
		for i = 1, one do
			imageFrame1:FindFirstChild('Item' .. i).Image = "http://www.roblox.com/asset/?id=" .. mathPicArray[pic]
		end
		for j = one+1, 9 do
			imageFrame1:FindFirstChild('Item' .. j).Image = ""
		end
		for k = 1, two do
			imageFrame2:FindFirstChild('Item' .. k).Image = "http://www.roblox.com/asset/?id=" .. mathPicArray[pic]
		end
		for l = two+1, 9 do
			imageFrame2:FindFirstChild('Item' .. l).Image = ""
		end
		
		-- Numbers and Answer
		num1.Text = one
		num2.Text = two	
		answer.Text = 0	
		Player.Answer.Value = '0'		
	end
	
	function myModule.cryptoProblem(Player)
		local one = math.random(1,5)
		local two = math.random(0,5)
		local three = math.random(0,5)
		local four = math.random(0,5)
		
		local num = Player.PlayerGui.CryptoGui.Problem:FindFirstChild("Number")
		local answer = Player.PlayerGui.CryptoGui.Problem:FindFirstChild("Answer")
		
		num.Text = (one*1000) + (two*100) + (three*10) + four
		answer.Text = 0		
		Player.Answer.Value = '0'
	end
	
	function myModule.cryptoProblem2(Player)
		local one = math.random(65,90)
		local two = math.random(65,90)
		local three = math.random(65,90)
		local four = math.random(65,90)
		
		local original = Player.PlayerGui.CryptoGui2.Problem:FindFirstChild("Original")
		local answer = Player.PlayerGui.CryptoGui2.Problem:FindFirstChild("Answer")
		
		original.Text = string.char(one, two, three, four)
		answer.Text = ""	
		Player.Answer.Value = ""
	end
	
	function myModule.electricalProblem(Player)
		local gui = Player.PlayerGui.ElectricalGui
		local rand = math.random(1,5)
		while rand == gui.Last.Value do
			rand = math.random(1,5)
		end
		gui.Last.Value = rand
		gui.Problem.imageNum.Value = rand
		
		local electricalPicArray = {1622315578, 1622521074, 2248649819, 2253827069, 2253827802}
		local num1 = gui.Problem:FindFirstChild("Component")
		local answer = gui.Problem:FindFirstChild("Answer")
		
		num1.Image = "http://www.roblox.com/asset/?id=" .. electricalPicArray[rand]
		answer.Text = ""
		Player.Answer.Value = ""			
	end
	
	function myModule.electricalFixObject(Player)
		local gui = Player.PlayerGui.ElectricalFixObject
		local rand = math.random(1,5)
		while rand == gui.Last.Value do
			rand = math.random(1,5)
		end
		gui.Last.Value = rand
		gui.Problem.imageNum.Value = rand
		
		local electricalPicArray = {1622315578, 1622521074, 2248649819, 2253827069, 2253827802}
		local num1 = gui.Problem:FindFirstChild("Component")
		local answer = gui.Problem:FindFirstChild("Answer")
		
		num1.Image = "http://www.roblox.com/asset/?id=" .. electricalPicArray[rand]
		answer.Text = ""
		Player.Answer.Value = ""			
	end
	
	function myModule.electricalSymbols(Player)
		local gui = Player.PlayerGui.ElectricalFixObject2
		local numComp = 5  -- number of components and symbols
		local rand = math.random(1,numComp)
		while rand == gui.Last.Value do  -- Don't show the same component twice in a row
			rand = math.random(1,numComp)
		end
		gui.Last.Value = rand
		gui.Problem.imageNum.Value = rand
		
		local componentNames = {"DIODE", "RESISTOR", "INTEGRATED CIRCUIT", "BATTERY", "CAPACITOR"}	
		local componentNames2 = {"DIODE", "RESISTOR", "IC", "BATTERY", "CAPACITOR"}
		local electricalPicArray = {1622315578, 1622521074, 2248649819, 2253827069, 2253827802}
		
		local comp = gui.Problem:FindFirstChild("Component")
		local answer1 = gui.Problem:FindFirstChild("Answer1")
		local answer2 = gui.Problem:FindFirstChild("Answer2")
		local answer3 = gui.Problem:FindFirstChild("Answer3")
		local answer4 = gui.Problem:FindFirstChild("Answer4")
				
		comp.Image = "http://www.roblox.com/asset/?id=" .. electricalPicArray[rand]
		local rand2 = math.random(1,4)		
		local randomizedAnswer = {0,0,0,0}
		randomizedAnswer[rand2] = componentNames[rand]
		for i = 1, 4 do
			if i ~= rand2 then
				local safety = 1  -- no infinite loops
				local rand3 = math.random(1, numComp)  -- make the while loop run at least once
				while (componentNames[rand3] == randomizedAnswer[1] or componentNames[rand3] == randomizedAnswer[2] or componentNames[rand3] == randomizedAnswer[3] or componentNames[rand3] == randomizedAnswer[4]) and safety < 1000 do
					rand3 = math.random(1, numComp)
					safety = safety + 1
				end
				if safety > 100 then
					print('NP_MS - safety')
				end
				randomizedAnswer[i] = componentNames[rand3]
			end
		end
		answer1.Text = randomizedAnswer[1]
		answer2.Text = randomizedAnswer[2]
		answer3.Text = randomizedAnswer[3]
		answer4.Text = randomizedAnswer[4]
		Player.Answer.Value = ""			
	end
	
	function myModule.chemistryProblem(Player)
		local gui = Player.PlayerGui.ChemistryGui
		local rand = math.random(1,6)
		while rand == gui.Last.Value do
			rand = math.random(1,6)
		end
		gui.Last.Value = rand
		gui.Problem.imageNum.Value = rand
		
		local chemPicArray = {2274413356, 2274413067, 2274413637, 2274413993, 2274414195, 2274367205}
		local atom = Player.PlayerGui.ChemistryGui.Problem:FindFirstChild("Atom")
		local answer = Player.PlayerGui.ChemistryGui.Problem:FindFirstChild("Answer")
		
		atom.Image = "http://www.roblox.com/asset/?id=" .. chemPicArray[rand]
		answer.Text = ""
		Player.Answer.Value = ""
	end
	
	function myModule.closeProblemGui(Player, Gui)
		Player.PlayerGui:FindFirstChild(Gui).Problem.Visible = false
		--Need to check for other Guis open
		if Player.PlayerGui.ElectricalBook.Page1.Visible == false and Player.PlayerGui.ChemistryBook.Page1.Visible == false then
			workspace.Camera.Blur.Size = 0
			Player.Character.Humanoid.WalkSpeed = 16
			Player.Character.Humanoid.JumpPower = 50
			Player.CameraMinZoomDistance = 0.5
			Player.CameraMaxZoomDistance = 50
		end
	end
	
	function myModule.closeBookGui(Player, Gui)
		Player.PlayerGui:FindFirstChild(Gui).Page1.Visible = false
		--Need to check for other Guis open
		if Player.PlayerGui.ElectricalGui.Problem.Visible == false and Player.PlayerGui.ChemistryGui.Problem.Visible == false then
			workspace.Camera.Blur.Size = 0
			Player.Character.Humanoid.WalkSpeed = 16
			Player.Character.Humanoid.JumpPower = 50
			Player.CameraMinZoomDistance = 0.5
			Player.CameraMaxZoomDistance = 50
		end
	end
	
	function myModule.closeMissionGui(Player, Gui)
		Player.PlayerGui:FindFirstChild(Gui).Mission.Visible = false
		workspace.Camera.Blur.Size = 0
		Player.Character.Humanoid.WalkSpeed = 16
		Player.Character.Humanoid.JumpPower = 50
		Player.CameraMinZoomDistance = 0.5
		Player.CameraMaxZoomDistance = 50
	end
	
	function myModule.closeFixObjectGui(Player, Gui)
		if Gui == 'FixObject' then
			Player.PlayerGui.Math:FindFirstChild(Gui).Broken.Visible = false
		else
			Player.PlayerGui:FindFirstChild(Gui).Broken.Visible = false
		end
		workspace.Camera.Blur.Size = 0
		Player.Character.Humanoid.WalkSpeed = 16
		Player.Character.Humanoid.JumpPower = 50
		Player.CameraMinZoomDistance = 0.5
		Player.CameraMaxZoomDistance = 50
	end
	
return myModule


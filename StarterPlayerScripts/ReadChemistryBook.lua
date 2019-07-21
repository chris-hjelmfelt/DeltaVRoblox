-- Chemistry Book Functionality and 
-- Periodic table and book open buttons on problem gui
--------------------------------------------------------------------------------------

Player = game.Players.LocalPlayer
chemistryBook = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Nailahs Table').Book
chemistryGui = Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryGui', 100).Problem.Book
chemistryPT = Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryGui', 100).Problem.Table
chemistryQuestion = Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryGui', 100).Problem.Question


-- Player clicks on Chemistry Gui button for Periodic Table
chemistryPT.OpenPT.MouseButton1Click:connect(function()
	Player.PlayerGui.ChemistryPTable.Page1.Visible = true
end)


--Open Chemistry HowTo Gui
function openHowToGui()
	Player = game.Players.LocalPlayer
	Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryHowTo').Page1.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	local dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
end
-- Player clicks on Chemistry Gui button for How To Do It
chemistryQuestion.OpenHowTo.MouseButton1Click:connect(openHowToGui)
	


--Open Chemistry Book
function openBook()
	Player = game.Players.LocalPlayer
	Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryBook').Page1.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	local dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	local book = Player.PlayerGui.ChemistryBook
	local page = book:FindFirstChild("Page1")
	book.Page.Value = 1
	newPage(page, 1)	
end
-- Player clicks on chemistry book
chemistryBook.ClickDetector.MouseClick:Connect(openBook)
-- Player clicks on chemistry Gui button
chemistryGui.OpenBook.MouseButton1Click:connect(openBook)	
	
-- Next Button
Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryBook').Page1.Next.MouseButton1Click:connect(function()	
		local book = Player.PlayerGui.ChemistryBook
		local page = book:FindFirstChild("Page1")
		page:FindFirstChild("PageTurn"):Play()
		if book.Page.Value == 1 then
			page.Previous.Visible = true
		elseif book.Page.Value == 2 then
			page.Next.Visible = false
		end
		book.Page.Value = book.Page.Value + 1
		hideElements(page)
		newPage(page, book.Page.Value)
end)

-- Previous Button
Player.PlayerGui:WaitForChild('ChemistryBook').Page1.Previous.MouseButton1Click:connect(function()	
		local book = Player.PlayerGui.ChemistryBook
		local page = book:FindFirstChild("Page1")
		page:FindFirstChild("PageTurn"):Play()
		if book.Page.Value == 2 then
			page.Previous.Visible = false
		elseif book.Page.Value == 3 then
			page.Next.Visible = true
		end
		book.Page.Value = book.Page.Value - 1
		hideElements(page)
		newPage(page, book.Page.Value)
		
end)

-- Hide
function hideElements(page)
	page.Title.Visible = false
	page.Description1.Visible = false
	page.Description2.Visible = false
	page.Description3.Visible = false
	page.Description4.Visible = false
	page.Pic1.Visible = false
	page.Pic2.Visible = false
	page.Pic3.Visible = false
	page.Pic4.Visible = false
end


-- Chemistry HowTo Contents 
function newPage(page, num)
	if num == 1 then
		page.Title.Visible = true
		page.Title.Text = "Identifying an Atom"
		page.Description1.Visible = true
		page.Description1.Text = "The periodic table shows each type of atom. These different types are called Elements."
		page.Description3.Visible = true
		page.Description3.Text = "The number of an element in the periodic table is the smae as the number of protons (shown as red circles)."
	elseif num == 2 then
		page.Pic3.Image = ""
		page.Title.Visible = true
		page.Title.Text = "Atoms"
		page.Description1.Visible = true
		page.Description1.Text = "Elements are made from different types of atoms. There are 1,670,000,000,000,000,000,000 atoms of Oxygen in a drop of water."
		page.Description3.Visible = true
		page.Description3.Text = "Atoms contain 3 main parts: Protons, Neutrons and Electrons. Protons have a positive electrical charge, electrons have a negative electrical charge, and neutrons have no electrical charge. Electricity is caused by electrons moving from one atom to another."
	elseif num == 3 then
		page.Pic1.Visible = true
		page.Pic1.Image = "rbxassetid://2274366197"	
		page.Description2.Visible = true
		page.Description2.Text = "The number of protons in an atom determines what element it is. You can recognize an element by counting the protons and then look on the periodic table."
		page.Pic3.Visible = true
		page.Pic3.Image = "rbxassetid://2274367205"
		page.Description4.Visible = true
		page.Description4.Text = "The atom shown is carbon. There are 6 protons (red). Look at the periodic table and find the 6th element."
	end
	end
	
	
-- Chemistry Book Contents of each page
function newPage(page, num)
	if num == 1 then
		page.Title.Visible = true
		page.Title.Text = "The Periodic Table of Elements."
		page.Description1.Visible = true
		page.Description1.Text = "The periodic table contains elements. Elements are the building blocks of the universe. Iron, Oxygen, Gold and Silicon are elements."
		page.Description3.Visible = true
		page.Description3.Text = "Other things are made up of combinations of elements. Water is made from a combination of Hydrogen and Oxygen."
	elseif num == 2 then
		page.Pic3.Image = ""
		page.Title.Visible = true
		page.Title.Text = "Atoms"
		page.Description1.Visible = true
		page.Description1.Text = "Elements are made from different types of atoms. There are 1,670,000,000,000,000,000,000 atoms of Oxygen in a drop of water."
		page.Description3.Visible = true
		page.Description3.Text = "Atoms contain 3 main parts: Protons, Neutrons and Electrons. Protons have a positive electrical charge, electrons have a negative electrical charge, and neutrons have no electrical charge. Electricity is caused by electrons moving from one atom to another."
	elseif num == 3 then
		page.Pic1.Visible = true
		page.Pic1.Image = "rbxassetid://2274366197"		
		page.Description2.Visible = true
		page.Description2.Text = "The number of protons in an atom determines what element it is. You can recognize an element by counting the protons and then look on the periodic table."
		page.Pic3.Visible = true
		page.Pic3.Image = "rbxassetid://2274367205"	
		page.Description4.Visible = true
		page.Description4.Text = "The atom shown is carbon. There are 6 protons (red). Look at the periodic table and find the 6th element."
	end
end
	
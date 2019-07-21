Player = game.Players.LocalPlayer
electricalBook = game.Workspace:FindFirstChild('Science Area'):FindFirstChild('Maries Table').Book
electricalGui = Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalFixObject', 100).Problem.Book
electricalGui2 = Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalFixObject2', 100).Problem.Book

-- Contents of each page
function newPage(page, num)
	if num == 1 then
		page.CompPic.Image = "http://www.roblox.com/asset/?id=1622315578"
		page.CompSymbol.Image = "http://www.roblox.com/asset/?id=1622633513"
		page.CompName.Text = "DIODE"
		page.Description.Text = "A diode is an electrical component designed to conduct electric current in only one direction. It has two ends (or terminals), each with an electrode of a different charge. The 'anode' end has a positive charge relative to the negatively charged 'cathode' end. Current naturally flows in the direction from the anode to the cathode."
	elseif num == 2 then
		page.CompPic.Image = "http://www.roblox.com/asset/?id=1622521074"
		page.CompSymbol.Image = "http://www.roblox.com/asset/?id=1622780746"
		page.CompName.Text = "RESISTOR"
		page.Description.Text = "A resistor limits the electrical current that flows through a circuit. Resistance is the restriction of current. In a resistor the energy of the electrons that pass through the resistor are changed to heat and/or light."
	elseif num == 3 then
		page.CompPic.Image = "http://www.roblox.com/asset/?id=2248649819"
		page.CompSymbol.Image = "http://www.roblox.com/asset/?id=2248650528"
		page.CompName.Text = "INTEGRATED CIRCUIT"
		page.Description.Text = "An integrated circuit."	
	elseif num == 4 then
		page.CompPic.Image = "http://www.roblox.com/asset/?id=2253827069"
		page.CompSymbol.Image = "http://www.roblox.com/asset/?id=2253827462"
		page.CompName.Text = "BATTERY"
		page.Description.Text = "A battery powers a circuit."
	elseif num == 5 then
		page.CompPic.Image = "http://www.roblox.com/asset/?id=2253827802"
		page.CompSymbol.Image = "http://www.roblox.com/asset/?id=2253828095"
		page.CompName.Text = "CAPACITOR"
		page.Description.Text = "A capacitor stores up charge."
	end
	end
	
--Open Electrical Book
function openBook()
	Player = game.Players.LocalPlayer
	Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalBook').Page1.Visible = true
	workspace.Camera.Blur.Size = 10	
	Player.Character.Humanoid.WalkSpeed = 0	
	Player.Character.Humanoid.JumpPower = 0
	-- Find current zoom
	local dist = (workspace.CurrentCamera.CoordinateFrame.p - Player.Character.Head.Position).magnitude
	Player.CameraMinZoomDistance = dist
	Player.CameraMaxZoomDistance = dist
	local book = Player.PlayerGui.ElectricalBook
	local page = book:FindFirstChild("Page1")
	book.Page.Value = 1
	newPage(page, 1)	
end
-- Player clicks on Book
electricalBook.ClickDetector.MouseClick:Connect(openBook)
-- Player clicks on ElectricalGui button
electricalGui.OpenBook.MouseButton1Click:connect(openBook)	
-- Player clicks on ElectricalGui2 button
electricalGui2.OpenBook.MouseButton1Click:connect(openBook)
	
-- Next Button
Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalBook').Page1.Next.MouseButton1Click:connect(function()	
		local book = Player.PlayerGui.ElectricalBook
		local page = book:FindFirstChild("Page1")
		page:FindFirstChild("PageTurn"):Play()
		if book.Page.Value == 1 then
			page.Previous.Visible = true
		elseif book.Page.Value == 4 then
			page.Next.Visible = false
		end
		book.Page.Value = book.Page.Value + 1
		newPage(page, book.Page.Value)
end)

-- Previous Button
Player.PlayerGui:WaitForChild('ElectricalBook').Page1.Previous.MouseButton1Click:connect(function()	
		local book = Player.PlayerGui.ElectricalBook
		local page = book:FindFirstChild("Page1")
		page:FindFirstChild("PageTurn"):Play()
		if book.Page.Value == 2 then
			page.Previous.Visible = false
		elseif book.Page.Value == 5 then
			page.Next.Visible = true
		end
		book.Page.Value = book.Page.Value - 1
		newPage(page, book.Page.Value)
		print('Previous')
end)



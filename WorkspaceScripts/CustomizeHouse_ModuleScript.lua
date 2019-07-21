
local module = {}
	function module.customize(Player)
		-- Find player house
		local houseInt = Player:WaitForChild("HouseInt",1000).Value 
		local houseExt = Player:WaitForChild("HouseExt",1000).Value
		local customizeInt = Player:WaitForChild('PlayerGui',1000):WaitForChild('Customize2',1000)
		-- hide all interior customization Guis
		houseExt.Door.ClickDetector.mouseClick:connect(function()
			wait(0.5) -- don't show button until they have completed teleporting
			customizeInt.EditButton.Edit.Image = "rbxassetid://2445024042"
			customizeInt.EditButton.Visible = true
		end)		
		
		-- show interior customization button
		houseInt.Door.ClickDetector.mouseClick:connect(function()	
			customizeInt.EditButton.Visible = false
			customizeInt.ColorChange.Visible = false					
			customizeInt.EditDirections.Visible = false	
		end)	
		
	end
return module

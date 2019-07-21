local missionModule = {}
	function missionModule.newMission(Player)
		local mGui = Player.PlayerGui.MissionGui.Mission
		local title = mGui:FindFirstChild("Title")
		local desc = mGui.Pieces:FindFirstChild("Description")
		local task1 = mGui.Pieces:FindFirstChild("Task1")
		local task2 = mGui.Pieces:FindFirstChild("Task2")
		local task3 = mGui.Pieces:FindFirstChild("Task3")
		local task4 = mGui.Pieces:FindFirstChild("Task4")
		
		--if Player.missiondata.Mission.Value == 1 then
			title.Text = "Welcome"
			desc.Text = "You can be a part of building "..
				"this amazing colony. Help me by completing tasks and I will give you special credits."
			task1.Text = "1. Collect 2 full baskets of fruit"
			task2.Text = "2. Do 2 sets of math"
		--elseif Player.missiondata.Mission.Value == 2 then
			
		--end
	end
return missionModule


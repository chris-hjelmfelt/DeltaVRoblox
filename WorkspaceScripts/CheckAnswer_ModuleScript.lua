local player = game.Players.LocalPlayer
local sound = player.PlayerGui.Sounds
local debounce = false

local module = {}
	function module.Math01()		
		local problem = player.PlayerGui.Math.MathGui.Problem
		local num1 = problem:FindFirstChild("FirstNum")
		local num2 = problem:FindFirstChild("SecondNum")
		local answer = problem:FindFirstChild("Answer")
		local correctAnswer = tonumber(num1.Text + num2.Text)
		local playerAnswer = tonumber(answer.Text)
		
		local problem = "math01"
		local rewardModule = require(workspace.Scripts.Rewards_ModuleScript)
		rewardModule.allReward(problem, correctAnswer, correctAnswer, playerAnswer)
		--if correctAnswer == playerAnswer then 			
			--local mathModule = require(workspace.Scripts.NewProblems_ModuleScript)
			--mathModule.mathProblem(player)	
		--end
		local UserInputService = game:GetService("UserInputService")
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
	
	function module.Electrical01()
		local componentNames = {"DIODE", "RESISTOR", "INTEGRATED CIRCUIT", "BATTERY", "CAPACITOR"}	
		local componentNames2 = {"DIODE", "RESISTOR", "IC", "BATTERY", "CAPACITOR"}
		local problem = player.PlayerGui.ElectricalGui.Problem
		local imageNum = problem.imageNum.Value
		local playerAnswer = problem:FindFirstChild("Answer").Text
		local correctAnswer1 = componentNames[imageNum]
		local correctAnswer2 = componentNames2[imageNum]
		
		local problem = "electrical01"
		local rewardModule = require(workspace.Scripts.Rewards_ModuleScript)
		rewardModule.allReward(problem, correctAnswer1, correctAnswer2, playerAnswer)	
		--if correctAnswer1 == playerAnswer or correctAnswer2 == playerAnswer then 		
			--local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
			--myModule.electricalProblem(player)	
		--end
		local UserInputService = game:GetService("UserInputService")
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end	
	
	function module.Chemistry01()
		local atomSymbolArray = {'H', 'HE', 'LI', 'BE', 'B', 'C'}
		local atomNameArray = {'HYDROGEN', 'HELIUM', 'LITHIUM', 'BERYLLIUM', 'BORON', 'CARBON'}
		local problem = player.PlayerGui.ChemistryGui.Problem
		local imageNum = problem.imageNum.Value
		local playerAnswer = problem:FindFirstChild("Answer").Text
		local correctAnswer1 = atomSymbolArray[imageNum]
		local correctAnswer2 = atomNameArray[imageNum]
		
		local problem = "chemistry01"
		local rewardModule = require(workspace.Scripts.Rewards_ModuleScript)
		rewardModule.allReward(problem, correctAnswer1, correctAnswer2, playerAnswer)	
		if correctAnswer1 == playerAnswer or correctAnswer2 == playerAnswer then 		
			local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
			myModule.chemistryProblem(player)	
		end
		local UserInputService = game:GetService("UserInputService")
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
	
	function module.FixMath()
		local problem = player.PlayerGui.Math.FixObject.Problem		
		local num1 = problem:FindFirstChild("FirstNum")
		local num2 = problem:FindFirstChild("SecondNum")
		local answer = problem:FindFirstChild("Answer")
		local correctAnswer = tonumber(num1.Text + num2.Text)
		local playerAnswer = tonumber(answer.Text)
		
		-- Correct answer
		if correctAnswer == playerAnswer then
			player:WaitForChild('PlayerGui'):WaitForChild('Math').FixObject.Correct.Visible = true  -- show Gui
			sound:FindFirstChild("CorrectAnswer"):Play()
			wait(1)
			player.PlayerGui.Math.FixObject.Correct.Visible = false  -- hide Gui
			game.ReplicatedStorage.MathAnsweredCorrectly:FireServer()  -- goes to PlayerAddedMisc script
		else
			-- Indicate wrong answer
			problem:WaitForChild("Wrong").Visible = true  -- show Gui
			sound:FindFirstChild("WrongAnswer"):Play()
			
			wait(1)
			problem:FindFirstChild("Wrong").Visible = false  -- hide Gui
		end
		local UserInputService = game:GetService("UserInputService")
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
	
	function module.ElectricalFixObject()
		local componentNames = {"DIODE", "RESISTOR", "INTEGRATED CIRCUIT", "BATTERY", "CAPACITOR"}	
		local componentNames2 = {"DIODE", "RESISTOR", "IC", "BATTERY", "CAPACITOR"}
		local problem = player.PlayerGui.ElectricalFixObject.Problem
		local imageNum = problem.imageNum.Value
		local playerAnswer = problem:FindFirstChild("Answer").Text
		local correctAnswer1 = componentNames[imageNum]
		local correctAnswer2 = componentNames2[imageNum]
		
		-- Correct answer
		if correctAnswer1 == playerAnswer or correctAnswer2 == playerAnswer then
			player:WaitForChild('PlayerGui').ElectricalFixObject.Correct.Visible = true  -- show Gui
			sound:FindFirstChild("CorrectAnswer"):Play()
			wait(1)
			player.PlayerGui.ElectricalFixObject.Correct.Visible = false  -- hide Gui
			game.ReplicatedStorage.ElectricalAnsweredCorrectly:FireServer()  -- goes to PlayerAddedMisc script
		else
			-- Indicate wrong answer
			problem:WaitForChild("Wrong").Visible = true  -- show Gui
			sound:FindFirstChild("WrongAnswer"):Play()
			wait(1)
			problem:FindFirstChild("Wrong").Visible = false  -- hide Gui
		end
		local UserInputService = game:GetService("UserInputService")
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default		
	end
	

	function module.ElectricalFixObject2(answer)
		local componentNames = {"DIODE", "RESISTOR", "INTEGRATED CIRCUIT", "BATTERY", "CAPACITOR"}	
		local componentNames2 = {"DIODE", "RESISTOR", "IC", "BATTERY", "CAPACITOR"}
		local problem = player.PlayerGui.ElectricalFixObject2.Problem
		local imageNum = problem.imageNum.Value
		local playerAnswer = answer
		local correctAnswer1 = componentNames[imageNum]
		local correctAnswer2 = componentNames2[imageNum]
		
		-- Correct answer
		if correctAnswer1 == playerAnswer or correctAnswer2 == playerAnswer then
			player:WaitForChild('PlayerGui').ElectricalFixObject2.Correct.Visible = true  -- show Gui
			sound:FindFirstChild("CorrectAnswer"):Play()
			wait(1)
			player.PlayerGui.ElectricalFixObject2.Correct.Visible = false  -- hide Gui
			game.ReplicatedStorage.ElectricalAnsweredCorrectly:FireServer()  -- goes to PlayerAddedMisc script
		else
			-- disable problems briefly to prevent spam clicking answers to find the correct one
			problem.Answer1.Active = false
			problem.Answer2.Active = false
			problem.Answer3.Active = false
			problem.Answer4.Active = false
			-- Indicate wrong answer
			problem:WaitForChild("Wrong").Visible = true  -- show Gui
			sound:FindFirstChild("WrongAnswer"):Play()
			wait(2)
			problem:FindFirstChild("Wrong").Visible = false  -- hide Gui
			-- reenable problems 
			problem.Answer1.Active = true
			problem.Answer2.Active = true
			problem.Answer3.Active = true
			problem.Answer4.Active = true
		end
		local UserInputService = game:GetService("UserInputService")
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default	
	end
return module

local Player = game.Players.LocalPlayer

-- If user presses enter check the answer
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
	local Player = game.Players.LocalPlayer
	local answer = Player:WaitForChild("Answer",1000)
	
	if (inputObject.KeyCode == Enum.KeyCode.Return) then
		local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
		if Player.PlayerGui.Math.FixObject.Broken.Visible == true then
			inputModule.FixMath()
		elseif Player.PlayerGui.Math.MathGui.Problem.Visible == true then
			inputModule.Math01()	
		elseif Player.PlayerGui.ElectricalGui.Problem.Visible == true then
			inputModule.Electrical01()
		elseif Player.PlayerGui.ElectricalFixObject.Problem.Visible == true then
			inputModule.ElectricalFixObject()
		elseif Player.PlayerGui.ChemistryGui.Problem.Visible == true then
			inputModule.Chemistry01()
		end
	end	
		
	if (inputObject.KeyCode == Enum.KeyCode.Backspace) then
		if Player.PlayerGui.Math.MathGui.Problem.Visible == true or Player.PlayerGui.Math.FixObject.Problem.Visible == true then
			local remainder = math.fmod(answer.Value,10)
			answer.Value = (answer.Value - remainder) / 10
			if answer.Value == "" then
				answer.Value = "0"
			end
		else
			answer.Value = answer.Value:sub(1, -2)
		end
	end
	
	-- Display current answer (for now just put in all Guis)
	Player.PlayerGui:WaitForChild("Math",100).MathGui.Problem.Answer.Text = answer.Value
	Player.PlayerGui:WaitForChild("Math",100).FixObject.Problem.Answer.Text = answer.Value
	Player.PlayerGui:WaitForChild("ElectricalGui",100).Problem.Answer.Text = answer.Value
	Player.PlayerGui:WaitForChild("ElectricalFixObject",100).Problem.Answer.Text = answer.Value
	Player.PlayerGui:WaitForChild("ChemistryGui",100).Problem.Answer.Text = answer.Value
	Player.PlayerGui:WaitForChild("CryptoGui",100).Problem.Answer.Text = answer.Value
	Player.PlayerGui:WaitForChild("CryptoGui2",100).Problem.Answer.Text = answer.Value
end)


-- Check button on Guis
Player:WaitForChild('PlayerGui',100):WaitForChild('Math',100).MathGui.Problem.Check.MouseButton1Click:connect(function()
	local answer = Player.Answer	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.Math01()		
	Player.PlayerGui.Math.MathGui.Problem.Answer.Text = answer.Value
end)
Player:WaitForChild('PlayerGui'):WaitForChild('Math').FixObject.Problem.Check.MouseButton1Click:connect(function()
	local answer = Player.Answer	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.FixMath()		
	Player.PlayerGui.Math.FixObject.Problem.Answer.Text = answer.Value
end)
Player:WaitForChild('PlayerGui'):WaitForChild('ChemistryGui').Problem.Check.MouseButton1Click:connect(function()
	local answer = Player.Answer	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.Chemistry01()		
	Player.PlayerGui.ChemistryGui.Problem.Answer.Text = answer.Value
end)
Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalGui').Problem.Check.MouseButton1Click:connect(function()
	local answer = Player.Answer	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.Electrical01()		
	Player.PlayerGui.ElectricalGui.Problem.Answer.Text = answer.Value
end)
Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalFixObject').Problem.Check.MouseButton1Click:connect(function()
	local answer = Player.Answer	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.ElectricalFixObject()		
	Player.PlayerGui.ElectricalGui.Problem.Answer.Text = answer.Value
end)


-- Check Multiple Choice
electrical1 = Player:WaitForChild('PlayerGui'):WaitForChild('ElectricalFixObject2').Problem
electrical1.Answer1.MouseButton1Click:connect(function()
	local answer = electrical1.Answer1.Text	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.ElectricalFixObject2(answer)		
	--Player.PlayerGui.ElectricalGui.Problem.Answer.Text = answer
end)
electrical1.Answer2.MouseButton1Click:connect(function()
	local answer = electrical1.Answer2.Text	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.ElectricalFixObject2(answer)		
	--Player.PlayerGui.ElectricalGui.Problem.Answer.Text = answer
end)
electrical1.Answer3.MouseButton1Click:connect(function()
	local answer = electrical1.Answer3.Text	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.ElectricalFixObject2(answer)		
	--Player.PlayerGui.ElectricalGui.Problem.Answer.Text = answer
end)
electrical1.Answer4.MouseButton1Click:connect(function()
	local answer = electrical1.Answer4.Text	
	local inputModule = require(workspace.Scripts.CheckAnswer_ModuleScript)
	inputModule.ElectricalFixObject2(answer)		
	--Player.PlayerGui.ElectricalGui.Problem.Answer.Text = answer
end)	
	
-- Numbers
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
	local Player = game.Players.LocalPlayer
	local answer = Player:WaitForChild("Answer",1000)
	-- Needed to avoid an error although I don't think I use answerNum anywhere
	local answerNum = tonumber(answer.Value) 
	
	if (inputObject.KeyCode == Enum.KeyCode.One) or (inputObject.KeyCode == Enum.KeyCode.KeypadOne) then
		answer.Value = (answer.Value * 10) + 1
	end
	if (inputObject.KeyCode == Enum.KeyCode.Two) or (inputObject.KeyCode == Enum.KeyCode.KeypadTwo) then
		answer.Value = (answer.Value * 10) + 2
	end
	if (inputObject.KeyCode == Enum.KeyCode.Three) or (inputObject.KeyCode == Enum.KeyCode.KeypadThree) then
		answer.Value = (answer.Value * 10) + 3
	end
	if (inputObject.KeyCode == Enum.KeyCode.Four) or (inputObject.KeyCode == Enum.KeyCode.KeypadFour) then
		answer.Value = (answer.Value * 10) + 4
	end
	if (inputObject.KeyCode == Enum.KeyCode.Five) or (inputObject.KeyCode == Enum.KeyCode.KeypadFive) then
		answer.Value = (answer.Value * 10) + 5
	end
	if (inputObject.KeyCode == Enum.KeyCode.Six) or (inputObject.KeyCode == Enum.KeyCode.KeypadSix) then
		answer.Value = (answer.Value * 10) + 6
	end
	if (inputObject.KeyCode == Enum.KeyCode.Seven) or (inputObject.KeyCode == Enum.KeyCode.KeypadSeven) then
		answer.Value = (answer.Value * 10) + 7
	end
	if (inputObject.KeyCode == Enum.KeyCode.Eight) or (inputObject.KeyCode == Enum.KeyCode.KeypadEight) then
		answer.Value = (answer.Value * 10) + 8
	end
	if (inputObject.KeyCode == Enum.KeyCode.Nine) or (inputObject.KeyCode == Enum.KeyCode.KeypadNine) then
		answer.Value = (answer.Value * 10) + 9
	end
	if (inputObject.KeyCode == Enum.KeyCode.Zero) or (inputObject.KeyCode == Enum.KeyCode.KeypadZero) then
		answer.Value = (answer.Value * 10) + 0
	end
end)


--Letters and Space
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
	local Player = game.Players.LocalPlayer
	local answer = Player:WaitForChild("Answer",1000)
	
	if string.len(answer.Value) < 20 then
		if (inputObject.KeyCode == Enum.KeyCode.A) then
			answer.Value = answer.Value .. "A"
		end
		if (inputObject.KeyCode == Enum.KeyCode.B) then
			answer.Value = answer.Value .. "B"
		end
		if (inputObject.KeyCode == Enum.KeyCode.C) then
			answer.Value = answer.Value .. "C"
		end
		if (inputObject.KeyCode == Enum.KeyCode.D) then
			answer.Value = answer.Value .. "D"
		end
		if (inputObject.KeyCode == Enum.KeyCode.E) then
			answer.Value = answer.Value .. "E"
		end
		if (inputObject.KeyCode == Enum.KeyCode.F) then
			answer.Value = answer.Value .. "F"
		end
		if (inputObject.KeyCode == Enum.KeyCode.G) then
			answer.Value = answer.Value .. "G"
		end
		if (inputObject.KeyCode == Enum.KeyCode.H) then
			answer.Value = answer.Value .. "H"
		end
		if (inputObject.KeyCode == Enum.KeyCode.I) then
			answer.Value = answer.Value .. "I"
		end
		if (inputObject.KeyCode == Enum.KeyCode.J) then
			answer.Value = answer.Value .. "J"
		end
		if (inputObject.KeyCode == Enum.KeyCode.K) then
			answer.Value = answer.Value .. "K"
		end
		if (inputObject.KeyCode == Enum.KeyCode.L) then
			answer.Value = answer.Value .. "L"
		end
		if (inputObject.KeyCode == Enum.KeyCode.M) then
			answer.Value = answer.Value .. "M"
		end
		if (inputObject.KeyCode == Enum.KeyCode.N) then
			answer.Value = answer.Value .. "N"
		end
		if (inputObject.KeyCode == Enum.KeyCode.O) then
			answer.Value = answer.Value .. "O"
		end
		if (inputObject.KeyCode == Enum.KeyCode.P) then
			answer.Value = answer.Value .. "P"
		end
		if (inputObject.KeyCode == Enum.KeyCode.Q) then
			answer.Value = answer.Value .. "Q"
		end
		if (inputObject.KeyCode == Enum.KeyCode.R) then
			answer.Value = answer.Value .. "R"
		end
		if (inputObject.KeyCode == Enum.KeyCode.S) then
			answer.Value = answer.Value .. "S"
		end
		if (inputObject.KeyCode == Enum.KeyCode.T) then
			answer.Value = answer.Value .. "T"
		end
		if (inputObject.KeyCode == Enum.KeyCode.U) then
			answer.Value = answer.Value .. "U"
		end
		if (inputObject.KeyCode == Enum.KeyCode.V) then
			answer.Value = answer.Value .. "V"
		end
		if (inputObject.KeyCode == Enum.KeyCode.W) then
			answer.Value = answer.Value .. "W"
		end
		if (inputObject.KeyCode == Enum.KeyCode.X) then
			answer.Value = answer.Value .. "X"
		end
		if (inputObject.KeyCode == Enum.KeyCode.Y) then
			answer.Value = answer.Value .. "Y"
		end
		if (inputObject.KeyCode == Enum.KeyCode.Z) then
			answer.Value = answer.Value .. "Z"
		end	
		if (inputObject.KeyCode == Enum.KeyCode.Space) then
			local substring = string.sub(answer.Value, -1)
			if answer.Value ~= "" and substring ~= " " then
				answer.Value = answer.Value .. " "
			end				
		end		
	end		
end)
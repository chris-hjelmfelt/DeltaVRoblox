local rewardModule = {}
	function rewardModule.allReward(problem, correctAnswer1, correctAnswer2, playerAnswer)
		local player = game.Players.LocalPlayer
		local rewardGold
		local rewardXP
		if problem == "math01" then		
			problem = player.PlayerGui.Math.MathGui.Problem			
			rewardGold = 2
			rewardXP = 5
			stat = 'Math'
		elseif problem == "electrical01" then	
			problem = player.PlayerGui.ElectricalGui.Problem			
			rewardGold = 2
			rewardXP = 5
			stat = 'Electrical'
		elseif problem == "chemistry01" then	
			problem = player.PlayerGui.ChemistryGui.Problem			
			rewardGold = 2
			rewardXP = 5
			stat = 'Chemistry'	
		elseif problem == "crypto01" then	
			problem = player.PlayerGui.CryptoGui.Problem			
			rewardGold = 10
			rewardXP = 15
			stat = 'Cryptography'
		elseif problem == "crypto02" then	
			problem = player.PlayerGui.CryptoGui2.Problem			
			rewardGold = 10
			rewardXP = 25
			stat = 'Cryptography'
		elseif problem == "robotica01" then		
			problem = player.PlayerGui.RoboticsGui.Problem			
			rewardGold = 10
			rewardXP = 25
			stat = 'Robotics'
		elseif problem == "physics01" then		
			problem = player.PlayerGui.PhysicsGui.Problem			
			rewardGold = 10
			rewardXP = 25
			stat = 'Physics'
		end
			
		if correctAnswer1 == playerAnswer or correctAnswer2 == playerAnswer then
			-- Show and add rewards
			problem.Reward.Coins.TextLabel.Text = "+" .. rewardGold
			problem.Reward.XP.TextLabel.Text = "+" .. rewardXP
			problem:FindFirstChild("Reward").Visible = true
			problem:FindFirstChild("CoinsPay"):Play()
			player.leaderstatsX.Gold.Value = player.leaderstatsX.Gold.Value + rewardGold
			player.leaderstatsX.XP.Value = player.leaderstatsX.XP.Value + rewardXP
			-- Give xp to correct skill
			player.leaderstatsX:FindFirstChild(stat).Value = player.leaderstatsX:FindFirstChild(stat).Value + rewardXP
			-- Hide reward Gui
			wait(2)
			problem:FindFirstChild("Reward").Visible = false	
		else	
			-- Indicate wrong answer
			problem:WaitForChild("Wrong").Visible = true
			problem:FindFirstChild("WrongAnswer"):Play()
			-- Hide Gui
			wait(1)
			problem:FindFirstChild("Wrong").Visible = false
		end	
	end	
		
		
	function rewardModule.MathFixed()
		local player = game.Players.LocalPlayer
		local problem = player.PlayerGui.Math.FixObject.Reward			
		local rewardGold = 10
		local rewardXP = 20
		stat = 'Math'
		-- Show and add rewards
		problem.Coins.TextLabel.Text = "+" .. rewardGold
		problem.XP.TextLabel.Text = "+" .. rewardXP
		problem.Visible = true
		problem:FindFirstChild("CoinsPay"):Play()
		--player.leaderstats.Gold.Value = player.leaderstats.Gold.Value + rewardGold
		--player.leaderstats.XP.Value = player.leaderstats.XP.Value + rewardXP
		--player.leaderstats:FindFirstChild(stat).Value = player.leaderstats:FindFirstChild(stat).Value + rewardXP
		-- Give player Gold and XP
		game.ReplicatedStorage:WaitForChild('GiveRewards'):FireServer('Math', rewardGold, rewardXP)  -- Goes to ChangeStats
		
		-- Hide reward Gui
		wait(1.5)
		problem.Visible = false	
		player.PlayerGui.Math.FixObject.DoAnother.Visible = true		
	end
	
	function rewardModule.ElectricalFixed()
		local player = game.Players.LocalPlayer
		local problem = player.PlayerGui.ElectricalFixObject.Reward			
		local rewardGold = 10
		local rewardXP = 20
		stat = 'Electrical'
		-- Show and add rewards
		problem.Coins.TextLabel.Text = "+" .. rewardGold
		problem.XP.TextLabel.Text = "+" .. rewardXP
		problem.Visible = true
		problem:FindFirstChild("CoinsPay"):Play()
		-- Give player Gold and XP
		game.ReplicatedStorage:WaitForChild('GiveRewards'):FireServer('Electrical', rewardGold, rewardXP)  -- Goes to ChangeStats
		-- Hide reward Gui
		wait(1.5)
		problem.Visible = false	
		player.PlayerGui.ElectricalFixObject.DoAnother.Visible = true		
	end
		
return rewardModule

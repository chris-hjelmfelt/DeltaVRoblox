local module = {}

	function module.fruitPick(Player, this)		
		local isClickable = true
		local myName = "Fruit"
		local myMax = 20
		local moneyValue = 1		
		local fruitGui = Player.PlayerGui.GetFruit
		local respawntime = 35
		
		if isClickable == true then	
			if Player.Backpack:FindFirstChild("Bin") or Player.Backpack:FindFirstChild(myName) then
				local thisOBJ = Player.Backpack:FindFirstChild(myName)
				
				if thisOBJ then
					if thisOBJ.Count.Value >= myMax then
						print("You have too many.")
						fruitGui.FullBasket.Visible = true
						wait(2)
						fruitGui.FullBasket.Visible = false
						return
					else
						thisOBJ.Count.Value = thisOBJ.Count.Value + 1
						fruitGui.FruitCount.Count.Text = thisOBJ.Count.Value.."/20"
						fruitGui.FruitCount.Visible = true
					end		
				else
					thisOBJ = Instance.new("Tool",Player.Backpack)
					thisOBJ.Name = myName
					thisOBJ.TextureId = "rbxassetid://1898791767"
					Player.Backpack:FindFirstChild("Bin"):Destroy()
					local count = Instance.new("IntValue", thisOBJ)
					local money = Instance.new("IntValue", thisOBJ)
					count.Name = "Count"
					count.Value = 1
					money.Name = "Money"
					money.Value = moneyValue
					fruitGui.FruitCount.Count.Text = thisOBJ.Count.Value.."/20"
					fruitGui.FruitCount.Visible = true
				end
				
				isClickable = false
				this.Transparency = 1.0
				this.ClickDetector.MaxActivationDistance = 0
				
				wait(respawntime)
				
				this.Transparency = 0.0		
				this.ClickDetector.MaxActivationDistance = 12
				isClickable = true	
				
			else
				fruitGui.GetBasket.Visible = true
				wait(2)
				fruitGui.GetBasket.Visible = false
			end
		end	
	end
	
	function module.sellItems(Player, canSell)
		if canSell == true then
			canSell = false
			local plrGold = Player.leaderstatsX.Gold
			local plrXP = Player.leaderstatsX.XP
			local plrLabor = Player.leaderstatsX.Labor
			local fruitGui = Player.PlayerGui.GetFruit
			
			if Player.Backpack:FindFirstChild("Fruit") then
				local itemValue = Player.Backpack:FindFirstChild("Fruit").Money.Value
				local itemCount = Player.Backpack:FindFirstChild("Fruit").Count.Value
				local rewardGold = itemValue * math.floor(itemCount/2)
				local rewardXP = itemCount
				
				plrGold.Value = plrGold.Value + rewardGold
				plrXP.Value = plrXP.Value + rewardXP
				plrLabor.Value = plrLabor.Value + rewardXP
				Player.Backpack:FindFirstChild("Fruit"):Destroy()
				
				fruitGui.FruitCount.Count.Text = "0/20"
				fruitGui.FruitCount.Visible = false
				fruitGui.Reward.Coins.TextLabel.Text = "+" .. rewardGold
				fruitGui.Reward.XP.TextLabel.Text = "+" .. rewardXP
				fruitGui:FindFirstChild("Reward").Visible = true
				fruitGui:FindFirstChild("CoinsPay"):Play()
				wait(2)
				fruitGui:FindFirstChild("Reward").Visible = false			
			end		
			canSell = true
		else
			return
		end		
	end
	
return module

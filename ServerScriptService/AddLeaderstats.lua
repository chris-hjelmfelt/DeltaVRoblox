game.Players.PlayerAdded:connect(function(player)
	local leaderstats = Instance.new("Model")
    leaderstats.Name = "leaderstatsX"
    leaderstats.Parent = player
 
    local money = Instance.new("IntValue") -- create a new IntValue
    money.Name = "Gold" -- name you want the leader-stat to be when it shows up in-game.
    money.Value = 0 --  value of money the new player starts out with. To change this, you can add some more code (shown later)
    money.Parent = leaderstats -- set the money object as a child of the leaderstats object.

	local xp = Instance.new("IntValue") 
    xp.Name = "XP" 
    xp.Value = 0 
    xp.Parent = leaderstats 

	local labor = Instance.new("IntValue")
	labor.Name = "Labor"
	labor.Value = 0
	labor.Parent = leaderstats 
	
	local mathx = Instance.new("IntValue")
	mathx.Name = "Math"
	mathx.Value = 0
	mathx.Parent = leaderstats 
	
	local elect = Instance.new("IntValue")
	elect.Name = "Electrical"
	elect.Value = 0
	elect.Parent = leaderstats 
	
	local chem = Instance.new("IntValue")
	chem.Name = "Chemistry"
	chem.Value = 0
	chem.Parent = leaderstats 
	
	local robot = Instance.new("IntValue")
	robot.Name = "Robotics"
	robot.Value = 0
	robot.Parent = leaderstats 
	
	local crypto = Instance.new("IntValue")
	crypto.Name = "Cryptography"
	crypto.Value = 0
	crypto.Parent = leaderstats 
	
	local phys = Instance.new("IntValue")
	phys.Name = "Physics"
	phys.Value = 0
	phys.Parent = leaderstats 
	
 end)


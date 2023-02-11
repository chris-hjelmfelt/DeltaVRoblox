Ari = game.Workspace:WaitForChild('Info Desk'):FindFirstChild('Ari')
Abbi = game.Workspace:WaitForChild('Science Area'):FindFirstChild('Abbi')
Andre = game.Workspace:WaitForChild('Science Area'):FindFirstChild('Andre')
Jack = game.Workspace:WaitForChild('Science Area'):FindFirstChild('Jack')
Marie = game.Workspace:WaitForChild('Science Area'):FindFirstChild('Marie')
Nailah = game.Workspace:WaitForChild('Science Area'):FindFirstChild('Nailah')
Sanjay = game.Workspace:WaitForChild('Science Area'):FindFirstChild('Sanjay')
William = game.Workspace:WaitForChild('Science Area'):FindFirstChild('William')

function talkAri(player)
	print('Hello from Ari')
end

Ari.Head.ClickDetector.MouseClick:Connect(talkAri)
Ari.Torso.ClickDetector.MouseClick:Connect(talkAri)
Ari["Right Arm"].ClickDetector.MouseClick:Connect(talkAri)
Ari["Left Arm"].ClickDetector.MouseClick:Connect(talkAri)


function talkAbbi(player)
	print('Hello from Abbi')
end

Abbi.Head.ClickDetector.MouseClick:Connect(talkAbbi)
Abbi.Torso.ClickDetector.MouseClick:Connect(talkAbbi)
Abbi["Right Arm"].ClickDetector.MouseClick:Connect(talkAbbi)
Abbi["Left Arm"].ClickDetector.MouseClick:Connect(talkAbbi)
Abbi.Hat.ClickDetector.MouseClick:Connect(talkAbbi)


function talkAndre(player)
	print('Hello from Andre')
end

Andre.Head.ClickDetector.MouseClick:Connect(talkAndre)
Andre.Torso.ClickDetector.MouseClick:Connect(talkAndre)
Andre["Right Arm"].ClickDetector.MouseClick:Connect(talkAndre)
Andre["Left Arm"].ClickDetector.MouseClick:Connect(talkAndre)
Andre["Memorial Day 2010"].ClickDetector.MouseClick:Connect(talkAndre)


function talkJack(player)
	print('Hello from Jack')
end

Jack.Head.ClickDetector.MouseClick:Connect(talkJack)
Jack.Torso.ClickDetector.MouseClick:Connect(talkJack)
Jack["Right Arm"].ClickDetector.MouseClick:Connect(talkJack)
Jack["Left Arm"].ClickDetector.MouseClick:Connect(talkJack)



function talkMarie(player)
	print('Hello from Marie')
end

Marie.Head.ClickDetector.MouseClick:Connect(talkMarie)
Marie.Torso.ClickDetector.MouseClick:Connect(talkMarie)
Marie["Right Arm"].ClickDetector.MouseClick:Connect(talkMarie)
Marie["Left Arm"].ClickDetector.MouseClick:Connect(talkMarie)
Marie.RedAnimeGirlHair.ClickDetector.MouseClick:Connect(talkMarie)


function talkNailah(player)
	player.PlayerGui.TalkNPCs.NailahGUI.Enabled = true
end

Nailah.Head.ClickDetector.MouseClick:Connect(talkNailah)
Nailah.Torso.ClickDetector.MouseClick:Connect(talkNailah)
Nailah["Right Arm"].ClickDetector.MouseClick:Connect(talkNailah)
Nailah["Left Arm"].ClickDetector.MouseClick:Connect(talkNailah)
Nailah.Hat.ClickDetector.MouseClick:Connect(talkNailah)


function talkSanjay(player)
	print('Hello from Sanjay')
end

Sanjay.Head.ClickDetector.MouseClick:Connect(talkSanjay)
Sanjay.Torso.ClickDetector.MouseClick:Connect(talkSanjay)
Sanjay["Right Arm"].ClickDetector.MouseClick:Connect(talkSanjay)
Sanjay["Left Arm"].ClickDetector.MouseClick:Connect(talkSanjay)
Sanjay.AnimeBoyHair2.ClickDetector.MouseClick:Connect(talkSanjay)


function talkWilliam(player)
	print('Hello from William')
end

William.Head.ClickDetector.MouseClick:Connect(talkWilliam)
William.Torso.ClickDetector.MouseClick:Connect(talkWilliam)
William["Right Arm"].ClickDetector.MouseClick:Connect(talkWilliam)
William["Left Arm"].ClickDetector.MouseClick:Connect(talkWilliam)
William.ColorfulStrawHat.ClickDetector.MouseClick:Connect(talkWilliam)


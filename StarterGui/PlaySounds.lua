Player = game:GetService("Players").LocalPlayer

-- Door Close
game.ReplicatedStorage.DoorClose.OnClientEvent:Connect(function()
	Player:WaitForChild('PlayerGui'):WaitForChild('Sounds').DoorClose:Play()
end)


-- Maries Radio
workspace:FindFirstChild('Science Area'):FindFirstChild('Maries Table').Radio.Button.ClickDetector.MouseClick:Connect(function(Player)
	local song = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Sounds'):FindFirstChild('Fredji Happy life')
	if song.Playing == true then
		song.Playing = false
	else	
		song:Play()
	end
end)



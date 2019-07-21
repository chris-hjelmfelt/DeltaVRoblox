--[[
local minutesAfterMidnight = 0 
while true do 
	game.Lighting:SetMinutesAfterMidnight(minutesAfterMidnight) 
	minutesAfterMidnight = minutesAfterMidnight + 1 
	wait(1) 
end
]]
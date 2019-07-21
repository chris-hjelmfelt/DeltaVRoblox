local Players = game:GetService("Players")

local myModule = {}
	function myModule.insideHouseCheck(player, mtarget)
	local inside = true
	local topOfItem = mtarget.Position.Y + (mtarget.Size.Y /2 )
	local houseType = Players:FindFirstChild(player.Name).HouseInt.Value 
	local housePos = houseType.Primary.Position 
	local houseSize = houseType.Primary.Size
	if topOfItem > 24.5 or topOfItem < 2 then	-- furniture is above or below the house
		inside = false
	elseif mtarget.Position.X > housePos.X + houseSize.X/2 or mtarget.Position.X < housePos.X - houseSize.X/2 then  -- outside in the X direction
		inside = false
	elseif mtarget.Position.Z > housePos.Z + houseSize.Z/2 or mtarget.Position.Z < housePos.Z - houseSize.Z/2 then  -- outside in the Z direction
		inside = false
	end	
	return inside
end
return myModule

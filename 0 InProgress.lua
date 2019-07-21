workspace:WaitForChild('TestingValue',100).Value = false
-----------------------------------------------------
-- TO DO + Notes     (Troubleshooting at the bottom)	
-----------------------------------------------------
-- Absolute minimum:  House testing - especially that furniture can't get lost


-- Current
------------
-- So far save on exit seems to still have problems
	-- furniturestats should make sure they don't lose anything, just last minute placement and color changes
	-- make sure all items end up in storage and money, skills etc are saving on exit
-- Test fill storage with remaining furniture code
-- Test exterior teleport locations
-- Test all house functions and furniture 
-- Check for correct changes in money and whether it saves correctly 


-- Main Testing Bugs
---------------------
-- Furniture torage seems to be showing weird item counts and losing stuff
-- Need a debounce on furniture save


--Fix after launch:
	-- furniture orientations are fucked up on respawn
	-- clicking edit button while item is selected puts it in storage even if it's in a good location
	-- hard to place things on table because the underneath is open
	-- Zstack issue on electrical (broken over problem) 
	-- Book pages get messed up when you hit back button or open them more than once



--------------------------------------
-- **Stuff to check before updates 
--------------------------------------
-- Remove test gold
-- Toggle Password Gui
-- Toggle FS&S
-- Toggle Housestats and Leaderstats
-- Guis added to ED_MS closeAllGuis  
-- New scripts and functionality added to 0HowThingsWork
-- Password Gui is off and no blur, etc.
-- Correct starting furniture and gold


--------------------------
-- TO DO --
--------------------------

-- Housing 
-------------
-- **Items are lost if teleporting or clicking a gui or anything during move when item is outside house
	-- need to handle onPlayerLeaving, teleport by button or door
		-- place deselectWhileOutside, etc in a ModuleScript
		-- use selected2 variable to keep track of mtarget (may not need the selected variable separate if you use this)
			-- make nil when unselecting
-- **Test all house saves in actual game (furniture positions & storage, house lock, house colors, different models)
-- **Improve save furniture settings 		
	-- USE a leaderstats like thing to keep track of what the player owns so if furniture spawn fails they won't lose things (add and subtract on sale, etc.)
	-- I'm not sure furniture is saving on PlayerRemoving  (FS&S) - the leaderstats like thing would solve this I think
-- Max items owned  - you can put up to 200,000 characters in a string. Furniture in the house takes slightly less than 250 characters each. 500 furniture items should be well within the limit
	-- Add a way to delete items
-- Furniture store 	
	-- add any more items you want to sell, there are some decorations in build (make sure they are available in Server Storage)
	-- make images of any more furniture you want (needed for both store and storage)
	-- cleanup store Gui (last row - small and large cube?)
-- Can't change rug colors if they aren't models 
	-- I think I may have solved this when I changed from item.Position to item.Vector3
	-- but they must be unions or parts to allow using collision groups (otherwise you won't be able to place them in small rooms)	
	-- could I code the collision group funcitonality by brute force?	
-- Check if all setup collision group stuff is working (do we need any in a onPlayerAdded function?)
	-- check list of furniture against it on save and if they don't match use it instead
	-- send yourself an error report by saving something in the Jaylah_Everstar character that can be put into a error messages gui
	-- append strings that contain as much detail as possible
	-- you could do some statistics this way as well
-- Remove poster and light or fix code for moving them		
	-- doesn't correctly find walls right now  (see the plan at bottom of this page)
	-- Paint walls & floor
-- Rug movement is really bad
-- Move edit house buttons to a different place or move edit menus
-- Furniture movement is really rough -- Can you hand code a collision group things that works with models 
	-- floor lamps are particularly bad
	-- colliding with player is one of the main issues
-- Furniture wood (and other) colors don't match (and aren't available on customize menu)
-- If you click outside edit button while colors are showing they should disappear
-- When entering and exiting house run closeAllMenus()
-- TVs need "stations" even if they are static
-- Sometimes i need to click a house door twice (both int and ext) to go into house (but the edit menu changes to inside)
-- Furniture in front of Door
	-- By having the door cut out and set back slightly it appears that people will spawn into that small space rather than on the roof
	-- Perhaps make that space a bit deeper just to be sure
-- Sell items in storage
-- If there is nowhere to put furniture in the house there isn't a way to deselect without leaving the house (see MoveObject deselectWhileOutside())
-- Test and readd house lock

	
-- Jobs --
----------
-- Books break on last page
-- Improve chemistry book
-- Add the next level of math problems 
   -- counting, other addition and subtraction
   -- Finish Math Dialog
   -- Connect in MathMenu 
-- Add a menu for math problems (prefered problem types, includeXP needed to unlock next, lesson for how to do them)
-- Add more components to electrical book and problems
-- Text input check for a single space and no spaces before or after
-- Need a debounce on electrical when wrong
-- add a check for phone users and give them a textbox instead of listening for keyboard input


-- Quests --
------------
-- Give a reason (story) for each thing that is being built
-- Pick people to talk to and problems to solve
-- Create dialog for each person
-- Keep track of player progress



-- Other Priority --
--------------------
-- **phone users can't do some stuff
	-- use door teleport (it changes the edit gui though)
	-- close some menus
	-- enter input on science guis (check for phone user and use a textbox object instead of listening for keypresses)
-- Ari's dialog at Info desk needs way more info (change it to a gui)
-- Welcome message 
-- Player list (shows too much stuff and only shows it to the local player) - make custom list with minimal info (total XP?)
-- Bug: You can click on Andre's dialog through the FixObject Gui  (tried Active = true but that's just for 3D elements like parts) - I probably ultimately want to make most dialogs into actual guis of some sort)
-- More music and sound effects
-- Create an offical logo for the game (could be the name in a special font and/or a design that represents the colony
-- Update wiki
-- Script that checks for missing load player data at start (check against some other values? I probably wouldn't turn off all of them during testing, just one or two)
	-- I'm afraid of doing something during testing that I then save to the real game and it removes all of the progress the players have made, I need a double check against it
-- decorations in neighborhood - bamboo, bonzai and other small plants from around the world
		
-- Low Priority
------------------
-- Space shuttle 
-- Allow players to choose which house model they wish to use if they own multiple and mix and match interior and exterior	
-- Open furniture store from house
-- Rovers - density block to lower rear of rover and check density of rover and humanoid in jump assist script	
-- Look at JSONWithUserdata modulescript (see mymodels in toolbox) and improve your usage of modulescripts
-- Blender learn to make meshes for toys, computer cables, etc.
-- Reread https://scriptinghelpers.org/questions/65889/how-does-hacking-work-on-roblox-so-i-can-prevent-itsolved
-- Select item on spawn from storage	
-- Close menus when people leave furniture and housing stores



-------------------------	
-- Troubleshooting 
-------------------------
-- Why isn't some block of code working at all?!? 
	-- make sure it isn't after a while loop. If the while loop always runs, nothing after it will ever run
-- When trying to access some GUI a script fails at a certain point without error (ie customizeInt = Players:FindFirstChild(Player.Name):WaitForChild('PlayerGui',100):WaitForChild('Customize2'))
	-- You can't access GUIs from server scripts
-- Gui layout order seems to work for some things and not others. I don't understand why the books work but not other things
-- Z-stack works on items within the same Frame and (sometimes?) the same Screen Gui  
	-- higher numbers get displayed on top of lower numbers
-- Error "attempt to concatenate global 'something' (a userdata value)" 
	-- means you are trying to put something that is not a string into a string. Use tostring() to fix it.
-- If a model is moving/spawning not quite where you expect 
	-- make sure Primary part is set
-- RemoteEvent isn't working 
	-- FireServer() will automatically pass the player so don't make it an argument  
	-- OnServerEvent() the first argument will always be the player so make sure you put OnServerEvent(player, anythingelse)
	-- FireClient() and OnClientEvent() work a bit differently I think
-- Parameter 1 must be BasePart 
	-- If this is in a loop you are probably hitting on an object like a IntValue or ClickDetector or something
-- Script fails but doesn't give an error at loading a gui
	-- is it a server script? move the gui stuff to a local script
-- Error "attempt to call a string value" on a remote function call
	-- findFurnitureRequest.OnClientInvoke = onFindFurnitureRequested() returns the function itself
	-- findFurnitureRequest.OnClientInvoke = onFindFurnitureRequested  returns the value returned from the function  (no parenthasis)
-- Scrolling Frame isn't showing everything
	-- in scrolling frame properties change canvas size (0,0)(2,0) to (0,0)(5,0) where 5 is whatever size you need (make it larger for something unknown)	
-- Can't move rugs
	-- If they are too big they will stuck in the wall and not move (make them smaller)		
-- Player doesn't sit where chair is
	-- local vs server script will make it look like the furniture has moved when it actually hasn't
-- Button1Down:connect() doesn't seem to work right
	-- make sure it isn't inside another function that can be called more than once. It may be running multiple instances which can oconflict with each other 
-- Color3 isn't working
	-- make sure you are using correct number system 0-1 vs 0-255
	-- Color3 = Color3.Value  (can't assign to Value but need to get from Value)
	-- use Color3.new() if a value is just numbers but not if already a Color3 (that will be nil)
-- Can't modify or select an object (ie change text on a Gui item)
	-- Make sure there isn't a second item with the same name (ie a text label and a text button with the same name)
	
------------------	
-- Poster plan
------------------
-- In general it might help to have a list of wall locations for each interior house type
	-- We could have a MS function that could be called with the name of the interior and it would 
	-- pass back an array with the info in it 
	-- There is a findWall() function in moveobject, I don't know if it works 
-- We need a way to tell front and back of the poster, probably we need to create them very uniformly so x and z is always the same
-- Posters should probably rotate automatically to match the wall and not be able to be placed away from one
-- I found the following code at  https://scriptinghelpers.org/questions/37857/how-do-i-detect-when-two-parts-are-colliding
--[[
	part.Touched:connect(function(hit)
		if hit == otherPart then
	        colliding = true
	    end
	end)
	 
	part.TouchEnded:connect(function(hit)
	    if hit == otherPart then
	        colliding = false
	    end
	end)
--]]


--------------------------
-- Plan for Saving Info
--------------------------
-- 1. House and settings 
	-- lock setting
	-- house level owned
	-- house being used (interior and exterior)
	-- exterior colors (6+)
	
	
-- 2. Furniture   -- use JSON	
	-- furniture in storage
	-- furniture in house 
		-- name, position, orientation, colors
		
-- Put this somewhere else:
	-- special items unlocked
	-- extra slots
	
	
-- 3. Skill progession    -- use JSON
	-- Level(s) unlocked for each skill (some such as math may progess as a tree) 
		-- need a new skill welcome message for each level unlock (with link to section in book)
		-- Have a version number as the first item in JSON so you can add to it over time and tell which the player is using
	-- Each skill should have a separate (or multiple) JSON save variables



-- JSON for house
--[[  -- I realized I don't need JSON for house info - might still need it for skills	
local HttpService = game:GetService("HttpService")
local houseToJSON = {
	version = 1;
	owned = 2;
	usedInt = 2;
	usedExt = 2;
	lock = "locked";
	colors = {  -- container, trim, door trim, door, extras
		one = "Lily white";
		two = "Lily white";
		three = "Lily white";
		four = "Lily white";
		five = "Lily white";
		six = "Lily white";
		seven = "Lily white";
		eight = "Lily white";
	};
	extra = 0;
}
local json = HttpService:JSONEncode(characterStats)
print(json)
]]


--[[ Accessing things in the JSON array
test = '[{"key1":"1","key2":"3","key3":"0"}]' -- with brackets
test = HttpService:JSONDecode(test)
print("Test1: Key1 is " .. test[1]["key1"])
test2 = '{"key1":"4","key2":"5","key3":"6"}' -- without brackets
test2 = HttpService:JSONDecode(test2)
print("Test2: Key1 is " .. test2["key1"])

-- more advanced:
jsonData = '{"F1":[{"name":"Standard Bed", "Position":[{"X":100096, "Y":12, "Z":96}], "Rotation":[{"X":0, "Y":0, "Z":0}], "color1":[{"R":0, "G":0, "B":255}], "color2":[{"R":27, "G":42, "B":53}], "color3":[{"R":159, "G":161, "B":172}] }], "S1":[{"name":"Fruit"}], "S2":[{"name":"Wooden Chair"}], "S5":[{"name":"Cube"}], "S7":[{"name":"White Rug"}] }'
print("Bed Position = " .. deco["F1"][1]["Position"][1]["X"] .. "," .. deco["F1"][1]["Position"][1]["Y"] .. "," .. deco["F1"][1]["Position"][1]["Z"])
if deco["S2"][1]["Position"]then
	print("In House")
else
	print(deco["S2"][1]["name"] .. " is in Storage")
end	
]]



-----------------
-- Old Notes
----------------
-- Things are spawning higher and higher even when nothings in the way - See EditHouse script SpawnItem 
	-- I changed from newModel:MoveTo(Vector3.new(posX,posY,posZ)) to newModel:SetPrimaryPartCFrame(CFrame.new(posX,posY,posZ))
	-- it allows things to spawn inside of other things but it should stop the problems
-- cubes are still spawning higher and higher
	-- I changed from newModel.Position = Vector3.new(posX,posY,posZ) to newModel.CFrame = CFrame.new(posX,posY,posZ)
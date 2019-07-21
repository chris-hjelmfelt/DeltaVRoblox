
script.Parent.MouseButton1Click:connect(function()
	local Player = game.Players.LocalPlayer
	local Gui = 'ChemistryBook'
	local myModule = require(workspace.Scripts.NewProblems_ModuleScript)
	myModule.closeBookGui(Player, Gui)
end)

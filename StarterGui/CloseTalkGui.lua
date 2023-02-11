script.Parent.MouseButton1Click:connect(function()
	local mainGui = script.Parent.Parent.Parent
	local children = mainGui:GetChildren()
	for k = 2, #children do
		children[k].Visible = false
	end	
	mainGui.Hello.Visible = true	
	mainGui.Close.Visible = true	
	mainGui.Enabled = false
end)
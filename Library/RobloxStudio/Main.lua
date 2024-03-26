Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
PlayerGui = LocalPlayer.PlayerGui
PlayerScripts = LocalPlayer.PlayerScripts

do
	Library = {}

	newGui = Instance.new("ScreenGui", PlayerGui)
	newGui.ResetOnSpawn = false
	newGui.Enabled = true

	Library.makeWindow = function(name, font, position)
		local frame = Instance.new("Frame", newGui)
		frame.Position = position
		frame.Size = UDim2.fromScale(0.3, 0.7)
		frame.BackgroundTransparency = .25
		frame.BorderSizePixel = 0
		frame.Name = name
		frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		frame.Active = true
		frame.Draggable = true

		local newframe = Instance.new("TextLabel", frame)
		newframe.Position = UDim2.fromScale(0, -.03)
		newframe.Size = UDim2.fromScale(1, .03)
		newframe.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
		newframe.BorderSizePixel = 0
		newframe.Text = "   " .. name
		newframe.TextXAlignment = Enum.TextXAlignment.Left
		newframe.Font = font
		newframe.TextSize = 20
		newframe.BackgroundTransparency = .15
		newframe.TextColor3 = Color3.fromRGB(255,255,255)

		local tabFrame = Instance.new("Frame", frame)
		tabFrame.Position = UDim2.fromScale(0,0)
		tabFrame.Size = UDim2.fromScale(1, 1)
		tabFrame.BackgroundTransparency = 1
		tabFrame.Name = "tabFrame"

		local sort = Instance.new("UIListLayout", tabFrame)
		sort.SortOrder = Enum.SortOrder.LayoutOrder

		local libs = {}

		libs.MakeTab = function(name2, font2)
			local newframe = Instance.new("TextButton", tabFrame)
			newframe.Position = UDim2.fromScale(0, 0)
			newframe.Size = UDim2.fromScale(1, .04)
			newframe.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
			newframe.BorderSizePixel = 0
			newframe.Text = "   " .. name2
			newframe.TextXAlignment = Enum.TextXAlignment.Left
			newframe.Font = font2
			newframe.TextSize = 20
			newframe.BackgroundTransparency = .15
			newframe.TextColor3 = Color3.fromRGB(255,255,255)
			newframe.AutoButtonColor = false
			newframe.Name = name2

			local modulesFrame = Instance.new("Frame", newframe)
			modulesFrame.Position = UDim2.fromScale(0,1)
			modulesFrame.Size = UDim2.fromScale(1, 5)
			modulesFrame.BackgroundTransparency = 1
			modulesFrame.Visible = false

			local sortMods = Instance.new("UIListLayout", modulesFrame)
			sortMods.SortOrder = Enum.SortOrder.LayoutOrder

			newframe.MouseButton1Down:Connect(function()
				for i,v in pairs(tabFrame:GetChildren()) do
					if v.Name == name2 then continue end
					if v:IsA("UIListLayout") then continue end
					v.Visible = not v.Visible
				end
				modulesFrame.Visible = not modulesFrame.Visible
			end)

			newframe.MouseButton2Down:Connect(function()
				for i,v in pairs(tabFrame:GetChildren()) do
					if v.Name == name2 then continue end
					if v:IsA("UIListLayout") then continue end
					v.Visible = not v.Visible
				end
				modulesFrame.Visible = not modulesFrame.Visible
			end)

			local library = {}

			library.makeButton = function(Table)
				local enabled = false
				local tab = {}

				local ButtonFrame = Instance.new("TextButton", modulesFrame)
				local Dropdown = Instance.new("Frame", ButtonFrame)

				tab.ToggleButton = function(v)
					if v then
						enabled = v
					else
						enabled = not enabled
					end
					task.spawn(function()
						Table["Function"](enabled)
					end)
					ButtonFrame.BackgroundColor3 = (ButtonFrame.BackgroundColor3 == Color3.fromRGB(50, 100, 255) and Color3.fromRGB(181, 198, 255) or Color3.fromRGB(50, 100, 255))
				end

				ButtonFrame.Position = UDim2.fromScale(0,0)
				ButtonFrame.Size = UDim2.fromScale(1, 0.15)
				ButtonFrame.BorderSizePixel = 0
				ButtonFrame.Name = Table.Name
				ButtonFrame.Text = Table.Name
				ButtonFrame.BackgroundTransparency = .25
				ButtonFrame.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
				ButtonFrame.TextColor3 = Color3.fromRGB(255,255,255)
				ButtonFrame.AutoButtonColor = false

				Dropdown.Position = UDim2.fromScale(0, 1)
				Dropdown.Size = UDim2.fromScale(1, 5)
				Dropdown.BackgroundTransparency = 1
				Dropdown.Visible = false

				ButtonFrame.MouseButton1Down:Connect(function()
					tab.ToggleButton()
				end)

				ButtonFrame.MouseButton2Down:Connect(function()
					for i,v in pairs(modulesFrame:GetChildren()) do
						if v.Name == Table.Name then continue end
						if v:IsA("UIListLayout") then continue end
						v.Visible = not v.Visible
					end
					Dropdown.Visible = not Dropdown.Visible
				end)

				game.UserInputService.InputBegan:Connect(function(k ,g)
					if g then return end
					if k.KeyCode == nil then return end
					if k.KeyCode == Table.Keybind then
						tab.ToggleButton()
					end
				end)

				tab.MiniToggle = function(Table2)
					local Enabled = false
					local tab2 = {}

					local ButtonFrame2 = Instance.new("TextButton", Dropdown)
					ButtonFrame2.Position = UDim2.fromScale(0,0)
					ButtonFrame2.Size = UDim2.fromScale(1, 0.15)
					ButtonFrame2.BorderSizePixel = 0
					ButtonFrame2.Name = Table2.Name
					ButtonFrame2.Text = Table2.Name
					ButtonFrame2.BackgroundTransparency = .25
					ButtonFrame2.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
					ButtonFrame2.TextColor3 = Color3.fromRGB(255,255,255)
					ButtonFrame2.AutoButtonColor = false

					ButtonFrame2.MouseButton1Down:Connect(function()
						tab2.ToggleButton()
					end)

					tab2.ToggleButton = function(v)
						if v then
							Enabled = v
						else
							Enabled = not Enabled
						end
						task.spawn(function()
							Table2["Function"](Enabled)
						end)
						ButtonFrame2.BackgroundColor3 = (ButtonFrame2.BackgroundColor3 == Color3.fromRGB(50, 100, 255) and Color3.fromRGB(181, 198, 255) or Color3.fromRGB(50, 100, 255))
					end

					return tab2
				end

				tab.Picker = function(Table2)
					local val = Table2.Default or Table2.Options[1]
					local index = 1

					local ButtonFrame2 = Instance.new("TextButton", Dropdown)
					ButtonFrame2.Position = UDim2.fromScale(0,0)
					ButtonFrame2.Size = UDim2.fromScale(1, 0.15)
					ButtonFrame2.BorderSizePixel = 0
					ButtonFrame2.Name = Table2.Name .. " : "
					ButtonFrame2.Text = Table2.Name
					ButtonFrame2.BackgroundTransparency = .25
					ButtonFrame2.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
					ButtonFrame2.TextColor3 = Color3.fromRGB(255,255,255)
					ButtonFrame2.AutoButtonColor = false

					local xd = {}

					xd.Option = function()
						return Table2.Options[index]
					end

					ButtonFrame2.MouseButton1Down:Connect(function()
						index += 1

						if index > #Table2.Options then
							index = 1
						end

						ButtonFrame2.Text = "  "..Table2.Name..": "..Table2.Options[index]
					end)

					return xd
				end

				return tab
			end

			return library
		end

		return libs
	end
end

return Library

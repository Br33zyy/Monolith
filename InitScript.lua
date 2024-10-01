-- Create the ScreenGui
local screenGui = Instance.new('ScreenGui')
screenGui.Name = 'Sage'
screenGui.ResetOnSpawn = false -- Prevent the GUI from disappearing on respawn
screenGui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

-- Set up the main frame (black background, rounded corners)
local mainFrame = Instance.new('Frame')
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Center the frame
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
mainFrame.BorderSizePixel = 0 -- No border
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundTransparency = 0.1
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Round the corners of the main frame
local uiCornerMain = Instance.new('UICorner')
uiCornerMain.CornerRadius = UDim.new(0, 12)
uiCornerMain.Parent = mainFrame

-- Title Label (Draggable)
local titleLabel = Instance.new('TextLabel')
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = 'Sage Executor'
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
titleLabel.BackgroundTransparency = 1 -- Transparent background
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

-- Make the main frame draggable by the title label
local dragging, dragInput, dragStart, startPos
local UIS = game:GetService("UserInputService")

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- TextBox for Script Input
local scriptBox = Instance.new('TextBox')
scriptBox.Size = UDim2.new(1, -20, 0.6, 0)
scriptBox.Position = UDim2.new(0.5, 0, 0.3, 0)
scriptBox.AnchorPoint = Vector2.new(0.5, 0)
scriptBox.Text = ''
scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
scriptBox.BackgroundTransparency = 0.3
scriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark gray background for the TextBox
scriptBox.TextXAlignment = Enum.TextXAlignment.Left
scriptBox.TextYAlignment = Enum.TextYAlignment.Top
scriptBox.MultiLine = true -- Allows for multiline scripts
scriptBox.ClearTextOnFocus = false
scriptBox.TextScaled = false
scriptBox.TextSize = 18
scriptBox.Font = Enum.Font.Code -- Code font for script input
scriptBox.Parent = mainFrame

-- Round the corners of the TextBox
local uiCornerTextBox = Instance.new('UICorner')
uiCornerTextBox.CornerRadius = UDim.new(0, 8)
uiCornerTextBox.Parent = scriptBox

-- Create the Execute button (rounded)
local executeButton = Instance.new('TextButton')
executeButton.Size = UDim2.new(0, 120, 0, 50)
executeButton.Position = UDim2.new(0.25, -60, 0.85, -25)
executeButton.Text = 'Execute'
executeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
executeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark gray button
executeButton.Parent = mainFrame

-- Round the corners of the Execute button
local uiCornerExecute = Instance.new('UICorner')
uiCornerExecute.CornerRadius = UDim.new(0, 12)
uiCornerExecute.Parent = executeButton

-- Function to handle the Execute button click
executeButton.MouseButton1Click:Connect(function()
    local scriptToExecute = scriptBox.Text
    if scriptToExecute ~= '' then
        print('Executing script...')
        -- Execute the script entered in the TextBox
        local success, errorMessage = pcall(function()
            loadstring(scriptToExecute)()
        end)

        if not success then
            warn("Error executing script: " .. errorMessage)
        end
    end
end)

-- Create the Clear button (rounded)
local clearButton = Instance.new('TextButton')
clearButton.Size = UDim2.new(0, 120, 0, 50)
clearButton.Position = UDim2.new(0.75, -60, 0.85, -25)
clearButton.Text = 'Clear'
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
clearButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark gray button
clearButton.Parent = mainFrame

-- Round the corners of the Clear button
local uiCornerClear = Instance.new('UICorner')
uiCornerClear.CornerRadius = UDim.new(0, 12)
uiCornerClear.Parent = clearButton

-- Function to handle the Clear button click
clearButton.MouseButton1Click:Connect(function()
    scriptBox.Text = ''
end)

-- Parent the ScreenGui to the player's PlayerGui to make it visible
screenGui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

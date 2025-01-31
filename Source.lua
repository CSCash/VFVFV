
-- Create the loading screen
local function createLoadingScreen(title, name, loadingText)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoadingScreen"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create background frame
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.6
    background.Parent = screenGui

    -- Create title text
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0.1, 0)
    titleLabel.Text = title or "Loading..."  -- Default to "Loading..."
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = screenGui

    -- Create name text
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 30)
    nameLabel.Position = UDim2.new(0, 0, 0.2, 0)
    nameLabel.Text = name or "VFVFV Library"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.SourceSans
    nameLabel.Parent = screenGui

    -- Create loading text (this is customizable for the user)
    local loadingTextLabel = Instance.new("TextLabel")
    loadingTextLabel.Size = UDim2.new(1, 0, 0, 50)
    loadingTextLabel.Position = UDim2.new(0, 0, 0.4, 0)
    loadingTextLabel.Text = loadingText or "Please wait..."  -- Default to "Please wait..."
    loadingTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingTextLabel.TextScaled = true
    loadingTextLabel.BackgroundTransparency = 1
    loadingTextLabel.Font = Enum.Font.SourceSans
    loadingTextLabel.Parent = screenGui

    -- Create loading bar background
    local barBackground = Instance.new("Frame")
    barBackground.Size = UDim2.new(0.8, 0, 0, 25)
    barBackground.Position = UDim2.new(0.1, 0, 0.55, 0)
    barBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    barBackground.BackgroundTransparency = 0.3
    barBackground.Parent = screenGui

    -- Create loading bar (this will be animated)
    local loadingBar = Instance.new("Frame")
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    loadingBar.BackgroundTransparency = 0
    loadingBar.Parent = barBackground

    -- Return the screenGui so we can modify it later
    return screenGui, loadingBar, loadingTextLabel
end

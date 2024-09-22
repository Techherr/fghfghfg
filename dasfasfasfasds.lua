local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local correctKey = "VACSC43FS44E"

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 15)

-- Title
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Text = "Enter Key"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 24

-- Key Input
local keyInput = Instance.new("TextBox", mainFrame)
keyInput.Size = UDim2.new(1, 0, 0.15, 0)
keyInput.Position = UDim2.new(0, 0, 0.2, 0)
keyInput.PlaceholderText = "Enter your key"
keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextColor3 = Color3.new(0, 0, 0)
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 20

-- Confirm Button
local confirmButton = Instance.new("TextButton", mainFrame)
confirmButton.Size = UDim2.new(1, 0, 0.15, 0)
confirmButton.Position = UDim2.new(0, 0, 0.35, 0)
confirmButton.Text = "Confirm Key"
confirmButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
confirmButton.TextColor3 = Color3.new(1, 1, 1)
confirmButton.Font = Enum.Font.Gotham
confirmButton.TextSize = 20
confirmButton.BorderSizePixel = 0

-- Tab System
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(1, 0, 0.65, 0)
tabFrame.Position = UDim2.new(0, 0, 0.5, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabFrame.BorderSizePixel = 0

local tabs = {}
local featuresPerTab = 8 -- For simplicity

for i = 1, 6 do
    local tabButton = Instance.new("TextButton", mainFrame)
    tabButton.Size = UDim2.new(1/6, 0, 0.1, 0)
    tabButton.Position = UDim2.new((i-1)/6, 0, 0.45, 0)
    tabButton.Text = "Tab " .. i
    tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 20
    tabButton.BorderSizePixel = 0

    tabs[i] = {button = tabButton, features = {}}
end

-- Load Features in Tabs
local function loadFeatures(tabIndex)
    for _, child in ipairs(tabFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Name ~= "UICorner" then
            child:Destroy()
        end
    end

    for j = 1, featuresPerTab do
        local featureButton = Instance.new("TextButton", tabFrame)
        featureButton.Size = UDim2.new(1, 0, 1/featuresPerTab, 0)
        featureButton.Position = UDim2.new(0, 0, (j-1)/featuresPerTab, 0)
        featureButton.Text = "Feature " .. ((tabIndex - 1) * featuresPerTab + j)
        featureButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        featureButton.TextColor3 = Color3.new(1, 1, 1)
        featureButton.Font = Enum.Font.Gotham
        featureButton.TextSize = 20
        featureButton.BorderSizePixel = 0

        featureButton.MouseButton1Click:Connect(function()
            print("Activated Feature " .. ((tabIndex - 1) * featuresPerTab + j))
            -- Add feature functionality here
        end)
        
        tabs[tabIndex].features[j] = featureButton
    end
end

-- Tab Functionality
for i, tab in ipairs(tabs) do
    tab.button.MouseButton1Click:Connect(function()
        loadFeatures(i)
    end)
end

-- Confirm Key Functionality
confirmButton.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        titleLabel.Text = "Access Granted!"
        keyInput.Visible = false
        confirmButton.Visible = false
        for _, tab in ipairs(tabs) do
            tab.button.Visible = true
        end
        loadFeatures(1)
    else
        titleLabel.Text = "Access Denied! Try Again"
        wait(2)
        titleLabel.Text = "Enter Key"
    end
end)

-- Initially Load Features for the First Tab
loadFeatures(1)

-- Make Tabs Invisible Initially
for _, tab in ipairs(tabs) do
    tab.button.Visible = false
end

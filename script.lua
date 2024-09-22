local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("RIGO HUB", "Synapse")

local Test = Window:NewTab("Test")
local TestSection = Test:NewSection("Test Section")

-- Variables to store current values
local walkSpeedValue = 16
local jumpPowerValue = 50

-- WalkSpeed Slider
TestSection:NewSlider("WalkSpeed", "Set WalkSpeed", 500, walkSpeedValue, function(s)
    walkSpeedValue = s
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- JumpPower Slider
TestSection:NewSlider("JumpPower", "Set JumpPower", 500, jumpPowerValue, function(s)
    jumpPowerValue = s
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

-- Toggle for Infinite Jump
local infiniteJumpEnabled = false
TestSection:NewToggle("Infinite Jump", "Enable/Disable Infinite Jump", function(state)
    infiniteJumpEnabled = state
    local player = game.Players.LocalPlayer
    local userInputService = game:GetService("UserInputService")

    if infiniteJumpEnabled then
        userInputService.JumpRequest:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- Button to Reset Values
TestSection:NewButton("Reset Values", "Reset WalkSpeed and JumpPower to default", function()
    walkSpeedValue = 16
    jumpPowerValue = 50
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeedValue
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPowerValue
end)

-- Display current values
local infoLabel = TestSection:NewLabel("Current WalkSpeed: " .. walkSpeedValue .. " | Current JumpPower: " .. jumpPowerValue)

-- Update the label whenever the sliders are adjusted
TestSection:NewSlider("WalkSpeed", "Set WalkSpeed", 500, walkSpeedValue, function(s)
    walkSpeedValue = s
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    infoLabel:SetText("Current WalkSpeed: " .. walkSpeedValue .. " | Current JumpPower: " .. jumpPowerValue)
end)

TestSection:NewSlider("JumpPower", "Set JumpPower", 500, jumpPowerValue, function(s)
    jumpPowerValue = s
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
    infoLabel:SetText("Current WalkSpeed: " .. walkSpeedValue .. " | Current JumpPower: " .. jumpPowerValue)
end)

-- Misc Tab
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc Features")

-- Walk on Walls Toggle
local walkOnWallsEnabled = false
MiscSection:NewToggle("Walk on Walls", "Enable/Disable walking on walls", function(state)
    walkOnWallsEnabled = state
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if walkOnWallsEnabled then
        character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        game:GetService("RunService").Heartbeat:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") then
                local pos = character.HumanoidRootPart.Position
                local direction = character.HumanoidRootPart.CFrame.LookVector
                character.HumanoidRootPart.CFrame = CFrame.new(pos + direction * 1, pos + direction * 1 + Vector3.new(0, 1, 0))
            end
        end)
    end
end)

-- Fly Feature
local flyEnabled = false
local flySpeed = 50
MiscSection:NewToggle("Fly", "Enable/Disable flying", function(state)
    flyEnabled = state
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local userInputService = game:GetService("UserInputService")
    local bodyVelocity = Instance.new("BodyVelocity")

    if flyEnabled then
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = character.HumanoidRootPart

        userInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.W then
                    bodyVelocity.Velocity = character.HumanoidRootPart.CFrame.LookVector * flySpeed
                elseif input.KeyCode == Enum.KeyCode.S then
                    bodyVelocity.Velocity = -character.HumanoidRootPart.CFrame.LookVector * flySpeed
                elseif input.KeyCode == Enum.KeyCode.Space then
                    bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
                elseif input.KeyCode == Enum.KeyCode.LeftControl then
                    bodyVelocity.Velocity = Vector3.new(0, -flySpeed, 0)
                end
            end
        end)
    else
        bodyVelocity:Destroy()
    end
end)

-- Noclip Feature
local noclipEnabled = false
MiscSection:NewToggle("Noclip", "Enable/Disable noclip", function(state)
    noclipEnabled = state
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if noclipEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

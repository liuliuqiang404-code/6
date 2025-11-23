local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "StellarLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bg.BackgroundTransparency = 1
bg.ZIndex = 0
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

local word = "LM HUB"
local letters = {}

local function tweenOutAndDestroy()
    for _, label in ipairs(letters) do
        TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 1, TextSize = 20}):Play()
    end
    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
    wait(0.6)
    screenGui:Destroy()
    blur:Destroy()
end

for i = 1, #word do
    local char = word:sub(i, i)

    local label = Instance.new("TextLabel")
    label.Text = char
    label.Font = Enum.Font.GothamBlack
    label.TextColor3 = Color3.fromRGB(255, 215, 0)  
    label.TextStrokeTransparency = 0.7
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextTransparency = 1
    label.TextScaled = false
    label.TextSize = 30
    label.Size = UDim2.new(0, 60, 0, 60)
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 65, 0.5, 0)
    label.BackgroundTransparency = 1
    label.Parent = frame

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),  
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 165, 0)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))  
    })
    gradient.Rotation = 90
    gradient.Parent = label

    local glow = Instance.new("UIStroke")
    glow.Color = Color3.fromRGB(255, 215, 0)
    glow.Thickness = 3
    glow.Transparency = 0.7
    glow.Parent = label

    local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60})
    tweenIn:Play()

    table.insert(letters, label)
    wait(0.25)
end

wait(2)
tweenOutAndDestroy()
--// 💥 RIMURU HUB
--// Simple Sound ID Library

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- SOUNDS
--==================================================

local Sounds = {
    {"Coin Parry", "81202220081219"},
    {"Coin", "136124980150792"},
    {"Naginata Hit1", "94107281648467"},
    {"Naginata Hit2", "103563218704266"},
    {"Naginata Hit3", "103563218704266"},
    {"Gun Fire", "5735280081"},
    {"Gun Hit", "3932141920"},
    {"Gun Break", "1358442317"},
    {"Dash 1", "92870369637296"},
    {"Dash 2", "133205097862880"},
    {"M1 Hit 1", "92660735965001"},
    {"M1 Hit 2", "103376351068703"},
    {"M1 Hit 3", "122604454724442"},
    {"M1 Hit 4", "108932851477523"},
    {"M1 Down", "73223862105514"},
    {"M1 Up", "124704505278190"}
}

--==================================================
-- REMOVE OLD
--==================================================

local Old = PlayerGui:FindFirstChild("RimuruHub")

if Old then
    Old:Destroy()
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "RimuruHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 52, 0, 52)
OpenButton.Position = UDim2.new(0, 20, 0.5, -26)
OpenButton.BackgroundColor3 = Color3.fromRGB(8, 22, 48)
OpenButton.BorderSizePixel = 0
OpenButton.Image = "rbxassetid://964321896585"
OpenButton.ScaleType = Enum.ScaleType.Fit
OpenButton.Parent = Gui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 13)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(55, 120, 255)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenButton

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 430, 0, 360)
Main.Position = UDim2.new(0.5, -215, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(55, 120, 255)
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--==================================================
-- DRAG
--==================================================

local Dragging = false
local DragStart
local StartPos

Main.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPos = Main.Position

    end

end)

UIS.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )

    end

end)

UIS.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end

end)

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 58)
Header.BackgroundTransparency = 1
Header.Parent = Main

-- LOGO
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 42, 0, 42)
Logo.Position = UDim2.new(0, 10, 0, 8)
Logo.BackgroundColor3 = Color3.fromRGB(8, 22, 48)
Logo.BorderSizePixel = 0
Logo.Image = "rbxassetid://964321896585"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = Header

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = Logo

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(55, 120, 255)
LogoStroke.Thickness = 1.5
LogoStroke.Parent = Logo

-- TITLE
local Title = Instance.new("TextLabel")
Title.Position = UDim2.new(0, 62, 0, 8)
Title.Size = UDim2.new(1, -105, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "Rimuru Hub"
Title.TextColor3 = Color3.fromRGB(240, 243, 250)
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Position = UDim2.new(0, 63, 0, 32)
SubTitle.Size = UDim2.new(1, -75, 0, 18)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Sound IDs"
SubTitle.TextColor3 = Color3.fromRGB(130, 140, 160)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- CLOSE
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -38, 0, 14)
Close.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
Close.BorderSizePixel = 0
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(230, 230, 235)
Close.TextSize = 12
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = Close

--==================================================
-- SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Position = UDim2.new(0, 10, 0, 65)
Scroll.Size = UDim2.new(1, -20, 1, -75)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(55, 120, 255)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.Parent = Main

local Padding = Instance.new("UIPadding")
Padding.PaddingBottom = UDim.new(0, 5)
Padding.Parent = Scroll

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

--==================================================
-- COPY
--==================================================

local function Copy(ID)

    if setclipboard then
        pcall(function()
            setclipboard(ID)
        end)
        return true
    end

    if toclipboard then
        pcall(function()
            toclipboard(ID)
        end)
        return true
    end

    return false
end

--==================================================
-- SOUND ITEMS
--==================================================

for Index, Sound in ipairs(Sounds) do

    local Name = Sound[1]
    local ID = Sound[2]

    local Item = Instance.new("Frame")
    Item.Size = UDim2.new(1, -5, 0, 48)
    Item.BackgroundColor3 = Color3.fromRGB(24, 28, 40)
    Item.BorderSizePixel = 0
    Item.LayoutOrder = Index
    Item.Parent = Scroll

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Item

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Position = UDim2.new(0, 12, 0, 5)
    NameLabel.Size = UDim2.new(0, 130, 0, 18)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = Name
    NameLabel.TextColor3 = Color3.fromRGB(235, 238, 245)
    NameLabel.TextSize = 12
    NameLabel.Font = Enum.Font.GothamMedium
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    NameLabel.Parent = Item

    local IDLabel = Instance.new("TextLabel")
    IDLabel.Position = UDim2.new(0, 12, 0, 24)
    IDLabel.Size = UDim2.new(0, 170, 0, 17)
    IDLabel.BackgroundTransparency = 1
    IDLabel.Text = ID
    IDLabel.TextColor3 = Color3.fromRGB(135, 145, 165)
    IDLabel.TextSize = 10
    IDLabel.Font = Enum.Font.Code
    IDLabel.TextXAlignment = Enum.TextXAlignment.Left
    IDLabel.Parent = Item

    local CopyButton = Instance.new("TextButton")
    CopyButton.Size = UDim2.new(0, 55, 0, 28)
    CopyButton.Position = UDim2.new(0, 188, 0.5, -14)
    CopyButton.BackgroundColor3 = Color3.fromRGB(55, 120, 255)
    CopyButton.BorderSizePixel = 0
    CopyButton.Text = "Copy"
    CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyButton.TextSize = 10
    CopyButton.Font = Enum.Font.GothamBold
    CopyButton.AutoButtonColor = false
    CopyButton.Parent = Item

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 6)
    CopyCorner.Parent = CopyButton

    CopyButton.MouseButton1Click:Connect(function()

        if Copy(ID) then
            CopyButton.Text = "Copied!"

            task.delay(0.8, function()
                if CopyButton.Parent then
                    CopyButton.Text = "Copy"
                end
            end)
        end

    end)

end

--==================================================
-- OPEN / CLOSE
--==================================================

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenButton.Visible = false
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenButton.Visible = true
end)

print("Rimuru Hub carregado.")

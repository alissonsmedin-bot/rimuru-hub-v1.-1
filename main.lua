--// 💥 RIMURU HUB
--// Main

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- LOAD SOUND DATABASE
--==================================================

local SoundsURL = "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/sound.lua"

local Sounds = loadstring(game:HttpGet(SoundsURL))()

--==================================================
-- REMOVE OLD VERSION
--==================================================

pcall(function()

    local Old = PlayerGui:FindFirstChild("RimuruHub")

    if Old then
        Old:Destroy()
    end

end)

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")

Gui.Name = "RimuruHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

Gui.DisplayOrder = 999999

Gui.Parent = PlayerGui

--==================================================
-- LOGO
--==================================================

local LogoButton = Instance.new("ImageButton")

LogoButton.Name = "RimuruLogo"
LogoButton.Size = UDim2.new(0, 55, 0, 55)
LogoButton.Position = UDim2.new(0, 20, 0.5, -27)

LogoButton.BackgroundColor3 = Color3.fromRGB(8, 22, 48)
LogoButton.BorderSizePixel = 0

LogoButton.Image = "rbxassetid://6691708227"

LogoButton.ScaleType = Enum.ScaleType.Fit
LogoButton.AutoButtonColor = false
LogoButton.ZIndex = 1000

LogoButton.Parent = Gui

local LogoCorner = Instance.new("UICorner")

LogoCorner.CornerRadius = UDim.new(0, 14)
LogoCorner.Parent = LogoButton

local LogoStroke = Instance.new("UIStroke")

LogoStroke.Color = Color3.fromRGB(55, 120, 255)
LogoStroke.Thickness = 2

LogoStroke.Parent = LogoButton

--==================================================
-- LOGO DRAG
--==================================================

local LogoDragging = false
local LogoMoved = false

local LogoDragStart
local LogoStartPosition

LogoButton.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        LogoDragging = true
        LogoMoved = false

        LogoDragStart = Input.Position
        LogoStartPosition = LogoButton.Position

    end

end)

UIS.InputChanged:Connect(function(Input)

    if not LogoDragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        local Delta = Input.Position - LogoDragStart

        if math.abs(Delta.X) > 5
        or math.abs(Delta.Y) > 5 then

            LogoMoved = true

        end

        LogoButton.Position = UDim2.new(
            LogoStartPosition.X.Scale,
            LogoStartPosition.X.Offset + Delta.X,

            LogoStartPosition.Y.Scale,
            LogoStartPosition.Y.Offset + Delta.Y
        )

    end

end)

UIS.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        LogoDragging = false

    end

end)

--==================================================
-- MAIN MENU
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.Size = UDim2.new(0, 430, 0, 360)
Main.Position = UDim2.new(0.5, -215, 0.5, -180)

Main.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
Main.BorderSizePixel = 0

Main.Visible = false
Main.ZIndex = 500

Main.Parent = Gui

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = Color3.fromRGB(55, 120, 255)
MainStroke.Thickness = 1.5

MainStroke.Parent = Main

--==================================================
-- MAIN DRAG
--==================================================

local Dragging = false

local DragStart
local StartPosition

Main.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true

        DragStart = Input.Position
        StartPosition = Main.Position

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
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
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
Header.ZIndex = 501

Header.Parent = Main

local HeaderLogo = Instance.new("ImageLabel")

HeaderLogo.Size = UDim2.new(0, 40, 0, 40)
HeaderLogo.Position = UDim2.new(0, 10, 0, 8)

HeaderLogo.BackgroundTransparency = 1

HeaderLogo.Image = "rbxassetid://6691708227"

HeaderLogo.ScaleType = Enum.ScaleType.Fit
HeaderLogo.ZIndex = 502

HeaderLogo.Parent = Header

local Title = Instance.new("TextLabel")

Title.Position = UDim2.new(0, 60, 0, 7)
Title.Size = UDim2.new(1, -105, 0, 25)

Title.BackgroundTransparency = 1

Title.Text = "Rimuru Hub"
Title.TextColor3 = Color3.fromRGB(240, 243, 250)

Title.TextSize = 19
Title.Font = Enum.Font.GothamBold

Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 502

Title.Parent = Header

local Subtitle = Instance.new("TextLabel")

Subtitle.Position = UDim2.new(0, 61, 0, 31)
Subtitle.Size = UDim2.new(1, -75, 0, 18)

Subtitle.BackgroundTransparency = 1

Subtitle.Text = "Sound IDs"
Subtitle.TextColor3 = Color3.fromRGB(130, 140, 160)

Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham

Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.ZIndex = 502

Subtitle.Parent = Header

--==================================================
-- CLOSE
--==================================================

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
Close.ZIndex = 503

Close.Parent = Header

local CloseCorner = Instance.new("UICorner")

CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = Close

--==================================================
-- SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")

Scroll.Name = "SoundList"

Scroll.Position = UDim2.new(0, 10, 0, 65)
Scroll.Size = UDim2.new(1, -20, 1, -75)

Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0

Scroll.ScrollBarThickness = 5
Scroll.ScrollBarImageColor3 = Color3.fromRGB(55, 120, 255)

Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y

Scroll.ZIndex = 501
Scroll.Parent = Main

local Padding = Instance.new("UIPadding")

Padding.PaddingBottom = UDim.new(0, 6)
Padding.Parent = Scroll

local Layout = Instance.new("UIListLayout")

Layout.Padding = UDim.new(0, 5)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

Layout.Parent = Scroll

--==================================================
-- COPY FUNCTION
--==================================================

local function Copy(ID)

    if setclipboard then

        local Success = pcall(function()
            setclipboard(ID)
        end)

        if Success then
            return true
        end

    end

    if toclipboard then

        local Success = pcall(function()
            toclipboard(ID)
        end)

        if Success then
            return true
        end

    end

    return false

end

--==================================================
-- SOUND CARDS
--==================================================

for Index, Data in ipairs(Sounds) do

    local Name = Data[1]
    local ID = Data[2]

    local Card = Instance.new("Frame")

    Card.Name = "Sound_" .. Index

    Card.Size = UDim2.new(1, -5, 0, 48)

    Card.BackgroundColor3 = Color3.fromRGB(24, 28, 40)
    Card.BorderSizePixel = 0

    Card.LayoutOrder = Index
    Card.ZIndex = 502

    Card.Parent = Scroll

    local CardCorner = Instance.new("UICorner")

    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    -- NAME

    local NameLabel = Instance.new("TextLabel")

    NameLabel.Position = UDim2.new(0, 12, 0, 5)
    NameLabel.Size = UDim2.new(0, 175, 0, 18)

    NameLabel.BackgroundTransparency = 1

    NameLabel.Text = Name
    NameLabel.TextColor3 = Color3.fromRGB(235, 238, 245)

    NameLabel.TextSize = 12
    NameLabel.Font = Enum.Font.GothamMedium

    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd

    NameLabel.ZIndex = 503
    NameLabel.Parent = Card

    -- ID

    local IDLabel = Instance.new("TextLabel")

    IDLabel.Position = UDim2.new(0, 12, 0, 25)
    IDLabel.Size = UDim2.new(0, 175, 0, 16)

    IDLabel.BackgroundTransparency = 1

    IDLabel.Text = ID
    IDLabel.TextColor3 = Color3.fromRGB(135, 145, 165)

    IDLabel.TextSize = 10
    IDLabel.Font = Enum.Font.Code

    IDLabel.TextXAlignment = Enum.TextXAlignment.Left

    IDLabel.ZIndex = 503
    IDLabel.Parent = Card

    -- COPY

    local CopyButton = Instance.new("TextButton")

    CopyButton.Size = UDim2.new(0, 55, 0, 28)
    CopyButton.Position = UDim2.new(0, 195, 0.5, -14)

    CopyButton.BackgroundColor3 = Color3.fromRGB(55, 120, 255)
    CopyButton.BorderSizePixel = 0

    CopyButton.Text = "Copy"
    CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    CopyButton.TextSize = 10
    CopyButton.Font = Enum.Font.GothamBold

    CopyButton.AutoButtonColor = false

    CopyButton.ZIndex = 504
    CopyButton.Parent = Card

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

        else

            CopyButton.Text = "N/A"

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

LogoButton.MouseButton1Click:Connect(function()

    if LogoMoved then

        LogoMoved = false
        return

    end

    Main.Visible = true
    LogoButton.Visible = false

end)

Close.MouseButton1Click:Connect(function()

    Main.Visible = false
    LogoButton.Visible = true

end)

print("💥 Rimuru Hub carregado.")

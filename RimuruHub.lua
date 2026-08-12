--// 💥 RIMURU HUB
--// Sound ID Library
--// Version 1.0

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- SOUND DATABASE
--==================================================

local Sounds = {
    {
        Name = "Coin Parry",
        ID = "81202220081219"
    },

    {
        Name = "Coin",
        ID = "136124980150792"
    },

    {
        Name = "Naginata Hit1",
        ID = "94107281648467"
    },

    {
        Name = "Naginata Hit2",
        ID = "103563218704266"
    },

    {
        Name = "Naginata Hit3",
        ID = "103563218704266"
    },

    {
        Name = "Gun Fire",
        ID = "5735280081"
    },

    {
        Name = "Gun Hit",
        ID = "3932141920"
    },

    {
        Name = "Gun Break",
        ID = "1358442317"
    },

    {
        Name = "Dash 1",
        ID = "92870369637296"
    },

    {
        Name = "Dash 2",
        ID = "133205097862880"
    },

    {
        Name = "M1 Hit 1",
        ID = "92660735965001"
    },

    {
        Name = "M1 Hit 2",
        ID = "103376351068703"
    },

    {
        Name = "M1 Hit 3",
        ID = "122604454724442"
    },

    {
        Name = "M1 Hit 4",
        ID = "108932851477523"
    },

    {
        Name = "M1 Down",
        ID = "73223862105514"
    },

    {
        Name = "M1 Up",
        ID = "124704505278190"
    }
}

--==================================================
-- THEMES
--==================================================

local Themes = {
    Green = Color3.fromRGB(70, 220, 120),
    Red = Color3.fromRGB(235, 65, 65),
    White = Color3.fromRGB(235, 235, 235),
    Blue = Color3.fromRGB(70, 130, 255),
    Cyan = Color3.fromRGB(40, 220, 220),
    Neon = Color3.fromRGB(180, 60, 255)
}

local CurrentColor = Themes.Blue
local RGBEnabled = false
local BackgroundTransparency = 0.08

--==================================================
-- DESTROY OLD VERSION
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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RimuruHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 720, 0, 450)
Main.Position = UDim2.new(0.5, -360, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(14, 17, 28)
Main.BackgroundTransparency = BackgroundTransparency
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = CurrentColor
MainStroke.Transparency = 0.15
MainStroke.Parent = Main

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function StartDrag(Input)
    Dragging = true
    DragStart = Input.Position
    StartPosition = Main.Position
end

local function UpdateDrag(Input)
    if not Dragging then
        return
    end

    local Delta = Input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end

local function EndDrag()
    Dragging = false
end

Main.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then
        StartDrag(Input)
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then
        UpdateDrag(Input)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then
        EndDrag()
    end
end)

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 65)
Header.BackgroundTransparency = 1
Header.Parent = Main

-- Logo background
local Logo = Instance.new("Frame")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 48, 0, 48)
Logo.Position = UDim2.new(0, 12, 0, 9)
Logo.BackgroundColor3 = Color3.fromRGB(8, 25, 55)
Logo.BorderSizePixel = 0
Logo.Parent = Header

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 12)
LogoCorner.Parent = Logo

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Thickness = 2
LogoStroke.Color = CurrentColor
LogoStroke.Transparency = 0
LogoStroke.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "💥"
LogoText.TextSize = 28
LogoText.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Position = UDim2.new(0, 72, 0, 10)
Title.Size = UDim2.new(0, 300, 0, 26)
Title.BackgroundTransparency = 1
Title.Text = "Rimuru Hub"
Title.TextColor3 = Color3.fromRGB(245, 245, 250)
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Position = UDim2.new(0, 73, 0, 36)
Subtitle.Size = UDim2.new(0, 300, 0, 18)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Sound ID Library"
Subtitle.TextColor3 = Color3.fromRGB(135, 140, 155)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 165, 1, -78)
Sidebar.Position = UDim2.new(0, 10, 0, 68)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
Sidebar.BackgroundTransparency = 0.1
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 11)
SidebarCorner.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 12)
SidebarPadding.PaddingLeft = UDim.new(0, 9)
SidebarPadding.PaddingRight = UDim.new(0, 9)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 7)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

--==================================================
-- SIDEBAR BUTTON CREATOR
--==================================================

local function CreateSidebarButton(Text, Icon)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 42)
    Button.BackgroundColor3 = Color3.fromRGB(24, 27, 38)
    Button.BackgroundTransparency = 0
    Button.BorderSizePixel = 0
    Button.Text = Icon .. "   " .. Text
    Button.TextColor3 = Color3.fromRGB(180, 185, 200)
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamMedium
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.Parent = Button

    return Button
end

local SoundsButton = CreateSidebarButton("Sounds", "🔊")
local ConfigButton = CreateSidebarButton("Configuração", "⚙️")

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -190, 1, -78)
Content.Position = UDim2.new(0, 180, 0, 68)
Content.BackgroundTransparency = 1
Content.Parent = Main

--==================================================
-- SOUNDS PAGE
--==================================================

local SoundsPage = Instance.new("Frame")
SoundsPage.Name = "SoundsPage"
SoundsPage.Size = UDim2.new(1, 0, 1, 0)
SoundsPage.BackgroundTransparency = 1
SoundsPage.Parent = Content

local SoundsTitle = Instance.new("TextLabel")
SoundsTitle.Size = UDim2.new(1, -10, 0, 28)
SoundsTitle.BackgroundTransparency = 1
SoundsTitle.Text = "Sound Library"
SoundsTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
SoundsTitle.TextSize = 19
SoundsTitle.Font = Enum.Font.GothamBold
SoundsTitle.TextXAlignment = Enum.TextXAlignment.Left
SoundsTitle.Parent = SoundsPage

local SoundsDescription = Instance.new("TextLabel")
SoundsDescription.Position = UDim2.new(0, 0, 0, 29)
SoundsDescription.Size = UDim2.new(1, -10, 0, 20)
SoundsDescription.BackgroundTransparency = 1
SoundsDescription.Text = "IDs disponíveis para seus movesets."
SoundsDescription.TextColor3 = Color3.fromRGB(125, 130, 145)
SoundsDescription.TextSize = 11
SoundsDescription.Font = Enum.Font.Gotham
SoundsDescription.TextXAlignment = Enum.TextXAlignment.Left
SoundsDescription.Parent = SoundsPage

--==================================================
-- SCROLLING FRAME
--==================================================

local SoundScroll = Instance.new("ScrollingFrame")
SoundScroll.Name = "SoundScroll"
SoundScroll.Position = UDim2.new(0, 0, 0, 58)
SoundScroll.Size = UDim2.new(1, -5, 1, -58)
SoundScroll.BackgroundTransparency = 1
SoundScroll.BorderSizePixel = 0
SoundScroll.ScrollBarThickness = 5
SoundScroll.ScrollBarImageColor3 = CurrentColor
SoundScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SoundScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SoundScroll.ScrollingDirection = Enum.ScrollingDirection.Y
SoundScroll.Parent = SoundsPage

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.PaddingRight = UDim.new(0, 6)
ScrollPadding.PaddingBottom = UDim.new(0, 10)
ScrollPadding.Parent = SoundScroll

local SoundLayout = Instance.new("UIListLayout")
SoundLayout.Padding = UDim.new(0, 7)
SoundLayout.SortOrder = Enum.SortOrder.LayoutOrder
SoundLayout.Parent = SoundScroll

--==================================================
-- COPY FUNCTION
--==================================================

local function CopyText(Text)

    local ClipboardFunction = nil

    pcall(function()
        if setclipboard then
            ClipboardFunction = setclipboard
        elseif toclipboard then
            ClipboardFunction = toclipboard
        end
    end)

    if ClipboardFunction then
        pcall(function()
            ClipboardFunction(Text)
        end)

        return true
    end

    return false
end

--==================================================
-- SOUND CARD
--==================================================

local function CreateSoundCard(Data, Index)

    local Card = Instance.new("Frame")
    Card.Name = "Sound_" .. Index
    Card.Size = UDim2.new(1, 0, 0, 59)
    Card.BackgroundColor3 = Color3.fromRGB(23, 26, 37)
    Card.BackgroundTransparency = 0
    Card.BorderSizePixel = 0
    Card.LayoutOrder = Index
    Card.Parent = SoundScroll

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 9)
    CardCorner.Parent = Card

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.new(0, 3, 1, -14)
    Accent.Position = UDim2.new(0, 6, 0, 7)
    Accent.BackgroundColor3 = CurrentColor
    Accent.BorderSizePixel = 0
    Accent.Parent = Card

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1, 0)
    AccentCorner.Parent = Accent

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Position = UDim2.new(0, 20, 0, 7)
    NameLabel.Size = UDim2.new(1, -135, 0, 20)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = Data.Name
    NameLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
    NameLabel.TextSize = 13
    NameLabel.Font = Enum.Font.GothamMedium
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    NameLabel.Parent = Card

    local IDLabel = Instance.new("TextLabel")
    IDLabel.Position = UDim2.new(0, 20, 0, 29)
    IDLabel.Size = UDim2.new(1, -135, 0, 19)
    IDLabel.BackgroundTransparency = 1
    IDLabel.Text = Data.ID
    IDLabel.TextColor3 = Color3.fromRGB(125, 130, 145)
    IDLabel.TextSize = 11
    IDLabel.Font = Enum.Font.Code
    IDLabel.TextXAlignment = Enum.TextXAlignment.Left
    IDLabel.Parent = Card

    local CopyButton = Instance.new("TextButton")
    CopyButton.Size = UDim2.new(0, 76, 0, 32)
    CopyButton.Position = UDim2.new(1, -86, 0.5, -16)
    CopyButton.BackgroundColor3 = CurrentColor
    CopyButton.BackgroundTransparency = 0
    CopyButton.BorderSizePixel = 0
    CopyButton.Text = "Copy"
    CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyButton.TextSize = 11
    CopyButton.Font = Enum.Font.GothamBold
    CopyButton.AutoButtonColor = false
    CopyButton.Parent = Card

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 7)
    CopyCorner.Parent = CopyButton

    CopyButton.MouseButton1Click:Connect(function()

        local Success = CopyText(Data.ID)

        if Success then
            CopyButton.Text = "Copied!"
        else
            CopyButton.Text = "No API"
        end

        task.delay(0.8, function()
            if CopyButton and CopyButton.Parent then
                CopyButton.Text = "Copy"
            end
        end)
    end)

    return Card
end

--==================================================
-- CREATE ALL SOUND CARDS
--==================================================

for Index, Data in ipairs(Sounds) do
    CreateSoundCard(Data, Index)
end

--==================================================
-- CONFIGURATION PAGE
--==================================================

local ConfigPage = Instance.new("Frame")
ConfigPage.Name = "ConfigPage"
ConfigPage.Size = UDim2.new(1, 0, 1, 0)
ConfigPage.BackgroundTransparency = 1
ConfigPage.Visible = false
ConfigPage.Parent = Content

local ConfigTitle = Instance.new("TextLabel")
ConfigTitle.Size = UDim2.new(1, -10, 0, 28)
ConfigTitle.BackgroundTransparency = 1
ConfigTitle.Text = "Configuração"
ConfigTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
ConfigTitle.TextSize = 19
ConfigTitle.Font = Enum.Font.GothamBold
ConfigTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfigTitle.Parent = ConfigPage

local ConfigDescription = Instance.new("TextLabel")
ConfigDescription.Position = UDim2.new(0, 0, 0, 29)
ConfigDescription.Size = UDim2.new(1, -10, 0, 20)
ConfigDescription.BackgroundTransparency = 1
ConfigDescription.Text = "Personalize o visual do Rimuru Hub."
ConfigDescription.TextColor3 = Color3.fromRGB(125, 130, 145)
ConfigDescription.TextSize = 11
ConfigDescription.Font = Enum.Font.Gotham
ConfigDescription.TextXAlignment = Enum.TextXAlignment.Left
ConfigDescription.Parent = ConfigPage

--==================================================
-- COLORS PANEL
--==================================================

local ColorsPanel = Instance.new("Frame")
ColorsPanel.Position = UDim2.new(0, 0, 0, 60)
ColorsPanel.Size = UDim2.new(1, -5, 0, 190)
ColorsPanel.BackgroundColor3 = Color3.fromRGB(23, 26, 37)
ColorsPanel.BorderSizePixel = 0
ColorsPanel.Parent = ConfigPage

local ColorsCorner = Instance.new("UICorner")
ColorsCorner.CornerRadius = UDim.new(0, 10)
ColorsCorner.Parent = ColorsPanel

local ColorsTitle = Instance.new("TextLabel")
ColorsTitle.Position = UDim2.new(0, 14, 0, 10)
ColorsTitle.Size = UDim2.new(1, -28, 0, 24)
ColorsTitle.BackgroundTransparency = 1
ColorsTitle.Text = "Cor do menu"
ColorsTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
ColorsTitle.TextSize = 13
ColorsTitle.Font = Enum.Font.GothamBold
ColorsTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorsTitle.Parent = ColorsPanel

local ColorContainer = Instance.new("Frame")
ColorContainer.Position = UDim2.new(0, 12, 0, 43)
ColorContainer.Size = UDim2.new(1, -24, 1, -53)
ColorContainer.BackgroundTransparency = 1
ColorContainer.Parent = ColorsPanel

local ColorGrid = Instance.new("UIGridLayout")
ColorGrid.CellSize = UDim2.new(0, 92, 0, 38)
ColorGrid.CellPadding = UDim2.new(0, 7, 0, 7)
ColorGrid.SortOrder = Enum.SortOrder.LayoutOrder
ColorGrid.Parent = ColorContainer

--==================================================
-- THEME UPDATE
--==================================================

local function UpdateTheme(NewColor)

    CurrentColor = NewColor

    MainStroke.Color = NewColor
    LogoStroke.Color = NewColor
    SoundScroll.ScrollBarImageColor3 = NewColor

    for _, Object in ipairs(SoundScroll:GetChildren()) do

        if Object:IsA("Frame") then

            for _, Child in ipairs(Object:GetChildren()) do

                if Child:IsA("TextButton") then
                    Child.BackgroundColor3 = NewColor
                end

                if Child:IsA("Frame") and Child.Name == "Accent" then
                    Child.BackgroundColor3 = NewColor
                end

            end

        end

    end

    if SliderButton then
        SliderButton.BackgroundColor3 = NewColor
    end

    if TransparencyValue then
        TransparencyValue.TextColor3 = NewColor
    end
end

--==================================================
-- COLOR BUTTONS
--==================================================

local ColorNames = {
    "Green",
    "Red",
    "White",
    "Blue",
    "Cyan",
    "Neon"
}

for Index, ColorName in ipairs(ColorNames) do

    local Button = Instance.new("TextButton")
    Button.Name = ColorName
    Button.Text = ColorName
    Button.BackgroundColor3 = Themes[ColorName]
    Button.BorderSizePixel = 0
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = false
    Button.LayoutOrder = Index
    Button.Parent = ColorContainer

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()

        RGBEnabled = false
        UpdateTheme(Themes[ColorName])

    end)
end

-- RGB BUTTON

local RGBButton = Instance.new("TextButton")
RGBButton.Name = "RGB"
RGBButton.Text = "RGB"
RGBButton.BackgroundColor3 = Color3.fromRGB(255, 70, 180)
RGBButton.BorderSizePixel = 0
RGBButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RGBButton.TextSize = 11
RGBButton.Font = Enum.Font.GothamBold
RGBButton.AutoButtonColor = false
RGBButton.LayoutOrder = 7
RGBButton.Parent = ColorContainer

local RGBButtonCorner = Instance.new("UICorner")
RGBButtonCorner.CornerRadius = UDim.new(0, 7)
RGBButtonCorner.Parent = RGBButton

RGBButton.MouseButton1Click:Connect(function()
    RGBEnabled = not RGBEnabled
end)

--==================================================
-- TRANSPARENCY PANEL
--==================================================

local TransparencyPanel = Instance.new("Frame")
TransparencyPanel.Position = UDim2.new(0, 0, 0, 265)
TransparencyPanel.Size = UDim2.new(1, -5, 0, 110)
TransparencyPanel.BackgroundColor3 = Color3.fromRGB(23, 26, 37)
TransparencyPanel.BorderSizePixel = 0
TransparencyPanel.Parent = ConfigPage

loc
--==================================================
-- TRANSPARENCY PANEL - CONTINUAÇÃO
--==================================================

local TransparencyCorner = Instance.new("UICorner")
TransparencyCorner.CornerRadius = UDim.new(0, 10)
TransparencyCorner.Parent = TransparencyPanel

local TransparencyTitle = Instance.new("TextLabel")
TransparencyTitle.Position = UDim2.new(0, 14, 0, 11)
TransparencyTitle.Size = UDim2.new(0.7, 0, 0, 22)
TransparencyTitle.BackgroundTransparency = 1
TransparencyTitle.Text = "Transparência do fundo"
TransparencyTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
TransparencyTitle.TextSize = 13
TransparencyTitle.Font = Enum.Font.GothamBold
TransparencyTitle.TextXAlignment = Enum.TextXAlignment.Left
TransparencyTitle.Parent = TransparencyPanel

local TransparencyValue = Instance.new("TextLabel")
TransparencyValue.Position = UDim2.new(1, -70, 0, 11)
TransparencyValue.Size = UDim2.new(0, 55, 0, 22)
TransparencyValue.BackgroundTransparency = 1
TransparencyValue.Text = "8%"
TransparencyValue.TextColor3 = CurrentColor
TransparencyValue.TextSize = 12
TransparencyValue.Font = Enum.Font.GothamBold
TransparencyValue.TextXAlignment = Enum.TextXAlignment.Right
TransparencyValue.Parent = TransparencyPanel

local SliderBack = Instance.new("Frame")
SliderBack.Position = UDim2.new(0, 15, 0, 57)
SliderBack.Size = UDim2.new(1, -30, 0, 7)
SliderBack.BackgroundColor3 = Color3.fromRGB(50, 54, 65)
SliderBack.BorderSizePixel = 0
SliderBack.Parent = TransparencyPanel

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = SliderBack

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 15, 0, 15)
SliderButton.Position = UDim2.new(BackgroundTransparency, -7, 0.5, -7)
SliderButton.BackgroundColor3 = CurrentColor
SliderButton.BorderSizePixel = 0
SliderButton.Text = ""
SliderButton.AutoButtonColor = false
SliderButton.Parent = SliderBack

local SliderButtonCorner = Instance.new("UICorner")
SliderButtonCorner.CornerRadius = UDim.new(1, 0)
SliderButtonCorner.Parent = SliderButton

--==================================================
-- TRANSPARENCY SLIDER
--==================================================

local SliderDragging = false

local function UpdateTransparencyFromInput(Input)

    local RelativeX =
        (Input.Position.X - SliderBack.AbsolutePosition.X)
        / SliderBack.AbsoluteSize.X

    RelativeX = math.clamp(RelativeX, 0, 1)

    BackgroundTransparency = RelativeX

    Main.BackgroundTransparency = RelativeX

    SliderButton.Position =
        UDim2.new(RelativeX, -7, 0.5, -7)

    TransparencyValue.Text =
        tostring(math.floor(RelativeX * 100)) .. "%"
end

SliderButton.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        SliderDragging = true
        UpdateTransparencyFromInput(Input)

    end
end)

SliderBack.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        SliderDragging = true
        UpdateTransparencyFromInput(Input)

    end
end)

UserInputService.InputChanged:Connect(function(Input)

    if not SliderDragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        UpdateTransparencyFromInput(Input)

    end

end)

UserInputService.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        SliderDragging = false

    end

end)

--==================================================
-- PAGE SWITCHING
--==================================================

local function SetButtonActive(Button, Active)

    if Active then

        Button.BackgroundColor3 = CurrentColor
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)

    else

        Button.BackgroundColor3 = Color3.fromRGB(24, 27, 38)
        Button.TextColor3 = Color3.fromRGB(180, 185, 200)

    end

end

local function ShowSounds()

    SoundsPage.Visible = true
    ConfigPage.Visible = false

    SetButtonActive(SoundsButton, true)
    SetButtonActive(ConfigButton, false)

end

local function ShowConfig()

    SoundsPage.Visible = false
    ConfigPage.Visible = true

    SetButtonActive(SoundsButton, false)
    SetButtonActive(ConfigButton, true)

end

SoundsButton.MouseButton1Click:Connect(ShowSounds)
ConfigButton.MouseButton1Click:Connect(ShowConfig)

ShowSounds()

--==================================================
-- RGB LOOP
--==================================================

task.spawn(function()

    local Hue = 0

    while ScreenGui.Parent do

        task.wait(0.03)

        if RGBEnabled then

            Hue = Hue + 0.003

            if Hue >= 1 then
                Hue = 0
            end

            local RGBColor = Color3.fromHSV(Hue, 0.9, 1)

            UpdateTheme(RGBColor)

            RGBButton.BackgroundColor3 = RGBColor

        end

    end

end)

--==================================================
-- FINISHED
--==================================================

print("Rimuru Hub carregado com sucesso.")

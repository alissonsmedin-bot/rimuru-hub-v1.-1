--// 💥🎵 RIMURU HUB
--// Sound ID Library

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--==================================================
-- SOUNDS
--==================================================

local Sounds = {
    {Name = "Coin Parry", ID = "81202220081219"},
    {Name = "Coin", ID = "136124980150792"},

    {Name = "Naginata Hit1", ID = "94107281648467"},
    {Name = "Naginata Hit2", ID = "103563218704266"},
    {Name = "Naginata Hit3", ID = "103563218704266"},

    {Name = "Gun Fire", ID = "5735280081"},
    {Name = "Gun Hit", ID = "3932141920"},
    {Name = "Gun Break", ID = "1358442317"},

    {Name = "Dash 1", ID = "92870369637296"},
    {Name = "Dash 2", ID = "133205097862880"},

    {Name = "M1 Hit 1", ID = "92660735965001"},
    {Name = "M1 Hit 2", ID = "103376351068703"},
    {Name = "M1 Hit 3", ID = "122604454724442"},
    {Name = "M1 Hit 4", ID = "108932851477523"},

    {Name = "M1 Down", ID = "73223862105514"},
    {Name = "M1 Up", ID = "124704505278190"},
}

--==================================================
-- SETTINGS
--==================================================

local ThemeColors = {
    Green = Color3.fromRGB(60, 220, 120),
    Red = Color3.fromRGB(235, 65, 65),
    White = Color3.fromRGB(235, 235, 235),
    Blue = Color3.fromRGB(65, 130, 255),
    Cyan = Color3.fromRGB(40, 220, 220),
    Neon = Color3.fromRGB(170, 60, 255),
}

local CurrentColor = ThemeColors.Cyan
local BackgroundTransparency = 0.08
local RGBMode = false

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RimuruHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 720, 0, 450)
Main.Position = UDim2.new(0.5, -360, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
Main.BackgroundTransparency = BackgroundTransparency
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = CurrentColor
MainStroke.Transparency = 0.25
MainStroke.Parent = Main

--==================================================
-- DRAG
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

UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then return end

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

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 62)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 55, 0, 55)
Logo.Position = UDim2.new(0, 15, 0, 3)
Logo.BackgroundTransparency = 1
Logo.Text = "💥"
Logo.TextSize = 34
Logo.Parent = Header

local MusicLogo = Instance.new("TextLabel")
MusicLogo.Size = UDim2.new(0, 35, 0, 35)
MusicLogo.Position = UDim2.new(0, 27, 0, -2)
MusicLogo.BackgroundTransparency = 1
MusicLogo.Text = "🎵"
MusicLogo.TextSize = 22
MusicLogo.ZIndex = 3
MusicLogo.Parent = Header

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Thickness = 2
LogoStroke.Color = CurrentColor
LogoStroke.Transparency = 0.15
LogoStroke.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Position = UDim2.new(0, 82, 0, 8)
Title.Size = UDim2.new(0, 300, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "Rimuru Hub"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Position = UDim2.new(0, 83, 0, 32)
Subtitle.Size = UDim2.new(0, 300, 0, 18)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Sound ID Library"
Subtitle.TextColor3 = Color3.fromRGB(135, 135, 145)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 165, 1, -72)
Sidebar.Position = UDim2.new(0, 10, 0, 68)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 19)
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 11)
SidebarCorner.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 12)
SidePadding.PaddingLeft = UDim.new(0, 9)
SidePadding.PaddingRight = UDim.new(0, 9)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

local function CreateSideButton(Text, Icon)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 42)
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    Button.BackgroundTransparency = 0.2
    Button.BorderSizePixel = 0
    Button.Text = Icon .. "   " .. Text
    Button.TextColor3 = Color3.fromRGB(180, 180, 190)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamMedium
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    return Button
end

local SoundsButton = CreateSideButton("Sounds", "🔊")
local ConfigButton = CreateSideButton("Configuração", "⚙️")

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -190, 1, -72)
Content.Position = UDim2.new(0, 180, 0, 68)
Content.BackgroundTransparency = 1
Content.Parent = Main

local PageTitle = Instance.new("TextLabel")
PageTitle.Size = UDim2.new(1, -10, 0, 35)
PageTitle.BackgroundTransparency = 1
PageTitle.Text = "Sound Library"
PageTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
PageTitle.TextSize = 19
PageTitle.Font = Enum.Font.GothamBold
PageTitle.TextXAlignment = Enum.TextXAlignment.Left
PageTitle.Parent = Content

local PageDescription = Instance.new("TextLabel")
PageDescription.Position = UDim2.new(0, 0, 0, 32)
PageDescription.Size = UDim2.new(1, -10, 0, 20)
PageDescription.BackgroundTransparency = 1
PageDescription.Text = "IDs disponíveis para seus movesets."
PageDescription.TextColor3 = Color3.fromRGB(125, 125, 135)
PageDescription.TextSize = 11
PageDescription.Font = Enum.Font.Gotham
PageDescription.TextXAlignment = Enum.TextXAlignment.Left
PageDescription.Parent = Content

--==================================================
-- SOUNDS SCROLLING FRAME
--==================================================

local SoundScroll = Instance.new("ScrollingFrame")
SoundScroll.Position = UDim2.new(0, 0, 0, 62)
SoundScroll.Size = UDim2.new(1, -5, 1, -62)
SoundScroll.BackgroundTransparency = 1
SoundScroll.BorderSizePixel = 0
SoundScroll.ScrollBarThickness = 5
SoundScroll.ScrollBarImageColor3 = CurrentColor
SoundScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SoundScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SoundScroll.ScrollingDirection = Enum.ScrollingDirection.Y
SoundScroll.Parent = Content

local SoundPadding = Instance.new("UIPadding")
SoundPadding.PaddingRight = UDim.new(0, 7)
SoundPadding.PaddingBottom = UDim.new(0, 10)
SoundPadding.Parent = SoundScroll

local SoundLayout = Instance.new("UIListLayout")
SoundLayout.Padding = UDim.new(0, 7)
SoundLayout.SortOrder = Enum.SortOrder.LayoutOrder
SoundLayout.Parent = SoundScroll

--==================================================
-- CREATE SOUND CARD
--==================================================

local function CreateSoundCard(Data, Index)

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 58)
    Card.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    Card.BackgroundTransparency = 0.08
    Card.BorderSizePixel = 0
    Card.LayoutOrder = Index
    Card.Parent = SoundScroll

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Card

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.new(0, 3, 1, -14)
    Accent.Position = UDim2.new(0, 6, 0, 7)
    Accent.BackgroundColor3 = CurrentColor
    Accent.BorderSizePixel = 0
    Accent.Parent = Card

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1, 0)
    AccentCorner.Parent = Accent

    local Name = Instance.new("TextLabel")
    Name.Position = UDim2.new(0, 20, 0, 8)
    Name.Size = UDim2.new(1, -145, 0, 19)
    Name.BackgroundTransparency = 1
    Name.Text = Data.Name
    Name.TextColor3 = Color3.fromRGB(235, 235, 240)
    Name.TextSize = 13
    Name.Font = Enum.Font.GothamMedium
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Card

    local ID = Instance.new("TextLabel")
    ID.Position = UDim2.new(0, 20, 0, 29)
    ID.Size = UDim2.new(1, -145, 0, 18)
    ID.BackgroundTransparency = 1
    ID.Text = Data.ID
    ID.TextColor3 = Color3.fromRGB(125, 125, 135)
    ID.TextSize = 11
    ID.Font = Enum.Font.Code
    ID.TextXAlignment = Enum.TextXAlignment.Left
    ID.Parent = Card

    local CopyButton = Instance.new("TextButton")
    CopyButton.Size = UDim2.new(0, 78, 0, 32)
    CopyButton.Position = UDim2.new(1, -88, 0.5, -16)
    CopyButton.BackgroundColor3 = CurrentColor
    CopyButton.BackgroundTransparency = 0.15
    CopyButton.BorderSizePixel = 0
    CopyButton.Text = "Copy"
    CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyButton.TextSize = 12
    CopyButton.Font = Enum.Font.GothamBold
    CopyButton.AutoButtonColor = false
    CopyButton.Parent = Card

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 7)
    CopyCorner.Parent = CopyButton

    CopyButton.MouseButton1Click:Connect(function()

        if setclipboard then
            setclipboard(Data.ID)
        elseif toclipboard then
            toclipboard(Data.ID)
        end

        local OldText = CopyButton.Text
        CopyButton.Text = "Copied!"

        task.delay(0.8, function()
            if CopyButton then
                CopyButton.Text = OldText
            end
        end)
    end)

    return Card
end

for Index, Data in ipairs(Sounds) do
    CreateSoundCard(Data, Index)
end

--==================================================
-- CONFIG PAGE
--==================================================

local ConfigPage = Instance.new("Frame")
ConfigPage.Size = UDim2.new(1, 0, 1, 0)
ConfigPage.BackgroundTransparency = 1
ConfigPage.Visible = false
ConfigPage.Parent = Content

local ConfigTitle = Instance.new("TextLabel")
ConfigTitle.Size = UDim2.new(1, -10, 0, 35)
ConfigTitle.BackgroundTransparency = 1
ConfigTitle.Text = "Configuração"
ConfigTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
ConfigTitle.TextSize = 19
ConfigTitle.Font = Enum.Font.GothamBold
ConfigTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfigTitle.Parent = ConfigPage

local ConfigDesc = Instance.new("TextLabel")
ConfigDesc.Position = UDim2.new(0, 0, 0, 32)
ConfigDesc.Size = UDim2.new(1, -10, 0, 20)
ConfigDesc.BackgroundTransparency = 1
ConfigDesc.Text = "Personalize o visual do Rimuru Hub."
ConfigDesc.TextColor3 = Color3.fromRGB(125, 125, 135)
ConfigDesc.TextSize = 11
ConfigDesc.Font = Enum.Font.Gotham
ConfigDesc.TextXAlignment = Enum.TextXAlignment.Left
ConfigDesc.Parent = ConfigPage

local ColorsFrame = Instance.new("Frame")
ColorsFrame.Position = UDim2.new(0, 0, 0, 70)
ColorsFrame.Size = UDim2.new(1, -5, 0, 190)
ColorsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
ColorsFrame.BackgroundTransparency = 0.08
ColorsFrame.BorderSizePixel = 0
ColorsFrame.Parent = ConfigPage

local ColorsCorner = Instance.new("UICorner")
ColorsCorner.CornerRadius = UDim.new(0, 10)
ColorsCorner.Parent = ColorsFrame

local ColorsTitle = Instance.new("TextLabel")
ColorsTitle.Position = UDim2.new(0, 15, 0, 12)
ColorsTitle.Size = UDim2.new(1, -30, 0, 25)
ColorsTitle.BackgroundTransparency = 1
ColorsTitle.Text = "Cor do menu"
ColorsTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
ColorsTitle.TextSize = 14
ColorsTitle.Font = Enum.Font.GothamBold
ColorsTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorsTitle.Parent = ColorsFrame

local ColorNames = {
    "Green",
    "Red",
    "White",
    "Blue",
    "Cyan",
    "Neon",
    "RGB"
}

local ColorList = Instance.new("UIGridLayout")
ColorList.CellSize = UDim2.new(0, 95, 0, 40)
ColorList.CellPadding = UDim2.new(0, 7, 0, 7)
ColorList.Parent = ColorsFrame

local ColorPadding = Instance.new("UIPadding")
ColorPadding.PaddingTop = UDim.new(0, 45)
ColorPadding.PaddingLeft = UDim.new(0, 12)
ColorPadding.Parent = ColorsFrame

local function UpdateTheme(Color)

    CurrentColor = Color

    MainStroke.Color = Color
    LogoStroke.Color = Color
    SoundScroll.ScrollBarImageColor3 = Color

    for _, Object in ipairs(SoundScroll:GetChildren()) do
        if Object:IsA("Frame") then

            for _, Child in ipairs(Object:GetChildren()) do
                if Child:IsA("Frame") and Child.Size.X.Offset == 3 then
                    Child.BackgroundColor3 = Color
                elseif Child:IsA("TextButton") then
                    Child.BackgroundColor3 = Color
                end
            end
        end
    end
end

for _, ColorName in ipairs(ColorNames) do

    local Button = Instance.new("TextButton")
    Button.Text = ColorName
    Button.BackgroundColor3 = ThemeColors[ColorName] or Color3.fromRGB(255, 0, 100)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Parent = ColorsFrame

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()

        if ColorName == "RGB" then
            RGBMode = not RGBMode
        else
            RGBMode = false
            UpdateTheme(ThemeColors[ColorName])
        end
    end)
end

--==================================================
-- TRANSPARENCY
--==================================================

local TransparencyBox = Instance.new("Frame")
TransparencyBox.Position = UDim2.new(0, 0, 0, 275)
TransparencyBox.Size = UDim2.new(1, -5, 0, 105)
TransparencyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
TransparencyBox.BackgroundTransparency = 0.08
TransparencyBox.BorderSizePixel = 0
TransparencyBox.Parent = ConfigPage

local TransparencyCorner = Instance.new("UICorner")
TransparencyCorner.CornerRadius = UDim.new(0, 10)
TransparencyCorner.Parent = TransparencyBox

local TransparencyTitle = Instance.new("TextLabel")
TransparencyTitle.Position = UDim2.new(0, 15, 0, 12)
TransparencyTitle.Size = UDim2.new(1, -30, 0, 22)
TransparencyTitle.BackgroundTransparency = 1
TransparencyTitle.Text = "Transparência do fundo"
TransparencyTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
TransparencyTitle.TextSize = 13
TransparencyTitle.Font = Enum.Font.GothamBold
TransparencyTitle.TextXAlignment = Enum.TextXAlignment.Left
TransparencyTitle.Parent = TransparencyBox

local TransparencyValue = Instance.new("TextLabel")
TransparencyValue.Position = UDim2.new(1, -70, 0, 12)
TransparencyValue.Size = UDim2.new(0, 55, 0, 22)
TransparencyValue.BackgroundTransparency = 1
TransparencyValue.Text = "8%"
TransparencyValue.TextColor3 = CurrentColor
TransparencyValue.TextSize = 12
TransparencyValue.Font = Enum.Font.GothamBold
TransparencyValue.TextXAlignment = Enum.TextXAlignment.Right
TransparencyValue.Parent = TransparencyBox

local SliderBack = Instance.new("Frame")
SliderBack.Position = UDim2.new(0, 15, 0, 53)
SliderBack.Size = UDim2.new(1, -30, 0, 7)
SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
SliderBack.BorderSizePixel = 0
SliderBack.Parent = TransparencyBox

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = SliderBack

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 14, 0, 14)
SliderButton.Position = UDim2.new(BackgroundTransparency, -7, 0.5, -7)
SliderButton.BackgroundColor3 = CurrentColor
SliderButton.Text = ""
SliderButton.BorderSizePixel = 0
SliderButton.Parent = SliderBack

local SliderButtonCorner = Instance.new("UICorner")
SliderButtonCorner.CornerRadius = UDim.new(1, 0)
SliderButtonCorner.Parent = SliderButton

local Sliding = false

SliderButton.MouseButton1Down:Connect(function()
    Sliding = true
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Sliding = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)

    if not Sliding then return end
    if Input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

    local X = math.clamp(
        (Input.Position.X - SliderBack.AbsolutePosition.X)
        / SliderBack.AbsoluteSize.X,
        0,
        1
    )

    BackgroundTransparency = X
    Main.BackgroundTransparency = X

    SliderButton.Position = UDim2.new(X, -7, 0.5, -7)
    TransparencyValue.Text = math.floor(X * 100) .. "%"
end)

--==================================================
-- PAGE SWITCHING
--==================================================

local function ShowSounds()

    SoundScroll.Visible = true
    PageTitle.Visible = true
    PageDescription.Visible = true
    ConfigPage.Visible = false

    SoundsButton.BackgroundColor3 = CurrentColor
    SoundsButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    ConfigButton.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    ConfigButton.TextColor3 = Color3.fromRGB(180, 180, 190)
end

local function ShowConfig()

    SoundScroll.Visible = false
    PageTitle.Visible = false
    PageDescription.Visible = false
    ConfigPage.Visible = true

    ConfigButton.BackgroundColor3 = CurrentColor
    ConfigButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    SoundsButton.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    SoundsButton.TextColor3 = Color3.fromRGB(180, 180, 190)
end

SoundsButton.MouseButton1Click:Connect(ShowSounds)
ConfigButton.MouseButton1Click:Connect(ShowConfig)

ShowSounds()

--==================================================
-- RGB
--==================================================

task.spawn(function()

    local Hue = 0

    while ScreenGui.Parent do

        task.wait(0.03)

        if RGBMode then

            Hue = (Hue + 0.003) % 1

            local RGBColor = Color3.fromHSV(Hue, 1, 1)

       

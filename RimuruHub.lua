--// =========================================================
--// 💥🎵 RIMURU HUB
--// Sound ID Library
--// =========================================================

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// =========================================================
--// PREVENT DUPLICATE
--// =========================================================

local GUI_NAME = "RimuruHub_GUI"

pcall(function()
    local old = game:GetService("CoreGui"):FindFirstChild(GUI_NAME)
    if old then
        old:Destroy()
    end
end)

pcall(function()
    local old = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(GUI_NAME)
    if old then
        old:Destroy()
    end
end)

--// =========================================================
--// SOUND DATABASE
--// =========================================================

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

--// =========================================================
--// SETTINGS
--// =========================================================

local Theme = Color3.fromRGB(0, 220, 255)
local RGBEnabled = false
local BackgroundTransparency = 0.08

local Colors = {
    Verde = Color3.fromRGB(50, 220, 110),
    Vermelho = Color3.fromRGB(235, 65, 65),
    Branco = Color3.fromRGB(235, 235, 235),
    Azul = Color3.fromRGB(65, 125, 255),
    Ciano = Color3.fromRGB(0, 220, 255),
    Neon = Color3.fromRGB(185, 55, 255)
}

--// =========================================================
--// GUI PARENT
--// =========================================================

local GuiParent

pcall(function()
    if typeof(gethui) == "function" then
        GuiParent = gethui()
    end
end)

if not GuiParent then
    pcall(function()
        GuiParent = game:GetService("CoreGui")
    end)
end

if not GuiParent then
    GuiParent = LocalPlayer:WaitForChild("PlayerGui")
end

--// =========================================================
--// SCREEN GUI
--// =========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

--// =========================================================
--// MAIN
--// =========================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(720, 450)
Main.Position = UDim2.new(0.5, -360, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(17, 18, 23)
Main.BackgroundTransparency = BackgroundTransparency
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Theme
MainStroke.Transparency = 0.15
MainStroke.Parent = Main

--// =========================================================
--// DRAG SYSTEM
--// =========================================================

local Dragging = false
local DragStart
local StartPosition
local DragInput

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

Main.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
        DragInput = Input
    end
end)

Main.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input == DragInput then
        UpdateDrag(Input)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
        DragInput = nil
    end
end)

--// =========================================================
--// HEADER
--// =========================================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 62)
Header.BackgroundTransparency = 1
Header.Parent = Main

--// Explosion
local ExplosionLogo = Instance.new("TextLabel")
ExplosionLogo.Name = "ExplosionLogo"
ExplosionLogo.Size = UDim2.fromOffset(58, 58)
ExplosionLogo.Position = UDim2.fromOffset(13, 2)
ExplosionLogo.BackgroundTransparency = 1
ExplosionLogo.Text = "💥"
ExplosionLogo.TextSize = 35
ExplosionLogo.Font = Enum.Font.GothamBold
ExplosionLogo.Parent = Header

--// Music note OVER explosion
local MusicLogo = Instance.new("TextLabel")
MusicLogo.Name = "MusicLogo"
MusicLogo.Size = UDim2.fromOffset(38, 38)
MusicLogo.Position = UDim2.fromOffset(27, -3)
MusicLogo.BackgroundTransparency = 1
MusicLogo.Text = "🎵"
MusicLogo.TextSize = 22
MusicLogo.Font = Enum.Font.GothamBold
MusicLogo.ZIndex = 5
MusicLogo.Parent = Header

--// Logo border
local LogoBorder = Instance.new("UIStroke")
LogoBorder.Thickness = 1.8
LogoBorder.Color = Theme
LogoBorder.Transparency = 0.1
LogoBorder.Parent = ExplosionLogo

local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromOffset(350, 27)
Title.Position = UDim2.fromOffset(78, 9)
Title.BackgroundTransparency = 1
Title.Text = "Rimuru Hub"
Title.TextColor3 = Color3.fromRGB(245, 245, 250)
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.fromOffset(350, 20)
Subtitle.Position = UDim2.fromOffset(79, 34)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Sound ID Library"
Subtitle.TextColor3 = Color3.fromRGB(130, 132, 145)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

--// =========================================================
--// SIDEBAR
--// =========================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 165, 1, -72)
Sidebar.Position = UDim2.fromOffset(10, 68)
Sidebar.BackgroundColor3 = Color3.fromRGB(13, 14, 19)
Sidebar.BackgroundTransparency = 0.08
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 11)
SidebarCorner.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 11)
SidebarPadding.PaddingLeft = UDim.new(0, 9)
SidebarPadding.PaddingRight = UDim.new(0, 9)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 7)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

local function CreateSidebarButton(Text, Icon)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 42)
    Button.BackgroundColor3 = Color3.fromRGB(25, 26, 32)
    Button.BackgroundTransparency = 0
    Button.BorderSizePixel = 0
    Button.Text = Icon .. "   " .. Text
    Button.TextColor3 = Color3.fromRGB(180, 182, 192)
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamMedium
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    return Button
end

local SoundsButton = CreateSidebarButton("Sounds", "🔊")
local ConfigButton = CreateSidebarButton("Configuração", "⚙️")

--// =========================================================
--// CONTENT AREA
--// =========================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -190, 1, -72)
Content.Position = UDim2.fromOffset(180, 68)
Content.BackgroundTransparency = 1
Content.Parent = Main

--// =========================================================
--// SOUNDS PAGE
--// =========================================================

local SoundsPage = Instance.new("Frame")
SoundsPage.Name = "SoundsPage"
SoundsPage.Size = UDim2.fromScale(1, 1)
SoundsPage.BackgroundTransparency = 1
SoundsPage.Parent = Content

local SoundsTitle = Instance.new("TextLabel")
SoundsTitle.Size = UDim2.new(1, -5, 0, 30)
SoundsTitle.BackgroundTransparency = 1
SoundsTitle.Text = "Sound Library"
SoundsTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
SoundsTitle.TextSize = 19
SoundsTitle.Font = Enum.Font.GothamBold
SoundsTitle.TextXAlignment = Enum.TextXAlignment.Left
SoundsTitle.Parent = SoundsPage

local SoundsDescription = Instance.new("TextLabel")
SoundsDescription.Size = UDim2.new(1, -5, 0, 20)
SoundsDescription.Position = UDim2.fromOffset(0, 31)
SoundsDescription.BackgroundTransparency = 1
SoundsDescription.Text = "IDs disponíveis para seus movesets."
SoundsDescription.TextColor3 = Color3.fromRGB(125, 127, 140)
SoundsDescription.TextSize = 11
SoundsDescription.Font = Enum.Font.Gotham
SoundsDescription.TextXAlignment = Enum.TextXAlignment.Left
SoundsDescription.Parent = SoundsPage

--// =========================================================
--// SCROLLING FRAME
--// =========================================================

local SoundScroll = Instance.new("ScrollingFrame")
SoundScroll.Name = "SoundScroll"
SoundScroll.Size = UDim2.new(1, -4, 1, -62)
SoundScroll.Position = UDim2.fromOffset(0, 62)
SoundScroll.BackgroundTransparency = 1
SoundScroll.BorderSizePixel = 0
SoundScroll.ScrollBarThickness = 5
SoundScroll.ScrollBarImageColor3 = Theme
SoundScroll.ScrollingDirection = Enum.ScrollingDirection.Y
SoundScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SoundScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SoundScroll.Parent = SoundsPage

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.PaddingRight = UDim.new(0, 7)
ScrollPadding.PaddingBottom = UDim.new(0, 10)
ScrollPadding.Parent = SoundScroll

local SoundLayout = Instance.new("UIListLayout")
SoundLayout.Padding = UDim.new(0, 7)
SoundLayout.SortOrder = Enum.SortOrder.LayoutOrder
SoundLayout.Parent = SoundScroll

--// =========================================================
--// COPY FUNCTION
--// =========================================================

local function CopyText(Text)

    local Success = false

    pcall(function()
        if typeof(setclipboard) == "function" then
            setclipboard(Text)
            Success = true
        end
    end)

    if not Success then
        pcall(function()
            if typeof(toclipboard) == "function" then
                toclipboard(Text)
                Success = true
            end
        end)
    end

    return Success
end

--// =========================================================
--// SOUND CARD
--// =========================================================

local Cards = {}

local function CreateSoundCard(Data, Index)

    local Card = Instance.new("Frame")
    Card.Name = "Sound_" .. tostring(Index)
    Card.Size = UDim2.new(1, 0, 0, 58)
    Card.BackgroundColor3 = Color3.fromRGB(25, 26, 32)
    Card.BackgroundTransparency = 0
    Card.BorderSizePixel = 0
    Card.LayoutOrder = Index
    Card.Parent = SoundScroll

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Card

    local Accent = Instance.new("Frame")
    Accent.Name = "Accent"
    Accent.Size = UDim2.fromOffset(3, 38)
    Accent.Position = UDim2.fromOffset(6, 10)
    Accent.BackgroundColor3 = Theme
    Accent.BorderSizePixel = 0
    Accent.Parent = Card

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1, 0)
    AccentCorner.Parent = Accent

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -150, 0, 20)
    NameLabel.Position = UDim2.fromOffset(20, 7)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = Data.Name
    NameLabel.TextColor3 = Color3.fromRGB(238, 238, 244)
    NameLabel.TextSize = 13
    NameLabel.Font = Enum.Font.GothamMedium
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Card

    local IDLabel = Instance.new("TextLabel")
    IDLabel.Size = UDim2.new(1, -150, 0, 18)
    IDLabel.Position = UDim2.fromOffset(20, 29)
    IDLabel.BackgroundTransparency = 1
    IDLabel.Text = Data.ID
    IDLabel.TextColor3 = Color3.fromRGB(125, 127, 140)
    IDLabel.TextSize = 11
    IDLabel.Font = Enum.Font.Code
    IDLabel.TextXAlignment = Enum.TextXAlignment.Left
    IDLabel.Parent = Card

    local CopyButton = Instance.new("TextButton")
    CopyButton.Name = "Copy"
    CopyButton.Size = UDim2.fromOffset(76, 32)
    CopyButton.Position = UDim2.new(1, -86, 0.5, -16)
    CopyButton.BackgroundColor3 = Theme
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

            task.delay(0.8, function()
                if CopyButton and CopyButton.Parent then
                    CopyButton.Text = "Copy"
                end
            end)
        else
            CopyButton.Text = "No Clipboard"

            task.delay(1, function()
                if CopyButton and CopyButton.Parent then
                    CopyButton.Text = "Copy"
                end
            end)
        end
    end)

    table.insert(Cards, {
        Card = Card,
        Accent = Accent,
        CopyButton = CopyButton
    })
end

for Index, Data in ipairs(Sounds) do
    CreateSoundCard(Data, Index)
end

--// =========================================================
--// CONFIG PAGE
--// =========================================================

local ConfigPage = Instance.new("Frame")
ConfigPage.Name = "ConfigPage"
ConfigPage.Size = UDim2.fromScale(1, 1)
ConfigPage.BackgroundTransparency = 1
ConfigPage.Visible = false
ConfigPage.Parent = Content

local ConfigTitle = Instance.new("TextLabel")
ConfigTitle.Size = UDim2.new(1, -5, 0, 30)
ConfigTitle.BackgroundTransparency = 1
ConfigTitle.Text = "Configuração"
ConfigTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
ConfigTitle.TextSize = 19
ConfigTitle.Font = Enum.Font.GothamBold
ConfigTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfigTitle.Parent = ConfigPage

local ConfigDescription = Instance.new("TextLabel")
ConfigDescription.Size = UDim2.new(1, -5, 0, 20)
ConfigDescription.Position = UDim2.fromOffset(0, 31)
ConfigDescription.BackgroundTransparency = 1
ConfigDescription.Text = "Personalize o visual do Rimuru Hub."
ConfigDescription.TextColor3 = Color3.fromRGB(125, 127, 140)
ConfigDescription.TextSize = 11
ConfigDescription.Font = Enum.Font.Gotham
ConfigDescription.TextXAlignment = Enum.TextXAlignment.Left
ConfigDescription.Parent = ConfigPage

--// =========================================================
--// COLOR PANEL
--// =========================================================

local ColorPanel = Instance.new("Frame")
ColorPanel.Size = UDim2.new(1, -5, 0, 195)
ColorPanel.Position = UDim2.fromOffset(0, 65)
ColorPanel.BackgroundColor3 = Color3.fromRGB(25, 26, 32)
ColorPanel.BorderSizePixel = 0
ColorPanel.Parent = ConfigPage

local ColorPanelCorner = Instance.new("UICorner")
ColorPanelCorner.CornerRadius = UDim.new(0, 10)
ColorPanelCorner.Parent = ColorPanel

local ColorTitle = Instance.new("TextLabel")
ColorTitle.Size = UDim2.new(1, -30, 0, 25)
ColorTitle.Position = UDim2.fromOffset(15, 11)
ColorTitle.BackgroundTransparency = 1
ColorTitle.Text = "Cor do menu"
ColorTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
ColorTitle.TextSize = 14
ColorTitle.Font = Enum.Font.GothamBold
ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorTitle.Parent = ColorPanel

local ColorGrid = Instance.new("Frame")
ColorGrid.Size = UDim2.new(1, -24, 0, 130)
ColorGrid.Position = UDim2.fromOffset(12, 48)
ColorGrid.BackgroundTransparency = 1
ColorGrid.Parent = ColorPanel

local GridLayout = Instance.new("UIGridLayout")
GridLayout.CellSize = UDim2.fromOffset(95, 40)
GridLayout.CellPadding = UDim2.fromOffset(7, 7)
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.Parent = ColorGrid

local function ApplyTheme(Color)

    Theme = Color
    RGBEnabled = false

    MainStroke.Color = Color
    LogoBorder.Color = Color
    SoundScroll.ScrollBarImageColor3 = Color

    for _, Data in ipairs(Cards) do

        if Data.Accent and Data.Accent.Parent then
            Data.Accent.BackgroundColor3 = Color
        end

        if Data.CopyButton and Data.CopyButton.Parent then
            Data.CopyButton.BackgroundColor3 = Color
        end
    end

    SoundsButton.BackgroundColor3 = Color
    ConfigButton.BackgroundColor3 = Color

    -- active page stays colored
    if SoundsPage.Visible then
        SoundsButton.BackgroundColor3 = Color
        ConfigButton.BackgroundColor3 = Color3.fromRGB(25, 26, 32)
    else
        ConfigButton.BackgroundColor3 = Color
        SoundsButton.BackgroundColor3 = Color3.fromRGB(25, 26, 32)
    end
end

for Name, Color in pairs(Colors) do

    local Button = Instance.new("TextButton")
    Button.Name = Name
    Button.BackgroundColor3 = Color
    Button.BorderSizePixel = 0
    Button.Text = Name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = false
    Button.Parent = ColorGrid

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        ApplyTheme(Color)
    end)
end

--// RGB BUTTON

local RGBButton = Instance.new("TextButton")
RGBButton.Name = "RGB"
RGBButton.BackgroundColor3 = Color3.fromRGB(255, 0, 120)
RGBButton.BorderSizePixel = 0
RGBButton.Text = "RGB"
RGBButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RGBButton.TextSize = 11
RGBButton.Font = Enum.Font.GothamBold
RGBButton.AutoBut

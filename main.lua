--// 💥 RIMURU HUB
--// Main

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- LOAD FILES
--==================================================

local BaseURL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/"

local SoundsURL = BaseURL .. "sound.lua"
local ConfigURL = BaseURL .. "config.lua"

local Sounds = loadstring(game:HttpGet(SoundsURL))()
local Config = loadstring(game:HttpGet(ConfigURL))()

--==================================================
-- COLORS
--==================================================

local AccentColor = Color3.fromRGB(
    Config.UI.Color.R,
    Config.UI.Color.G,
    Config.UI.Color.B
)

local function GetAccent()
    return AccentColor
end

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

LogoStroke.Color = GetAccent()
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

    if not Config.UI.LogoDraggable then
        return
    end

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

Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)

Main.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
Main.BorderSizePixel = 0

Main.Visible = false
Main.ZIndex = 500

Main.Parent = Gui

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = GetAccent()
MainStroke.Thickness = 1.5

MainStroke.Parent = Main

--==================================================
-- MAIN DRAG
--==================================================

local Dragging = false

local DragStart
local StartPosition

Main.InputBegan:Connect(function(Input)

    if not Config.UI.MainMenuDraggable then
        return
    end

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

Subtitle.Text = "Sound Library"

Subtitle.TextColor3 =
    Color3.fromRGB(130, 140, 160)

Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham

Subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

Subtitle.ZIndex = 502
Subtitle.Parent = Header

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")

Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -38, 0, 14)

Close.BackgroundColor3 =
    Color3.fromRGB(35, 40, 55)

Close.BorderSizePixel = 0

Close.Text = "X"

Close.TextColor3 =
    Color3.fromRGB(230, 230, 235)

Close.TextSize = 12
Close.Font = Enum.Font.GothamBold

Close.AutoButtonColor = false

Close.ZIndex = 503
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")

CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = Close

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"

Sidebar.Position = UDim2.new(0, 10, 0, 65)
Sidebar.Size = UDim2.new(0, 165, 1, -75)

Sidebar.BackgroundColor3 =
    Color3.fromRGB(11, 14, 23)

Sidebar.BorderSizePixel = 0

Sidebar.ZIndex = 502
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")

SidebarCorner.CornerRadius =
    UDim.new(0, 9)

SidebarCorner.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")

SidebarPadding.PaddingTop =
    UDim.new(0, 8)

SidebarPadding.PaddingLeft =
    UDim.new(0, 7)

SidebarPadding.PaddingRight =
    UDim.new(0, 7)

SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")

SidebarLayout.Padding =
    UDim.new(0, 5)

SidebarLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

SidebarLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Position = UDim2.new(0, 185, 0, 65)

Content.Size = UDim2.new(1, -195, 1, -75)

Content.BackgroundColor3 =
    Color3.fromRGB(11, 14, 23)

Content.BorderSizePixel = 0

Content.ZIndex = 502
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")

ContentCorner.CornerRadius =
    UDim.new(0, 9)

ContentCorner.Parent = Content

--==================================================
-- CONTENT TITLE
--==================================================

local ContentTitle = Instance.new("TextLabel")

ContentTitle.Position =
    UDim2.new(0, 14, 0, 10)

ContentTitle.Size =
    UDim2.new(1, -28, 0, 25)

ContentTitle.BackgroundTransparency = 1

ContentTitle.Text = "Principal"

ContentTitle.TextColor3 =
    Color3.fromRGB(240, 243, 250)

ContentTitle.TextSize = 17
ContentTitle.Font = Enum.Font.GothamBold

ContentTitle.TextXAlignment =
    Enum.TextXAlignment.Left

ContentTitle.ZIndex = 503
ContentTitle.Parent = Content

--==================================================
-- CONTENT SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")

Scroll.Name = "ContentScroll"

Scroll.Position =
    UDim2.new(0, 10, 0, 42)

Scroll.Size =
    UDim2.new(1, -20, 1, -52)

Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0

Scroll.ScrollBarThickness = 5

Scroll.ScrollBarImageColor3 =
    GetAccent()

Scroll.AutomaticCanvasSize =
    Enum.AutomaticSize.Y

Scroll.ScrollingDirection =
    Enum.ScrollingDirection.Y

Scroll.ZIndex = 503
Scroll.Parent = Content

local ScrollPadding = Instance.new("UIPadding")

ScrollPadding.PaddingBottom =
    UDim.new(0, 6)

ScrollPadding.Parent = Scroll

local ScrollLayout = Instance.new("UIListLayout")

ScrollLayout.Padding =
    UDim.new(0, 5)

ScrollLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

ScrollLayout.Parent = Scroll

--==================================================
-- COPY
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
-- CLEAR CONTENT
--==================================================

local function ClearContent()

    for _, Object in ipairs(Scroll:GetChildren()) do

        if not Object:IsA("UIListLayout")
        and not Object:IsA("UIPadding") then

            Object:Destroy()

        end

    end

end

--==================================================
-- SOUND CARD
--==================================================

local function CreateSoundCard(Index, Data)

    local Name = Data[1]
    local ID = Data[2]

    local Card = Instance.new("Frame")

    Card.Name = "Sound_" .. Index

    Card.Size =
        UDim2.new(1, -5, 0, 48)

    Card.BackgroundColor3 =
        Color3.fromRGB(24, 28, 40)

    Card.BorderSizePixel = 0

    Card.LayoutOrder = Index

    Card.ZIndex = 504
    Card.Parent = Scroll

    local CardCorner = Instance.new("UICorner")

    CardCorner.CornerRadius =
        UDim.new(0, 8)

    CardCorner.Parent = Card

    -- NAME

    local NameLabel =
        Instance.new("TextLabel")

    NameLabel.Position =
        UDim2.new(0, 12, 0, 5)

    NameLabel.Size =
        UDim2.new(1, -90, 0, 18)

    NameLabel.BackgroundTransparency = 1

    NameLabel.Text = Name

    NameLabel.TextColor3 =
        Color3.fromRGB(235, 238, 245)

    NameLabel.TextSize = 12
    NameLabel.Font =
        Enum.Font.GothamMedium

    NameLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    NameLabel.TextTruncate =
        Enum.TextTruncate.AtEnd

    NameLabel.ZIndex = 505
    NameLabel.Parent = Card

    -- ID

    local IDLabel =
        Instance.new("TextLabel")

    IDLabel.Position =
        UDim2.new(0, 12, 0, 25)

    IDLabel.Size =
        UDim2.new(1, -90, 0, 16)

    IDLabel.BackgroundTransparency = 1

    IDLabel.Text = ID

    IDLabel.TextColor3 =
        Color3.fromRGB(135, 145, 165)

    IDLabel.TextSize = 10
    IDLabel.Font = Enum.Font.Code

    IDLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    IDLabel.ZIndex = 505
    IDLabel.Parent = Card

    -- COPY

    local CopyButton =
        Instance.new("TextButton")

    CopyButton.Size =
        UDim2.new(0, 55, 0, 28)

    CopyButton.Position =
        UDim2.new(1, -65, 0.5, -14)

    CopyButton.BackgroundColor3 =
        GetAccent()

    CopyButton.BorderSizePixel = 0

    CopyButton.Text = "Copy"

    CopyButton.TextColor3 =
        Color3.fromRGB(255, 255, 255)

    CopyButton.TextSize = 10
    CopyButton.Font =
        Enum.Font.GothamBold

    CopyButton.AutoButtonColor = false

    CopyButton.ZIndex = 506
    CopyButton.Parent = Card

    local CopyCorner =
        Instance.new("UICorner")

    CopyCorner.CornerRadius =
        UDim.new(0, 6)

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
-- SHOW CATEGORY
--==================================================

local function ShowCategory(CategoryName)

    ClearContent()

    ContentTitle.Text = CategoryName

    local Category =
        Sounds[CategoryName]

    if not Category then
        return
    end

    for Index, Data in ipairs(Category) do

        CreateSoundCard(
            Index,
            Data
        )

    end

end

--==================================================
-- CATEGORY BUTTON
--==================================================

local SelectedButton = nil

local function CreateCategoryButton(
    CategoryName,
    Order
)

    local Button =
        Instance.new("TextButton")

    Button.Name = CategoryName

    Button.Size =
        UDim2.new(1, 0, 0, 38)

    Button.BackgroundColor3 =
        Color3.fromRGB(20, 24, 35)

    Button.BorderSizePixel = 0

    Button.Text =
        "📁  " .. CategoryName

    Button.TextColor3 =
        Color3.fromRGB(180, 187, 205)

    Button.TextSize = 11

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor = false

    Button.LayoutOrder = Order

    Button.ZIndex = 503
    Button.Parent = Sidebar

    local ButtonPadding =
        Instance.new("UIPadding")

    ButtonPadding.PaddingLeft =
        UDim.new(0, 10)

    ButtonPadding.Parent = Button

    local ButtonCorner =
        Instance.new("UICorner")

    ButtonCorner.CornerRadius =
        UDim.new(0, 7)

    ButtonCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()

        if SelectedButton then

            SelectedButton.BackgroundColor3 =
                Color3.fromRGB(20, 24, 35)

            SelectedButton.TextColor3 =
                Color3.fromRGB(180, 187, 205)

        end

        SelectedButton = Button

        Button.BackgroundColor3 =
            GetAccent()

        Button.TextColor3 =
            Color3.fromRGB(255, 255, 255)

        ShowCategory(CategoryName)

    end)

    return Button

end

--==================================================
-- SOUND CATEGORIES
--==================================================

local CategoryButtons = {}

local CategoryIndex = 0

for CategoryName in pairs(Sounds) do

    CategoryIndex += 1

    local Button =
        CreateCategoryButton(
            CategoryName,
            CategoryIndex
        )

    CategoryButtons[CategoryName] =
        Button

end

--==================================================
-- CONFIGURATION CATEGORY
--==================================================

local ConfigButton =
    CreateCategoryButton(
        "Configuração",
        CategoryIndex + 1
    )

ConfigButton.MouseButton1Click:Connect(function()

    ClearContent()

    ContentTitle.Text =
        "Configuração"

    --==================================================
    -- CONFIG TOGGLE
    --==================================================

    local function CreateConfigToggle(
        Name,
        GetValue,
        SetValue,
        Order
    )

        local Button =
            Instance.new("TextButton")

        Button.Name =
            Name

        Button.Size =
            UDim2.new(1, -5, 0, 45)

        Button.BackgroundColor3 =
            Color3.fromRGB(24, 28, 40)

        Button.BorderSizePixel = 0

        Button.Text =
            Name .. ": " .. tostring(GetValue())

        Button.TextColor3 =
            Color3.fromRGB(235, 238, 245)

        Button.TextSize = 12

        Button.Font =
            Enum.Font.GothamMedium

        Button.TextXAlignment =
            Enum.TextXAlignment.Left

        Button.AutoButtonColor = false

        Button.LayoutOrder =
            Order

        Button.ZIndex = 504
        Button.Parent = Scroll

        local Padding =
            Instance.new("UIPadding")

        Padding.PaddingLeft =
            UDim.new(0, 12)

        Padding.Parent = Button

        local Corner =
            Instance.new("UICorner")

        Corner.CornerRadius =
            UDim.new(0, 8)

        Corner.Parent = Button

        Button.MouseButton1Click:Connect(function()

            local NewValue =
                not GetValue()

            SetValue(NewValue)

            Button.Text =
                Name .. ": " .. tostring(NewValue)

        end)

    end

    --==================================================
    -- SHOW LOGO
    --==================================================

    CreateConfigToggle(

        "Mostrar Logo",

        function()
            return Config.UI.ShowLogo
        end,

        function(Value)

            Config.UI.ShowLogo =
                Value

            LogoButton.Visible =
                Value

        end,

        1

    )

    --==================================================
    -- LOGO DRAGGABLE
    --==================================================

    CreateConfigToggle(

        "Logo Arrastável",

        function()
            return Config.UI.LogoDraggable
        end,

        function(Value)

            Config.UI.LogoDraggable =
                Value

        end,

        2

    )

    --==================================================
    -- MAIN MENU DRAGGABLE
    --==================================================

    CreateConfigToggle(

        "Menu Arrastável",

        function()
            return Config.UI.MainMenuDraggable
        end,

        function(Value)

            Config.UI.MainMenuDraggable =
                Value

        end,

        3

    )

end)

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

    if Config.UI.ShowLogo then
        LogoButton.Visible = true
    end

end)

--==================================================
-- DEFAULT CATEGORY
--==================================================

if Sounds["Principal"] then

    ShowCategory("Principal")

    local PrincipalButton =
        CategoryButtons["Principal"]

    if PrincipalButton then

        SelectedButton =
            PrincipalButton

        PrincipalButton.BackgroundColor3 =
            GetAccent()

        PrincipalButton.TextColor3 =
            Color3.fromRGB(255, 255, 255)

    end

end

--==================================================
-- FINAL
--==================================================

print("💥 Rimuru Hub carregado.")

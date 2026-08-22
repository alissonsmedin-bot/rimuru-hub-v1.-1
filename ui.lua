--// 💥 RIMURU HUB
--// UI System
--// PREMIUM NEON UI
--// TRUE PERIMETER SNAKE
--// THIN LINE BORDER FLOW
--// ROUNDED CORNERS
--// NATURAL PULSE
--// SOFT GLOW
--// CONTAINED BORDER
--// SAFE THEME INTEGRATION
--// BLACKOUT COMPATIBLE

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local UIS =
    game:GetService("UserInputService")

local TweenService =
    game:GetService("TweenService")

local RunService =
    game:GetService("RunService")

--==================================================
-- UI MODULE
--==================================================

local UI = {}

--==================================================
-- MENU ANIMATION
--==================================================

local OPEN_TIME =
    0.24

local CLOSE_TIME =
    0.18

local OPEN_SCALE =
    0.94

local CLOSE_SCALE =
    0.95

local OPEN_OFFSET_Y =
    8

local CLOSE_OFFSET_Y =
    7

--==================================================
-- ROUNDED UI
--==================================================

local CORNER_RADIUS =
    14

local SMALL_CORNER_RADIUS =
    10

--==================================================
-- BORDER
--==================================================

local BORDER_THICKNESS =
    1.35

local SNAKE_THICKNESS =
    2

--==================================================
-- SNAKE
--==================================================

-- Quantidade de segmentos usados para desenhar
-- a linha ao redor da interface.

local SNAKE_SEGMENTS =
    128

-- Quantos segmentos ficam iluminados ao mesmo tempo.

local SNAKE_LENGTH =
    17

-- Velocidade do deslocamento.

local SNAKE_SPEED =
    42

--==================================================
-- GLOW
--==================================================

local GLOW_THICKNESS =
    7

local GLOW_MIN_TRANSPARENCY =
    0.84

local GLOW_MAX_TRANSPARENCY =
    0.95

--==================================================
-- SAFE THEME VALUE
--==================================================

local function ThemeColor(
    Theme,
    Key,
    Fallback
)

    if Theme
    and Theme[Key] ~= nil then

        return Theme[Key]

    end

    return Fallback

end

--==================================================
-- GET THEME NAME
--==================================================

local function GetThemeName(
    Theme
)

    if not Theme then
        return ""
    end

    if Theme.GetName then

        local Success,
            Result =
            pcall(
                function()

                    return Theme:GetName()

                end
            )

        if Success
        and Result then

            return tostring(Result)

        end

    end

    if Theme.GetCurrentName then

        local Success,
            Result =
            pcall(
                function()

                    return Theme:GetCurrentName()

                end
            )

        if Success
        and Result then

            return tostring(Result)

        end

    end

    return ""

end

--==================================================
-- INIT
--==================================================

function UI:Init(Context)

    self.Context =
        Context

    self.Player =
        Context.Player
        or Players.LocalPlayer

    self.PlayerGui =
        Context.PlayerGui
        or self.Player:WaitForChild(
            "PlayerGui"
        )

    self.Config =
        Context.Config

    self.Theme =
        Context.Theme

    self.AnimationBusy =
        false

    self.AnimationToken =
        0

    self.NeonConnection =
        nil

    self.NeonTime =
        0

    self.SnakePosition =
        0

    self.SnakeParts =
        {}

    self:Create()

end

--==================================================
-- REMOVE OLD GUI
--==================================================

function UI:RemoveOld()

    pcall(function()

        local Old =
            self.PlayerGui:FindFirstChild(
                "RimuruHub"
            )

        if Old then

            Old:Destroy()

        end

    end)

end

--==================================================
-- CREATE
--==================================================

function UI:Create()

    self:RemoveOld()

    if not self.Theme then

        warn(
            "❌ Rimuru Hub UI: Theme não encontrado."
        )

        return

    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then

        warn(
            "❌ Rimuru Hub UI: tema inválido."
        )

        return

    end

    --==================================================
    -- SCREEN GUI
    --==================================================

    local Gui =
        Instance.new("ScreenGui")

    Gui.Name =
        "RimuruHub"

    Gui.ResetOnSpawn =
        false

    Gui.IgnoreGuiInset =
        true

    Gui.ZIndexBehavior =
        Enum.ZIndexBehavior.Global

    Gui.DisplayOrder =
        999999

    Gui.Parent =
        self.PlayerGui

    self.Gui =
        Gui

    --==================================================
    -- OUTER GLOW
    --==================================================

    -- O glow agora fica FORA do Main.
    -- Assim ele não é cortado pelo ClipsDescendants.

    local OuterGlow =
        Instance.new("Frame")

    OuterGlow.Name =
        "OuterGlow"

    OuterGlow.Size =
        UDim2.new(
            0,
            600,
            0,
            400
        )

    OuterGlow.Position =
        UDim2.new(
            0.5,
            -300,
            0.5,
            -200
        )

    OuterGlow.BackgroundTransparency =
        1

    OuterGlow.BorderSizePixel =
        0

    OuterGlow.ZIndex =
        490

    OuterGlow.Parent =
        Gui

    local OuterGlowCorner =
        Instance.new("UICorner")

    OuterGlowCorner.CornerRadius =
        UDim.new(
            0,
            CORNER_RADIUS
        )

    OuterGlowCorner.Parent =
        OuterGlow

    local OuterGlowStroke =
        Instance.new("UIStroke")

    OuterGlowStroke.Name =
        "OuterGlowStroke"

    OuterGlowStroke.Color =
        self.Theme:GetGlowColor()

    OuterGlowStroke.Thickness =
        GLOW_THICKNESS

    OuterGlowStroke.Transparency =
        0.92

    OuterGlowStroke.Parent =
        OuterGlow

    self.OuterGlow =
        OuterGlow

    self.OuterGlowStroke =
        OuterGlowStroke

    --==================================================
    -- MAIN
    --==================================================

    local Main =
        Instance.new("Frame")

    Main.Name =
        "Main"

    Main.Size =
        UDim2.new(
            0,
            600,
            0,
            400
        )

    Main.Position =
        UDim2.new(
            0.5,
            -300,
            0.5,
            -200
        )

    Main.BackgroundColor3 =
        ThemeColor(
            CurrentTheme,
            "Main",
            CurrentTheme.Background
                or Color3.fromRGB(
                    10,
                    10,
                    15
                )
        )

    Main.BackgroundTransparency =
        0.10

    Main.BorderSizePixel =
        0

    Main.Visible =
        false

    Main.ZIndex =
        500

    Main.ClipsDescendants =
        true

    Main.Parent =
        Gui

    self.Main =
        Main

    self.OriginalPosition =
        Main.Position

    self.OriginalSize =
        Main.Size

    --==================================================
    -- SCALE
    --==================================================

    local MainScale =
        Instance.new("UIScale")

    MainScale.Name =
        "MenuScale"

    MainScale.Scale =
        1

    MainScale.Parent =
        Main

    self.MainScale =
        MainScale

    --==================================================
    -- MAIN CORNER
    --==================================================

    local MainCorner =
        Instance.new("UICorner")

    MainCorner.CornerRadius =
        UDim.new(
            0,
            CORNER_RADIUS
        )

    MainCorner.Parent =
        Main

    self.MainCorner =
        MainCorner

    --==================================================
    -- DARK BASE BORDER
    --==================================================

    local MainStroke =
        Instance.new("UIStroke")

    MainStroke.Name =
        "BaseBorder"

    MainStroke.Color =
        self.Theme:GetAccent()

    MainStroke.Thickness =
        BORDER_THICKNESS

    MainStroke.Transparency =
        0.32

    MainStroke.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    MainStroke.Parent =
        Main

    self.MainStroke =
        MainStroke

    --==================================================
    -- SNAKE CONTAINER
    --==================================================

    local Flow =
        Instance.new("Frame")

    Flow.Name =
        "NeonFlow"

    Flow.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Flow.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Flow.BackgroundTransparency =
        1

    Flow.BorderSizePixel =
        0

    Flow.ZIndex =
        501

    Flow.ClipsDescendants =
        true

    Flow.Parent =
        Main

    local FlowCorner =
        Instance.new("UICorner")

    FlowCorner.CornerRadius =
        UDim.new(
            0,
            CORNER_RADIUS
        )

    FlowCorner.Parent =
        Flow

    self.Flow =
        Flow

    --==================================================
    -- CREATE SNAKE PARTS
    --==================================================

    self:CreateSnakeParts()

    --==================================================
    -- BACKGROUND
    --==================================================

    local Background =
        Instance.new("ImageLabel")

    Background.Name =
        "ThemeBackground"

    Background.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Background.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Background.BackgroundTransparency =
        1

    Background.BorderSizePixel =
        0

    Background.ScaleType =
        Enum.ScaleType.Crop

    Background.ImageTransparency =
        self.Theme:GetBackgroundTransparency()

    Background.ZIndex =
        500

    Background.Visible =
        false

    Background.Parent =
        Main

    local BackgroundCorner =
        Instance.new("UICorner")

    BackgroundCorner.CornerRadius =
        UDim.new(
            0,
            CORNER_RADIUS
        )

    BackgroundCorner.Parent =
        Background

    self.Background =
        Background

    --==================================================
    -- HEADER
    --==================================================

    local Header =
        Instance.new("Frame")

    Header.Name =
        "Header"

    Header.Size =
        UDim2.new(
            1,
            0,
            0,
            58
        )

    Header.BackgroundTransparency =
        1

    Header.ZIndex =
        502

    Header.Parent =
        Main

    self.Header =
        Header

    --==================================================
    -- HEADER LOGO
    --==================================================

    local HeaderLogo =
        Instance.new("ImageLabel")

    HeaderLogo.Name =
        "HeaderLogo"

    HeaderLogo.Size =
        UDim2.new(
            0,
            40,
            0,
            40
        )

    HeaderLogo.Position =
        UDim2.new(
            0,
            10,
            0,
            8
        )

    HeaderLogo.BackgroundTransparency =
        1

    HeaderLogo.Image =
        "rbxassetid://6691708227"

    HeaderLogo.ScaleType =
        Enum.ScaleType.Fit

    HeaderLogo.ZIndex =
        502

    HeaderLogo.Parent =
        Header

    self.HeaderLogo =
        HeaderLogo

    --==================================================
    -- LOGO STROKE
    --==================================================

    local LogoStroke =
        Instance.new("UIStroke")

    LogoStroke.Name =
        "LogoBorder"

    LogoStroke.Color =
        self.Theme:GetLogoBorder()

    LogoStroke.Thickness =
        1.2

    LogoStroke.Transparency =
        0.2

    LogoStroke.Parent =
        HeaderLogo

    self.LogoStroke =
        LogoStroke

    --==================================================
    -- TITLE
    --==================================================

    local Title =
        Instance.new("TextLabel")

    Title.Name =
        "Title"

    Title.Position =
        UDim2.new(
            0,
            60,
            0,
            7
        )

    Title.Size =
        UDim2.new(
            1,
            -105,
            0,
            25
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "Rimuru Hub"

    Title.TextColor3 =
        CurrentTheme.Text

    Title.TextSize =
        19

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        502

    Title.Parent =
        Header

    self.Title =
        Title

    --==================================================
    -- SUBTITLE
    --==================================================

    local Subtitle =
        Instance.new("TextLabel")

    Subtitle.Name =
        "Subtitle"

    Subtitle.Position =
        UDim2.new(
            0,
            61,
            0,
            31
        )

    Subtitle.Size =
        UDim2.new(
            1,
            -75,
            0,
            18
        )

    Subtitle.BackgroundTransparency =
        1

    Subtitle.Text =
        "Sound Library"

    Subtitle.TextColor3 =
        CurrentTheme.SubText

    Subtitle.TextSize =
        11

    Subtitle.Font =
        Enum.Font.Gotham

    Subtitle.TextXAlignment =
        Enum.TextXAlignment.Left

    Subtitle.ZIndex =
        502

    Subtitle.Parent =
        Header

    self.Subtitle =
        Subtitle

    --==================================================
    -- CLOSE
    --==================================================

    local Close =
        Instance.new("TextButton")

    Close.Name =
        "Close"

    Close.Size =
        UDim2.new(
            0,
            30,
            0,
            30
        )

    Close.Position =
        UDim2.new(
            1,
            -38,
            0,
            14
        )

    Close.BackgroundColor3 =
        ThemeColor(
            CurrentTheme,
            "Close",
            CurrentTheme.Button
                or CurrentTheme.Card
                or Color3.fromRGB(
                    30,
                    30,
                    30
                )
        )

    Close.BorderSizePixel =
        0

    Close.Text =
        "X"

    Close.TextColor3 =
        CurrentTheme.Text

    Close.TextSize =
        12

    Close.Font =
        Enum.Font.GothamBold

    Close.AutoButtonColor =
        false

    Close.ZIndex =
        503

    Close.Parent =
        Header

    local CloseCorner =
        Instance.new("UICorner")

    CloseCorner.CornerRadius =
        UDim.new(
            0,
            SMALL_CORNER_RADIUS
        )

    CloseCorner.Parent =
        Close

    local CloseStroke =
        Instance.new("UIStroke")

    CloseStroke.Color =
        self.Theme:GetAccent()

    CloseStroke.Thickness =
        1

    CloseStroke.Transparency =
        0.45

    CloseStroke.Parent =
        Close

    self.Close =
        Close

    self.CloseStroke =
        CloseStroke

    --==================================================
    -- SIDEBAR
    --==================================================

    local Sidebar =
        Instance.new("Frame")

    Sidebar.Name =
        "Sidebar"

    Sidebar.Position =
        UDim2.new(
            0,
            10,
            0,
            65
        )

    Sidebar.Size =
        UDim2.new(
            0,
            165,
            1,
            -75
        )

    Sidebar.BackgroundColor3 =
        ThemeColor(
            CurrentTheme,
            "Sidebar",
            CurrentTheme.Content
                or CurrentTheme.Background
                or Color3.fromRGB(
                    15,
                    15,
                    20
                )
        )

    Sidebar.BackgroundTransparency =
        0.10

    Sidebar.BorderSizePixel =
        0

    Sidebar.ZIndex =
        502

    Sidebar.Parent =
        Main

    local SidebarCorner =
        Instance.new("UICorner")

    SidebarCorner.CornerRadius =
        UDim.new(
            0,
            11
        )

    SidebarCorner.Parent =
        Sidebar

    local SidebarStroke =
        Instance.new("UIStroke")

    SidebarStroke.Color =
        self.Theme:GetAccent()

    SidebarStroke.Thickness =
        1

    SidebarStroke.Transparency =
        0.72

    SidebarStroke.Parent =
        Sidebar

    local SidebarPadding =
        Instance.new("UIPadding")

    SidebarPadding.PaddingTop =
        UDim.new(
            0,
            8
        )

    SidebarPadding.PaddingLeft =
        UDim.new(
            0,
            7
        )

    SidebarPadding.PaddingRight =
        UDim.new(
            0,
            7
        )

    SidebarPadding.Parent =
        Sidebar

    local SidebarLayout =
        Instance.new("UIListLayout")

    SidebarLayout.Padding =
        UDim.new(
            0,
            5
        )

    SidebarLayout.SortOrder =
        Enum.SortOrder.LayoutOrder

    SidebarLayout.Parent =
        Sidebar

    self.Sidebar =
        Sidebar

    self.SidebarStroke =
        SidebarStroke

    --==================================================
    -- CONTENT
    --==================================================

    local Content =
        Instance.new("Frame")

    Content.Name =
        "Content"

    Content.Position =
        UDim2.new(
            0,
            185,
            0,
            65
        )

    Content.Size =
        UDim2.new(
            1,
            -195,
            1,
            -75
        )

    Content.BackgroundColor3 =
        CurrentTheme.Content
        or CurrentTheme.Background
        or Color3.fromRGB(
            15,
            15,
            20
        )

    Content.BackgroundTransparency =
        0.10

    Content.BorderSizePixel =
        0

    Content.ZIndex =
        502

    Content.Parent =
        Main

    local ContentCorner =
        Instance.new("UICorner")

    ContentCorner.CornerRadius =
        UDim.new(
            0,
            11
        )

    ContentCorner.Parent =
        Content

    local ContentStroke =
        Instance.new("UIStroke")

    ContentStroke.Color =
        self.Theme:GetAccent()

    ContentStroke.Thickness =
        1

    ContentStroke.Transparency =
        0.72

    ContentStroke.Parent =
        Content

    self.Content =
        Content

    self.ContentStroke =
        ContentStroke

    --==================================================
    -- CONTENT TITLE
    --==================================================

    local ContentTitle =
        Instance.new("TextLabel")

    ContentTitle.Name =
        "ContentTitle"

    ContentTitle.Position =
        UDim2.new(
            0,
            14,
            0,
            10
        )

    ContentTitle.Size =
        UDim2.new(
            1,
            -28,
            0,
            25
        )

    ContentTitle.BackgroundTransparency =
        1

    ContentTitle.Text =
        "Principal"

    ContentTitle.TextColor3 =
        CurrentTheme.Text

    ContentTitle.TextSize =
        17

    ContentTitle.Font =
        Enum.Font.GothamBold

    ContentTitle.TextXAlignment =
        Enum.TextXAlignment.Left

    ContentTitle.ZIndex =
        503

    ContentTitle.Parent =
        Content

    self.ContentTitle =
        ContentTitle

    --==================================================
    -- SCROLL
    --==================================================

    local Scroll =
        Instance.new("ScrollingFrame")

    Scroll.Name =
        "ContentScroll"

    Scroll.Position =
        UDim2.new(
            0,
            10,
            0,
            42
        )

    Scroll.Size =
        UDim2.new(
            1,
            -20,
            1,
            -52
        )

    Scroll.BackgroundTransparency =
        1

    Scroll.BorderSizePixel =
        0

    Scroll.ScrollBarThickness =
        5

    Scroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    Scroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scroll.ZIndex =
        503

    Scroll.Parent =
        Content

    local ScrollPadding =
        Instance.new("UIPadding")

    ScrollPadding.PaddingBottom =
        UDim.new(
            0,
            6
        )

    ScrollPadding.Parent =
        Scroll

    local ScrollLayout =
        Instance.new("UIListLayout")

    ScrollLayout.Padding =
        UDim.new(
            0,
            5
        )

    ScrollLayout.SortOrder =
        Enum.SortOrder.LayoutOrder

    ScrollLayout.Parent =
        Scroll

    self.Scroll =
        Scroll

    --==================================================
    -- CLOSE EVENT
    --==================================================

    Close.MouseButton1Click:Connect(

        function()

            self:SetVisibleAnimated(
                false
            )

        end

    )

    --==================================================
    -- DRAG
    --==================================================

    self:SetupDrag()

    --==================================================
    -- START NEON
    --==================================================

    self:StartNeonAnimation()

end

--==================================================
-- CREATE SNAKE PARTS
--==================================================

function UI:CreateSnakeParts()

    if not self.Flow then
        return
    end

    for _, Part in
        ipairs(self.SnakeParts) do

        if Part then

            Part:Destroy()

        end

    end

    self.SnakeParts =
        {}

    for Index = 1, SNAKE_SEGMENTS do

        local Segment =
            Instance.new("Frame")

        Segment.Name =
            "SnakeSegment_" .. Index

        Segment.AnchorPoint =
            Vector2.new(
                0.5,
                0.5
            )

        Segment.BackgroundColor3 =
            self.Theme:GetAccent()

        Segment.BackgroundTransparency =
            1

        Segment.BorderSizePixel =
            0

        Segment.Size =
            UDim2.new(
                0,
                8,
                0,
                SNAKE_THICKNESS
            )

        Segment.ZIndex =
            502

        Segment.Parent =
            self.Flow

        self.SnakeParts[Index] =
            Segment

    end

end

--==================================================
-- ROUNDED RECTANGLE PATH
--==================================================

function UI:GetBorderPoint(
    Index,
    Width,
    Height
)

    local Radius =
        math.min(
            CORNER_RADIUS,
            math.min(
                Width,
                Height
            ) * 0.5
        )

    local StraightWidth =
        Width
        - Radius * 2

    local StraightHeight =
        Height
        - Radius * 2

    local CornerLength =
        math.pi
        * Radius
        * 0.5

    local TotalLength =
        (
            StraightWidth
            * 2
        )
        +
        (
            StraightHeight
            * 2
        )
        +
        (
            CornerLength
            * 4
        )

    local Distance =
        (
            Index
            /
            SNAKE_SEGMENTS
        )
        *
        TotalLength

    --==================================================
    -- TOP
    --==================================================

    if Distance <= StraightWidth then

        return
            Distance + Radius,
            0,
            0

    end

    Distance -=
        StraightWidth

    --==================================================
    -- TOP RIGHT CORNER
    --==================================================

    if Distance <= CornerLength then

        local T =
            Distance
            /
            CornerLength

        local Angle =
            -math.pi / 2
            +
            T
            *
            math.pi / 2

        local CX =
            Width - Radius

        local CY =
            Radius

        local X =
            CX
            +
            math.cos(Angle)
            *
            Radius

        local Y =
            CY
            +
            math.sin(Angle)
            *
            Radius

        local DX =
            -math.sin(Angle)

        local DY =
            math.cos(Angle)

        return X, Y,
            math.deg(
                math.atan2(
                    DY,
                    DX
                )
            )

    end

    Distance -=
        CornerLength

    --==================================================
    -- RIGHT
    --==================================================

    if Distance <= StraightHeight then

        return
            Width,
            Distance + Radius,
            90

    end

    Distance -=
        StraightHeight

    --==================================================
    -- BOTTOM RIGHT
    --==================================================

    if Distance <= CornerLength then

        local T =
            Distance
            /
            CornerLength

        local Angle =
            0
            +
            T
            *
            math.pi / 2

        local CX =
            Width - Radius

        local CY =
            Height - Radius

        local X =
            CX
            +
            math.cos(Angle)
            *
            Radius

        local Y =
            CY
            +
            math.sin(Angle)
            *
            Radius

        local DX =
            -math.sin(Angle)

        local DY =
            math.cos(Angle)

        return X, Y,
            math.deg(
                math.atan2(
                    DY,
                    DX
                )
            )

    end

    Distance -=
        CornerLength

    --==================================================
    -- BOTTOM
    --==================================================

    if Distance <= StraightWidth then

        return
            Width
            -
            Radius
            -
            Distance,
            Height,
            180

    end

    Distance -=
        StraightWidth

    --==================================================
    -- BOTTOM LEFT
    --==================================================

    if Distance <= CornerLength then

        local T =
            Distance
            /
            CornerLength

        local Angle =
            math.pi / 2
            +
            T
            *
            math.pi / 2

        local CX =
            Radius

        local CY =
            Height - Radius

        local X =
            CX
            +
            math.cos(Angle)
            *
            Radius

        local Y =
            CY
            +
            math.sin(Angle)
            *
            Radius

        local DX =
            -math.sin(Angle)

        local DY =
            math.cos(Angle)

        return X, Y,
            math.deg(
                math.atan2(
                    DY,
                    DX
                )
            )

    end

    Distance -=
        CornerLength

    --==================================================
    -- LEFT
    --==================================================

    if Distance <= StraightHeight then

        return
            0,
            Height
            -
            Radius
            -
            Distance,
            270

    end

    Distance -=
        StraightHeight

    --==================================================
    -- TOP LEFT
    --==================================================

    local T =
        math.clamp(
            Distance
            /
            CornerLength,
            0,
            1
        )

    local Angle =
        math.pi
        +
        T
        *
        math.pi / 2

    local CX =
        Radius

    local CY =
        Radius

    local X =
        CX
        +
        math.cos(Angle)
        *
        Radius

    local Y =
        CY
        +
        math.sin(Angle)
        *
        Radius

    local DX =
        -math.sin(Angle)

    local DY =
        math.cos(Angle)

    return X, Y,
        math.deg(
            math.atan2(
                DY,
                DX
            )
        )

end

--==================================================
-- SHOULD USE GLOW
--==================================================

function UI:ShouldUseGlow()

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return false
    end

    if CurrentTheme.GlowEnabled ~= nil then

        return
            CurrentTheme.GlowEnabled
            == true

    end

    local Name =
        string.lower(
            GetThemeName(
                self.Theme
            )
        )

    if string.find(
        Name,
        "rimuru dark",
        1,
        true
    )
    or string.find(
        Name,
        "blackout",
        1,
        true
    )
    or string.find(
        Name,
        "void",
        1,
        true
    ) then

        return true

    end

    return false

end

--==================================================
-- UPDATE SNAKE
--==================================================

function UI:UpdateSnake(
    DeltaTime,
    Accent,
    GlowEnabled,
    Pulse
)

    if not self.Flow then
        return
    end

    local Width =
        self.Flow.AbsoluteSize.X

    local Height =
        self.Flow.AbsoluteSize.Y

    if Width <= 0
    or Height <= 0 then

        return

    end

    self.SnakePosition +=
        SNAKE_SPEED
        *
        DeltaTime

    self.SnakePosition =
        self.SnakePosition
        %
        SNAKE_SEGMENTS

    for Index, Segment in
        ipairs(self.SnakeParts) do

        local Offset =
            (
                Index
                -
                self.SnakePosition
            )
            %
            SNAKE_SEGMENTS

        local Distance =
            math.min(
                Offset,
                SNAKE_SEGMENTS
                -
                Offset
            )

        --==================================================
        -- LINE TAIL
        --==================================================

        local Strength =
            0

        if Offset <= SNAKE_LENGTH then

            Strength =
                1
                -
                (
                    Offset
                    /
                    SNAKE_LENGTH
                )

        end

        --==================================================
        -- SOFT CURVE
        --==================================================

        Strength =
            Strength
            *
            Strength
            *
            (
                3
                -
                2
                *
                Strength
            )

        --==================================================
        -- BASE VISIBILITY
        --==================================================

        if not GlowEnabled then

            Strength *=
                0.48

        end

        local X,
            Y,
            Rotation =
            self:GetBorderPoint(
                Index - 1,
                Width,
                Height
            )

        Segment.Position =
            UDim2.new(
                0,
                X,
                0,
                Y
            )

        Segment.Rotation =
            Rotation

        --==================================================
        -- SEGMENT LENGTH
        --==================================================

        local SegmentLength =
            8

        if Strength > 0.01 then

            Segment.Size =
                UDim2.new(
                    0,
                    SegmentLength,
                    0,
                    SNAKE_THICKNESS
                )

        else

            Segment.Size =
                UDim2.new(
                    0,
                    5,
                    0,
                    SNAKE_THICKNESS
                )

        end

        --==================================================
        -- BRIGHTNESS
        --==================================================

        local BrightAccent =
            Accent:Lerp(
                Color3.new(
                    1,
                    1,
                    1
                ),
                0.18
                +
                (
                    Strength
                    * 0.32
                )
            )

        Segment.BackgroundColor3 =
            BrightAccent

        Segment.BackgroundTransparency =
            1
            -
            (
                Strength
                *
                (
                    0.78
                    +
                    Pulse
                    *
                    0.16
                )
            )

    end

end

--==================================================
-- START NEON ANIMATION
--==================================================

function UI:StartNeonAnimation()

    if self.NeonConnection then

        self.NeonConnection:Disconnect()

        self.NeonConnection =
            nil

    end

    self.NeonTime =
        0

    self.SnakePosition =
        0

    self.NeonConnection =
        RunService.RenderStepped:Connect(

            function(
                DeltaTime
            )

                if not self.Main
                or not self.Main.Parent then

                    return

                end

                if not self.Theme then
                    return
                end

                local Current =
                    self.Theme:GetCurrent()

                if not Current then
                    return
                end

                self.NeonTime +=
                    DeltaTime

                --==================================================
                -- COLORS
                --==================================================

                local Accent =
                    self.Theme:GetAccent()

                local GlowColor =
                    Accent

                if self.Theme.GetGlowColor then

                    local Success,
                        Result =
                        pcall(
                            function()

                                return self.Theme:GetGlowColor()

                            end
                        )

                    if Success
                    and Result then

                        GlowColor =
                            Result

                    end

                end

                --==================================================
                -- GLOW
                --==================================================

                local GlowEnabled =
                    self:ShouldUseGlow()

                --==================================================
                -- NATURAL PULSE
                --==================================================

                local Wave =
                    (
                        math.sin(
                            self.NeonTime
                            *
                            1.35
                        )
                        + 1
                    )
                    *
                    0.5

                local Pulse =
                    Wave
                    *
                    Wave
                    *
                    (
                        3
                        -
                        2
                        *
                        Wave
                    )

                if self.Theme.GetBorderPulse then

                    local Success,
                        Result =
                        pcall(
                            function()

                                return self.Theme:GetBorderPulse()

                            end
                        )

                    if Success
                    and type(Result)
                    == "number" then

                        Pulse =
                            math.clamp(
                                Result,
                                0,
                                1
                            )

                    end

                end

                --==================================================
                -- BASE BORDER
                --==================================================

                if self.MainStroke then

                    self.MainStroke.Color =
                        Accent

                    -- A borda fica propositalmente
                    -- mais escura que a cobra.

                    if GlowEnabled then

                        self.MainStroke.Transparency =
                            0.32
                            -
                            (
                                Pulse
                                *
                                0.10
                            )

                        self.MainStroke.Thickness =
                            BORDER_THICKNESS

                    else

                        self.MainStroke.Transparency =
                            0.42

                        self.MainStroke.Thickness =
                            1.2

                    end

                end

                --==================================================
                -- OUTER GLOW
                --==================================================

                if self.OuterGlow then

                    self.OuterGlow.Position =
                        self.Main.Position

                    self.OuterGlow.Size =
                        self.Main.Size

                end

                if self.OuterGlowStroke then

                    self.OuterGlowStroke.Color =
                        GlowColor

                    if GlowEnabled then

                        self.OuterGlowStroke.Transparency =
                            GLOW_MAX_TRANSPARENCY
                            -
                            (
                                Pulse
                                *
                                (
                                    GLOW_MAX_TRANSPARENCY
                                    -
                                    GLOW_MIN_TRANSPARENCY
                                )
                            )

                        self.OuterGlowStroke.Thickness =
                            GLOW_THICKNESS
                            +
                            (
                                Pulse
                                * 2
                            )

                    else

                        self.OuterGlowStroke.Transparency =
                            1

                    end

                end

                --==================================================
                -- SNAKE
                --==================================================

                self:UpdateSnake(
                    DeltaTime,
                    Accent,
                    GlowEnabled,
                    Pulse
                )

                --==================================================
                -- CLOSE BUTTON
                --==================================================

                if self.CloseStroke then

                    self.CloseStroke.Color =
                        Accent

                    self.CloseStroke.Transparency =
                        0.38
                        -
                        (
                            Pulse
                            *
                            0.08
                        )

                end

                --==================================================
                -- SIDEBAR
                --==================================================

                if self.SidebarStroke then

                    self.SidebarStroke.Color =
                        Accent

                    self.SidebarStroke.Transparency =
                        0.72
                        -
                        (
                            Pulse
                            *
                            0.08
                        )

                end

                --==================================================
                -- CONTENT
                --==================================================

                if self.ContentStroke then

                    self.ContentStroke.Color =
                        Accent

                    self.ContentStroke.Transparency =
                        0.72
                        -
                        (
                            Pulse
                            *
                            0.08
                        )

                end

                --==================================================
                -- LOGO
                --==================================================

                if self.LogoStroke then

                    self.LogoStroke.Color =
                        self.Theme:GetLogoBorder()

                end

                --==================================================
                -- SCROLLBAR
                --==================================================

                if self.Scroll then

                    self.Scroll.ScrollBarImageColor3 =
                        Accent

                end

            end

        )

end

--==================================================
-- ANIMATION ENABLED
--==================================================

function UI:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    return
        self.Config.UI.Animation
        ~= false

end

--==================================================
-- CANCEL ANIMATION
--==================================================

function UI:CancelAnimation()

    self.AnimationToken +=
        1

    self.AnimationBusy =
        false

end

--==================================================
-- SET VISIBLE
--==================================================

function UI:SetVisible(
    Value
)

    if not self.Main then
        return
    end

    self:CancelAnimation()

    self.Main.Visible =
        Value

    if self.OuterGlow then

        self.OuterGlow.Visible =
            Value

    end

    if Value then

        self.MainScale.Scale =
            1

        self.Main.Position =
            self.OriginalPosition

        if self.OuterGlow then

            self.OuterGlow.Position =
                self.Main.Position

        end

    end

end

--==================================================
-- SET VISIBLE ANIMATED
--==================================================

function UI:SetVisibleAnimated(
    Value
)

    local Main =
        self.Main

    local Scale =
        self.MainScale

    if not Main
    or not Scale then

        return

    end

    if not self:IsAnimationEnabled() then

        self:SetVisible(
            Value
        )

        return

    end

    self:CancelAnimation()

    local Token =
        self.AnimationToken

    --==================================================
    -- OPEN
    --==================================================

    if Value then

        Main.Visible =
            true

        if self.OuterGlow then

            self.OuterGlow.Visible =
                true

        end

        Scale.Scale =
            OPEN_SCALE

        Main.Position =
            UDim2.new(

                self.OriginalPosition.X.Scale,

                self.OriginalPosition.X.Offset,

                self.OriginalPosition.Y.Scale,

                self.OriginalPosition.Y.Offset
                    + OPEN_OFFSET_Y

            )

        if self.OuterGlow then

            self.OuterGlow.Position =
                Main.Position

        end

        local Info =
            TweenInfo.new(

                OPEN_TIME,

                Enum.EasingStyle.Quint,

                Enum.EasingDirection.Out

            )

        local ScaleTween =
            TweenService:Create(

                Scale,

                Info,

                {
                    Scale = 1
                }

            )

        local PositionTween =
            TweenService:Create(

                Main,

                Info,

                {
                    Position =
                        self.OriginalPosition
                }

            )

        self.AnimationBusy =
            true

        ScaleTween:Play()

        PositionTween:Play()

        task.spawn(

            function()

                PositionTween.Completed:Wait()

                if self.AnimationToken ==
                    Token then

                    self.AnimationBusy =
                        false

                end

            end

        )

        return

    end

    --==================================================
    -- CLOSE
    --==================================================

    if not Main.Visible then
        return
    end

    local Info =
        TweenInfo.new(

            CLOSE_TIME,

            Enum.EasingStyle.Quint,

            Enum.EasingDirection.In

        )

    local ScaleTween =
        TweenService:Create(

            Scale,

            Info,

            {
                Scale = CLOSE_SCALE
            }

        )

    local PositionTween =
        TweenService:Create(

            Main,

            Info,

            {

                Position =
                    UDim2.new(

                        self.OriginalPosition.X.Scale,

                        self.OriginalPosition.X.Offset,

                        self.OriginalPosition.Y.Scale,

                        self.OriginalPosition.Y.Offset
                            + CLOSE_OFFSET_Y

                    )

            }

        )

    self.AnimationBusy =
        true

    ScaleTween:Play()

    PositionTween:Play()

    task.spawn(

        function()

            PositionTween.Completed:Wait()

            if self.AnimationToken ~=
                Token then

                return

            end

            Main.Visible =
                false

            if self.OuterGlow then

                self.OuterGlow.Visible =
                    false

            end

            Scale.Scale =
                1

            Main.Position =
                self.OriginalPosition

            self.AnimationBusy =
                false

        end

    )

end

--==================================================
-- TOGGLE
--==================================================

function UI:ToggleAnimated()

    if not self.Main then
        return
    end

    self:SetVisibleAnimated(

        not self.Main.Visible

    )

end

--==================================================
-- DRAG
--==================================================

function UI:SetupDrag()

    local Main =
        self.Main

    if not Main then
        return
    end

    local Dragging =
        false

    local DragStart
    local StartPosition

    Main.InputBegan:Connect(

        function(Input)

            if not self.Config
            or not self.Config.UI
            or not self.Config.UI.MainMenuDraggable then

                return

            end

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1

            or Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging =
                    true

                DragStart =
                    Input.Position

                StartPosition =
                    Main.Position

            end

        end

    )

    UIS.InputChanged:Connect(

        function(Input)

            if not Dragging then
                return
            end

            if Input.UserInputType ==
                Enum.UserInputType.MouseMovement

            or Input.UserInputType ==
                Enum.UserInputType.Touch then

                local Delta =
                    Input.Position
                    -
                    DragStart

                Main.Position =
                    UDim2.new(

                        StartPosition.X.Scale,

                        StartPosition.X.Offset
                            + Delta.X,

                        StartPosition.Y.Scale,

                        StartPosition.Y.Offset
                            + Delta.Y

                    )

            end

        end

    )

    UIS.InputEnded:Connect(

        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1

            or Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging =
                    false

            end

        end

    )

end

--==================================================
-- APPLY BACKGROUND
--==================================================

function UI:ApplyBackground()

    if not self.Background then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

    local Image =
        CurrentTheme.BackgroundImage

    self.Background.Visible =
        false

    self.Background.Image =
        ""

    if not Image
    or Image == "" then

        return

    end

    self.Background.Image =
        Image

    self.Background.ImageTransparency =
        CurrentTheme.BackgroundTransparency
        or 0.35

    self.Background.Visible =
        true

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    if not self.Theme then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

    --==================================================
    -- MAIN
    --==================================================

    if self.Main then

        self.Main.BackgroundColor3 =
            ThemeColor(

                CurrentTheme,

                "Main",

                CurrentTheme.Background
                    or Color3.fromRGB(
                        10,
                        10,
                        15
                    )

            )

    end

    --==================================================
    -- MAIN CORNER
    --==================================================

    if self.MainCorner then

        self.MainCorner.CornerRadius =
            UDim.new(
                0,
                CORNER_RADIUS
            )

    end

    --==================================================
    -- OUTER GLOW CORNER
    --==================================================

    if self.OuterGlow then

        local Corner =
            self.OuterGlow:FindFirstChildOfClass(
                "UICorner"
            )

        if Corner then

            Corner.CornerRadius =
                UDim.new(
                    0,
                    CORNER_RADIUS
                )

        end

    end

    --==================================================
    -- FLOW CORNER
    --==================================================

    if self.Flow then

        local Corner =
            self.Flow:FindFirstChildOfClass(
                "UICorner"
            )

        if Corner then

            Corner.CornerRadius =
                UDim.new(
                    0,
                    CORNER_RADIUS
                )

        end

    end

    --==================================================
    -- BACKGROUND
    --==================================================

    self:ApplyBackground()

    --==================================================
    -- BORDER
    --==================================================

    if self.MainStroke then

        self.MainStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- OUTER GLOW
    --==================================================

    if self.OuterGlowStroke then

        self.OuterGlowStroke.Color =
            self.Theme:GetGlowColor()

    end

    --==================================================
    -- SNAKE
    --==================================================

    for _, Segment in
        ipairs(self.SnakeParts) do

        Segment.BackgroundColor3 =
            self.Theme:GetAccent()

    end

    --==================================================
    -- LOGO
    --==================================================

    if self.LogoStroke then

        self.LogoStroke.Color =
            self.Theme:GetLogoBorder()

    end

    --==================================================
    -- TITLE
    --==================================================

    if self.Title then

        self.Title.TextColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- SUBTITLE
    --==================================================

    if self.Subtitle then

        self.Subtitle.TextColor3 =
            CurrentTheme.SubText

    end

    --==================================================
    -- CLOSE
    --==================================================

    if self.Close then

        self.Close.BackgroundColor3 =
            ThemeColor(

                CurrentTheme,

                "Close",

                CurrentTheme.Button
                    or CurrentTheme.Card
                    or Color3.fromRGB(
                        30,
                        30,
                        30
                    )

            )

        self.Close.TextColor3 =
            CurrentTheme.Text

    end

    if self.CloseStroke then

        self.CloseStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar then

        self.Sidebar.BackgroundColor3 =
            ThemeColor(

                CurrentTheme,

                "Sidebar",

                CurrentTheme.Content
                    or CurrentTheme.Background
                    or Color3.fromRGB(
                        15,
                        15,
                        20
                    )

            )

    end

    if self.SidebarStroke then

        self.SidebarStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- CONTENT
    --==================================================

    if self.Content then

        self.Content.BackgroundColor3 =
            CurrentTheme.Content
            or CurrentTheme.Background
            or Color3.fromRGB(
                15,
                15,
                20
            )

    end

    if self.ContentStroke then

        self.ContentStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- CONTENT TITLE
    --==================================================

    if self.ContentTitle then

        self.ContentTitle.TextColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- SCROLLBAR
    --==================================================

    if self.Scroll then

        self.Scroll.ScrollBarImageColor3 =
            self.Theme:GetAccent()

    end

end

--==================================================
-- DESTROY
--==================================================

function UI:Destroy()

    if self.NeonConnection then

        self.NeonConnection:Disconnect()

        self.NeonConnection =
            nil

    end

    self.SnakeParts =
        {}

    if self.Gui then

        self.Gui:Destroy()

        self.Gui =
            nil

    end

end

--==================================================
-- RETURN
--==================================================

return UI

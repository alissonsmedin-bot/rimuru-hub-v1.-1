--// 💥 RIMURU HUB
--// UI System
--// PREMIUM NEON UI
--// Animated Stable Version
--// Background Contained Inside Main
--// SAFE THEME INTEGRATION
--// NEON GLOW
--// BORDER SNAKE
--// RGB COMPATIBLE
--// BLACKOUT COMPATIBLE
--// CLEAN ANIMATION CONNECTIONS

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
-- ANIMATION CONFIG
--==================================================

local OPEN_TIME =
    0.22

local CLOSE_TIME =
    0.16

local OPEN_SCALE =
    0.94

local CLOSE_SCALE =
    0.94

local OPEN_OFFSET_Y =
    10

local CLOSE_OFFSET_Y =
    10

--==================================================
-- NEON CONFIG
--==================================================

local BORDER_THICKNESS =
    2

local GLOW_THICKNESS_1 =
    5

local GLOW_THICKNESS_2 =
    9

local SNAKE_THICKNESS =
    3

local SNAKE_LENGTH =
    0.16

local SNAKE_TAIL =
    0.075

--==================================================
-- SAFE THEME VALUE
--==================================================

local function ThemeColor(
    Theme,
    Key,
    Fallback
)

    if Theme
    and Theme[Key] then

        return Theme[Key]

    end

    return Fallback

end

--==================================================
-- CREATE CORNER
--==================================================

local function CreateCorner(
    Object,
    Radius
)

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            Radius
        )

    Corner.Parent =
        Object

    return Corner

end

--==================================================
-- CREATE BORDER PART
--==================================================

local function CreateBorderPart(
    Parent,
    Name,
    ZIndex
)

    local Part =
        Instance.new("Frame")

    Part.Name =
        Name

    Part.BackgroundTransparency =
        0

    Part.BorderSizePixel =
        0

    Part.ZIndex =
        ZIndex

    Part.Parent =
        Parent

    return Part

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

    self.RenderConnection =
        nil

    self:Create()

end

--==================================================
-- REMOVE OLD GUI
--==================================================

function UI:RemoveOld()

    if self.RenderConnection then

        self.RenderConnection:Disconnect()

        self.RenderConnection =
            nil

    end

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

    --==================================================
    -- IMPORTANT
    --==================================================
    -- O glow precisa poder sair alguns pixels
    -- da interface.

    Main.ClipsDescendants =
        false

    Main.Parent =
        Gui

    self.Main =
        Main

    self.OriginalPosition =
        Main.Position

    self.OriginalSize =
        Main.Size

    --==================================================
    -- MAIN SCALE
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
            12
        )

    MainCorner.Parent =
        Main

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
            12
        )

    BackgroundCorner.Parent =
        Background

    self.Background =
        Background

    --==================================================
    -- MAIN BORDER SYSTEM
    --==================================================

    local BorderFolder =
        Instance.new("Folder")

    BorderFolder.Name =
        "NeonBorder"

    BorderFolder.Parent =
        Main

    self.NeonBorder =
        BorderFolder

    --==================================================
    -- BASE BORDER
    --==================================================

    local BorderTop =
        CreateBorderPart(
            BorderFolder,
            "Top",
            506
        )

    local BorderRight =
        CreateBorderPart(
            BorderFolder,
            "Right",
            506
        )

    local BorderBottom =
        CreateBorderPart(
            BorderFolder,
            "Bottom",
            506
        )

    local BorderLeft =
        CreateBorderPart(
            BorderFolder,
            "Left",
            506
        )

    self.BorderParts = {

        Top = BorderTop,
        Right = BorderRight,
        Bottom = BorderBottom,
        Left = BorderLeft

    }

    --==================================================
    -- GLOW 1
    --==================================================

    local GlowFolder =
        Instance.new("Folder")

    GlowFolder.Name =
        "Glow"

    GlowFolder.Parent =
        Main

    self.GlowFolder =
        GlowFolder

    local GlowTop =
        CreateBorderPart(
            GlowFolder,
            "TopGlow",
            504
        )

    local GlowRight =
        CreateBorderPart(
            GlowFolder,
            "RightGlow",
            504
        )

    local GlowBottom =
        CreateBorderPart(
            GlowFolder,
            "BottomGlow",
            504
        )

    local GlowLeft =
        CreateBorderPart(
            GlowFolder,
            "LeftGlow",
            504
        )

    self.GlowParts = {

        Top = GlowTop,
        Right = GlowRight,
        Bottom = GlowBottom,
        Left = GlowLeft

    }

    --==================================================
    -- GLOW 2
    --==================================================

    local GlowFolder2 =
        Instance.new("Folder")

    GlowFolder2.Name =
        "GlowOuter"

    GlowFolder2.Parent =
        Main

    self.GlowFolder2 =
        GlowFolder2

    local GlowTop2 =
        CreateBorderPart(
            GlowFolder2,
            "TopGlowOuter",
            503
        )

    local GlowRight2 =
        CreateBorderPart(
            GlowFolder2,
            "RightGlowOuter",
            503
        )

    local GlowBottom2 =
        CreateBorderPart(
            GlowFolder2,
            "BottomGlowOuter",
            503
        )

    local GlowLeft2 =
        CreateBorderPart(
            GlowFolder2,
            "LeftGlowOuter",
            503
        )

    self.GlowParts2 = {

        Top = GlowTop2,
        Right = GlowRight2,
        Bottom = GlowBottom2,
        Left = GlowLeft2

    }

    --==================================================
    -- SNAKE
    --==================================================

    local SnakeFolder =
        Instance.new("Folder")

    SnakeFolder.Name =
        "BorderSnake"

    SnakeFolder.Parent =
        Main

    self.SnakeFolder =
        SnakeFolder

    --==================================================
    -- SNAKE GLOW
    --==================================================

    local SnakeGlow =
        CreateBorderPart(
            SnakeFolder,
            "SnakeGlow",
            507
        )

    self.SnakeGlow =
        SnakeGlow

    --==================================================
    -- SNAKE CORE
    --==================================================

    local SnakeCore =
        CreateBorderPart(
            SnakeFolder,
            "SnakeCore",
            508
        )

    self.SnakeCore =
        SnakeCore

    --==================================================
    -- SNAKE HEAD
    --==================================================

    local SnakeHead =
        CreateBorderPart(
            SnakeFolder,
            "SnakeHead",
            509
        )

    self.SnakeHead =
        SnakeHead

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
        501

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
    -- LOGO GLOW
    --==================================================

    local LogoGlow =
        Instance.new("UIStroke")

    LogoGlow.Name =
        "NeonGlow"

    LogoGlow.Color =
        self.Theme:GetLogoBorder()

    LogoGlow.Thickness =
        4

    LogoGlow.Transparency =
        0.55

    LogoGlow.Parent =
        HeaderLogo

    self.LogoGlow =
        LogoGlow

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
    -- TITLE STROKE
    --==================================================

    local TitleStroke =
        Instance.new("UIStroke")

    TitleStroke.Name =
        "NeonTextGlow"

    TitleStroke.Color =
        self.Theme:GetAccent()

    TitleStroke.Thickness =
        1.5

    TitleStroke.Transparency =
        0.55

    TitleStroke.Parent =
        Title

    self.TitleStroke =
        TitleStroke

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
            7
        )

    CloseCorner.Parent =
        Close

    local CloseStroke =
        Instance.new("UIStroke")

    CloseStroke.Name =
        "NeonStroke"

    CloseStroke.Color =
        self.Theme:GetAccent()

    CloseStroke.Thickness =
        1

    CloseStroke.Transparency =
        0.35

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
            9
        )

    SidebarCorner.Parent =
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

    --==================================================
    -- SIDEBAR GLOW
    --==================================================

    local SidebarStroke =
        Instance.new("UIStroke")

    SidebarStroke.Name =
        "NeonStroke"

    SidebarStroke.Color =
        self.Theme:GetAccent()

    SidebarStroke.Thickness =
        1

    SidebarStroke.Transparency =
        0.5

    SidebarStroke.Parent =
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
            9
        )

    ContentCorner.Parent =
        Content

    self.Content =
        Content

    --==================================================
    -- CONTENT STROKE
    --==================================================

    local ContentStroke =
        Instance.new("UIStroke")

    ContentStroke.Name =
        "NeonStroke"

    ContentStroke.Color =
        self.Theme:GetAccent()

    ContentStroke.Thickness =
        1

    ContentStroke.Transparency =
        0.55

    ContentStroke.Parent =
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
    -- CONTENT TITLE GLOW
    --==================================================

    local ContentTitleStroke =
        Instance.new("UIStroke")

    ContentTitleStroke.Name =
        "NeonTextGlow"

    ContentTitleStroke.Color =
        self.Theme:GetAccent()

    ContentTitleStroke.Thickness =
        1.25

    ContentTitleStroke.Transparency =
        0.6

    ContentTitleStroke.Parent =
        ContentTitle

    self.ContentTitleStroke =
        ContentTitleStroke

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
    -- APPLY INITIAL THEME
    --==================================================

    self:ApplyTheme()

    --==================================================
    -- START NEON ENGINE
    --==================================================

    self:StartNeonEngine()

end

--==================================================
-- ANIMATION ENABLED
--==================================================

function UI:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    return self.Config.UI.Animation ~= false

end

--==================================================
-- CANCEL ANIMATION
--==================================================

function UI:CancelAnimation()

    self.AnimationToken += 1

    self.AnimationBusy =
        false

end

--==================================================
-- SET VISIBLE
--==================================================

function UI:SetVisible(Value)

    if not self.Main then
        return
    end

    self:CancelAnimation()

    self.Main.Visible =
        Value

    if Value then

        self.MainScale.Scale =
            1

        self.Main.Position =
            self.OriginalPosition

    end

end

--==================================================
-- SET VISIBLE ANIMATED
--==================================================

function UI:SetVisibleAnimated(Value)

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

            Enum.EasingStyle.Quad,

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
                    Input.Position -
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
    -- BACKGROUND
    --==================================================

    self:ApplyBackground()

    --==================================================
    -- COLORS
    --==================================================

    local Accent =
        self.Theme:GetAccent()

    --==================================================
    -- MAIN BORDER
    --==================================================

    if self.BorderParts then

        for _, Part in
            pairs(self.BorderParts) do

            Part.BackgroundColor3 =
                Accent

        end

    end

    --==================================================
    -- GLOW
    --==================================================

    if self.GlowParts then

        for _, Part in
            pairs(self.GlowParts) do

            Part.BackgroundColor3 =
                Accent

        end

    end

    if self.GlowParts2 then

        for _, Part in
            pairs(self.GlowParts2) do

            Part.BackgroundColor3 =
                Accent

        end

    end

    --==================================================
    -- HEADER TITLE
    --==================================================

    if self.Title then

        self.Title.TextColor3 =
            CurrentTheme.Text

    end

    if self.TitleStroke then

        self.TitleStroke.Color =
            Accent

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
            Accent

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
            Accent

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
            Accent

    end

    --==================================================
    -- CONTENT TITLE
    --==================================================

    if self.ContentTitle then

        self.ContentTitle.TextColor3 =
            CurrentTheme.Text

    end

    if self.ContentTitleStroke then

        self.ContentTitleStroke.Color =
            Accent

    end

    --==================================================
    -- SCROLLBAR
    --==================================================

    if self.Scroll then

        self.Scroll.ScrollBarImageColor3 =
            Accent

    end

    --==================================================
    -- LOGO
    --==================================================

    if self.HeaderLogo then

        local LogoStroke =
            self.HeaderLogo:FindFirstChildOfClass(
                "UIStroke"
            )

        if LogoStroke then

            LogoStroke.Color =
                self.Theme:GetLogoBorder()

        end

    end

    if self.LogoGlow then

        self.LogoGlow.Color =
            self.Theme:GetLogoBorder()

    end

end

--==================================================
-- BORDER GEOMETRY
--==================================================

function UI:UpdateBorderGeometry()

    if not self.Main
    or not self.BorderParts
    or not self.GlowParts
    or not self.GlowParts2 then

        return

    end

    local Size =
        self.Main.AbsoluteSize

    local Width =
        Size.X

    local Height =
        Size.Y

    if Width <= 0
    or Height <= 0 then

        return

    end

    local T =
        BORDER_THICKNESS

    local G1 =
        GLOW_THICKNESS_1

    local G2 =
        GLOW_THICKNESS_2

    --==================================================
    -- BASE BORDER
    --==================================================

    self.BorderParts.Top.Size =
        UDim2.new(
            1,
            0,
            0,
            T
        )

    self.BorderParts.Top.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    self.BorderParts.Bottom.Size =
        UDim2.new(
            1,
            0,
            0,
            T
        )

    self.BorderParts.Bottom.Position =
        UDim2.new(
            0,
            0,
            1,
            -T
        )

    self.BorderParts.Left.Size =
        UDim2.new(
            0,
            T,
            1,
            0
        )

    self.BorderParts.Left.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    self.BorderParts.Right.Size =
        UDim2.new(
            0,
            T,
            1,
            0
        )

    self.BorderParts.Right.Position =
        UDim2.new(
            1,
            -T,
            0,
            0
        )

    --==================================================
    -- GLOW 1
    --==================================================

    self.GlowParts.Top.Size =
        UDim2.new(
            1,
            0,
            0,
            G1
        )

    self.GlowParts.Top.Position =
        UDim2.new(
            0,
            0,
            0,
            -(G1 - T) / 2
        )

    self.GlowParts.Bottom.Size =
        UDim2.new(
            1,
            0,
            0,
            G1
        )

    self.GlowParts.Bottom.Position =
        UDim2.new(
            0,
            0,
            1,
            -G1 / 2
        )

    self.GlowParts.Left.Size =
        UDim2.new(
            0,
            G1,
            1,
            0
        )

    self.GlowParts.Left.Position =
        UDim2.new(
            0,
            -(G1 - T) / 2,
            0,
            0
        )

    self.GlowParts.Right.Size =
        UDim2.new(
            0,
            G1,
            1,
            0
        )

    self.GlowParts.Right.Position =
        UDim2.new(
            1,
            -G1 / 2,
            0,
            0
        )

    --==================================================
    -- GLOW 2
    --==================================================

    self.GlowParts2.Top.Size =
        UDim2.new(
            1,
            0,
            0,
            G2
        )

    self.GlowParts2.Top.Position =
        UDim2.new(
            0,
            0,
            0,
            -(G2 - T) / 2
        )

    self.GlowParts2.Bottom.Size =
        UDim2.new(
            1,
            0,
            0,
            G2
        )

    self.GlowParts2.Bottom.Position =
        UDim2.new(
            0,
            0,
            1,
            -G2 / 2
        )

    self.GlowParts2.Left.Size =
        UDim2.new(
            0,
            G2,
            1,
            0
        )

    self.GlowParts2.Left.Position =
        UDim2.new(
            0,
            -(G2 - T) / 2,
            0,
            0
        )

    self.GlowParts2.Right.Size =
        UDim2.new(
            0,
            G2,
            1,
            0
        )

    self.GlowParts2.Right.Position =
        UDim2.new(
            1,
            -G2 / 2,
            0,
            0
        )

end

--==================================================
-- SNAKE POSITION
--==================================================
-- A cobra percorre:
--
-- TOP
-- ↓
-- RIGHT
-- ↓
-- BOTTOM
-- ↓
-- LEFT
-- ↓
-- TOP

function UI:UpdateSnake()

    if not self.Main
    or not self.SnakeCore
    or not self.SnakeGlow
    or not self.SnakeHead then

        return

    end

    if not self.Theme:IsSnakeEnabled() then

        self.SnakeCore.Visible =
            false

        self.SnakeGlow.Visible =
            false

        self.SnakeHead.Visible =
            false

        return

    end

    local Size =
        self.Main.AbsoluteSize

    local Width =
        Size.X

    local Height =
        Size.Y

    if Width <= 0
    or Height <= 0 then

        return

    end

    local Progress =
        self.Theme:GetSnakeProgress()

    local Length =
        self.Theme:GetSnakeLength()

    local Perimeter =
        (
            Width
            + Height
        ) * 2

    local SegmentLength =
        math.max(
            25,
            Perimeter * Length
        )

    local TailLength =
        math.max(
            10,
            SegmentLength * SNAKE_TAIL
        )

    --==================================================
    -- POSITION ON PERIMETER
    --==================================================

    local Distance =
        Progress * Perimeter

    local X
    local Y
    local Horizontal

    --==================================================
    -- TOP
    --==================================================

    if Distance <= Width then

        X =
            Distance

        Y =
            0

        Horizontal =
            true

    --==================================================
    -- RIGHT
    --==================================================

    elseif Distance <=
        Width + Height then

        X =
            Width

        Y =
            Distance - Width

        Horizontal =
            false

    --==================================================
    -- BOTTOM
    --==================================================

    elseif Distance <=
        Width * 2 + Height then

        X =
            Width
            - (
                Distance
                - Width
                - Height
            )

        Y =
            Height

        Horizontal =
            true

    --==================================================
    -- LEFT
    --==================================================

    else

        X =
            0

        Y =
            Height
            - (
                Distance
                - Width * 2
                - Height
            )

        Horizontal =
            false

    end

    --==================================================
    -- CORE
    --==================================================

    local CoreThickness =
        SNAKE_THICKNESS

    if Horizontal then

        self.SnakeCore.Size =
            UDim2.new(
                0,
                SegmentLength,
                0,
                CoreThickness
            )

        self.SnakeCore.Position =
            UDim2.new(
                0,
                X - SegmentLength / 2,
                0,
                Y - CoreThickness / 2
            )

    else

        self.SnakeCore.Size =
            UDim2.new(
                0,
                CoreThickness,
                0,
                SegmentLength
            )

        self.SnakeCore.Position =
            UDim2.new(
                0,
                X - CoreThickness / 2,
                0,
                Y - SegmentLength / 2
            )

    end

    --==================================================
    -- GLOW
    --==================================================

    local GlowSize =
        CoreThickness * 3

    if Horizontal then

        self.SnakeGlow.Size =
            UDim2.new(
                0,
                SegmentLength,
                0,
                GlowSize
            )

        self.SnakeGlow.Position =
            UDim2.new(
                0,
                X - SegmentLength / 2,
                0,
                Y - GlowSize / 2
            )

    else

        self.SnakeGlow.Size =
            UDim2.new(
                0,
                GlowSize,
                0,
                SegmentLength
            )

        self.SnakeGlow.Position =
            UDim2.new(
                0,
                X - GlowSize / 2,
                0,
                Y - SegmentLength / 2
            )

    end

    --==================================================
    -- HEAD
    --==================================================

    local HeadSize =
        math.max(
            7,
            SegmentLength * 0.18
        )

    if Horizontal then

        self.SnakeHead.Size =
            UDim2.new(
                0,
                HeadSize,
                0,
                CoreThickness + 1
            )

        self.SnakeHead.Position =
            UDim2.new(
                0,
                X + SegmentLength / 2
                    - HeadSize / 2,
                0,
                Y - (
                    CoreThickness + 1
                ) / 2
            )

    else

        self.SnakeHead.Size =
            UDim2.new(
                0,
                CoreThickness + 1,
                0,
                HeadSize
            )

        self.SnakeHead.Position =
            UDim2.new(
                0,
                X - (
                    CoreThickness + 1
                ) / 2,
                0,
                Y + SegmentLength / 2
                    - HeadSize / 2
            )

    end

    --==================================================
    -- COLORS
    --==================================================

    local CoreColor =
        self.Theme:GetNeonColor()

    local SnakeColor =
        self.Theme:GetSnakeColor()

    local GlowTransparency =
        self.Theme:GetGlowTransparency()

    self.SnakeCore.BackgroundColor3 =
        CoreColor

    self.SnakeGlow.BackgroundColor3 =
        CoreColor

    self.SnakeHead.BackgroundColor3 =
        SnakeColor

    --==================================================
    -- TRANSPARENCY
    --==================================================

    self.SnakeCore.BackgroundTransparency =
        0

    self.SnakeGlow.BackgroundTransparency =
        math.clamp(
            GlowTransparency + 0.12,
            0.05,
            0.8
        )

    self.SnakeHead.BackgroundTransparency =
        0

    self.SnakeCore.Visible =
        true

    self.SnakeGlow.Visible =
        true

    self.SnakeHead.Visible =
        true

end

--==================================================
-- UPDATE NEON
--==================================================

function UI:UpdateNeon()

    if not self.Theme
    or not self.Main then

        return

    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

    local Accent =
        self.Theme:GetAccent()

    local Neon =
        self.Theme:GetNeonColor()

    local Glow =
        self.Theme:GetGlowTransparency()

    --==================================================
    -- BASE BORDER
    --==================================================

    if self.BorderParts then

        for _, Part in
            pairs(self.BorderParts) do

            Part.BackgroundColor3 =
                Accent

            Part.BackgroundTransparency =
                0

        end

    end

    --==================================================
    -- GLOW 1
    --==================================================

    if self.GlowParts then

        for _, Part in
            pairs(self.GlowParts) do

            Part.BackgroundColor3 =
                Accent

            Part.BackgroundTransparency =
                math.clamp(
                    Glow + 0.18,
                    0.15,
                    0.85
                )

        end

    end

    --==================================================
    -- GLOW 2
    --==================================================

    if self.GlowParts2 then

        for _, Part in
            pairs(self.GlowParts2) do

            Part.BackgroundColor3 =
                Accent

            Part.BackgroundTransparency =
                math.clamp(
                    Glow + 0.38,
                    0.3,
                    0.95
                )

        end

    end

    --==================================================
    -- MAIN SCALE GLOW
    --==================================================

    if self.LogoGlow then

        self.LogoGlow.Color =
            Neon

        self.LogoGlow.Transparency =
            math.clamp(
                Glow + 0.18,
                0.2,
                0.85
            )

    end

    --==================================================
    -- TEXT GLOW
    --==================================================

    if self.TitleStroke then

        self.TitleStroke.Color =
            Neon

        self.TitleStroke.Transparency =
            math.clamp(
                Glow + 0.15,
                0.15,
                0.85
            )

    end

    if self.ContentTitleStroke then

        self.ContentTitleStroke.Color =
            Neon

        self.ContentTitleStroke.Transparency =
            math.clamp(
                Glow + 0.2,
                0.2,
                0.9
            )

    end

    --==================================================
    -- CLOSE
    --==================================================

    if self.CloseStroke then

        self.CloseStroke.Color =
            Accent

        self.CloseStroke.Transparency =
            math.clamp(
                Glow + 0.1,
                0.15,
                0.85
            )

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.SidebarStroke then

        self.SidebarStroke.Color =
            Accent

        self.SidebarStroke.Transparency =
            math.clamp(
                Glow + 0.2,
                0.25,
                0.9
            )

    end

    --==================================================
    -- CONTENT
    --==================================================

    if self.ContentStroke then

        self.ContentStroke.Color =
            Accent

        self.ContentStroke.Transparency =
            math.clamp(
                Glow + 0.2,
                0.25,
                0.9
            )

    end

    --==================================================
    -- SCROLLBAR
    --==================================================

    if self.Scroll then

        self.Scroll.ScrollBarImageColor3 =
            Neon

    end

    --==================================================
    -- SNAKE
    --==================================================

    self:UpdateSnake()

end

--==================================================
-- START NEON ENGINE
--==================================================

function UI:StartNeonEngine()

    if self.RenderConnection then

        self.RenderConnection:Disconnect()

        self.RenderConnection =
            nil

    end

    self:UpdateBorderGeometry()

    self.RenderConnection =
        RunService.RenderStepped:Connect(

            function()

                if not self.Main
                or not self.Main.Parent then

                    if self.RenderConnection then

                        self.RenderConnection:Disconnect()

                        self.RenderConnection =
                            nil

                    end

                    return

                end

                if not self:IsAnimationEnabled() then

                    return

                end

                --==================================================
                -- THEME ANIMATION
                --==================================================

                self.Theme:Update()

                --==================================================
                -- BORDER SIZE
                --==================================================

                self:UpdateBorderGeometry()

                --==================================================
                -- NEON
                --==================================================

                self:UpdateNeon()

            end

        )

end

--==================================================
-- RETURN
--==================================================

return UI

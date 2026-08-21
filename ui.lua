--// 💥 RIMURU HUB
--// UI System
--// Animated Stable Version
--// Background Contained Inside Main
--// PREMIUM THEME INTEGRATION
--// Visible Theme Contrast
--// Text Stroke Support
--// Logo Border Support
--// SAFE THEME COMPATIBILITY
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
-- SAFE THEME COLOR
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
-- SAFE THEME NUMBER
--==================================================

local function ThemeNumber(
    Theme,
    Key,
    Fallback
)

    if Theme
    and Theme[Key] ~= nil then

        local Value =
            tonumber(
                Theme[Key]
            )

        if Value ~= nil then
            return Value
        end

    end

    return Fallback

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
        ThemeNumber(
            CurrentTheme,
            "MainTransparency",
            0.04
        )

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
    -- MAIN STROKE
    --==================================================

    local MainStroke =
        Instance.new("UIStroke")

    MainStroke.Color =
        self.Theme:GetAccent()

    MainStroke.Thickness =
        1.8

    MainStroke.Transparency =
        0.05

    MainStroke.Parent =
        Main

    self.MainStroke =
        MainStroke

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
        self.Theme:GetText()

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

    TitleStroke.Color =
        self.Theme:GetTextStroke()

    TitleStroke.Transparency =
        self.Theme:GetTextStrokeTransparency()

    TitleStroke.Thickness =
        0.65

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
        self.Theme:GetSubText()

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
    -- SUBTITLE STROKE
    --==================================================

    local SubtitleStroke =
        Instance.new("UIStroke")

    SubtitleStroke.Color =
        self.Theme:GetTextStroke()

    SubtitleStroke.Transparency =
        math.clamp(
            self.Theme:GetTextStrokeTransparency()
                + 0.15,
            0,
            1
        )

    SubtitleStroke.Thickness =
        0.45

    SubtitleStroke.Parent =
        Subtitle

    self.SubtitleStroke =
        SubtitleStroke

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
            self.Theme:GetButtonColor()
        )

    Close.BackgroundTransparency =
        0

    Close.BorderSizePixel =
        0

    Close.Text =
        "X"

    Close.TextColor3 =
        self.Theme:GetText()

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

    CloseStroke.Color =
        self.Theme:GetAccent()

    CloseStroke.Thickness =
        1

    CloseStroke.Transparency =
        0.15

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
            self.Theme:GetDarkButtonColor()
        )

    Sidebar.BackgroundTransparency =
        ThemeNumber(
            CurrentTheme,
            "SidebarTransparency",
            0
        )

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

    self.SidebarStroke =
        SidebarStroke

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
        ThemeColor(
            CurrentTheme,
            "Content",
            CurrentTheme.Background
        )

    Content.BackgroundTransparency =
        ThemeNumber(
            CurrentTheme,
            "ContentTransparency",
            0
        )

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

    local ContentStroke =
        Instance.new("UIStroke")

    ContentStroke.Color =
        self.Theme:GetAccent()

    ContentStroke.Thickness =
        1

    ContentStroke.Transparency =
        0.78

    ContentStroke.Parent =
        Content

    self.ContentStroke =
        ContentStroke

    self.Content =
        Content

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
        self.Theme:GetText()

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
    -- CONTENT TITLE STROKE
    --==================================================

    local ContentTitleStroke =
        Instance.new("UIStroke")

    ContentTitleStroke.Color =
        self.Theme:GetTextStroke()

    ContentTitleStroke.Transparency =
        self.Theme:GetTextStrokeTransparency()

    ContentTitleStroke.Thickness =
        0.55

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

    Scroll.ScrollBarImageTransparency =
        0.15

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

        self:SetVisible(Value)

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
        self.Theme:GetBackgroundTransparency()

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
            )

        self.Main.BackgroundTransparency =
            ThemeNumber(
                CurrentTheme,
                "MainTransparency",
                0.04
            )

    end

    --==================================================
    -- BACKGROUND
    --==================================================

    self:ApplyBackground()

    --==================================================
    -- MAIN STROKE
    --==================================================

    if self.MainStroke then

        self.MainStroke.Color =
            self.Theme:GetAccent()

        self.MainStroke.Transparency =
            0.05

    end

    --==================================================
    -- TITLE
    --==================================================

    if self.Title then

        self.Title.TextColor3 =
            self.Theme:GetText()

    end

    if self.TitleStroke then

        self.TitleStroke.Color =
            self.Theme:GetTextStroke()

        self.TitleStroke.Transparency =
            self.Theme:GetTextStrokeTransparency()

    end

    --==================================================
    -- SUBTITLE
    --==================================================

    if self.Subtitle then

        self.Subtitle.TextColor3 =
            self.Theme:GetSubText()

    end

    if self.SubtitleStroke then

        self.SubtitleStroke.Color =
            self.Theme:GetTextStroke()

        self.SubtitleStroke.Transparency =
            math.clamp(
                self.Theme:GetTextStrokeTransparency()
                    + 0.15,
                0,
                1
            )

    end

    --==================================================
    -- CLOSE
    --==================================================

    if self.Close then

        self.Close.BackgroundColor3 =
            ThemeColor(
                CurrentTheme,
                "Close",
                self.Theme:GetButtonColor()
            )

        self.Close.TextColor3 =
            self.Theme:GetText()

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
                self.Theme:GetDarkButtonColor()
            )

        self.Sidebar.BackgroundTransparency =
            ThemeNumber(
                CurrentTheme,
                "SidebarTransparency",
                0
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
            ThemeColor(
                CurrentTheme,
                "Content",
                CurrentTheme.Background
            )

        self.Content.BackgroundTransparency =
            ThemeNumber(
                CurrentTheme,
                "ContentTransparency",
                0
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
            self.Theme:GetText()

    end

    if self.ContentTitleStroke then

        self.ContentTitleStroke.Color =
            self.Theme:GetTextStroke()

        self.ContentTitleStroke.Transparency =
            self.Theme:GetTextStrokeTransparency()

    end

    --==================================================
    -- SCROLLBAR
    --==================================================

    if self.Scroll then

        self.Scroll.ScrollBarImageColor3 =
            self.Theme:GetAccent()

    end

    --==================================================
    -- HEADER LOGO BORDER
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

end

--==================================================
-- RETURN
--==================================================

return UI

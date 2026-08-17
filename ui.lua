--// 💥 RIMURU HUB
--// UI System
--// ANIMATED STABLE VERSION
--// Modular UI Core
--// Logo Animation Compatible
--// Safe Menu Animation
--// NO BackgroundTransparency Animation

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

    --==================================================
    -- ANIMATION STATE
    --==================================================

    self.AnimationBusy =
        false

    self.AnimationToken =
        0

    --==================================================
    -- CREATE UI
    --==================================================

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
-- CREATE GUI
--==================================================

function UI:Create()

    self:RemoveOld()

    --==================================================
    -- THEME SAFETY
    --==================================================

    if not self.Theme then

        warn(
            "❌ Rimuru Hub UI: Theme não encontrado."
        )

        return

    end

    local CurrentTheme

    local Success =
        pcall(function()

            CurrentTheme =
                self.Theme:GetCurrent()

        end)

    if not Success
    or not CurrentTheme then

        warn(
            "❌ Rimuru Hub UI: não foi possível obter o tema atual."
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
        CurrentTheme.Main

    Main.BorderSizePixel =
        0

    Main.Visible =
        false

    Main.ZIndex =
        500

    Main.Parent =
        Gui

    self.Main =
        Main

    --==================================================
    -- SAVE ORIGINAL POSITION
    --==================================================

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
    -- MAIN STROKE
    --==================================================

    local MainStroke =
        Instance.new("UIStroke")

    MainStroke.Color =
        self.Theme:GetAccent()

    MainStroke.Thickness =
        1.5

    MainStroke.Parent =
        Main

    self.MainStroke =
        MainStroke

    --==================================================
    -- MAIN DRAG
    --==================================================

    self:SetupDrag()

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
    -- CLOSE BUTTON
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
        CurrentTheme.Close

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

    self.Close =
        Close

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
        CurrentTheme.Sidebar

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
    -- CONTENT SCROLL
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

end

--==================================================
-- ANIMATION ENABLED?
--==================================================

function UI:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    return self.Config.UI.Animation ~= false

end

--==================================================
-- CANCEL CURRENT ANIMATION
--==================================================

function UI:CancelAnimation()

    self.AnimationToken =
        self.AnimationToken + 1

    self.AnimationBusy =
        false

end

--==================================================
-- SHOW / HIDE
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
-- ANIMATED VISIBILITY
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

    --==================================================
    -- NO ANIMATION
    --==================================================

    if not self:IsAnimationEnabled() then

        self:SetVisible(
            Value
        )

        return

    end

    --==================================================
    -- CANCEL PREVIOUS
    --==================================================

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

                self.OriginalPosition.Y.Offset +
                OPEN_OFFSET_Y

            )

        local OpenInfo =
            TweenInfo.new(

                OPEN_TIME,

                Enum.EasingStyle.Quint,

                Enum.EasingDirection.Out

            )

        local ScaleTween =
            TweenService:Create(

                Scale,

                OpenInfo,

                {
                    Scale = 1
                }

            )

        local PositionTween =
            TweenService:Create(

                Main,

                OpenInfo,

                {
                    Position =
                        self.OriginalPosition
                }

            )

        self.AnimationBusy =
            true

        ScaleTween:Play()
        PositionTween:Play()

        task.spawn(function()

            PositionTween.Completed:Wait()

            if self.AnimationToken ==
                Token then

                self.AnimationBusy =
                    false

            end

        end)

        return

    end

    --==================================================
    -- CLOSE
    --==================================================

    if not Main.Visible then
        return
    end

    local CloseInfo =
        TweenInfo.new(

            CLOSE_TIME,

            Enum.EasingStyle.Quad,

            Enum.EasingDirection.In

        )

    local ScaleTween =
        TweenService:Create(

            Scale,

            CloseInfo,

            {
                Scale = CLOSE_SCALE
            }

        )

    local PositionTween =
        TweenService:Create(

            Main,

            CloseInfo,

            {

                Position =
                    UDim2.new(

                        self.OriginalPosition.X.Scale,

                        self.OriginalPosition.X.Offset,

                        self.OriginalPosition.Y.Scale,

                        self.OriginalPosition.Y.Offset +
                        CLOSE_OFFSET_Y

                    )

            }

        )

    self.AnimationBusy =
        true

    ScaleTween:Play()
    PositionTween:Play()

    task.spawn(function()

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

    end)

end

--==================================================
-- TOGGLE ANIMATED
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
-- MAIN DRAG
--==================================================

function UI:SetupDrag()

    local Main =
        self.Main

    local Config =
        self.Config

    if not Main then
        return
    end

    local Dragging =
        false

    local DragStart

    local StartPosition

    Main.InputBegan:Connect(function(Input)

        if not Config
        or not Config.UI
        or not Config.UI.MainMenuDraggable then

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

    end)

    UIS.InputChanged:Connect(function(Input)

        if not Dragging then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseMovement

        or Input.UserInputType ==
            Enum.UserInputType.Touch then
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

                    StartPosition.X.Offset +
                    Delta.X,

                    StartPosition.Y.Scale,

                    StartPosition.Y.Offset +
                    Delta.Y

                )

        end

    end)

    UIS.InputEnded:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1

        or Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging =
                false

        end

    end)

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    if not self.Theme then
        return
    end

    local CurrentTheme

    local Success =
        pcall(function()

            CurrentTheme =
                self.Theme:GetCurrent()

        end)

    if not Success
    or not CurrentTheme then

        return

    end

    --==================================================
    -- MAIN
    --==================================================

    if self.Main then

        self.Main.BackgroundColor3 =
            CurrentTheme.Main

    end

    --==================================================
    -- MAIN STROKE
    --==================================================

    if self.MainStroke then

        self.MainStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- HEADER
    --==================================================

    if self.Header then

        self.Header.BackgroundTransparency =
            1

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
            CurrentTheme.Close

        self.Close.TextColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar then

        self.Sidebar.BackgroundColor3 =
            CurrentTheme.Sidebar

    end

    --==================================================
    -- CONTENT
    --==================================================

    if self.Content then

        self.Content.BackgroundColor3 =
            CurrentTheme.Content

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
-- RETURN MODULE
--==================================================

return UI

--// 💥 RIMURU HUB
--// UI System
--// SEARCH VERSION
--// Modular UI Core

local Players =
    game:GetService("Players")

local UIS =
    game:GetService("UserInputService")

local UI = {}

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

    self:Create()

end

--==================================================
-- MENU ANIMATION
--==================================================

function UI:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    return self.Config.UI.Animation ~= false

end

--==================================================
-- SET MENU VISIBLE
--==================================================

function UI:SetVisibleAnimated(Value)

    local Main =
        self.Main

    if not Main then
        return
    end

    --==================================================
    -- ANIMATION DISABLED
    --==================================================

    if not self:IsAnimationEnabled() then

        Main.Visible =
            Value

        Main.BackgroundTransparency =
            0

        if self.MainScale then

            self.MainScale.Scale =
                1

        end

        return

    end

    --==================================================
    -- OPEN
    --==================================================

    if Value then

        Main.Visible =
            true

        Main.BackgroundTransparency =
            1

        if self.MainScale then

            self.MainScale.Scale =
                0.92

        end

        local TweenInfoOpen =
            TweenInfo.new(

                0.18,

                Enum.EasingStyle.Quint,

                Enum.EasingDirection.Out

            )

        local TransparencyTween =
            TweenService:Create(

                Main,

                TweenInfoOpen,

                {
                    BackgroundTransparency = 0
                }

            )

        local ScaleTween =
            TweenService:Create(

                self.MainScale,

                TweenInfoOpen,

                {
                    Scale = 1
                }

            )

        TransparencyTween:Play()
        ScaleTween:Play()

    --==================================================
    -- CLOSE
    --==================================================

    else

        local TweenInfoClose =
            TweenInfo.new(

                0.13,

                Enum.EasingStyle.Quad,

                Enum.EasingDirection.In

            )

        local TransparencyTween =
            TweenService:Create(

                Main,

                TweenInfoClose,

                {
                    BackgroundTransparency = 1
                }

            )

        local ScaleTween =
            TweenService:Create(

                self.MainScale,

                TweenInfoClose,

                {
                    Scale = 0.92
                }

            )

        TransparencyTween:Play()
        ScaleTween:Play()

        task.delay(

            0.13,

            function()

                if Main then

                    Main.Visible =
                        false

                    Main.BackgroundTransparency =
                        0

                    self.MainScale.Scale =
                        1

                end

            end

        )

    end

end

--==================================================
-- REMOVE OLD VERSION
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

    local ThemeSuccess =
        pcall(function()

            CurrentTheme =
                self.Theme:GetCurrent()

        end)

    if not ThemeSuccess or not CurrentTheme then

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

    --==================================================
    -- INITIAL VISIBILITY
    --==================================================

    local InitialVisible =
        false

    if self.Config
        and self.Config.UI
        and self.Config.UI.Visible ~= nil then

        InitialVisible =
            self.Config.UI.Visible

    end

    Main.Visible =
        InitialVisible

    Main.ZIndex =
        500

    Main.Parent =
        Gui

    self.Main =
        Main

    --==================================================
-- MAIN ANIMATION SCALE
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
-- MAIN DRAG
--==================================================

function UI:SetupDrag()

    local Main =
        self.Main

    local Config =
        self.Config

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
-- VISIBILITY
--==================================================

function UI:SetVisible(Value)

    if not self.Main then
        return
    end

    self.Main.Visible =
        Value

end

function UI:IsVisible()

    if not self.Main then
        return false
    end

    return self.Main.Visible

end

--==================================================
-- MENU ANIMATION
--==================================================

function UI:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    return self.Config.UI.Animation ~= false

end

--==================================================
-- SHOW / HIDE WITH ANIMATION
--==================================================

function UI:SetVisibleAnimated(Value)

    local Main =
        self.Main

    if not Main then
        return
    end

    --==================================================
    -- ANIMATION DISABLED
    --==================================================

    if not self:IsAnimationEnabled() then

        Main.Visible =
            Value

        Main.BackgroundTransparency =
            0

        if self.MainScale then

            self.MainScale.Scale =
                1

        end

        return

    end

    --==================================================
    -- OPEN
    --==================================================

    if Value then

        Main.Visible =
            true

        Main.BackgroundTransparency =
            1

        if self.MainScale then

            self.MainScale.Scale =
                0.92

        end

        local OpenInfo =
            TweenInfo.new(

                0.18,

                Enum.EasingStyle.Quint,

                Enum.EasingDirection.Out

            )

        local Fade =
            TweenService:Create(

                Main,

                OpenInfo,

                {
                    BackgroundTransparency = 0
                }

            )

        local Scale =
            TweenService:Create(

                self.MainScale,

                OpenInfo,

                {
                    Scale = 1
                }

            )

        Fade:Play()
        Scale:Play()

    --==================================================
    -- CLOSE
    --==================================================

    else

        local CloseInfo =
            TweenInfo.new(

                0.13,

                Enum.EasingStyle.Quad,

                Enum.EasingDirection.In

            )

        local Fade =
            TweenService:Create(

                Main,

                CloseInfo,

                {
                    BackgroundTransparency = 1
                }

            )

        local Scale =
            TweenService:Create(

                self.MainScale,

                CloseInfo,

                {
                    Scale = 0.92
                }

            )

        Fade:Play()
        Scale:Play()

        task.delay(

            0.13,

            function()

                if not Main then
                    return
                end

                Main.Visible =
                    false

                Main.BackgroundTransparency =
                    0

                if self.MainScale then

                    self.MainScale.Scale =
                        1

                end

            end

        )

    end

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    if not self.Main then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    self.Main.BackgroundColor3 =
        CurrentTheme.Main

    self.MainStroke.Color =
        self.Theme:GetAccent()

    self.Sidebar.BackgroundColor3 =
        CurrentTheme.Sidebar

    self.Content.BackgroundColor3 =
        CurrentTheme.Content

    self.Title.TextColor3 =
        CurrentTheme.Text

    self.Subtitle.TextColor3 =
        CurrentTheme.SubText

    self.ContentTitle.TextColor3 =
        CurrentTheme.Text

    self.Close.BackgroundColor3 =
        CurrentTheme.Close

    self.Close.TextColor3 =
        CurrentTheme.Text

    self.Scroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

end

--==================================================
-- 🎬 RIMURU HUB ANIMATION SYSTEM
--==================================================

local TweenService =
    game:GetService("TweenService")

--==================================================
-- ANIMATION CONFIG
--==================================================

UI.Animation = {

    -- Duração principal
    OpenTime = 0.32,
    CloseTime = 0.24,

    -- Duração dos elementos internos
    ElementTime = 0.22,

    -- Pequeno atraso entre elementos
    ElementDelay = 0.035

}

--==================================================
-- CHECK ANIMATION
--==================================================

function UI:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    if self.Config.UI.Animation == nil then

        return true

    end

    return self.Config.UI.Animation == true

end

--==================================================
-- CREATE TWEEN
--==================================================

function UI:Tween(
    Object,
    Time,
    Properties,
    Style,
    Direction
)

    if not Object then
        return nil
    end

    local Info =
        TweenInfo.new(

            Time,

            Style
                or Enum.EasingStyle.Quint,

            Direction
                or Enum.EasingDirection.Out

        )

    local Tween =
        TweenService:Create(

            Object,
            Info,
            Properties

        )

    Tween:Play()

    return Tween

end

--==================================================
-- SAVE ORIGINAL SIZE
--==================================================

function UI:PrepareAnimation()

    if not self.Main then
        return
    end

    self.AnimationOriginalSize =
        self.Main.Size

    self.AnimationOriginalPosition =
        self.Main.Position

end

--==================================================
-- OPEN ANIMATION
--==================================================

function UI:OpenAnimated()

    if not self.Main then
        return
    end

    --==================================================
    -- INSTANT MODE
    --==================================================

    if not self:IsAnimationEnabled() then

        self.Main.Visible =
            true

        self.Main.Size =
            self.AnimationOriginalSize
            or UDim2.new(
                0,
                600,
                0,
                400
            )

        self.Main.BackgroundTransparency =
            0

        return

    end

    --==================================================
    -- ORIGINAL VALUES
    --==================================================

    local OriginalSize =
        self.AnimationOriginalSize
        or self.Main.Size

    local OriginalPosition =
        self.AnimationOriginalPosition
        or self.Main.Position

    --==================================================
    -- INITIAL STATE
    --==================================================

    self.Main.Visible =
        true

    self.Main.Size =
        UDim2.new(

            OriginalSize.X.Scale,
            OriginalSize.X.Offset - 35,

            OriginalSize.Y.Scale,
            OriginalSize.Y.Offset - 25

        )

    self.Main.Position =
        UDim2.new(

            OriginalPosition.X.Scale,
            OriginalPosition.X.Offset,

            OriginalPosition.Y.Scale,
            OriginalPosition.Y.Offset + 10

        )

    self.Main.BackgroundTransparency =
        0

    --==================================================
    -- INTERNAL ELEMENTS
    --==================================================

    local Elements = {

        self.Header,
        self.Sidebar,
        self.Content

    }

    local OriginalTransparency = {}

    for _, Element in
        ipairs(Elements) do

        if Element then

            OriginalTransparency[Element] =
                Element.BackgroundTransparency

            Element.BackgroundTransparency =
                1

        end

    end

    --==================================================
    -- MAIN EXPANSION
    --==================================================

    self:Tween(

        self.Main,

        self.Animation.OpenTime,

        {

            Size =
                OriginalSize,

            Position =
                OriginalPosition

        },

        Enum.EasingStyle.Quint,

        Enum.EasingDirection.Out

    )

    --==================================================
    -- INTERNAL ELEMENTS
    --==================================================

    task.spawn(function()

        for Index, Element in
            ipairs(Elements) do

            if Element then

                task.wait(
                    (Index - 1) *
                    self.Animation.ElementDelay
                )

                self:Tween(

                    Element,

                    self.Animation.ElementTime,

                    {

                        BackgroundTransparency =
                            OriginalTransparency[Element]
                            or 0

                    },

                    Enum.EasingStyle.Quad,

                    Enum.EasingDirection.Out

                )

            end

        end

    end)

end

--==================================================
-- CLOSE ANIMATION
--==================================================

function UI:CloseAnimated()

    if not self.Main then
        return
    end

    --==================================================
    -- INSTANT MODE
    --==================================================

    if not self:IsAnimationEnabled() then

        self.Main.Visible =
            false

        self.Main.Size =
            self.AnimationOriginalSize
            or self.Main.Size

        return

    end

    --==================================================
    -- ORIGINAL VALUES
    --==================================================

    local OriginalSize =
        self.AnimationOriginalSize
        or self.Main.Size

    local OriginalPosition =
        self.AnimationOriginalPosition
        or self.Main.Position

    --==================================================
    -- CLOSE SIZE
    --==================================================

    local CloseSize =
        UDim2.new(

            OriginalSize.X.Scale,
            OriginalSize.X.Offset - 30,

            OriginalSize.Y.Scale,
            OriginalSize.Y.Offset - 22

        )

    local ClosePosition =
        UDim2.new(

            OriginalPosition.X.Scale,
            OriginalPosition.X.Offset,

            OriginalPosition.Y.Scale,
            OriginalPosition.Y.Offset + 8

        )

    --==================================================
    -- ELEMENT FADE
    --==================================================

    local Elements = {

        self.Header,
        self.Sidebar,
        self.Content

    }

    for _, Element in
        ipairs(Elements) do

        if Element then

            self:Tween(

                Element,

                self.Animation.ElementTime,

                {

                    BackgroundTransparency =
                        1

                },

                Enum.EasingStyle.Quad,

                Enum.EasingDirection.In

            )

        end

    end

    --==================================================
    -- MAIN CLOSE
    --==================================================

    local Tween =
        self:Tween(

            self.Main,

            self.Animation.CloseTime,

            {

                Size =
                    CloseSize,

                Position =
                    ClosePosition

            },

            Enum.EasingStyle.Quint,

            Enum.EasingDirection.In

        )

    --==================================================
    -- WAIT FOR ANIMATION
    --==================================================

    if Tween then

        Tween.Completed:Wait()

    end

    --==================================================
    -- RESET
    --==================================================

    self.Main.Visible =
        false

    self.Main.Size =
        OriginalSize

    self.Main.Position =
        OriginalPosition

    --==================================================
    -- RESTORE ELEMENTS
    --==================================================

    for _, Element in
        ipairs(Elements) do

        if Element then

            Element.BackgroundTransparency =
                1

        end

    end

end

--==================================================
-- TOGGLE ANIMATION
--==================================================

function UI:ToggleAnimated()

    if not self.Main then
        return
    end

    if self.Main.Visible then

        self:CloseAnimated()

    else

        self:OpenAnimated()

    end

end

--==================================================
-- PREPARE ANIMATION
--==================================================

task.defer(function()

    if UI.Main then

        UI:PrepareAnimation()

    end

end)

--==================================================
-- 🎬 BUTTON PRESS ANIMATION
--==================================================

function UI:PressAnimation(Button)

    if not Button then
        return
    end

    --==================================================
    -- ANIMATION DISABLED
    --==================================================

    if not self:IsAnimationEnabled() then
        return
    end

    --==================================================
    -- SAVE / CREATE SCALE
    --==================================================

    local Scale =
        Button:FindFirstChild(
            "RimuruButtonScale"
        )

    if not Scale then

        Scale =
            Instance.new("UIScale")

        Scale.Name =
            "RimuruButtonScale"

        Scale.Scale =
            1

        Scale.Parent =
            Button

    end

    --==================================================
    -- CANCEL PREVIOUS TWEEN
    --==================================================

    if self._ButtonTweens
    and self._ButtonTweens[Button] then

        pcall(function()

            self._ButtonTweens[Button]:Cancel()

        end)

    end

    self._ButtonTweens =
        self._ButtonTweens
        or {}

    --==================================================
    -- PRESS
    --==================================================

    local PressTween =
        self:Tween(

            Scale,

            0.07,

            {
                Scale = 0.94
            },

            Enum.EasingStyle.Quad,

            Enum.EasingDirection.Out

        )

    if PressTween then

        PressTween.Completed:Wait()

    end

    --==================================================
    -- SMALL BOUNCE
    --==================================================

    local BounceTween =
        self:Tween(

            Scale,

            0.08,

            {
                Scale = 1.035
            },

            Enum.EasingStyle.Back,

            Enum.EasingDirection.Out

        )

    if BounceTween then

        BounceTween.Completed:Wait()

    end

    --==================================================
    -- RETURN TO NORMAL
    --==================================================

    local ReturnTween =
        self:Tween(

            Scale,

            0.09,

            {
                Scale = 1
            },

            Enum.EasingStyle.Quad,

            Enum.EasingDirection.Out

        )

    self._ButtonTweens[Button] =
        ReturnTween

end

return UI

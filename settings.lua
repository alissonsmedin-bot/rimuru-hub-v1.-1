--// 💥 RIMURU HUB
--// Settings System
--// REWORKED SETTINGS UI
--// MODERN TOGGLE SYSTEM
--// ON / OFF SWITCHES
--// THEME POPUP
--// SCROLLABLE THEME LIST
--// SAFE POPUP POSITION
--// OUTSIDE CLICK CLOSE
--// THEME AWARE
--// SMOOTH TOGGLE ANIMATION

local Settings = {}

--==================================================
-- SERVICES
--==================================================

local UIS =
    game:GetService("UserInputService")

local TweenService =
    game:GetService("TweenService")

--==================================================
-- POPUP CONFIG
--==================================================

local POPUP_WIDTH =
    120

local POPUP_HEIGHT =
    82

local POPUP_OFFSET =
    5

local POPUP_OPEN_TIME =
    0.14

local POPUP_CLOSE_TIME =
    0.10

--==================================================
-- TOGGLE CONFIG
--==================================================

local TOGGLE_WIDTH =
    52

local TOGGLE_HEIGHT =
    26

local TOGGLE_KNOB_SIZE =
    20

local TOGGLE_ANIMATION_TIME =
    0.14

--==================================================
-- INIT
--==================================================

function Settings:Init(Context)

    self.Context =
        Context

    self.Config =
        Context.Config

    self.Theme =
        Context.Theme

    self.UI =
        Context.UI

    self.Logo =
        Context.Logo

    self.Categories =
        Context.Categories

    self.Scroll =
        self.UI.Scroll

    self.ContentTitle =
        self.UI.ContentTitle

    self.ThemePopup =
        nil

    self.ThemePopupConnection =
        nil

    self.ToggleButtons =
        {}

end

--==================================================
-- GET CURRENT THEME
--==================================================

function Settings:GetTheme()

    if self.Theme
    and self.Theme.GetCurrent then

        return self.Theme:GetCurrent()

    end

    return {}

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Settings:ClearContent()

    self:CloseThemePopup()

    self.ToggleButtons =
        {}

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        ) do

        if not Object:IsA("UIListLayout")
        and not Object:IsA("UIPadding") then

            Object:Destroy()

        end

    end

end

--==================================================
-- TOGGLE COLORS
--==================================================

function Settings:GetToggleColors(
    Enabled
)

    local CurrentTheme =
        self:GetTheme()

    local Accent =
        self.Theme:GetAccent()

    local OffColor =
        CurrentTheme.Button
        or CurrentTheme.Card

    local OnColor =
        Accent

    local KnobColor =
        Color3.fromRGB(
            255,
            255,
            255
        )

    if Enabled then

        return OnColor, KnobColor

    end

    return OffColor, CurrentTheme.SubText

end

--==================================================
-- UPDATE TOGGLE VISUAL
--==================================================

function Settings:UpdateToggleVisual(
    Data,
    Enabled,
    Animate
)

    if not Data then
        return
    end

    local Button =
        Data.Button

    local Track =
        Data.Track

    local Knob =
        Data.Knob

    local StateLabel =
        Data.StateLabel

    if not Button
    or not Button.Parent
    or not Track
    or not Knob
    or not StateLabel then

        return

    end

    local TrackColor,
        KnobColor =
        self:GetToggleColors(
            Enabled
        )

    local KnobPosition

    if Enabled then

        KnobPosition =
            UDim2.new(
                1,
                -TOGGLE_KNOB_SIZE - 3,
                0.5,
                -TOGGLE_KNOB_SIZE / 2
            )

        StateLabel.Text =
            "ON"

    else

        KnobPosition =
            UDim2.new(
                0,
                3,
                0.5,
                -TOGGLE_KNOB_SIZE / 2
            )

        StateLabel.Text =
            "OFF"

    end

    local Duration =
        Animate
        and TOGGLE_ANIMATION_TIME
        or 0

    if Duration <= 0 then

        Track.BackgroundColor3 =
            TrackColor

        Knob.BackgroundColor3 =
            KnobColor

        Knob.Position =
            KnobPosition

    else

        local TrackTween =
            TweenService:Create(

                Track,

                TweenInfo.new(
                    Duration,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),

                {
                    BackgroundColor3 =
                        TrackColor
                }

            )

        local KnobTween =
            TweenService:Create(

                Knob,

                TweenInfo.new(
                    Duration,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),

                {
                    BackgroundColor3 =
                        KnobColor,

                    Position =
                        KnobPosition
                }

            )

        TrackTween:Play()
        KnobTween:Play()

    end

end

--==================================================
-- CREATE TOGGLE
--==================================================

function Settings:CreateToggle(
    Name,
    GetValue,
    SetValue,
    Order
)

    local CurrentTheme =
        self:GetTheme()

    --==================================================
    -- MAIN BUTTON
    --==================================================

    local Button =
        Instance.new("TextButton")

    Button.Name =
        Name

    Button.Size =
        UDim2.new(
            1,
            -5,
            0,
            45
        )

    Button.BackgroundColor3 =
        CurrentTheme.Card

    Button.BackgroundTransparency =
        0.12

    Button.BorderSizePixel =
        0

    Button.Text =
        ""

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Order

    Button.ZIndex =
        504

    Button.Parent =
        self.Scroll

    --==================================================
    -- CORNER
    --==================================================

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        Button

    --==================================================
    -- NAME LABEL
    --==================================================

    local Label =
        Instance.new("TextLabel")

    Label.Name =
        "SettingName"

    Label.Size =
        UDim2.new(
            1,
            -(TOGGLE_WIDTH + 30),
            1,
            0
        )

    Label.Position =
        UDim2.new(
            0,
            12,
            0,
            0
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        Name

    Label.TextColor3 =
        CurrentTheme.Text

    Label.TextSize =
        12

    Label.Font =
        Enum.Font.GothamMedium

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.ZIndex =
        505

    Label.Parent =
        Button

    --==================================================
    -- TOGGLE TRACK
    --==================================================

    local Track =
        Instance.new("Frame")

    Track.Name =
        "Toggle"

    Track.Size =
        UDim2.new(
            0,
            TOGGLE_WIDTH,
            0,
            TOGGLE_HEIGHT
        )

    Track.Position =
        UDim2.new(
            1,
            -TOGGLE_WIDTH - 10,
            0.5,
            -TOGGLE_HEIGHT / 2
        )

    Track.BorderSizePixel =
        0

    Track.ZIndex =
        506

    Track.Parent =
        Button

    local TrackCorner =
        Instance.new("UICorner")

    TrackCorner.CornerRadius =
        UDim.new(
            1,
            0
        )

    TrackCorner.Parent =
        Track

    --==================================================
    -- TOGGLE KNOB
    --==================================================

    local Knob =
        Instance.new("Frame")

    Knob.Name =
        "Knob"

    Knob.Size =
        UDim2.new(
            0,
            TOGGLE_KNOB_SIZE,
            0,
            TOGGLE_KNOB_SIZE
        )

    Knob.BorderSizePixel =
        0

    Knob.ZIndex =
        507

    Knob.Parent =
        Track

    local KnobCorner =
        Instance.new("UICorner")

    KnobCorner.CornerRadius =
        UDim.new(
            1,
            0
        )

    KnobCorner.Parent =
        Knob

    --==================================================
    -- STATE TEXT
    --==================================================

    local StateLabel =
        Instance.new("TextLabel")

    StateLabel.Name =
        "State"

    StateLabel.Size =
        UDim2.new(
            0,
            27,
            1,
            0
        )

    StateLabel.Position =
        UDim2.new(
            0,
            25,
            0,
            0
        )

    StateLabel.BackgroundTransparency =
        1

    StateLabel.TextSize =
        8

    StateLabel.Font =
        Enum.Font.GothamBold

    StateLabel.TextXAlignment =
        Enum.TextXAlignment.Center

    StateLabel.ZIndex =
        508

    StateLabel.Parent =
        Track

    --==================================================
    -- DATA
    --==================================================

    local Data = {

        Button =
            Button,

        Track =
            Track,

        Knob =
            Knob,

        StateLabel =
            StateLabel,

        GetValue =
            GetValue,

        SetValue =
            SetValue,

        Name =
            Name

    }

    self.ToggleButtons[
        Name
    ] =
        Data

    --==================================================
    -- INITIAL STATE
    --==================================================

    local InitialValue =
        false

    local Success,
        Value =
        pcall(
            GetValue
        )

    if Success then

        InitialValue =
            Value == true

    end

    self:UpdateToggleVisual(
        Data,
        InitialValue,
        false
    )

    --==================================================
    -- HOVER
    --==================================================

    Button.MouseEnter:Connect(
        function()

            if not Button.Parent then
                return
            end

            local Tween =
                TweenService:Create(

                    Button,

                    TweenInfo.new(
                        0.10,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundTransparency =
                            0
                    }

                )

            Tween:Play()

        end
    )

    Button.MouseLeave:Connect(
        function()

            if not Button.Parent then
                return
            end

            local Tween =
                TweenService:Create(

                    Button,

                    TweenInfo.new(
                        0.10,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundTransparency =
                            0.12
                    }

                )

            Tween:Play()

        end
    )

    --==================================================
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(
        function()

            local Success,
                CurrentValue =
                pcall(
                    GetValue
                )

            if not Success then
                return
            end

            local NewValue =
                not (
                    CurrentValue == true
                )

            local SetSuccess =
                pcall(
                    function()

                        SetValue(
                            NewValue
                        )

                    end
                )

            if not SetSuccess then
                return
            end

            self:UpdateToggleVisual(
                Data,
                NewValue,
                true
            )

        end
    )

    return Button

end

--==================================================
-- CLOSE THEME POPUP
--==================================================

function Settings:CloseThemePopup()

    if self.ThemePopupConnection then

        self.ThemePopupConnection:Disconnect()

        self.ThemePopupConnection =
            nil

    end

    local Popup =
        self.ThemePopup

    self.ThemePopup =
        nil

    if not Popup then
        return
    end

    local Scale =
        Popup:FindFirstChild(
            "PopupScale"
        )

    if Scale then

        local Tween =
            TweenService:Create(

                Scale,

                TweenInfo.new(

                    POPUP_CLOSE_TIME,

                    Enum.EasingStyle.Quad,

                    Enum.EasingDirection.In

                ),

                {
                    Scale = 0.92
                }

            )

        Tween:Play()

        task.spawn(
            function()

                Tween.Completed:Wait()

                if Popup then
                    Popup:Destroy()
                end

            end
        )

    else

        Popup:Destroy()

    end

end

--==================================================
-- GET SAFE POPUP POSITION
--==================================================

function Settings:GetPopupPosition(
    ThemeButton
)

    local Gui =
        self.UI.Gui

    if not Gui then
        return nil
    end

    local AbsolutePosition =
        ThemeButton.AbsolutePosition

    local AbsoluteSize =
        ThemeButton.AbsoluteSize

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        return nil
    end

    local Viewport =
        Camera.ViewportSize

    local X =
        AbsolutePosition.X +
        AbsoluteSize.X -
        POPUP_WIDTH

    local Y =
        AbsolutePosition.Y +
        AbsoluteSize.Y +
        POPUP_OFFSET

    if X + POPUP_WIDTH >
        Viewport.X then

        X =
            Viewport.X -
            POPUP_WIDTH -
            6

    end

    if X < 6 then
        X = 6
    end

    if Y + POPUP_HEIGHT >
        Viewport.Y then

        Y =
            AbsolutePosition.Y -
            POPUP_HEIGHT -
            POPUP_OFFSET

    end

    if Y < 6 then
        Y = 6
    end

    return X, Y

end

--==================================================
-- CREATE THEME POPUP
--==================================================

function Settings:CreateThemePopup(
    ThemeButton
)

    self:CloseThemePopup()

    local Gui =
        self.UI.Gui

    if not Gui then
        return
    end

    local CurrentTheme =
        self:GetTheme()

    if not CurrentTheme then
        return
    end

    --==================================================
    -- POPUP
    --==================================================

    local Popup =
        Instance.new("Frame")

    Popup.Name =
        "ThemeSelector"

    Popup.Size =
        UDim2.new(
            0,
            POPUP_WIDTH,
            0,
            POPUP_HEIGHT
        )

    Popup.BackgroundColor3 =
        CurrentTheme.Main

    Popup.BackgroundTransparency =
        0.02

    Popup.BorderSizePixel =
        0

    Popup.ZIndex =
        9000

    Popup.ClipsDescendants =
        true

    Popup.Parent =
        Gui

    self.ThemePopup =
        Popup

    --==================================================
    -- SCALE
    --==================================================

    local PopupScale =
        Instance.new("UIScale")

    PopupScale.Name =
        "PopupScale"

    PopupScale.Scale =
        0.92

    PopupScale.Parent =
        Popup

    --==================================================
    -- CORNER
    --==================================================

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        Popup

    --==================================================
    -- STROKE
    --==================================================

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        1

    Stroke.Transparency =
        0.05

    Stroke.Parent =
        Popup

    --==================================================
    -- POSITION
    --==================================================

    local X, Y =
        self:GetPopupPosition(
            ThemeButton
        )

    if not X then

        Popup:Destroy()

        self.ThemePopup =
            nil

        return

    end

    Popup.Position =
        UDim2.new(
            0,
            X,
            0,
            Y
        )

    --==================================================
    -- SCROLL
    --==================================================

    local Scroll =
        Instance.new("ScrollingFrame")

    Scroll.Name =
        "ThemeScroll"

    Scroll.Size =
        UDim2.new(
            1,
            -8,
            1,
            -8
        )

    Scroll.Position =
        UDim2.new(
            0,
            4,
            0,
            4
        )

    Scroll.BackgroundTransparency =
        1

    Scroll.BorderSizePixel =
        0

    Scroll.ScrollBarThickness =
        3

    Scroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    Scroll.ScrollBarImageTransparency =
        0.15

    Scroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Scroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scroll.ZIndex =
        9001

    Scroll.Parent =
        Popup

    --==================================================
    -- PADDING
    --==================================================

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingTop =
        UDim.new(
            0,
            2
        )

    Padding.PaddingBottom =
        UDim.new(
            0,
            2
        )

    Padding.PaddingLeft =
        UDim.new(
            0,
            2
        )

    Padding.PaddingRight =
        UDim.new(
            0,
            5
        )

    Padding.Parent =
        Scroll

    --==================================================
    -- LAYOUT
    --==================================================

    local Layout =
        Instance.new("UIListLayout")

    Layout.Padding =
        UDim.new(
            0,
            3
        )

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent =
        Scroll

    --==================================================
    -- THEME NAMES
    --==================================================

    local Themes =
        self.Theme:GetThemes()

    local ThemeNames =
        {}

    for Name in pairs(Themes) do

        table.insert(
            ThemeNames,
            Name
        )

    end

    table.sort(
        ThemeNames
    )

    --==================================================
    -- CREATE THEME BUTTONS
    --==================================================

    for Index, Name in
        ipairs(
            ThemeNames
        ) do

        local ThemeData =
            Themes[Name]

        local IsCurrent =
            Name ==
            self.Theme:GetName()

        local Button =
            Instance.new("TextButton")

        Button.Name =
            "Theme_" ..
            Name

        Button.Size =
            UDim2.new(
                1,
                -2,
                0,
                20
            )

        Button.BackgroundColor3 =
            ThemeData.Card
            or CurrentTheme.Card

        Button.BackgroundTransparency =
            IsCurrent
            and 0
            or 0.08

        Button.BorderSizePixel =
            0

        Button.Text =
            IsCurrent
            and "●  " .. Name
            or Name

        Button.TextColor3 =
            ThemeData.Text
            or CurrentTheme.Text

        Button.TextSize =
            9

        Button.Font =
            IsCurrent
            and Enum.Font.GothamBold
            or Enum.Font.GothamMedium

        Button.TextXAlignment =
            Enum.TextXAlignment.Left

        Button.AutoButtonColor =
            false

        Button.LayoutOrder =
            Index

        Button.ZIndex =
            9002

        Button.Parent =
            Scroll

        --==================================================
        -- PADDING
        --==================================================

        local ButtonPadding =
            Instance.new("UIPadding")

        ButtonPadding.PaddingLeft =
            UDim.new(
                0,
                6
            )

        ButtonPadding.Parent =
            Button

        --==================================================
        -- CORNER
        --==================================================

        local ButtonCorner =
            Instance.new("UICorner")

        ButtonCorner.CornerRadius =
            UDim.new(
                0,
                5
            )

        ButtonCorner.Parent =
            Button

        --==================================================
        -- CURRENT STROKE
        --==================================================

        if IsCurrent then

            local CurrentStroke =
                Instance.new("UIStroke")

            CurrentStroke.Color =
                self.Theme:GetAccent()

            CurrentStroke.Thickness =
                1

            CurrentStroke.Transparency =
                0.15

            CurrentStroke.Parent =
                Button

        end

        --==================================================
        -- HOVER
        --==================================================

        Button.MouseEnter:Connect(
            function()

                if not Button.Parent then
                    return
                end

                local Tween =
                    TweenService:Create(

                        Button,

                        TweenInfo.new(
                            0.10,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out
                        ),

                        {
                            BackgroundTransparency =
                                0
                        }

                    )

                Tween:Play()

            end
        )

        Button.MouseLeave:Connect(
            function()

                if not Button.Parent then
                    return
                end

                local Tween =
                    TweenService:Create(

                        Button,

                        TweenInfo.new(
                            0.10,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out
                        ),

                        {
                            BackgroundTransparency =
                                IsCurrent
                                and 0
                                or 0.08
                        }

                    )

                Tween:Play()

            end
        )

        --==================================================
        -- CLICK
        --==================================================

        Button.MouseButton1Click:Connect(
            function()

                if self.Theme:SetTheme(
                    Name
                ) then

                    self:CloseThemePopup()

                    self:ApplyTheme()

                    task.defer(
                        function()

                            if self.Scroll
                            and self.Scroll.Parent then

                                self:Show()

                            end

                        end
                    )

                end

            end
        )

    end

    --==================================================
    -- OPEN ANIMATION
    --==================================================

    local OpenTween =
        TweenService:Create(

            PopupScale,

            TweenInfo.new(

                POPUP_OPEN_TIME,

                Enum.EasingStyle.Back,

                Enum.EasingDirection.Out

            ),

            {
                Scale = 1
            }

        )

    OpenTween:Play()

    --==================================================
    -- CLICK OUTSIDE
    --==================================================

    self.ThemePopupConnection =
        UIS.InputBegan:Connect(
            function(Input)

                if not self.ThemePopup then
                    return
                end

                if Input.UserInputType ~=
                    Enum.UserInputType.MouseButton1

                and Input.UserInputType ~=
                    Enum.UserInputType.Touch then

                    return

                end

                local Position =
                    Input.Position

                local PopupPosition =
                    Popup.AbsolutePosition

                local PopupSize =
                    Popup.AbsoluteSize

                local InsidePopup =

                    Position.X >=
                    PopupPosition.X

                    and

                    Position.X <=
                    PopupPosition.X +
                    PopupSize.X

                    and

                    Position.Y >=
                    PopupPosition.Y

                    and

                    Position.Y <=
                    PopupPosition.Y +
                    PopupSize.Y

                if InsidePopup then
                    return
                end

                local ButtonPosition =
                    ThemeButton.AbsolutePosition

                local ButtonSize =
                    ThemeButton.AbsoluteSize

                local InsideButton =

                    Position.X >=
                    ButtonPosition.X

                    and

                    Position.X <=
                    ButtonPosition.X +
                    ButtonSize.X

                    and

                    Position.Y >=
                    ButtonPosition.Y

                    and

                    Position.Y <=
                    ButtonPosition.Y +
                    ButtonSize.Y

                if InsideButton then
                    return
                end

                self:CloseThemePopup()

            end
        )

end

--==================================================
-- CREATE THEME SELECTOR
--==================================================

function Settings:CreateThemeSelector()

    local CurrentTheme =
        self:GetTheme()

    local ThemeButton =
        Instance.new("TextButton")

    ThemeButton.Name =
        "Tema"

    ThemeButton.Size =
        UDim2.new(
            1,
            -5,
            0,
            45
        )

    ThemeButton.BackgroundColor3 =
        CurrentTheme.Card

    ThemeButton.BackgroundTransparency =
        0.12

    ThemeButton.BorderSizePixel =
        0

    ThemeButton.Text =
        "🎨  Tema: " ..
        self.Theme:GetName()

    ThemeButton.TextColor3 =
        CurrentTheme.Text

    ThemeButton.TextSize =
        12

    ThemeButton.Font =
        Enum.Font.GothamMedium

    ThemeButton.TextXAlignment =
        Enum.TextXAlignment.Left

    ThemeButton.AutoButtonColor =
        false

    ThemeButton.LayoutOrder =
        0

    ThemeButton.ZIndex =
        504

    ThemeButton.Parent =
        self.Scroll

    --==================================================
    -- PADDING
    --==================================================

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    Padding.Parent =
        ThemeButton

    --==================================================
    -- CORNER
    --==================================================

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        ThemeButton

    --==================================================
    -- ARROW
    --==================================================

    local Arrow =
        Instance.new("TextLabel")

    Arrow.Name =
        "Arrow"

    Arrow.Size =
        UDim2.new(
            0,
            30,
            1,
            0
        )

    Arrow.Position =
        UDim2.new(
            1,
            -35,
            0,
            0
        )

    Arrow.BackgroundTransparency =
        1

    Arrow.Text =
        "›"

    Arrow.TextColor3 =
        CurrentTheme.SubText

    Arrow.TextSize =
        20

    Arrow.Font =
        Enum.Font.GothamBold

    Arrow.ZIndex =
        505

    Arrow.Parent =
        ThemeButton

    --==================================================
    -- HOVER
    --==================================================

    ThemeButton.MouseEnter:Connect(
        function()

            local Tween =
                TweenService:Create(

                    ThemeButton,

                    TweenInfo.new(
                        0.10,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundTransparency =
                            0
                    }

                )

            Tween:Play()

        end
    )

    ThemeButton.MouseLeave:Connect(
        function()

            local Tween =
                TweenService:Create(

                    ThemeButton,

                    TweenInfo.new(
                        0.10,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundTransparency =
                            0.12
                    }

                )

            Tween:Play()

        end
    )

    --==================================================
    -- CLICK
    --==================================================

    ThemeButton.MouseButton1Click:Connect(
        function()

            if self.ThemePopup then

                self:CloseThemePopup()

            else

                self:CreateThemePopup(
                    ThemeButton
                )

            end

        end
    )

    self.ThemeButton =
        ThemeButton

    return ThemeButton

end

--==================================================
-- SHOW SETTINGS
--==================================================

function Settings:Show()

    self:CloseThemePopup()

    self:ClearContent()

    self.ContentTitle.Text =
        "Configuração"

    --==================================================
    -- THEME
    --==================================================

    self:CreateThemeSelector()

    --==================================================
    -- ANIMATIONS
    --==================================================

    self:CreateToggle(

        "Animações",

        function()

            return
                self.Config.UI.Animation == true

        end,

        function(Value)

            self.Config.UI.Animation =
                Value

        end,

        1

    )

    --==================================================
    -- SHOW LOGO
    --==================================================

    self:CreateToggle(

        "Mostrar Logo",

        function()

            return
                self.Config.UI.ShowLogo == true

        end,

        function(Value)

            self.Config.UI.ShowLogo =
                Value

            if self.Logo then

                self.Logo:SetVisible(
                    Value
                )

            end

        end,

        2

    )

    --==================================================
    -- LOGO DRAGGABLE
    --==================================================

    self:CreateToggle(

        "Logo Arrastável",

        function()

            return
                self.Config.UI.LogoDraggable == true

        end,

        function(Value)

            self.Config.UI.LogoDraggable =
                Value

        end,

        3

    )

    --==================================================
    -- MAIN MENU DRAGGABLE
    --==================================================

    self:CreateToggle(

        "Menu Arrastável",

        function()

            return
                self.Config.UI.MainMenuDraggable == true

        end,

        function(Value)

            self.Config.UI.MainMenuDraggable =
                Value

        end,

        4

    )

end

--==================================================
-- APPLY THEME
--==================================================

function Settings:ApplyTheme()

    if self.UI then

        self.UI:ApplyTheme()

    end

    if self.Logo then

        self.Logo:ApplyTheme()

    end

    if self.Categories then

        self.Categories:ApplyTheme()

    end

    local CurrentTheme =
        self:GetTheme()

    if not CurrentTheme
    or not self.Scroll then

        return

    end

    --==================================================
    -- SETTINGS OBJECTS
    --==================================================

    for _, Object in
        ipairs(
            self.Scroll:GetDescendants()
        ) do

        if Object:IsA("Frame") then

            if Object.Name ==
                "Toggle" then

                -- Toggle será atualizado
                -- individualmente abaixo.

            else

                Object.BackgroundColor3 =
                    CurrentTheme.Card

            end

        elseif Object:IsA("TextLabel") then

            Object.TextColor3 =
                CurrentTheme.Text

        elseif Object:IsA("TextButton") then

            Object.BackgroundColor3 =
                CurrentTheme.Card

            Object.TextColor3 =
                CurrentTheme.Text

        end

    end

    --==================================================
    -- UPDATE TOGGLES
    --==================================================

    for Name, Data in
        pairs(
            self.ToggleButtons
        ) do

        local Success,
            Value =
            pcall(
                Data.GetValue
            )

        if Success then

            self:UpdateToggleVisual(
                Data,
                Value == true,
                false
            )

        end

    end

    --==================================================
    -- THEME BUTTON
    --==================================================

    if self.ThemeButton
    and self.ThemeButton.Parent then

        self.ThemeButton.BackgroundColor3 =
            CurrentTheme.Card

        self.ThemeButton.TextColor3 =
            CurrentTheme.Text

        local Arrow =
            self.ThemeButton:FindFirstChild(
                "Arrow"
            )

        if Arrow then

            Arrow.TextColor3 =
                CurrentTheme.SubText

        end

    end

    --==================================================
    -- UPDATE OPEN POPUP
    --==================================================

    if self.ThemePopup then

        self.ThemePopup.BackgroundColor3 =
            CurrentTheme.Main

        local Stroke =
            self.ThemePopup:FindFirstChildOfClass(
                "UIStroke"
            )

        if Stroke then

            Stroke.Color =
                self.Theme:GetAccent()

        end

        local ThemeScroll =
            self.ThemePopup:FindFirstChild(
                "ThemeScroll"
            )

        if ThemeScroll then

            ThemeScroll.ScrollBarImageColor3 =
                self.Theme:GetAccent()

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Settings

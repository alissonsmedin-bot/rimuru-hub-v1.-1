--// 💥 RIMURU HUB
--// Settings System
--// Theme Popup Selector
--// Animation Toggle Version

local Settings = {}

--==================================================
-- THEME POPUP CONFIG
--==================================================

local THEME_POPUP_WIDTH =
    120

local THEME_POPUP_HEIGHT =
    82

local THEME_BUTTON_HEIGHT =
    28

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

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Settings:ClearContent()

    --==================================================
    -- CLOSE THEME POPUP
    --==================================================

    self:CloseThemePopup()

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
-- CREATE TOGGLE
--==================================================

function Settings:CreateToggle(
    Name,
    GetValue,
    SetValue,
    Order
)

    local CurrentTheme =
        self.Theme:GetCurrent()

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

    Button.BorderSizePixel =
        0

    Button.Text =
        Name ..
        ": " ..
        tostring(
            GetValue()
        )

    Button.TextColor3 =
        CurrentTheme.Text

    Button.TextSize =
        12

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Order

    Button.ZIndex =
        504

    Button.Parent =
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
        Button

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
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(function()

        local NewValue =
            not GetValue()

        SetValue(
            NewValue
        )

        Button.Text =
            Name ..
            ": " ..
            tostring(
                NewValue
            )

    end)

    return Button

end

--==================================================
-- CLOSE THEME POPUP
--==================================================

function Settings:CloseThemePopup()

    if self.ThemePopup then

        self.ThemePopup:Destroy()

        self.ThemePopup =
            nil

    end

end

--==================================================
-- CREATE THEME POPUP
--==================================================

function Settings:CreateThemePopup(
    ThemeButton
)

    --==================================================
    -- TOGGLE
    --==================================================

    if self.ThemePopup then

        self:CloseThemePopup()

        return

    end

    local CurrentTheme =
        self.Theme:GetCurrent()

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
    -- POPUP
    --==================================================

    local Popup =
        Instance.new("Frame")

    Popup.Name =
        "ThemePopup"

    Popup.Size =
        UDim2.new(
            0,
            THEME_POPUP_WIDTH,
            0,
            THEME_POPUP_HEIGHT
        )

    Popup.BackgroundColor3 =
        CurrentTheme.Main

    Popup.BackgroundTransparency =
        CurrentTheme.Transparency or 0

    Popup.BorderSizePixel =
        0

    Popup.ZIndex =
        900

    Popup.ClipsDescendants =
        true

    --==================================================
    -- POSITION
    --==================================================

    Popup.AnchorPoint =
        Vector2.new(
            0,
            0
        )

    Popup.Position =
        UDim2.new(
            0,
            ThemeButton.AbsolutePosition.X
            - self.UI.Gui.AbsolutePosition.X,

            0,
            ThemeButton.AbsolutePosition.Y
            - self.UI.Gui.AbsolutePosition.Y
            + ThemeButton.AbsoluteSize.Y
            + 5
        )

    Popup.Parent =
        self.UI.Gui

    --==================================================
    -- CORNER
    --==================================================

    local PopupCorner =
        Instance.new("UICorner")

    PopupCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    PopupCorner.Parent =
        Popup

    --==================================================
    -- STROKE
    --==================================================

    local PopupStroke =
        Instance.new("UIStroke")

    PopupStroke.Color =
        self.Theme:GetAccent()

    PopupStroke.Thickness =
        1

    PopupStroke.Transparency =
        CurrentTheme.BorderTransparency or 0

    PopupStroke.Parent =
        Popup

    --==================================================
    -- SCROLL
    --==================================================

    local Scroll =
        Instance.new("ScrollingFrame")

    Scroll.Name =
        "ThemeList"

    Scroll.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Scroll.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Scroll.BackgroundTransparency =
        1

    Scroll.BorderSizePixel =
        0

    Scroll.ScrollBarThickness =
        4

    Scroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    Scroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            #ThemeNames *
            THEME_BUTTON_HEIGHT
        )

    Scroll.ZIndex =
        901

    Scroll.Parent =
        Popup

    --==================================================
    -- LIST
    --==================================================

    local Layout =
        Instance.new("UIListLayout")

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Padding =
        UDim.new(
            0,
            2
        )

    Layout.Parent =
        Scroll

    --==================================================
    -- PADDING
    --==================================================

    local ListPadding =
        Instance.new("UIPadding")

    ListPadding.PaddingTop =
        UDim.new(
            0,
            3
        )

    ListPadding.PaddingBottom =
        UDim.new(
            0,
            3
        )

    ListPadding.PaddingLeft =
        UDim.new(
            0,
            3
        )

    ListPadding.PaddingRight =
        UDim.new(
            0,
            5
        )

    ListPadding.Parent =
        Scroll

    --==================================================
    -- CREATE THEME BUTTONS
    --==================================================

    for Index, Name in
        ipairs(
            ThemeNames
        ) do

        local IsSelected =
            Name ==
            self.Theme:GetName()

        local Button =
            Instance.new("TextButton")

        Button.Name =
            Name

        Button.Size =
            UDim2.new(
                1,
                -5,
                0,
                THEME_BUTTON_HEIGHT
            )

        --==================================================
        -- SELECTED COLOR
        --==================================================

        if IsSelected then

            Button.BackgroundColor3 =
                self.Theme:GetAccent()

        else

            Button.BackgroundColor3 =
                CurrentTheme.Card

        end

        Button.BackgroundTransparency =
            CurrentTheme.Transparency or 0

        Button.BorderSizePixel =
            0

        Button.Text =
            Name

        Button.TextColor3 =
            IsSelected
            and Color3.fromRGB(
                255,
                255,
                255
            )
            or CurrentTheme.Text

        Button.TextSize =
            10

        Button.Font =
            Enum.Font.GothamMedium

        Button.TextXAlignment =
            Enum.TextXAlignment.Left

        Button.AutoButtonColor =
            false

        Button.LayoutOrder =
            Index

        Button.ZIndex =
            902

        Button.Parent =
            Scroll

        --==================================================
        -- BUTTON PADDING
        --==================================================

        local ButtonPadding =
            Instance.new("UIPadding")

        ButtonPadding.PaddingLeft =
            UDim.new(
                0,
                7
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
        -- CLICK
        --==================================================

        Button.MouseButton1Click:Connect(function()

            if self.Theme:SetTheme(
                Name
            ) then

                ThemeButton.Text =
                    "Tema: " ..
                    Name

                self:ApplyTheme()

                self:CloseThemePopup()

            end

        end)

    end

    self.ThemePopup =
        Popup

end

--==================================================
-- CREATE THEME SELECTOR
--==================================================

function Settings:CreateThemeSelector()

    local CurrentTheme =
        self.Theme:GetCurrent()

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
        CurrentTheme.Transparency or 0

    ThemeButton.BorderSizePixel =
        0

    ThemeButton.Text =
        "Tema: " ..
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

    local ThemePadding =
        Instance.new("UIPadding")

    ThemePadding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    ThemePadding.Parent =
        ThemeButton

    --==================================================
    -- CORNER
    --==================================================

    local ThemeCorner =
        Instance.new("UICorner")

    ThemeCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    ThemeCorner.Parent =
        ThemeButton

    --==================================================
    -- STROKE
    --==================================================

    local ThemeStroke =
        Instance.new("UIStroke")

    ThemeStroke.Color =
        self.Theme:GetAccent()

    ThemeStroke.Thickness =
        1

    ThemeStroke.Transparency =
        CurrentTheme.BorderTransparency or 0

    ThemeStroke.Parent =
        ThemeButton

    --==================================================
    -- CLICK
    --==================================================

    ThemeButton.MouseButton1Click:Connect(function()

        self:CreateThemePopup(
            ThemeButton
        )

    end)

    self.ThemeButton =
        ThemeButton

    return ThemeButton

end

--==================================================
-- SHOW SETTINGS
--==================================================

function Settings:Show()

    self:ClearContent()

    self.ContentTitle.Text =
        "Configuração"

    --==================================================
    -- THEME
    --==================================================

    self:CreateThemeSelector()

    --==================================================
    -- ANIMATION
    --==================================================

    self:CreateToggle(

        "Animações",

        function()

            return self.Config.UI.Animation

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

            return self.Config.UI.ShowLogo

        end,

        function(Value)

            self.Config.UI.ShowLogo =
                Value

            self.Logo:SetVisible(
                Value
            )

        end,

        2

    )

    --==================================================
    -- LOGO DRAGGABLE
    --==================================================

    self:CreateToggle(

        "Logo Arrastável",

        function()

            return self.Config.UI.LogoDraggable

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

            return self.Config.UI.MainMenuDraggable

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

    self.UI:ApplyTheme()

    self.Logo:ApplyTheme()

    self.Categories:ApplyTheme()

    local CurrentTheme =
        self.Theme:GetCurrent()

    --==================================================
    -- UPDATE THEME BUTTON
    --==================================================

    if self.ThemeButton then

        self.ThemeButton.Text =
            "Tema: " ..
            self.Theme:GetName()

        self.ThemeButton.BackgroundColor3 =
            CurrentTheme.Card

        self.ThemeButton.BackgroundTransparency =
            CurrentTheme.Transparency or 0

        local Stroke =
            self.ThemeButton:FindFirstChildOfClass(
                "UIStroke"
            )

        if Stroke then

            Stroke.Color =
                self.Theme:GetAccent()

            Stroke.Transparency =
                CurrentTheme.BorderTransparency or 0

        end

    end

    --==================================================
    -- UPDATE POPUP
    --==================================================

    if self.ThemePopup then

        self:CloseThemePopup()

    end

    --==================================================
    -- APPLY CONTENT
    --==================================================

    for _, Object in
        ipairs(
            self.Scroll:GetDescendants()
        ) do

        if Object:IsA("Frame") then

            Object.BackgroundColor3 =
                CurrentTheme.Card

            Object.BackgroundTransparency =
                CurrentTheme.Transparency or 0

        elseif Object:IsA("TextLabel") then

            if Object.Font ==
                Enum.Font.Code then

                Object.TextColor3 =
                    CurrentTheme.SubText

            else

                Object.TextColor3 =
                    CurrentTheme.Text

            end

        elseif Object:IsA("TextButton") then

            if Object.Name ==
                "Copy"

            or Object.Text ==
                "Copy"

            or Object.Text ==
                "Copied!"

            or Object.Text ==
                "N/A" then

                Object.BackgroundColor3 =
                    self.Theme:GetAccent()

                Object.TextColor3 =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    )

            else

                Object.BackgroundColor3 =
                    CurrentTheme.Card

                Object.BackgroundTransparency =
                    CurrentTheme.Transparency or 0

                Object.TextColor3 =
                    CurrentTheme.Text

                local Stroke =
                    Object:FindFirstChildOfClass(
                        "UIStroke"
                    )

                if Stroke then

                    Stroke.Transparency =
                        CurrentTheme.BorderTransparency or 0

                end

            end

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Settings

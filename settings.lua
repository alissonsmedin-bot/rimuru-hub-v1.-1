--// 💥 RIMURU HUB
--// Settings System
--// Theme Popup + Animation Toggle

local Settings = {}

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

    Button.BackgroundTransparency =
        0.12

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

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    Padding.Parent =
        Button

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        Button

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

function Settings:CreateThemePopup(ThemeButton)

    self:CloseThemePopup()

    local Gui =
        self.UI.Gui

    if not Gui then
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
            120,
            0,
            82
        )

    Popup.BackgroundColor3 =
        self.Theme:GetCurrent().Main

    Popup.BackgroundTransparency =
        0.02

    Popup.BorderSizePixel =
        0

    Popup.ZIndex =
        9000

    Popup.Parent =
        Gui

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        Popup

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        1

    Stroke.Parent =
        Popup

    --==================================================
    -- POSITION
    --==================================================

    local AbsolutePosition =
        ThemeButton.AbsolutePosition

    local AbsoluteSize =
        ThemeButton.AbsoluteSize

    Popup.Position =
        UDim2.new(
            0,
            AbsolutePosition.X +
            AbsoluteSize.X -
            120,
            0,
            AbsolutePosition.Y +
            AbsoluteSize.Y +
            5
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

    Scroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scroll.ZIndex =
        9001

    Scroll.Parent =
        Popup

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
    -- BUTTONS
    --==================================================

    for Index, Name in
        ipairs(ThemeNames) do

        local CurrentTheme =
            self.Theme:GetCurrent()

        local ThemeData =
            Themes[Name]

        local Button =
            Instance.new("TextButton")

        Button.Name =
            Name

        Button.Size =
            UDim2.new(
                1,
                -2,
                0,
                20
            )

        Button.BackgroundColor3 =
            ThemeData.Card or
            CurrentTheme.Card

        Button.BackgroundTransparency =
            0.05

        Button.BorderSizePixel =
            0

        Button.Text =
            Name

        Button.TextColor3 =
            ThemeData.Text or
            CurrentTheme.Text

        Button.TextSize =
            9

        Button.Font =
            Enum.Font.GothamMedium

        Button.AutoButtonColor =
            false

        Button.LayoutOrder =
            Index

        Button.ZIndex =
            9002

        Button.Parent =
            Scroll

        local ButtonCorner =
            Instance.new("UICorner")

        ButtonCorner.CornerRadius =
            UDim.new(
                0,
                5
            )

        ButtonCorner.Parent =
            Button

        Button.MouseButton1Click:Connect(function()

            if self.Theme:SetTheme(
                Name
            ) then

                self:CloseThemePopup()

                self:ApplyTheme()

                -- Rebuild settings so the
                -- selector shows the new theme
                task.defer(function()

                    if self.Scroll
                    and self.Scroll.Parent then

                        self:Show()

                    end

                end)

            end

        end)

    end

    self.ThemePopup =
        Popup

end

--==================================================
-- CREATE THEME SELECTOR BUTTON
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
        0.12

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

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    Padding.Parent =
        ThemeButton

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        ThemeButton

    ThemeButton.MouseButton1Click:Connect(function()

        if self.ThemePopup then

            self:CloseThemePopup()

        else

            self:CreateThemePopup(
                ThemeButton
            )

        end

    end)

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

    --==================================================
    -- MAIN UI
    --==================================================

    self.UI:ApplyTheme()

    --==================================================
    -- LOGO
    --==================================================

    if self.Logo then

        self.Logo:ApplyTheme()

    end

    --==================================================
    -- CATEGORIES
    --==================================================

    if self.Categories then

        self.Categories:ApplyTheme()

    end

    --==================================================
    -- SETTINGS OBJECTS
    --==================================================

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(
            self.Scroll:GetDescendants()
        ) do

        if Object:IsA("Frame") then

            Object.BackgroundColor3 =
                CurrentTheme.Card

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

                Object.TextColor3 =
                    CurrentTheme.Text

            end

        end

    end

end

return Settings

--// 💥 RIMURU HUB
--// Settings System

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

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Settings:ClearContent()

    for _, Object in
        ipairs(self.Scroll:GetChildren()) do

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
-- CREATE THEME SELECTOR
--==================================================

function Settings:CreateThemeSelector()

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

    local ThemeIndex =
        1

    for Index, Name in
        ipairs(ThemeNames) do

        if Name ==
            self.Theme:GetName() then

            ThemeIndex =
                Index

            break

        end

    end

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
    -- CLICK
    --==================================================

    ThemeButton.MouseButton1Click:Connect(function()

        if #ThemeNames == 0 then
            return
        end

        ThemeIndex += 1

        if ThemeIndex >
            #ThemeNames then

            ThemeIndex =
                1

        end

        local NewTheme =
            ThemeNames[
                ThemeIndex
            ]

        if self.Theme:SetTheme(
            NewTheme
        ) then

            ThemeButton.Text =
                "Tema: " ..
                NewTheme

            self:ApplyTheme()

        end

    end)

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

        1

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

        2

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

        3

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

    for _, Object in
        ipairs(self.Scroll:GetDescendants()) do

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

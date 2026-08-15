--// 💥 RIMURU HUB
--// Settings System
--// REWORKED SETTINGS
--// Theme Selector + Color Panel + Scroll
--// Transparência + Animações + RGB + UI Size

local Settings = {}

--==================================================
-- INIT
--==================================================

function Settings:Init(Context)

    self.Context =
        Context or {}

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

    self.ColorPanel =
        nil

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Settings:ClearContent()

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(self.Scroll:GetChildren()) do

        if not Object:IsA("UIListLayout")
        and not Object:IsA("UIPadding") then

            Object:Destroy()

        end

    end

end

--==================================================
-- CREATE CORNER
--==================================================

function Settings:AddCorner(Object, Radius)

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            Radius or 8
        )

    Corner.Parent =
        Object

    return Corner

end

--==================================================
-- CREATE LABEL
--==================================================

function Settings:CreateSectionLabel(
    Text,
    Order
)

    local Theme =
        self.Theme:GetCurrent()

    local Label =
        Instance.new("TextLabel")

    Label.Name =
        "Section_" .. Text

    Label.Size =
        UDim2.new(
            1,
            -5,
            0,
            25
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        Text

    Label.TextColor3 =
        Theme.Text

    Label.TextSize =
        13

    Label.Font =
        Enum.Font.GothamBold

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.LayoutOrder =
        Order or 0

    Label.ZIndex =
        504

    Label.Parent =
        self.Scroll

    return Label

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

    local Theme =
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
        Theme.Card

    Button.BorderSizePixel =
        0

    Button.Text =
        Name ..
        ": " ..
        tostring(
            GetValue()
        )

    Button.TextColor3 =
        Theme.Text

    Button.TextSize =
        12

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Order or 0

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

    self:AddCorner(
        Button,
        8
    )

    Button.MouseButton1Click:Connect(
        function()

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

        end
    )

    return Button

end

--==================================================
-- CREATE BUTTON
--==================================================

function Settings:CreateButton(
    Name,
    Text,
    Order,
    Callback
)

    local Theme =
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
        Theme.Card

    Button.BorderSizePixel =
        0

    Button.Text =
        Text

    Button.TextColor3 =
        Theme.Text

    Button.TextSize =
        12

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Order or 0

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

    self:AddCorner(
        Button,
        8
    )

    Button.MouseButton1Click:Connect(
        function()

            if Callback then
                Callback(Button)
            end

        end
    )

    return Button

end

--==================================================
-- CREATE THEME LIST
--==================================================

function Settings:CreateThemeSelector()

    local Theme =
        self.Theme:GetCurrent()

    local Themes =
        self.Theme:GetThemes()

    local ThemeNames =
        self.Theme:GetThemeNames()

    local Container =
        Instance.new("Frame")

    Container.Name =
        "ThemeSelector"

    Container.Size =
        UDim2.new(
            1,
            -5,
            0,
            170
        )

    Container.BackgroundColor3 =
        Theme.Card

    Container.BorderSizePixel =
        0

    Container.LayoutOrder =
        1

    Container.ZIndex =
        504

    Container.Parent =
        self.Scroll

    self:AddCorner(
        Container,
        8
    )

    local Title =
        Instance.new("TextLabel")

    Title.Size =
        UDim2.new(
            1,
            -20,
            0,
            28
        )

    Title.Position =
        UDim2.new(
            0,
            10,
            0,
            5
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "Tema: " ..
        self.Theme:GetName()

    Title.TextColor3 =
        Theme.Text

    Title.TextSize =
        12

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        505

    Title.Parent =
        Container

    local ThemeScroll =
        Instance.new("ScrollingFrame")

    ThemeScroll.Name =
        "ThemeScroll"

    ThemeScroll.Position =
        UDim2.new(
            0,
            8,
            0,
            35
        )

    ThemeScroll.Size =
        UDim2.new(
            1,
            -16,
            1,
            -42
        )

    ThemeScroll.BackgroundTransparency =
        1

    ThemeScroll.BorderSizePixel =
        0

    ThemeScroll.ScrollBarThickness =
        4

    ThemeScroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    ThemeScroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    ThemeScroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    ThemeScroll.ZIndex =
        505

    ThemeScroll.Parent =
        Container

    local Layout =
        Instance.new("UIListLayout")

    Layout.Padding =
        UDim.new(
            0,
            4
        )

    Layout.Parent =
        ThemeScroll

    for _, ThemeName in
        ipairs(ThemeNames) do

        local ThemeData =
            Themes[ThemeName]

        local Button =
            Instance.new("TextButton")

        Button.Name =
            ThemeName

        Button.Size =
            UDim2.new(
                1,
                -5,
                0,
                32
            )

        Button.BackgroundColor3 =
            ThemeData.Card
            or Theme.Card

        Button.BorderSizePixel =
            0

        Button.Text =
            "  " ..
            ThemeName

        Button.TextColor3 =
            ThemeData.Text
            or Theme.Text

        Button.TextSize =
            11

        Button.Font =
            Enum.Font.GothamMedium

        Button.TextXAlignment =
            Enum.TextXAlignment.Left

        Button.AutoButtonColor =
            false

        Button.ZIndex =
            506

        Button.Parent =
            ThemeScroll

        self:AddCorner(
            Button,
            6
        )

        local Accent =
            Instance.new("Frame")

        Accent.Name =
            "Accent"

        Accent.Size =
            UDim2.new(
                0,
                4,
                1,
                -10
            )

        Accent.Position =
            UDim2.new(
                0,
                4,
                0,
                5
            )

        Accent.BackgroundColor3 =
            ThemeData.Accent
            or Theme:GetAccent()

        Accent.BorderSizePixel =
            0

        Accent.ZIndex =
            507

        Accent.Parent =
            Button

        self:AddCorner(
            Accent,
            3
        )

        Button.MouseButton1Click:Connect(
            function()

                if not self.Theme:SetTheme(
                    ThemeName
                ) then

                    return

                end

                self:ApplyTheme()

                Title.Text =
                    "Tema: " ..
                    self.Theme:GetName()

                self:RefreshColorPanel()

            end
        )

    end

end

--==================================================
-- COLOR NAMES
--==================================================

function Settings:GetColorNames()

    local Names = {

        "Accent",
        "Main",
        "Sidebar",
        "Content",
        "Card",
        "Button",
        "Text",
        "SubText",
        "LogoBackground",
        "Close",

    }

    return Names

end

--==================================================
-- COLOR TO RGB
--==================================================

function Settings:ColorToRGB(Color)

    if typeof(Color) ~= "Color3" then

        return 0, 0, 0

    end

    return
        math.floor(
            Color.R * 255 + 0.5
        ),
        math.floor(
            Color.G * 255 + 0.5
        ),
        math.floor(
            Color.B * 255 + 0.5
        )

end

--==================================================
-- CREATE COLOR ROW
--==================================================

function Settings:CreateColorRow(
    Name,
    Parent,
    Order
)

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Row =
        Instance.new("TextButton")

    Row.Name =
        "Color_" .. Name

    Row.Size =
        UDim2.new(
            1,
            -8,
            0,
            40
        )

    Row.BackgroundColor3 =
        CurrentTheme.Button
        or CurrentTheme.Card

    Row.BorderSizePixel =
        0

    Row.Text =
        ""

    Row.AutoButtonColor =
        false

    Row.LayoutOrder =
        Order or 0

    Row.ZIndex =
        507

    Row.Parent =
        Parent

    self:AddCorner(
        Row,
        7
    )

    local ColorPreview =
        Instance.new("Frame")

    ColorPreview.Name =
        "Preview"

    ColorPreview.Size =
        UDim2.new(
            0,
            26,
            0,
            26
        )

    ColorPreview.Position =
        UDim2.new(
            0,
            8,
            0.5,
            -13
        )

    ColorPreview.BackgroundColor3 =
        CurrentTheme[Name]
        or Color3.fromRGB(
            255,
            255,
            255
        )

    ColorPreview.BorderSizePixel =
        0

    ColorPreview.ZIndex =
        508

    ColorPreview.Parent =
        Row

    self:AddCorner(
        ColorPreview,
        6
    )

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -120,
            1,
            0
        )

    Label.Position =
        UDim2.new(
            0,
            45,
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
        11

    Label.Font =
        Enum.Font.GothamMedium

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.ZIndex =
        508

    Label.Parent =
        Row

    local R, G, B =
        self:ColorToRGB(
            CurrentTheme[Name]
        )

    local RGBLabel =
        Instance.new("TextLabel")

    RGBLabel.Name =
        "RGB"

    RGBLabel.Size =
        UDim2.new(
            0,
            70,
            1,
            0
        )

    RGBLabel.Position =
        UDim2.new(
            1,
            -78,
            0,
            0
        )

    RGBLabel.BackgroundTransparency =
        1

    RGBLabel.Text =
        string.format(
            "%d,%d,%d",
            R,
            G,
            B
        )

    RGBLabel.TextColor3 =
        CurrentTheme.SubText

    RGBLabel.TextSize =
        9

    RGBLabel.Font =
        Enum.Font.Code

    RGBLabel.TextXAlignment =
        Enum.TextXAlignment.Right

    RGBLabel.ZIndex =
        508

    RGBLabel.Parent =
        Row

    Row.MouseButton1Click:Connect(
        function()

            self:OpenColorEditor(
                Name
            )

        end
    )

    return Row

end

--==================================================
-- CREATE COLOR PANEL
--==================================================

function Settings:CreateColorPanel()

    if self.ColorPanel then

        self.ColorPanel:Destroy()

        self.ColorPanel =
            nil

    end

    local Theme =
        self.Theme:GetCurrent()

    local Panel =
        Instance.new("Frame")

    Panel.Name =
        "ColorPanel"

    Panel.Size =
        UDim2.new(
            1,
            -5,
            0,
            260
        )

    Panel.BackgroundColor3 =
        Theme.Card

    Panel.BorderSizePixel =
        0

    Panel.LayoutOrder =
        2

    Panel.ZIndex =
        504

    Panel.Parent =
        self.Scroll

    self:AddCorner(
        Panel,
        8
    )

    local Title =
        Instance.new("TextLabel")

    Title.Size =
        UDim2.new(
            1,
            -20,
            0,
            30
        )

    Title.Position =
        UDim2.new(
            0,
            10,
            0,
            4
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "🎨 Cores do Tema"

    Title.TextColor3 =
        Theme.Text

    Title.TextSize =
        12

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        505

    Title.Parent =
        Panel

    local Hint =
        Instance.new("TextLabel")

    Hint.Size =
        UDim2.new(
            1,
            -20,
            0,
            20
        )

    Hint.Position =
        UDim2.new(
            0,
            10,
            0,
            28
        )

    Hint.BackgroundTransparency =
        1

    Hint.Text =
        "Clique em uma cor para editar"

    Hint.TextColor3 =
        Theme.SubText

    Hint.TextSize =
        9

    Hint.Font =
        Enum.Font.Gotham

    Hint.TextXAlignment =
        Enum.TextXAlignment.Left

    Hint.ZIndex =
        505

    Hint.Parent =
        Panel

    local ColorScroll =
        Instance.new("ScrollingFrame")

    ColorScroll.Name =
        "ColorScroll"

    ColorScroll.Position =
        UDim2.new(
            0,
            8,
            0,
            52
        )

    ColorScroll.Size =
        UDim2.new(
            1,
            -16,
            1,
            -60
        )

    ColorScroll.BackgroundTransparency =
        1

    ColorScroll.BorderSizePixel =
        0

    ColorScroll.ScrollBarThickness =
        4

    ColorScroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    ColorScroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    ColorScroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    ColorScroll.ZIndex =
        505

    ColorScroll.Parent =
        Panel

    local Layout =
        Instance.new("UIListLayout")

    Layout.Padding =
        UDim.new(
            0,
            4
        )

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent =
        ColorScroll

    for Index, Name in
        ipairs(
            self:GetColorNames()
        ) do

        self:CreateColorRow(
            Name,
            ColorScroll,
            Index
        )

    end

    self.ColorPanel =
        Panel

end

--==================================================
-- OPEN COLOR EDITOR
--==================================================

function Settings:OpenColorEditor(
    Name
)

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Existing =
        self.ColorEditor

    if Existing then

        Existing:Destroy()

        self.ColorEditor =
            nil

    end

    local Editor =
        Instance.new("Frame")

    Editor.Name =
        "ColorEditor"

    Editor.Size =
        UDim2.new(
            0,
            250,
            0,
            180
        )

    Editor.Position =
        UDim2.new(
            1,
            -260,
            0,
            70
        )

    Editor.BackgroundColor3 =
        CurrentTheme.Card

    Editor.BorderSizePixel =
        0

    Editor.ZIndex =
        900

    Editor.Parent =
        self.UI.Main

    self:AddCorner(
        Editor,
        10
    )

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        1.5

    Stroke.Parent =
        Editor

    local Title =
        Instance.new("TextLabel")

    Title.Size =
        UDim2.new(
            1,
            -20,
            0,
            30
        )

    Title.Position =
        UDim2.new(
            0,
            10,
            0,
            5
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "Editar: " ..
        Name

    Title.TextColor3 =
        CurrentTheme.Text

    Title.TextSize =
        12

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        901

    Title.Parent =
        Editor

    local Info =
        Instance.new("TextLabel")

    Info.Size =
        UDim2.new(
            1,
            -20,
            0,
            45
        )

    Info.Position =
        UDim2.new(
            0,
            10,
            0,
            38
        )

    Info.BackgroundTransparency =
        1

    Info.Text =
        "A edição de cores é aplicada\n"
        .. "ao tema durante esta execução."

    Info.TextColor3 =
        CurrentTheme.SubText

    Info.TextSize =
        9

    Info.Font =
        Enum.Font.Gotham

    Info.TextXAlignment =
        Enum.TextXAlignment.Left

    Info.ZIndex =
        901

    Info.Parent =
        Editor

    local CurrentColor =
        CurrentTheme[Name]

    if typeof(CurrentColor) ~=
        "Color3" then

        CurrentColor =
            Color3.fromRGB(
                255,
                255,
                255
            )

    end

    local R, G, B =
        self:ColorToRGB(
            CurrentColor
        )

    local Value =
        Instance.new("TextLabel")

    Value.Size =
        UDim2.new(
            1,
            -20,
            0,
            25
        )

    Value.Position =
        UDim2.new(
            0,
            10,
            0,
            88
        )

        Value.Size =
        UDim2.new(
            1,
            -20,
            0,
            25
        )

    Value.Position =
        UDim2.new(
            0,
            10,
            0,
            88
        )

    Value.BackgroundTransparency =
        1

    Value.Text =
        string.format(
            "RGB: %d, %d, %d",
            R,
            G,
            B
        )

    Value.TextColor3 =
        CurrentTheme.Text

    Value.TextSize =
        11

    Value.Font =
        Enum.Font.Code

    Value.TextXAlignment =
        Enum.TextXAlignment.Left

    Value.ZIndex =
        901

    Value.Parent =
        Editor

    --==================================================
    -- RGB INPUT
    --==================================================

    local Input =
        Instance.new("TextBox")

    Input.Name =
        "RGBInput"

    Input.Size =
        UDim2.new(
            1,
            -20,
            0,
            32
        )

    Input.Position =
        UDim2.new(
            0,
            10,
            0,
            118
        )

    Input.BackgroundColor3 =
        CurrentTheme.Button
        or CurrentTheme.Card

    Input.BorderSizePixel =
        0

    Input.Text =
        string.format(
            "%d,%d,%d",
            R,
            G,
            B
        )

    Input.PlaceholderText =
        "R,G,B"

    Input.TextColor3 =
        CurrentTheme.Text

    Input.PlaceholderColor3 =
        CurrentTheme.SubText

    Input.TextSize =
        11

    Input.Font =
        Enum.Font.Code

    Input.ClearTextOnFocus =
        false

    Input.ZIndex =
        901

    Input.Parent =
        Editor

    self:AddCorner(
        Input,
        7
    )

    local InputPadding =
        Instance.new("UIPadding")

    InputPadding.PaddingLeft =
        UDim.new(
            0,
            8
        )

    InputPadding.PaddingRight =
        UDim.new(
            0,
            8
        )

    InputPadding.Parent =
        Input

    --==================================================
    -- APPLY BUTTON
    --==================================================

    local Apply =
        Instance.new("TextButton")

    Apply.Name =
        "Apply"

    Apply.Size =
        UDim2.new(
            0,
            105,
            0,
            28
        )

    Apply.Position =
        UDim2.new(
            0,
            10,
            1,
            -38
        )

    Apply.BackgroundColor3 =
        self.Theme:GetAccent()

    Apply.BorderSizePixel =
        0

    Apply.Text =
        "Aplicar"

    Apply.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

    Apply.TextSize =
        10

    Apply.Font =
        Enum.Font.GothamBold

    Apply.AutoButtonColor =
        false

    Apply.ZIndex =
        902

    Apply.Parent =
        Editor

    self:AddCorner(
        Apply,
        7
    )

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
            105,
            0,
            28
        )

    Close.Position =
        UDim2.new(
            1,
            -115,
            1,
            -38
        )

    Close.BackgroundColor3 =
        CurrentTheme.Button
        or CurrentTheme.Card

    Close.BorderSizePixel =
        0

    Close.Text =
        "Cancelar"

    Close.TextColor3 =
        CurrentTheme.Text

    Close.TextSize =
        10

    Close.Font =
        Enum.Font.GothamMedium

    Close.AutoButtonColor =
        false

    Close.ZIndex =
        902

    Close.Parent =
        Editor

    self:AddCorner(
        Close,
        7
    )

    --==================================================
    -- APPLY COLOR
    --==================================================

    Apply.MouseButton1Click:Connect(
        function()

            local Text =
                Input.Text or ""

            local R2,
                G2,
                B2 =
                Text:match(
                    "^%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*$"
                )

            R2 =
                tonumber(R2)

            G2 =
                tonumber(G2)

            B2 =
                tonumber(B2)

            if not R2
            or not G2
            or not B2 then

                Input.Text =
                    string.format(
                        "%d,%d,%d",
                        R,
                        G,
                        B
                    )

                return

            end

            R2 =
                math.clamp(
                    R2,
                    0,
                    255
                )

            G2 =
                math.clamp(
                    G2,
                    0,
                    255
                )

            B2 =
                math.clamp(
                    B2,
                    0,
                    255
                )

            local NewColor =
                Color3.fromRGB(
                    R2,
                    G2,
                    B2
                )

            --==================================================
            -- ALTERA O TEMA ATUAL
            --==================================================

            CurrentTheme[Name] =
                NewColor

            --==================================================
            -- ATUALIZA UI
            --==================================================

            self:ApplyTheme()

            --==================================================
            -- ATUALIZA EDITOR
            --==================================================

            Value.Text =
                string.format(
                    "RGB: %d, %d, %d",
                    R2,
                    G2,
                    B2
                )

            --==================================================
            -- ATUALIZA INPUT
            --==================================================

            Input.Text =
                string.format(
                    "%d,%d,%d",
                    R2,
                    G2,
                    B2
                )

            --==================================================
            -- ATUALIZA PAINEL
            --==================================================

            self:RefreshColorPanel()

        end
    )

    --==================================================
    -- CLOSE
    --==================================================

    Close.MouseButton1Click:Connect(
        function()

            if self.ColorEditor then

                self.ColorEditor:Destroy()

                self.ColorEditor =
                    nil

            end

        end
    )

    self.ColorEditor =
        Editor

end

--==================================================
-- REFRESH COLOR PANEL
--==================================================

function Settings:RefreshColorPanel()

    if not self.ColorPanel then
        return
    end

    local Parent =
        self.ColorPanel

    local ColorScroll =
        Parent:FindFirstChild(
            "ColorScroll"
        )

    if not ColorScroll then
        return
    end

    for _, Object in
        ipairs(
            ColorScroll:GetChildren()
        ) do

        if not Object:IsA("UIListLayout") then

            Object:Destroy()

        end

    end

    for Index, Name in
        ipairs(
            self:GetColorNames()
        ) do

        self:CreateColorRow(
            Name,
            ColorScroll,
            Index
        )

    end

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
    -- LOGO
    --==================================================

    self:CreateToggle(

        "Mostrar Logo",

        function()

            return self.Config.UI.ShowLogo

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

    if self.UI then

        self.UI:ApplyTheme()

    end

    if self.Logo then

        self.Logo:ApplyTheme()

    end

    if self.Categories then

        self.Categories:ApplyTheme()

    end

    if not self.Scroll then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
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

            Object.TextColor3 =
                CurrentTheme.Text

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

        elseif Object:IsA("ScrollingFrame") then

            Object.ScrollBarImageColor3 =
                self.Theme:GetAccent()

        end

    end

    --==================================================
    -- COLOR EDITOR
    --==================================================

    if self.ColorEditor then

        local Editor =
            self.ColorEditor

        local EditorStroke =
            Editor:FindFirstChildOfClass(
                "UIStroke"
            )

        if EditorStroke then

            EditorStroke.Color =
                self.Theme:GetAccent()

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Settings

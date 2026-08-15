--// 💥 RIMURU HUB
--// Settings System
--// SIDE COLOR/THEME PANEL
--// Scroll + Theme Selector + Color Editor
--// Responsive + External Panel

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

    self.ColorPanelOpen =
        false

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Settings:ClearContent()

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
-- CREATE CORNER
--==================================================

function Settings:AddCorner(
    Object,
    Radius
)

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
-- CREATE SECTION LABEL
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
        "Section_" ..
        Text

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

    Button.BackgroundTransparency =
        0.15

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

    Button.BackgroundTransparency =
        0.15

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

                Callback(
                    Button
                )

            end

        end
    )

    return Button

end

--==================================================
-- CREATE THEME BUTTON
--==================================================

function Settings:CreateThemeButton()

    local Theme =
        self.Theme:GetCurrent()

    local Button =
        Instance.new("TextButton")

    Button.Name =
        "ColorThemeButton"

    Button.Size =
        UDim2.new(
            1,
            -5,
            0,
            45
        )

    Button.BackgroundColor3 =
        Theme.Card

    Button.BackgroundTransparency =
        0.15

    Button.BorderSizePixel =
        0

    Button.Text =
        "🎨  Cores / Tema"

    Button.TextColor3 =
        Theme.Text

    Button.TextSize =
        12

    Button.Font =
        Enum.Font.GothamBold

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        0

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

            self:ToggleColorPanel()

        end
    )

    self.ThemeButton =
        Button

    return Button

end

--==================================================
-- CREATE SIDE PANEL
--==================================================

function Settings:CreateColorPanel()

    if self.ColorPanel then

        self.ColorPanel:Destroy()

        self.ColorPanel =
            nil

    end

    if not self.UI
    or not self.UI.Main then

        return

    end

    local Main =
        self.UI.Main

    local Theme =
        self.Theme:GetCurrent()

    --==================================================
    -- PANEL
    --==================================================

    local Panel =
        Instance.new("Frame")

    Panel.Name =
        "RimuruColorThemePanel"

    Panel.Size =
        UDim2.new(
            0,
            250,
            0,
            330
        )

    Panel.BackgroundColor3 =
        Theme.Main

    Panel.BackgroundTransparency =
        0.05

    Panel.BorderSizePixel =
        0

    Panel.ZIndex =
        1000

    Panel.Visible =
        false

    Panel.Parent =
        self.UI.Gui

    self:AddCorner(
        Panel,
        12
    )

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        1.5

    Stroke.Parent =
        Panel

    self.ColorPanelStroke =
        Stroke

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
            12,
            0,
            8
        )

    Title.Size =
        UDim2.new(
            1,
            -45,
            0,
            25
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "🎨  Cores / Tema"

    Title.TextColor3 =
        Theme.Text

    Title.TextSize =
        14

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        1001

    Title.Parent =
        Panel

    self.ColorPanelTitle =
        Title

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
            26,
            0,
            26
        )

    Close.Position =
        UDim2.new(
            1,
            -34,
            0,
            8
        )

    Close.BackgroundColor3 =
        Theme.Close

    Close.BorderSizePixel =
        0

    Close.Text =
        "×"

    Close.TextColor3 =
        Theme.Text

    Close.TextSize =
        16

    Close.Font =
        Enum.Font.GothamBold

    Close.AutoButtonColor =
        false

    Close.ZIndex =
        1002

    Close.Parent =
        Panel

    self:AddCorner(
        Close,
        6
    )

    Close.MouseButton1Click:Connect(
        function()

            self:SetColorPanelVisible(
                false
            )

        end
    )

    --==================================================
    -- SCROLL
    --==================================================

    local Scroll =
        Instance.new("ScrollingFrame")

    Scroll.Name =
        "ThemeColorScroll"

    Scroll.Position =
        UDim2.new(
            0,
            8,
            0,
            42
        )

    Scroll.Size =
        UDim2.new(
            1,
            -16,
            1,
            -50
        )

    Scroll.BackgroundTransparency =
        1

    Scroll.BorderSizePixel =
        0

    Scroll.ScrollBarThickness =
        5

    Scroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    Scroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Scroll.ZIndex =
        1001

    Scroll.Parent =
        Panel

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingBottom =
        UDim.new(
            0,
            8
        )

    Padding.Parent =
        Scroll

    local Layout =
        Instance.new("UIListLayout")

    Layout.Padding =
        UDim.new(
            0,
            5
        )

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent =
        Scroll

    self.ColorPanel =
        Panel

    self.ColorScroll =
        Scroll

    --==================================================
    -- BUILD PANEL
    --==================================================

    self:BuildColorPanel()

end

--==================================================
-- BUILD COLOR PANEL
--==================================================

function Settings:BuildColorPanel()

    if not self.ColorScroll then
        return
    end

    for _, Object in
        ipairs(
            self.ColorScroll:GetChildren()
        ) do

        if not Object:IsA("UIListLayout")
        and not Object:IsA("UIPadding") then

            Object:Destroy()

        end

    end

    local Theme =
        self.Theme:GetCurrent()

    --==================================================
    -- THEME SECTION
    --==================================================

    local ThemeLabel =
        Instance.new("TextLabel")

    ThemeLabel.Size =
        UDim2.new(
            1,
            -8,
            0,
            24
        )

    ThemeLabel.BackgroundTransparency =
        1

    ThemeLabel.Text =
        "TEMAS"

    ThemeLabel.TextColor3 =
        Theme.Text

    ThemeLabel.TextSize =
        10

    ThemeLabel.Font =
        Enum.Font.GothamBold

    ThemeLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    ThemeLabel.LayoutOrder =
        1

    ThemeLabel.ZIndex =
        1002

    ThemeLabel.Parent =
        self.ColorScroll

    --==================================================
    -- THEME LIST
    --==================================================

    local ThemeNames =
        self.Theme:GetThemeNames()

    local Themes =
        self.Theme:GetThemes()

    for Index, ThemeName in
        ipairs(
            ThemeNames
        ) do

        local ThemeData =
            Themes[ThemeName]

        local Button =
            Instance.new("TextButton")

        Button.Name =
            "Theme_" ..
            ThemeName

        Button.Size =
            UDim2.new(
                1,
                -8,
                0,
                34
            )

        Button.BackgroundColor3 =
            ThemeData.Card
            or Theme.Card

        Button.BackgroundTransparency =
            0.10

        Button.BorderSizePixel =
            0

        Button.Text =
            "  " ..
            ThemeName

        Button.TextColor3 =
            ThemeData.Text
            or Theme.Text

        Button.TextSize =
            10

        Button.Font =
            Enum.Font.GothamMedium

        Button.TextXAlignment =
            Enum.TextXAlignment.Left

        Button.AutoButtonColor =
            false

        Button.LayoutOrder =
            10 + Index

        Button.ZIndex =
            1002

        Button.Parent =
            self.ColorScroll

        self:AddCorner(
            Button,
            7
        )

        local Accent =
            Instance.new("Frame")

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
            or self.Theme:GetAccent()

        Accent.BorderSizePixel =
            0

        Accent.ZIndex =
            1003

        Accent.Parent =
            Button

        self:AddCorner(
            Accent,
            3
        )

        Button.MouseButton1Click:Connect(
            function()

                if self.Theme:SetTheme(
                    ThemeName
                ) then

                    self:ApplyTheme()

                    self:BuildColorPanel()

                end

            end
        )

    end

    --==================================================
    -- COLOR SECTION
    --==================================================

    local ColorLabel =
        Instance.new("TextLabel")

    ColorLabel.Size =
        UDim2.new(
            1,
            -8,
            0,
            24
        )

    ColorLabel.BackgroundTransparency =
        1

    ColorLabel.Text =
        "CORES"

    ColorLabel.TextColor3 =
        Theme.Text

    ColorLabel.TextSize =
        10

    ColorLabel.Font =
        Enum.Font.GothamBold

    ColorLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    ColorLabel.LayoutOrder =
        100

    ColorLabel.ZIndex =
        1002

    ColorLabel.Parent =
        self.ColorScroll

    --==================================================
    -- COLOR ROWS
    --==================================================

    for Index, Name in
        ipairs(
            self:GetColorNames()
        ) do

        self:CreateColorRow(
            Name,
            self.ColorScroll,
            100 + Index
        )

    end

end

--==================================================
-- TOGGLE PANEL
--==================================================

function Settings:ToggleColorPanel()

    self:SetColorPanelVisible(
        not self.ColorPanelOpen
    )

end

--==================================================
-- PANEL POSITION
--==================================================

function Settings:UpdateColorPanelPosition()

    if not self.ColorPanel
    or not self.UI
    or not self.UI.Main then

        return

    end

    local Main =
        self.UI.Main

    local Panel =
        self.ColorPanel

    local MainPosition =
        Main.AbsolutePosition

    local MainSize =
        Main.AbsoluteSize

    local Viewport =
        workspace.CurrentCamera
        and workspace.CurrentCamera.ViewportSize

    if not Viewport then
        return
    end

    local Gap =
        8

    local PanelWidth =
        Panel.AbsoluteSize.X

    local PanelHeight =
        Panel.AbsoluteSize.Y

    local X =
        MainPosition.X +
        MainSize.X +
        Gap

    local Y =
        MainPosition.Y

    --==================================================
    -- RIGHT SIDE CHECK
    --==================================================

    if X + PanelWidth >
        Viewport.X then

        X =
            MainPosition.X -
            PanelWidth -
            Gap

    end

    --==================================================
    -- VERTICAL CHECK
    --==================================================

    if Y + PanelHeight >
        Viewport.Y then

        Y =
            Viewport.Y -
            PanelHeight -
            8

    end

    if Y < 8 then
        Y = 8
    end

    Panel.Position =
        UDim2.new(
            0,
            math.floor(X),
            0,
            math.floor(Y)
        )

end

--==================================================
-- SET PANEL VISIBLE
--==================================================

function Settings:SetColorPanelVisible(
    Value
)

    if not self.ColorPanel then

        self:CreateColorPanel()

    end

    if not self.ColorPanel then
        return
    end

    self.ColorPanelOpen =
        Value == true

    self.ColorPanel.Visible =
        self.ColorPanelOpen

    if self.ColorPanelOpen then

        self:BuildColorPanel()

        task.defer(
            function()

                self:UpdateColorPanelPosition()

            end
        )

    end

end

--==================================================
-- GET COLOR NAMES
--==================================================

function Settings:GetColorNames()

    return {

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

end

--==================================================
-- COLOR TO RGB
--==================================================

function Settings:ColorToRGB(
    Color
)

    if typeof(Color) ~=
        "Color3" then

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
        "Color_" ..
        Name

    Row.Size =
        UDim2.new(
            1,
            -8,
            0,
            38
    )

    Row.BackgroundColor3 =
        CurrentTheme.Button
        or CurrentTheme.Card

    Row.BackgroundTransparency =
        0.10

    Row.BorderSizePixel =
        0

    Row.Text =
        ""

    Row.AutoButtonColor =
        false

    Row.LayoutOrder =
        Order or 0

    Row.ZIndex =
        1002

    Row.Parent =
        Parent

    self:AddCorner(
        Row,
        7
    )

    --==================================================
    -- COLOR PREVIEW
    --==================================================

    local Preview =
        Instance.new("Frame")

    Preview.Name =
        "Preview"

    Preview.Size =
        UDim2.new(
            0,
            24,
            0,
            24
        )

    Preview.Position =
        UDim2.new(
            0,
            7,
            0.5,
            -12
        )

    Preview.BackgroundColor3 =
        CurrentTheme[Name]
        or Color3.fromRGB(
            255,
            255,
            255
        )

    Preview.BorderSizePixel =
        0

    Preview.ZIndex =
        1003

    Preview.Parent =
        Row

    self:AddCorner(
        Preview,
        6
    )

    --==================================================
    -- COLOR NAME
    --==================================================

    local Label =
        Instance.new("TextLabel")

    Label.Name =
        "Name"

    Label.Position =
        UDim2.new(
            0,
            40,
            0,
            0
        )

    Label.Size =
        UDim2.new(
            1,
            -115,
            1,
            0
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        Name

    Label.TextColor3 =
        CurrentTheme.Text

    Label.TextSize =
        10

    Label.Font =
        Enum.Font.GothamMedium

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.ZIndex =
        1003

    Label.Parent =
        Row

    --==================================================
    -- RGB VALUE
    --==================================================

    local R, G, B =
        self:ColorToRGB(
            CurrentTheme[Name]
        )

    local RGB =
        Instance.new("TextLabel")

    RGB.Name =
        "RGB"

    RGB.Size =
        UDim2.new(
            0,
            65,
            1,
            0
        )

    RGB.Position =
        UDim2.new(
            1,
            -72,
            0,
            0
        )

    RGB.BackgroundTransparency =
        1

    RGB.Text =
        string.format(
            "%d,%d,%d",
            R,
            G,
            B
        )

    RGB.TextColor3 =
        CurrentTheme.SubText

    RGB.TextSize =
        8

    RGB.Font =
        Enum.Font.Code

    RGB.TextXAlignment =
        Enum.TextXAlignment.Right

    RGB.ZIndex =
        1003

    RGB.Parent =
        Row

    --==================================================
    -- CLICK
    --==================================================

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
-- OPEN COLOR EDITOR
--==================================================

function Settings:OpenColorEditor(
    Name
)

    local Existing =
        self.ColorEditor

    if Existing then

        Existing:Destroy()

        self.ColorEditor =
            nil

    end

    local Main =
        self.UI
        and self.UI.Main

    if not Main then
        return
    end

    local Theme =
        self.Theme:GetCurrent()

    --==================================================
    -- EDITOR
    --==================================================

    local Editor =
        Instance.new("Frame")

    Editor.Name =
        "ColorEditor"

    Editor.Size =
        UDim2.new(
            0,
            235,
            0,
            175
        )

    Editor.Position =
        UDim2.new(
            1,
            -245,
            0,
            70
        )

    Editor.BackgroundColor3 =
        Theme.Card

    Editor.BackgroundTransparency =
        0.03

    Editor.BorderSizePixel =
        0

    Editor.ZIndex =
        1100

    Editor.Parent =
        Main

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

    --==================================================
    -- TITLE
    --==================================================

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
            6
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "Editar: " ..
        Name

    Title.TextColor3 =
        Theme.Text

    Title.TextSize =
        12

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        1101

    Title.Parent =
        Editor

    --==================================================
    -- INFO
    --==================================================

    local Info =
        Instance.new("TextLabel")

    Info.Size =
        UDim2.new(
            1,
            -20,
            0,
            35
        )

    Info.Position =
        UDim2.new(
            0,
            10,
            0,
            34
        )

    Info.BackgroundTransparency =
        1

    Info.Text =
        "Use RGB para alterar esta cor."

    Info.TextColor3 =
        Theme.SubText

    Info.TextSize =
        9

    Info.Font =
        Enum.Font.Gotham

    Info.TextXAlignment =
        Enum.TextXAlignment.Left

    Info.ZIndex =
        1101

    Info.Parent =
        Editor

    --==================================================
    -- RGB BOX
    --==================================================

    local CurrentColor =
        Theme[Name]

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

    local RGBBox =
        Instance.new("TextBox")

    RGBBox.Name =
        "RGBInput"

    RGBBox.Size =
        UDim2.new(
            1,
            -20,
            0,
            35
        )

    RGBBox.Position =
        UDim2.new(
            0,
            10,
            0,
            75
        )

    RGBBox.BackgroundColor3 =
        Theme.Button
        or Theme.Card

    RGBBox.BackgroundTransparency =
        0.10

    RGBBox.BorderSizePixel =
        0

    RGBBox.Text =
        string.format(
            "%d, %d, %d",
            R,
            G,
            B
        )

    RGBBox.PlaceholderText =
        "R, G, B"

    RGBBox.TextColor3 =
        Theme.Text

    RGBBox.PlaceholderColor3 =
        Theme.SubText

    RGBBox.TextSize =
        10

    RGBBox.Font =
        Enum.Font.Code

    RGBBox.ClearTextOnFocus =
        false

    RGBBox.ZIndex =
        1101

    RGBBox.Parent =
        Editor

    self:AddCorner(
        RGBBox,
        7
    )

    --==================================================
    -- APPLY
    --==================================================

    local Apply =
        Instance.new("TextButton")

    Apply.Name =
        "Apply"

    Apply.Size =
        UDim2.new(
            0,
            100,
            0,
            32
        )

    Apply.Position =
        UDim2.new(
            0,
            10,
            1,
            -42
        )

    Apply.BackgroundColor3 =
        self.Theme:GetAccent()

    Apply.BorderSizePixel =
        0

    Apply.Text =
        "Aplicar"

    Apply.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    Apply.TextSize =
        10

    Apply.Font =
        Enum.Font.GothamBold

    Apply.AutoButtonColor =
        false

    Apply.ZIndex =
        1101

    Apply.Parent =
        Editor

    self:AddCorner(
        Apply,
        7
    )

    --==================================================
    -- CANCEL
    --==================================================

    local Cancel =
        Instance.new("TextButton")

    Cancel.Name =
        "Cancel"

    Cancel.Size =
        UDim2.new(
            0,
            100,
            0,
            32
        )

    Cancel.Position =
        UDim2.new(
            1,
            -110,
            1,
            -42
        )

    Cancel.BackgroundColor3 =
        Theme.Close

    Cancel.BorderSizePixel =
        0

    Cancel.Text =
        "Fechar"

    Cancel.TextColor3 =
        Theme.Text

    Cancel.TextSize =
        10

    Cancel.Font =
        Enum.Font.GothamBold

    Cancel.AutoButtonColor =
        false

    Cancel.ZIndex =
        1101

    Cancel.Parent =
        Editor

    self:AddCorner(
        Cancel,
        7
    )

    --==================================================
    -- APPLY FUNCTION
    --==================================================

    Apply.MouseButton1Click:Connect(
        function()

            local Text =
                RGBBox.Text

            local Values = {}

            for Number in
                string.gmatch(
                    Text,
                    "%d+"
                ) do

                table.insert(
                    Values,
                    tonumber(Number)
                )

            end

            if #Values < 3 then

                warn(
                    "[Rimuru Hub] RGB inválido. Use R, G, B."
                )

                return

            end

            local NewColor =
                Color3.fromRGB(
                    math.clamp(
                        Values[1],
                        0,
                        255
                    ),
                    math.clamp(
                        Values[2],
                        0,
                        255
                    ),
                    math.clamp(
                        Values[3],
                        0,
                        255
                    )
                )

            if self.Theme.SetColor then

                pcall(
                    function()

                        self.Theme:SetColor(
                            Name,
                            NewColor
                        )

                    end
                )

            else

                Theme[Name] =
                    NewColor

            end

            self:ApplyTheme()

            self:BuildColorPanel()

            Editor:Destroy()

            self.ColorEditor =
                nil

        end
    )

    --==================================================
    -- CLOSE EDITOR
    --==================================================

    Cancel.MouseButton1Click:Connect(
        function()

            Editor:Destroy()

            self.ColorEditor =
                nil

        end
    )

    self.ColorEditor =
        Editor

end

--==================================================
-- APPLY THEME
--==================================================

function Settings:ApplyTheme()

    if not self.UI then
        return
    end

    local Theme =
        self.Theme:GetCurrent()

    if not Theme then
        return
    end

    --==================================================
    -- MAIN
    --==================================================

    if self.UI.Main then

        self.UI.Main.BackgroundColor3 =
            Theme.Main

    end

    if self.UI.MainStroke then

        self.UI.MainStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- BACKGROUND
    --==================================================

    if self.UI.BackgroundImage then

        self.UI.BackgroundImage.ImageTransparency =
            self.UI:GetBackgroundTransparency()

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.UI.Sidebar then

        self.UI.Sidebar.BackgroundColor3 =
            Theme.Sidebar

        self.UI.Sidebar.BackgroundTransparency =
            0.15

    end

    --==================================================
    -- CONTENT
    --==================================================

    if self.UI.Content then

        self.UI.Content.BackgroundColor3 =
            Theme.Content

        self.UI.Content.BackgroundTransparency =
            0.15

    end

    --==================================================
    -- TITLE
    --==================================================

    if self.UI.Title then

        self.UI.Title.TextColor3 =
            Theme.Text

    end

    if self.UI.Subtitle then

        self.UI.Subtitle.TextColor3 =
            Theme.SubText

    end

    if self.UI.ContentTitle then

        self.UI.ContentTitle.TextColor3 =
            Theme.Text

    end

    --==================================================
    -- HEADER LOGO
    --==================================================

    if self.UI.HeaderLogo then

        self.UI.HeaderLogo.BackgroundTransparency =
            1

    end

    --==================================================
    -- COLOR PANEL
    --==================================================

    if self.ColorPanel then

        self.ColorPanel.BackgroundColor3 =
            Theme.Main

    end

    if self.ColorPanelStroke then

        self.ColorPanelStroke.Color =
            self.Theme:GetAccent()

    end

    if self.ColorPanelTitle then

        self.ColorPanelTitle.TextColor3 =
            Theme.Text

    end

    --==================================================
    -- REFRESH
    --==================================================

    if self.ColorPanelOpen then

        self:BuildColorPanel()

    end

end

--==================================================
-- UPDATE POSITION LOOP
--==================================================

function Settings:StartPanelPositionUpdater()

    if self.PanelPositionConnection then
        return
    end

    self.PanelPositionConnection =
        game:GetService("RunService").RenderStepped:Connect(
            function()

                if self.ColorPanelOpen then

                    self:UpdateColorPanelPosition()

                end

            end
        )

end

--==================================================
-- BUILD SETTINGS
--==================================================

function Settings:Build()

    self:ClearContent()

    if self.ColorPanel then

        self.ColorPanel.Visible =
            false

        self.ColorPanelOpen =
            false

    end

    self.ContentTitle.Text =
        "Configurações"

    --==================================================
    -- UI
    --==================================================

    self:CreateSectionLabel(
        "INTERFACE",
        1
    )

    self:CreateToggle(
        "Menu Arrastável",
        function()

            return self.Config.UI.MainMenuDraggable

        end,
        function(Value)

            self.Config.UI.MainMenuDraggable =
                Value

        end,
        2
    )

    self:CreateToggle(
        "Animações",
        function()

            return self.Config.UI.Animations

        end,
        function(Value)

            self.Config.UI.Animations =
                Value

        end,
        3
    )

    self:CreateButton(
        "ResetUI",
        "↻  Resetar posição da interface",
        4,
        function()

            if self.UI.Main then

                self.UI.Main.Position =
                    UDim2.new(
                        0.5,
                        -300,
                        0.5,
                        -200
                    )

            end

        end
    )

    --==================================================
    -- THEME
    --==================================================

    self:CreateSectionLabel(
        "APARÊNCIA",
        10
    )

    self:CreateThemeButton()

    --==================================================
    -- PANEL
    --==================================================

    if not self.ColorPanel then

        self:CreateColorPanel()

    end

    self:StartPanelPositionUpdater()

end

--==================================================
-- RETURN
--==================================================

return Settings

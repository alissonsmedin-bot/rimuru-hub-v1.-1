--// 💥 RIMURU HUB
--// UI Topbar System
--// Modular UI Architecture

local Topbar = {}

--==================================================
-- INIT
--==================================================

function Topbar:Init(Context)

    self.Context =
        Context or {}

    self.UI =
        self.Context.UI

    self.Theme =
        self.Context.Theme

    self.Window =
        nil

    self.Container =
        nil

    self.Title =
        nil

    self.CloseButton =
        nil

    self.MinimizeButton =
        nil

    self:_Create()

end

--==================================================
-- CREATE
--==================================================

function Topbar:_Create()

    if not self.UI then
        return false
    end

    local Parent =
        self.UI.Main
        or self.UI.Window

    if not Parent
    or typeof(Parent) ~= "Instance"
    then
        return false
    end

    --==================================================
    -- TOPBAR
    --==================================================

    local Bar =
        Instance.new("Frame")

    Bar.Name =
        "Topbar"

    Bar.Size =
        UDim2.new(
            1,
            0,
            0,
            42
        )

    Bar.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Bar.BorderSizePixel =
        0

    Bar.BackgroundTransparency =
        0.75

    Bar.ZIndex =
        20

    Bar.Parent =
        Parent

    self.Container =
        Bar

    --==================================================
    -- TITLE
    --==================================================

    local Title =
        Instance.new(
            "TextLabel"
        )

    Title.Name =
        "Title"

    Title.BackgroundTransparency =
        1

    Title.Position =
        UDim2.new(
            0,
            14,
            0,
            0
        )

    Title.Size =
        UDim2.new(
            1,
            -120,
            1,
            0
        )

    Title.Text =
        "RIMURU HUB"

    Title.TextSize =
        15

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        21

    Title.Parent =
        Bar

    self.Title =
        Title

    --==================================================
    -- CLOSE BUTTON
    --==================================================

    local Close =
        Instance.new(
            "TextButton"
        )

    Close.Name =
        "Close"

    Close.Size =
        UDim2.new(
            0,
            32,
            0,
            32
        )

    Close.Position =
        UDim2.new(
            1,
            -38,
            0,
            5
        )

    Close.BackgroundTransparency =
        0.75

    Close.BorderSizePixel =
        0

    Close.Text =
        "×"

    Close.TextSize =
        20

    Close.Font =
        Enum.Font.GothamBold

    Close.AutoButtonColor =
        false

    Close.ZIndex =
        22

    Close.Parent =
        Bar

    self.CloseButton =
        Close

    --==================================================
    -- MINIMIZE BUTTON
    --==================================================

    local Minimize =
        Instance.new(
            "TextButton"
        )

    Minimize.Name =
        "Minimize"

    Minimize.Size =
        UDim2.new(
            0,
            32,
            0,
            32
        )

    Minimize.Position =
        UDim2.new(
            1,
            -74,
            0,
            5
        )

    Minimize.BackgroundTransparency =
        0.75

    Minimize.BorderSizePixel =
        0

    Minimize.Text =
        "−"

    Minimize.TextSize =
        18

    Minimize.Font =
        Enum.Font.GothamBold

    Minimize.AutoButtonColor =
        false

    Minimize.ZIndex =
        22

    Minimize.Parent =
        Bar

    self.MinimizeButton =
        Minimize

    return true

end

--==================================================
-- GET
--==================================================

function Topbar:Get()

    return self.Container

end

--==================================================
-- SET TITLE
--==================================================

function Topbar:SetTitle(
    Text
)

    if not self.Title then
        return false
    end

    self.Title.Text =
        tostring(
            Text or "RIMURU HUB"
        )

    return true

end

--==================================================
-- APPLY THEME
--==================================================

function Topbar:ApplyTheme()

    if not self.Container then
        return
    end

    self.Container.BackgroundTransparency =
        0.75

    if self.Theme
    and type(
        self.Theme.GetCurrent
    ) == "function"
    then

        local Success,
            ThemeData =
            pcall(
                function()

                    return self.Theme:
                        GetCurrent()

                end
            )

        if Success
        and type(ThemeData) == "table"
        then

            if self.Title then

                self.Title.TextColor3 =
                    ThemeData.Text

            end

            if self.CloseButton then

                self.CloseButton.TextColor3 =
                    ThemeData.Text

            end

            if self.MinimizeButton then

                self.MinimizeButton.TextColor3 =
                    ThemeData.Text

            end

        end

    end

end

return Topbar

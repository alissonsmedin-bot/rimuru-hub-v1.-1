--// 💥 RIMURU HUB
--// UI Transparency System
--// Centralized Transparency
--// Modular UI Architecture

local Transparency = {}

--==================================================
-- DEFAULTS
--==================================================

local DEFAULT_VALUE =
    0.75

--==================================================
-- INIT
--==================================================

function Transparency:Init(Context)

    self.Context =
        Context or {}

    self.UI =
        self.Context.UI

    self.Config =
        self.Context.Config

    self.Theme =
        self.Context.Theme

    self.Value =
        DEFAULT_VALUE

    self:_Load()

end

--==================================================
-- LOAD
--==================================================

function Transparency:_Load()

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config
    and self.Config.UI
    and self.Config.UI.Transparency
    ~= nil
    then

        local Value =
            tonumber(
                self.Config.UI.Transparency
            )

        if Value then

            self.Value =
                math.clamp(
                    Value,
                    0,
                    1
                )

            return

        end

    end

    --==================================================
    -- THEME
    --==================================================

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
        and ThemeData.Transparency
        ~= nil
        then

            local Value =
                tonumber(
                    ThemeData.Transparency
                )

            if Value then

                self.Value =
                    math.clamp(
                        Value,
                        0,
                        1
                    )

            end

        end

    end

end

--==================================================
-- GET
--==================================================

function Transparency:Get()

    return self.Value
        or DEFAULT_VALUE

end

--==================================================
-- SET
--==================================================

function Transparency:Set(
    Value
)

    Value =
        tonumber(Value)

    if not Value then
        return false
    end

    self.Value =
        math.clamp(
            Value,
            0,
            1
        )

    --==================================================
    -- SAVE CONFIG
    --==================================================

    if self.Config then

        self.Config.UI =
            self.Config.UI
            or {}

        self.Config.UI.Transparency =
            self.Value

    end

    --==================================================
    -- APPLY
    --==================================================

    self:Apply()

    return true

end

--==================================================
-- APPLY
--==================================================

function Transparency:Apply()

    if not self.UI then
        return false
    end

    local Value =
        self:Get()

    --==================================================
    -- MAIN
    --==================================================

    if self.UI.Main
    and self.UI.Main:IsA("GuiObject")
    then

        self.UI.Main.BackgroundTransparency =
            Value

    end

    --==================================================
    -- WINDOW
    --==================================================

    if self.UI.Window
    and self.UI.Window:IsA("GuiObject")
    then

        self.UI.Window.BackgroundTransparency =
            Value

    end

    --==================================================
    -- TOPBAR
    --==================================================

    if self.UI.Topbar
    and self.UI.Topbar:IsA("GuiObject")
    then

        self.UI.Topbar.BackgroundTransparency =
            Value

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.UI.Sidebar
    and self.UI.Sidebar:IsA("GuiObject")
    then

        self.UI.Sidebar.BackgroundTransparency =
            Value

    end

    return true

end

--==================================================
-- RESET
--==================================================

function Transparency:Reset()

    self.Value =
        DEFAULT_VALUE

    self:Apply()

    return true

end

--==================================================
-- SET UI
--==================================================

function Transparency:SetUI(
    UI
)

    if type(UI) ~= "table" then
        return false
    end

    self.UI =
        UI

    self:Apply()

    return true

end

return Transparency

--// 💥 RIMURU HUB
--// UI STYLING SYSTEM
--// Theme / Colors / Corners / Transparency
--// Safe + Modular

local Styling = {}

--==================================================
-- DEFAULTS
--==================================================

local DEFAULTS = {

    CornerRadius = 8,

    Transparency = 0.75,

    Main = Color3.fromRGB(
        15,
        17,
        22
    ),

    Sidebar = Color3.fromRGB(
        18,
        21,
        28
    ),

    Content = Color3.fromRGB(
        20,
        23,
        30
    ),

    Card = Color3.fromRGB(
        28,
        32,
        40
    ),

    Button = Color3.fromRGB(
        35,
        40,
        50
    ),

    Text = Color3.fromRGB(
        240,
        245,
        255
    ),

    SubText = Color3.fromRGB(
        160,
        170,
        185
    ),

    Accent = Color3.fromRGB(
        80,
        170,
        255
    ),

    Close = Color3.fromRGB(
        150,
        45,
        55
    ),

}

--==================================================
-- INIT
--==================================================

function Styling:Init(Context)

    self.Context =
        Context or {}

    self.Theme =
        self.Context.Theme

    self.Transparency =
        self.Context.UITransparency

    self.Current =
        {}

    self:Refresh()

end

--==================================================
-- GET THEME
--==================================================

function Styling:_GetTheme()

    if self.Theme
    and type(
        self.Theme.GetCurrent
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Theme:
                        GetCurrent()

                end
            )

        if Success
        and type(Result) == "table"
        then

            return Result

        end

    end

    return {}

end

--==================================================
-- REFRESH
--==================================================

function Styling:Refresh()

    local Theme =
        self:_GetTheme()

    for Name, Default in
        pairs(DEFAULTS)
    do

        self.Current[Name] =
            Theme[Name]
            or Default

    end

    if self.Transparency
    and type(
        self.Transparency.Get
    ) == "function"
    then

        local Success,
            Value =
            pcall(
                function()

                    return self.Transparency:
                        Get()

                end
            )

        if Success
        and type(Value) == "number"
        then

            self.Current.Transparency =
                Value

        end

    end

    return self.Current

end

--==================================================
-- GET COLOR
--==================================================

function Styling:GetColor(
    Name
)

    if not self.Current[Name] then

        self:Refresh()

    end

    return self.Current[Name]

end

--==================================================
-- GET TRANSPARENCY
--==================================================

function Styling:GetTransparency()

    local Value =
        self.Current.Transparency

    if type(Value) ~= "number" then

        Value =
            DEFAULTS.Transparency

    end

    return math.clamp(
        Value,
        0,
        1
    )

end

--==================================================
-- SET TRANSPARENCY
--==================================================

function Styling:SetTransparency(
    Value
)

    Value =
        tonumber(Value)

    if not Value then
        return false
    end

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    self.Current.Transparency =
        Value

    if self.Transparency
    and type(
        self.Transparency.Set
    ) == "function"
    then

        pcall(
            function()

                self.Transparency:
                    Set(
                        Value
                    )

            end
        )

    end

    return true

end

--==================================================
-- APPLY CORNER
--==================================================

function Styling:ApplyCorner(
    Object,
    Radius
)

    if not Object
    or not Object:IsA("GuiObject")
    then

        return false

    end

    Radius =
        tonumber(Radius)
        or DEFAULTS.CornerRadius

    local Corner =
        Object:FindFirstChild(
            "RimuruCorner"
        )

    if not Corner then

        Corner =
            Instance.new(
                "UICorner"
            )

        Corner.Name =
            "RimuruCorner"

        Corner.Parent =
            Object

    end

    Corner.CornerRadius =
        UDim.new(
            0,
            Radius
        )

    return true

end

--==================================================
-- APPLY COLORS
--==================================================

function Styling:ApplyColor(
    Object,
    ColorName
)

    if not Object
    or not Object:IsA("GuiObject")
    then

        return false

    end

    local Color =
        self:GetColor(
            ColorName
        )

    if not Color then
        return false
    end

    Object.BackgroundColor3 =
        Color

    return true

end

--==================================================
-- APPLY TEXT COLOR
--==================================================

function Styling:ApplyTextColor(
    Object,
    ColorName
)

    if not Object
    or not Object:IsA("TextLabel")
        and not Object:IsA("TextButton")
        and not Object:IsA("TextBox")
    then

        return false

    end

    local Color =
        self:GetColor(
            ColorName
            or "Text"
        )

    if not Color then
        return false
    end

    Object.TextColor3 =
        Color

    return true

end

--==================================================
-- APPLY TRANSPARENCY
--==================================================

function Styling:ApplyTransparency(
    Object,
    Value
)

    if not Object
    or not Object:IsA("GuiObject")
    then

        return false

    end

    Value =
        tonumber(Value)
        or self:GetTransparency()

    Object.BackgroundTransparency =
        math.clamp(
            Value,
            0,
            1
        )

    return true

end

--==================================================
-- STYLE OBJECT
--==================================================

function Styling:Style(
    Object,
    Options
)

    if not Object
    or not Object:IsA("GuiObject")
    then

        return false

    end

    Options =
        Options or {}

    if Options.Color then

        self:ApplyColor(
            Object,
            Options.Color
        )

    end

    if Options.TextColor then

        self:ApplyTextColor(
            Object,
            Options.TextColor
        )

    end

    if Options.Transparency ~= nil then

        self:ApplyTransparency(
            Object,
            Options.Transparency
        )

    end

    if Options.Corner ~= false then

        self:ApplyCorner(
            Object,
            Options.CornerRadius
        )

    end

    return true

end

--==================================================
-- APPLY ROOT THEME
--==================================================

function Styling:ApplyRoot(
    Root
)

    if not Root
    or not Root:IsA("GuiObject")
    then

        return false

    end

    self:Refresh()

    return self:Style(
        Root,
        {
            Color = "Main",
            Transparency =
                self:GetTransparency(),
            CornerRadius = 10,
        }
    )

end

--==================================================
-- DEFAULTS
--==================================================

function Styling:GetDefaults()

    return DEFAULTS

end

--==================================================
-- RETURN
--==================================================

return Styling

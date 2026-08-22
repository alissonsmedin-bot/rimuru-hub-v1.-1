--// 💥 RIMURU HUB
--// THEME SYSTEM
--// PREMIUM THEME ENGINE
--// DYNAMIC COLORS
--// SAFE THEME FALLBACKS
--// BACKGROUND SUPPORT
--// GLOW SUPPORT
--// BORDER PULSE SUPPORT
--// LOGO BORDER SUPPORT
--// BLACKOUT SUPPORT
--// RGB SUPPORT
--// UI COMPATIBLE
--// CONFIG COMPATIBLE
--// STABLE VERSION

local Theme = {}

--==================================================
-- SERVICES
--==================================================

local RunService =
    game:GetService("RunService")

--==================================================
-- INTERNAL STATE
--==================================================

Theme.Config = nil
Theme.CurrentTheme = nil
Theme.CurrentThemeName = nil

Theme.RGBTime = 0
Theme.RGBConnection = nil

--==================================================
-- FALLBACKS
--==================================================

local DEFAULT_COLOR =
    Color3.fromRGB(
        10,
        10,
        15
    )

local DEFAULT_ACCENT =
    Color3.fromRGB(
        25,
        150,
        255
    )

local DEFAULT_TEXT =
    Color3.fromRGB(
        240,
        240,
        245
    )

local DEFAULT_SUBTEXT =
    Color3.fromRGB(
        140,
        145,
        155
    )

--==================================================
-- SAFE COLOR
--==================================================

local function SafeColor(
    Value,
    Fallback
)

    if typeof(Value) == "Color3" then
        return Value
    end

    return Fallback
end

--==================================================
-- SAFE NUMBER
--==================================================

local function SafeNumber(
    Value,
    Fallback
)

    if type(Value) == "number" then
        return Value
    end

    return Fallback

end

--==================================================
-- SAFE BOOLEAN
--==================================================

local function SafeBoolean(
    Value,
    Fallback
)

    if type(Value) == "boolean" then
        return Value
    end

    return Fallback

end

--==================================================
-- GET RAW THEME
--==================================================

local function GetRawTheme(
    Config,
    Name
)

    if not Config then
        return nil
    end

    if not Config.UI then
        return nil
    end

    if not Config.UI.Themes then
        return nil
    end

    return Config.UI.Themes[Name]

end

--==================================================
-- NORMALIZE THEME
--==================================================

function Theme:Normalize(
    Name,
    RawTheme
)

    if type(RawTheme) ~= "table" then

        return nil

    end

    local Normalized = {}

    --==================================================
    -- COPY ORIGINAL VALUES
    --==================================================

    for Key, Value in pairs(RawTheme) do

        Normalized[Key] =
            Value

    end

    --==================================================
    -- NAME
    --==================================================

    Normalized.Name =
        Name

    --==================================================
    -- BACKGROUND
    --==================================================
    -- Config usa "Main".
    -- UI usa "Background".
    --
    -- Mantemos os dois compatíveis.

    Normalized.Background =
        SafeColor(
            RawTheme.Background,
            SafeColor(
                RawTheme.Main,
                DEFAULT_COLOR
            )
        )

    Normalized.Main =
        Normalized.Background

    --==================================================
    -- SIDEBAR
    --==================================================

    Normalized.Sidebar =
        SafeColor(
            RawTheme.Sidebar,
            Normalized.Background
        )

    --==================================================
    -- CONTENT
    --==================================================

    Normalized.Content =
        SafeColor(
            RawTheme.Content,
            Normalized.Background
        )

    --==================================================
    -- CARD
    --==================================================

    Normalized.Card =
        SafeColor(
            RawTheme.Card,
            Normalized.Content
        )

    --==================================================
    -- BUTTON
    --==================================================

    Normalized.Button =
        SafeColor(
            RawTheme.Button,
            Normalized.Card
        )

    --==================================================
    -- ACCENT
    --==================================================

    Normalized.Accent =
        SafeColor(
            RawTheme.Accent,
            DEFAULT_ACCENT
        )

    --==================================================
    -- TEXT
    --==================================================

    Normalized.Text =
        SafeColor(
            RawTheme.Text,
            DEFAULT_TEXT
        )

    --==================================================
    -- SUBTEXT
    --==================================================

    Normalized.SubText =
        SafeColor(
            RawTheme.SubText,
            DEFAULT_SUBTEXT
        )

    --==================================================
    -- LOGO BACKGROUND
    --==================================================

    Normalized.LogoBackground =
        SafeColor(
            RawTheme.LogoBackground,
            Normalized.Background
        )

    --==================================================
    -- CLOSE
    --==================================================

    Normalized.Close =
        SafeColor(
            RawTheme.Close,
            Normalized.Button
        )

    --==================================================
    -- BACKGROUND IMAGE
    --==================================================

    Normalized.BackgroundImage =
        RawTheme.BackgroundImage

    --==================================================
    -- BACKGROUND TRANSPARENCY
    --==================================================

    Normalized.BackgroundTransparency =
        math.clamp(
            SafeNumber(
                RawTheme.BackgroundTransparency,
                0.35
            ),
            0,
            1
        )

    --==================================================
    -- GLOW
    --==================================================

    if RawTheme.GlowEnabled ~= nil then

        Normalized.GlowEnabled =
            SafeBoolean(
                RawTheme.GlowEnabled,
                false
            )

    else

        -- Temas naturalmente neon.

        if Name == "Rimuru Dark"
        or Name == "Void"
        or Name == "Blackout" then

            Normalized.GlowEnabled =
                true

        else

            Normalized.GlowEnabled =
                false

        end

    end

    --==================================================
    -- SHADOW
    --==================================================

    if RawTheme.ShadowEnabled ~= nil then

        Normalized.ShadowEnabled =
            SafeBoolean(
                RawTheme.ShadowEnabled,
                false
            )

    else

        -- Sombra padrão apenas no tema principal.

        Normalized.ShadowEnabled =
            Name == "Rimuru Dark"

    end

    --==================================================
    -- SHADOW TRANSPARENCY
    --==================================================

    Normalized.ShadowTransparency =
        math.clamp(
            SafeNumber(
                RawTheme.ShadowTransparency,
                0.92
            ),
            0,
            1
        )

    --==================================================
    -- RGB
    --==================================================

    Normalized.RGB =
        RawTheme.RGB == true

    --==================================================
    -- BORDER PULSE
    --==================================================

    Normalized.BorderPulse =
        SafeBoolean(
            RawTheme.BorderPulse,
            Normalized.GlowEnabled
        )

    return Normalized

end

--==================================================
-- INIT
--==================================================

function Theme:Init(
    Config
)

    self.Config =
        Config

    self.RGBTime =
        0

    --==================================================
    -- DEFAULT THEME
    --==================================================

    local DefaultName =
        "Rimuru Dark"

    if Config
    and Config.UI
    and Config.UI.Theme then

        DefaultName =
            Config.UI.Theme

    end

    --==================================================
    -- LOAD DEFAULT
    --==================================================

    self:SetTheme(
        DefaultName
    )

end

--==================================================
-- INITIALIZE
--==================================================

function Theme:Initialize(
    Config
)

    return self:Init(
        Config
    )

end

--==================================================
-- SET THEME
--==================================================

function Theme:SetTheme(
    Name
)

    if not self.Config then

        warn(
            "❌ Rimuru Hub Theme: Config não encontrada."
        )

        return false

    end

    if not self.Config.UI then

        warn(
            "❌ Rimuru Hub Theme: Config.UI não encontrada."
        )

        return false

    end

    local RawTheme =
        GetRawTheme(
            self.Config,
            Name
        )

    --==================================================
    -- FALLBACK
    --==================================================

    if not RawTheme then

        warn(
            "⚠️ Rimuru Hub Theme: tema '" ..
            tostring(Name) ..
            "' não encontrado. Usando Rimuru Dark."
        )

        Name =
            "Rimuru Dark"

        RawTheme =
            GetRawTheme(
                self.Config,
                Name
            )

    end

    --==================================================
    -- FINAL FALLBACK
    --==================================================

    if not RawTheme then

        warn(
            "❌ Rimuru Hub Theme: nenhum tema válido encontrado."
        )

        return false

    end

    local Normalized =
        self:Normalize(
            Name,
            RawTheme
        )

    if not Normalized then

        warn(
            "❌ Rimuru Hub Theme: falha ao normalizar tema."
        )

        return false

    end

    self.CurrentTheme =
        Normalized

    self.CurrentThemeName =
        Name

    return true

end

--==================================================
-- CHANGE THEME
--==================================================

function Theme:ChangeTheme(
    Name
)

    return self:SetTheme(
        Name
    )

end

--==================================================
-- GET CURRENT
--==================================================

function Theme:GetCurrent()

    return self.CurrentTheme

end

--==================================================
-- GET CURRENT NAME
--==================================================

function Theme:GetCurrentName()

    return self.CurrentThemeName

end

--==================================================
-- GET NAME
--==================================================

function Theme:GetName()

    return self.CurrentThemeName

end

--==================================================
-- GET THEME
--==================================================

function Theme:GetTheme(
    Name
)

    if not self.Config then
        return nil
    end

    local RawTheme =
        GetRawTheme(
            self.Config,
            Name
        )

    if not RawTheme then
        return nil
    end

    return self:Normalize(
        Name,
        RawTheme
    )

end

--==================================================
-- GET ALL THEMES
--==================================================

function Theme:GetThemes()

    if not self.Config
    or not self.Config.UI
    or not self.Config.UI.Themes then

        return {}

    end

    return self.Config.UI.Themes

end

--==================================================
-- GET THEME NAMES
--==================================================

function Theme:GetThemeNames()

    local Names = {}

    if not self.Config
    or not self.Config.UI
    or not self.Config.UI.Themes then

        return Names

    end

    for Name in pairs(
        self.Config.UI.Themes
    ) do

        table.insert(
            Names,
            Name
        )

    end

    table.sort(
        Names
    )

    return Names

end

--==================================================
-- ACCENT
--==================================================

function Theme:GetAccent()

    local Current =
        self.CurrentTheme

    if not Current then

        return DEFAULT_ACCENT

    end

    -- RGB não usa Accent fixo.

    if Current.RGB then

        return self:GetRGBColor()

    end

    return SafeColor(
        Current.Accent,
        DEFAULT_ACCENT
    )

end

--==================================================
-- GLOW COLOR
--==================================================

function Theme:GetGlowColor()

    local Current =
        self.CurrentTheme

    if not Current then

        return DEFAULT_ACCENT

    end

    if Current.RGB then

        return self:GetRGBColor()

    end

    return SafeColor(
        Current.Accent,
        DEFAULT_ACCENT
    )

end

--==================================================
-- LOGO BORDER
--==================================================

function Theme:GetLogoBorder()

    local Current =
        self.CurrentTheme

    if not Current then

        return DEFAULT_ACCENT

    end

    if Current.RGB then

        return self:GetRGBColor()

    end

    if Current.LogoBorder then

        return SafeColor(
            Current.LogoBorder,
            Current.Accent
        )

    end

    if Current.LogoBackground then

        return SafeColor(
            Current.LogoBackground,
            Current.Accent
        )

    end

    return SafeColor(
        Current.Accent,
        DEFAULT_ACCENT
    )

end

--==================================================
-- BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

    local Current =
        self.CurrentTheme

    if not Current then

        return 0.35

    end

    return math.clamp(
        SafeNumber(
            Current.BackgroundTransparency,
            0.35
        ),
        0,
        1
    )

end

--==================================================
-- SHADOW ENABLED
--==================================================

function Theme:IsShadowEnabled()

    local Current =
        self.CurrentTheme

    if not Current then
        return false
    end

    return Current.ShadowEnabled
        == true

end

--==================================================
-- GLOW ENABLED
--==================================================

function Theme:IsGlowEnabled()

    local Current =
        self.CurrentTheme

    if not Current then
        return false
    end

    return Current.GlowEnabled
        == true

end

--==================================================
-- BORDER PULSE
--==================================================

function Theme:GetBorderPulse()

    local Current =
        self.CurrentTheme

    if not Current then

        return 0

    end

    if Current.BorderPulse
        == false then

        return 0

    end

    --==================================================
    -- RGB
    --==================================================

    if Current.RGB then

        return (
            math.sin(
                self.RGBTime * 1.15
            )
            + 1
        ) * 0.5

    end

    --==================================================
    -- NORMAL PULSE
    --==================================================

    return (
        math.sin(
            self.RGBTime * 1.15
        )
        + 1
    ) * 0.5

end

--==================================================
-- RGB COLOR
--==================================================

function Theme:GetRGBColor()

    local Time =
        self.RGBTime

    local R =
        math.sin(
            Time
        )
        * 0.5
        + 0.5

    local G =
        math.sin(
            Time
            + 2.094
        )
        * 0.5
        + 0.5

    local B =
        math.sin(
            Time
            + 4.188
        )
        * 0.5
        + 0.5

    return Color3.new(
        R,
        G,
        B
    )

end

--==================================================
-- START RGB CLOCK
--==================================================

function Theme:StartRGB()

    if self.RGBConnection then

        self.RGBConnection:Disconnect()

        self.RGBConnection =
            nil

    end

    self.RGBTime =
        0

    self.RGBConnection =
        RunService.RenderStepped:Connect(
            function(
                DeltaTime
            )

                self.RGBTime +=
                    DeltaTime

            end
        )

end

--==================================================
-- STOP RGB CLOCK
--==================================================

function Theme:StopRGB()

    if self.RGBConnection then

        self.RGBConnection:Disconnect()

        self.RGBConnection =
            nil

    end

end

--==================================================
-- IS RGB
--==================================================

function Theme:IsRGB()

    local Current =
        self.CurrentTheme

    if not Current then
        return false
    end

    return Current.RGB
        == true

end

--==================================================
-- GET COLOR
--==================================================

function Theme:GetColor(
    Key
)

    local Current =
        self.CurrentTheme

    if not Current then

        return DEFAULT_COLOR

    end

    if Current.RGB
    and (
        Key == "Accent"
        or Key == "Glow"
        or Key == "LogoBorder"
    ) then

        return self:GetRGBColor()

    end

    if Current[Key] ~= nil then

        if typeof(
            Current[Key]
        ) == "Color3" then

            return Current[Key]

        end

    end

    return DEFAULT_COLOR

end

--==================================================
-- GET MAIN COLOR
--==================================================

function Theme:GetMain()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.Background

end

--==================================================
-- GET SIDEBAR COLOR
--==================================================

function Theme:GetSidebar()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.Sidebar

end

--==================================================
-- GET CONTENT COLOR
--==================================================

function Theme:GetContent()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.Content

end

--==================================================
-- GET CARD COLOR
--==================================================

function Theme:GetCard()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.Card

end

--==================================================
-- GET BUTTON COLOR
--==================================================

function Theme:GetButton()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.Button

end

--==================================================
-- GET TEXT COLOR
--==================================================

function Theme:GetText()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_TEXT
    end

    return Current.Text

end

--==================================================
-- GET SUBTEXT COLOR
--==================================================

function Theme:GetSubText()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_SUBTEXT
    end

    return Current.SubText

end

--==================================================
-- GET CLOSE COLOR
--==================================================

function Theme:GetClose()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.Close

end

--==================================================
-- GET LOGO BACKGROUND
--==================================================

function Theme:GetLogoBackground()

    local Current =
        self.CurrentTheme

    if not Current then
        return DEFAULT_COLOR
    end

    return Current.LogoBackground

end

--==================================================
-- GET BACKGROUND IMAGE
--==================================================

function Theme:GetBackgroundImage()

    local Current =
        self.CurrentTheme

    if not Current then
        return nil
    end

    return Current.BackgroundImage

end

--==================================================
-- REFRESH
--==================================================

function Theme:Refresh()

    if not self.CurrentThemeName then
        return false
    end

    return self:SetTheme(
        self.CurrentThemeName
    )

end

--==================================================
-- APPLY
--==================================================

function Theme:Apply(
    Name
)

    if Name then

        return self:SetTheme(
            Name
        )

    end

    return self:Refresh()

end

--==================================================
-- DESTROY
--==================================================

function Theme:Destroy()

    self:StopRGB()

    self.Config =
        nil

    self.CurrentTheme =
        nil

    self.CurrentThemeName =
        nil

    self.RGBTime =
        0

end

--==================================================
-- RETURN
--==================================================

return Theme

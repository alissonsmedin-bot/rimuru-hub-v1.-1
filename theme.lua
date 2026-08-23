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
--// HARD FALLBACK SYSTEM
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
-- DEFAULT COLORS
--==================================================

local DEFAULT_BACKGROUND =
    Color3.fromRGB(
        10,
        10,
        15
    )

local DEFAULT_CONTENT =
    Color3.fromRGB(
        15,
        15,
        20
    )

local DEFAULT_CARD =
    Color3.fromRGB(
        25,
        25,
        32
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

local DEFAULT_BLACK =
    Color3.fromRGB(
        8,
        8,
        8
    )

local DEFAULT_WHITE =
    Color3.fromRGB(
        245,
        245,
        245
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
-- SAFE STRING
--==================================================

local function SafeString(
    Value,
    Fallback
)

    if type(Value) == "string"
    and Value ~= "" then

        return Value

    end

    return Fallback

end

--==================================================
-- CREATE HARD FALLBACK THEME
--==================================================

function Theme:CreateFallbackTheme()

    return {

        Name =
            "Rimuru Dark",

        --==================================================
        -- MAIN COLORS
        --==================================================

        Background =
            DEFAULT_BACKGROUND,

        Main =
            DEFAULT_BACKGROUND,

        Sidebar =
            DEFAULT_CONTENT,

        Content =
            DEFAULT_CONTENT,

        Card =
            DEFAULT_CARD,

        Button =
            DEFAULT_CARD,

        Close =
            DEFAULT_CARD,

        --==================================================
        -- TEXT
        --==================================================

        Accent =
            DEFAULT_ACCENT,

        Text =
            DEFAULT_TEXT,

        SubText =
            DEFAULT_SUBTEXT,

        --==================================================
        -- LOGO
        --==================================================

        LogoBackground =
            DEFAULT_BACKGROUND,

        LogoBorder =
            DEFAULT_ACCENT,

        --==================================================
        -- BACKGROUND
        --==================================================

        BackgroundImage =
            nil,

        BackgroundTransparency =
            0.35,

        --==================================================
        -- EFFECTS
        --==================================================

        GlowEnabled =
            true,

        ShadowEnabled =
            true,

        ShadowTransparency =
            0.92,

        BorderPulse =
            true,

        --==================================================
        -- RGB
        --==================================================

        RGB =
            false,

    }

end

--==================================================
-- GET RAW THEME
--==================================================

local function GetRawTheme(
    Config,
    Name
)

    if type(Config) ~= "table" then
        return nil
    end

    if type(Config.UI) ~= "table" then
        return nil
    end

    if type(Config.UI.Themes) ~= "table" then
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

    for Key, Value in pairs(
        RawTheme
    ) do

        Normalized[Key] =
            Value

    end

    --==================================================
    -- NAME
    --==================================================

    Normalized.Name =
        SafeString(
            Name,
            "Rimuru Dark"
        )

    --==================================================
    -- BACKGROUND
    --==================================================

    Normalized.Background =
        SafeColor(
            RawTheme.Background,

            SafeColor(
                RawTheme.Main,

                DEFAULT_BACKGROUND
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
    -- CLOSE
    --==================================================

    Normalized.Close =
        SafeColor(
            RawTheme.Close,

            Normalized.Button
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
    -- LOGO BORDER
    --==================================================

    Normalized.LogoBorder =
        SafeColor(
            RawTheme.LogoBorder,

            Normalized.Accent
        )

    --==================================================
    -- BACKGROUND IMAGE
    --==================================================

    if RawTheme.BackgroundImage ~= nil then

        Normalized.BackgroundImage =
            tostring(
                RawTheme.BackgroundImage
            )

    else

        Normalized.BackgroundImage =
            nil

    end

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

        Normalized.GlowEnabled =
            (
                Normalized.Name
                == "Rimuru Dark"
            )
            or
            (
                Normalized.Name
                == "Void"
            )
            or
            (
                Normalized.Name
                == "Blackout"
            )

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

        Normalized.ShadowEnabled =
            (
                Normalized.Name
                == "Rimuru Dark"
            )

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
    ConfigOrContext
)

    --==================================================
    -- RESET RGB
    --==================================================

    self:StopRGB()

    self.RGBTime =
        0

    --==================================================
    -- DETECT CONFIG
    --==================================================

    local Config =
        ConfigOrContext

    -- Permite:
    --
    -- Theme:Init(Config)
    --
    -- OU
    --
    -- Theme:Init(Context)
    --
    -- caso Context.Config exista.

    if type(Config) == "table"
    and type(Config.Config) == "table" then

        Config =
            Config.Config

    end

    --==================================================
    -- STORE CONFIG
    --==================================================

    self.Config =
        Config

    --==================================================
    -- INVALID CONFIG FALLBACK
    --==================================================

    if type(self.Config) ~= "table" then

        warn(
            "⚠️ Rimuru Hub Theme: Config inválida. Usando fallback."
        )

        self.CurrentTheme =
            self:CreateFallbackTheme()

        self.CurrentThemeName =
            "Rimuru Dark"

        return false

    end

    --==================================================
    -- DEFAULT NAME
    --==================================================

    local DefaultName =
        "Rimuru Dark"

    if type(self.Config.UI) == "table"
    and self.Config.UI.Theme ~= nil then

        DefaultName =
            tostring(
                self.Config.UI.Theme
            )

    end

    --==================================================
    -- LOAD DEFAULT
    --==================================================

    local Success =
        self:SetTheme(
            DefaultName
        )

    --==================================================
    -- HARD FALLBACK
    --==================================================

    if not Success
    or type(self.CurrentTheme) ~= "table" then

        warn(
            "⚠️ Rimuru Hub Theme: usando tema interno Rimuru Dark."
        )

        self.CurrentTheme =
            self:CreateFallbackTheme()

        self.CurrentThemeName =
            "Rimuru Dark"

    end

    --==================================================
    -- RGB
    --==================================================

    if self:IsRGB() then

        self:StartRGB()

    end

    return true

end

--==================================================
-- INITIALIZE ALIAS
--==================================================

function Theme:Initialize(
    ConfigOrContext
)

    return self:Init(
        ConfigOrContext
    )

end

--==================================================
-- SET THEME
--==================================================

function Theme:SetTheme(
    Name
)

    --==================================================
    -- CONFIG CHECK
    --==================================================

    if type(self.Config) ~= "table" then

        warn(
            "❌ Rimuru Hub Theme: Config não encontrada."
        )

        self.CurrentTheme =
            self:CreateFallbackTheme()

        self.CurrentThemeName =
            "Rimuru Dark"

        return false

    end

    --==================================================
    -- THEME NAME
    --==================================================

    Name =
        SafeString(
            Name,
            "Rimuru Dark"
        )

    --==================================================
    -- FIND THEME
    --==================================================

    local RawTheme =
        GetRawTheme(
            self.Config,
            Name
        )

    --==================================================
    -- FALLBACK TO RIMURU DARK
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
    -- CONFIG THEMES INVALID
    --==================================================

    if not RawTheme then

        warn(
            "⚠️ Rimuru Hub Theme: Themes não encontrados. Usando fallback interno."
        )

        self.CurrentTheme =
            self:CreateFallbackTheme()

        self.CurrentThemeName =
            "Rimuru Dark"

        return false

    end

    --==================================================
    -- NORMALIZE
    --==================================================

    local Normalized =
        self:Normalize(
            Name,
            RawTheme
        )

    if type(Normalized) ~= "table" then

        warn(
            "⚠️ Rimuru Hub Theme: falha ao normalizar '" ..
            tostring(Name) ..
            "'. Usando fallback."
        )

        self.CurrentTheme =
            self:CreateFallbackTheme()

        self.CurrentThemeName =
            "Rimuru Dark"

        return false

    end

    --==================================================
    -- APPLY
    --==================================================

    self.CurrentTheme =
        Normalized

    self.CurrentThemeName =
        Name

    --==================================================
    -- RGB STATE
    --==================================================

    if Normalized.RGB then

        self:StartRGB()

    else

        self:StopRGB()

    end

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

    if type(self.CurrentTheme)
        ~= "table" then

        self.CurrentTheme =
            self:CreateFallbackTheme()

        self.CurrentThemeName =
            "Rimuru Dark"

    end

    return self.CurrentTheme

end

--==================================================
-- GET CURRENT NAME
--==================================================

function Theme:GetCurrentName()

    return self.CurrentThemeName
        or "Rimuru Dark"

end

--==================================================
-- GET NAME
--==================================================

function Theme:GetName()

    return self.CurrentThemeName
        or "Rimuru Dark"

end

--==================================================
-- GET THEME
--==================================================

function Theme:GetTheme(
    Name
)

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

    if type(self.Config) ~= "table"
    or type(self.Config.UI) ~= "table"
    or type(self.Config.UI.Themes) ~= "table" then

        return {}

    end

    return self.Config.UI.Themes

end

--==================================================
-- GET THEME NAMES
--==================================================

function Theme:GetThemeNames()

    local Names = {}

    local Themes =
        self:GetThemes()

    for Name in pairs(Themes) do

        table.insert(
            Names,
            tostring(Name)
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
        self:GetCurrent()

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
        self:GetCurrent()

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
        self:GetCurrent()

    if Current.RGB then

        return self:GetRGBColor()

    end

    return SafeColor(
        Current.LogoBorder,
        Current.Accent
    )

end

--==================================================
-- BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

    local Current =
        self:GetCurrent()

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
        self:GetCurrent()

    return Current.ShadowEnabled
        == true

end

--==================================================
-- GLOW ENABLED
--==================================================

function Theme:IsGlowEnabled()

    local Current =
        self:GetCurrent()

    return Current.GlowEnabled
        == true

end

--==================================================
-- BORDER PULSE
--==================================================

function Theme:GetBorderPulse()

    local Current =
        self:GetCurrent()

    if Current.BorderPulse
        == false then

        return 0

    end

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
            Time + 2.094
        )
        * 0.5
        + 0.5

    local B =
        math.sin(
            Time + 4.188
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
        self:GetCurrent()

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
        self:GetCurrent()

    --==================================================
    -- RGB COLORS
    --==================================================

    if Current.RGB
    and (
        Key == "Accent"
        or Key == "Glow"
        or Key == "LogoBorder"
    ) then

        return self:GetRGBColor()

    end

    --==================================================
    -- COLOR EXISTS
    --==================================================

    if Current[Key] ~= nil
    and typeof(
        Current[Key]
    ) == "Color3" then

        return Current[Key]

    end

    --==================================================
    -- SPECIAL FALLBACKS
    --==================================================

    if Key == "Accent"
    or Key == "Glow"
    or Key == "LogoBorder" then

        return DEFAULT_ACCENT

    end

    if Key == "Text" then

        return DEFAULT_TEXT

    end

    if Key == "SubText" then

        return DEFAULT_SUBTEXT

    end

    if Key == "Card"
    or Key == "Button"
    or Key == "Close" then

        return DEFAULT_CARD

    end

    return DEFAULT_BACKGROUND

end

--==================================================
-- GET MAIN COLOR
--==================================================

function Theme:GetMain()

    return self:GetCurrent().Background

end

--==================================================
-- GET SIDEBAR COLOR
--==================================================

function Theme:GetSidebar()

    return self:GetCurrent().Sidebar

end

--==================================================
-- GET CONTENT COLOR
--==================================================

function Theme:GetContent()

    return self:GetCurrent().Content

end

--==================================================
-- GET CARD COLOR
--==================================================

function Theme:GetCard()

    return self:GetCurrent().Card

end

--==================================================
-- GET BUTTON COLOR
--==================================================

function Theme:GetButton()

    return self:GetCurrent().Button

end

--==================================================
-- GET TEXT COLOR
--==================================================

function Theme:GetText()

    return self:GetCurrent().Text

end

--==================================================
-- GET SUBTEXT COLOR
--==================================================

function Theme:GetSubText()

    return self:GetCurrent().SubText

end

--==================================================
-- GET CLOSE COLOR
--==================================================

function Theme:GetClose()

    return self:GetCurrent().Close

end

--==================================================
-- GET LOGO BACKGROUND
--==================================================

function Theme:GetLogoBackground()

    return self:GetCurrent().LogoBackground

end

--==================================================
-- GET BACKGROUND IMAGE
--==================================================

function Theme:GetBackgroundImage()

    return self:GetCurrent().BackgroundImage

end

--==================================================
-- GET NORMAL COLOR
--==================================================

function Theme:GetNormalColor()

    local Current =
        self:GetCurrent()

    local Name =
        string.lower(
            tostring(
                Current.Name
            )
        )

    if string.find(
        Name,
        "blackout",
        1,
        true
    ) then

        return DEFAULT_BLACK

    end

    return SafeColor(
        Current.Button
            or Current.Card,
        DEFAULT_CARD
    )

end

--==================================================
-- GET NORMAL TEXT COLOR
--==================================================

function Theme:GetNormalTextColor()

    local Current =
        self:GetCurrent()

    local Name =
        string.lower(
            tostring(
                Current.Name
            )
        )

    if string.find(
        Name,
        "blackout",
        1,
        true
    ) then

        return DEFAULT_WHITE

    end

    return SafeColor(
        Current.Text,
        DEFAULT_TEXT
    )

end

--==================================================
-- GET SELECTED COLOR
--==================================================

function Theme:GetSelectedColor()

    local Current =
        self:GetCurrent()

    local Name =
        string.lower(
            tostring(
                Current.Name
            )
        )

    if string.find(
        Name,
        "blackout",
        1,
        true
    ) then

        return DEFAULT_WHITE

    end

    return self:GetAccent()

end

--==================================================
-- GET SELECTED TEXT COLOR
--==================================================

function Theme:GetSelectedTextColor()

    local Current =
        self:GetCurrent()

    local Name =
        string.lower(
            tostring(
                Current.Name
            )
        )

    if string.find(
        Name,
        "blackout",
        1,
        true
    ) then

        return DEFAULT_BLACK

    end

    return SafeColor(
        Current.Text,
        DEFAULT_TEXT
    )

end

--==================================================
-- REFRESH
--==================================================

function Theme:Refresh()

    local Name =
        self.CurrentThemeName
        or "Rimuru Dark"

    return self:SetTheme(
        Name
    )

end

--==================================================
-- APPLY
--==================================================

function Theme:Apply(
    Name
)

    if Name ~= nil then

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

--// 🎨 RIMURU HUB
--// Theme System
--// PREMIUM THEME ENGINE
--// Dynamic Colors
--// Natural Neon Pulse
--// Interface Glow
--// Strong Interface Shadow
--// Border Glow
--// Animated Border Snake
--// Smooth Snake Motion
--// Rounded Border Support
--// Logo Border Support
--// Text Stroke Support
--// Card Color Cycling
--// Background Safe
--// RGB Compatible
--// BLACKOUT SELECTED STATE
--// WHITE GOLD FULL INTERFACE
--// SAFE THEME FALLBACKS

local Theme = {}

--==================================================
-- PREMIUM THEME PRESETS
--==================================================

local PremiumPresets = {

    --==================================================
    -- 🌌 RIMURU DARK
    --==================================================

    ["Rimuru Dark"] = {

        Background = Color3.fromRGB(2, 4, 8),
        Main = Color3.fromRGB(2, 4, 8),
        Sidebar = Color3.fromRGB(3, 6, 11),
        Content = Color3.fromRGB(5, 8, 14),

        Card = Color3.fromRGB(8, 16, 25),
        CardDark = Color3.fromRGB(5, 10, 18),

        Button = Color3.fromRGB(6, 13, 22),
        ButtonDark = Color3.fromRGB(3, 8, 14),

        Accent = Color3.fromRGB(35, 145, 210),
        AccentLight = Color3.fromRGB(105, 215, 245),

        LogoBorder = Color3.fromRGB(115, 235, 255),
        LogoBorderTransparency = 0.14,
        LogoBorderThickness = 1.65,

        LogoBackground = Color3.fromRGB(4, 18, 30),
        Close = Color3.fromRGB(8, 18, 30),

        Text = Color3.fromRGB(242, 248, 252),
        SubText = Color3.fromRGB(145, 170, 190),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.18,

        ShadowEnabled = true,
        ShadowColor = Color3.fromRGB(0, 0, 0),

        -- Mais forte que antes
        ShadowTransparency = 0.64,
        ShadowSize = 12,
        ShadowSoftness = 0.78,

        ShadowOffset = Vector2.new(0, 2),

        ShadowAnimated = true,
        ShadowMinTransparency = 0.70,
        ShadowMaxTransparency = 0.56,
        ShadowSpeed = 0.55,

        Animated = true,
        AnimationSpeed = 1.15,
        CardAnimation = true,

        GlowEnabled = true,
        GlowSpeed = 0.88,
        GlowStrength = 0.58,
        GlowMinTransparency = 0.84,
        GlowMaxTransparency = 0.68,

        SnakeEnabled = true,
        SnakeSpeed = 0.20,
        SnakeSize = 4,
        SnakeGlow = 0.68,
        SnakeTransparency = 0.12,

        BackgroundTransparency = 0.08
    },

    --==================================================
    -- ⬛ BLACKOUT
    --==================================================

    ["Blackout"] = {

        Background = Color3.fromRGB(0, 0, 0),
        Main = Color3.fromRGB(0, 0, 0),
        Sidebar = Color3.fromRGB(0, 0, 0),
        Content = Color3.fromRGB(0, 0, 0),

        Card = Color3.fromRGB(0, 0, 0),
        CardDark = Color3.fromRGB(8, 8, 8),

        Button = Color3.fromRGB(0, 0, 0),
        ButtonDark = Color3.fromRGB(10, 10, 10),

        Accent = Color3.fromRGB(255, 255, 255),
        AccentLight = Color3.fromRGB(255, 255, 255),

        LogoBorder = Color3.fromRGB(255, 255, 255),
        LogoBorderTransparency = 0.08,
        LogoBorderThickness = 1.8,

        LogoBackground = Color3.fromRGB(0, 0, 0),
        Close = Color3.fromRGB(10, 10, 10),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        Normal = Color3.fromRGB(0, 0, 0),
        NormalText = Color3.fromRGB(255, 255, 255),

        Selected = Color3.fromRGB(255, 255, 255),
        SelectedText = Color3.fromRGB(0, 0, 0),

        ShadowEnabled = false,

        Animated = true,
        AnimationSpeed = 0.78,
        CardAnimation = false,

        GlowEnabled = true,
        GlowSpeed = 0.72,
        GlowStrength = 0.68,
        GlowMinTransparency = 0.86,
        GlowMaxTransparency = 0.60,

        SnakeEnabled = true,
        SnakeSpeed = 0.16,
        SnakeSize = 5,
        SnakeGlow = 0.82,
        SnakeTransparency = 0.05,

        BackgroundTransparency = 0
    },

    --==================================================
    -- 🕳️ VOID
    --==================================================

    ["Void"] = {

        Background = Color3.fromRGB(4, 3, 10),
        Main = Color3.fromRGB(4, 3, 10),
        Sidebar = Color3.fromRGB(5, 4, 13),
        Content = Color3.fromRGB(8, 6, 17),

        Card = Color3.fromRGB(15, 11, 30),
        CardDark = Color3.fromRGB(10, 7, 22),

        Button = Color3.fromRGB(18, 13, 36),
        ButtonDark = Color3.fromRGB(11, 8, 24),

        Accent = Color3.fromRGB(145, 85, 255),
        AccentLight = Color3.fromRGB(190, 135, 255),

        LogoBorder = Color3.fromRGB(205, 150, 255),
        LogoBorderTransparency = 0.12,
        LogoBorderThickness = 1.7,

        LogoBackground = Color3.fromRGB(18, 10, 35),
        Close = Color3.fromRGB(25, 20, 35),

        Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(165, 150, 190),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.25,

        Animated = true,
        AnimationSpeed = 0.75,
        CardAnimation = true,

        GlowEnabled = true,
        GlowSpeed = 0.68,
        GlowStrength = 0.90,
        GlowMinTransparency = 0.83,
        GlowMaxTransparency = 0.50,

        SnakeEnabled = true,
        SnakeSpeed = 0.19,
        SnakeSize = 5,
        SnakeGlow = 0.95,
        SnakeTransparency = 0.06,

        ShadowEnabled = false,

        BackgroundTransparency = 0.08
    },

    --==================================================
    -- 🩸 CRIMSON
    --==================================================

    ["Crimson"] = {

        Background = Color3.fromRGB(12, 3, 5),
        Main = Color3.fromRGB(12, 3, 5),
        Sidebar = Color3.fromRGB(15, 3, 6),
        Content = Color3.fromRGB(20, 5, 8),

        Card = Color3.fromRGB(42, 8, 13),
        CardDark = Color3.fromRGB(27, 5, 9),

        Button = Color3.fromRGB(35, 7, 12),
        ButtonDark = Color3.fromRGB(22, 4, 8),

        Accent = Color3.fromRGB(220, 35, 55),
        AccentLight = Color3.fromRGB(255, 75, 90),

        LogoBorder = Color3.fromRGB(255, 105, 115),
        LogoBorderTransparency = 0.10,
        LogoBorderThickness = 1.7,

        LogoBackground = Color3.fromRGB(45, 8, 12),
        Close = Color3.fromRGB(55, 20, 24),

        Text = Color3.fromRGB(255, 245, 245),
        SubText = Color3.fromRGB(205, 160, 165),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        Animated = true,
        AnimationSpeed = 0.65,
        CardAnimation = true,

        GlowEnabled = true,
        GlowSpeed = 0.62,
        GlowStrength = 0.78,
        GlowMinTransparency = 0.84,
        GlowMaxTransparency = 0.58,

        SnakeEnabled = true,
        SnakeSpeed = 0.18,
        SnakeSize = 5,
        SnakeGlow = 0.88,
        SnakeTransparency = 0.08,

        ShadowEnabled = false,

        BackgroundTransparency = 0.04
    },

    --==================================================
    -- 💎 CRYSTAL
    --==================================================

    ["Crystal"] = {

        Background = Color3.fromRGB(235, 242, 248),
        Main = Color3.fromRGB(235, 242, 248),
        Sidebar = Color3.fromRGB(230, 239, 247),
        Content = Color3.fromRGB(248, 251, 255),

        Card = Color3.fromRGB(225, 237, 248),
        CardDark = Color3.fromRGB(210, 226, 240),

        Button = Color3.fromRGB(220, 235, 248),
        ButtonDark = Color3.fromRGB(205, 222, 237),

        Accent = Color3.fromRGB(55, 155, 220),
        AccentLight = Color3.fromRGB(105, 205, 255),

        LogoBorder = Color3.fromRGB(80, 220, 255),
        LogoBorderTransparency = 0.10,
        LogoBorderThickness = 1.5,

        LogoBackground = Color3.fromRGB(235, 245, 252),
        Close = Color3.fromRGB(205, 222, 237),

        Text = Color3.fromRGB(20, 30, 40),
        SubText = Color3.fromRGB(75, 95, 115),

        TextStroke = Color3.fromRGB(255, 255, 255),
        TextStrokeTransparency = 0.1,

        Animated = true,
        AnimationSpeed = 0.45,
        CardAnimation = true,

        GlowEnabled = true,
        GlowSpeed = 0.42,
        GlowStrength = 0.35,
        GlowMinTransparency = 0.90,
        GlowMaxTransparency = 0.76,

        SnakeEnabled = true,
        SnakeSpeed = 0.14,
        SnakeSize = 4,
        SnakeGlow = 0.45,
        SnakeTransparency = 0.15,

        ShadowEnabled = false,

        BackgroundTransparency = 0
    },

    --==================================================
    -- 🥇 GOLDEN NEON
    --==================================================

    ["Golden Neon"] = {

        Background = Color3.fromRGB(8, 7, 4),
        Main = Color3.fromRGB(8, 7, 4),
        Sidebar = Color3.fromRGB(10, 8, 4),
        Content = Color3.fromRGB(15, 13, 7),

        Card = Color3.fromRGB(32, 27, 11),
        CardDark = Color3.fromRGB(22, 19, 8),

        Button = Color3.fromRGB(28, 24, 10),
        ButtonDark = Color3.fromRGB(18, 15, 7),

        Accent = Color3.fromRGB(235, 175, 35),
        AccentLight = Color3.fromRGB(255, 215, 85),

        LogoBorder = Color3.fromRGB(255, 225, 110),
        LogoBorderTransparency = 0.08,
        LogoBorderThickness = 1.8,

        LogoBackground = Color3.fromRGB(42, 31, 7),
        Close = Color3.fromRGB(55, 44, 18),

        Text = Color3.fromRGB(255, 248, 220),
        SubText = Color3.fromRGB(200, 180, 125),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.1,

        Animated = true,
        AnimationSpeed = 0.55,
        CardAnimation = true,

        GlowEnabled = true,
        GlowSpeed = 0.55,
        GlowStrength = 0.72,
        GlowMinTransparency = 0.86,
        GlowMaxTransparency = 0.57,

        SnakeEnabled = true,
        SnakeSpeed = 0.17,
        SnakeSize = 5,
        SnakeGlow = 0.85,
        SnakeTransparency = 0.08,

        ShadowEnabled = false,

        BackgroundTransparency = 0.03
    },

    --==================================================
    -- 🤍✨ BRANCO DOURADO
    --==================================================
    -- IMPORTANTE:
    -- Este preset controla TODA a interface.
    --
    -- Main       = branco
    -- Sidebar    = branco
    -- Content    = branco
    -- Card       = branco
    -- Button     = branco
    -- Accent     = dourado
    -- Logo       = branco/dourado
    --
    -- Isso impede partes antigas do Config.lua
    -- de deixarem o topo preto.

    ["Branco Dourado"] = {

        --==================================================
        -- FULL WHITE INTERFACE
        --==================================================

        Background = Color3.fromRGB(245, 245, 242),

        Main = Color3.fromRGB(245, 245, 242),

        Sidebar = Color3.fromRGB(238, 238, 234),

        Content = Color3.fromRGB(248, 248, 245),

        --==================================================
        -- WHITE CARDS
        --==================================================

        Card = Color3.fromRGB(255, 255, 252),

        CardDark = Color3.fromRGB(238, 238, 233),

        Button = Color3.fromRGB(250, 250, 247),

        ButtonDark = Color3.fromRGB(232, 232, 226),

        --==================================================
        -- GOLD ACCENT
        --==================================================

        Accent = Color3.fromRGB(218, 170, 55),

        AccentLight = Color3.fromRGB(255, 215, 100),

        --==================================================
        -- LOGO
        --==================================================

        LogoBorder = Color3.fromRGB(235, 190, 70),

        LogoBorderTransparency = 0.05,

        LogoBorderThickness = 1.9,

        LogoBackground = Color3.fromRGB(255, 253, 242),

        Close = Color3.fromRGB(225, 215, 190),

        --==================================================
        -- TEXT
        --==================================================

        Text = Color3.fromRGB(35, 35, 32),

        SubText = Color3.fromRGB(105, 100, 88),

        TextStroke = Color3.fromRGB(255, 255, 255),

        TextStrokeTransparency = 0.25,

        --==================================================
        -- SELECTED / NORMAL
        --==================================================

        Normal = Color3.fromRGB(245, 245, 242),

        NormalText = Color3.fromRGB(45, 43, 38),

        Selected = Color3.fromRGB(218, 170, 55),

        SelectedText = Color3.fromRGB(255, 255, 255),

        --==================================================
        -- ANIMATION
        --==================================================

        Animated = true,

        AnimationSpeed = 0.52,

        CardAnimation = true,

        --==================================================
        -- GOLD GLOW
        --==================================================

        GlowEnabled = true,

        GlowSpeed = 0.52,

        GlowStrength = 0.62,

        GlowMinTransparency = 0.88,

        GlowMaxTransparency = 0.62,

        --==================================================
        -- GOLD BORDER SNAKE
        --==================================================

        SnakeEnabled = true,

        SnakeSpeed = 0.17,

        SnakeSize = 5,

        SnakeGlow = 0.78,

        SnakeTransparency = 0.06,

        --==================================================
        -- SHADOW
        --==================================================

        ShadowEnabled = true,

        ShadowColor = Color3.fromRGB(90, 75, 40),

        ShadowTransparency = 0.72,

        ShadowSize = 11,

        ShadowSoftness = 0.82,

        ShadowOffset = Vector2.new(0, 2),

        ShadowAnimated = true,

        ShadowMinTransparency = 0.78,

        ShadowMaxTransparency = 0.66,

        ShadowSpeed = 0.48,

        BackgroundTransparency = 0
    }

}

--==================================================
-- INIT
--==================================================

function Theme:Init(Context)

    Context = Context or {}

    self.Config = Context.Config or {}

    self.Config.UI = self.Config.UI or {}

    self.Themes = self.Config.UI.Themes or {}

    self.Name =
        self.Config.UI.Theme
        or "Rimuru Dark"

    --==================================================
    -- SAFE FALLBACK
    --==================================================

    if not self.Themes[self.Name] then

        if self.Themes["Rimuru Dark"] then

            self.Name = "Rimuru Dark"

        else

            self.Name = next(self.Themes)

        end

    end

    self.Current =
        self.Themes[self.Name]

    --==================================================
    -- APPLY PREMIUM PRESET
    --==================================================

    self:ApplyPremiumPreset()

    --==================================================
    -- ANIMATION STATE
    --==================================================

    self.RGBHue = 0

    self.AnimationTime = 0

end

--==================================================
-- APPLY PREMIUM PRESET
--==================================================

function Theme:ApplyPremiumPreset()

    if not self.Current then
        return
    end

    local Preset =
        PremiumPresets[self.Name]

    if not Preset then
        return
    end

    --==================================================
    -- PREMIUM VALUES OVERRIDE CONFIG VALUES
    --==================================================

    for Key, Value in pairs(Preset) do

        self.Current[Key] = Value

    end

    --==================================================
    -- IMPORTANT ALIASES
    --==================================================
    -- Alguns módulos antigos do Rimuru Hub usam
    -- Main / Sidebar em vez de Background / Content.
    --
    -- Mantemos tudo sincronizado.

    if Preset.Background then
        self.Current.Main = Preset.Background
    end

    if Preset.Content then
        self.Current.Content = Preset.Content
    end

    --==================================================
    -- WHITE GOLD FORCE SYNC
    --==================================================

    if self.Name == "Branco Dourado" then

        local White =
            Color3.fromRGB(
                245,
                245,
                242
            )

        local ContentWhite =
            Color3.fromRGB(
                248,
                248,
                245
            )

        self.Current.Background =
            White

        self.Current.Main =
            White

        self.Current.Sidebar =
            Color3.fromRGB(
                238,
                238,
                234
            )

        self.Current.Content =
            ContentWhite

        self.Current.Card =
            Color3.fromRGB(
                255,
                255,
                252
            )

        self.Current.Button =
            Color3.fromRGB(
                250,
                250,
                247
            )

        self.Current.Accent =
            Color3.fromRGB(
                218,
                170,
                55
            )

        self.Current.AccentLight =
            Color3.fromRGB(
                255,
                215,
                100
            )

    end

end

--==================================================
-- GET ACCENT
--==================================================

function Theme:GetAccent()

    if not self.Current then

        return Color3.new(1, 1, 1)

    end

    --==================================================
    -- RGB
    --==================================================

    if self.Current.RGB then

        return Color3.fromHSV(
            self.RGBHue,
            0.9,
            1
        )

    end

    local Base =
        self.Current.Accent

    if not Base then

        return Color3.new(1, 1, 1)

    end

    if self.Current.Animated then

        local Pulse =
            self:GetLightPulse()

        local AccentLight =
            self.Current.AccentLight

        if AccentLight then

            return Base:Lerp(
                AccentLight,
                Pulse * 0.72
            )

        end

    end

    return Base

end

--==================================================
-- LIGHT PULSE
--==================================================

function Theme:GetLightPulse()

    if not self.Current
    or not self.Current.Animated then

        return 0

    end

    local Speed =
        self.Current.AnimationSpeed
        or 1

    local Time =
        os.clock() * Speed

    local Wave =
        (math.sin(Time) + 1) / 2

    return
        Wave
        * Wave
        * (3 - 2 * Wave)

end

--==================================================
-- GLOW PULSE
--==================================================

function Theme:GetGlowPulse()

    if not self.Current
    or not self.Current.GlowEnabled then

        return 0

    end

    local Speed =
        self.Current.GlowSpeed
        or 1

    local Wave =
        (math.sin(os.clock() * Speed) + 1) / 2

    return
        Wave
        * Wave
        * (3 - 2 * Wave)

end

--==================================================
-- GLOW COLOR
--==================================================

function Theme:GetGlowColor()

    if not self.Current then
        return Color3.new(1, 1, 1)
    end

    local Accent =
        self:GetAccent()

    local Light =
        self.Current.AccentLight

    if Light then

        return Accent:Lerp(
            Light,
            0.35
        )

    end

    return Accent

end

--==================================================
-- GLOW TRANSPARENCY
--==================================================

function Theme:GetGlowTransparency()

    if not self.Current
    or not self.Current.GlowEnabled then

        return 1

    end

    local Pulse =
        self:GetGlowPulse()

    local Min =
        self.Current.GlowMinTransparency
        or 0.80

    local Max =
        self.Current.GlowMaxTransparency
        or 0.55

    return
        Min
        - (
            Pulse
            * (Min - Max)
        )

end

--==================================================
-- GLOW STRENGTH
--==================================================

function Theme:GetGlowStrength()

    if not self.Current
    or not self.Current.GlowEnabled then

        return 0

    end

    local Strength =
        self.Current.GlowStrength
        or 0.7

    local Pulse =
        self:GetGlowPulse()

    return
        Strength
        * (
            0.72
            + Pulse * 0.28
        )

end

--==================================================
-- BORDER PULSE
--==================================================

function Theme:GetBorderPulse()

    if not self.Current
    or not self.Current.Animated then

        return 0.35

    end

    local Speed =
        (
            self.Current.AnimationSpeed
            or 1
        )
        * 0.72

    local Wave =
        (
            math.sin(
                os.clock() * Speed
            )
            + 1
        )
        / 2

    Wave =
        Wave
        * Wave
        * (3 - 2 * Wave)

    return
        0.28
        + Wave * 0.52

end

--==================================================
-- 🌑 SHADOW SYSTEM
--==================================================

function Theme:IsShadowEnabled()

    if not self.Current then
        return false
    end

    return self.Current.ShadowEnabled == true

end

--==================================================
-- SHADOW COLOR
--==================================================

function Theme:GetShadowColor()

    if not self.Current then

        return Color3.fromRGB(
            0,
            0,
            0
        )

    end

    return
        self.Current.ShadowColor
        or Color3.fromRGB(
            0,
            0,
            0
        )

end

--==================================================
-- SHADOW TRANSPARENCY
--==================================================

function Theme:GetShadowTransparency()

    if not self.Current
    or not self.Current.ShadowEnabled then

        return 1

    end

    if not self.Current.ShadowAnimated then

        return
            self.Current.ShadowTransparency
            or 0.70

    end

    local Min =
        self.Current.ShadowMinTransparency
        or 0.78

    local Max =
        self.Current.ShadowMaxTransparency
        or 0.62

    local Speed =
        self.Current.ShadowSpeed
        or 0.5

    local Wave =
        (
            math.sin(
                os.clock() * Speed
            )
            + 1
        )
        / 2

    Wave =
        Wave
        * Wave
        * (3 - 2 * Wave)

    return
        Min
        - (
            Wave
            * (Min - Max)
        )

end

--==================================================
-- SHADOW SIZE
--==================================================

function Theme:GetShadowSize()

    if not self.Current then
        return 10
    end

    return
        self.Current.ShadowSize
        or 10

end

--==================================================
-- SHADOW SOFTNESS
--==================================================

function Theme:GetShadowSoftness()

    if not self.Current then
        return 0.82
    end

    return
        self.Current.ShadowSoftness
        or 0.82

end

--==================================================
-- SHADOW OFFSET
--==================================================

function Theme:GetShadowOffset()

    if not self.Current then

        return Vector2.new(
            0,
            2
        )

    end

    return
        self.Current.ShadowOffset
        or Vector2.new(
            0,
            2
        )

end

--==================================================
-- SNAKE ENABLED
--==================================================

function Theme:IsSnakeEnabled()

    return
        self.Current
        and self.Current.SnakeEnabled == true
        or false

end

--==================================================
-- SNAKE SPEED
--==================================================

function Theme:GetSnakeSpeed()

    if not self.Current then
        return 0.15
    end

    return
        self.Current.SnakeSpeed
        or 0.18

end

--==================================================
-- SNAKE SIZE
--==================================================

function Theme:GetSnakeSize()

    if not self.Current then
        return 5
    end

    return
        self.Current.SnakeSize
        or 5

end

--==================================================
-- SNAKE GLOW
--==================================================

function Theme:GetSnakeGlow()

    if not self.Current then
        return 0.8
    end

    return
        self.Current.SnakeGlow
        or 0.8

end

--==================================================
-- SNAKE TRANSPARENCY
--==================================================

function Theme:GetSnakeTransparency()

    if not self.Current then
        return 0.1
    end

    return
        self.Current.SnakeTransparency
        or 0.1

end

--==================================================
-- SNAKE COLOR
--==================================================

function Theme:GetSnakeColor()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    local Accent =
        self:GetAccent()

    local Light =
        self.Current.AccentLight

    if Light then

        local Pulse =
            self:GetGlowPulse()

        return Accent:Lerp(
            Light,
            0.45
            + Pulse * 0.25
        )

    end

    return Accent

end

--==================================================
-- GET CARD COLOR
--==================================================

function Theme:GetCardColor(Index)

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    local Card =
        self.Current.Card

    local Dark =
        self.Current.CardDark

    if not Card then

        return Color3.new(
            1,
            1,
            1
        )

    end

    if not Dark
    or not self.Current.CardAnimation then

        return Card

    end

    local Offset =
        (Index or 1) * 0.55

    local Wave =
        (
            math.sin(
                os.clock() * 0.9
                + Offset
            )
            + 1
        )
        / 2

    Wave =
        Wave
        * Wave
        * (3 - 2 * Wave)

    return Card:Lerp(
        Dark,
        Wave * 0.35
    )

end

--==================================================
-- LOGO BORDER
--==================================================

function Theme:GetLogoBorder()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    return
        self.Current.LogoBorder
        or self:GetAccent()

end

--==================================================
-- LOGO BORDER TRANSPARENCY
--==================================================

function Theme:GetLogoBorderTransparency()

    if not self.Current then
        return 0.20
    end

    return
        self.Current.LogoBorderTransparency
        or 0.20

end

--==================================================
-- LOGO BORDER THICKNESS
--==================================================

function Theme:GetLogoBorderThickness()

    if not self.Current then
        return 1.5
    end

    return
        self.Current.LogoBorderThickness
        or 1.5

end

--==================================================
-- TEXT
--==================================================

function Theme:GetText()

    if not self.Current then
        return Color3.new(1, 1, 1)
    end

    return
        self.Current.Text
        or Color3.new(1, 1, 1)

end

--==================================================
-- SUB TEXT
--==================================================

function Theme:GetSubText()

    if not self.Current then

        return Color3.new(
            0.7,
            0.7,
            0.7
        )

    end

    return
        self.Current.SubText
        or self:GetText()

end

--==================================================
-- TEXT STROKE
--==================================================

function Theme:GetTextStroke()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    return
        self.Current.TextStroke
        or Color3.new(
            0,
            0,
            0
        )

end

--==================================================
-- TEXT STROKE TRANSPARENCY
--==================================================

function Theme:GetTextStrokeTransparency()

    if not self.Current then
        return 0
    end

    return
        self.Current.TextStrokeTransparency
        or 0

end

--==================================================
-- BUTTON
--==================================================

function Theme:GetButtonColor()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    return
        self.Current.Button
        or self.Current.Card

end

--==================================================
-- DARK BUTTON
--==================================================

function Theme:GetDarkButtonColor()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    return
        self.Current.ButtonDark
        or self.Current.Button

end

--==================================================
-- NORMAL STATE
--==================================================

function Theme:GetNormalColor()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    return
        self.Current.Normal
        or self.Current.Card
        or self.Current.Button
        or Color3.new(
            0,
            0,
            0
        )

end

--==================================================
-- NORMAL TEXT
--==================================================

function Theme:GetNormalTextColor()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    return
        self.Current.NormalText
        or self.Current.Text
        or Color3.new(
            1,
            1,
            1
        )

end

--==================================================
-- SELECTED
--==================================================

function Theme:GetSelectedColor()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    if self.Current.Selected then
        return self.Current.Selected
    end

    return self:GetAccent()

end

--==================================================
-- SELECTED TEXT
--==================================================

function Theme:GetSelectedTextColor()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    if self.Current.SelectedText then
        return self.Current.SelectedText
    end

    return self:GetText()

end

--==================================================
-- CUSTOM STATES
--==================================================

function Theme:HasCustomStateColors()

    if not self.Current then
        return false
    end

    return
        self.Current.Normal ~= nil
        or self.Current.NormalText ~= nil
        or self.Current.Selected ~= nil
        or self.Current.SelectedText ~= nil

end

--==================================================
-- SET THEME
--==================================================

function Theme:SetTheme(Name)

    if not self.Themes[Name] then
        return false
    end

    self.Name =
        Name

    self.Current =
        self.Themes[Name]

    self.Config.UI.Theme =
        Name

    self:ApplyPremiumPreset()

    if self.Current.RGB then
        self.RGBHue = 0
    end

    self.AnimationTime = 0

    return true

end

--==================================================
-- RGB
--==================================================

function Theme:UpdateRGB()

    if not self.Current then
        return nil
    end

    if not self.Current.RGB then
        return nil
    end

    self.RGBHue += 0.0025

    if self.RGBHue >= 1 then
        self.RGBHue = 0
    end

    return Color3.fromHSV(
        self.RGBHue,
        0.9,
        1
    )

end

--==================================================
-- UPDATE
--==================================================

function Theme:Update()

    if not self.Current then
        return
    end

    self.AnimationTime =
        os.clock()

end

--==================================================
-- CURRENT
--==================================================

function Theme:GetCurrent()

    return self.Current

end

--==================================================
-- NAME
--==================================================

function Theme:GetName()

    return self.Name

end

--==================================================
-- THEMES
--==================================================

function Theme:GetThemes()

    return self.Themes

end

--==================================================
-- BACKGROUND
--==================================================

function Theme:GetBackground()

    if not self.Current then
        return nil
    end

    return self.Current.BackgroundImage

end

--==================================================
-- BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

    if not self.Current then
        return 1
    end

    return
        self.Current.BackgroundTransparency
        or 1

end

--==================================================
-- PREMIUM PRESETS
--==================================================

function Theme:GetPremiumPresets()

    return PremiumPresets

end

--==================================================
-- ANIMATED
--==================================================

function Theme:IsAnimated()

    if not self.Current then
        return false
    end

    return
        self.Current.Animated == true

end

--==================================================
-- GLOW ENABLED
--==================================================

function Theme:IsGlowEnabled()

    if not self.Current then
        return false
    end

    return
        self.Current.GlowEnabled == true

end

--==================================================
-- MAIN COLOR
--==================================================

function Theme:GetMainColor()

    if not self.Current then
        return Color3.new(0, 0, 0)
    end

    return
        self.Current.Main
        or self.Current.Background
        or Color3.new(0, 0, 0)

end

--==================================================
-- SIDEBAR COLOR
--==================================================

function Theme:GetSidebarColor()

    if not self.Current then
        return Color3.new(0, 0, 0)
    end

    return
        self.Current.Sidebar
        or self.Current.Main
        or self.Current.Background
        or Color3.new(0, 0, 0)

end

--==================================================
-- CONTENT COLOR
--==================================================

function Theme:GetContentColor()

    if not self.Current then
        return Color3.new(0, 0, 0)
    end

    return
        self.Current.Content
        or self.Current.Background
        or Color3.new(0, 0, 0)

end

--==================================================
-- LOGO BACKGROUND
--==================================================

function Theme:GetLogoBackground()

    if not self.Current then
        return self:GetMainColor()
    end

    return
        self.Current.LogoBackground
        or self:GetMainColor()

end

--==================================================
-- CLOSE COLOR
--==================================================

function Theme:GetCloseColor()

    if not self.Current then
        return self:GetButtonColor()
    end

    return
        self.Current.Close
        or self:GetButtonColor()

end

--==================================================
-- RETURN
--==================================================

return Theme

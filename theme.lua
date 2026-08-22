--// 🎨 RIMURU HUB
--// PREMIUM NEON THEME ENGINE
--// Dynamic Colors
--// Animated Lighting
--// Neon Glow System
--// Neon Pulse System
--// Border Snake Animation
--// Animated Border Progress
--// Logo Border Support
--// Text Stroke Support
--// Card Color Cycling
--// Background Safe
--// RGB Compatible
--// BLACKOUT SELECTED STATE
--// SAFE THEME FALLBACKS

local RunService =
    game:GetService("RunService")

local Theme = {}

--==================================================
-- PREMIUM THEME PRESETS
--==================================================

local PremiumPresets = {

    --==================================================
    -- 🌌 RIMURU DARK
    --==================================================

    ["Rimuru Dark"] = {

        Background =
            Color3.fromRGB(
                5,
                9,
                18
            ),

        Content =
            Color3.fromRGB(
                7,
                13,
                25
            ),

        Card =
            Color3.fromRGB(
                10,
                28,
                55
            ),

        CardDark =
            Color3.fromRGB(
                7,
                18,
                38
            ),

        Button =
            Color3.fromRGB(
                9,
                24,
                46
            ),

        ButtonDark =
            Color3.fromRGB(
                6,
                16,
                32
            ),

        Accent =
            Color3.fromRGB(
                40,
                150,
                255
            ),

        AccentLight =
            Color3.fromRGB(
                90,
                190,
                255
            ),

        LogoBorder =
            Color3.fromRGB(
                80,
                220,
                255
            ),

        Text =
            Color3.fromRGB(
                245,
                250,
                255
            ),

        SubText =
            Color3.fromRGB(
                165,
                190,
                215
            ),

        TextStroke =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        TextStrokeTransparency =
            0.15,

        Animated =
            true,

        AnimationSpeed =
            1.35,

        CardAnimation =
            true,

        --==================================================
        -- NEON
        --==================================================

        Neon =
            true,

        NeonStrength =
            1.15,

        GlowStrength =
            1.25,

        GlowMin =
            0.35,

        GlowMax =
            1,

        SnakeAnimation =
            true,

        SnakeSpeed =
            0.28,

        SnakeLength =
            0.18,

        SnakeGlow =
            1.35,

        PulseStrength =
            0.42,

        BackgroundTransparency =
            0.05
    },

    --==================================================
    -- ⬛ BLACKOUT
    --==================================================

    ["Blackout"] = {

        Background =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        Content =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        Card =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        CardDark =
            Color3.fromRGB(
                8,
                8,
                8
            ),

        Button =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        ButtonDark =
            Color3.fromRGB(
                10,
                10,
                10
            ),

        Accent =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        AccentLight =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        LogoBorder =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        Text =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        SubText =
            Color3.fromRGB(
                180,
                180,
                180
            ),

        TextStroke =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        TextStrokeTransparency =
            0.15,

        --==================================================
        -- BLACKOUT STATE COLORS
        --==================================================

        Normal =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        NormalText =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        Selected =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        SelectedText =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        --==================================================
        -- NEON
        --==================================================

        Neon =
            true,

        NeonStrength =
            1.4,

        GlowStrength =
            1.6,

        GlowMin =
            0.15,

        GlowMax =
            1,

        SnakeAnimation =
            true,

        SnakeSpeed =
            0.42,

        SnakeLength =
            0.16,

        SnakeGlow =
            1.75,

        PulseStrength =
            0.25,

        Animated =
            true,

        AnimationSpeed =
            0.9,

        CardAnimation =
            true,

        BackgroundTransparency =
            0
    },

    --==================================================
    -- 🕳️ VOID
    --==================================================

    ["Void"] = {

        Background =
            Color3.fromRGB(
                4,
                3,
                10
            ),

        Content =
            Color3.fromRGB(
                8,
                6,
                17
            ),

        Card =
            Color3.fromRGB(
                15,
                11,
                30
            ),

        CardDark =
            Color3.fromRGB(
                10,
                7,
                22
            ),

        Button =
            Color3.fromRGB(
                18,
                13,
                36
            ),

        ButtonDark =
            Color3.fromRGB(
                11,
                8,
                24
            ),

        Accent =
            Color3.fromRGB(
                145,
                85,
                255
            ),

        AccentLight =
            Color3.fromRGB(
                190,
                135,
                255
            ),

        LogoBorder =
            Color3.fromRGB(
                205,
                150,
                255
            ),

        Text =
            Color3.fromRGB(
                245,
                240,
                255
            ),

        SubText =
            Color3.fromRGB(
                165,
                150,
                190
            ),

        TextStroke =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        TextStrokeTransparency =
            0.25,

        Animated =
            true,

        AnimationSpeed =
            0.75,

        CardAnimation =
            true,

        Neon =
            true,

        NeonStrength =
            1.25,

        GlowStrength =
            1.4,

        GlowMin =
            0.3,

        GlowMax =
            1,

        SnakeAnimation =
            true,

        SnakeSpeed =
            0.22,

        SnakeLength =
            0.2,

        SnakeGlow =
            1.5,

        PulseStrength =
            0.38,

        BackgroundTransparency =
            0.08
    },

    --==================================================
    -- 🩸 CRIMSON
    --==================================================

    ["Crimson"] = {

        Background =
            Color3.fromRGB(
                12,
                3,
                5
            ),

        Content =
            Color3.fromRGB(
                20,
                5,
                8
            ),

        Card =
            Color3.fromRGB(
                42,
                8,
                13
            ),

        CardDark =
            Color3.fromRGB(
                27,
                5,
                9
            ),

        Button =
            Color3.fromRGB(
                35,
                7,
                12
            ),

        ButtonDark =
            Color3.fromRGB(
                22,
                4,
                8
            ),

        Accent =
            Color3.fromRGB(
                220,
                35,
                55
            ),

        AccentLight =
            Color3.fromRGB(
                255,
                75,
                90
            ),

        LogoBorder =
            Color3.fromRGB(
                255,
                105,
                115
            ),

        Text =
            Color3.fromRGB(
                255,
                245,
                245
            ),

        SubText =
            Color3.fromRGB(
                205,
                160,
                165
            ),

        TextStroke =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        TextStrokeTransparency =
            0.15,

        Animated =
            true,

        AnimationSpeed =
            0.65,

        CardAnimation =
            true,

        Neon =
            true,

        NeonStrength =
            1.3,

        GlowStrength =
            1.55,

        GlowMin =
            0.2,

        GlowMax =
            1,

        SnakeAnimation =
            true,

        SnakeSpeed =
            0.34,

        SnakeLength =
            0.17,

        SnakeGlow =
            1.7,

        PulseStrength =
            0.45,

        BackgroundTransparency =
            0.04
    },

    --==================================================
    -- 💎 CRYSTAL
    --==================================================

    ["Crystal"] = {

        Background =
            Color3.fromRGB(
                235,
                242,
                248
            ),

        Content =
            Color3.fromRGB(
                248,
                251,
                255
            ),

        Card =
            Color3.fromRGB(
                225,
                237,
                248
            ),

        CardDark =
            Color3.fromRGB(
                210,
                226,
                240
            ),

        Button =
            Color3.fromRGB(
                220,
                235,
                248
            ),

        ButtonDark =
            Color3.fromRGB(
                205,
                222,
                237
            ),

        Accent =
            Color3.fromRGB(
                55,
                155,
                220
            ),

        AccentLight =
            Color3.fromRGB(
                105,
                205,
                255
            ),

        LogoBorder =
            Color3.fromRGB(
                80,
                220,
                255
            ),

        Text =
            Color3.fromRGB(
                20,
                30,
                40
            ),

        SubText =
            Color3.fromRGB(
                75,
                95,
                115
            ),

        TextStroke =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        TextStrokeTransparency =
            0.1,

        Animated =
            true,

        AnimationSpeed =
            0.45,

        CardAnimation =
            true,

        Neon =
            true,

        NeonStrength =
            0.75,

        GlowStrength =
            0.8,

        GlowMin =
            0.55,

        GlowMax =
            1,

        SnakeAnimation =
            true,

        SnakeSpeed =
            0.18,

        SnakeLength =
            0.14,

        SnakeGlow =
            1.15,

        PulseStrength =
            0.18,

        BackgroundTransparency =
            0
    },

    --==================================================
    -- 🥇 GOLDEN NEON
    --==================================================

    ["Golden Neon"] = {

        Background =
            Color3.fromRGB(
                8,
                7,
                4
            ),

        Content =
            Color3.fromRGB(
                15,
                13,
                7
            ),

        Card =
            Color3.fromRGB(
                32,
                27,
                11
            ),

        CardDark =
            Color3.fromRGB(
                22,
                19,
                8
            ),

        Button =
            Color3.fromRGB(
                28,
                24,
                10
            ),

        ButtonDark =
            Color3.fromRGB(
                18,
                15,
                7
            ),

        Accent =
            Color3.fromRGB(
                235,
                175,
                35
            ),

        AccentLight =
            Color3.fromRGB(
                255,
                215,
                85
            ),

        LogoBorder =
            Color3.fromRGB(
                255,
                225,
                110
            ),

        Text =
            Color3.fromRGB(
                255,
                248,
                220
            ),

        SubText =
            Color3.fromRGB(
                200,
                180,
                125
            ),

        TextStroke =
            Color3.fromRGB(
                0,
                0,
                0
            ),

        TextStrokeTransparency =
            0.1,

        Animated =
            true,

        AnimationSpeed =
            0.55,

        CardAnimation =
            true,

        Neon =
            true,

        NeonStrength =
            1.3,

        GlowStrength =
            1.45,

        GlowMin =
            0.25,

        GlowMax =
            1,

        SnakeAnimation =
            true,

        SnakeSpeed =
            0.25,

        SnakeLength =
            0.18,

        SnakeGlow =
            1.55,

        PulseStrength =
            0.35,

        BackgroundTransparency =
            0.03
    }
}

--==================================================
-- INIT
--==================================================

function Theme:Init(Context)

    self.Config =
        Context.Config

    self.Themes =
        self.Config.UI.Themes or {}

    self.Name =
        self.Config.UI.Theme
        or "Rimuru Dark"

    if not self.Themes[self.Name] then

        if self.Themes["Rimuru Dark"] then

            self.Name =
                "Rimuru Dark"

        else

            self.Name =
                next(self.Themes)

        end

    end

    self.Current =
        self.Themes[self.Name]

    --==================================================
    -- APPLY PREMIUM PRESET
    --==================================================

    if PremiumPresets[self.Name] then

        local Preset =
            PremiumPresets[self.Name]

        for Key, Value in
            pairs(Preset) do

            self.Current[Key] =
                Value

        end

    end

    self.RGBHue =
        0

    self.AnimationTime =
        os.clock()

    self.Initialized =
        true

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

    for Key, Value in
        pairs(Preset) do

        self.Current[Key] =
            Value

    end

end

--==================================================
-- INTERNAL ANIMATION TIME
--==================================================

function Theme:GetAnimationTime()

    if self.AnimationTime then
        return self.AnimationTime
    end

    return os.clock()

end

--==================================================
-- GET PULSE
--==================================================
-- Retorna uma onda suave:
--
-- 0 = mínimo
-- 1 = máximo
--
-- Usado por glow, accent e iluminação.

function Theme:GetPulse()

    if not self.Current
    or not self.Current.Animated then

        return 0.5

    end

    local Speed =
        self.Current.AnimationSpeed
        or 1

    local Time =
        self:GetAnimationTime()

    return (
        math.sin(
            Time * Speed
        ) + 1
    ) / 2

end

--==================================================
-- GET NEON PULSE
--==================================================
-- Pulso controlado pela intensidade do tema.

function Theme:GetNeonPulse()

    if not self.Current then
        return 0
    end

    local Pulse =
        self:GetPulse()

    local Strength =
        self.Current.PulseStrength
        or 0.35

    local Center =
        0.5

    return math.clamp(
        Center
        + ((Pulse - Center) * Strength * 2),
        0,
        1
    )

end

--==================================================
-- GET ACCENT
--==================================================

function Theme:GetAccent()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

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

        return Color3.new(
            1,
            1,
            1
        )

    end

    --==================================================
    -- ANIMATED NEON ACCENT
    --==================================================

    if self.Current.Animated then

        local AccentLight =
            self.Current.AccentLight

        if AccentLight then

            local Pulse =
                self:GetNeonPulse()

            return Base:Lerp(
                AccentLight,
                Pulse
            )

        end

    end

    return Base

end

--==================================================
-- GET NEON COLOR
--==================================================
-- Cor principal usada pelos elementos neon.

function Theme:GetNeonColor()

    local Accent =
        self:GetAccent()

    if not self.Current then
        return Accent
    end

    local Strength =
        self.Current.NeonStrength
        or 1

    local Pulse =
        self:GetNeonPulse()

    local Boost =
        math.clamp(
            Pulse * Strength,
            0,
            1
        )

    return Accent:Lerp(
        Color3.new(
            1,
            1,
            1
        ),
        Boost * 0.22
    )

end

--==================================================
-- GET SNAKE COLOR
--==================================================
-- Núcleo brilhante da cobra.

function Theme:GetSnakeColor()

    local Accent =
        self:GetAccent()

    if not self.Current then
        return Accent
    end

    local Glow =
        self.Current.SnakeGlow
        or 1.5

    local Pulse =
        self:GetNeonPulse()

    local Intensity =
        math.clamp(
            0.35
            + (Pulse * 0.35)
            + (Glow * 0.15),
            0,
            1
        )

    return Accent:Lerp(
        Color3.new(
            1,
            1,
            1
        ),
        Intensity
    )

end

--==================================================
-- GET GLOW STRENGTH
--==================================================

function Theme:GetGlowStrength()

    if not self.Current then
        return 0
    end

    local Strength =
        self.Current.GlowStrength
        or 1

    local Pulse =
        self:GetNeonPulse()

    return math.clamp(
        Strength
        * (0.55 + Pulse * 0.45),
        0,
        3
    )

end

--==================================================
-- GET GLOW TRANSPARENCY
--==================================================

function Theme:GetGlowTransparency()

    if not self.Current then
        return 1
    end

    local Min =
        self.Current.GlowMin
        or 0.25

    local Max =
        self.Current.GlowMax
        or 1

    local Pulse =
        self:GetNeonPulse()

    return math.clamp(
        Max
        - ((Max - Min) * Pulse),
        0,
        1
    )

end

--==================================================
-- GET SNAKE PROGRESS
--==================================================
-- A posição da cobra percorre a borda:
--
-- 0.00 → início
-- 0.25 → topo/direita
-- 0.50 → lado oposto
-- 0.75 → parte inferior
-- 1.00 → volta ao início

function Theme:GetSnakeProgress()

    if not self.Current
    or not self.Current.SnakeAnimation then

        return 0

    end

    local Speed =
        self.Current.SnakeSpeed
        or 0.25

    return (
        self:GetAnimationTime()
        * Speed
    ) % 1

end

--==================================================
-- GET SNAKE LENGTH
--==================================================

function Theme:GetSnakeLength()

    if not self.Current then
        return 0.15
    end

    return math.clamp(
        self.Current.SnakeLength
        or 0.18,
        0.03,
        0.5
    )

end

--==================================================
-- GET SNAKE HEAD INTENSITY
--==================================================
-- Faz a cabeça da cobra ficar mais brilhante.

function Theme:GetSnakeHeadIntensity()

    local Progress =
        self:GetSnakeProgress()

    local Pulse =
        self:GetNeonPulse()

    local Wave =
        (
            math.sin(
                Progress
                * math.pi
                * 2
            )
            + 1
        ) / 2

    return math.clamp(
        0.65
        + (Wave * 0.2)
        + (Pulse * 0.2),
        0,
        1
    )

end

--==================================================
-- LIGHT PULSE
--==================================================

function Theme:GetLightPulse()

    return self:GetPulse()

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

    --==================================================
    -- CARD WAVE
    --==================================================

    local Offset =
        (Index or 1) * 0.55

    local Wave =
        (
            math.sin(
                self:GetAnimationTime()
                * 0.9
                + Offset
            )
            + 1
        ) / 2

    return Card:Lerp(
        Dark,
        Wave * 0.35
    )

end

--==================================================
-- GET LOGO BORDER
--==================================================

function Theme:GetLogoBorder()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    if self.Current.Neon then
        return self:GetNeonColor()
    end

    return self.Current.LogoBorder
        or self:GetAccent()

end

--==================================================
-- GET TEXT COLOR
--==================================================

function Theme:GetText()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    return self.Current.Text
        or Color3.new(
            1,
            1,
            1
        )

end

--==================================================
-- GET SUB TEXT
--==================================================

function Theme:GetSubText()

    if not self.Current then

        return Color3.new(
            0.7,
            0.7,
            0.7
        )

    end

    return self.Current.SubText
        or self:GetText()

end

--==================================================
-- GET TEXT STROKE
--==================================================

function Theme:GetTextStroke()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    return self.Current.TextStroke
        or Color3.new(
            0,
            0,
            0
        )

end

--==================================================
-- GET TEXT STROKE TRANSPARENCY
--==================================================

function Theme:GetTextStrokeTransparency()

    if not self.Current then
        return 0
    end

    return self.Current.TextStrokeTransparency
        or 0

end

--==================================================
-- GET BUTTON COLOR
--==================================================

function Theme:GetButtonColor()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    return self.Current.Button
        or self.Current.Card

end

--==================================================
-- GET DARK BUTTON COLOR
--==================================================

function Theme:GetDarkButtonColor()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    return self.Current.ButtonDark
        or self.Current.Button

end

--==================================================
-- NORMAL STATE COLOR
--==================================================

function Theme:GetNormalColor()

    if not self.Current then

        return Color3.new(
            0,
            0,
            0
        )

    end

    return self.Current.Normal
        or self.Current.Card
        or self.Current.Button
        or Color3.new(
            0,
            0,
            0
        )

end

--==================================================
-- NORMAL STATE TEXT
--==================================================

function Theme:GetNormalTextColor()

    if not self.Current then

        return Color3.new(
            1,
            1,
            1
        )

    end

    return self.Current.NormalText
        or self.Current.Text
        or Color3.new(
            1,
            1,
            1
        )

end

--==================================================
-- SELECTED STATE COLOR
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
-- SELECTED STATE TEXT
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
-- HAS CUSTOM STATE COLORS
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

    --==================================================
    -- PREMIUM PRESET
    --==================================================

    self:ApplyPremiumPreset()

    --==================================================
    -- RGB RESET
    --==================================================

    if self.Current.RGB then

        self.RGBHue =
            0

    end

    self.AnimationTime =
        os.clock()

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

    self.RGBHue +=
        0.0025

    if self.RGBHue >= 1 then

        self.RGBHue =
            0

    end

    return Color3.fromHSV(
        self.RGBHue,
        0.9,
        1
    )

end

--==================================================
-- UPDATE ANIMATION
--==================================================

function Theme:Update()

    if not self.Current then
        return
    end

    self.AnimationTime =
        os.clock()

    if self.Current.RGB then

        self:UpdateRGB()

    end

end

--==================================================
-- IS NEON
--==================================================

function Theme:IsNeon()

    if not self.Current then
        return false
    end

    return self.Current.Neon == true

end

--==================================================
-- IS SNAKE ENABLED
--==================================================

function Theme:IsSnakeEnabled()

    if not self.Current then
        return false
    end

    return self.Current.SnakeAnimation == true

end

--==================================================
-- GET CURRENT
--==================================================

function Theme:GetCurrent()

    return self.Current

end

--==================================================
-- GET NAME
--==================================================

function Theme:GetName()

    return self.Name

end

--==================================================
-- GET THEMES
--==================================================

function Theme:GetThemes()

    return self.Themes

end

--==================================================
-- GET BACKGROUND
--==================================================

function Theme:GetBackground()

    if not self.Current then
        return nil
    end

    return self.Current.BackgroundImage

end

--==================================================
-- GET BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

    if not self.Current then
        return 1
    end

    return self.Current.BackgroundTransparency
        or 1

end

--==================================================
-- GET PREMIUM PRESETS
--==================================================

function Theme:GetPremiumPresets()

    return PremiumPresets

end

--==================================================
-- IS ANIMATED
--==================================================

function Theme:IsAnimated()

    if not self.Current then
        return false
    end

    return self.Current.Animated == true

end

--==================================================
-- RETURN
--==================================================

return Theme

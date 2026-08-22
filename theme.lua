--// 🎨 RIMURU HUB
--// Theme System
--// PREMIUM THEME ENGINE
--// Dynamic Colors
--// Animated Lighting
--// Natural Neon Pulse
--// Neon Glow Support
--// Border Glow Support
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

        Animated =
            false,

        CardAnimation =
            false,

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
        self.Config.UI.Themes
        or {}

    self.Name =
        self.Config.UI.Theme
        or "Rimuru Dark"

    --==================================================
    -- SAFE THEME FALLBACK
    --==================================================

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

    --==================================================
    -- ANIMATION STATE
    --==================================================

    self.RGBHue =
        0

    self.AnimationTime =
        0

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
    -- NATURAL ANIMATED ACCENT
    --==================================================

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
        math.sin(Time)

    local Smooth =
        (Wave + 1) / 2

    --==================================================
    -- SMOOTHSTEP
    --==================================================

    Smooth =
        Smooth * Smooth *
        (3 - 2 * Smooth)

    return Smooth

end

--==================================================
-- GLOW COLOR
--==================================================

function Theme:GetGlowColor()

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

    if not self.Current then

        return 0.8

    end

    if not self.Current.Animated then

        return 0.82

    end

    local Pulse =
        self:GetLightPulse()

    return 0.78 -
        (Pulse * 0.16)

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
        (self.Current.AnimationSpeed or 1)
        * 0.72

    local Time =
        os.clock() * Speed

    local Wave =
        (math.sin(Time) + 1) / 2

    --==================================================
    -- SMOOTHSTEP
    --==================================================

    Wave =
        Wave * Wave *
        (3 - 2 * Wave)

    return 0.28 +
        (Wave * 0.52)

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
                os.clock()
                * 0.9
                + Offset
            )
            + 1
        ) / 2

    --==================================================
    -- SMOOTHSTEP
    --==================================================

    Wave =
        Wave * Wave *
        (3 - 2 * Wave)

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
        0

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

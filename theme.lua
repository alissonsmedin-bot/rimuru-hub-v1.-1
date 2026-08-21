--// 🎨 RIMURU HUB
--// Theme System
--// PREMIUM THEME ENGINE
--// Dynamic Colors
--// Animated Lighting
--// Visible Glow System
--// Fade Support
--// Logo Border Support
--// Text Stroke Support
--// Card Color Cycling
--// Background Safe
--// RGB Compatible
--// BLACKOUT SELECTED STATE
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

        Background = Color3.fromRGB(5, 9, 18),
        Content = Color3.fromRGB(7, 13, 25),

        Card = Color3.fromRGB(10, 28, 55),
        CardDark = Color3.fromRGB(7, 18, 38),

        Button = Color3.fromRGB(9, 24, 46),
        ButtonDark = Color3.fromRGB(6, 16, 32),

        Accent = Color3.fromRGB(40, 150, 255),
        AccentLight = Color3.fromRGB(90, 190, 255),

        LogoBorder = Color3.fromRGB(80, 220, 255),

        Text = Color3.fromRGB(245, 250, 255),
        SubText = Color3.fromRGB(165, 190, 215),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        -- VISUAL
        GlowColor = Color3.fromRGB(50, 165, 255),
        GlowTransparency = 0.30,
        GlowThickness = 2,

        HoverColor = Color3.fromRGB(25, 70, 115),
        HoverTransparency = 0,

        FadeTime = 0.20,

        Animated = true,
        AnimationSpeed = 1.35,

        CardAnimation = true,

        BackgroundTransparency = 0.05
    },

    --==================================================
    -- 🟢 SLIME
    --==================================================

    ["Slime"] = {

        Background = Color3.fromRGB(3, 14, 13),
        Content = Color3.fromRGB(5, 23, 21),

        Card = Color3.fromRGB(7, 43, 39),
        CardDark = Color3.fromRGB(5, 28, 26),

        Button = Color3.fromRGB(7, 38, 34),
        ButtonDark = Color3.fromRGB(4, 24, 22),

        Accent = Color3.fromRGB(40, 255, 190),
        AccentLight = Color3.fromRGB(110, 255, 220),

        LogoBorder = Color3.fromRGB(70, 255, 205),

        Text = Color3.fromRGB(235, 255, 250),
        SubText = Color3.fromRGB(135, 205, 190),

        TextStroke = Color3.fromRGB(0, 20, 18),
        TextStrokeTransparency = 0.10,

        GlowColor = Color3.fromRGB(40, 255, 190),
        GlowTransparency = 0.25,
        GlowThickness = 2,

        HoverColor = Color3.fromRGB(15, 85, 70),
        HoverTransparency = 0,

        FadeTime = 0.20,

        Animated = true,
        AnimationSpeed = 1.00,

        CardAnimation = true,

        BackgroundTransparency = 0.05
    },

    --==================================================
    -- ⬛ BLACKOUT
    --==================================================

    ["Blackout"] = {

        Background = Color3.fromRGB(0, 0, 0),
        Content = Color3.fromRGB(0, 0, 0),

        Card = Color3.fromRGB(0, 0, 0),
        CardDark = Color3.fromRGB(8, 8, 8),

        Button = Color3.fromRGB(0, 0, 0),
        ButtonDark = Color3.fromRGB(10, 10, 10),

        Accent = Color3.fromRGB(255, 255, 255),
        AccentLight = Color3.fromRGB(255, 255, 255),

        LogoBorder = Color3.fromRGB(255, 255, 255),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        -- BLACKOUT NÃO USA GLOW FORTE
        GlowColor = Color3.fromRGB(255, 255, 255),
        GlowTransparency = 0.70,
        GlowThickness = 1,

        HoverColor = Color3.fromRGB(20, 20, 20),
        HoverTransparency = 0,

        FadeTime = 0.14,

        Normal = Color3.fromRGB(0, 0, 0),
        NormalText = Color3.fromRGB(255, 255, 255),

        Selected = Color3.fromRGB(255, 255, 255),
        SelectedText = Color3.fromRGB(0, 0, 0),

        Animated = false,
        CardAnimation = false,

        BackgroundTransparency = 0
    },

    --==================================================
    -- 🕳️ VOID
    --==================================================

    ["Void"] = {

        Background = Color3.fromRGB(4, 3, 10),
        Content = Color3.fromRGB(8, 6, 17),

        Card = Color3.fromRGB(15, 11, 30),
        CardDark = Color3.fromRGB(10, 7, 22),

        Button = Color3.fromRGB(18, 13, 36),
        ButtonDark = Color3.fromRGB(11, 8, 24),

        Accent = Color3.fromRGB(145, 85, 255),
        AccentLight = Color3.fromRGB(205, 145, 255),

        LogoBorder = Color3.fromRGB(205, 150, 255),

        Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(165, 150, 190),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.20,

        -- VOID
        GlowColor = Color3.fromRGB(155, 85, 255),
        GlowTransparency = 0.18,
        GlowThickness = 2.2,

        HoverColor = Color3.fromRGB(45, 25, 80),
        HoverTransparency = 0,

        FadeTime = 0.24,

        Animated = true,
        AnimationSpeed = 0.75,

        CardAnimation = true,

        BackgroundTransparency = 0.08
    },

    --==================================================
    -- 🩸 CRIMSON
    --==================================================

    ["Crimson"] = {

        Background = Color3.fromRGB(12, 3, 5),
        Content = Color3.fromRGB(20, 5, 8),

        Card = Color3.fromRGB(42, 8, 13),
        CardDark = Color3.fromRGB(27, 5, 9),

        Button = Color3.fromRGB(35, 7, 12),
        ButtonDark = Color3.fromRGB(22, 4, 8),

        Accent = Color3.fromRGB(220, 35, 55),
        AccentLight = Color3.fromRGB(255, 75, 90),

        LogoBorder = Color3.fromRGB(255, 105, 115),

        Text = Color3.fromRGB(255, 245, 245),
        SubText = Color3.fromRGB(205, 160, 165),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        GlowColor = Color3.fromRGB(255, 35, 55),
        GlowTransparency = 0.20,
        GlowThickness = 2.2,

        HoverColor = Color3.fromRGB(85, 15, 25),
        HoverTransparency = 0,

        FadeTime = 0.18,

        Animated = true,
        AnimationSpeed = 0.65,

        CardAnimation = true,

        BackgroundTransparency = 0.04
    },

    --==================================================
    -- 💎 CRYSTAL
    --==================================================

    ["Crystal"] = {

        Background = Color3.fromRGB(235, 242, 248),
        Content = Color3.fromRGB(248, 251, 255),

        Card = Color3.fromRGB(225, 237, 248),
        CardDark = Color3.fromRGB(210, 226, 240),

        Button = Color3.fromRGB(220, 235, 248),
        ButtonDark = Color3.fromRGB(205, 222, 237),

        Accent = Color3.fromRGB(55, 155, 220),
        AccentLight = Color3.fromRGB(105, 205, 255),

        LogoBorder = Color3.fromRGB(80, 220, 255),

        Text = Color3.fromRGB(20, 30, 40),
        SubText = Color3.fromRGB(75, 95, 115),

        TextStroke = Color3.fromRGB(255, 255, 255),
        TextStrokeTransparency = 0.10,

        GlowColor = Color3.fromRGB(70, 180, 240),
        GlowTransparency = 0.35,
        GlowThickness = 1.8,

        HoverColor = Color3.fromRGB(195, 220, 240),
        HoverTransparency = 0,

        FadeTime = 0.20,

        Animated = true,
        AnimationSpeed = 0.45,

        CardAnimation = true,

        BackgroundTransparency = 0
    },

    --==================================================
    -- 🥇 GOLDEN NEON
    --==================================================

    ["Golden Neon"] = {

        Background = Color3.fromRGB(8, 7, 4),
        Content = Color3.fromRGB(15, 13, 7),

        Card = Color3.fromRGB(32, 27, 11),
        CardDark = Color3.fromRGB(22, 19, 8),

        Button = Color3.fromRGB(28, 24, 10),
        ButtonDark = Color3.fromRGB(18, 15, 7),

        Accent = Color3.fromRGB(235, 175, 35),
        AccentLight = Color3.fromRGB(255, 215, 85),

        LogoBorder = Color3.fromRGB(255, 225, 110),

        Text = Color3.fromRGB(255, 248, 220),
        SubText = Color3.fromRGB(200, 180, 125),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.10,

        GlowColor = Color3.fromRGB(255, 190, 45),
        GlowTransparency = 0.20,
        GlowThickness = 2.2,

        HoverColor = Color3.fromRGB(75, 58, 18),
        HoverTransparency = 0,

        FadeTime = 0.20,

        Animated = true,
        AnimationSpeed = 0.55,

        CardAnimation = true,

        BackgroundTransparency = 0.03
    },

    --==================================================
    -- 🔵 AZUL ESCURO
    --==================================================

    ["Azul Escuro"] = {

        Background = Color3.fromRGB(2, 6, 15),
        Content = Color3.fromRGB(5, 12, 27),

        Card = Color3.fromRGB(8, 22, 48),
        CardDark = Color3.fromRGB(5, 15, 34),

        Button = Color3.fromRGB(7, 19, 42),
        ButtonDark = Color3.fromRGB(4, 12, 27),

        Accent = Color3.fromRGB(45, 105, 255),
        AccentLight = Color3.fromRGB(95, 150, 255),

        LogoBorder = Color3.fromRGB(90, 155, 255),

        Text = Color3.fromRGB(235, 242, 255),
        SubText = Color3.fromRGB(145, 165, 205),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.18,

        GlowColor = Color3.fromRGB(45, 105, 255),
        GlowTransparency = 0.22,
        GlowThickness = 2,

        HoverColor = Color3.fromRGB(18, 48, 105),
        HoverTransparency = 0,

        FadeTime = 0.20,

        Animated = true,
        AnimationSpeed = 0.85,

        CardAnimation = true,

        BackgroundTransparency = 0.05
    },

    --==================================================
    -- 🤍 BRANCO DOURADO
    --==================================================

    ["Branco Dourado"] = {

        Background = Color3.fromRGB(242, 239, 229),
        Content = Color3.fromRGB(250, 248, 240),

        Card = Color3.fromRGB(235, 229, 210),
        CardDark = Color3.fromRGB(220, 211, 187),

        Button = Color3.fromRGB(232, 225, 201),
        ButtonDark = Color3.fromRGB(215, 205, 178),

        Accent = Color3.fromRGB(190, 145, 45),
        AccentLight = Color3.fromRGB(235, 195, 85),

        LogoBorder = Color3.fromRGB(215, 170, 60),

        Text = Color3.fromRGB(35, 31, 22),
        SubText = Color3.fromRGB(105, 95, 75),

        TextStroke = Color3.fromRGB(255, 255, 255),
        TextStrokeTransparency = 0.15,

        GlowColor = Color3.fromRGB(210, 165, 55),
        GlowTransparency = 0.32,
        GlowThickness = 1.8,

        HoverColor = Color3.fromRGB(220, 205, 165),
        HoverTransparency = 0,

        FadeTime = 0.20,

        Animated = true,
        AnimationSpeed = 0.50,

        CardAnimation = true,

        BackgroundTransparency = 0
    },

    --==================================================
    -- 🔴 VERMELHO
    --==================================================

    ["Vermelho"] = {

        Background = Color3.fromRGB(12, 2, 3),
        Content = Color3.fromRGB(22, 4, 6),

        Card = Color3.fromRGB(43, 7, 10),
        CardDark = Color3.fromRGB(28, 4, 7),

        Button = Color3.fromRGB(36, 5, 9),
        ButtonDark = Color3.fromRGB(22, 3, 6),

        Accent = Color3.fromRGB(245, 35, 45),
        AccentLight = Color3.fromRGB(255, 90, 95),

        LogoBorder = Color3.fromRGB(255, 80, 90),

        Text = Color3.fromRGB(255, 240, 240),
        SubText = Color3.fromRGB(205, 150, 155),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        GlowColor = Color3.fromRGB(255, 30, 45),
        GlowTransparency = 0.18,
        GlowThickness = 2.2,

        HoverColor = Color3.fromRGB(90, 12, 18),
        HoverTransparency = 0,

        FadeTime = 0.17,

        Animated = true,
        AnimationSpeed = 0.70,

        CardAnimation = true,

        BackgroundTransparency = 0.04
    },

    --==================================================
    -- 🌈 RGB
    --==================================================

    ["RGB"] = {

        Background = Color3.fromRGB(5, 5, 8),
        Content = Color3.fromRGB(9, 9, 14),

        Card = Color3.fromRGB(18, 18, 25),
        CardDark = Color3.fromRGB(10, 10, 16),

        Button = Color3.fromRGB(16, 16, 23),
        ButtonDark = Color3.fromRGB(9, 9, 14),

        Accent = Color3.fromRGB(255, 0, 255),
        AccentLight = Color3.fromRGB(255, 255, 255),

        LogoBorder = Color3.fromRGB(255, 255, 255),

        Text = Color3.fromRGB(245, 245, 255),
        SubText = Color3.fromRGB(165, 165, 185),

        TextStroke = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.15,

        GlowColor = Color3.fromRGB(255, 0, 255),
        GlowTransparency = 0.18,
        GlowThickness = 2,

        HoverColor = Color3.fromRGB(35, 35, 45),
        HoverTransparency = 0,

        FadeTime = 0.18,

        Animated = true,
        AnimationSpeed = 1,

        CardAnimation = true,

        BackgroundTransparency = 0.05,

        RGB = true
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

    --==================================================
    -- ADD PREMIUM THEMES
    --==================================================

    for Name, Preset in
        pairs(PremiumPresets) do

        if not self.Themes[Name] then

            self.Themes[Name] = {}

        end

        for Key, Value in
            pairs(Preset) do

            self.Themes[Name][Key] =
                Value

        end

    end

    self.Name =
        self.Config.UI.Theme
        or "Rimuru Dark"

    if not self.Themes[self.Name] then

        self.Name =
            "Rimuru Dark"

    end

    self.Current =
        self.Themes[self.Name]

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

        return Color3.new(1, 1, 1)

    end

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

        local Light =
            self:GetLightPulse()

        local AccentLight =
            self.Current.AccentLight

        if AccentLight then

            return Base:Lerp(
                AccentLight,
                Light
            )

        end

    end

    return Base

end

--==================================================
-- GET LIGHT PULSE
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

    return (
        math.sin(Time) + 1
    ) / 2

end

--==================================================
-- GET GLOW COLOR
--==================================================

function Theme:GetGlowColor()

    if not self.Current then

        return Color3.new(1, 1, 1)

    end

    if self.Current.RGB then

        return self:GetAccent()

    end

    return self.Current.GlowColor
        or self:GetAccent()

end

--==================================================
-- GET GLOW TRANSPARENCY
--==================================================

function Theme:GetGlowTransparency()

    if not self.Current then
        return 1
    end

    local Base =
        self.Current.GlowTransparency

    if Base == nil then
        return 0.35
    end

    if self.Current.Animated then

        local Pulse =
            self:GetLightPulse()

        return math.clamp(
            Base + (Pulse * 0.12),
            0,
            1
        )

    end

    return Base

end

--==================================================
-- GET GLOW THICKNESS
--==================================================

function Theme:GetGlowThickness()

    if not self.Current then
        return 1
    end

    return self.Current.GlowThickness
        or 1

end

--==================================================
-- GET HOVER COLOR
--==================================================

function Theme:GetHoverColor()

    if not self.Current then

        return Color3.new(0.2, 0.2, 0.2)

    end

    return self.Current.HoverColor
        or self:GetButtonColor()

end

--==================================================
-- GET FADE TIME
--==================================================

function Theme:GetFadeTime()

    if not self.Current then
        return 0.2
    end

    return self.Current.FadeTime
        or 0.2

end

--==================================================
-- GET CARD COLOR
--==================================================

function Theme:GetCardColor(Index)

    if not self.Current then

        return Color3.new(1, 1, 1)

    end

    local Card =
        self.Current.Card

    local Dark =
        self.Current.CardDark

    if not Card then

        return Color3.new(1, 1, 1)

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
                os.clock() * 0.9 + Offset
            ) + 1
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

        return Color3.new(1, 1, 1)

    end

    return self.Current.LogoBorder
        or self:GetAccent()

end

--==================================================
-- GET TEXT
--==================================================

function Theme:GetText()

    if not self.Current then

        return Color3.new(1, 1, 1)

    end

    return self.Current.Text
        or Color3.new(1, 1, 1)

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

        return Color3.new(0, 0, 0)

    end

    return self.Current.TextStroke
        or Color3.new(0, 0, 0)

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

        return Color3.new(1, 1, 1)

    end

    return self.Current.Button
        or self.Current.Card

end

--==================================================
-- GET DARK BUTTON COLOR
--==================================================

function Theme:GetDarkButtonColor()

    if not self.Current then

        return Color3.new(0, 0, 0)

    end

    return self.Current.ButtonDark
        or self.Current.Button

end

--==================================================
-- NORMAL
--==================================================

function Theme:GetNormalColor()

    if not self.Current then

        return Color3.new(0, 0, 0)

    end

    return self.Current.Normal
        or self.Current.Card
        or self.Current.Button
        or Color3.new(0, 0, 0)

end

function Theme:GetNormalTextColor()

    if not self.Current then

        return Color3.new(1, 1, 1)

    end

    return self.Current.NormalText
        or self.Current.Text
        or Color3.new(1, 1, 1)

end

--==================================================
-- SELECTED
--==================================================

function Theme:GetSelectedColor()

    if not self.Current then

        return Color3.new(1, 1, 1)

    end

    if self.Current.Selected then

        return self.Current.Selected

    end

    return self:GetAccent()

end

function Theme:GetSelectedTextColor()

    if not self.Current then

        return Color3.new(0, 0, 0)

    end

    if self.Current.SelectedText then

        return self.Current.SelectedText

    end

    return self:GetText()

end

--==================================================
-- CUSTOM STATE
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

    if not self.Current
    or not self.Current.RGB then

        return nil

    end

    self.RGBHue += 0.0025

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
-- GETTERS
--==================================================

function Theme:GetCurrent()

    return self.Current

end

function Theme:GetName()

    return self.Name

end

function Theme:GetThemes()

    return self.Themes

end

function Theme:GetBackground()

    if not self.Current then
        return nil
    end

    return self.Current.BackgroundImage

end

function Theme:GetBackgroundTransparency()

    if not self.Current then
        return 1
    end

    return self.Current.BackgroundTransparency
        or 1

end

function Theme:GetPremiumPresets()

    return PremiumPresets

end

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

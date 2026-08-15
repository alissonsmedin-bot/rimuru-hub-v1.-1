--// 🎨 RIMURU HUB
--// Theme System
--// Reworked Theme Core

local Theme = {}

--==================================================
-- INIT
--==================================================

function Theme:Init(Context)

    self.Context =
        Context

    self.Config =
        Context.Config

    --==================================================
    -- THEMES
    --==================================================

    self.Themes =
        self.Config.UI.Themes
        or {}

    --==================================================
    -- DEFAULT THEME
    --==================================================

    self.Name =
        self.Config.UI.Theme
        or "Rimuru Dark"

    --==================================================
    -- FALLBACK
    --==================================================

    if not self.Themes[self.Name] then

        if self.Themes["Rimuru Dark"] then

            self.Name =
                "Rimuru Dark"

        else

            local FirstTheme

            for ThemeName in
                pairs(
                    self.Themes
                ) do

                FirstTheme =
                    ThemeName

                break

            end

            self.Name =
                FirstTheme
                or "Rimuru Dark"

        end

    end

    --==================================================
    -- CURRENT
    --==================================================

    self.Current =
        self.Themes[self.Name]

    --==================================================
    -- RGB
    --==================================================

    self.RGBHue =
        0

    --==================================================
    -- BACKGROUND
    --==================================================

    self.BackgroundTransparency =
        0.78

end

--==================================================
-- GET ACCENT
--==================================================

function Theme:GetAccent()

    if not self.Current then
        return Color3.fromRGB(
            80,
            170,
            255
        )
    end

    --==================================================
    -- RGB THEME
    --==================================================

    if self.Current.RGB then

        return Color3.fromHSV(
            self.RGBHue,
            0.9,
            1
        )

    end

    --==================================================
    -- NORMAL ACCENT
    --==================================================

    return self.Current.Accent
        or Color3.fromRGB(
            80,
            170,
            255
        )

end

--==================================================
-- SET THEME
--==================================================

function Theme:SetTheme(
    Name
)

    if not self.Themes[Name] then
        return false
    end

    self.Name =
        Name

    self.Current =
        self.Themes[Name]

    self.Config.UI.Theme =
        Name

    return true

end

--==================================================
-- GET BACKGROUND IMAGE
--==================================================

function Theme:GetBackgroundImage()

    if not self.Current then
        return nil
    end

    return self.Current.BackgroundImage

end

--==================================================
-- HAS BACKGROUND IMAGE
--==================================================

function Theme:HasBackgroundImage()

    return self:GetBackgroundImage()
        ~= nil

end

--==================================================
-- GET BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

    --==================================================
    -- USER CONFIGURATION
    --==================================================

    if self.Config
    and self.Config.UI
    and self.Config.UI.BackgroundTransparency
    ~= nil then

        return self.Config.UI.BackgroundTransparency

    end

    --==================================================
    -- THEME DEFAULT
    --==================================================

    if self.Current
    and self.Current.BackgroundTransparency
    ~= nil then

        return self.Current.BackgroundTransparency

    end

    --==================================================
    -- DEFAULT
    --==================================================

    return 0.78

end

--==================================================
-- SET BACKGROUND TRANSPARENCY
--==================================================

function Theme:SetBackgroundTransparency(
    Value
)

    Value =
        tonumber(
            Value
        )

    if not Value then
        return false
    end

    -- Clamp between 0 and 1

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    --==================================================
    -- CONFIG
    --==================================================

    self.Config.UI.BackgroundTransparency =
        Value

    self.BackgroundTransparency =
        Value

    return true

end

--==================================================
-- GET THEME BACKGROUND
--==================================================

function Theme:GetBackgroundSettings()

    if not self.Current then

        return {

            Image = nil,

            Transparency =
                self:GetBackgroundTransparency()

        }

    end

    return {

        Image =
            self.Current.BackgroundImage,

        Transparency =
            self:GetBackgroundTransparency()

    }

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
-- IS RGB
--==================================================

function Theme:IsRGB()

    if not self.Current then
        return false
    end

    return self.Current.RGB == true

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
-- GET THEME
--==================================================

function Theme:GetTheme(
    Name
)

    return self.Themes[
        Name
    ]

end

--==================================================
-- HAS THEME
--==================================================

function Theme:HasTheme(
    Name
)

    return self.Themes[
        Name
    ] ~= nil

end

--==================================================
-- GET THEME NAMES
--==================================================

function Theme:GetThemeNames()

    local Names =
        {}

    for Name in
        pairs(
            self.Themes
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
-- EXPORT
--==================================================

return Theme

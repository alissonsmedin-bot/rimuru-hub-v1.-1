--// 🎨 RIMURU HUB
--// Theme System
--// Background Safe Version

local Theme = {}

--==================================================
-- INIT
--==================================================

function Theme:Init(Context)

    self.Config =
        Context.Config

    self.Themes =
        self.Config.UI.Themes or {}

    self.Name =
        self.Config.UI.Theme or "Rimuru Dark"

    if not self.Themes[self.Name] then

        if self.Themes["Rimuru Dark"] then
            self.Name = "Rimuru Dark"
        else
            self.Name = next(self.Themes)
        end

    end

    self.Current =
        self.Themes[self.Name]

    self.RGBHue =
        0

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

    return self.Current.Accent

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

    -- Reset RGB hue when entering RGB
    if self.Current.RGB then
        self.RGBHue = 0
    end

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
        self.RGBHue = 0
    end

    return Color3.fromHSV(
        self.RGBHue,
        0.9,
        1
    )

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

    return self.Current.BackgroundTransparency or 1

end

return Theme

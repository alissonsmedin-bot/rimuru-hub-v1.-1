--// 🎨 RIMURU HUB
--// Theme System

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
        self.Config.UI.Theme or "Azul Escuro"

    if not self.Themes[self.Name] then
        self.Name = "Azul Escuro"
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

    if self.Current
    and self.Current.RGB then

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
        0.75,
        1
    )

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

return Theme

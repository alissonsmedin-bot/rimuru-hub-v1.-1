--// 🎨 RIMURU HUB
--// Theme System
--// Background Compatible
--// RGB Compatible

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

            self.Name =
                "Rimuru Dark"

        else

            for Name in pairs(self.Themes) do

                self.Name =
                    Name

                break

            end

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
        return Color3.fromRGB(
            255,
            255,
            255
        )
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
-- GET BACKGROUND
--==================================================

function Theme:GetBackgroundImage()

    if not self.Current then
        return nil
    end

    return self.Current.BackgroundImage

end

--==================================================
-- TRANSPARENCY
--==================================================

function Theme:GetMainTransparency()

    return self.Config.UI.MainTransparency
        or 0

end

function Theme:GetSidebarTransparency()

    return self.Config.UI.SidebarTransparency
        or 0

end

function Theme:GetContentTransparency()

    return self.Config.UI.ContentTransparency
        or 0

end

function Theme:GetCardTransparency()

    return self.Config.UI.CardTransparency
        or 0

end

function Theme:GetButtonTransparency()

    return self.Config.UI.ButtonTransparency
        or 0

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

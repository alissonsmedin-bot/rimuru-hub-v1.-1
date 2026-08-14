--// 💥 RIMURU HUB
--// RGB System

local RunService = game:GetService("RunService")

local RGB = {}

--==================================================
-- INIT
--==================================================

function RGB:Init(Context)

    self.Context =
        Context

    self.Theme =
        Context.Theme

    self.UI =
        Context.UI

    self.Logo =
        Context.Logo

    self.Categories =
        Context.Categories

    self.Running =
        true

    self.Hue =
        0

    self:Start()

end

--==================================================
-- START RGB
--==================================================

function RGB:Start()

    RunService.RenderStepped:Connect(function()

        if not self.Running then
            return
        end

        local CurrentTheme =
            self.Theme:GetCurrent()

        if not CurrentTheme then
            return
        end

        if not CurrentTheme.RGB then
            return
        end

        self.Hue +=
            0.0025

        if self.Hue >= 1 then
            self.Hue = 0
        end

        local RGBColor =
            Color3.fromHSV(
                self.Hue,
                0.9,
                1
            )

        --==================================================
        -- LOGO
        --==================================================

        if self.Logo
        and self.Logo.Stroke then

            self.Logo.Stroke.Color =
                RGBColor

        end

        --==================================================
        -- MAIN STROKE
        --==================================================

        if self.UI
        and self.UI.MainStroke then

            self.UI.MainStroke.Color =
                RGBColor

        end

        --==================================================
        -- SCROLLBAR
        --==================================================

        if self.UI
        and self.UI.Scroll then

            self.UI.Scroll.ScrollBarImageColor3 =
                RGBColor

        end

        --==================================================
        -- SELECTED CATEGORY
        --==================================================

        if self.Categories then

            local Selected =
                self.Categories:GetSelectedButton()

            if Selected then

                Selected.BackgroundColor3 =
                    RGBColor

            end

        end

        --==================================================
        -- COPY BUTTONS
        --==================================================

        if self.UI
        and self.UI.Scroll then

            for _, Object in
                ipairs(
                    self.UI.Scroll:GetDescendants()
                ) do

                if Object:IsA("TextButton") then

                    if Object.Name ==
                        "Copy"

                    or Object.Text ==
                        "Copy"

                    or Object.Text ==
                        "Copied!"

                    or Object.Text ==
                        "N/A" then

                        Object.BackgroundColor3 =
                            RGBColor

                    end

                end

            end

        end

    end)

end

--==================================================
-- STOP
--==================================================

function RGB:Stop()

    self.Running =
        false

end

return RGB

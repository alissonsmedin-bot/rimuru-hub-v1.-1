--// 💥 RIMURU HUB
--// RGB System
--// Dual Speed RGB
--// Main RGB + Slow Logo Stroke RGB

local RunService =
    game:GetService("RunService")

local RGB = {}

--==================================================
-- RGB SPEED CONFIG
--==================================================

-- RGB principal:
-- Fundo da logo
-- MainStroke
-- Scrollbar
-- Selected Category
-- Copy Buttons

local MAIN_RGB_SPEED =
    0.15

-- RGB do contorno da logo.
-- Bem mais lento que o RGB principal.

local LOGO_STROKE_RGB_SPEED =
    0.045

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

    --==================================================
    -- MAIN RGB HUE
    --==================================================

    self.Hue =
        0

    --==================================================
    -- LOGO STROKE HUE
    --==================================================

    self.LogoStrokeHue =
        0

    --==================================================
    -- RUNNING
    --==================================================

    self.Running =
        true

    --==================================================
    -- START
    --==================================================

    self:Start()

end

--==================================================
-- START RGB
--==================================================

function RGB:Start()

    RunService.RenderStepped:Connect(
        function(DeltaTime)

            if not self.Running then

                return

            end

            local CurrentTheme =
                self.Theme:GetCurrent()

            if not CurrentTheme then

                return

            end

            --==================================================
            -- RGB CHECK
            --==================================================

            if not CurrentTheme.RGB then

                return

            end

            --==================================================
            -- MAIN RGB
            --==================================================

            self.Hue +=
                DeltaTime *
                MAIN_RGB_SPEED

            if self.Hue >= 1 then

                self.Hue -= 1

            end

            local RGBColor =
                Color3.fromHSV(

                    self.Hue,

                    0.9,

                    1

                )

            --==================================================
            -- LOGO STROKE RGB
            --==================================================

            self.LogoStrokeHue +=
                DeltaTime *
                LOGO_STROKE_RGB_SPEED

            if self.LogoStrokeHue >= 1 then

                self.LogoStrokeHue -= 1

            end

            local LogoStrokeColor =
                Color3.fromHSV(

                    self.LogoStrokeHue,

                    0.9,

                    0.64

                )

            --==================================================
            -- LOGO BACKGROUND
            --==================================================
            -- O FUNDO acompanha o RGB principal.

            if self.Logo
            and self.Logo.Button then

                self.Logo.Button.BackgroundColor3 =
                    RGBColor

            end

            --==================================================
            -- LOGO STROKE
            --==================================================
            -- O CONTORNO usa RGB separado e mais lento.

            if self.Logo
            and self.Logo.Stroke then

                self.Logo.Stroke.Color =
                    LogoStrokeColor

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

        end
    )

end

--==================================================
-- STOP
--==================================================

function RGB:Stop()

    self.Running =
        false

end

--==================================================
-- RETURN
--==================================================

return RGB

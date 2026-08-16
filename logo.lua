--// 💥 RIMURU HUB
--// Logo System

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Logo = {}

--==================================================
-- INIT
--==================================================

function Logo:Init(Context)
end

--==================================================
-- CREATE LOGO
--==================================================

function Logo:Create()

    local Config =
        self.Config

    local Theme =
        self.Theme

    local CurrentTheme =
        Theme:GetCurrent()

    --==================================================
    -- LOGO BUTTON
    --==================================================

    local LogoButton =
        Instance.new("ImageButton")

    LogoButton.Name =
        "RimuruLogo"

    LogoButton.Size =
        UDim2.new(
            0,
            55,
            0,
            55
        )

    LogoButton.Position =
        UDim2.new(
            0,
            20,
            0.5,
            -27
        )

    LogoButton.BackgroundColor3 =
        CurrentTheme.LogoBackground

    LogoButton.BorderSizePixel =
        0

    LogoButton.Image =
        "rbxassetid://6691708227"

    LogoButton.ScaleType =
        Enum.ScaleType.Fit

    LogoButton.AutoButtonColor =
        false

    LogoButton.ZIndex =
        1000

    -- A logo continua visível mesmo com o menu aberto.
    LogoButton.Visible =
        Config.UI.ShowLogo

    LogoButton.Parent =
        self.Gui

    --==================================================
    -- CORNER
    --==================================================

    local LogoCorner =
        Instance.new("UICorner")

    LogoCorner.CornerRadius =
        UDim.new(
            0,
            14
        )

    LogoCorner.Parent =
        LogoButton

    --==================================================
    -- STROKE
    --==================================================

    local LogoStroke =
        Instance.new("UIStroke")

    LogoStroke.Color =
        Theme:GetAccent()

    LogoStroke.Thickness =
        2

    LogoStroke.Parent =
        LogoButton

    --==================================================
    -- SAVE REFERENCES
    --==================================================

    self.Button =
        LogoButton

    self.Stroke =
        LogoStroke

    --==================================================
    -- DRAG
    --==================================================

    self:SetupDrag()

    --==================================================
    -- OPEN / CLOSE MENU
    --==================================================

    LogoButton.MouseButton1Click:Connect(function()

        -- Se o clique foi usado para arrastar,
        -- não abre/fecha o menu.
        if self.LogoMoved() then

            self.ResetMoved()

            return

        end

        local Main =
            self.UI.Main

        if not Main then
            return
        end

        -- A logo funciona como segundo botão
        -- para abrir e fechar o menu.
        Main.Visible =
            not Main.Visible

    end)

end

--==================================================
-- DRAG SYSTEM
--==================================================

function Logo:SetupDrag()

    local LogoButton =
        self.Button

    local Config =
        self.Config

    local LogoDragging =
        false

    local LogoMoved =
        false

    local LogoDragStart
    local LogoStartPosition

    LogoButton.InputBegan:Connect(function(Input)

        if not Config.UI.LogoDraggable then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1

        or Input.UserInputType ==
            Enum.UserInputType.Touch then

            LogoDragging =
                true

            LogoMoved =
                false

            LogoDragStart =
                Input.Position

            LogoStartPosition =
                LogoButton.Position

        end

    end)

    UIS.InputChanged:Connect(function(Input)

        if not LogoDragging then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseMovement

        or Input.UserInputType ==
            Enum.UserInputType.Touch then

            local Delta =
                Input.Position -
                LogoDragStart

            if math.abs(Delta.X) > 5
            or math.abs(Delta.Y) > 5 then

                LogoMoved =
                    true

            end

            LogoButton.Position =
                UDim2.new(

                    LogoStartPosition.X.Scale,

                    LogoStartPosition.X.Offset +
                    Delta.X,

                    LogoStartPosition.Y.Scale,

                    LogoStartPosition.Y.Offset +
                    Delta.Y

                )

        end

    end)

    UIS.InputEnded:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1

        or Input.UserInputType ==
            Enum.UserInputType.Touch then

            LogoDragging =
                false

        end

    end)

    self.LogoMoved =
        function()

            return LogoMoved

        end

    self.ResetMoved =
        function()

            LogoMoved =
                false

        end

end

--==================================================
-- VISIBILITY
--==================================================

function Logo:SetVisible(Value)

    if self.Button then

        self.Button.Visible =
            Value

    end

end

function Logo:IsVisible()

    if not self.Button then
        return false
    end

    return self.Button.Visible

end

--==================================================
-- GET BUTTON
--==================================================

function Logo:GetButton()

    return self.Button

end

--==================================================
-- APPLY THEME
--==================================================

function Logo:ApplyTheme()

    if not self.Button then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    self.Button.BackgroundColor3 =
        CurrentTheme.LogoBackground

    self.Stroke.Color =
        self.Theme:GetAccent()

end

return Logo

--// 💥 RIMURU HUB
--// Logo System
--// SEARCH VERSION
--// Modular Logo Controller

local Players =
    game:GetService("Players")

local UIS =
    game:GetService("UserInputService")

local Logo = {}

--==================================================
-- INIT
--==================================================

function Logo:Init(Context)

    self.Context =
        Context

    self.Player =
        Context.Player
        or Players.LocalPlayer

    self.PlayerGui =
        Context.PlayerGui
        or self.Player:WaitForChild(
            "PlayerGui"
        )

    self.Config =
        Context.Config

    self.Theme =
        Context.Theme

    self.UI =
        Context.UI

    --==================================================
    -- VALIDATION
    --==================================================

    if not self.Config then

        warn(
            "❌ Rimuru Hub Logo: Config não encontrado."
        )

        return

    end

    if not self.Theme then

        warn(
            "❌ Rimuru Hub Logo: Theme não encontrado."
        )

        return

    end

    if not self.UI then

        warn(
            "❌ Rimuru Hub Logo: UI não encontrado."
        )

        return

    end

    self.Gui =
        self.UI.Gui

    if not self.Gui then

        warn(
            "❌ Rimuru Hub Logo: ScreenGui não encontrado."
        )

        return

    end

    --==================================================
    -- CREATE
    --==================================================

    self:Create()

end

--==================================================
-- CREATE LOGO
--==================================================

function Logo:Create()

    local Config =
        self.Config

    local Theme =
        self.Theme

    if not Config
    or not Config.UI then

        warn(
            "❌ Rimuru Hub Logo: Config.UI não encontrado."
        )

        return

    end

    local CurrentTheme =
        Theme:GetCurrent()

    if not CurrentTheme then

        warn(
            "❌ Rimuru Hub Logo: tema atual não encontrado."
        )

        return

    end

    --==================================================
    -- REMOVE OLD LOGO
    --==================================================

    local OldLogo =
        self.Gui:FindFirstChild(
            "RimuruLogo"
        )

    if OldLogo then

        OldLogo:Destroy()

    end

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

    LogoButton.Visible =
        Config.UI.ShowLogo == true

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

        if self.LogoMoved
        and self.LogoMoved() then

            if self.ResetMoved then

                self.ResetMoved()

            end

            return

        end

        local Main

        if self.UI then

            Main =
                self.UI.Main

        end

        if not Main then
            return
        end

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

    if not LogoButton
    or not Config
    or not Config.UI then

        return

    end

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

    if not self.Button
    or not self.Theme then

        return

    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

    self.Button.BackgroundColor3 =
        CurrentTheme.LogoBackground

    self.Stroke.Color =
        self.Theme:GetAccent()

end

--==================================================
-- RETURN
--==================================================

return Logo

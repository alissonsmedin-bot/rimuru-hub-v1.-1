--// 💥 RIMURU HUB
--// Logo System
--// GitHub Image Version
--// Centralized Logo
--// Press Animation
--// Animation Config Support
--// No Roblox ImageId Required

local Players =
    game:GetService("Players")

local UIS =
    game:GetService("UserInputService")

local TweenService =
    game:GetService("TweenService")

local Logo = {}

--==================================================
-- IMAGE CONFIG
--==================================================

local IMAGE_URL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/1000086171-removebg-preview.png"

local IMAGE_PATH =
    "RimuruHubLogo.png"

--==================================================
-- ANIMATION CONFIG
--==================================================

local PRESS_SCALE =
    0.95

local PRESS_TIME =
    0.09

local RELEASE_TIME =
    0.15

--==================================================
-- LOAD GITHUB IMAGE
--==================================================

local function LoadImage()

    if not getcustomasset then

        warn(
            "⚠️ Rimuru Hub: getcustomasset() não está disponível."
        )

        return nil

    end

    --==================================================
    -- CHECK EXISTING FILE
    --==================================================

    if isfile then

        local Success, Exists =
            pcall(function()

                return isfile(
                    IMAGE_PATH
                )

            end)

        if Success
        and Exists then

            local AssetSuccess, Asset =
                pcall(function()

                    return getcustomasset(
                        IMAGE_PATH
                    )

                end)

            if AssetSuccess then

                return Asset

            end

        end

    end

    --==================================================
    -- DOWNLOAD IMAGE
    --==================================================

    local Success, Data =
        pcall(function()

            return game:HttpGet(
                IMAGE_URL
            )

        end)

    if not Success
    or not Data
    or Data == "" then

        warn(
            "⚠️ Rimuru Hub: não foi possível baixar a logo do GitHub."
        )

        return nil

    end

    --==================================================
    -- SAVE IMAGE
    --==================================================

    if not writefile then

        warn(
            "⚠️ Rimuru Hub: writefile() não está disponível."
        )

        return nil

    end

    local WriteSuccess =
        pcall(function()

            writefile(
                IMAGE_PATH,
                Data
            )

        end)

    if not WriteSuccess then

        warn(
            "⚠️ Rimuru Hub: não foi possível salvar a logo."
        )

        return nil

    end

    --==================================================
    -- CUSTOM ASSET
    --==================================================

    local AssetSuccess, Asset =
        pcall(function()

            return getcustomasset(
                IMAGE_PATH
            )

        end)

    if not AssetSuccess then

        warn(
            "⚠️ Rimuru Hub: getcustomasset() falhou ao carregar a logo."
        )

        return nil

    end

    return Asset

end

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
    -- LOAD IMAGE
    --==================================================

    self.ImageAsset =
        LoadImage()

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
            -22
        )

    LogoButton.BackgroundColor3 =
        CurrentTheme.LogoBackground

    LogoButton.BorderSizePixel =
        0

    LogoButton.Image =
        ""

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
    -- LOGO IMAGE
    --==================================================

    local LogoImage =
        Instance.new("ImageLabel")

    LogoImage.Name =
        "LogoImage"

    LogoImage.AnchorPoint =
        Vector2.new(
            0.5,
            0.5
        )

    LogoImage.Position =
        UDim2.new(
            0.5,
            0,
            0.5,
            0
        )

    LogoImage.Size =
        UDim2.new(
            0,
            46,
            0,
            46
        )

    LogoImage.BackgroundTransparency =
        1

    LogoImage.BorderSizePixel =
        0

    LogoImage.ScaleType =
        Enum.ScaleType.Fit

    LogoImage.ZIndex =
        1001

    LogoImage.Active =
        false

    --==================================================
    -- IMAGE ASSET
    --==================================================

    if self.ImageAsset then

        LogoImage.Image =
            self.ImageAsset

    else

        LogoImage.Image =
            "rbxassetid://6691708227"

    end

    LogoImage.Parent =
        LogoButton

    self.Image =
        LogoImage

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
    -- ANIMATION SCALE
    --==================================================

    local Scale =
        Instance.new("UIScale")

    Scale.Name =
        "PressScale"

    Scale.Scale =
        1

    Scale.Parent =
        LogoButton

    self.Scale =
        Scale

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
    -- PRESS ANIMATION
    --==================================================

    self:SetupPressAnimation()

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

        --==================================================
        -- ANIMATED MENU
        --==================================================

        if self.UI.SetVisibleAnimated then

            self.UI:SetVisibleAnimated(
                not Main.Visible
            )

        else

            Main.Visible =
                not Main.Visible

        end

    end)

end

--==================================================
-- CHECK ANIMATION
--==================================================

function Logo:IsAnimationEnabled()

    if not self.Config
    or not self.Config.UI then

        return true

    end

    if self.Config.UI.Animation == false then

        return false

    end

    return true

end

--==================================================
-- PRESS ANIMATION
--==================================================

function Logo:SetupPressAnimation()

    local LogoButton =
        self.Button

    local Scale =
        self.Scale

    if not LogoButton
    or not Scale then

        return

    end

    local PressTween
    local ReleaseTween

    --==================================================
    -- PRESS
    --==================================================

    LogoButton.InputBegan:Connect(function(Input)

        if Input.UserInputType ~=
            Enum.UserInputType.MouseButton1

        and Input.UserInputType ~=
            Enum.UserInputType.Touch then

            return

        end

        if not self:IsAnimationEnabled() then

            Scale.Scale =
                1

            return

        end

        if PressTween then

            PressTween:Cancel()

        end

        if ReleaseTween then

            ReleaseTween:Cancel()

        end

        PressTween =
            TweenService:Create(

                Scale,

                TweenInfo.new(

                    PRESS_TIME,

                    Enum.EasingStyle.Quad,

                    Enum.EasingDirection.Out

                ),

                {
                    Scale = PRESS_SCALE
                }

            )

        PressTween:Play()

    end)

    --==================================================
    -- RELEASE
    --==================================================

    LogoButton.InputEnded:Connect(function(Input)

        if Input.UserInputType ~=
            Enum.UserInputType.MouseButton1

        and Input.UserInputType ~=
            Enum.UserInputType.Touch then

            return

        end

        if not self:IsAnimationEnabled() then

            Scale.Scale =
                1

            return

        end

        if PressTween then

            PressTween:Cancel()

        end

        if ReleaseTween then

            ReleaseTween:Cancel()

        end

        ReleaseTween =
            TweenService:Create(

                Scale,

                TweenInfo.new(

                    RELEASE_TIME,

                    Enum.EasingStyle.Back,

                    Enum.EasingDirection.Out

                ),

                {
                    Scale = 1
                }

            )

        ReleaseTween:Play()

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

    if self.Stroke then

        self.Stroke.Color =
            self.Theme:GetAccent()

    end

end

--==================================================
-- RETURN
--==================================================

return Logo

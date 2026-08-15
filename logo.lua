--// 💥 RIMURU HUB
--// Logo System
--// LOCAL IMAGE VERSION
--// Sem ImageId do Roblox
--// Usa arquivo local + getcustomasset()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Logo = {}

--==================================================
-- CONFIGURAÇÃO DA LOGO
--==================================================

local LOGO_SIZE = 55

-- Caminhos possíveis.
-- O sistema testa na ordem.
local LOGO_PATHS = {
    "assets/logo.png",
    "RimuruHub/assets/logo.png",
    "RimuruHub/logo.png",
    "logo.png"
}

--==================================================
-- INIT
--==================================================

function Logo:Init(Context)

    self.Context =
        Context or {}

    self.Player =
        self.Context.Player
        or Players.LocalPlayer

    if not self.Player then
        return
    end

    self.PlayerGui =
        self.Context.PlayerGui
        or self.Player:WaitForChild("PlayerGui")

    self.Config =
        self.Context.Config

    self.Theme =
        self.Context.Theme

    self.UI =
        self.Context.UI

    if not self.UI then

        warn(
            "[Rimuru Hub] UI não encontrado."
        )

        return
    end

    if not self.UI.Gui then

        warn(
            "[Rimuru Hub] ScreenGui não encontrado."
        )

        return
    end

    self.Gui =
        self.UI.Gui

    self:Create()

end

--==================================================
-- GET LOCAL ASSET
--==================================================

function Logo:GetLocalAsset()

    --==============================================
    -- GETCUSTOMASSET
    --==============================================

    local CustomAsset =
        getcustomasset

    --==============================================
    -- FALLBACK
    --==============================================

    if type(CustomAsset) ~= "function" then

        if type(getsynasset) == "function" then

            CustomAsset =
                getsynasset

        end

    end

    if type(CustomAsset) ~= "function" then

        warn(
            "[Rimuru Hub] getcustomasset/getsynasset não encontrado."
        )

        return nil
    end

    --==============================================
    -- TESTA OS CAMINHOS
    --==============================================

    for _, Path in ipairs(LOGO_PATHS) do

        local Exists = true

        -- Se isfile existir, verifica primeiro.
        if type(isfile) == "function" then

            local Success, Result =
                pcall(
                    isfile,
                    Path
                )

            if not Success or not Result then

                Exists = false

            end

        end

        if Exists then

            local Success, Asset =
                pcall(
                    CustomAsset,
                    Path
                )

            if Success
            and Asset
            and type(Asset) == "string"
            and Asset ~= "" then

                print(
                    "[Rimuru Hub] Logo encontrada: "
                    .. Path
                )

                return Asset
            end

        end

    end

    warn(
        "[Rimuru Hub] Não foi possível encontrar assets/logo.png."
    )

    return nil

end

--==================================================
-- CREATE LOGO
--==================================================

function Logo:Create()

    if not self.Gui then
        return
    end

    local Config =
        self.Config or {}

    local Theme =
        self.Theme

    if not Theme then
        return
    end

    local CurrentTheme =
        Theme:GetCurrent()

    if not CurrentTheme then
        return
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
            LOGO_SIZE,
            0,
            LOGO_SIZE
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

    --==================================================
    -- LOCAL IMAGE
    --==================================================

    LogoButton.Image =
        ""

    LogoButton.ImageTransparency =
        0

    LogoButton.ScaleType =
        Enum.ScaleType.Fit

    LogoButton.ResampleMode =
        Enum.ResamplerMode.Default

    LogoButton.AutoButtonColor =
        false

    LogoButton.ZIndex =
        1000

    --==================================================
    -- CONFIG VISIBILITY
    --==================================================

    local ShowLogo =
        true

    pcall(function()

        if Config.UI
        and Config.UI.ShowLogo ~= nil then

            ShowLogo =
                Config.UI.ShowLogo

        end

    end)

    LogoButton.Visible =
        ShowLogo

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
    -- LOAD LOCAL LOGO
    --==================================================

    self:LoadImage()

    --==================================================
    -- DRAG
    --==================================================

    self:SetupDrag()

    --==================================================
    -- OPEN / CLOSE
    --==================================================

    pcall(function()

        LogoButton.Activated:Connect(function()

            if self.LogoMoved
            and self.LogoMoved() then

                self.ResetMoved()

                return

            end

            local Main =
                self.UI.Main

            if not Main then
                return
            end

            Main.Visible =
                not Main.Visible

        end)

    end)

end

--==================================================
-- LOAD IMAGE
--==================================================

function Logo:LoadImage()

    if not self.Button then
        return
    end

    local Asset =
        self:GetLocalAsset()

    if not Asset then

        self.Button.Image =
            ""

        self.Button.ImageTransparency =
            1

        warn(
            "[Rimuru Hub] Logo local não carregada."
        )

        warn(
            "[Rimuru Hub] Coloque o arquivo em: assets/logo.png"
        )

        return false

    end

    local Success =
        pcall(function()

            self.Button.Image =
                Asset

            self.Button.ImageTransparency =
                0

            self.Button.ScaleType =
                Enum.ScaleType.Fit

        end)

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao aplicar a logo local."
        )

        return false

    end

    print(
        "[Rimuru Hub] Logo local carregada com sucesso."
    )

    return true

end

--==================================================
-- DRAG SYSTEM
--==================================================

function Logo:SetupDrag()

    local LogoButton =
        self.Button

    if not LogoButton then
        return
    end

    local Config =
        self.Config or {}

    local LogoDragging =
        false

    local LogoMoved =
        false

    local LogoDragStart =
        nil

    local LogoStartPosition =
        nil

    --==================================================
    -- BUTTON INPUT
    --==================================================

    self.LogoInputBegan =
        LogoButton.InputBegan:Connect(
            function(Input)

                local CanDrag =
                    true

                pcall(function()

                    if Config.UI
                    and Config.UI.LogoDraggable ~= nil then

                        CanDrag =
                            Config.UI.LogoDraggable

                    end

                end)

                if not CanDrag then
                    return
                end

                local InputType =
                    Input.UserInputType

                if InputType ==
                    Enum.UserInputType.MouseButton1

                or InputType ==
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

            end
        )

    --==================================================
    -- INPUT CHANGED
    --==================================================

    self.LogoInputChanged =
        UIS.InputChanged:Connect(
            function(Input)

                if not LogoDragging then
                    return
                end

                local InputType =
                    Input.UserInputType

                if InputType ~=
                    Enum.UserInputType.MouseMovement

                and InputType ~=
                    Enum.UserInputType.Touch then

                    return

                end

                if not LogoDragStart
                or not LogoStartPosition then

                    return

                end

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

                        LogoStartPosition.X.Offset
                        + Delta.X,

                        LogoStartPosition.Y.Scale,

                        LogoStartPosition.Y.Offset
                        + Delta.Y

                    )

            end
        )

    --==================================================
    -- INPUT ENDED
    --==================================================

    self.LogoInputEnded =
        UIS.InputEnded:Connect(
            function(Input)

                local InputType =
                    Input.UserInputType

                if InputType ==
                    Enum.UserInputType.MouseButton1

                or InputType ==
                    Enum.UserInputType.Touch then

                    LogoDragging =
                        false

                    LogoDragStart =
                        nil

                    LogoStartPosition =
                        nil

                end

            end
        )

    --==================================================
    -- MOVED STATE
    --==================================================

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

    if not self.Button then
        return
    end

    self.Button.Visible =
        Value

end

--==================================================
-- IS VISIBLE
--==================================================

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

    if not self.Theme then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

    --==================================================
    -- BACKGROUND
    --==================================================

    self.Button.BackgroundColor3 =
        CurrentTheme.LogoBackground

    --==================================================
    -- STROKE
    --==================================================

    if self.Stroke then

        self.Stroke.Color =
            self.Theme:GetAccent()

    end

end

--==================================================
-- DESTROY
--==================================================

function Logo:Destroy()

    --==================================================
    -- DISCONNECT EVENTS
    --==================================================

    pcall(function()

        if self.LogoInputBegan then

            self.LogoInputBegan:Disconnect()

        end

        if self.LogoInputChanged then

            self.LogoInputChanged:Disconnect()

        end

        if self.LogoInputEnded then

            self.LogoInputEnded:Disconnect()

        end

    end)

    --==================================================
    -- REMOVE BUTTON
    --==================================================

    pcall(function()

        if self.Button then

            self.Button:Destroy()

        end

    end)

    self.Button =
        nil

    self.Stroke =
        nil

end

--==================================================
-- RETURN
--==================================================

return Logo

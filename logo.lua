--// 💥 RIMURU HUB
--// Logo System
--// GITHUB + LOCAL ASSET VERSION
--// PNG TRANSPARENTE
--// Sem ImageId do Roblox

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Logo = {}

--==================================================
-- CONFIG
--==================================================

local LOGO_SIZE = 55

--==================================================
-- ARQUIVOS LOCAIS
--==================================================

local LOCAL_LOGO_PATHS = {
    "1000086171-removebg-preview.png",
    "assets/1000086171-removebg-preview.png",
    "RimuruHub/1000086171-removebg-preview.png",
    "RimuruHub/assets/1000086171-removebg-preview.png",
}

--==================================================
-- LOGO NO GITHUB
--==================================================

local GITHUB_LOGO_URL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/1000086171-removebg-preview.png"

--==================================================
-- INIT
--==================================================

function Logo:Init(Context)

    self.Context = Context or {}

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
        warn("[Rimuru Hub] UI não encontrado.")
        return
    end

    if not self.UI.Gui then
        warn("[Rimuru Hub] ScreenGui não encontrado.")
        return
    end

    self.Gui =
        self.UI.Gui

    self:Create()

end

--==================================================
-- LOCAL ASSET
--==================================================

function Logo:GetLocalAsset()

    local AssetFunction = nil

    if type(getcustomasset) == "function" then
        AssetFunction = getcustomasset
    elseif type(getsynasset) == "function" then
        AssetFunction = getsynasset
    end

    if not AssetFunction then
        return nil
    end

    for _, Path in ipairs(LOCAL_LOGO_PATHS) do

        local Exists = true

        if type(isfile) == "function" then

            local Success, Result =
                pcall(isfile, Path)

            if not Success or not Result then
                Exists = false
            end

        end

        if Exists then

            local Success, Asset =
                pcall(
                    AssetFunction,
                    Path
                )

            if Success
            and type(Asset) == "string"
            and Asset ~= "" then

                print(
                    "[Rimuru Hub] Logo PNG local encontrada: "
                    .. Path
                )

                return Asset

            end

        end

    end

    return nil

end

--==================================================
-- GITHUB ASSET
--==================================================

function Logo:GetGitHubAsset()

    local RequestFunction = nil

    -- Procura pelas APIs HTTP mais comuns
    if type(request) == "function" then
        RequestFunction = request

    elseif type(http_request) == "function" then
        RequestFunction = http_request

    elseif type(syn) == "table"
    and type(syn.request) == "function" then
        RequestFunction = syn.request

    elseif type(http) == "table"
    and type(http.request) == "function" then
        RequestFunction = http.request
    end

    if not RequestFunction then

        warn(
            "[Rimuru Hub] Nenhuma API de request encontrada."
        )

        return nil

    end

    local Success, Response =
        pcall(
            RequestFunction,
            {
                Url = GITHUB_LOGO_URL,
                Method = "GET"
            }
        )

    if not Success or not Response then

        warn(
            "[Rimuru Hub] Falha ao acessar a logo PNG do GitHub."
        )

        return nil

    end

    if Response.StatusCode
    and Response.StatusCode ~= 200 then

        warn(
            "[Rimuru Hub] GitHub retornou HTTP "
            .. tostring(Response.StatusCode)
        )

        return nil

    end

    local Body =
        Response.Body

    if type(Body) ~= "string"
    or #Body == 0 then

        warn(
            "[Rimuru Hub] GitHub retornou dados vazios."
        )

        return nil

    end

    --==================================================
    -- SALVA COMO PNG LOCAL
    --==================================================

    if type(writefile) == "function" then

        -- IMPORTANTE:
        -- Mantemos .png para preservar transparência.

        local TempPath =
            "rimuru_hub_logo.png"

        local WriteSuccess =
            pcall(
                writefile,
                TempPath,
                Body
            )

        if WriteSuccess then

            local AssetFunction = nil

            if type(getcustomasset) == "function" then
                AssetFunction = getcustomasset

            elseif type(getsynasset) == "function" then
                AssetFunction = getsynasset
            end

            if AssetFunction then

                local AssetSuccess, Asset =
                    pcall(
                        AssetFunction,
                        TempPath
                    )

                if AssetSuccess
                and type(Asset) == "string"
                and Asset ~= "" then

                    print(
                        "[Rimuru Hub] Logo PNG carregada pelo GitHub."
                    )

                    return Asset

                end

            end

        end

    end

    warn(
        "[Rimuru Hub] O Delta conseguiu acessar o GitHub,"
        .. " mas não conseguiu transformar a PNG em asset."
    )

    return nil

end

--==================================================
-- LOAD LOGO
--==================================================

function Logo:LoadImage()

    if not self.Button then
        return false
    end

    --==================================================
    -- 1. LOCAL
    --==================================================

    local Asset =
        self:GetLocalAsset()

    if Asset then

        self.Button.Image =
            Asset

        self.Button.ImageTransparency =
            0

        return true

    end

    --==================================================
    -- 2. GITHUB
    --==================================================

    Asset =
        self:GetGitHubAsset()

    if Asset then

        self.Button.Image =
            Asset

        self.Button.ImageTransparency =
            0

        return true

    end

    --==================================================
    -- FALHA
    --==================================================

    self.Button.Image =
        ""

    self.Button.ImageTransparency =
        1

    warn(
        "[Rimuru Hub] Não foi possível carregar a logo."
    )

    return false

end

--==================================================
-- CREATE
--==================================================

function Logo:Create()

    if not self.Gui then
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
    -- BUTTON
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

    LogoButton.Image =
        ""

    LogoButton.ImageTransparency =
        1

    -- Mantém a proporção da logo
    LogoButton.ScaleType =
        Enum.ScaleType.Fit

    LogoButton.AutoButtonColor =
        false

    LogoButton.ZIndex =
        1000

    --==================================================
    -- VISIBILITY
    --==================================================

    local ShowLogo =
        true

    pcall(function()

        if self.Config
        and self.Config.UI
        and self.Config.UI.ShowLogo ~= nil then

            ShowLogo =
                self.Config.UI.ShowLogo

        end

    end)

    LogoButton.Visible =
        ShowLogo

    LogoButton.Parent =
        self.Gui

    --==================================================
    -- CORNER
    --==================================================

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            14
        )

    Corner.Parent =
        LogoButton

    --==================================================
    -- STROKE
    --==================================================

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        2

    Stroke.Parent =
        LogoButton

    --==================================================
    -- REFERENCES
    --==================================================

    self.Button =
        LogoButton

    self.Stroke =
        Stroke

    --==================================================
    -- LOAD IMAGE
    --==================================================

    task.spawn(function()
        self:LoadImage()
    end)

    --==================================================
    -- DRAG
    --==================================================

    self:SetupDrag()

    --==================================================
    -- OPEN / CLOSE
    --==================================================

    LogoButton.Activated:Connect(
        function()

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

        end
    )

end

--==================================================
-- DRAG
--==================================================

function Logo:SetupDrag()

    local Button =
        self.Button

    if not Button then
        return
    end

    local Dragging =
        false

    local Moved =
        false

    local DragStart =
        nil

    local StartPosition =
        nil

    self.LogoInputBegan =
        Button.InputBegan:Connect(
            function(Input)

                local CanDrag =
                    true

                pcall(function()

                    if self.Config
                    and self.Config.UI
                    and self.Config.UI.LogoDraggable ~= nil then

                        CanDrag =
                            self.Config.UI.LogoDraggable

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

                    Dragging =
                        true

                    Moved =
                        false

                    DragStart =
                        Input.Position

                    StartPosition =
                        Button.Position

                end

            end
        )

    self.LogoInputChanged =
        UIS.InputChanged:Connect(
            function(Input)

                if not Dragging then
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

                if not DragStart
                or not StartPosition then
                    return
                end

                local Delta =
                    Input.Position -
                    DragStart

                if math.abs(Delta.X) > 5
                or math.abs(Delta.Y) > 5 then

                    Moved =
                        true

                end

                Button.Position =
                    UDim2.new(
                        StartPosition.X.Scale,
                        StartPosition.X.Offset + Delta.X,
                        StartPosition.Y.Scale,
                        StartPosition.Y.Offset + Delta.Y
                    )

            end
        )

    self.LogoInputEnded =
        UIS.InputEnded:Connect(
            function(Input)

                local InputType =
                    Input.UserInputType

                if InputType ==
                    Enum.UserInputType.MouseButton1
                or InputType ==
                    Enum.UserInputType.Touch then

                    Dragging =
                        false

                    DragStart =
                        nil

                    StartPosition =
                        nil

                end

            end
        )

    self.LogoMoved =
        function()
            return Moved
        end

    self.ResetMoved =
        function()
            Moved = false
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
-- THEME
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

    self.Button.BackgroundColor3 =
        CurrentTheme.LogoBackground

    if self.Stroke then

        self.Stroke.Color =
            self.Theme:GetAccent()

    end

end

--==================================================
-- DESTROY
--==================================================

function Logo:Destroy()

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

    pcall(function()

        if self.Button then
            self.Button:Destroy()
        end

    end)

    self.Button = nil
    self.Stroke = nil

end

--==================================================
-- RETURN
--==================================================

return Logo

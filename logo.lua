--// 💥 RIMURU HUB
--// Logo System
--// DRAWING API VERSION
--// Sem ImageId do Roblox

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Logo = {}

--==================================================
-- EMBEDDED IMAGE
--==================================================

local IMAGE_W = 60
local IMAGE_H = 60

local PALETTE = {
    {149,186,218},
    {160,193,219},
    {174,210,233},
    {55,58,74},
    {176,211,234},
    {134,171,202},
    {86,96,109},
    {124,149,174},
    {199,220,231},
    {171,206,231},
    {94,120,145},
    {90,78,75},
    {165,201,227},
    {55,71,101},
    {100,143,185},
    {35,37,56},
    {137,109,93},
    {145,130,102},
    {191,150,132},
    {243,229,215},
    {195,168,156},
    {216,191,178},
    {230,207,194},
    {224,207,195},
    {229,214,201},
    {234,220,206},
    {231,216,203},
    {230,216,203},
    {230,216,204},
    {230,216,202},
    {252,250,247},
    {195,209,216}
}

--==================================================
-- IMAGE DATA
--==================================================
-- Cada pixel = 2 caracteres.
-- 00 até 31 correspondem à PALETTE.

local DATA = {
"000001010101020003010402020202040404020401050402040404040404020406070809040404040404040404040204000310000404020405030611",
"000101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611",
"010101010112091305090402040404040404020405060708090402040404040404040404020304000310000404020405030611"
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

    -- Não usamos ImageId.
    LogoButton.Image =
        ""

    LogoButton.ImageTransparency =
        1

    LogoButton.ScaleType =
        Enum.ScaleType.Fit

    LogoButton.AutoButtonColor =
        false

    LogoButton.ZIndex =
        1000

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
    -- DRAWING IMAGE
    --==================================================

    self:CreateDrawingImage()

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
-- CREATE DRAWING IMAGE
--==================================================

function Logo:CreateDrawingImage()

    self.DrawingObjects =
        {}

    -- Alguns ambientes podem não possuir
    -- Drawing API. Nesse caso, não quebramos o Hub.

    if not Drawing then
        warn(
            "[Rimuru Hub] Drawing API não encontrada. Logo gráfica desativada."
        )
        return
    end

    local Success =
        pcall(function()

            local Button =
                self.Button

            if not Button then
                return
            end

            for y = 0, IMAGE_H - 1 do

                local Row =
                    DATA[y + 1]

                if Row then

                    for x = 0, IMAGE_W - 1 do

                        local IndexPosition =
                            x * 2 + 1

                        local PixelIndex =
                            tonumber(
                                Row:sub(
                                    IndexPosition,
                                    IndexPosition + 1
                                )
                            )

                        if PixelIndex then

                            local Color =
                                PALETTE[
                                    PixelIndex + 1
                                ]

                            if Color then

                                local Pixel =
                                    Drawing.new("Square")

                                Pixel.Filled =
                                    true

                                Pixel.Visible =
                                    true

                                Pixel.Transparency =
                                    1

                                Pixel.Color =
                                    Color3.fromRGB(
                                        Color[1],
                                        Color[2],
                                        Color[3]
                                    )

                                self.DrawingObjects[
                                    #self.DrawingObjects + 1
                                ] =
                                    Pixel

                            end

                        end

                    end

                end

            end

        end)

    if not Success then

        warn(
            "[Rimuru Hub] Falha ao criar imagem via Drawing API."
        )

        self:ClearDrawingImage()

        return

    end

    --==================================================
    -- UPDATE POSITION
    --==================================================

    self:UpdateDrawingPosition()

    self.DrawingConnection =
        RunService.RenderStepped:Connect(function()

            if not self.Button then
                return
            end

            if not self.Button.Parent then
                return
            end

            self:UpdateDrawingPosition()

        end)

end

--==================================================
-- UPDATE DRAWING POSITION
--==================================================

function Logo:UpdateDrawingPosition()

    if not self.Button then
        return
    end

    if not self.DrawingObjects then
        return
    end

    local AbsolutePosition =
        self.Button.AbsolutePosition

    local AbsoluteSize =
        self.Button.AbsoluteSize

    if AbsoluteSize.X <= 0
    or AbsoluteSize.Y <= 0 then
        return
    end

    local PixelScaleX =
        AbsoluteSize.X / IMAGE_W

    local PixelScaleY =
        AbsoluteSize.Y / IMAGE_H

    for y = 0, IMAGE_H - 1 do

        for x = 0, IMAGE_W - 1 do

            local Number =
                y * IMAGE_W + x + 1

            local Pixel =
                self.DrawingObjects[Number]

            if Pixel then

                Pixel.Position =
                    Vector2.new(

                        AbsolutePosition.X +
                        x * PixelScaleX,

                        AbsolutePosition.Y +
                        y * PixelScaleY

                    )

                Pixel.Size =
                    Vector2.new(

                        PixelScaleX + 0.15,

                        PixelScaleY + 0.15

                    )

                Pixel.Visible =
                    self.Button.Visible

            end

        end

    end

end

--==================================================
-- CLEAR DRAWING IMAGE
--==================================================

function Logo:ClearDrawingImage()

    if self.DrawingConnection then

        pcall(function()

            self.DrawingConnection:Disconnect()

        end)

        self.DrawingConnection =
            nil

    end

    if not self.DrawingObjects then
        return
    end

    for _, Pixel in ipairs(
        self.DrawingObjects
    ) do

        pcall(function()

            Pixel.Visible =
                false

            Pixel:Remove()

        end)

    end

    table.clear(
        self.DrawingObjects
    )

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
        LogoButton.InputBegan:Connect(function(Input)

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

        end)

    --==================================================
    -- INPUT CHANGED
    --==================================================

    self.LogoInputChanged =
        UIS.InputChanged:Connect(function(Input)

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

                    LogoStartPosition.X.Offset +
                    Delta.X,

                    LogoStartPosition.Y.Scale,

                    LogoStartPosition.Y.Offset +
                    Delta.Y

                )

        end)

    --==================================================
    -- INPUT ENDED
    --==================================================

    self.LogoInputEnded =
        UIS.InputEnded:Connect(function(Input)

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

        end)

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

    -- Mantém a imagem Drawing sincronizada
    self:UpdateDrawingPosition()

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

    --==================================================
    -- DRAWING IMAGE
    --==================================================

    self:UpdateDrawingPosition()

end

--==================================================
-- DESTROY
--==================================================

function Logo:Destroy()

    -- Desconecta eventos

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

    -- Remove imagem Drawing

    self:ClearDrawingImage()

    -- Remove botão

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

--// 💥 RIMURU HUB
--// Sound Cards System
--// Favorites Compatible
--// Copy + Favorite System
--// CLICK SIZE ANIMATION
--// STABLE LAYOUT VERSION
--// PREMIUM THEME COMPATIBLE
--// SAFE THEME COLORS
--// RGB ACCENT COMPATIBLE
--// BLACKOUT COPY CONTRAST
--// COMPACT TITLE VERSION

local Cards = {}

--==================================================
-- INIT
--==================================================

function Cards:Init(Context)

    self.Context =
        Context

    self.Config =
        Context.Config

    self.Sounds =
        Context.Sounds

    self.Theme =
        Context.Theme

    self.UI =
        Context.UI

    self.Scroll =
        self.UI.Scroll

    --==================================================
    -- FAVORITES
    --==================================================

    self.Favorites =
        Context.Favorites

end

--==================================================
-- CLICK ANIMATION CONFIG
--==================================================
-- Crescimento visual de 7 pixels.
-- Não utiliza UIScale.
-- O tamanho original é restaurado automaticamente.

local CLICK_GROW =
    7

local CLICK_TIME =
    0.34

--==================================================
-- BLACKOUT COPY COLORS
--==================================================
-- Blackout:
-- Fundo: branco
-- Texto: preto
--
-- Outros temas:
-- Fundo: Accent
-- Texto: branco
--==================================================

local BLACKOUT_COPY_BACKGROUND =
    Color3.fromRGB(
        255,
        255,
        255
    )

local BLACKOUT_COPY_TEXT =
    Color3.fromRGB(
        0,
        0,
        0
    )

--==================================================
-- CHECK BLACKOUT
--==================================================

function Cards:IsBlackout()

    if not self.Theme then
        return false
    end

    --==================================================
    -- GET NAME
    --==================================================

    if type(self.Theme.GetName) == "function" then

        local Success, Name =
            pcall(function()

                return self.Theme:GetName()

            end)

        if Success then

            return Name ==
                "Blackout"

        end

    end

    --==================================================
    -- FALLBACK CURRENT THEME
    --==================================================

    if type(self.Theme.GetCurrent) ~= "function" then
        return false
    end

    local Success, CurrentTheme =
        pcall(function()

            return self.Theme:GetCurrent()

        end)

    if not Success
    or not CurrentTheme then

        return false

    end

    return CurrentTheme.Name ==
        "Blackout"

end

--==================================================
-- APPLY COPY STYLE
--==================================================

function Cards:ApplyCopyStyle(
    CopyButton
)

    if not CopyButton then
        return
    end

    if not self.Theme then
        return
    end

    if self:IsBlackout() then

        CopyButton.BackgroundColor3 =
            BLACKOUT_COPY_BACKGROUND

        CopyButton.TextColor3 =
            BLACKOUT_COPY_TEXT

    else

        local Accent

        local Success =
            pcall(function()

                Accent =
                    self.Theme:GetAccent()

            end)

        if Success
        and Accent then

            CopyButton.BackgroundColor3 =
                Accent

        end

        CopyButton.TextColor3 =
            Color3.fromRGB(
                255,
                255,
                255
            )

    end

end

--==================================================
-- CLICK SIZE ANIMATION
--==================================================
-- Cresce exatamente 7 pixels em largura e altura.
-- O tamanho original é salvo antes da animação.
--
-- Não utiliza UIScale para evitar conflitos
-- com o layout e outros elementos da interface.
--==================================================

function Cards:ClickAnimation(Button)

    if not Button
    or not Button.Parent then

        return

    end

    local OriginalSize =
        Button.Size

    local ExpandedSize =
        UDim2.new(

            OriginalSize.X.Scale,

            OriginalSize.X.Offset
                + CLICK_GROW,

            OriginalSize.Y.Scale,

            OriginalSize.Y.Offset
                + CLICK_GROW

        )

    Button.Size =
        ExpandedSize

    task.delay(

        CLICK_TIME,

        function()

            if Button
            and Button.Parent then

                Button.Size =
                    OriginalSize

            end

        end

    )

end

--==================================================
-- COPY SYSTEM
--==================================================

function Cards:Copy(ID)

    if setclipboard then

        local Success =
            pcall(function()

                setclipboard(
                    tostring(ID)
                )

            end)

        if Success then
            return true
        end

    end

    if toclipboard then

        local Success =
            pcall(function()

                toclipboard(
                    tostring(ID)
                )

            end)

        if Success then
            return true
        end

    end

    return false

end

--==================================================
-- FAVORITE STATUS
--==================================================

function Cards:IsFavorite(ID)

    if not self.Favorites then
        return false
    end

    local Success, Result =
        pcall(function()

            return self.Favorites:IsFavorite(
                ID
            )

        end)

    if Success then

        return Result == true

    end

    return false

end

--==================================================
-- UPDATE FAVORITE BUTTON
--==================================================
-- Esta é a ÚNICA função responsável pelo
-- visual do botão de favorito.
--==================================================

function Cards:UpdateFavoriteButton(
    Button,
    ID
)

    if not Button then
        return
    end

    if not self.Theme then
        return
    end

    local Success, CurrentTheme =
        pcall(function()

            return self.Theme:GetCurrent()

        end)

    if not Success
    or not CurrentTheme then

        return

    end

    local IsFavorite =
        self:IsFavorite(ID)

    --==================================================
    -- FAVORITADO
    --==================================================

    if IsFavorite then

        Button.Text =
            "★"

        local Accent

        local AccentSuccess =
            pcall(function()

                Accent =
                    self.Theme:GetAccent()

            end)

        if AccentSuccess
        and Accent then

            Button.TextColor3 =
                Accent

        else

            Button.TextColor3 =
                CurrentTheme.Text

        end

    --==================================================
    -- NÃO FAVORITADO
    --==================================================

    else

        Button.Text =
            "☆"

        Button.TextColor3 =
            CurrentTheme.SubText
            or CurrentTheme.Text

    end

end

--==================================================
-- TOGGLE FAVORITE
--==================================================

function Cards:ToggleFavorite(
    ID,
    Button
)

    if not self.Favorites then

        warn(
            "⚠️ Rimuru Hub: módulo Favorites não encontrado."
        )

        return

    end

    if not Button then
        return
    end

    local Success, Result =
        pcall(function()

            return self.Favorites:Toggle(
                ID
            )

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao alterar favorito:",
            Result
        )

        return

    end

    --==================================================
    -- ATUALIZA VISUAL
    --==================================================

    self:UpdateFavoriteButton(
        Button,
        ID
    )

end

--==================================================
-- CREATE SOUND CARD
--==================================================

function Cards:CreateSoundCard(
    Index,
    Data
)

    if type(Data) ~= "table" then
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

    local Name =
        tostring(
            Data[1]
            or "Unknown"
        )

    local ID =
        tostring(
            Data[2]
            or ""
        )

    --==================================================
    -- CARD
    --==================================================

    local Card =
        Instance.new(
            "Frame"
        )

    Card.Name =
        "Sound_" .. tostring(Index)

    Card.Size =
        UDim2.new(
            1,
            -5,
            0,
            48
        )

    Card.BackgroundColor3 =
        CurrentTheme.Card
        or CurrentTheme.Content

    Card.BorderSizePixel =
        0

    Card.LayoutOrder =
        Index

    Card.ZIndex =
        504

    Card.Parent =
        self.Scroll

    --==================================================
    -- CARD CORNER
    --==================================================

    local CardCorner =
        Instance.new(
            "UICorner"
        )

    CardCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    CardCorner.Parent =
        Card

    --==================================================
    -- NAME
    --==================================================
    -- Ajustado para ficar menor e mais elegante.
    -- Não ocupa espaço excessivo no card.
    --==================================================

    local NameLabel =
        Instance.new(
            "TextLabel"
        )

    NameLabel.Name =
        "Name"

    NameLabel.Position =
        UDim2.new(
            0,
            12,
            0,
            6
        )

    NameLabel.Size =
        UDim2.new(
            1,
            -130,
            0,
            16
        )

    NameLabel.BackgroundTransparency =
        1

    NameLabel.Text =
        Name

    NameLabel.TextColor3 =
        CurrentTheme.Text

    NameLabel.TextSize =
        11

    NameLabel.Font =
        Enum.Font.GothamMedium

    NameLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    NameLabel.TextYAlignment =
        Enum.TextYAlignment.Center

    NameLabel.TextTruncate =
        Enum.TextTruncate.AtEnd

    NameLabel.ZIndex =
        505

    NameLabel.Parent =
        Card

    --==================================================
    -- ID
    --==================================================

    local IDLabel =
        Instance.new(
            "TextLabel"
        )

    IDLabel.Name =
        "ID"

    IDLabel.Position =
        UDim2.new(
            0,
            12,
            0,
            24
        )

    IDLabel.Size =
        UDim2.new(
            1,
            -130,
            0,
            14
        )

    IDLabel.BackgroundTransparency =
        1

    IDLabel.Text =
        ID

    IDLabel.TextColor3 =
        CurrentTheme.SubText
        or CurrentTheme.Text

    IDLabel.TextSize =
        9

    IDLabel.Font =
        Enum.Font.Code

    IDLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    IDLabel.TextYAlignment =
        Enum.TextYAlignment.Center

    IDLabel.ZIndex =
        505

    IDLabel.Parent =
        Card

    --==================================================
    -- FAVORITE BUTTON
    --==================================================

    local FavoriteButton =
        Instance.new(
            "TextButton"
        )

    FavoriteButton.Name =
        "Favorite"

    FavoriteButton.Size =
        UDim2.new(
            0,
            28,
            0,
            28
        )

    FavoriteButton.Position =
        UDim2.new(
            1,
            -98,
            0.5,
            -14
        )

    FavoriteButton.BackgroundColor3 =
        CurrentTheme.Button
        or CurrentTheme.Card

    FavoriteButton.BorderSizePixel =
        0

    FavoriteButton.TextSize =
        18

    FavoriteButton.Font =
        Enum.Font.GothamBold

    FavoriteButton.AutoButtonColor =
        false

    FavoriteButton.ZIndex =
        506

    FavoriteButton.Parent =
        Card

    --==================================================
    -- FAVORITE CORNER
    --==================================================

    local FavoriteCorner =
        Instance.new(
            "UICorner"
        )

    FavoriteCorner.CornerRadius =
        UDim.new(
            0,
            6
        )

    FavoriteCorner.Parent =
        FavoriteButton

    --==================================================
    -- FAVORITE STATE
    --==================================================

    self:UpdateFavoriteButton(
        FavoriteButton,
        ID
    )

    --==================================================
    -- FAVORITE EVENT
    --==================================================

    FavoriteButton.MouseButton1Click:Connect(

        function()

            self:ClickAnimation(
                FavoriteButton
            )

            self:ToggleFavorite(
                ID,
                FavoriteButton
            )

        end

    )

    --==================================================
    -- COPY BUTTON
    --==================================================

    local CopyButton =
        Instance.new(
            "TextButton"
        )

    CopyButton.Name =
        "Copy"

    CopyButton.Size =
        UDim2.new(
            0,
            55,
            0,
            28
        )

    CopyButton.Position =
        UDim2.new(
            1,
            -65,
            0.5,
            -14
        )

    CopyButton.BackgroundTransparency =
        0

    CopyButton.BorderSizePixel =
        0

    CopyButton.Text =
        "Copy"

    CopyButton.TextSize =
        10

    CopyButton.Font =
        Enum.Font.GothamBold

    CopyButton.AutoButtonColor =
        false

    CopyButton.ZIndex =
        506

    CopyButton.Parent =
        Card

    --==================================================
    -- COPY STYLE
    --==================================================

    self:ApplyCopyStyle(
        CopyButton
    )

    --==================================================
    -- COPY CORNER
    --==================================================

    local CopyCorner =
        Instance.new(
            "UICorner"
        )

    CopyCorner.CornerRadius =
        UDim.new(
            0,
            6
        )

    CopyCorner.Parent =
        CopyButton

    --==================================================
    -- COPY EVENT
    --==================================================

    CopyButton.MouseButton1Click:Connect(

        function()

            self:ClickAnimation(
                CopyButton
            )

            if self:Copy(ID) then

                CopyButton.Text =
                    "Copied!"

                task.delay(

                    0.8,

                    function()

                        if CopyButton
                        and CopyButton.Parent then

                            CopyButton.Text =
                                "Copy"

                        end

                    end

                )

            else

                CopyButton.Text =
                    "N/A"

                task.delay(

                    0.8,

                    function()

                        if CopyButton
                        and CopyButton.Parent then

                            CopyButton.Text =
                                "Copy"

                        end

                    end

                )

            end

        end

    )

    return Card

end

--==================================================
-- APPLY THEME
--==================================================

function Cards:ApplyTheme()

    if not self.Scroll then
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

    for _, Card in
        ipairs(
            self.Scroll:GetChildren()
        ) do

        if Card:IsA("Frame")
        and Card.Name:sub(1, 6) ==
            "Sound_" then

            --==================================================
            -- CARD
            --==================================================

            Card.BackgroundColor3 =
                CurrentTheme.Card
                or CurrentTheme.Content

            --==================================================
            -- NAME
            --==================================================

            local NameLabel =
                Card:FindFirstChild(
                    "Name"
                )

            if NameLabel then

                NameLabel.TextColor3 =
                    CurrentTheme.Text

            end

            --==================================================
            -- ID
            --==================================================

            local IDLabel =
                Card:FindFirstChild(
                    "ID"
                )

            if IDLabel then

                IDLabel.TextColor3 =
                    CurrentTheme.SubText
                    or CurrentTheme.Text

            end

            --==================================================
            -- FAVORITE
            --==================================================

            local FavoriteButton =
                Card:FindFirstChild(
                    "Favorite"
                )

            if FavoriteButton then

                FavoriteButton.BackgroundColor3 =
                    CurrentTheme.Button
                    or CurrentTheme.Card

                local StoredID =
                    ""

                if IDLabel then

                    StoredID =
                        IDLabel.Text

                end

                self:UpdateFavoriteButton(

                    FavoriteButton,

                    StoredID

                )

            end

            --==================================================
            -- COPY
            --==================================================

            local CopyButton =
                Card:FindFirstChild(
                    "Copy"
                )

            if CopyButton then

                self:ApplyCopyStyle(
                    CopyButton
                )

            end

        end

    end

end

--==================================================
-- REFRESH CARD
--==================================================

function Cards:RefreshCard(
    Card
)

    if not Card
    or not Card.Parent then

        return

    end

    local IDLabel =
        Card:FindFirstChild(
            "ID"
        )

    local FavoriteButton =
        Card:FindFirstChild(
            "Favorite"
        )

    if IDLabel
    and FavoriteButton then

        self:UpdateFavoriteButton(

            FavoriteButton,

            IDLabel.Text

        )

    end

end

--==================================================
-- REFRESH ALL CARDS
--==================================================

function Cards:Refresh()

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        ) do

        if Object:IsA("Frame")
        and Object.Name:sub(1, 6) ==
            "Sound_" then

            self:RefreshCard(
                Object
            )

        end

    end

end

--==================================================
-- RETURN MODULE
--==================================================

return Cards

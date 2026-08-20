--// 💥 RIMURU HUB
--// Sound Cards System
--// Favorites Compatible
--// Copy + Favorite System

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
-- COPY SYSTEM
--==================================================

function Cards:Copy(ID)

    if setclipboard then

        local Success =
            pcall(function()

                setclipboard(ID)

            end)

        if Success then
            return true
        end

    end

    if toclipboard then

        local Success =
            pcall(function()

                toclipboard(ID)

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

function Cards:UpdateFavoriteButton(
    Button,
    ID
)

    if not Button then
        return
    end

    local IsFavorite =
        self:IsFavorite(ID)

    if IsFavorite then

        Button.Text =
            "★"

        Button.TextColor3 =
            self.Theme:GetAccent()

    else

        Button.Text =
            "☆"

        Button.TextColor3 =
            self.Theme:GetCurrent().SubText

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
            "⚠️ Rimuru Hub: erro ao alterar favorito."
        )

        return

    end

    if Result then

        Button.Text =
            "★"

        Button.TextColor3 =
            self.Theme:GetAccent()

    else

        Button.Text =
            "☆"

        Button.TextColor3 =
            self.Theme:GetCurrent().SubText

    end

end

--==================================================
-- CREATE SOUND CARD
--==================================================

function Cards:CreateSoundCard(
    Index,
    Data
)

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Name =
        Data[1]

    local ID =
        Data[2]

    --==================================================
    -- CARD
    --==================================================

    local Card =
        Instance.new("Frame")

    Card.Name =
        "Sound_" .. Index

    Card.Size =
        UDim2.new(
            1,
            -5,
            0,
            48
        )

    Card.BackgroundColor3 =
        CurrentTheme.Card

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
        Instance.new("UICorner")

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

    local NameLabel =
        Instance.new("TextLabel")

    NameLabel.Position =
        UDim2.new(
            0,
            12,
            0,
            5
        )

    NameLabel.Size =
        UDim2.new(
            1,
            -130,
            0,
            18
        )

    NameLabel.BackgroundTransparency =
        1

    NameLabel.Text =
        Name

    NameLabel.TextColor3 =
        CurrentTheme.Text

    NameLabel.TextSize =
        12

    NameLabel.Font =
        Enum.Font.GothamMedium

    NameLabel.TextXAlignment =
        Enum.TextXAlignment.Left

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
        Instance.new("TextLabel")

    IDLabel.Position =
        UDim2.new(
            0,
            12,
            0,
            25
        )

    IDLabel.Size =
        UDim2.new(
            1,
            -130,
            0,
            16
        )

    IDLabel.BackgroundTransparency =
        1

    IDLabel.Text =
        ID

    IDLabel.TextColor3 =
        CurrentTheme.SubText

    IDLabel.TextSize =
        10

    IDLabel.Font =
        Enum.Font.Code

    IDLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    IDLabel.ZIndex =
        505

    IDLabel.Parent =
        Card

    --==================================================
    -- FAVORITE BUTTON
    --==================================================

    local FavoriteButton =
        Instance.new("TextButton")

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
        Instance.new("UICorner")

    FavoriteCorner.CornerRadius =
        UDim.new(
            0,
            6
        )

    FavoriteCorner.Parent =
        FavoriteButton

    --==================================================
    -- INITIAL FAVORITE STATE
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
        Instance.new("TextButton")

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

    CopyButton.BackgroundColor3 =
        self.Theme:GetAccent()

    CopyButton.BorderSizePixel =
        0

    CopyButton.Text =
        "Copy"

    CopyButton.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

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
    -- COPY CORNER
    --==================================================

    local CopyCorner =
        Instance.new("UICorner")

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

            if self:Copy(ID) then

                CopyButton.Text =
                    "Copied!"

                task.delay(

                    0.8,

                    function()

                        if CopyButton.Parent then

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

                        if CopyButton.Parent then

                            CopyButton.Text =
                                "Copy"

                        end

                    end

                )

            end

        end

    )

    --==================================================
    -- RETURN
    --==================================================

    return Card

end

--==================================================
-- APPLY THEME
--==================================================

function Cards:ApplyTheme()

    if not self.Scroll then
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

            Card.BackgroundColor3 =
                CurrentTheme.Card

            local FavoriteButton =
                Card:FindFirstChild(
                    "Favorite"
                )

            if FavoriteButton then

                FavoriteButton.BackgroundColor3 =
                    CurrentTheme.Button

            end

            local NameLabel =
                Card:FindFirstChild(
                    "TextLabel"
                )

            if NameLabel then

                NameLabel.TextColor3 =
                    CurrentTheme.Text

            end

        end

    end

end

--==================================================
-- RETURN MODULE
--==================================================

return Cards

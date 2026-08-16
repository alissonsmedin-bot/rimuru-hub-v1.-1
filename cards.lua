--// 💥 RIMURU HUB
--// Sound Cards System
--// ⭐ Favorites Integration
--// 🎨 Transparent Cards + Theme Support

local Cards = {}

--==================================================
-- INIT
--==================================================

function Cards:Init(Context)

    self.Context =
        Context or {}

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

    self.Favorites =
        Context.Favorites

    self.Categories =
        Context.Categories

end

--==================================================
-- GET CARD TRANSPARENCY
--==================================================

function Cards:GetCardTransparency()

    return 0.75

end

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config
    and self.Config.UI
    and self.Config.UI.CardTransparency
    ~= nil then

        return math.clamp(
            tonumber(
                self.Config.UI.CardTransparency
            ) or 0.15,
            0,
            1
        )

    end

    --==================================================
    -- THEME
    --==================================================

    local CurrentTheme =
        self.Theme
        and self.Theme:GetCurrent()

    if CurrentTheme
    and CurrentTheme.CardTransparency
    ~= nil then

        return math.clamp(
            tonumber(
                CurrentTheme.CardTransparency
            ) or 0.15,
            0,
            1
        )

    end

    --==================================================
    -- DEFAULT
    --==================================================

    return 0.15

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
-- ⭐ FAVORITE STATUS
--==================================================

function Cards:IsFavorite(ID)

    if not self.Favorites then
        return false
    end

    local Success,
        Result =
        pcall(function()

            return self.Favorites:IsFavorite(
                tostring(ID)
            )

        end)

    if Success then
        return Result == true
    end

    return false

end

--==================================================
-- ⭐ TOGGLE FAVORITE
--==================================================

function Cards:ToggleFavorite(ID)

    if not self.Favorites then
        return false
    end

    local Success,
        Result =
        pcall(function()

            return self.Favorites:Toggle(
                tostring(ID)
            )

        end)

    if Success then
        return Result == true
    end

    return false

end

--==================================================
-- ⭐ UPDATE FAVORITE SYSTEM
--==================================================

function Cards:RefreshFavorites()

    if not self.Categories then
        return
    end

    if self.Categories.UpdateFavorites then

        pcall(function()

            self.Categories:UpdateFavorites()

        end)

    elseif self.Categories.UpdateFavoritesButton then

        pcall(function()

            self.Categories:UpdateFavoritesButton()

        end)

    end

end

--==================================================
-- ⭐ HANDLE FAVORITE CLICK
--==================================================

function Cards:HandleFavorite(
    ID,
    UpdateButton
)

    local IsFavorite =
        self:ToggleFavorite(ID)

    if UpdateButton then

        if IsFavorite then

            UpdateButton.Text =
                "⭐"

        else

            UpdateButton.Text =
                "☆"

        end

    end

    self:RefreshFavorites()

    if self.Categories then

        local CurrentCategory

        pcall(function()

            CurrentCategory =
                self.Categories:
                GetCurrentCategory()

        end)

        if CurrentCategory ==
            "Favoritos" then

            task.defer(function()

                pcall(function()

                    self.Categories:
                    ShowFavorites()

                end)

            end)

        end

    end

    return IsFavorite

end

--==================================================
-- CREATE SOUND CARD
--==================================================

function Cards:CreateSoundCard(
    Index,
    Data
)

    if not Data then
        return nil
    end

    local Name =
        tostring(
            Data[1] or
            "Unknown"
        )

    local ID =
        tostring(
            Data[2] or
            ""
        )

    local CurrentTheme =
        self.Theme:GetCurrent()

    --==================================================
    -- CARD
    --==================================================

    local Card =
        Instance.new(
            "Frame"
        )

    Card.Name =
        "Sound_" ..
        tostring(Index)

    Card.Size =
        UDim2.new(
            1,
            -5,
            0,
            48
        )

    Card.BackgroundColor3 =
        CurrentTheme.Card

    Card.BackgroundTransparency =
        self:GetCardTransparency()

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
    -- SOUND NAME
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
            5
        )

    NameLabel.Size =
        UDim2.new(
            1,
            -150,
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
    -- SOUND ID
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
            25
        )

    IDLabel.Size =
        UDim2.new(
            1,
            -150,
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

    IDLabel.TextTruncate =
        Enum.TextTruncate.AtEnd

    IDLabel.ZIndex =
        505

    IDLabel.Parent =
        Card

    --==================================================
    -- ⭐ FAVORITE BUTTON
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
            30,
            0,
            30
        )

    FavoriteButton.Position =
        UDim2.new(
            1,
            -102,
            0.5,
            -15
        )

    FavoriteButton.BackgroundTransparency =
        1

    FavoriteButton.BorderSizePixel =
        0

    FavoriteButton.AutoButtonColor =
        false

    FavoriteButton.TextSize =
        18

    FavoriteButton.Font =
        Enum.Font.GothamBold

    FavoriteButton.ZIndex =
        507

    FavoriteButton.Parent =
        Card

    --==================================================
    -- ⭐ INITIAL STATE
    --==================================================

    local function UpdateFavoriteButton()

        if self:IsFavorite(ID) then

            FavoriteButton.Text =
                "⭐"

        else

            FavoriteButton.Text =
                "☆"

        end

    end

    UpdateFavoriteButton()

    --==================================================
    -- ⭐ FAVORITE CLICK
    --==================================================

    FavoriteButton.MouseButton1Click:Connect(
        function()

            self:HandleFavorite(
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

    CopyButton.BackgroundColor3 =
        self.Theme:GetAccent()

    CopyButton.BackgroundTransparency =
        0

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
    -- COPY CLICK
    --==================================================

    CopyButton.MouseButton1Click:Connect(
        function()

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
-- REFRESH ALL FAVORITE BUTTONS
--==================================================

function Cards:RefreshFavoriteButtons()

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        ) do

        if Object:IsA("Frame") then

            local FavoriteButton =
                Object:FindFirstChild(
                    "Favorite"
                )

            local IDLabel =
                Object:FindFirstChild(
                    "ID"
                )

            if FavoriteButton
            and IDLabel then

                local ID =
                    tostring(
                        IDLabel.Text
                    )

                if self:IsFavorite(ID) then

                    FavoriteButton.Text =
                        "⭐"

                else

                    FavoriteButton.Text =
                        "☆"

                end

            end

        end

    end

end

--==================================================
-- APPLY THEME
--==================================================

function Cards:ApplyTheme()

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        ) do

        if Object:IsA("Frame") then

            Object.BackgroundColor3 =
                CurrentTheme.Card

            Object.BackgroundTransparency =
                self:GetCardTransparency()

            local NameLabel =
                Object:FindFirstChild(
                    "Name"
                )

            local IDLabel =
                Object:FindFirstChild(
                    "ID"
                )

            local CopyButton =
                Object:FindFirstChild(
                    "Copy"
                )

            if NameLabel then

                NameLabel.TextColor3 =
                    CurrentTheme.Text

            end

            if IDLabel then

                IDLabel.TextColor3 =
                    CurrentTheme.SubText

            end

            if CopyButton then

                CopyButton.BackgroundColor3 =
                    self.Theme:GetAccent()

            end

        end

    end

    self:RefreshFavoriteButtons()

end

--==================================================
-- EXPORT
--==================================================

return Cards

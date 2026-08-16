--// 💥 RIMURU HUB
--// Sound Cards System
--// ⭐ Favorites Integration
--// 🎨 Transparent Cards + Theme Support
--// CLEAN REWORK
--// Card Transparency: 0.75
--// Compatible with Remote Main + Config + Theme + UI + Favorites

local Cards = {}

--==================================================
-- INIT
--==================================================

function Cards:Init(Context)

    self.Context =
        Context or {}

    --==================================================
    -- CONFIG
    --==================================================

    self.Config =
        self.Context.Config

    --==================================================
    -- SOUND
    -- Accepts Sound or Sounds
    --==================================================

    self.Sounds =
        self.Context.Sound
        or self.Context.Sounds

    --==================================================
    -- THEME
    --==================================================

    self.Theme =
        self.Context.Theme

    --==================================================
    -- UI
    --==================================================

    self.UI =
        self.Context.UI

    self.Scroll =
        nil

    if self.UI then

        self.Scroll =
            self.UI.Scroll

        -- Compatibility with UI:GetScroll()

        if not self.Scroll
        and type(
            self.UI.GetScroll
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return self.UI:
                            GetScroll()

                    end
                )

            if Success then

                self.Scroll =
                    Result

            end

        end

    end

    --==================================================
    -- FAVORITES
    --==================================================

    self.Favorites =
        self.Context.Favorites

    --==================================================
    -- CATEGORIES
    --==================================================

    self.Categories =
        self.Context.Categories

end

--==================================================
-- GET CARD TRANSPARENCY
--==================================================

function Cards:GetCardTransparency()

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config
    and self.Config.UI
    and self.Config.UI.CardTransparency
    ~= nil
    then

        local Value =
            tonumber(
                self.Config.UI.CardTransparency
            )

        if Value then

            return math.clamp(
                Value,
                0,
                1
            )

        end

    end

    --==================================================
    -- THEME
    --==================================================

    if self.Theme
    and type(
        self.Theme.GetCurrent
    ) == "function"
    then

        local Success,
            CurrentTheme =
            pcall(
                function()

                    return self.Theme:
                        GetCurrent()

                end
            )

        if Success
        and type(CurrentTheme) == "table"
        and CurrentTheme.CardTransparency
        ~= nil
        then

            local Value =
                tonumber(
                    CurrentTheme.CardTransparency
                )

            if Value then

                return math.clamp(
                    Value,
                    0,
                    1
                )

            end

        end

    end

    --==================================================
    -- DEFAULT
    --==================================================

    return 0.75

end

--==================================================
-- COPY SYSTEM
--==================================================

function Cards:Copy(ID)

    ID =
        tostring(
            ID or ""
        )

    if setclipboard then

        local Success =
            pcall(
                function()

                    setclipboard(
                        ID
                    )

                end
            )

        if Success then
            return true
        end

    end

    if toclipboard then

        local Success =
            pcall(
                function()

                    toclipboard(
                        ID
                    )

                end
            )

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

    if type(
        self.Favorites.IsFavorite
    ) ~= "function"
    then

        return false

    end

    local Success,
        Result =
        pcall(
            function()

                return self.Favorites:
                    IsFavorite(
                        tostring(ID)
                    )

            end
        )

    if Success then

        return Result == true

    end

    return false

end

--==================================================
-- TOGGLE FAVORITE
--==================================================

function Cards:ToggleFavorite(ID)

    if not self.Favorites then
        return false
    end

    if type(
        self.Favorites.Toggle
    ) ~= "function"
    then

        return false

    end

    local Success,
        Result =
        pcall(
            function()

                return self.Favorites:
                    Toggle(
                        tostring(ID)
                    )

            end
        )

    if Success then

        return Result == true

    end

    return false

end

--==================================================
-- UPDATE FAVORITES
--==================================================

function Cards:RefreshFavorites()

    if not self.Categories then
        return
    end

    if type(
        self.Categories.UpdateFavorites
    ) == "function"
    then

        pcall(
            function()

                self.Categories:
                    UpdateFavorites()

            end
        )

    elseif type(
        self.Categories.UpdateFavoritesButton
    ) == "function"
    then

        pcall(
            function()

                self.Categories:
                    UpdateFavoritesButton()

            end
        )

    end

end

--==================================================
-- HANDLE FAVORITE
--==================================================

function Cards:HandleFavorite(
    ID,
    UpdateButton
)

    local IsFavorite =
        self:ToggleFavorite(
            ID
        )

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

    --==================================================
    -- FAVORITES CATEGORY
    --==================================================

    if self.Categories then

        local CurrentCategory =
            nil

        if type(
            self.Categories.GetCurrentCategory
        ) == "function"
        then

            pcall(
                function()

                    CurrentCategory =
                        self.Categories:
                        GetCurrentCategory()

                end
            )

        end

        if CurrentCategory ==
            "Favoritos"
        then

            if type(
                self.Categories.ShowFavorites
            ) == "function"
            then

                task.defer(
                    function()

                        pcall(
                            function()

                                self.Categories:
                                ShowFavorites()

                            end
                        )

                    end
                )

            end

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

    if not self.Scroll then

        warn(
            "[Rimuru Hub] Cards: Scroll não encontrado."
        )

        return nil

    end

    --==================================================
    -- DATA
    --==================================================

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
    -- THEME
    --==================================================

    local CurrentTheme = {}

    if self.Theme
    and type(
        self.Theme.GetCurrent
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Theme:
                        GetCurrent()

                end
            )

        if Success
        and type(Result) == "table"
        then

            CurrentTheme =
                Result

        end

    end

    local CardColor =
        CurrentTheme.Card
        or Color3.fromRGB(
            28,
            32,
            40
        )

    local TextColor =
        CurrentTheme.Text
        or Color3.fromRGB(
            240,
            245,
            255
        )

    local SubTextColor =
        CurrentTheme.SubText
        or Color3.fromRGB(
            160,
            170,
            185
        )

    local AccentColor =
        Color3.fromRGB(
            80,
            170,
            255
        )

    if self.Theme
    and type(
        self.Theme.GetAccent
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Theme:
                        GetAccent()

                end
            )

        if Success
        and typeof(Result) == "Color3"
        then

            AccentColor =
                Result

        end

    end

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
        CardColor

    -- ⭐ DEFAULT = 0.75

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
        TextColor

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
        SubTextColor

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
    -- INITIAL FAVORITE
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
    -- FAVORITE CLICK
    --==================================================

    FavoriteButton.MouseButton1Click:
        Connect(
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
        AccentColor

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

    CopyButton.MouseButton1Click:
        Connect(
            function()

                if self:Copy(ID) then

                    CopyButton.Text =
                        "Copied!"

                else

                    CopyButton.Text =
                        "N/A"

                end

                task.delay(
                    0.8,
                    function()

                        if CopyButton
                        and CopyButton.Parent
                        then

                            CopyButton.Text =
                                "Copy"

                        end

                    end
                )

            end
        )

    return Card

end

--==================================================
-- REFRESH FAVORITE BUTTONS
--==================================================

function Cards:RefreshFavoriteButtons()

    if not self.Scroll then
        return
    end

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

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
            and IDLabel
            then

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

    if not self.Scroll then
        return
    end

    local CurrentTheme = {}

    if self.Theme
    and type(
        self.Theme.GetCurrent
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Theme:
                        GetCurrent()

                end
            )

        if Success
        and type(Result) == "table"
        then

            CurrentTheme =
                Result

        end

    end

    local CardColor =
        CurrentTheme.Card
        or Color3.fromRGB(
            28,
            32,
            40
        )

    local TextColor =
        CurrentTheme.Text
        or Color3.fromRGB(
            240,
            245,
            255
        )

    local SubTextColor =
        CurrentTheme.SubText
        or Color3.fromRGB(
            160,
            170,
            185
        )

    local AccentColor =
        Color3.fromRGB(
            80,
            170,
            255
        )

    if self.Theme
    and type(
        self.Theme.GetAccent
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Theme:
                        GetAccent()

                end
            )

        if Success
        and typeof(Result) == "Color3"
        then

            AccentColor =
                Result

        end

    end

    --==================================================
    -- APPLY TO CARDS
    --==================================================

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame") then

            Object.BackgroundColor3 =
           
            Object.BackgroundColor3 =
                CardColor

            Object.BackgroundTransparency =
                self:GetCardTransparency()

            local NameLabel =
                Object:FindFirstChild(
                    "Name"
                )

            if NameLabel
            and NameLabel:IsA("TextLabel")
            then

                NameLabel.TextColor3 =
                    TextColor

            end

            local IDLabel =
                Object:FindFirstChild(
                    "ID"
                )

            if IDLabel
            and IDLabel:IsA("TextLabel")
            then

                IDLabel.TextColor3 =
                    SubTextColor

            end

            local CopyButton =
                Object:FindFirstChild(
                    "Copy"
                )

            if CopyButton
            and CopyButton:IsA("TextButton")
            then

                CopyButton.BackgroundColor3 =
                    AccentColor

            end

        end

    end

end

--==================================================
-- REFRESH CARDS
--==================================================

function Cards:Refresh()

    if not self.Scroll then

        warn(
            "[Rimuru Hub] Cards: Scroll não encontrado."
        )

        return false

    end

    --==================================================
    -- REMOVE OLD CARDS
    --==================================================

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match("^Sound_")
        then

            Object:Destroy()

        end

    end

    --==================================================
    -- CHECK SOUNDS
    --==================================================

    if not self.Sounds then

        warn(
            "[Rimuru Hub] Cards: Sound não carregado."
        )

        return false

    end

    --==================================================
    -- FIND SOUND DATA
    --==================================================

    local Data = nil

    if type(
        self.Sounds.GetCurrentSounds
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Sounds:
                        GetCurrentSounds()

                end
            )

        if Success
        and type(Result) == "table"
        then

            Data =
                Result

        end

    end
        if Success
        and type(Result) == "table"
        then

            Data =
                Result

        end

    end

    if not Data
    and type(
        self.Sounds.Sounds
    ) == "table"
    then

        Data =
            self.Sounds.Sounds

    end

    --==================================================
    -- NO DATA
    --==================================================

    if type(Data) ~= "table" then

        warn(
            "[Rimuru Hub] Cards: Nenhum dado de som encontrado."
        )

        return false

    end

    --==================================================
    -- CREATE CARDS
    --==================================================

    local Index =
        0

    for _, SoundData in
        ipairs(Data)
    do

        if type(SoundData) == "table" then

            Index +=
                1

            self:CreateSoundCard(
                Index,
                SoundData
            )

        end

    end

    --==================================================
    -- APPLY THEME
    --==================================================

    self:ApplyTheme()

    --==================================================
    -- UPDATE FAVORITES
    --==================================================

    self:RefreshFavoriteButtons()

    return true

end

--==================================================
-- CREATE CARDS FROM DATA
--==================================================

function Cards:CreateCards(
    Data
)

    if type(Data) ~= "table" then

        return false

    end

    if not self.Scroll then

        warn(
            "[Rimuru Hub] Cards: Scroll não encontrado."
        )

        return false

    end

    --==================================================
    -- REMOVE EXISTING CARDS
    --==================================================

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match("^Sound_")
        then

            Object:Destroy()

        end

    end

    --==================================================
    -- CREATE
    --==================================================

    local Index =
        0

    for _, SoundData in
        ipairs(Data)
    do

        if type(SoundData) == "table" then

            Index +=
                1

            self:CreateSoundCard(
                Index,
                SoundData
            )

        end

    end

    --==================================================
    -- THEME
    --==================================================

    self:ApplyTheme()

    --==================================================
    -- FAVORITES
    --==================================================

    self:RefreshFavoriteButtons()

    return true

end

--==================================================
-- ADD CARD
--==================================================

function Cards:Add(
    Name,
    ID
)

    if not self.Scroll then

        return nil

    end

    local Index =
        1

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match("^Sound_")
        then

            Index +=
                1

        end

    end

    return self:CreateSoundCard(
        Index,
        {
            tostring(Name or "Unknown"),
            tostring(ID or ""),
        }
    )

end

--==================================================
-- REMOVE CARD
--==================================================

function Cards:Remove(
    ID
)

    if not self.Scroll then
        return false
    end

    ID =
        tostring(
            ID or ""
        )

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame") then

            local IDLabel =
                Object:FindFirstChild(
                    "ID"
                )

            if IDLabel
            and tostring(IDLabel.Text)
                == ID
            then

                Object:Destroy()

                return true

            end

        end

    end

    return false

end

--==================================================
-- FIND CARD
--==================================================

function Cards:FindCard(
    ID
)

    if not self.Scroll then
        return nil
    end

    ID =
        tostring(
            ID or ""
        )

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame") then

            local IDLabel =
                Object:FindFirstChild(
                    "ID"
                )

            if IDLabel
            and tostring(IDLabel.Text)
                == ID
            then

                return Object

            end

        end

    end

    return nil

end

--==================================================
-- GET CARDS
--==================================================

function Cards:GetCards()

    local Result =
        {}

    if not self.Scroll then
        return Result
    end

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match("^Sound_")
        then

            table.insert(
                Result,
                Object
            )

        end

    end

    return Result

end

--==================================================
-- GET CARD COUNT
--==================================================

function Cards:GetCardCount()

    if not self.Scroll then
        return 0
    end

    local Count =
        0

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match("^Sound_")
        then

            Count +=
                1

        end

    end

    return Count

end

--==================================================
-- SET CARD TRANSPARENCY
--==================================================

function Cards:SetCardTransparency(
    Value
)

    Value =
        tonumber(Value)

    if not Value then
        return false
    end

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    --==================================================
    -- SAVE TO CONFIG
    --==================================================

    if self.Config then

        if self.Config.UI
        and type(
            self.Config.UI
        ) == "table"
        then

            self.Config.UI.CardTransparency =
                Value

        end

        if type(
            self.Config.Set
        ) == "function"
        then

            pcall(
                function()

                    self.Config:Set(
                        "UI",
                        "CardTransparency",
                        Value
                    )

                end
            )

        end

    end

    --==================================================
    -- APPLY
    --==================================================

    if self.Scroll then

        for _, Object in
            ipairs(
                self.Scroll:GetChildren()
            )
        do

            if Object:IsA("Frame")
            and Object.Name:match("^Sound_")
            then

                Object.BackgroundTransparency =
                    Value

            end

        end

    end

    return true

end

--==================================================
-- GET SCROLL
--==================================================

function Cards:GetScroll()

    return self.Scroll

end

--==================================================
-- GET FAVORITES
--==================================================

function Cards:GetFavorites()

    if not self.Favorites then
        return {}
    end

    if type(
        self.Favorites.GetFavorites
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Favorites:
                        GetFavorites()

                end
            )

        if Success
        and type(Result) == "table"
        then

            return Result

        end

    end

    return {}

end

--==================================================
-- INITIAL TRANSPARENCY
--==================================================

function Cards:ApplyTransparency()

    if not self.Scroll then
        return
    end

    local Transparency =
        self:GetCardTransparency()

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match("^Sound_")
        then

            Object.BackgroundTransparency =
                Transparency

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Cards

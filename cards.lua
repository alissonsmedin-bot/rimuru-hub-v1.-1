--// 💥 RIMURU HUB
--// Sound Cards System
--// ⭐ Favorites Integration
--// 🎨 Transparent Cards
--// 🎨 Theme Support
--// 🛡️ SAFE REWORK
--// Card Transparency: 0.75
--// Compatible with Remote Main
--// Config + Theme + UI + Favorites + Sound

local Cards = {}

--==================================================
-- DEFAULTS
--==================================================

local DEFAULT_CARD_TRANSPARENCY = 0.75

local DEFAULT_CARD_COLOR =
    Color3.fromRGB(
        28,
        32,
        40
    )

local DEFAULT_TEXT_COLOR =
    Color3.fromRGB(
        240,
        245,
        255
    )

local DEFAULT_SUBTEXT_COLOR =
    Color3.fromRGB(
        160,
        170,
        185
    )

local DEFAULT_ACCENT_COLOR =
    Color3.fromRGB(
        80,
        170,
        255
    )

--==================================================
-- SAFE CALL
--==================================================

local function SafeCall(
    Function,
    ...
)

    if type(Function) ~= "function" then
        return false, nil
    end

    local Success,
        Result =
        pcall(
            Function,
            ...
        )

    return Success,
        Result

end

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
    --==================================================

    self.Sound =
        self.Context.Sound

    self.Sounds =
        self.Context.Sounds

    if not self.Sound then

        self.Sound =
            self.Sounds

    end

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

    --==================================================
    -- SCROLL
    --==================================================

    self.Scroll =
        nil

    self:_FindScroll()

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
-- FIND SCROLL
--==================================================

function Cards:_FindScroll()

    self.Scroll =
        nil

    if not self.UI then
        return nil
    end

    --==================================================
    -- DIRECT
    --==================================================

    if self.UI.Scroll
    and typeof(self.UI.Scroll) == "Instance"
    then

        self.Scroll =
            self.UI.Scroll

        return self.Scroll

    end

    --==================================================
    -- GET SCROLL
    --==================================================

    if type(
        self.UI.GetScroll
    ) == "function"
    then

        local Success,
            Result =
            SafeCall(
                function()

                    return self.UI:
                        GetScroll()

                end
            )

        if Success
        and typeof(Result) == "Instance"
        then

            self.Scroll =
                Result

            return self.Scroll

        end

    end

    --==================================================
    -- COMMON UI NAMES
    --==================================================

    local PossibleNames = {

        "Scroll",
        "ScrollingFrame",
        "SoundList",
        "Items",
        "Content",
        "Results",

    }

    for _, Name in
        ipairs(
            PossibleNames
        )
    do

        local Object =
            self.UI[Name]

        if typeof(Object) == "Instance" then

            self.Scroll =
                Object

            return self.Scroll

        end

    end

    return nil

end

--==================================================
-- GET SCROLL
--==================================================

function Cards:GetScroll()

    if self.Scroll
    and self.Scroll.Parent
    then

        return self.Scroll

    end

    return self:_FindScroll()

end

--==================================================
-- GET CARD TRANSPARENCY
--==================================================

function Cards:GetCardTransparency()

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config then

        -- Direct UI table

        if self.Config.UI
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

        -- Config getter

        if type(
            self.Config.GetCardTransparency
        ) == "function"
        then

            local Success,
                Value =
                SafeCall(
                    function()

                        return self.Config:
                            GetCardTransparency()

                    end
                )

            if Success
            and type(Value) == "number"
            then

                return math.clamp(
                    Value,
                    0,
                    1
                )

            end

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
            SafeCall(
                function()

                    return self.Theme:
                        GetCurrent()

                end
            )

        if Success
        and type(CurrentTheme) == "table"
        then

            if CurrentTheme.CardTransparency
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

    end

    --==================================================
    -- DEFAULT
    --==================================================

    return DEFAULT_CARD_TRANSPARENCY

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
    -- CONFIG
    --==================================================

    if self.Config then

        if self.Config.UI then

            self.Config.UI.CardTransparency =
                Value

        end

        if type(
            self.Config.SetCardTransparency
        ) == "function"
        then

            SafeCall(
                function()

                    self.Config:
                        SetCardTransparency(
                            Value
                        )

                end
            )

        end

    end

    --==================================================
    -- APPLY
    --==================================================

    self:ApplyTransparency(
        Value
    )

    return true

end

--==================================================
-- APPLY TRANSPARENCY
--==================================================

function Cards:ApplyTransparency(
    Value
)

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return false
    end

    Value =
        tonumber(Value)
        or self:GetCardTransparency()

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match(
            "^Sound_"
        )
        then

            Object.BackgroundTransparency =
                Value

        end

    end

    return true

end

--==================================================
-- COPY
--==================================================

function Cards:Copy(ID)

    ID =
        tostring(
            ID or ""
        )

    if ID == "" then
        return false
    end

    --==================================================
    -- SETCLIPBOARD
    --==================================================

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

    --==================================================
    -- TOCLIPBOARD
    --==================================================

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
        SafeCall(
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
        SafeCall(
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
-- REFRESH FAVORITES
--==================================================

function Cards:RefreshFavorites()

    if not self.Categories then
        return
    end

    if type(
        self.Categories.UpdateFavorites
    ) == "function"
    then

        SafeCall(
            function()

                self.Categories:
                    UpdateFavorites()

            end
        )

        return

    end

    if type(
        self.Categories.UpdateFavoritesButton
    ) == "function"
    then

        SafeCall(
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
    Button
)

    local Result =
        self:ToggleFavorite(
            ID
        )

    if Button
    and Button.Parent
    then

        if Result then

            Button.Text =
                "⭐"

        else

            Button.Text =
                "☆"

        end

    end

    self:RefreshFavorites()

    return Result

end

--==================================================
-- GET THEME
--==================================================

function Cards:GetTheme()

    if not self.Theme then
        return {}
    end

    if type(
        self.Theme.GetCurrent
    ) ~= "function"
    then

        return {}

    end

    local Success,
        Result =
        SafeCall(
            function()

                return self.Theme:
                    GetCurrent()

            end
        )

    if Success
    and type(Result) == "table"
    then

        return Result

    end

    return {}

end

--==================================================
-- GET ACCENT
--==================================================

function Cards:GetAccent()

    if self.Theme
    and type(
        self.Theme.GetAccent
    ) == "function"
    then

        local Success,
            Result =
            SafeCall(
                function()

                    return self.Theme:
                        GetAccent()

                end
            )

        if Success
        and typeof(Result) == "Color3"
        then

            return Result

        end

    end

    return DEFAULT_ACCENT_COLOR

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

    local Scroll =
        self:GetScroll()

    if not Scroll then

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
            or Data.Name
            or "Unknown"
        )

    local ID =
        tostring(
            Data[2]
            or Data.ID
            or Data.Id
            or ""
        )

    --==================================================
    -- THEME
    --==================================================

    local CurrentTheme =
        self:GetTheme()

    local CardColor =
        CurrentTheme.Card
        or DEFAULT_CARD_COLOR

    local TextColor =
        CurrentTheme.Text
        or DEFAULT_TEXT_COLOR

    local SubTextColor =
        CurrentTheme.SubText
        or DEFAULT_SUBTEXT_COLOR

    local AccentColor =
        self:GetAccent()

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

    Card.BackgroundTransparency =
        self:GetCardTransparency()

    Card.BorderSizePixel =
        0

    Card.LayoutOrder =
        tonumber(Index)
        or 0

    Card.ZIndex =
        504

    Card.Parent =
        Scroll

    --==================================================
    -- CORNER
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
    -- FAVORITE TEXT
    --==================================================

    local function UpdateFavorite()

        if not FavoriteButton
        or not FavoriteButton.Parent
        then

            return

        end

        if self:IsFavorite(ID) then

            FavoriteButton.Text =
                "⭐"

        else

            FavoriteButton.Text =
                "☆"

        end

    end

    UpdateFavorite()

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
-- CLEAR CARDS
--==================================================

function Cards:Clear()

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return false
    end

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match(
            "^Sound_"
        )
        then

            Object:Destroy()

        end

    end

    return true

end

--==================================================
-- CREATE ALL CARDS
--==================================================

function Cards:CreateCards(Data)

    if type(Data) ~= "table" then
        return false
    end

    local Scroll =
        self:GetScroll()

    if not Scroll then

        warn(
            "[Rimuru Hub] Cards: Scroll não encontrado."
        )

        return false

    end

    --==================================================
    -- CLEAR OLD
    --==================================================

    self:Clear()

    --==================================================
    -- CREATE
    --==================================================

    local Created =
        0

    for Index, SoundData in
        ipairs(Data)
    do

        local Success,
            Card =
            SafeCall(
                function()

                    return self:
                        CreateSoundCard(
                            Index,
                            SoundData
                        )

                end
            )

        if Success
        and Card
        then

            Created +=
                1

        end

    end

    --==================================================
    -- LAYOUT
    --==================================================

    self:UpdateCanvas()

    return Created > 0

end

--==================================================
-- UPDATE CANVAS
--==================================================

function Cards:UpdateCanvas()

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return false
    end

    local Layout =
        Scroll:FindFirstChildOfClass(
            "UIListLayout"
        )

    if not Layout then
        return true
    end

    task.defer(
        function()

            if Layout
            and Layout.Parent
            then

                Scroll.CanvasSize =
                    UDim2.new(
                        0,
                        0,
                        0,
                        Layout.AbsoluteContentSize.Y
                    )

            end

        end
    )

    return true

end

--==================================================
-- REFRESH FAVORITE BUTTONS
--==================================================

function Cards:RefreshFavoriteButtons()

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return false
    end

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match(
            "^Sound_"
        )
        then

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
                        or ""
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

    return true

end

--==================================================
-- APPLY THEME
--==================================================

function Cards:ApplyTheme()

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return false
    end

    local CurrentTheme =
        self:GetTheme()

    local CardColor =
        CurrentTheme.Card
        or DEFAULT_CARD_COLOR

    local TextColor =
        CurrentTheme.Text
        or DEFAULT_TEXT_COLOR

    local SubTextColor =
        CurrentTheme.SubText
        or DEFAULT_SUBTEXT_COLOR

    local AccentColor =
        self:GetAccent()

    local Transparency =
        self:GetCardTransparency()

    --==================================================
    -- APPLY
    --==================================================

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match(
            "^Sound_"
        )
        then

            Object.BackgroundColor3 =
                CardColor

            Object.BackgroundTransparency =
                Transparency

            local NameLabel =
                Object:FindFirstChild(
                    "Name"
                )

            if NameLabel
            and NameLabel:IsA(
                "TextLabel"
            )
            then

                NameLabel.TextColor3 =
                    TextColor

            end

            local IDLabel =
                Object:FindFirstChild(
                    "ID"
                )

            if IDLabel
            and IDLabel:IsA(
                "TextLabel"
            )
            then

                IDLabel.TextColor3 =
                    SubTextColor

            end

            local CopyButton =
                Object:FindFirstChild(
                    "Copy"
                )

            if CopyButton
            and CopyButton:IsA(
                "TextButton"
            )
            then

                CopyButton.BackgroundColor3 =
                    AccentColor

            end

        end

    end

    return true

end

--==================================================
-- REFRESH
--==================================================

function Cards:Refresh(Data)

    if type(Data) == "table" then

        return self:CreateCards(
            Data
        )

    end

    self:ApplyTheme()

    self:RefreshFavoriteButtons()

    self:UpdateCanvas()

    return true

end

--==================================================
-- GET CARDS
--==================================================

function Cards:GetCards()

    local Result =
        {}

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return Result
    end

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match(
            "^Sound_"
        )
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

    local Count =
        0

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return Count
    end

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if Object:IsA("Frame")
        and Object.Name:match(
            "^Sound_"
        )
        then

            Count +=
                1

        end

    end

    return Count

end

--==================================================
-- DESTROY
--==================================================

function Cards:Destroy()

    local Scroll =
        self:GetScroll()

    if Scroll then

        self:Clear()

    end

    self.Context =
        nil

    self.Config =
        nil

    self.Sound =
        nil

    self.Sounds =
        nil

    self.Theme =
        nil

    self.UI =
        nil

    self.Scroll =
        nil

    self.Favorites =
        nil

    self.Categories =
        nil

end

--==================================================
-- RETURN
--==================================================

return Cards

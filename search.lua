--// 💥 RIMURU HUB
--// Search System
--// FILTER-AWARE SEARCH
--// CATEGORY-AWARE SEARCH
--// FAVORITE / M1 / HIT COMPATIBLE
--// FUTURE FILTER COMPATIBLE
--// CATEGORY CHANGE CLEARS SEARCH
--// SAFE SEARCH RESET
--// NO OLD QUERY RESTORE
--// CONTEXT SAFE VERSION

local Search = {}

--==================================================
-- INIT
--==================================================

function Search:Init(Context)

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

    self.Cards =
        Context.Cards

    self.Favorites =
        Context.Favorites

    self.Categories =
        Context.Categories

    self.Box =
        nil

    self.ResultLabel =
        nil

    self.Query =
        ""

    self.Results =
        {}

    self.Active =
        false

    self.Connected =
        false

    self.SortMode =
        nil

    self.LastCategory =
        "ALL"

    --==================================================
    -- CONTEXT CHANGE LOCK
    --==================================================

    self.ContextChanging =
        false

end

--==================================================
-- THEME
--==================================================

function Search:GetTheme()

    if self.Theme
    and type(self.Theme.GetCurrent) ==
        "function" then

        local Success, Result =
            pcall(function()

                return self.Theme:GetCurrent()

            end)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    return {}

end

--==================================================
-- CREATE SEARCH
--==================================================

function Search:Create()

    if self.Box
    and self.Box.Parent then

        return self.Box

    end

    if not self.UI then
        return nil
    end

    local Header =
        self.UI.Header

    if not Header then
        return nil
    end

    --==================================================
    -- SEARCH BOX
    --==================================================

    local SearchBox =
        Instance.new(
            "TextBox"
        )

    SearchBox.Name =
        "SearchBox"

    SearchBox.Position =
        UDim2.new(
            0,
            285,
            0,
            12
        )

    SearchBox.Size =
        UDim2.new(
            0,
            210,
            0,
            34
        )

    SearchBox.BackgroundColor3 =
        self:GetTheme().Card
        or Color3.fromRGB(
            35,
            35,
            35
        )

    SearchBox.BorderSizePixel =
        0

    SearchBox.Text =
        ""

    SearchBox.PlaceholderText =
        "🔎 Pesquisar..."

    SearchBox.PlaceholderColor3 =
        self:GetTheme().SubText
        or Color3.fromRGB(
            150,
            150,
            150
        )

    SearchBox.TextColor3 =
        self:GetTheme().Text
        or Color3.fromRGB(
            255,
            255,
            255
        )

    SearchBox.TextSize =
        11

    SearchBox.Font =
        Enum.Font.Gotham

    SearchBox.TextXAlignment =
        Enum.TextXAlignment.Left

    SearchBox.ClearTextOnFocus =
        false

    SearchBox.ZIndex =
        505

    SearchBox.Parent =
        Header

    --==================================================
    -- CORNER
    --==================================================

    local Corner =
        Instance.new(
            "UICorner"
        )

    Corner.CornerRadius =
        UDim.new(
            0,
            8
        )

    Corner.Parent =
        SearchBox

    --==================================================
    -- PADDING
    --==================================================

    local Padding =
        Instance.new(
            "UIPadding"
        )

    Padding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    Padding.PaddingRight =
        UDim.new(
            0,
            12
        )

    Padding.Parent =
        SearchBox

    --==================================================
    -- RESULT COUNT
    --==================================================

    local ResultLabel =
        Instance.new(
            "TextLabel"
        )

    ResultLabel.Name =
        "SearchResultCount"

    ResultLabel.Position =
        UDim2.new(
            0,
            285,
            0,
            48
        )

    ResultLabel.Size =
        UDim2.new(
            0,
            210,
            0,
            18
        )

    ResultLabel.BackgroundTransparency =
        1

    ResultLabel.Text =
        ""

    ResultLabel.TextColor3 =
        self:GetTheme().SubText
        or Color3.fromRGB(
            150,
            150,
            150
        )

    ResultLabel.TextSize =
        10

    ResultLabel.Font =
        Enum.Font.Gotham

    ResultLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    ResultLabel.Visible =
        false

    ResultLabel.ZIndex =
        505

    ResultLabel.Parent =
        Header

    --==================================================
    -- SAVE
    --==================================================

    self.Box =
        SearchBox

    self.ResultLabel =
        ResultLabel

    return SearchBox

end

--==================================================
-- SEARCH EVENTS
--==================================================

function Search:Connect()

    if not self.Box
    or not self.Box.Parent then

        self:Create()

    end

    if not self.Box then
        return
    end

    if self.Connected then
        return
    end

    self.Connected =
        true

    self.Box:GetPropertyChangedSignal(
        "Text"
    ):Connect(function()

        --==================================================
        -- DURING CATEGORY CHANGE
        --==================================================

        if self.ContextChanging then
            return
        end

        self:Search(
            self.Box.Text
        )

    end)

end

--==================================================
-- CLEAR SCROLL
--==================================================

function Search:ClearScroll()

    if not self.UI then
        return
    end

    local Scroll =
        self.UI.Scroll

    if not Scroll then
        return
    end

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        ) do

        if not Object:IsA(
            "UIListLayout"
        )
        and not Object:IsA(
            "UIPadding"
        ) then

            Object:Destroy()

        end

    end

end

--==================================================
-- GET CURRENT SOUND POOL
--==================================================

function Search:GetCurrentSoundPool()

    --==================================================
    -- CATEGORIES
    --==================================================

    if self.Categories
    and type(
        self.Categories.GetCurrentSounds
    ) == "function" then

        local Success, Sounds =
            pcall(function()

                return self.Categories:
                    GetCurrentSounds()

            end)

        if Success
        and type(Sounds) == "table" then

            return Sounds

        end

    end

    --==================================================
    -- FALLBACK
    --==================================================

    local Result =
        {}

    if not self.Sounds then
        return Result
    end

    for _, Category in
        pairs(
            self.Sounds
        ) do

        if type(Category) ==
            "table" then

            for _, Data in
                ipairs(Category) do

                if type(Data) ==
                    "table" then

                    table.insert(
                        Result,
                        Data
                    )

                end

            end

        end

    end

    return Result

end

--==================================================
-- MATCH QUERY
--==================================================

function Search:Matches(
    SoundData,
    Query
)

    if type(SoundData) ~= "table" then
        return false
    end

    local Name =
        tostring(
            SoundData[1]
            or ""
        )

    local ID =
        tostring(
            SoundData[2]
            or ""
        )

    local LowerName =
        string.lower(
            Name
        )

    local LowerID =
        string.lower(
            ID
        )

    local LowerQuery =
        string.lower(
            tostring(
                Query
                or ""
            )
        )

    if LowerQuery == "" then
        return false
    end

    --==================================================
    -- NAME
    --==================================================

    if string.find(
        LowerName,
        LowerQuery,
        1,
        true
    ) then

        return true

    end

    --==================================================
    -- ID
    --==================================================

    if string.find(
        LowerID,
        LowerQuery,
        1,
        true
    ) then

        return true

    end

    return false

end

--==================================================
-- COLLECT
--==================================================

function Search:Collect(
    Query
)

    local Results =
        {}

    Query =
        string.lower(
            tostring(
                Query
                or ""
            )
        )

    if Query == "" then
        return Results
    end

    --==================================================
    -- CURRENT CONTEXT
    --==================================================

    local CurrentPool =
        self:GetCurrentSoundPool()

    --==================================================
    -- SEARCH CURRENT POOL ONLY
    --==================================================

    for Index, Data in
        ipairs(
            CurrentPool
        ) do

        if type(Data) ==
            "table"
        and self:Matches(
            Data,
            Query
        ) then

            local CurrentCategory =
                "ALL"

            if self.Categories
            and type(
                self.Categories.GetCurrentCategory
            ) == "function" then

                local Success, Category =
                    pcall(function()

                        return self.Categories:
                            GetCurrentCategory()

                    end)

                if Success
                and Category then

                    CurrentCategory =
                        Category

                end

            end

            table.insert(
                Results,
                {

                    Name =
                        tostring(
                            Data[1]
                            or ""
                        ),

                    ID =
                        tostring(
                            Data[2]
                            or ""
                        ),

                    Category =
                        CurrentCategory,

                    Index =
                        Index,

                    Data =
                        Data

                }
            )

        end

    end

    return Results

end

--==================================================
-- SORT
--==================================================

function Search:Sort(
    Results
)

    if type(Results) ~= "table" then
        return
    end

    if self.SortMode ==
        "A-Z" then

        table.sort(
            Results,
            function(A, B)

                return string.lower(
                    A.Name
                )
                <
                string.lower(
                    B.Name
                )

            end
        )

    elseif self.SortMode ==
        "Z-A" then

        table.sort(
            Results,
            function(A, B)

                return string.lower(
                    A.Name
                )
                >
                string.lower(
                    B.Name
                )

            end
        )

    end

end

--==================================================
-- CREATE RESULT
--==================================================

function Search:CreateResult(
    Index,
    Result
)

    if not self.Cards then
        return
    end

    if type(
        self.Cards.CreateSoundCard
    ) ~= "function" then

        return

    end

    local Data =
        Result.Data

    if type(Data) ==
        "table" then

        self.Cards:CreateSoundCard(
            Index,
            Data
        )

        return

    end

    self.Cards:CreateSoundCard(
        Index,
        {
            Result.Name,
            Result.ID
        }
    )

end

--==================================================
-- NO RESULTS
--==================================================

function Search:ShowNoResults(
    Query
)

    if not self.UI then
        return
    end

    local Scroll =
        self.UI.Scroll

    if not Scroll then
        return
    end

    local Label =
        Instance.new(
            "TextLabel"
        )

    Label.Name =
        "NoResults"

    Label.Size =
        UDim2.new(
            1,
            -5,
            0,
            50
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        'Nenhum resultado para "' ..
        tostring(Query) ..
        '"'

    Label.TextColor3 =
        self:GetTheme().SubText
        or Color3.fromRGB(
            150,
            150,
            150
        )

    Label.TextSize =
        12

    Label.Font =
        Enum.Font.GothamMedium

    Label.ZIndex =
        504

    Label.Parent =
        Scroll

end

--==================================================
-- SEARCH
--==================================================

function Search:Search(
    Query
)

    Query =
        tostring(
            Query
            or ""
        )

    self.Query =
        Query

    --==================================================
    -- EMPTY SEARCH
    --==================================================

    if Query == "" then

        self.Active =
            false

        self.Results =
            {}

        if self.ResultLabel then

            self.ResultLabel.Visible =
                false

            self.ResultLabel.Text =
                ""

        end

        self:ClearScroll()

        --==================================================
        -- IMPORTANT:
        -- NÃO chama RefreshCurrent aqui.
        --
        -- O Categories já controla o conteúdo.
        -- Isso impede que apagar uma pesquisa
        -- faça o sistema voltar para ALL.
        --==================================================

        return

    end

    --==================================================
    -- ACTIVE
    --==================================================

    self.Active =
        true

    --==================================================
    -- CLEAR OLD RESULTS
    --==================================================

    self:ClearScroll()

    --==================================================
    -- COLLECT
    --==================================================

    local Results =
        self:Collect(
            Query
        )

    self:Sort(
        Results
    )

    self.Results =
        Results

    --==================================================
    -- RESULT COUNT
    --==================================================

    if self.ResultLabel then

        self.ResultLabel.Visible =
            true

        self.ResultLabel.Text =
            tostring(
                #Results
            ) ..
            " resultado(s)"

    end

    --==================================================
    -- NO RESULTS
    --==================================================

    if #Results == 0 then

        self:ShowNoResults(
            Query
        )

        return

    end

    --==================================================
    -- CREATE RESULTS
    --==================================================

    for Index, Result in
        ipairs(
            Results
        ) do

        self:CreateResult(
            Index,
            Result
        )

    end

end

--==================================================
-- CLEAR SEARCH INTERNAL
--==================================================

function Search:ClearInternal()

    self.Query =
        ""

    self.Results =
        {}

    self.Active =
        false

    if self.ResultLabel then

        self.ResultLabel.Visible =
            false

        self.ResultLabel.Text =
            ""

    end

    self:ClearScroll()

end

--==================================================
-- CONTEXT CHANGED
--==================================================
-- Chamado pelo Categories quando:
--
-- • troca de categoria
-- • troca de filtro
-- • refresh
--
-- A pesquisa antiga NÃO deve sobreviver
-- à troca de categoria/filtro.
--==================================================

function Search:OnContextChanged()

    --==================================================
    -- CONTEXTO MUDOU:
    -- LIMPA A PESQUISA.
    --==================================================

    self.ContextChanging =
        true

    --==================================================
    -- LIMPAR TEXTBOX SEM DISPARAR
    -- UMA NOVA PESQUISA
    --==================================================

    if self.Box then

        self.Box.Text =
            ""

    end

    self:ClearInternal()

    self.ContextChanging =
        false

end

--==================================================
-- CATEGORY CHANGED
--==================================================

function Search:SetCategory(
    CategoryName
)

    if CategoryName then

        self.LastCategory =
            CategoryName

    end

    --==================================================
    -- CATEGORY CHANGE:
    -- SEMPRE LIMPA A PESQUISA.
    --==================================================

    self:OnContextChanged()

end

--==================================================
-- THEME
--==================================================

function Search:ApplyTheme()

    local CurrentTheme =
        self:GetTheme()

    if self.Box then

        if CurrentTheme.Card then

            self.Box.BackgroundColor3 =
                CurrentTheme.Card

        end

        if CurrentTheme.Text then

            self.Box.TextColor3 =
                CurrentTheme.Text

        end

        if CurrentTheme.SubText then

            self.Box.PlaceholderColor3 =
                CurrentTheme.SubText

        end

    end

    if self.ResultLabel
    and CurrentTheme.SubText then

        self.ResultLabel.TextColor3 =
            CurrentTheme.SubText

    end

end

--==================================================
-- SORT MODE
--==================================================

function Search:SetSortMode(
    Mode
)

    self.SortMode =
        Mode

    if self.Active
    and self.Query ~= "" then

        self:Search(
            self.Query
        )

    end

end

--==================================================
-- VISIBILITY
--==================================================

function Search:SetVisible(
    Value
)

    if self.Box then

        self.Box.Visible =
            Value

    end

    if self.ResultLabel then

        self.ResultLabel.Visible =
            Value
            and self.Active

    end

end

--==================================================
-- GET BOX
--==================================================

function Search:GetBox()

    return self.Box

end

--==================================================
-- GET QUERY
--==================================================

function Search:GetQuery()

    return self.Query

end

--==================================================
-- IS ACTIVE
--==================================================

function Search:IsActive()

    return self.Active

end

--==================================================
-- CLEAR SEARCH
--==================================================

function Search:Clear()

    self.ContextChanging =
        true

    if self.Box then

        self.Box.Text =
            ""

    end

    self:ClearInternal()

    self.ContextChanging =
        false

end

--==================================================
-- RETURN
--==================================================

return Search

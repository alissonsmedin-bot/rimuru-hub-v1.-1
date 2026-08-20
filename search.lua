--// 💥 RIMURU HUB
--// Search System
--// FILTER AWARE
--// CATEGORY AWARE
--// FUTURE FILTER COMPATIBLE
--// Modular Search Architecture

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

    self.Categories =
        Context.Categories

    --==================================================
    -- STATE
    --==================================================

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

    self.SortMode =
        nil

    --==================================================
    -- CATEGORY STATE
    --==================================================

    self.LastCategory =
        "ALL"

end

--==================================================
-- THEME
--==================================================

function Search:GetTheme()

    if self.Theme
    and self.Theme.GetCurrent then

        return self.Theme:GetCurrent()

    end

    return {}

end

--==================================================
-- CREATE SEARCH
--==================================================

function Search:Create()

    local Header =
        self.UI.Header

    if not Header then
        return
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

    SearchBox.BorderSizePixel =
        0

    SearchBox.Text =
        ""

    SearchBox.PlaceholderText =
        "🔎 Pesquisar..."

    SearchBox.PlaceholderColor3 =
        self:GetTheme().SubText

    SearchBox.TextColor3 =
        self:GetTheme().Text

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
            12,
            0,
            6
        )

    ResultLabel.Size =
        UDim2.new(
            1,
            -24,
            0,
            20
        )

    ResultLabel.BackgroundTransparency =
        1

    ResultLabel.Text =
        ""

    ResultLabel.TextColor3 =
        self:GetTheme().SubText

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
        self.UI.Content

    --==================================================
    -- SAVE
    --==================================================

    self.Box =
        SearchBox

    self.ResultLabel =
        ResultLabel

end

--==================================================
-- SEARCH EVENTS
--==================================================

function Search:Connect()

    if not self.Box then
        return
    end

    self.Box:GetPropertyChangedSignal(
        "Text"
    ):Connect(function()

        self:Search(
            self.Box.Text
        )

    end)

end

--==================================================
-- CLEAR SCROLL
--==================================================

function Search:ClearScroll()

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
-- GET ACTIVE CATEGORY
--==================================================

function Search:GetActiveCategory()

    --==================================================
    -- CATEGORIES SYSTEM
    --==================================================

    if self.Categories then

        --==================================================
        -- SELECTED BUTTON
        --==================================================

        local SelectedButton =
            self.Categories:GetSelectedButton()

        if SelectedButton then

            local Name =
                SelectedButton.Name

            if Name then

                return Name

            end

        end

        --==================================================
        -- FALLBACK
        --==================================================

        if self.Categories.GetCurrentCategory then

            local Category =
                self.Categories:GetCurrentCategory()

            if Category then

                return Category

            end

        end

    end

    --==================================================
    -- FALLBACK
    --==================================================

    return self.LastCategory
        or "ALL"

end

--==================================================
-- GET ACTIVE FILTER
--==================================================

function Search:GetActiveFilter()

    if not self.Categories then
        return "All"
    end

    --==================================================
    -- GENERIC FUTURE FILTER SYSTEM
    --==================================================

    if self.Categories.GetCurrentFilter then

        local Filter =
            self.Categories:GetCurrentFilter()

        if Filter then

            return Filter

        end

    end

    return "All"

end

--==================================================
-- GET FILTERED SOUNDS
--==================================================
-- IMPORTANTE:
--
-- O SEARCH NÃO PRECISA SABER QUAIS FILTROS EXISTEM.
--
-- O Categories é responsável por isso.
--
-- Assim, no futuro:
--
-- M1
-- Hit
-- Dash
-- Grab
-- Block
-- Ultimate
-- etc.
--
-- basta o Categories fornecer os sons daquele filtro.
-- O Search continuará funcionando sozinho.
--==================================================

function Search:GetSoundsFromCurrentFilter()

    if not self.Categories then
        return nil
    end

    --==================================================
    -- NOVO SISTEMA GENÉRICO
    --==================================================

    if self.Categories.GetFilteredSounds then

        local Success, Result =
            pcall(function()

                return self.Categories:GetFilteredSounds()

            end)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    --==================================================
    -- COMPATIBILIDADE COM VERSÃO ATUAL
    --==================================================

    local Filter =
        self:GetActiveFilter()

    if Filter == "Favorite" then

        if self.Categories.GetFavoriteSounds then

            return self.Categories:GetFavoriteSounds()

        end

    elseif Filter == "M1" then

        if self.Categories.GetM1Sounds then

            return self.Categories:GetM1Sounds()

        end

    elseif Filter == "Hit" then

        if self.Categories.GetHitSounds then

            return self.Categories:GetHitSounds()

        end

    end

    --==================================================
    -- ALL
    --==================================================

    if self.Categories.GetAllSounds then

        return self.Categories:GetAllSounds()

    end

    return nil

end

--==================================================
-- GET CATEGORY SOUNDS
--==================================================

function Search:GetCategorySounds(
    CategoryName
)

    local Results =
        {}

    if not self.Sounds then
        return Results
    end

    --==================================================
    -- ALL
    --==================================================

    if CategoryName == "ALL" then

        local FilteredSounds =
            self:GetSoundsFromCurrentFilter()

        if type(FilteredSounds) ==
            "table" then

            return FilteredSounds

        end

        return Results

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    local Category =
        self.Sounds[
            CategoryName
        ]

    if type(Category) ~= "table" then
        return Results
    end

    for _, Data in
        ipairs(Category) do

        if type(Data) == "table" then

            table.insert(
                Results,
                Data
            )

        end

    end

    return Results

end

--==================================================
-- COLLECT
--==================================================
-- Pesquisa dentro do conjunto correto:
--
-- ALL + filtro:
--     somente sons daquele filtro.
--
-- Categoria:
--     somente sons daquela categoria.
--
--==================================================

function Search:Collect(
    Query
)

    local Results =
        {}

    Query =
        string.lower(
            tostring(
                Query or ""
            )
        )

    local CategoryName =
        self:GetActiveCategory()

    local SourceSounds =
        self:GetCategorySounds(
            CategoryName
        )

    if type(SourceSounds) ~=
        "table" then

        return Results

    end

    --==================================================
    -- SEARCH
    --==================================================

    for Index, Data in
        ipairs(SourceSounds) do

        if type(Data) == "table" then

            local Name =
                tostring(
                    Data[1] or ""
                )

            local ID =
                tostring(
                    Data[2] or ""
                )

            local LowerName =
                string.lower(
                    Name
                )

            local LowerID =
                string.lower(
                    ID
                )

            --==================================================
            -- QUERY MATCH
            --==================================================

            if string.find(
                LowerName,
                Query,
                1,
                true
            )
            or string.find(
                LowerID,
                Query,
                1,
                true
            ) then

                table.insert(
                    Results,
                    {

                        Name =
                            Name,

                        ID =
                            ID,

                        Category =
                            CategoryName,

                        Index =
                            Index

                    }
                )

            end

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

    if not self.Cards.CreateSoundCard then
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
        Query ..
        '"'

    Label.TextColor3 =
        self:GetTheme().SubText

    Label.TextSize =
        12

    Label.Font =
        Enum.Font.GothamMedium

    Label.TextXAlignment =
        Enum.TextXAlignment.Center

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
            Query or ""
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
        -- RESTORE CURRENT CONTENT
        --==================================================

        if self.Categories
        and self.Categories.RefreshCurrent then

            self.Categories:RefreshCurrent()

        elseif self.Categories
        and self.Categories.ShowCategory then

            self.Categories:ShowCategory(
                self.LastCategory
            )

        end

        return

    end

    --==================================================
    -- ACTIVE
    --==================================================

    self.Active =
        true

    --==================================================
    -- CLEAR OLD CONTENT
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
            )
            ..
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
        ipairs(Results) do

        self:CreateResult(

            Index,

            Result

        )

    end

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
    -- IF SEARCH IS ACTIVE
    --==================================================

    if self.Active
    and self.Query ~= "" then

        self:Search(
            self.Query
        )

    end

end

--==================================================
-- FILTER CHANGED
--==================================================
-- Pode ser chamado pelo Categories quando
-- o filtro mudar.
--
-- O Search automaticamente refaz a pesquisa
-- usando o novo conjunto de sons.
--==================================================

function Search:SetFilter(
    FilterName
)

    self.CurrentFilter =
        FilterName

    if self.Active
    and self.Query ~= "" then

        self:Search(
            self.Query
        )

    end

end

--==================================================
-- REFRESH
--==================================================
-- Útil quando favoritos são adicionados/removidos
-- enquanto a pesquisa está aberta.
--==================================================

function Search:Refresh()

    if self.Active
    and self.Query ~= "" then

        self:Search(
            self.Query
        )

    end

end

--==================================================
-- THEME
--==================================================

function Search:ApplyTheme()

    local CurrentTheme =
        self:GetTheme()

    if self.Box then

        self.Box.BackgroundColor3 =
            CurrentTheme.Card

        self.Box.TextColor3 =
            CurrentTheme.Text

        self.Box.PlaceholderColor3 =
            CurrentTheme.SubText

    end

    if self.ResultLabel then

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

    if self.Active then

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

    return self.Active == true

end

--==================================================
-- RETURN
--==================================================

return Search

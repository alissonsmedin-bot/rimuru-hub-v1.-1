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
--// CARDS COMPATIBLE
--// THEME COMPATIBLE
--// NO RECURSIVE CONTEXT LOOP

local Search = {}

--==================================================
-- INIT
--==================================================

function Search:Init(Context)

    Context = Context or {}

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

    self.Favorites =
        Context.Favorites

    --==================================================
    -- SEARCH STATE
    --==================================================

    self.Query =
        ""

    self.LastQuery =
        ""

    self.IsSearching =
        false

    self.SuppressContextUpdate =
        false

    self.IsUpdating =
        false

    --==================================================
    -- UI
    --==================================================

    self.SearchBox =
        nil

    self.ResultsLabel =
        nil

    self.ResultCountLabel =
        nil

    --==================================================
    -- CONTEXT
    --==================================================

    self.ContextCategory =
        "ALL"

    self.ContextFilter =
        "All"

    --==================================================
    -- CONNECTION
    --==================================================

    self.SearchConnection =
        nil

end

--==================================================
-- SET UI REFERENCES
--==================================================

function Search:SetSearchBox(
    SearchBox
)

    self.SearchBox =
        SearchBox

    if not SearchBox then
        return
    end

    --==================================================
    -- REMOVE OLD CONNECTION
    --==================================================

    if self.SearchConnection then

        pcall(function()

            self.SearchConnection:Disconnect()

        end)

        self.SearchConnection =
            nil

    end

    --==================================================
    -- TEXT CHANGED
    --==================================================

    self.SearchConnection =
        SearchBox:GetPropertyChangedSignal(
            "Text"
        ):Connect(

            function()

                self:SetQuery(
                    SearchBox.Text
                )

            end

        )

end

--==================================================
-- SET RESULT LABEL
--==================================================

function Search:SetResultsLabel(
    Label
)

    self.ResultsLabel =
        Label

end

--==================================================
-- NORMALIZE
--==================================================

function Search:Normalize(
    Text
)

    if Text == nil then
        return ""
    end

    return string.lower(
        tostring(Text)
    )

end

--==================================================
-- GET QUERY
--==================================================

function Search:GetQuery()

    return self.Query

end

--==================================================
-- HAS QUERY
--==================================================

function Search:HasQuery()

    return self.Query ~= ""

end

--==================================================
-- GET CATEGORY
--==================================================

function Search:GetCurrentCategory()

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
        and type(Category) == "string" then

            return Category

        end

    end

    return self.ContextCategory

end

--==================================================
-- GET FILTER
--==================================================

function Search:GetCurrentFilter()

    if self.Categories
    and type(
        self.Categories.GetCurrentFilter
    ) == "function" then

        local Success, Filter =
            pcall(function()

                return self.Categories:
                    GetCurrentFilter()

            end)

        if Success
        and type(Filter) == "string" then

            return Filter

        end

    end

    return self.ContextFilter

end

--==================================================
-- UPDATE CONTEXT
--==================================================

function Search:UpdateContext()

    self.ContextCategory =
        self:GetCurrentCategory()

    self.ContextFilter =
        self:GetCurrentFilter()

end

--==================================================
-- VALID SOUND DATA
--==================================================

function Search:IsValidSoundData(
    Data
)

    if type(Data) ~= "table" then
        return false
    end

    if type(Data[1]) ~= "string" then
        return false
    end

    if Data[1] == "" then
        return false
    end

    if Data[2] == nil then
        return false
    end

    return true

end

--==================================================
-- GET ALL SOUNDS
--==================================================

function Search:GetAllSounds()

    if self.Categories
    and type(
        self.Categories.GetAllSounds
    ) == "function" then

        local Success, Result =
            pcall(function()

                return self.Categories:
                    GetAllSounds()

            end)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    local Result = {}

    if type(self.Sounds) ~= "table" then
        return Result
    end

    for CategoryName, CategoryData in pairs(
        self.Sounds
    ) do

        if CategoryName ~= "ALL"
        and CategoryName ~= "Configuração"
        and type(CategoryData) == "table" then

            for _, Data in ipairs(CategoryData) do

                if self:IsValidSoundData(Data) then

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
-- GET FAVORITES
--==================================================

function Search:GetFavoriteSounds()

    if self.Categories
    and type(
        self.Categories.GetFavoriteSounds
    ) == "function" then

        local Success, Result =
            pcall(function()

                return self.Categories:
                    GetFavoriteSounds()

            end)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    local Result = {}

    if not self.Favorites
    or type(self.Favorites.IsFavorite) ~= "function" then

        return Result

    end

    for _, Data in ipairs(
        self:GetAllSounds()
    ) do

        if self:IsValidSoundData(Data) then

            local ID =
                Data[2]

            local Success, Favorite =
                pcall(function()

                    return self.Favorites:
                        IsFavorite(ID)

                end)

            if Success
            and Favorite == true then

                table.insert(
                    Result,
                    Data
                )

            end

        end

    end

    return Result

end

--==================================================
-- GET M1
--==================================================

function Search:GetM1Sounds()

    if self.Categories
    and type(
        self.Categories.GetM1Sounds
    ) == "function" then

        local Success, Result =
            pcall(function()

                return self.Categories:
                    GetM1Sounds()

            end)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    return self:FilterListByWord(
        self:GetAllSounds(),
        "m1"
    )

end

--==================================================
-- GET HIT
--==================================================

function Search:GetHitSounds()

    if self.Categories
    and type(
        self.Categories.GetHitSounds
    ) == "function" then

        local Success, Result =
            pcall(function()

                return self.Categories:
                    GetHitSounds()

            end)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    return self:FilterListByWord(
        self:GetAllSounds(),
        "hit"
    )

end

--==================================================
-- FILTER LIST BY WORD
--==================================================

function Search:FilterListByWord(
    List,
    Word
)

    local Result = {}

    Word =
        self:Normalize(Word)

    if Word == "" then
        return Result
    end

    if type(List) ~= "table" then
        return Result
    end

    for _, Data in ipairs(List) do

        if self:IsValidSoundData(Data) then

            local Name =
                self:Normalize(
                    Data[1]
                )

            if string.find(
                Name,
                Word,
                1,
                true
            ) then

                table.insert(
                    Result,
                    Data
                )

            end

        end

    end

    return Result

end

--==================================================
-- GET CONTEXT SOUNDS
--==================================================

function Search:GetContextSounds()

    self:UpdateContext()

    local Category =
        self.ContextCategory

    local Filter =
        self.ContextFilter

    --==================================================
    -- CONFIGURATION
    --==================================================

    if Category ==
        "Configuração" then

        return {}

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    if Category ~= "ALL" then

        if type(self.Sounds) == "table" then

            local CategoryData =
                self.Sounds[Category]

            if type(CategoryData) == "table" then

                local Result = {}

                for _, Data in ipairs(
                    CategoryData
                ) do

                    if self:IsValidSoundData(Data) then

                        table.insert(
                            Result,
                            Data
                        )

                    end

                end

                return Result

            end

        end

        return {}

    end

    --==================================================
    -- ALL FILTERS
    --==================================================

    if Filter == "Favorite" then

        return self:GetFavoriteSounds()

    end

    if Filter == "M1" then

        return self:GetM1Sounds()

    end

    if Filter == "Hit" then

        return self:GetHitSounds()

    end

    return self:GetAllSounds()

end

--==================================================
-- SEARCH DATA
--==================================================

function Search:SearchList(
    List,
    Query
)

    local Result = {}

    Query =
        self:Normalize(Query)

    if Query == "" then

        for _, Data in ipairs(List or {}) do

            if self:IsValidSoundData(Data) then

                table.insert(
                    Result,
                    Data
                )

            end

        end

        return Result

    end

    if type(List) ~= "table" then
        return Result
    end

    for _, Data in ipairs(List) do

        if self:IsValidSoundData(Data) then

            local Name =
                self:Normalize(
                    Data[1]
                )

            if string.find(
                Name,
                Query,
                1,
                true
            ) then

                table.insert(
                    Result,
                    Data
                )

            end

        end

    end

    return Result

end

--==================================================
-- GET SEARCH RESULTS
--==================================================

function Search:GetResults(
    Query
)

    Query =
        self:Normalize(
            Query ~= nil
            and Query
            or self.Query
        )

    local ContextSounds =
        self:GetContextSounds()

    return self:SearchList(
        ContextSounds,
        Query
    )

end

--==================================================
-- UPDATE RESULT TEXT
--==================================================

function Search:UpdateResultLabel(
    Count,
    Query
)

    local Label =
        self.ResultsLabel

    if not Label then
        return
    end

    if Query == "" then

        Label.Text = ""

        return

    end

    Label.Text =
        "Results found: "
        .. tostring(Count)

end

--==================================================
-- RENDER RESULTS
--==================================================

function Search:RenderResults(
    Results
)

    if self.IsUpdating then
        return
    end

    self.IsUpdating = true

    local Success, Error =
        pcall(function()

            if not self.Categories then
                return
            end

            if self.Categories.CurrentCategory ==
                "Configuração" then

                return

            end

            if not self.Cards
            or type(
                self.Cards.CreateSoundCard
            ) ~= "function" then

                warn(
                    "[RIMURU HUB] Search: Cards.CreateSoundCard não está disponível."
                )

                return

            end

            if not self.UI
            or not self.UI.Scroll then
                return
            end

            --==================================================
            -- CLEAR ONLY SOUND CARDS
            --==================================================

            for _, Object in ipairs(
                self.UI.Scroll:GetChildren()
            ) do

                if Object:IsA("Frame")
                and Object.Name:sub(1, 6) ==
                    "Sound_" then

                    Object:Destroy()

                end

            end

            --==================================================
            -- CREATE RESULTS
            --==================================================

            for Index, Data in ipairs(
                Results or {}
            ) do

                if self:IsValidSoundData(Data) then

                    self.Cards:CreateSoundCard(
                        Index,
                        Data
                    )

                end

            end

        end)

    self.IsUpdating = false

    if not Success then

        warn(
            "[RIMURU HUB] Search Render Error:",
            Error
        )

    end

end

--==================================================
-- SET QUERY
--==================================================

function Search:SetQuery(
    Query
)

    Query =
        self:Normalize(
            Query
        )

    --==================================================
    -- NO CHANGE
    --==================================================

    if Query == self.Query
    and Query == self.LastQuery then

        return

    end

    self.Query =
        Query

    self.LastQuery =
        Query

    self.IsSearching =
        Query ~= ""

    --==================================================
    -- UPDATE CONTEXT
    --==================================================

    self:UpdateContext()

    --==================================================
    -- EMPTY QUERY
    --==================================================

    if Query == "" then

        self:UpdateResultLabel(
            0,
            ""
        )

        self:RenderResults(
            self:GetContextSounds()
        )

        return

    end

    --==================================================
    -- SEARCH
    --==================================================

    local Results =
        self:GetResults(
            Query
        )

    self:UpdateResultLabel(
        #Results,
        Query
    )

    self:RenderResults(
        Results
    )

end

--==================================================
-- CLEAR SEARCH
--==================================================
-- Zera completamente a busca.
-- Não restaura query antiga.
--==================================================

function Search:Clear()

    self.Query =
        ""

    self.LastQuery =
        ""

    self.IsSearching =
        false

    if self.SearchBox then

        -- evita que o TextChanged
        -- execute duas reconstruções

        self.SuppressContextUpdate =
            true

        self.SearchBox.Text =
            ""

        self.SuppressContextUpdate =
            false

    end

    self:UpdateResultLabel(
        0,
        ""
    )

end

--==================================================
-- CLEAR FOR CONTEXT
--==================================================
-- Usado pelo Categories.lua quando:
--
-- categoria muda
-- filtro muda
-- configuração abre
--
-- IMPORTANTE:
-- nunca restaura a pesquisa anterior.
--==================================================

function Search:ClearForContext()

    self:Clear()

    self:UpdateContext()

end

--==================================================
-- CONTEXT CHANGED
--==================================================
-- Quando tema ou categoria atualiza a interface,
-- a pesquisa atual continua válida.
--
-- Se houver query:
-- pesquisa novamente.
--
-- Se não houver:
-- apenas redesenha o contexto atual.
--==================================================

function Search:OnContextChanged()

    if self.SuppressContextUpdate then
        return
    end

    self:UpdateContext()

    if self.IsSearching
    and self.Query ~= "" then

        local Results =
            self:GetResults(
                self.Query
            )

        self:UpdateResultLabel(
            #Results,
            self.Query
        )

        self:RenderResults(
            Results
        )

        return

    end

    self:UpdateResultLabel(
        0,
        ""
    )

end

--==================================================
-- REFRESH
--==================================================

function Search:Refresh()

    self:OnContextChanged()

end

--==================================================
-- GET RESULT COUNT
--==================================================

function Search:GetResultCount()

    if not self.IsSearching then
        return 0
    end

    local Results =
        self:GetResults(
            self.Query
        )

    return #Results

end

--==================================================
-- GET STATE
--==================================================

function Search:GetState()

    return {

        Query =
            self.Query,

        IsSearching =
            self.IsSearching,

        Category =
            self:GetCurrentCategory(),

        Filter =
            self:GetCurrentFilter(),

        ResultCount =
            self:GetResultCount()

    }

end

--==================================================
-- RESET
--==================================================

function Search:Reset()

    self:Clear()

    self.ContextCategory =
        "ALL"

    self.ContextFilter =
        "All"

end

--==================================================
-- APPLY THEME
--==================================================

function Search:ApplyTheme()

    if not self.Theme then
        return
    end

    if self.ResultsLabel then

        local CurrentTheme =
            self.Theme:GetCurrent()

        if CurrentTheme then

            self.ResultsLabel.TextColor3 =
                CurrentTheme.SubText
                or CurrentTheme.Text

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Search

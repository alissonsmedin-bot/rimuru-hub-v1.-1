--// 💥 RIMURU HUB
--// Search System

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

    self.UI =
        Context.UI

    self.Cards =
        Context.Cards

    self.Theme =
        Context.Theme

    self.Categories =
        Context.Categories

    self.Active =
        false

    self.Query =
        ""

    self.Results =
        {}

    self.SortMode =
        "A-Z"

    self.LastCategory =
        "Outros"

    self:Create()

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
            22
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
        Enum.Font.GothamMedium

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
-- COLLECT
--==================================================

function Search:Collect(Query)

    local Results =
        {}

    Query =
        string.lower(
            tostring(
                Query or ""
            )
        )

    for CategoryName, Category in
        pairs(
            self.Sounds
        ) do

        if type(Category) ==
            "table" then

            for Index, Data in
                ipairs(Category) do

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

    end

    return Results

end

--==================================================
-- SORT
--==================================================

function Search:Sort(Results)

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

    Label.ZIndex =
        504

    Label.Parent =
        Scroll

end

--==================================================
-- RESULT COUNT
--==================================================

function Search:UpdateResultCount(
    Count
)

    if not self.ResultLabel then
        return
    end

    self.ResultLabel.Text =
        "Resultados encontrados: " ..
        tostring(
            Count
        )

    self.ResultLabel.Visible =
        true

end

--==================================================
-- SEARCH
--==================================================

function Search:Search(Query)

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

        -- Volta para a categoria atual

        if self.Categories
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

    self:UpdateResultCount(
        #Results
    )

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
-- CATEGORY CHANGED
--==================================================

function Search:SetCategory(
    CategoryName
)

    if CategoryName then

        self.LastCategory =
            CategoryName

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
-- GET RESULTS
--==================================================

function Search:GetResults()

    return self.Results

end

--==================================================
-- GET RESULT COUNT
--==================================================

function Search:GetResultCount()

    return #self.Results

end

--==================================================
-- EXPORT
--==================================================

return Search

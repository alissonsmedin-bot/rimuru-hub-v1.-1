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

    self.Active =
        false

    self.Query =
        ""

    self.Results =
        {}

    self.SortMode =
        "A-Z"

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
-- CREATE
--==================================================

function Search:Create()

    local Content =
        self.UI.Content

    if not Content then
        return
    end

    --==================================================
    -- SEARCH BOX
    --==================================================

    local SearchBox =
        Instance.new("TextBox")

    SearchBox.Name =
        "SearchBox"

    SearchBox.Position =
        UDim2.new(
            0,
            10,
            0,
            10
        )

    SearchBox.Size =
        UDim2.new(
            1,
            -20,
            0,
            38
        )

    SearchBox.BackgroundColor3 =
        self:GetTheme().Card

    SearchBox.BorderSizePixel =
        0

    SearchBox.Text =
        ""

    SearchBox.PlaceholderText =
        "🔎  Pesquisar sons..."

    SearchBox.PlaceholderColor3 =
        self:GetTheme().SubText

    SearchBox.TextColor3 =
        self:GetTheme().Text

    SearchBox.TextSize =
        12

    SearchBox.Font =
        Enum.Font.Gotham

    SearchBox.TextXAlignment =
        Enum.TextXAlignment.Left

    SearchBox.ClearTextOnFocus =
        false

    SearchBox.ZIndex =
        510

    SearchBox.Parent =
        Content

    --==================================================
    -- CORNER
    --==================================================

    local Corner =
        Instance.new("UICorner")

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
        Instance.new("UIPadding")

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
    -- RESULT COUNTER
    --==================================================

    local ResultLabel =
        Instance.new("TextLabel")

    ResultLabel.Name =
        "ResultCount"

    ResultLabel.Position =
        UDim2.new(
            0,
            12,
            0,
            52
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

    ResultLabel.ZIndex =
        510

    ResultLabel.Parent =
        Content

    --==================================================
    -- SAVE
    --==================================================

    self.Box =
        SearchBox

    self.ResultLabel =
        ResultLabel

    --==================================================
    -- SEARCH EVENT
    --==================================================

    SearchBox:GetPropertyChangedSignal(
        "Text"
    ):Connect(function()

        self:Search(
            SearchBox.Text
        )

    end)

end

--==================================================
-- COLLECT RESULTS
--==================================================

function Search:Collect(Query)

    local Results =
        {}

    Query =
        string.lower(
            tostring(Query or "")
        )

    for CategoryName, Category in
        pairs(self.Sounds) do

        if type(Category) == "table" then

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

                if Query == ""
                or string.find(
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

    if self.SortMode == "A-Z" then

        table.sort(
            Results,
            function(A, B)

                return string.lower(
                    A.Name
                ) <
                string.lower(
                    B.Name
                )

            end
        )

    elseif self.SortMode == "Z-A" then

        table.sort(
            Results,
            function(A, B)

                return string.lower(
                    A.Name
                ) >
                string.lower(
                    B.Name
                )

            end
        )

    elseif self.SortMode == "ID ↑" then

        table.sort(
            Results,
            function(A, B)

                return tonumber(A.ID)
                    or 0
                    <
                    tonumber(B.ID)
                    or 0

            end
        )

    elseif self.SortMode == "ID ↓" then

        table.sort(
            Results,
            function(A, B)

                return tonumber(A.ID)
                    or 0
                    >
                    tonumber(B.ID)
                    or 0

            end
        )

    end

end

--==================================================
-- CLEAR CARDS
--==================================================

function Search:ClearCards()

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
-- CREATE RESULT CARD
--==================================================

function Search:CreateResult(
    Index,
    Result
)

    if self.Cards
    and self.Cards.CreateSoundCard then

        self.Cards:CreateSoundCard(
            Index,
            {
                Result.Name,
                Result.ID
            }
        )

    end

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
    -- EMPTY
    --==================================================

    if Query == "" then

        self.Active =
            false

        self.Results =
            {}

        if self.ResultLabel then

            self.ResultLabel.Text =
                ""

        end

        return

    end

    self.Active =
        true

    --==================================================
    -- COLLECT
    --==================================================

    local Results =
        self:Collect(
            Query
        )

    --==================================================
    -- SORT
    --==================================================

    self:Sort(
        Results
    )

    self.Results =
        Results

    --==================================================
    -- CLEAR
    --==================================================

    self:ClearCards()

    --==================================================
    -- COUNT
    --==================================================

    if self.ResultLabel then

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
    -- RESULTS
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
-- NO RESULTS
--==================================================

function Search:ShowNoResults(Query)

    local Scroll =
        self.UI.Scroll

    if not Scroll then
        return
    end

    local Label =
        Instance.new("TextLabel")

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
        'Nenhum som encontrado para "' ..
        Query ..
        '"'

    Label.TextColor3 =
        self:GetTheme().SubText

    Label.TextSize =
        12

    Label.Font =
        Enum.Font.GothamMedium

    Label.ZIndex =
        510

    Label.Parent =
        Scroll

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

function Search:GetSortMode()

    return self.SortMode

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

    end

end

function Search:IsVisible()

    if not self.Box then
        return false
    end

    return self.Box.Visible

end

--==================================================
-- GET BOX
--==================================================

function Search:GetBox()

    return self.Box

end

return Search

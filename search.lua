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

    self.Active =
        false

    self:Create()

end

--==================================================
-- CREATE SEARCH BAR
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
        self.UI:GetTheme().Card

    SearchBox.BorderSizePixel =
        0

    SearchBox.PlaceholderText =
        "🔎  Pesquisar sons..."

    SearchBox.PlaceholderColor3 =
        self.UI:GetTheme().SubText

    SearchBox.Text =
        ""

    SearchBox.TextColor3 =
        self.UI:GetTheme().Text

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
    -- SAVE
    --==================================================

    self.Box =
        SearchBox

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
-- SEARCH
--==================================================

function Search:Search(Query)

    Query =
        string.lower(
            tostring(Query or "")
        )

    -- Campo vazio
    if Query == "" then

        self:ClearSearch()

        return

    end

    self.Active =
        true

    -- Limpa os resultados atuais
    self.Cards:Clear()

    local Found =
        0

    --==================================================
    -- SEARCH ALL CATEGORIES
    --==================================================

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

                --==================================================
                -- MATCH
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

                    Found += 1

                    self.Cards:Create(
                        Found,
                        {
                            Name,
                            ID
                        }
                    )

                end

            end

        end

    end

    --==================================================
    -- NO RESULTS
    --==================================================

    if Found == 0 then

        self:ShowNoResults(
            Query
        )

    end

end

--==================================================
-- CLEAR SEARCH
--==================================================

function Search:ClearSearch()

    self.Active =
        false

    self.Cards:Clear()

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
            45
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        'Nenhum som encontrado para "' ..
        Query ..
        '"'

    Label.TextColor3 =
        self.UI:GetTheme().SubText

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
-- VISIBILITY
--==================================================

function Search:SetVisible(Value)

    if self.Box then

        self.Box.Visible =
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

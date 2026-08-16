--// 💥 RIMURU HUB
--// Categories System
--// ⭐ Favorites Integration

local Categories = {}

--==================================================
-- CATEGORY ICONS
--==================================================

local CategoryIcons = {

    ["Todos"] =
        "📚",

    ["Favoritos"] =
        "⭐",

    ["Outro"] =
        "🏠",

    ["Outros"] =
        "🏠",

    ["Heian Sukuna Sounds"] =
        "👹",

    ["Gojo"] =
        "🔵",

    ["Configuração"] =
        "⚙️"

}

--==================================================
-- INIT
--==================================================

function Categories:Init(Context)

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

    self.Search =
        Context.Search

    self.Favorites =
        Context.Favorites

    self.Settings =
    Context.Settings

    self.Sidebar =
        self.UI.Sidebar

    self.Scroll =
        self.UI.Scroll

    self.ContentTitle =
        self.UI.ContentTitle

    self.SelectedButton =
        nil

    self.CategoryButtons =
        {}

    self.CurrentCategory =
        nil

    self.IsVirtualCategory =
        false

end

--==================================================
-- GET CATEGORY ICON
--==================================================

function Categories:GetIcon(
    CategoryName
)

    return CategoryIcons[
        CategoryName
    ]
    or "📁"

end

--==================================================
-- GET FAVORITE COUNT
--==================================================

function Categories:GetFavoriteCount()

    if not self.Favorites then
        return 0
    end

    local Success, Count =
        pcall(function()

            return self.Favorites:GetCount()

        end)

    if Success then
        return Count or 0
    end

    return 0

end

--==================================================
-- UPDATE FAVORITES BUTTON
--==================================================

function Categories:UpdateFavoritesButton()

    local Button =
        self.CategoryButtons[
            "Favoritos"
        ]

    if not Button then
        return
    end

    local Count =
        self:GetFavoriteCount()

    Button.Text =
        "⭐  Favoritos"

    if Count > 0 then

        Button.Text =
            "⭐  Favoritos (" ..
            tostring(Count) ..
            ")"

    end

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Categories:ClearContent()

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
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
-- CREATE CARD
--==================================================

function Categories:CreateCard(
    Index,
    Data
)

    self.Cards:CreateSoundCard(

        Index,

        Data

    )

end

--==================================================
-- SHOW ALL SOUNDS
--==================================================

function Categories:ShowAll()

    self.CurrentCategory =
        "Todos"

    self.IsVirtualCategory =
        true

    --==================================================
    -- INFORM SEARCH SYSTEM
    --==================================================

    if CategoryName ==
    "Todos"
then

    self:ShowAll()

elseif CategoryName ==
    "Favoritos"
then

    self:ShowFavorites()

elseif CategoryName ==
    "Configuração"
then

    if self.Settings
    and type(
        self.Settings.Build
    ) == "function"
    then

        local Success,
            Error =
            pcall(
                function()

                    self.Settings:
                        Build()

                end
            )

        if not Success then

            warn(
                "[Rimuru Hub] Erro ao abrir Configuração: "
                .. tostring(Error)
            )

        end

    end

elseif ShowSoundCategory
then

    self:ShowCategory(
        CategoryName
    )

    end

    --==================================================
    -- CLEAR
    --==================================================

    self:ClearContent()

    --==================================================
    -- TITLE
    --==================================================

    self.ContentTitle.Text =
        "Todos"

    --==================================================
    -- CREATE ALL CARDS
    --==================================================

    local CardIndex =
        0

    for CategoryName, Category in
        pairs(
            self.Sounds
        ) do

        if type(Category) ==
            "table" then

            for _, Data in
                ipairs(Category) do

                CardIndex += 1

                self:CreateCard(

                    CardIndex,

                    Data

                )

            end

        end

    end

end

--==================================================
-- SHOW FAVORITES
--==================================================

function Categories:ShowFavorites()

    self.CurrentCategory =
        "Favoritos"

    self.IsVirtualCategory =
        true

    --==================================================
    -- INFORM SEARCH SYSTEM
    --==================================================

    if self.Search
    and self.Search.SetCategory then

        self.Search:SetCategory(
            "Favoritos"
        )

    end

    --==================================================
    -- CLEAR
    --==================================================

    self:ClearContent()

    --==================================================
    -- TITLE
    --==================================================

    self.ContentTitle.Text =
        "Favoritos"

    --==================================================
    -- FAVORITE DATA
    --==================================================

    if not self.Favorites then

        return

    end

    local CardIndex =
        0

    --==================================================
    -- SEARCH ALL CATEGORIES
    --==================================================

    for CategoryName, Category in
        pairs(
            self.Sounds
        ) do

        if type(Category) ==
            "table" then

            for _, Data in
                ipairs(Category) do

                local ID =
                    tostring(
                        Data[2] or ""
                    )

                local IsFavorite =
                    false

                local Success, Result =
                    pcall(function()

                        return self.Favorites:IsFavorite(
                            ID
                        )

                    end)

                if Success then

                    IsFavorite =
                        Result == true

                end

                if IsFavorite then

                    CardIndex += 1

                    self:CreateCard(

                        CardIndex,

                        Data

                    )

                end

            end

        end

    end

    --==================================================
    -- EMPTY FAVORITES
    --==================================================

    if CardIndex == 0 then

        local EmptyLabel =
            Instance.new(
                "TextLabel"
            )

        EmptyLabel.Name =
            "NoFavorites"

        EmptyLabel.Size =
            UDim2.new(
                1,
                -5,
                0,
                55
            )

        EmptyLabel.BackgroundTransparency =
            1

        EmptyLabel.Text =
            "⭐ Nenhum favorito ainda"

        EmptyLabel.TextColor3 =
            self.Theme:GetCurrent().SubText

        EmptyLabel.TextSize =
            12

        EmptyLabel.Font =
            Enum.Font.GothamMedium

        EmptyLabel.TextXAlignment =
            Enum.TextXAlignment.Center

        EmptyLabel.ZIndex =
            504

        EmptyLabel.Parent =
            self.Scroll

    end

end

--==================================================
-- SHOW NORMAL CATEGORY
--==================================================

function Categories:ShowCategory(
    CategoryName
)

    --==================================================
    -- VIRTUAL CATEGORIES
    --==================================================

    if CategoryName ==
        "Todos" then

        self:ShowAll()

        return

    end

    if CategoryName ==
        "Favoritos" then

        self:ShowFavorites()

        return

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    self.CurrentCategory =
        CategoryName

    self.IsVirtualCategory =
        false

    --==================================================
    -- INFORM SEARCH SYSTEM
    --==================================================

    if self.Search
    and self.Search.SetCategory then

        self.Search:SetCategory(
            CategoryName
        )

    end

    --==================================================
    -- CLEAR
    --==================================================

    self:ClearContent()

    --==================================================
    -- TITLE
    --==================================================

    self.ContentTitle.Text =
        CategoryName

    --==================================================
    -- GET CATEGORY
    --==================================================

    local Category =
        self.Sounds[
            CategoryName
        ]

    if not Category then
        return
    end

    --==================================================
    -- CREATE CARDS
    --==================================================

    for Index, Data in
        ipairs(
            Category
        ) do

        self:CreateCard(

            Index,

            Data

        )

    end

end

--==================================================
-- REFRESH CURRENT CATEGORY
--==================================================

function Categories:RefreshCurrent()

    if self.CurrentCategory ==
        "Favoritos" then

        self:ShowFavorites()

        return

    end

    if self.CurrentCategory ==
        "Todos" then

        self:ShowAll()

        return

    end

    if self.CurrentCategory then

        self:ShowCategory(
            self.CurrentCategory
        )

    end

end

--==================================================
-- SELECT BUTTON
--==================================================

function Categories:SelectButton(
    Button
)

    if self.SelectedButton
    and self.SelectedButton ~= Button then

        self.SelectedButton.BackgroundColor3 =
            self.Theme:GetCurrent().Button

        self.SelectedButton.TextColor3 =
            self.Theme:GetCurrent().SubText

    end

    self.SelectedButton =
        Button

    Button.BackgroundColor3 =
        self.Theme:GetAccent()

    Button.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

end

--==================================================
-- CREATE CATEGORY BUTTON
--==================================================

function Categories:CreateCategoryButton(

    CategoryName,

    Order,

    ShowSoundCategory

)

    if ShowSoundCategory == nil then

        ShowSoundCategory =
            true

    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    --==================================================
    -- BUTTON
    --==================================================

    local Button =
        Instance.new(
            "TextButton"
        )

    Button.Name =
        CategoryName

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            38
        )

    Button.BackgroundColor3 =
        CurrentTheme.Button

    Button.BorderSizePixel =
        0

    --==================================================
    -- ICON
    --==================================================

    local Icon =
        self:GetIcon(
            CategoryName
        )

    Button.Text =
        Icon ..
        "  " ..
        CategoryName

    Button.TextColor3 =
        CurrentTheme.SubText

    Button.TextSize =
        11

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Order

    Button.ZIndex =
        503

    Button.Parent =
        self.Sidebar

    --==================================================
    -- PADDING
    --==================================================

    local ButtonPadding =
        Instance.new(
            "UIPadding"
        )

    ButtonPadding.PaddingLeft =
        UDim.new(
            0,
            10
        )

    ButtonPadding.Parent =
        Button

    --==================================================
    -- CORNER
    --==================================================

    local ButtonCorner =
        Instance.new(
            "UICorner"
        )

    ButtonCorner.CornerRadius =
        UDim.new(
            0,
            7
        )

    ButtonCorner.Parent =
        Button

    --==================================================
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(
        function()

            self:SelectButton(
                Button
            )

            if CategoryName ==
                "Todos" then

                self:ShowAll()

            elseif CategoryName ==
                "Favoritos" then

                self:ShowFavorites()

            elseif ShowSoundCategory then

                self:ShowCategory(
                    CategoryName
                )

            end

        end
    )

    self.CategoryButtons[
        CategoryName
    ] =
        Button

    return Button

end

--==================================================
-- CREATE ALL CATEGORIES
--==================================================

function Categories:CreateCategories()

    local CategoryIndex =
        0

    --==================================================
    -- TODOS
    --==================================================

    CategoryIndex += 1

    self:CreateCategoryButton(

        "Todos",

        CategoryIndex,

        true

    )

    --==================================================
    -- FAVORITOS
    --==================================================

    CategoryIndex += 1

    self:CreateCategoryButton(

        "Favoritos",

        CategoryIndex,

        true

    )

    --==================================================
    -- NORMAL CATEGORIES
    --==================================================

    for CategoryName in
        pairs(
            self.Sounds
        ) do

        CategoryIndex += 1

        self:CreateCategoryButton(

            CategoryName,

            CategoryIndex,

            true

        )

    end

    --==================================================
    -- CONFIGURATION
    --==================================================

    local ConfigButton =
        self:CreateCategoryButton(

            "Configuração",

            CategoryIndex + 1,

            false

        )

    self.ConfigButton =
        ConfigButton

    --==================================================
    -- UPDATE FAVORITE COUNT
    --==================================================

    self:UpdateFavoritesButton()

    return CategoryIndex

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

function Categories:SetDefaultCategory()

    local DefaultCategory =
        nil

    --==================================================
    -- DEFAULT = TODOS
    --==================================================

    if self.CategoryButtons[
        "Todos"
    ] then

        DefaultCategory =
            "Todos"

    end

    if not DefaultCategory then
        return
    end

    self:ShowAll()

    local DefaultButton =
        self.CategoryButtons[
            DefaultCategory
        ]

    if DefaultButton then

        self:SelectButton(
            DefaultButton
        )

    end

end

--==================================================
-- GET SELECTED BUTTON
--==================================================

function Categories:GetSelectedButton()

    return self.SelectedButton

end

--==================================================
-- GET CATEGORY BUTTON
--==================================================

function Categories:GetButton(
    CategoryName
)

    return self.CategoryButtons[
        CategoryName
    ]

end

--==================================================
-- GET CURRENT CATEGORY
--==================================================

function Categories:GetCurrentCategory()

    return self.CurrentCategory

end

--==================================================
-- IS FAVORITES
--==================================================

function Categories:IsFavorites()

    return self.CurrentCategory ==
        "Favoritos"

end

--==================================================
-- APPLY THEME
--==================================================

function Categories:ApplyTheme()

    local CurrentTheme =
        self.Theme:GetCurrent()

    for _, Button in
        pairs(
            self.CategoryButtons
        ) do

        if Button ==
            self.SelectedButton then

            Button.BackgroundColor3 =
                self.Theme:GetAccent()

            Button.TextColor3 =
                Color3.fromRGB(
                    255,
                    255,
                    255
                )

        else

            Button.BackgroundColor3 =
                CurrentTheme.Button

            Button.TextColor3 =
                CurrentTheme.SubText

        end

    end

    self:UpdateFavoritesButton()

end

--==================================================
-- UPDATE FAVORITES
--==================================================

function Categories:UpdateFavorites()

    self:UpdateFavoritesButton()

    if self.CurrentCategory ==
        "Favoritos" then

        self:ShowFavorites()

    end

end

--==================================================
-- RETURN
--==================================================

return Categories

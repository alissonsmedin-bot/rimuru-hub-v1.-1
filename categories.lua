--// 💥 RIMURU HUB
--// Categories System
--// ALL CATEGORY SYSTEM
--// FAVORITE FILTER
--// Dynamic All Sounds
--// ALL Always First
--// No Sound Duplication
--// Favorite Filter Compatible

local Categories = {}

--==================================================
-- CATEGORY ICONS
--==================================================

local CategoryIcons = {

    ["ALL"] =
        "🏠",

    ["Outro"] =
        "📁",

    ["Heian Sukuna Sounds"] =
        "👹",

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

    self.Favorites =
        Context.Favorites

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

    --==================================================
    -- ALL SOUNDS
    --==================================================

    self.AllSounds =
        {}

    --==================================================
    -- FILTER STATE
    --==================================================

    self.CurrentFilter =
        "All"

    self.FilterButton =
        nil

    self.FilterMenu =
        nil

end

--==================================================
-- GET CATEGORY ICON
--==================================================

function Categories:GetIcon(CategoryName)

    return CategoryIcons[CategoryName]
        or "📁"

end

--==================================================
-- BUILD ALL SOUNDS
--==================================================

function Categories:BuildAllSounds()

    self.AllSounds =
        {}

    if not self.Sounds then
        return
    end

    --==================================================
    -- GO THROUGH ALL SOUND CATEGORIES
    --==================================================

    for CategoryName, CategoryData in
        pairs(self.Sounds) do

        --==================================================
        -- IGNORE INVALID DATA
        --==================================================

        if type(CategoryData) == "table" then

            --==================================================
            -- ADD SOUNDS TO ALL
            --==================================================

            for _, SoundData in
                ipairs(CategoryData) do

                if type(SoundData) == "table" then

                    table.insert(

                        self.AllSounds,

                        SoundData

                    )

                end

            end

        end

    end

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Categories:ClearContent()

    if not self.Scroll then
        return
    end

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
-- GET FAVORITE SOUNDS
--==================================================

function Categories:GetFavoriteSounds()

    local Result =
        {}

    if not self.Favorites then
        return Result
    end

    self:BuildAllSounds()

    for _, SoundData in
        ipairs(self.AllSounds) do

        if type(SoundData) == "table" then

            local ID =
                SoundData[2]

            if ID
            and self.Favorites:IsFavorite(
                ID
            ) then

                table.insert(
                    Result,
                    SoundData
                )

            end

        end

    end

    return Result

end

--==================================================
-- UPDATE FILTER BUTTON
--==================================================

function Categories:UpdateFilterButton()

    if not self.FilterButton then
        return
    end

    if self.CurrentFilter ==
        "Favorite" then

        self.FilterButton.Text =
            "★ Favorite"

    else

        self.FilterButton.Text =
            "All"

    end

end

--==================================================
-- CLOSE FILTER MENU
--==================================================

function Categories:CloseFilterMenu()

    if self.FilterMenu then

        self.FilterMenu.Visible =
            false

    end

end

--==================================================
-- CREATE FILTER MENU
--==================================================

function Categories:CreateFilterMenu()

    if self.FilterMenu then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    --==================================================
    -- MENU
    --==================================================

    local Menu =
        Instance.new("Frame")

    Menu.Name =
        "FilterMenu"

    Menu.Size =
        UDim2.new(
            0,
            120,
            0,
            82
        )

    Menu.Position =
        UDim2.new(
            1,
            -130,
            0,
            42
        )

    Menu.BackgroundColor3 =
        CurrentTheme.Content

    Menu.BorderSizePixel =
        0

    Menu.ZIndex =
        800

    Menu.Visible =
        false

    Menu.Parent =
        self.ContentTitle.Parent

    local MenuCorner =
        Instance.new("UICorner")

    MenuCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    MenuCorner.Parent =
        Menu

    local MenuStroke =
        Instance.new("UIStroke")

    MenuStroke.Color =
        self.Theme:GetAccent()

    MenuStroke.Thickness =
        1

    MenuStroke.Parent =
        Menu

    self.FilterMenu =
        Menu

    --==================================================
    -- ALL BUTTON
    --==================================================

    local AllButton =
        Instance.new("TextButton")

    AllButton.Name =
        "All"

    AllButton.Size =
        UDim2.new(
            1,
            -10,
            0,
            32
        )

    AllButton.Position =
        UDim2.new(
            0,
            5,
            0,
            5
        )

    AllButton.BackgroundColor3 =
        CurrentTheme.Button

    AllButton.BorderSizePixel =
        0

    AllButton.Text =
        "All"

    AllButton.TextColor3 =
        CurrentTheme.Text

    AllButton.TextSize =
        11

    AllButton.Font =
        Enum.Font.GothamMedium

    AllButton.AutoButtonColor =
        false

    AllButton.TextXAlignment =
        Enum.TextXAlignment.Left

    AllButton.ZIndex =
        801

    AllButton.Parent =
        Menu

    local AllPadding =
        Instance.new("UIPadding")

    AllPadding.PaddingLeft =
        UDim.new(
            0,
            9
        )

    AllPadding.Parent =
        AllButton

    local AllCorner =
        Instance.new("UICorner")

    AllCorner.CornerRadius =
        UDim.new(
            0,
            6
        )

    AllCorner.Parent =
        AllButton

    --==================================================
    -- FAVORITE BUTTON
    --==================================================

    local FavoriteButton =
        Instance.new("TextButton")

    FavoriteButton.Name =
        "Favorite"

    FavoriteButton.Size =
        UDim2.new(
            1,
            -10,
            0,
            32
        )

    FavoriteButton.Position =
        UDim2.new(
            0,
            5,
            0,
            45
        )

    FavoriteButton.BackgroundColor3 =
        CurrentTheme.Button

    FavoriteButton.BorderSizePixel =
        0

    FavoriteButton.Text =
        "★ Favorite"

    FavoriteButton.TextColor3 =
        CurrentTheme.Text

    FavoriteButton.TextSize =
        11

    FavoriteButton.Font =
        Enum.Font.GothamMedium

    FavoriteButton.AutoButtonColor =
        false

    FavoriteButton.TextXAlignment =
        Enum.TextXAlignment.Left

    FavoriteButton.ZIndex =
        801

    FavoriteButton.Parent =
        Menu

    local FavoritePadding =
        Instance.new("UIPadding")

    FavoritePadding.PaddingLeft =
        UDim.new(
            0,
            9
        )

    FavoritePadding.Parent =
        FavoriteButton

    local FavoriteCorner =
        Instance.new("UICorner")

    FavoriteCorner.CornerRadius =
        UDim.new(
            0,
            6
        )

    FavoriteCorner.Parent =
        FavoriteButton

    --==================================================
    -- ALL EVENT
    --==================================================

    AllButton.MouseButton1Click:Connect(

        function()

            self.CurrentFilter =
                "All"

            self:CloseFilterMenu()

            self:UpdateFilterButton()

            self:ShowAll()

        end

    )

    --==================================================
    -- FAVORITE EVENT
    --==================================================

    FavoriteButton.MouseButton1Click:Connect(

        function()

            self.CurrentFilter =
                "Favorite"

            self:CloseFilterMenu()

            self:UpdateFilterButton()

            self:ShowFavorites()

        end

    )

end

--==================================================
-- CREATE FILTER BUTTON
--==================================================

function Categories:CreateFilterButton()

    if self.FilterButton then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Parent =
        self.ContentTitle.Parent

    local Button =
        Instance.new("TextButton")

    Button.Name =
        "FilterButton"

    Button.Size =
        UDim2.new(
            0,
            105,
            0,
            28
        )

    Button.Position =
        UDim2.new(
            1,
            -115,
            0,
            8
        )

    Button.BackgroundColor3 =
        CurrentTheme.Button

    Button.BorderSizePixel =
        0

    Button.Text =
        "All"

    Button.TextColor3 =
        CurrentTheme.Text

    Button.TextSize =
        10

    Button.Font =
        Enum.Font.GothamMedium

    Button.AutoButtonColor =
        false

    Button.ZIndex =
        700

    Button.Parent =
        Parent

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            7
        )

    Corner.Parent =
        Button

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        1

    Stroke.Parent =
        Button

    self.FilterButton =
        Button

    self.FilterStroke =
        Stroke

    --==================================================
    -- CREATE MENU
    --==================================================

    self:CreateFilterMenu()

    --==================================================
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(

        function()

            if not self.FilterMenu then
                return
            end

            self.FilterMenu.Visible =
                not self.FilterMenu.Visible

        end

    )

end

--==================================================
-- SHOW ALL
--==================================================

function Categories:ShowAll()

    self:ClearContent()

    self:BuildAllSounds()

    self.ContentTitle.Text =
        "ALL"

    --==================================================
    -- CREATE ALL CARDS
    --==================================================

    for Index, Data in
        ipairs(self.AllSounds) do

        self.Cards:CreateSoundCard(

            Index,

            Data

        )

    end

end

--==================================================
-- SHOW FAVORITES
--==================================================

function Categories:ShowFavorites()

    self:ClearContent()

    self.ContentTitle.Text =
        "Favorite"

    local FavoriteSounds =
        self:GetFavoriteSounds()

    --==================================================
    -- CREATE FAVORITE CARDS
    --==================================================

    for Index, Data in
        ipairs(FavoriteSounds) do

        self.Cards:CreateSoundCard(

            Index,

            Data

        )

    end

end

--==================================================
-- SHOW CATEGORY
--==================================================

function Categories:ShowCategory(
    CategoryName
)

    --==================================================
    -- ALL
    --==================================================

    if CategoryName == "ALL" then

        self.CurrentFilter =
            "All"

        self:UpdateFilterButton()

        self:ShowAll()

        return

    end

    --==================================================
    -- CLOSE FILTER MENU
    --==================================================

    self:CloseFilterMenu()

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    self:ClearContent()

    self.ContentTitle.Text =
        CategoryName

    local Category =
        self.Sounds[CategoryName]

    if not Category then
        return
    end

    for Index, Data in
        ipairs(Category) do

        self.Cards:CreateSoundCard(

            Index,

            Data

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
    -- CATEGORY ICON
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

            if ShowSoundCategory then

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
    -- ALL ALWAYS FIRST
    --==================================================

    CategoryIndex += 1

    local AllButton =
        self:CreateCategoryButton(

            "ALL",

            CategoryIndex,

            true

        )

    self.AllButton =
        AllButton

    --==================================================
    -- NORMAL SOUND CATEGORIES
    --==================================================

    for CategoryName in
        pairs(
            self.Sounds
        ) do

        --==================================================
        -- NEVER CREATE ANOTHER ALL
        --==================================================

        if CategoryName ~= "ALL"
        and CategoryName ~= "Configuração" then

            CategoryIndex += 1

            self:CreateCategoryButton(

                CategoryName,

                CategoryIndex,

                true

            )

        end

    end

    --==================================================
    -- CONFIGURATION BUTTON
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
    -- FILTER
    --==================================================

    self:CreateFilterButton()

    return CategoryIndex + 1

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

function Categories:SetDefaultCategory()

    --==================================================
    -- ALL IS ALWAYS DEFAULT
    --==================================================

    local AllButton =
        self.CategoryButtons[
            "ALL"
        ]

    if not AllButton then
        return
    end

    self.CurrentFilter =
        "All"

    self:UpdateFilterButton()

    self:ShowAll()

    self:SelectButton(
        AllButton
    )

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
-- GET ALL SOUNDS
--==================================================

function Categories:GetAllSounds()

    self:BuildAllSounds()

    return self.AllSounds

end

--==================================================
-- GET ALL SOUND COUNT
--==================================================

function Categories:GetAllSoundCount()

    self:BuildAllSounds()

    return #self.AllSounds

end

--==================================================
-- GET FAVORITE SOUND COUNT
--==================================================

function Categories:GetFavoriteSoundCount()

    local FavoriteSounds =
        self:GetFavoriteSounds()

    return #FavoriteSounds

end

--==================================================
-- GET CURRENT FILTER
--==================================================

function Categories:GetCurrentFilter()

    return self.CurrentFilter

end

--==================================================
-- SET FILTER
--==================================================

function Categories:SetFilter(
    FilterName
)

    if FilterName ~= "All"
    and FilterName ~= "Favorite" then

        return

    end

    self.CurrentFilter =
        FilterName

    self:UpdateFilterButton()

    if FilterName == "Favorite" then

        self:ShowFavorites()

    else

        self:ShowAll()

    end

end

--==================================================
-- REFRESH CURRENT CONTENT
--==================================================

function Categories:RefreshCurrent()

    if self.CurrentFilter ==
        "Favorite" then

        self:ShowFavorites()

        return

    end

    local SelectedButton =
        self.SelectedButton

    if SelectedButton
    and SelectedButton.Name ==
        "ALL" then

        self:ShowAll()

        return

    end

    local CategoryName

    if SelectedButton then

        CategoryName =
            SelectedButton.Name

    end

    if CategoryName
    and self.Sounds[CategoryName] then

        self:ShowCategory(
            CategoryName
        )

        return

    end

    self:ShowAll()

end

--==================================================
-- APPLY THEME
--==================================================

function Categories:ApplyTheme()

    local CurrentTheme =
        self.Theme:GetCurrent()

    --==================================================
    -- CATEGORY BUTTONS
    --==================================================

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
                    245,
                    235
                )

        else

            Button.BackgroundColor3 =
                CurrentTheme.Button

            Button.TextColor3 =
                CurrentTheme.SubText

        end

    end

    --==================================================
    -- FILTER BUTTON
    --==================================================

    if self.FilterButton then

        self.FilterButton.BackgroundColor3 =
            CurrentTheme.Button

        self.FilterButton.TextColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- FILTER STROKE
    --==================================================

    if self.FilterStroke then

        self.FilterStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- FILTER MENU
    --==================================================

    if self.FilterMenu then

        self.FilterMenu.BackgroundColor3 =
            CurrentTheme.Content

        local Stroke =
            self.FilterMenu:FindFirstChildOfClass(
                "UIStroke"
            )

        if Stroke then

            Stroke.Color =
                self.Theme:GetAccent()

        end

        local AllButton =
            self.FilterMenu:FindFirstChild(
                "All"
            )

        if AllButton then

            AllButton.BackgroundColor3 =
                CurrentTheme.Button

            AllButton.TextColor3 =
                CurrentTheme.Text

        end

        local FavoriteButton =
            self.FilterMenu:FindFirstChild(
                "Favorite"
            )

        if FavoriteButton then

            FavoriteButton.BackgroundColor3 =
                CurrentTheme.Button

            FavoriteButton.TextColor3 =
                CurrentTheme.Text

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Categories

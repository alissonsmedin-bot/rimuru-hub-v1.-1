--// 💥 RIMURU HUB
--// Categories System
--// ALL CATEGORY SYSTEM
--// FAVORITE FILTER
--// M1 FILTER
--// HIT FILTER
--// Dynamic All Sounds
--// ALL Always First
--// No Sound Duplication
--// Favorite Filter Compatible
--// Scrollable Filter Menu
--// SEARCH CONTEXT COMPATIBLE
--// FUTURE FILTER READY
--// CATEGORY CLICK SIZE ANIMATION
--// CLICK = +4 PIXELS
--// RETURN TO ORIGINAL AFTER 0.34s
--// CATEGORY CONTRAST SYSTEM
--// THEME AWARE
--// BLACKOUT = BLACK/WHITE INVERSION
--// OTHER THEMES = ORIGINAL BEHAVIOR
--// SUBTLE CATEGORY STROKES
--// THEME TEXT STROKE SUPPORT
--// PREMIUM VISUAL FINISH

local TweenService =
    game:GetService("TweenService")

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
-- VISUAL CONFIG
--==================================================

local NORMAL_STROKE_TRANSPARENCY =
    0.78

local SELECTED_STROKE_TRANSPARENCY =
    0.05

local FILTER_STROKE_TRANSPARENCY =
    0.20

local FILTER_OPTION_STROKE_TRANSPARENCY =
    0.78

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

    self.Search =
        Context.Search

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

    self.CategoryStrokes =
        {}

    --==================================================
    -- ALL SOUNDS
    --==================================================

    self.AllSounds =
        {}

    --==================================================
    -- CURRENT CATEGORY
    --==================================================

    self.CurrentCategory =
        "ALL"

    --==================================================
    -- FILTER STATE
    --==================================================

    self.CurrentFilter =
        "All"

    --==================================================
    -- FILTER UI
    --==================================================

    self.FilterButton =
        nil

    self.FilterMenu =
        nil

    self.FilterScroll =
        nil

    self.FilterStroke =
        nil

    --==================================================
    -- CATEGORY CLICK ANIMATION
    --==================================================

    self.CategoryClickAnimation =
        true

    self.CategoryClickHeight =
        4

    self.CategoryClickDuration =
        0.34

    self.CategoryClickExpandTime =
        0.07

    self.CategoryClickReturnTime =
        0.10

    --==================================================
    -- FILTER RESOLVERS
    --==================================================

    self.FilterResolvers = {

        ["All"] = function()

            self:BuildAllSounds()

            return self.AllSounds

        end,

        ["Favorite"] = function()

            return self:GetFavoriteSounds()

        end,

        ["M1"] = function()

            return self:GetM1Sounds()

        end,

        ["Hit"] = function()

            return self:GetHitSounds()

        end

    }

end

--==================================================
-- GET CATEGORY ICON
--==================================================

function Categories:GetIcon(
    CategoryName
)

    return CategoryIcons[CategoryName]
        or "📁"

end

--==================================================
-- GET TEXT STROKE
--==================================================

function Categories:ApplyTextStroke(
    Button
)

    if not Button
    or not self.Theme then

        return

    end

    local StrokeColor =
        self.Theme:GetTextStroke()

    local StrokeTransparency =
        self.Theme:GetTextStrokeTransparency()

    Button.TextStrokeColor3 =
        StrokeColor

    Button.TextStrokeTransparency =
        StrokeTransparency

end

--==================================================
-- CREATE CATEGORY STROKE
--==================================================

function Categories:CreateCategoryStroke(
    Button
)

    if not Button then
        return nil
    end

    local Stroke =
        Instance.new(
            "UIStroke"
        )

    Stroke.Name =
        "CategoryStroke"

    Stroke.Thickness =
        1

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Transparency =
        NORMAL_STROKE_TRANSPARENCY

    Stroke.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    Stroke.Parent =
        Button

    self.CategoryStrokes[
        Button
    ] =
        Stroke

    return Stroke

end

--==================================================
-- UPDATE CATEGORY STROKE
--==================================================

function Categories:UpdateCategoryStroke(
    Button,
    Selected
)

    if not Button
    or not self.Theme then

        return

    end

    local Stroke =
        self.CategoryStrokes[
            Button
        ]

    if not Stroke then

        Stroke =
            Button:FindFirstChild(
                "CategoryStroke"
            )

    end

    if not Stroke then
        return
    end

    if Selected then

        Stroke.Color =
            self.Theme:GetAccent()

        -- Blackout naturally becomes white.
        -- Void becomes purple.
        -- Crimson becomes red.
        -- Golden becomes gold.

        Stroke.Transparency =
            SELECTED_STROKE_TRANSPARENCY

    else

        Stroke.Color =
            self.Theme:GetAccent()

        Stroke.Transparency =
            NORMAL_STROKE_TRANSPARENCY

    end

end

--==================================================
-- SET NORMAL CATEGORY STYLE
--==================================================

function Categories:SetNormalStyle(
    Button
)

    if not Button then
        return
    end

    if not self.Theme then
        return
    end

    Button.BackgroundColor3 =
        self.Theme:GetNormalColor()

    Button.TextColor3 =
        self.Theme:GetNormalTextColor()

    self:ApplyTextStroke(
        Button
    )

    self:UpdateCategoryStroke(
        Button,
        false
    )

end

--==================================================
-- SET SELECTED CATEGORY STYLE
--==================================================

function Categories:SetSelectedStyle(
    Button
)

    if not Button then
        return
    end

    if not self.Theme then
        return
    end

    Button.BackgroundColor3 =
        self.Theme:GetSelectedColor()

    Button.TextColor3 =
        self.Theme:GetSelectedTextColor()

    self:ApplyTextStroke(
        Button
    )

    self:UpdateCategoryStroke(
        Button,
        true
    )

end

--==================================================
-- CATEGORY CLICK ANIMATION
--==================================================

function Categories:AnimateCategoryClick(
    Button
)

    if not Button
    or not Button.Parent then

        return

    end

    if self.CategoryClickAnimation == false then

        return

    end

    local OriginalSize =
        Button.Size

    local OriginalHeight =
        OriginalSize.Y.Offset

    local ExtraHeight =
        self.CategoryClickHeight or 4

    local Duration =
        self.CategoryClickDuration or 0.34

    local ExpandTime =
        self.CategoryClickExpandTime or 0.07

    local ReturnTime =
        self.CategoryClickReturnTime or 0.10

    local Token =
        (Button:GetAttribute(
            "CategoryAnimationToken"
        ) or 0) + 1

    Button:SetAttribute(
        "CategoryAnimationToken",
        Token
    )

    local ExpandedSize =
        UDim2.new(

            OriginalSize.X.Scale,
            OriginalSize.X.Offset,

            OriginalSize.Y.Scale,
            OriginalHeight + ExtraHeight

        )

    local ExpandTween =
        TweenService:Create(

            Button,

            TweenInfo.new(
                ExpandTime,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),

            {
                Size =
                    ExpandedSize
            }

        )

    ExpandTween:Play()

    task.delay(

        Duration,

        function()

            if not Button
            or not Button.Parent then

                return

            end

            if Button:GetAttribute(
                "CategoryAnimationToken"
            ) ~= Token then

                return

            end

            local ReturnTween =
                TweenService:Create(

                    Button,

                    TweenInfo.new(
                        ReturnTime,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        Size =
                            OriginalSize
                    }

                )

            ReturnTween:Play()

        end

    )

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

    for CategoryName, CategoryData in
        pairs(
            self.Sounds
        ) do

        if type(CategoryData) ==
            "table" then

            for _, SoundData in
                ipairs(CategoryData) do

                if type(SoundData) ==
                    "table" then

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
-- NOTIFY SEARCH
--==================================================

function Categories:NotifySearch()

    if self.Search
    and self.Search.OnContextChanged then

        self.Search:OnContextChanged()

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
        ipairs(
            self.AllSounds
        ) do

        if type(SoundData) ==
            "table" then

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
-- GET SOUND NAME
--==================================================

function Categories:GetSoundName(
    SoundData
)

    if type(SoundData) ~=
        "table" then

        return ""

    end

    return string.lower(
        tostring(
            SoundData[1]
            or ""
        )
    )

end

--==================================================
-- GENERIC NAME FILTER
--==================================================

function Categories:GetSoundsByName(
    SearchText
)

    local Result =
        {}

    self:BuildAllSounds()

    SearchText =
        string.lower(
            tostring(
                SearchText
                or ""
            )
        )

    if SearchText == "" then
        return Result
    end

    for _, SoundData in
        ipairs(
            self.AllSounds
        ) do

        if type(SoundData) ==
            "table" then

            local Name =
                self:GetSoundName(
                    SoundData
                )

            if string.find(
                Name,
                SearchText,
                1,
                true
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
-- GET M1 SOUNDS
--==================================================

function Categories:GetM1Sounds()

    return self:GetSoundsByName(
        "m1"
    )

end

--==================================================
-- GET HIT SOUNDS
--==================================================

function Categories:GetHitSounds()

    return self:GetSoundsByName(
        "hit"
    )

end

--==================================================
-- GET CURRENT SOUNDS
--==================================================

function Categories:GetCurrentSounds()

    if self.CurrentCategory ~= "ALL" then

        local Category =
            self.Sounds[
                self.CurrentCategory
            ]

        if type(Category) ==
            "table" then

            local Result =
                {}

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

            return Result

        end

    end

    local Resolver =
        self.FilterResolvers[
            self.CurrentFilter
        ]

    if Resolver then

        local Success, Result =
            pcall(
                Resolver
            )

        if Success
        and type(Result) ==
            "table" then

            return Result

        end

    end

    self:BuildAllSounds()

    return self.AllSounds

end

--==================================================
-- GET CURRENT CATEGORY
--==================================================

function Categories:GetCurrentCategory()

    return self.CurrentCategory

end

--==================================================
-- GET CURRENT FILTER
--==================================================

function Categories:GetCurrentFilter()

    return self.CurrentFilter

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

    elseif self.CurrentFilter ==
        "M1" then

        self.FilterButton.Text =
            "M1"

    elseif self.CurrentFilter ==
        "Hit" then

        self.FilterButton.Text =
            "Hit"

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
-- CREATE FILTER OPTION
--==================================================

function Categories:CreateFilterOption(

    Parent,

    Name,

    Text,

    Order,

    Callback

)

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Button =
        Instance.new(
            "TextButton"
        )

    Button.Name =
        Name

    Button.Size =
        UDim2.new(
            1,
            -10,
            0,
            32
        )

    Button.BackgroundColor3 =
        CurrentTheme.Button

    Button.BorderSizePixel =
        0

    Button.Text =
        Text

    Button.TextColor3 =
        CurrentTheme.Text

    Button.TextSize =
        11

    Button.Font =
        Enum.Font.GothamMedium

    Button.AutoButtonColor =
        false

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.LayoutOrder =
        Order

    Button.ZIndex =
        802

    Button.Parent =
        Parent

    --==================================================
    -- TEXT STROKE
    --==================================================

    self:ApplyTextStroke(
        Button
    )

    --==================================================
    -- OPTION STROKE
    --==================================================

    local OptionStroke =
        Instance.new(
            "UIStroke"
        )

    OptionStroke.Name =
        "OptionStroke"

    OptionStroke.Color =
        self.Theme:GetAccent()

    OptionStroke.Thickness =
        1

    OptionStroke.Transparency =
        FILTER_OPTION_STROKE_TRANSPARENCY

    OptionStroke.Parent =
        Button

    local Padding =
        Instance.new(
            "UIPadding"
        )

    Padding.PaddingLeft =
        UDim.new(
            0,
            9
        )

    Padding.Parent =
        Button

    local Corner =
        Instance.new(
            "UICorner"
        )

    Corner.CornerRadius =
        UDim.new(
            0,
            6
        )

    Corner.Parent =
        Button

    Button.MouseButton1Click:Connect(

        function()

            Callback()

        end

    )

    return Button

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

    local Menu =
        Instance.new(
            "Frame"
        )

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

    Menu.ClipsDescendants =
        true

    Menu.Parent =
        self.ContentTitle.Parent

    local MenuCorner =
        Instance.new(
            "UICorner"
        )

    MenuCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    MenuCorner.Parent =
        Menu

    local MenuStroke =
        Instance.new(
            "UIStroke"
        )

    MenuStroke.Name =
        "FilterMenuStroke"

    MenuStroke.Color =
        self.Theme:GetAccent()

    MenuStroke.Thickness =
        1

    MenuStroke.Transparency =
        FILTER_STROKE_TRANSPARENCY

    MenuStroke.Parent =
        Menu

    self.FilterMenu =
        Menu

    self.FilterStroke =
        MenuStroke

    local FilterScroll =
        Instance.new(
            "ScrollingFrame"
        )

    FilterScroll.Name =
        "FilterScroll"

    FilterScroll.Size =
        UDim2.new(
            1,
            -4,
            1,
            -4
        )

    FilterScroll.Position =
        UDim2.new(
            0,
            2,
            0,
            2
        )

    FilterScroll.BackgroundTransparency =
        1

    FilterScroll.BorderSizePixel =
        0

    FilterScroll.ScrollBarThickness =
        3

    FilterScroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    FilterScroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    FilterScroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    FilterScroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    FilterScroll.ZIndex =
        801

    FilterScroll.Parent =
        Menu

    self.FilterScroll =
        FilterScroll

    local Layout =
        Instance.new(
            "UIListLayout"
        )

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Padding =
        UDim.new(
            0,
            5
        )

    Layout.Parent =
        FilterScroll

    local Padding =
        Instance.new(
            "UIPadding"
        )

    Padding.PaddingTop =
        UDim.new(
            0,
            3
        )

    Padding.PaddingBottom =
        UDim.new(
            0,
            3
        )

    Padding.Parent =
        FilterScroll

    self:CreateFilterOption(
        FilterScroll,
        "All",
        "All",
        1,

        function()

            self:SetFilter(
                "All"
            )

            self:CloseFilterMenu()

        end
    )

    self:CreateFilterOption(
        FilterScroll,
        "Favorite",
        "★ Favorite",
        2,

        function()

            self:SetFilter(
                "Favorite"
            )

            self:CloseFilterMenu()

        end
    )

    self:CreateFilterOption(
        FilterScroll,
        "M1",
        "M1",
        3,

        function()

            self:SetFilter(
                "M1"
            )

            self:CloseFilterMenu()

        end
    )

    self:CreateFilterOption(
        FilterScroll,
        "Hit",
        "Hit",
        4,

        function()

            self:SetFilter(
                "Hit"
            )

            self:CloseFilterMenu()

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
        Instance.new(
            "TextButton"
        )

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

    self:ApplyTextStroke(
        Button
    )

    local Corner =
        Instance.new(
            "UICorner"
        )

    Corner.CornerRadius =
        UDim.new(
            0,
            7
        )

    Corner.Parent =
        Button

    local Stroke =
        Instance.new(
            "UIStroke"
        )

    Stroke.Name =
        "FilterButtonStroke"

    Stroke.Color =
        self.Theme:GetAccent()

    Stroke.Thickness =
        1

    Stroke.Transparency =
        FILTER_STROKE_TRANSPARENCY

    Stroke.Parent =
        Button

    self.FilterButton =
        Button

    self.FilterStroke =
        Stroke

    self:CreateFilterMenu()

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

    self.CurrentCategory =
        "ALL"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:ClearContent()

    self:BuildAllSounds()

    self.ContentTitle.Text =
        "ALL"

    if self.CurrentFilter ==
        "Favorite" then

        self:ShowFavorites()

        return

    end

    if self.CurrentFilter ==
        "M1" then

        self:ShowM1()

        return

    end

    if self.CurrentFilter ==
        "Hit" then

        self:ShowHit()

        return

    end

    for Index, Data in
        ipairs(
            self.AllSounds
        ) do

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

    self.CurrentCategory =
        "ALL"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:ClearContent()

    self.ContentTitle.Text =
        "ALL"

    local FavoriteSounds =
        self:GetFavoriteSounds()

    for Index, Data in
        ipairs(
            FavoriteSounds
        ) do

        self.Cards:CreateSoundCard(
            Index,
            Data
        )

    end

    self:NotifySearch()

end

--==================================================
-- SHOW M1
--==================================================

function Categories:ShowM1()

    self.CurrentCategory =
        "ALL"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:ClearContent()

    self.ContentTitle.Text =
        "ALL"

    local M1Sounds =
        self:GetM1Sounds()

    for Index, Data in
        ipairs(
            M1Sounds
        ) do

        self.Cards:CreateSoundCard(
            Index,
            Data
        )

    end

    self:NotifySearch()

end

--==================================================
-- SHOW HIT
--==================================================

function Categories:ShowHit()

    self.CurrentCategory =
        "ALL"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:ClearContent()

    self.ContentTitle.Text =
        "ALL"

    local HitSounds =
        self:GetHitSounds()

    for Index, Data in
        ipairs(
            HitSounds
        ) do

        self.Cards:CreateSoundCard(
            Index,
            Data
        )

    end

    self:NotifySearch()

end

--==================================================
-- SHOW CATEGORY
--==================================================

function Categories:ShowCategory(
    CategoryName
)

    if CategoryName == "ALL" then

        self.CurrentCategory =
            "ALL"

        self.CurrentFilter =
            "All"

        self:UpdateFilterButton()

        self:ShowAll()

        return

    end

    self.CurrentCategory =
        CategoryName

    self.CurrentFilter =
        "All"

    self:UpdateFilterButton()

    if self.FilterButton then

        self.FilterButton.Visible =
            false

    end

    self:CloseFilterMenu()

    self:ClearContent()

    self.ContentTitle.Text =
        CategoryName

    local Category =
        self.Sounds[
            CategoryName
        ]

    if not Category then

        self:NotifySearch()

        return

    end

    for Index, Data in
        ipairs(Category) do

        self.Cards:CreateSoundCard(
            Index,
            Data
        )

    end

    self:NotifySearch()

end

--==================================================
-- SELECT BUTTON
--==================================================

function Categories:SelectButton(
    Button
)

    if not Button then
        return
    end

    if self.SelectedButton
    and self.SelectedButton ~= Button then

        self:SetNormalStyle(
            self.SelectedButton
        )

    end

    self.SelectedButton =
        Button

    self:SetSelectedStyle(
        Button
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

    --==================================================
    -- NORMAL STYLE
    --==================================================

    self:SetNormalStyle(
        Button
    )

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
    -- STROKE
    --==================================================

    self:CreateCategoryStroke(
        Button
    )

    -- Reaplica depois do stroke para garantir
    -- que o estado inicial fique correto.

    self:SetNormalStyle(
        Button
    )

    --==================================================
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(

        function()

            self:SelectButton(
                Button
            )

            self:AnimateCategoryClick(
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
    -- ALL FIRST
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
    -- SOUND CATEGORIES
    --==================================================

    for CategoryName in
        pairs(
            self.Sounds
        ) do

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
    -- FILTER
    --==================================================

    self:CreateFilterButton()

    return CategoryIndex + 1

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

function Categories:SetDefaultCategory()

    local AllButton =
        self.CategoryButtons[
            "ALL"
        ]

    if not AllButton then
        return
    end

    self.CurrentCategory =
        "ALL"

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
-- SET FILTER
--==================================================

function Categories:SetFilter(
    FilterName
)

    if not self.FilterResolvers[
        FilterName
    ] then

        return

    end

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        FilterName

    self:UpdateFilterButton()

    if FilterName ==
        "Favorite" then

        self:ShowFavorites()

    elseif FilterName ==
        "M1" then

        self:ShowM1()

    elseif FilterName ==
        "Hit" then

        self:ShowHit()

    else

        self:ShowAll()

    end

end

--==================================================
-- ADD FUTURE FILTER
--==================================================

function Categories:RegisterFilter(
    FilterName,
    Resolver
)

    if type(FilterName) ~=
        "string" then

        return false

    end

    if type(Resolver) ~=
        "function" then

        return false

    end

    self.FilterResolvers[
        FilterName
    ] =
        Resolver

    return true

end

--==================================================
-- REFRESH CURRENT CONTENT
--==================================================

function Categories:RefreshCurrent()

    if self.CurrentCategory ~=
        "ALL" then

        self:ShowCategory(
            self.CurrentCategory
        )

        return

    end

    if self.CurrentFilter ==
        "Favorite" then

        self:ShowFavorites()

        return

    end

    if self.CurrentFilter ==
        "M1" then

        self:ShowM1()

        return

    end

    if self.CurrentFilter ==
        "Hit" then

        self:ShowHit()

        return

    end

    self:ShowAll()

end

--==================================================
-- APPLY THEME
--==================================================

function Categories:ApplyTheme()

    if not self.Theme then
        return
    end

    --==================================================
    -- CATEGORY BUTTONS
    --==================================================

    for _, Button in
        pairs(
            self.CategoryButtons
        ) do

        if Button ==
            self.SelectedButton then

            self:SetSelectedStyle(
                Button
            )

        else

            self:SetNormalStyle(
                Button
            )

        end

    end

    --==================================================
    -- FILTER BUTTON
    --==================================================

    if self.FilterButton then

        local CurrentTheme =
            self.Theme:GetCurrent()

        self.FilterButton.BackgroundColor3 =
            CurrentTheme.Button

        self.FilterButton.TextColor3 =
            CurrentTheme.Text

        self:ApplyTextStroke(
            self.FilterButton
        )

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

        local CurrentTheme =
            self.Theme:GetCurrent()

        self.FilterMenu.BackgroundColor3 =
            CurrentTheme.Content

        local MenuStroke =
            self.FilterMenu:FindFirstChild(
                "FilterMenuStroke"
            )

        if MenuStroke then

            MenuStroke.Color =
                self.Theme:GetAccent()

        end

    end

    --==================================================
    -- FILTER OPTIONS
    --==================================================

    if self.FilterScroll then

        self.FilterScroll.ScrollBarImageColor3 =
            self.Theme:GetAccent()

        local CurrentTheme =
            self.Theme:GetCurrent()

        for _, Button in
            ipairs(
                self.FilterScroll:GetChildren()
            ) do

            if Button:IsA(
                "TextButton"
            ) then

                Button.BackgroundColor3 =
                    CurrentTheme.Button

                Button.TextColor3 =
                    CurrentTheme.Text

                self:ApplyTextStroke(
                    Button
                )

                local Stroke =
                    Button:FindFirstChild(
                        "OptionStroke"
                    )

                if Stroke then

                    Stroke.Color =
                        self.Theme:GetAccent()

                end

            end

        end

    end

end

--==================================================
-- RETURN MODULE
--==================================================

return Categories

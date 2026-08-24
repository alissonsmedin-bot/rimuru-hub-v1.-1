--// 💥 RIMURU HUB
--// Categories System
--// UPDATED SOUND CATEGORY SYSTEM
--// ONLY CURRENT SOUND DATABASE
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
--// CONFIGURATION CONTEXT FIX
--// CONFIGURATION CLEANUP FIX
--// CONFIGURATION EXIT FIX
--// SEARCH CLEAR ON CATEGORY CHANGE
--// SAFE CONTEXT SWITCHING
--// SOUND DATABASE COMPATIBILITY FIX
--// ALL SOUND COLLECTION FIX
--// PREVENT CONFIGURATION MIXING
--// SAFE RAPID CATEGORY SWITCHING
--// OUTROS EXCLUDED
--// NO UNKNOWN / EMPTY CATEGORY
--// CATEGORY ORDER STABILIZED

local TweenService = game:GetService("TweenService")

local Categories = {}

--==================================================
-- CATEGORY ICONS
--==================================================

local CategoryIcons = {

    ["ALL"] = "🏠",

    ["Configuração"] = "⚙️",

    -- Jujutsu / JJS
    ["Gojo"] = "🔵",
    ["Sukuna"] = "👹",
    ["Heian Sukuna Sounds"] = "👹",
    ["Mahoraga"] = "☸️",
    ["Melee"] = "⚔️",

    -- Fallback
    ["Outros"] = "📁",
    ["Outro"] = "📁"

}

--==================================================
-- EXCLUDED CATEGORIES
--==================================================
-- Essas categorias NÃO serão criadas na interface
-- e também não serão adicionadas ao ALL.
--
-- Atualmente "Outros" será ignorado porque os sons
-- dessa categoria serão adicionados posteriormente.

local ExcludedCategories = {

    ["Outros"] = true,
    ["Outro"] = true,
    ["Configuração"] = true,
    ["ALL"] = true

}

--==================================================
-- INIT
--==================================================

function Categories:Init(Context)

    Context = Context or {}

    self.Context = Context

    self.Config = Context.Config
    self.Sounds = Context.Sounds
    self.Theme = Context.Theme
    self.UI = Context.UI
    self.Cards = Context.Cards
    self.Favorites = Context.Favorites
    self.Search = Context.Search
    self.Settings = Context.Settings

    if self.UI then

        self.Sidebar =
            self.UI.Sidebar

        self.Scroll =
            self.UI.Scroll

        self.ContentTitle =
            self.UI.ContentTitle

    end

    self.SelectedButton = nil

    self.CategoryButtons = {}

    self.AllSounds = {}

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        "All"

    --==================================================
    -- CONTEXT
    --==================================================

    self.CurrentContext =
        "NORMAL"

    self.ContextSwitchToken =
        0

    self.FilterButton = nil
    self.FilterMenu = nil
    self.FilterScroll = nil
    self.FilterStroke = nil

    --==================================================
    -- CLICK ANIMATION
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

            return self:BuildAllSounds()

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

function Categories:GetIcon(CategoryName)

    return CategoryIcons[
        CategoryName
    ] or "📁"

end

--==================================================
-- CHECK EXCLUDED CATEGORY
--==================================================

function Categories:IsExcludedCategory(
    CategoryName
)

    if type(CategoryName) ~= "string" then
        return true
    end

    return ExcludedCategories[
        CategoryName
    ] == true

end

--==================================================
-- VALID CATEGORY
--==================================================

function Categories:IsValidCategory(
    CategoryName,
    CategoryData
)

    if type(CategoryName) ~= "string" then
        return false
    end

    if self:IsExcludedCategory(
        CategoryName
    ) then

        return false

    end

    if type(CategoryData) ~= "table" then
        return false
    end

    return true

end

--==================================================
-- NORMAL CATEGORY STYLE
--==================================================

function Categories:SetNormalStyle(Button)

    if not Button then
        return
    end

    if not self.Theme then
        return
    end

    if type(self.Theme.GetNormalColor)
        ~= "function" then

        return

    end

    local Success, Color =
        pcall(function()

            return self.Theme:GetNormalColor()

        end)

    if Success and Color then

        Button.BackgroundColor3 =
            Color

    end

    if type(
        self.Theme.GetNormalTextColor
    ) == "function" then

        local TextSuccess,
            TextColor =
            pcall(function()

                return self.Theme:
                    GetNormalTextColor()

            end)

        if TextSuccess
        and TextColor then

            Button.TextColor3 =
                TextColor

        end

    end

end

--==================================================
-- SELECTED CATEGORY STYLE
--==================================================

function Categories:SetSelectedStyle(Button)

    if not Button then
        return
    end

    if not self.Theme then
        return
    end

    if type(
        self.Theme.GetSelectedColor
    ) ~= "function" then

        return

    end

    local Success, Color =
        pcall(function()

            return self.Theme:GetSelectedColor()

        end)

    if Success and Color then

        Button.BackgroundColor3 =
            Color

    end

    if type(
        self.Theme.GetSelectedTextColor
    ) == "function" then

        local TextSuccess,
            TextColor =
            pcall(function()

                return self.Theme:
                    GetSelectedTextColor()

            end)

        if TextSuccess
        and TextColor then

            Button.TextColor3 =
                TextColor

        end

    end

end

--==================================================
-- INVALIDATE OLD CONTEXT
--==================================================

function Categories:InvalidateContext()

    self.ContextSwitchToken =
        (self.ContextSwitchToken or 0) + 1

    return self.ContextSwitchToken

end

--==================================================
-- HIDE CONFIGURATION
--==================================================

function Categories:HideConfiguration()

    if self.CurrentContext ==
        "CONFIGURATION" then

        self.CurrentContext =
            "NORMAL"

    end

    if self.Settings then

        if type(
            self.Settings.CloseThemePopup
        ) == "function" then

            pcall(function()

                self.Settings:
                    CloseThemePopup()

            end)

        end

        if type(
            self.Settings.Hide
        ) == "function" then

            pcall(function()

                self.Settings:Hide()

            end)

        end

        if type(
            self.Settings.ToggleButtons
        ) == "table" then

            self.Settings.ToggleButtons =
                {}

        end

        self.Settings.ThemeButton =
            nil

    end

    self:ClearContent()

end

--==================================================
-- ENTER CONFIGURATION
--==================================================

function Categories:EnterConfiguration()

    local Token =
        self:InvalidateContext()

    self.CurrentContext =
        "CONFIGURATION"

    self.CurrentCategory =
        "Configuração"

    self.CurrentFilter =
        "All"

    self:ClearSearchContext()

    self:CloseFilterMenu()

    if self.FilterButton then

        self.FilterButton.Visible =
            false

    end

    self:ClearContent()

    if self.ContentTitle then

        self.ContentTitle.Text =
            "Configuração"

    end

    if self.Settings
    and type(
        self.Settings.Show
    ) == "function" then

        pcall(function()

            self.Settings:Show()

        end)

    end

    if Token ~=
        self.ContextSwitchToken then

        return false

    end

    return true

end

--==================================================
-- LEAVE CONFIGURATION
--==================================================

function Categories:LeaveConfiguration()

    if self.CurrentContext ~=
        "CONFIGURATION"
    and self.CurrentCategory ~=
        "Configuração" then

        return

    end

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    if self.Settings
    and type(
        self.Settings.CloseThemePopup
    ) == "function" then

        pcall(function()

            self.Settings:
                CloseThemePopup()

        end)

    end

    if self.Settings then

        if type(
            self.Settings.ToggleButtons
        ) == "table" then

            self.Settings.ToggleButtons =
                {}

        end

        self.Settings.ThemeButton =
            nil

    end

    self:ClearContent()

end

--==================================================
-- CATEGORY CLICK ANIMATION
--==================================================

function Categories:AnimateCategoryClick(Button)

    if not Button
    or not Button.Parent then

        return

    end

    if self.CategoryClickAnimation ==
        false then

        return

    end

    local OriginalSize =
        Button.Size

    local ExtraHeight =
        self.CategoryClickHeight
        or 4

    local Duration =
        self.CategoryClickDuration
        or 0.34

    local ExpandTime =
        self.CategoryClickExpandTime
        or 0.07

    local ReturnTime =
        self.CategoryClickReturnTime
        or 0.10

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
            OriginalSize.Y.Offset
                + ExtraHeight

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
                Size = ExpandedSize
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
                        Size = OriginalSize
                    }

                )

            ReturnTween:Play()

        end
    )

end

--==================================================
-- VALID SOUND DATA
--==================================================

function Categories:IsValidSoundData(
    SoundData
)

    if type(SoundData) ~= "table" then
        return false
    end

    if type(SoundData[1]) ~= "string" then
        return false
    end

    if SoundData[1] == "" then
        return false
    end

    if SoundData[2] == nil then
        return false
    end

    return true

end

--==================================================
-- GET SORTED SOUND CATEGORIES
--==================================================

function Categories:GetSoundCategoryNames()

    local Result = {}

    if type(self.Sounds) ~= "table" then

        return Result

    end

    for CategoryName,
        CategoryData in pairs(
            self.Sounds
        ) do

        if self:IsValidCategory(
            CategoryName,
            CategoryData
        ) then

            table.insert(
                Result,
                CategoryName
            )

        end

    end

    table.sort(
        Result,
        function(A, B)

            --==================================================
            -- PRIORITY CATEGORIES
            --==================================================

            local Priority = {

                ["Gojo"] = 1,
                ["Sukuna"] = 2,
                ["Heian Sukuna Sounds"] = 3,
                ["Mahoraga"] = 4,
                ["Melee"] = 5

            }

            local PA =
                Priority[A]

            local PB =
                Priority[B]

            if PA and PB then

                return PA < PB

            end

            if PA then
                return true
            end

            if PB then
                return false
            end

            --==================================================
            -- ALPHABETICAL
            --==================================================

            return string.lower(
                tostring(A)
            ) <
            string.lower(
                tostring(B)
            )

        end
    )

    return Result

end

--==================================================
-- BUILD ALL SOUNDS
--==================================================

function Categories:BuildAllSounds()

    self.AllSounds = {}

    if type(self.Sounds) ~= "table" then

        return self.AllSounds

    end

    local SeenIDs = {}

    local CategoryNames =
        self:GetSoundCategoryNames()

    for _, CategoryName in ipairs(
        CategoryNames
    ) do

        local CategoryData =
            self.Sounds[
                CategoryName
            ]

        if type(CategoryData) == "table" then

            for _, SoundData in ipairs(
                CategoryData
            ) do

                if self:IsValidSoundData(
                    SoundData
                ) then

                    local SoundID =
                        tostring(
                            SoundData[2]
                        )

                    --==================================================
                    -- NO DUPLICATION
                    --==================================================

                    if not SeenIDs[
                        SoundID
                    ] then

                        SeenIDs[
                            SoundID
                        ] = true

                        table.insert(
                            self.AllSounds,
                            SoundData
                        )

                    end

                end

            end

        end

    end

    return self.AllSounds

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Categories:ClearContent()

    if not self.Scroll then
        return
    end

    for _, Object in ipairs(
        self.Scroll:GetChildren()
    ) do

        if not Object:IsA(
            "UIListLayout"
        )
        and not Object:IsA(
            "UIPadding"
        )
        and not Object:IsA(
            "UIGridLayout"
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
    and type(
        self.Search.OnContextChanged
    ) == "function" then

        task.defer(function()

            pcall(function()

                self.Search:
                    OnContextChanged()

            end)

        end)

    end

end

--==================================================
-- CLEAR SEARCH CONTEXT
--==================================================

function Categories:ClearSearchContext()

    if self.Search
    and type(
        self.Search.ClearForContext
    ) == "function" then

        pcall(function()

            self.Search:
                ClearForContext()

        end)

    end

end

--==================================================
-- GET FAVORITES
--==================================================

function Categories:GetFavoriteSounds()

    local Result = {}

    if not self.Favorites then
        return Result
    end

    local AllSounds =
        self:BuildAllSounds()

    if type(
        self.Favorites.IsFavorite
    ) ~= "function" then

        return Result

    end

    for _, SoundData in ipairs(
        AllSounds
    ) do

        if self:IsValidSoundData(
            SoundData
        ) then

            local ID =
                SoundData[2]

            local Success,
                IsFavorite =
                pcall(function()

                    return self.Favorites:
                        IsFavorite(ID)

                end)

            if Success
            and IsFavorite == true then

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

    if not self:IsValidSoundData(
        SoundData
    ) then

        return ""

    end

    return string.lower(
        tostring(
            SoundData[1]
        )
    )

end

--==================================================
-- GET SOUNDS BY NAME
--==================================================

function Categories:GetSoundsByName(
    SearchText
)

    local Result = {}

    SearchText =
        string.lower(
            tostring(
                SearchText or ""
            )
        )

    if SearchText == "" then

        return Result

    end

    local AllSounds =
        self:BuildAllSounds()

    for _, SoundData in ipairs(
        AllSounds
    ) do

        if self:IsValidSoundData(
            SoundData
        ) then

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
-- M1
--==================================================

function Categories:GetM1Sounds()

    return self:GetSoundsByName(
        "m1"
    )

end

--==================================================
-- HIT
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

    if self.CurrentCategory ==
        "Configuração" then

        return {}

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    if self.CurrentCategory ~=
        "ALL" then

        local Category =
            self.Sounds
            and self.Sounds[
                self.CurrentCategory
            ]

        if type(Category) == "table" then

            local Result = {}

            local SeenIDs = {}

            for _, Data in ipairs(
                Category
            ) do

                if self:IsValidSoundData(
                    Data
                ) then

                    local ID =
                        tostring(
                            Data[2]
                        )

                    if not SeenIDs[
                        ID
                    ] then

                        SeenIDs[ID] =
                            true

                        table.insert(
                            Result,
                            Data
                        )

                    end

                end

            end

            return Result

        end

        return {}

    end

    --==================================================
    -- ALL FILTER
    --==================================================

    local Resolver =
        self.FilterResolvers[
            self.CurrentFilter
        ]

    if type(Resolver) == "function" then

        local Success,
            Result =
            pcall(Resolver)

        if Success
        and type(Result) == "table" then

            return Result

        end

    end

    return self:BuildAllSounds()

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

    local Labels = {

        ["All"] = "All",

        ["Favorite"] =
            "★ Favorite",

        ["M1"] = "M1",

        ["Hit"] = "Hit"

    }

    self.FilterButton.Text =
        Labels[
            self.CurrentFilter
        ]
        or "All"

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

    if not Parent then
        return nil
    end

    if not self.Theme then
        return nil
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Button =
        Instance.new("TextButton")

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

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(
            0,
            9
        )

    Padding.Parent =
        Button

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            6
        )

    Corner.Parent =
        Button

    Button.MouseButton1Click:Connect(
        function()

            if type(Callback)
                == "function" then

                Callback()

            end

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

    if not self.ContentTitle then
        return
    end

    if not self.Theme then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Parent =
        self.ContentTitle.Parent

    if not Parent then
        return
    end

    local Menu =
        Instance.new("Frame")

    Menu.Name =
        "FilterMenu"

    Menu.Size =
        UDim2.new(
            0,
            120,
            0,
            112
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
        Parent

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

    self.FilterStroke =
        MenuStroke

    --==================================================
    -- SCROLL
    --==================================================

    local FilterScroll =
        Instance.new("ScrollingFrame")

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
        Instance.new("UIListLayout")

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
        Instance.new("UIPadding")

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

    --==================================================
    -- OPTIONS
    --==================================================

    local Options = {

        {
            "All",
            "All",
            1
        },

        {
            "Favorite",
            "★ Favorite",
            2
        },

        {
            "M1",
            "M1",
            3
        },

        {
            "Hit",
            "Hit",
            4
        }

    }

    for _, Option in ipairs(
        Options
    ) do

        self:CreateFilterOption(

            FilterScroll,

            Option[1],

            Option[2],

            Option[3],

            function()

                self:SetFilter(
                    Option[1]
                )

                self:CloseFilterMenu()

            end

        )

    end

end

--==================================================
-- CREATE FILTER BUTTON
--==================================================

function Categories:CreateFilterButton()

    if self.FilterButton then
        return
    end

    if not self.ContentTitle then
        return
    end

    if not self.Theme then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Parent =
        self.ContentTitle.Parent

    if not Parent then
        return
    end

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
-- CREATE CARDS FROM DATA
--==================================================

function Categories:RenderSounds(
    Sounds
)

    self:LeaveConfiguration()

    self:ClearContent()

    if not self.Cards
    or type(
        self.Cards.CreateSoundCard
    ) ~= "function" then

        warn(
            "[RIMURU HUB] Cards.CreateSoundCard não está disponível."
        )

        return

    end

    if type(Sounds) ~= "table" then
        return
    end

    local CardIndex =
        0

    local RenderedIDs = {}

    for _, Data in ipairs(
        Sounds
    ) do

        if self:IsValidSoundData(
            Data
        ) then

            local ID =
                tostring(
                    Data[2]
                )

            if not RenderedIDs[
                ID
            ] then

                RenderedIDs[
                    ID
                ] = true

                CardIndex += 1

                self.Cards:
                    CreateSoundCard(
                        CardIndex,
                        Data
                    )

            end

        end

    end

end

--==================================================
-- SHOW ALL
--==================================================

function Categories:ShowAll()

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        "All"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:UpdateFilterButton()

    if self.ContentTitle then

        self.ContentTitle.Text =
            "ALL"

    end

    local Sounds =
        self:GetCurrentSounds()

    self:RenderSounds(
        Sounds
    )

    self:NotifySearch()

end

--==================================================
-- SHOW FAVORITES
--==================================================

function Categories:ShowFavorites()

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        "Favorite"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:UpdateFilterButton()

    if self.ContentTitle then

        self.ContentTitle.Text =
            "ALL"

    end

    local Sounds =
        self:GetFavoriteSounds()

    self:RenderSounds(
        Sounds
    )

    self:NotifySearch()

end

--==================================================
-- SHOW M1
--==================================================

function Categories:ShowM1()

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        "M1"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:UpdateFilterButton()

    if self.ContentTitle then

        self.ContentTitle.Text =
            "ALL"

    end

    local Sounds =
        self:GetM1Sounds()

    self:RenderSounds(
        Sounds
    )

    self:NotifySearch()

end

--==================================================
-- SHOW HIT
--==================================================

function Categories:ShowHit()

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        "Hit"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    self:UpdateFilterButton()

    if self.ContentTitle then

        self.ContentTitle.Text =
            "ALL"

    end

    local Sounds =
        self:GetHitSounds()

    self:RenderSounds(
        Sounds
    )

    self:NotifySearch()

end

--==================================================
-- SHOW CATEGORY
--==================================================

function Categories:ShowCategory(
    CategoryName
)

    if type(CategoryName) ~= "string" then
        return
    end

    --==================================================
    -- CONFIGURATION
    --==================================================

    if CategoryName ==
        "Configuração" then

        self:EnterConfiguration()

        return

    end

    --==================================================
    -- INVALID / EXCLUDED CATEGORY
    --==================================================

    if CategoryName ~=
        "ALL"
    and self:IsExcludedCategory(
        CategoryName
    ) then

        return

    end

    --==================================================
    -- LEAVE CONFIGURATION
    --==================================================

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self:ClearSearchContext()

    --==================================================
    -- ALL
    --==================================================

    if CategoryName ==
        "ALL" then

        self.CurrentCategory =
            "ALL"

        self.CurrentFilter =
            "All"

        self:UpdateFilterButton()

        self:ShowAll()

        return

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

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

    if self.ContentTitle then

        self.ContentTitle.Text =
            CategoryName

    end

    local Category =
        self.Sounds
        and self.Sounds[
            CategoryName
        ]

    if type(Category) ~= "table" then

        self:ClearContent()

        self:NotifySearch()

        return

    end

    self:RenderSounds(
        Category
    )

    self:NotifySearch()

end

--==================================================
-- SHOW CONFIGURATION
--==================================================

function Categories:ShowConfiguration()

    self:EnterConfiguration()

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

    if not self.Sidebar then
        return nil
    end

    local Button =
        Instance.new("TextButton")

    Button.Name =
        CategoryName

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            38
        )

    self:SetNormalStyle(
        Button
    )

    Button.BorderSizePixel =
        0

    Button.Text =
        self:GetIcon(
            CategoryName
        )
        .. "  "
        .. CategoryName

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

    local ButtonPadding =
        Instance.new("UIPadding")

    ButtonPadding.PaddingLeft =
        UDim.new(
            0,
            10
        )

    ButtonPadding.Parent =
        Button

    local ButtonCorner =
        Instance.new("UICorner")

    ButtonCorner.CornerRadius =
        UDim.new(
            0,
            7
        )

    ButtonCorner.Parent =
        Button

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

                return

            end

            if CategoryName ==
                "Configuração" then

                self:ShowConfiguration()

            else

                self:LeaveConfiguration()

                self:ClearSearchContext()

                if self.FilterButton then

                    self.FilterButton.Visible =
                        false

                end

                self:CloseFilterMenu()

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

    --==================================================
    -- CLEAN OLD BUTTONS
    --==================================================

    for _, Button in pairs(
        self.CategoryButtons
    ) do

        if Button
        and Button.Parent then

            Button:Destroy()

        end

    end

    self.CategoryButtons =
        {}

    self.SelectedButton =
        nil

    local CategoryIndex =
        0

    --==================================================
    -- ALL ALWAYS FIRST
    --==================================================

    CategoryIndex += 1

    self.AllButton =
        self:CreateCategoryButton(
            "ALL",
            CategoryIndex,
            true
        )

    --==================================================
    -- SOUND CATEGORIES
    --==================================================

    local SoundCategoryNames =
        self:GetSoundCategoryNames()

    for _, CategoryName in ipairs(
        SoundCategoryNames
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

    self.ConfigButton =
        self:CreateCategoryButton(

            "Configuração",

            CategoryIndex + 1,

            false

        )

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

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

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

    return self:BuildAllSounds()

end

--==================================================
-- GET ALL SOUND COUNT
--==================================================

function Categories:GetAllSoundCount()

    return #self:BuildAllSounds()

end

--==================================================
-- GET FAVORITE COUNT
--==================================================

function Categories:GetFavoriteSoundCount()

    return #self:GetFavoriteSounds()

end

--==================================================
-- SET FILTER
--==================================================

function Categories:SetFilter(
    FilterName
)

    if type(FilterName) ~= "string" then
        return
    end

    if not self.FilterResolvers[
        FilterName
    ] then

        return

    end

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        FilterName

    self:ClearSearchContext()

    self:UpdateFilterButton()

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

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
-- REGISTER FUTURE FILTER
--==================================================

function Categories:RegisterFilter(
    FilterName,
    Resolver
)

    if type(FilterName) ~= "string" then
        return false
    end

    if type(Resolver) ~= "function" then
        return false
    end

    self.FilterResolvers[
        FilterName
    ] =
        Resolver

    return true

end

--==================================================
-- REFRESH CURRENT
--==================================================

function Categories:RefreshCurrent()

    --==================================================
    -- CONFIGURATION
    --==================================================

    if self.CurrentCategory ==
        "Configuração" then

        self:EnterConfiguration()

        return

    end

    --==================================================
    -- NORMAL CONTEXT
    --==================================================

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    if self.CurrentCategory ~=
        "ALL" then

        local Category =
            self.Sounds
            and self.Sounds[
                self.CurrentCategory
            ]

        if type(Category) == "table" then

            if self.ContentTitle then

                self.ContentTitle.Text =
                    self.CurrentCategory

            end

            self:RenderSounds(
                Category
            )

            return

        end

    end

    --==================================================
    -- ALL / FILTER
    --==================================================

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

    for _, Button in pairs(
        self.CategoryButtons
    ) do

        if Button
        and Button.Parent then

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
            self.FilterMenu:
                FindFirstChildOfClass(
                    "UIStroke"
                )

        if MenuStroke then

            MenuStroke.Color =
                self.Theme:GetAccent()

        end

    end

    --==================================================
    -- FILTER SCROLL
    --==================================================

    if self.FilterScroll then

        self.FilterScroll:
            ScrollBarImageColor3 =
            self.Theme:GetAccent()

        local CurrentTheme =
            self.Theme:GetCurrent()

        for _, Button in ipairs(
            self.FilterScroll:GetChildren()
        ) do

            if Button:IsA(
                "TextButton"
            ) then

                Button.BackgroundColor3 =
                    CurrentTheme.Button

                Button.TextColor3 =
                    CurrentTheme.Text

            end

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Categories

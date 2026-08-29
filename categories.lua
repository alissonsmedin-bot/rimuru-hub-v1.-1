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
--// SCROLLABLE CATEGORY LIST
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
--// SAFE CATEGORY SCROLL SYSTEM
--// OUTRO CATEGORY REMOVED
--// OUTROS CATEGORY FIX
--// CHARACTER CATEGORY ICONS
--// CATEGORY IMAGE SYSTEM
--// CATEGORY IMAGE FALLBACK
--// FUTURE CATEGORY IMAGE READY
--// IMAGE / TEXT SEPARATION FIX
--// MEGUMI IMAGE
--// CHOSO IMAGE
--// GOJO IMAGE
--// MAHORAGA IMAGE
--// CATEGORY SIZE INCREASE
--// GOJO IMAGE 10% SMALLER

local TweenService = game:GetService("TweenService")

local Categories = {}

--==================================================
-- CATEGORY ICONS
--==================================================

local CategoryIcons = {

    --==================================================
    -- MAIN
    --==================================================

    ["ALL"] = "🏠",

    --==================================================
    -- UTILITY
    --==================================================

    ["Outros"] = "📁",

    --==================================================
    -- CHARACTERS
    --==================================================

    ["Power"] = "⚡",

    ["Megumi"] = "🐺",

    ["Choso"] = "🩸",

    ["Gojo"] = "🔵",

    ["Goku"] = "🟠",

    ["Hakari"] = "🎰",

    ["Hanami"] = "🌺",

    ["Haruta"] = "🗡️",

    ["Heian Sukuna Sounds"] = "👹",

    ["Mahoraga"] = "⚙️",

    ["Mangaka"] = "✒️",

    --==================================================
    -- OTHER
    --==================================================

    ["Kill Sound"] = "💀",

    --==================================================
    -- CONFIG
    --==================================================

    ["Configuração"] = "⚙️"

}

--==================================================
-- CATEGORY IMAGES
--==================================================

local CategoryImages = {

    --==================================================
    -- MEGUMI
    --==================================================

    ["Megumi"] = {

        URL =
            "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/1000087286-removebg-preview.png",

        PATH =
            "MegumiLogo.png",

        -- Tamanho normal
        Scale =
            1.3

    },

    --==================================================
    -- CHOSO
    --==================================================

    ["Choso"] = {

        URL =
            "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/1000087282-removebg-preview.png",

        PATH =
            "ChosoLogo.png",

        -- Tamanho normal
        Scale =
            1.69

    },

    --==================================================
    -- GOJO
    --==================================================

    ["Gojo"] = {

        URL =
            "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/1000087038-removebg-preview%20(1).png",

        PATH =
            "GojoLogo.png",

        -- GOJO 10% MENOR
        Scale =
            0.85

    },

    --==================================================
    -- MAHORAGA
    --==================================================

    ["Mahoraga"] = {

        URL =
            "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/1000087390-removebg-preview.png",

        PATH =
            "MahoragaLogo.png",

        -- TAMANHO NORMAL = 30x30
        Scale =
            1.13

    }

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

        self.Sidebar = self.UI.Sidebar
        self.Scroll = self.UI.Scroll
        self.ContentTitle = self.UI.ContentTitle

    end

    self.SelectedButton = nil
    self.CategoryButtons = {}

    self.AllSounds = {}

    self.CurrentCategory = "ALL"
    self.CurrentFilter = "All"

    --==================================================
    -- CATEGORY SCROLL
    --==================================================

    self.CategoryScroll = nil
    self.CategoryScrollLayout = nil
    self.CategoryScrollPadding = nil

    --==================================================
    -- CONTEXT
    --==================================================

    self.CurrentContext = "NORMAL"

    self.ContextSwitchToken = 0

    self.FilterButton = nil
    self.FilterMenu = nil
    self.FilterScroll = nil
    self.FilterStroke = nil

    --==================================================
    -- CLICK ANIMATION
    --==================================================

    self.CategoryClickAnimation = true

    self.CategoryClickHeight = 4

    self.CategoryClickDuration = 0.34

    self.CategoryClickExpandTime = 0.07

    self.CategoryClickReturnTime = 0.10

    --==================================================
    -- CATEGORY SIZE
    --==================================================

    self.CategoryHeight = 40

    self.CategoryImageSize = 30

    self.CategoryImageLeft = 7

    self.CategoryTextLeft = 44

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

    --==================================================
    -- CATEGORY SCROLL SETUP
    --==================================================

    self:SetupCategoryScroll()

end

--==================================================
-- SETUP CATEGORY SCROLL
--==================================================

function Categories:SetupCategoryScroll()

    if not self.Sidebar then
        return
    end

    --==================================================
    -- IF SIDEBAR IS ALREADY A SCROLLING FRAME
    --==================================================

    if self.Sidebar:IsA("ScrollingFrame") then

        self.CategoryScroll = self.Sidebar

    else

        --==================================================
        -- CHECK FOR EXISTING CATEGORY SCROLL
        --==================================================

        local ExistingScroll =
            self.Sidebar:FindFirstChild(
                "CategoryScroll"
            )

        if ExistingScroll
        and ExistingScroll:IsA("ScrollingFrame") then

            self.CategoryScroll =
                ExistingScroll

        else

            --==================================================
            -- CREATE CATEGORY SCROLL
            --==================================================

            local ScrollFrame =
                Instance.new("ScrollingFrame")

            ScrollFrame.Name =
                "CategoryScroll"

            ScrollFrame.Size =
                UDim2.new(
                    1,
                    0,
                    1,
                    0
                )

            ScrollFrame.Position =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                )

            ScrollFrame.BackgroundTransparency =
                1

            ScrollFrame.BorderSizePixel =
                0

            ScrollFrame.ScrollBarThickness =
                3

            ScrollFrame.ScrollingDirection =
                Enum.ScrollingDirection.Y

            ScrollFrame.CanvasSize =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                )

            ScrollFrame.AutomaticCanvasSize =
                Enum.AutomaticSize.Y

            ScrollFrame.ClipsDescendants =
                true

            ScrollFrame.ZIndex =
                500

            ScrollFrame.Parent =
                self.Sidebar

            self.CategoryScroll =
                ScrollFrame

        end

    end

    --==================================================
    -- SCROLL SETTINGS
    --==================================================

    self.CategoryScroll.BackgroundTransparency =
        1

    self.CategoryScroll.BorderSizePixel =
        0

    self.CategoryScroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    self.CategoryScroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    self.CategoryScroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    self.CategoryScroll.ScrollBarThickness =
        3

    self.CategoryScroll.ClipsDescendants =
        true

    --==================================================
    -- FIND EXISTING LAYOUT
    --==================================================

    local Layout =
        self.CategoryScroll:FindFirstChild(
            "CategoryLayout"
        )

    if not Layout then

        Layout =
            self.CategoryScroll:FindFirstChildOfClass(
                "UIListLayout"
            )

    end

    if not Layout then

        Layout =
            Instance.new("UIListLayout")

        Layout.Name =
            "CategoryLayout"

        Layout.SortOrder =
            Enum.SortOrder.LayoutOrder

        Layout.Padding =
            UDim.new(
                0,
                5
            )

        Layout.Parent =
            self.CategoryScroll

    else

        Layout.SortOrder =
            Enum.SortOrder.LayoutOrder

    end

    self.CategoryScrollLayout =
        Layout

    --==================================================
    -- PADDING
    --==================================================

    local Padding =
        self.CategoryScroll:FindFirstChild(
            "CategoryPadding"
        )

    if not Padding then

        Padding =
            Instance.new("UIPadding")

        Padding.Name =
            "CategoryPadding"

        Padding.PaddingTop =
            UDim.new(
                0,
                4
            )

        Padding.PaddingBottom =
            UDim.new(
                0,
                4
            )

        Padding.PaddingLeft =
            UDim.new(
                0,
                4
            )

        Padding.PaddingRight =
            UDim.new(
                0,
                4
            )

        Padding.Parent =
            self.CategoryScroll

    end

    self.CategoryScrollPadding =
        Padding

    --==================================================
    -- THEME SCROLLBAR
    --==================================================

    if self.Theme
    and type(self.Theme.GetAccent) == "function" then

        local Success, Accent =
            pcall(function()

                return self.Theme:GetAccent()

            end)

        if Success
        and Accent then

            self.CategoryScroll.ScrollBarImageColor3 =
                Accent

        end

    end

end

--==================================================
-- GET CATEGORY ICON
--==================================================

function Categories:GetIcon(CategoryName)

    return CategoryIcons[CategoryName]
        or "📁"

end

--==================================================
-- GET CATEGORY IMAGE
--==================================================

function Categories:GetCategoryImage(CategoryName)

    return CategoryImages[CategoryName]

end

--==================================================
-- LOAD CATEGORY IMAGE
--==================================================

function Categories:LoadCategoryImage(CategoryName)

    local ImageData =
        self:GetCategoryImage(
            CategoryName
        )

    if not ImageData then
        return nil
    end

    if type(ImageData) ~= "table" then
        return nil
    end

    if type(ImageData.URL) ~= "string"
    or ImageData.URL == "" then

        return nil

    end

    if type(ImageData.PATH) ~= "string"
    or ImageData.PATH == "" then

        return nil

    end

    if type(isfile) ~= "function"
    or type(writefile) ~= "function"
    or type(getcustomasset) ~= "function" then

        return nil

    end

    local Success, Result =
        pcall(function()

            if not isfile(
                ImageData.PATH
            ) then

                local Data =
                    game:HttpGet(
                        ImageData.URL
                    )

                writefile(
                    ImageData.PATH,
                    Data
                )

            end

            return getcustomasset(
                ImageData.PATH
            )

        end)

    if Success
    and Result then

        return Result

    end

    return nil

end

--==================================================
-- UPDATE CATEGORY TEXT COLOR
--==================================================

function Categories:UpdateCategoryTextColor(Button, Color)

    if not Button then
        return
    end

    local TextLabel =
        Button:FindFirstChild(
            "CategoryText"
        )

    if TextLabel
    and TextLabel:IsA("TextLabel") then

        TextLabel.TextColor3 =
            Color

    end

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

    if type(self.Theme.GetNormalColor) ~= "function" then
        return
    end

    local Success, Color =
        pcall(function()

            return self.Theme:GetNormalColor()

        end)

    if Success
    and Color then

        Button.BackgroundColor3 =
            Color

    end

    if type(self.Theme.GetNormalTextColor) == "function" then

        local TextSuccess, TextColor =
            pcall(function()

                return self.Theme:GetNormalTextColor()

            end)

        if TextSuccess
        and TextColor then

            Button.TextColor3 =
                TextColor

            self:UpdateCategoryTextColor(
                Button,
                TextColor
            )

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

    if type(self.Theme.GetSelectedColor) ~= "function" then
        return
    end

    local Success, Color =
        pcall(function()

            return self.Theme:GetSelectedColor()

        end)

    if Success
    and Color then

        Button.BackgroundColor3 =
            Color

    end

    if type(self.Theme.GetSelectedTextColor) == "function" then

        local TextSuccess, TextColor =
            pcall(function()

                return self.Theme:GetSelectedTextColor()

            end)

        if TextSuccess
        and TextColor then

            Button.TextColor3 =
                TextColor

            self:UpdateCategoryTextColor(
                Button,
                TextColor
            )

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

    if self.CurrentContext == "CONFIGURATION" then

        self.CurrentContext =
            "NORMAL"

    end

    if self.Settings then

        if type(self.Settings.CloseThemePopup) == "function" then

            pcall(function()

                self.Settings:CloseThemePopup()

            end)

        end

        if type(self.Settings.Hide) == "function" then

            pcall(function()

                self.Settings:Hide()

            end)

        end

        if type(self.Settings.ToggleButtons) == "table" then

            self.Settings.ToggleButtons = {}

        end

        self.Settings.ThemeButton = nil

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
    and type(self.Settings.Show) == "function" then

        pcall(function()

            self.Settings:Show()

        end)

    end

    if Token ~= self.ContextSwitchToken then

        return false

    end

    return true

end

--==================================================
-- LEAVE CONFIGURATION
--==================================================

function Categories:LeaveConfiguration()

    if self.CurrentContext ~= "CONFIGURATION"
    and self.CurrentCategory ~= "Configuração" then

        return

    end

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    if self.Settings
    and type(self.Settings.CloseThemePopup) == "function" then

        pcall(function()

            self.Settings:CloseThemePopup()

        end)

    end

    if self.Settings then

        if type(self.Settings.ToggleButtons) == "table" then

            self.Settings.ToggleButtons = {}

        end

        self.Settings.ThemeButton = nil

    end

    self:ClearContent()

end

--==================================================
-- CATEGORY CLICK ANIMATION
--==================================================

function Categories:AnimateCategoryClick(Button)

    if not Button or not Button.Parent then
        return
    end

    if self.CategoryClickAnimation == false then
        return
    end

    local OriginalSize =
        Button.Size

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
            OriginalSize.Y.Offset + ExtraHeight
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

    task.delay(Duration, function()

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

    end)

end

--==================================================
-- VALID SOUND DATA
--==================================================

function Categories:IsValidSoundData(SoundData)

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
-- BUILD ALL SOUNDS
--==================================================

function Categories:BuildAllSounds()

    self.AllSounds = {}

    if type(self.Sounds) ~= "table" then
        return self.AllSounds
    end

    local CategoryNames = {}

    for CategoryName, CategoryData in pairs(
        self.Sounds
    ) do

        if CategoryName ~= "ALL"
        and CategoryName ~= "Configuração"
        and CategoryName ~= "Outro"
        and type(CategoryData) == "table" then

            table.insert(
                CategoryNames,
                CategoryName
            )

        end

    end

    table.sort(
        CategoryNames,
        function(A, B)

            if A == "Outros"
            and B ~= "Outros" then

                return true

            end

            if B == "Outros"
            and A ~= "Outros" then

                return false

            end

            if A == "Heian Sukuna Sounds"
            and B ~= "Heian Sukuna Sounds" then

                return true

            end

            if B == "Heian Sukuna Sounds"
            and A ~= "Heian Sukuna Sounds" then

                return false

            end

            return tostring(A) < tostring(B)

        end
    )

    for _, CategoryName in ipairs(
        CategoryNames
    ) do

        local CategoryData =
            self.Sounds[CategoryName]

        if type(CategoryData) == "table" then

            for _, SoundData in ipairs(
                CategoryData
            ) do

                if self:IsValidSoundData(
                    SoundData
                ) then

                    table.insert(
                        self.AllSounds,
                        SoundData
                    )

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

        if not Object:IsA("UIListLayout")
        and not Object:IsA("UIPadding")
        and not Object:IsA("UIGridLayout") then

            Object:Destroy()

        end

    end

end

--==================================================
-- NOTIFY SEARCH
--==================================================

function Categories:NotifySearch()

    if self.Search
    and type(self.Search.OnContextChanged) == "function" then

        task.defer(function()

            pcall(function()

                self.Search:OnContextChanged()

            end)

        end)

    end

end

--==================================================
-- CLEAR SEARCH CONTEXT
--==================================================

function Categories:ClearSearchContext()

    if self.Search
    and type(self.Search.ClearForContext) == "function" then

        pcall(function()

            self.Search:ClearForContext()

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

    if type(self.Favorites.IsFavorite) ~= "function" then
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

                    return self.Favorites:IsFavorite(
                        ID
                    )

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

function Categories:GetSoundName(SoundData)

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

function Categories:GetSoundsByName(SearchText)

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

    if self.CurrentCategory ~= "ALL" then

        local Category =
            self.Sounds
            and self.Sounds[
                self.CurrentCategory
            ]

        if type(Category) == "table" then

            local Result = {}

            for _, Data in ipairs(
                Category
            ) do

                if self:IsValidSoundData(
                    Data
                ) then

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
        UDim.new(0, 9)

    Padding.Parent =
        Button

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 6)

    Corner.Parent =
        Button

    Button.MouseButton1Click:Connect(
        function()

            if type(Callback) == "function" then

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
        UDim.new(0, 8)

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
        UDim.new(0, 5)

    Layout.Parent =
        FilterScroll

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingTop =
        UDim.new(0, 3)

    Padding.PaddingBottom =
        UDim.new(0, 3)

    Padding.Parent =
        FilterScroll

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
        UDim.new(0, 7)

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

function Categories:RenderSounds(Sounds)

    self:LeaveConfiguration()

    self:ClearContent()

    if not self.Cards
    or type(self.Cards.CreateSoundCard) ~= "function" then

        warn(
            "[RIMURU HUB] Cards.CreateSoundCard não está disponível."
        )

        return

    end

    if type(Sounds) ~= "table" then
        return
    end

    local CardIndex = 0

    for _, Data in ipairs(
        Sounds
    ) do

        if self:IsValidSoundData(
            Data
        ) then

            CardIndex += 1

            self.Cards:CreateSoundCard(
                CardIndex,
                Data
            )

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

function Categories:ShowCategory(CategoryName)

    if type(CategoryName) ~= "string" then
        return
    end

    if CategoryName == "Outro" then

        CategoryName = "Outros"

    end

    if CategoryName ==
        "Configuração" then

        self:EnterConfiguration()

        return

    end

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    self:ClearSearchContext()

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

function Categories:SelectButton(Button)

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

    --==================================================
    -- ENSURE CATEGORY SCROLL
    --==================================================

    self:SetupCategoryScroll()

    local Parent =
        self.CategoryScroll

    if not Parent then

        Parent =
            self.Sidebar

    end

    if not Parent then
        return nil
    end

    --==================================================
    -- BUTTON
    --==================================================

    local Button =
        Instance.new("TextButton")

    Button.Name =
        CategoryName

    -- AUMENTADO:
    -- 38 -> 40
    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            self.CategoryHeight or 40
        )

    self:SetNormalStyle(
        Button
    )

    Button.BorderSizePixel =
        0

    --==================================================
    -- BUTTON SEM TEXTO
    --==================================================

    Button.Text =
        ""

    Button.TextTransparency =
        1

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
        Parent

    --==================================================
    -- CORNER
    --==================================================

    local ButtonCorner =
        Instance.new("UICorner")

    ButtonCorner.CornerRadius =
        UDim.new(
            0,
            7
        )

    ButtonCorner.Parent =
        Button

    --==================================================
    -- CATEGORY IMAGE
    --==================================================

    local CategoryImage =
        self:LoadCategoryImage(
            CategoryName
        )

    if CategoryImage then

        local Image =
            Instance.new("ImageLabel")

        Image.Name =
            "CategoryImage"

        --==================================================
        -- DEFAULT = 30x30
        -- GOJO = 13.5x13.5
        -- MEGUMI = 36x36
        -- CHOSO = 48x48
        -- MAHORAGA = 30x30
        --==================================================

        local BaseImageSize =
            self.CategoryImageSize or 30

        local ImageScale =
            1

        local ImageData =
            self:GetCategoryImage(
                CategoryName
            )

        if ImageData
        and type(ImageData) == "table"
        and type(ImageData.Scale) == "number" then

            ImageScale =
                ImageData.Scale

        end

        local FinalImageSize =
            math.floor(
                BaseImageSize *
                ImageScale
            )

        Image.Size =
            UDim2.new(
                0,
                FinalImageSize,
                0,
                FinalImageSize
            )

        Image.Position =
            UDim2.new(
                0,
                self.CategoryImageLeft or 7,
                0.5,
                -(FinalImageSize / 2)
            )

        Image.BackgroundTransparency =
            1

        Image.BorderSizePixel =
            0

        Image.Image =
            CategoryImage

        Image.ScaleType =
            Enum.ScaleType.Fit

        Image.ZIndex =
            Button.ZIndex + 1

        Image.Parent =
            Button

        --==================================================
        -- SEPARATE TEXT
        --==================================================

        local TextLabel =
            Instance.new("TextLabel")

        TextLabel.Name =
            "CategoryText"

        TextLabel.Size =
            UDim2.new(
                1,
                -(self.CategoryTextLeft or 44) - 8,
                1,
                0
            )

        TextLabel.Position =
            UDim2.new(
                0,
                self.CategoryTextLeft or 44,
                0,
                0
            )

        TextLabel.BackgroundTransparency =
            1

        TextLabel.BorderSizePixel =
            0

        TextLabel.Text =
            CategoryName

        TextLabel.TextSize =
            11

        TextLabel.Font =
            Enum.Font.GothamMedium

        TextLabel.TextXAlignment =
            Enum.TextXAlignment.Left

        TextLabel.TextYAlignment =
            Enum.TextYAlignment.Center

        TextLabel.TextTruncate =
            Enum.TextTruncate.AtEnd

        TextLabel.TextColor3 =
            Button.TextColor3

        TextLabel.ZIndex =
            Button.ZIndex + 1

        TextLabel.Parent =
            Button

    else

        --==================================================
        -- EMOJI FALLBACK
        --==================================================

        local TextLabel =
            Instance.new("TextLabel")

        TextLabel.Name =
            "CategoryText"

        TextLabel.Size =
            UDim2.new(
                1,
                -20,
                1,
                0
            )

        TextLabel.Position =
            UDim2.new(
                0,
                10,
                0,
                0
            )

        TextLabel.BackgroundTransparency =
            1

        TextLabel.BorderSizePixel =
            0

        TextLabel.Text =
            self:GetIcon(
                CategoryName
            )
            .. "  "
            .. CategoryName

        TextLabel.TextSize =
            11

        TextLabel.Font =
            Enum.Font.GothamMedium

        TextLabel.TextXAlignment =
            Enum.TextXAlignment.Left

        TextLabel.TextYAlignment =
            Enum.TextYAlignment.Center

        TextLabel.TextTruncate =
            Enum.TextTruncate.AtEnd

        TextLabel.TextColor3 =
            Button.TextColor3

        TextLabel.ZIndex =
            Button.ZIndex + 1

        TextLabel.Parent =
            Button

    end

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

    self:SetupCategoryScroll()

    local Parent =
        self.CategoryScroll
        or self.Sidebar

    if not Parent then
        return 0
    end

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

    --==================================================
    -- CLEAN LEGACY BUTTONS
    --==================================================

    for _, Object in ipairs(
        Parent:GetChildren()
    ) do

        if Object:IsA("TextButton") then

            Object:Destroy()

        end

    end

    self.CategoryButtons = {}

    self.SelectedButton = nil

    local CategoryIndex = 0

    --==================================================
    -- ALL FIRST
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

    local SoundCategoryNames = {}

    if type(self.Sounds) == "table" then

        for CategoryName, CategoryData in pairs(
            self.Sounds
        ) do

            if CategoryName ~= "ALL"
            and CategoryName ~= "Configuração"
            and CategoryName ~= "Outro"
            and type(CategoryData) == "table" then

                table.insert(
                    SoundCategoryNames,
                    CategoryName
                )

            end

        end

    end

    --==================================================
    -- SORT
    --==================================================

    table.sort(
        SoundCategoryNames,
        function(A, B)

            if A == "Outros"
            and B ~= "Outros" then

                return true

            end

            if B == "Outros"
            and A ~= "Outros" then

                return false

            end

            if A == "Heian Sukuna Sounds"
            and B ~= "Heian Sukuna Sounds" then

                return true

            end

            if B == "Heian Sukuna Sounds"
            and A ~= "Heian Sukuna Sounds" then

                return false

            end

            return tostring(A) <
                tostring(B)

        end
    )

    --==================================================
    -- CREATE SOUND CATEGORIES
    --==================================================

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

    --==================================================
    -- FORCE SCROLL UPDATE
    --==================================================

    if self.CategoryScroll then

        self.CategoryScroll.CanvasPosition =
            Vector2.new(
                0,
                0
            )

        task.defer(function()

            if self.CategoryScroll
            and self.CategoryScroll.Parent then

                self.CategoryScroll.CanvasSize =
                    UDim2.new(
                        0,
                        0,
                        0,
                        self.CategoryScrollLayout
                        and self.CategoryScrollLayout.AbsoluteContentSize.Y
                        or 0
                    )

            end

        end)

    end

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

    if FilterName == "Favorite" then

        self:ShowFavorites()

    elseif FilterName == "M1" then

        self:ShowM1()

    elseif FilterName == "Hit" then

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

    if self.CurrentCategory ==
        "Configuração" then

        self:EnterConfiguration()

        return

    end

    self:LeaveConfiguration()

    self:InvalidateContext()

    self.CurrentContext =
        "NORMAL"

    if self.CurrentCategory ~= "ALL" then

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
    -- CATEGORY SCROLL
    --==================================================

    if self.CategoryScroll then

        local Success, Accent =
            pcall(function()

                return self.Theme:GetAccent()

            end)

        if Success
        and Accent then

            self.CategoryScroll.ScrollBarImageColor3 =
                Accent

        end

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
            self.FilterMenu:FindFirstChildOfClass(
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

        self.FilterScroll.ScrollBarImageColor3 =
            self.Theme:GetAccent()

        local CurrentTheme =
            self.Theme:GetCurrent()

        for _, Button in ipairs(
            self.FilterScroll:GetChildren()
        ) do

            if Button:IsA("TextButton") then

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

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
--// CATEGORY CLICK ANIMATION
--// NON-ACCUMULATING ANIMATION
--// UISCALE CATEGORY ANIMATION
--// NO SIDEBAR SPACING BUG
--// CATEGORY CONTRAST SYSTEM
--// THEME AWARE
--// BLACKOUT = BLACK/WHITE INVERSION
--// CONFIGURATION CONTEXT FIX
--// SETTINGS DISPLAY FIX
--// SEARCH CLEAR ON CATEGORY CHANGE
--// SAFE CONTEXT SWITCHING
--// SOUND DATABASE COMPATIBILITY FIX
--// ALL SOUND COLLECTION FIX

local Categories = {}

--==================================================
-- CATEGORY ICONS
--==================================================

local CategoryIcons = {

    ["ALL"] = "🏠",

    ["Outros"] = "📁",

    ["Outro"] = "📁",

    ["Heian Sukuna Sounds"] = "👹",

    ["Configuração"] = "⚙️"

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

    self.AllButton = nil
    self.ConfigButton = nil

    self.AllSounds = {}

    self.CurrentCategory = "ALL"
    self.CurrentFilter = "All"

    self.FilterButton = nil
    self.FilterMenu = nil
    self.FilterScroll = nil
    self.FilterStroke = nil

    --==================================================
    -- CATEGORY ANIMATION
    --==================================================
    -- IMPORTANTE:
    -- Não alteramos mais Button.Size.
    --
    -- Isso evita:
    -- • crescimento acumulado
    -- • espaço extra no UIListLayout
    -- • botão ficando cada vez maior
    -- • tween antigo interferindo no novo
    --
    -- UIScale aumenta apenas a aparência do botão.
    -- O espaço real ocupado pelo botão continua igual.

    self.CategoryClickAnimation = true

    self.CategoryClickScale = 1.07

    self.CategoryClickExpandTime = 0.07

    self.CategoryClickReturnTime = 0.12

    -- Guarda o UIScale de cada botão.
    self.CategoryScales = {}

    -- Guarda o tween atual de cada botão.
    self.CategoryTweens = {}

    -- Token de segurança por botão.
    self.CategoryAnimationTokens = {}

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

    return CategoryIcons[CategoryName] or "📁"

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

    local Success, Color = pcall(function()

        return self.Theme:GetNormalColor()

    end)

    if Success and Color then

        Button.BackgroundColor3 = Color

    end

    if type(self.Theme.GetNormalTextColor) == "function" then

        local TextSuccess, TextColor = pcall(function()

            return self.Theme:GetNormalTextColor()

        end)

        if TextSuccess and TextColor then

            Button.TextColor3 = TextColor

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

    local Success, Color = pcall(function()

        return self.Theme:GetSelectedColor()

    end)

    if Success and Color then

        Button.BackgroundColor3 = Color

    end

    if type(self.Theme.GetSelectedTextColor) == "function" then

        local TextSuccess, TextColor = pcall(function()

            return self.Theme:GetSelectedTextColor()

        end)

        if TextSuccess and TextColor then

            Button.TextColor3 = TextColor

        end

    end

end

--==================================================
-- GET / CREATE CATEGORY SCALE
--==================================================

function Categories:GetCategoryScale(Button)

    if not Button then
        return nil
    end

    if not Button.Parent then
        return nil
    end

    local Scale = self.CategoryScales[Button]

    if Scale and Scale.Parent == Button then
        return Scale
    end

    Scale = Button:FindFirstChild(
        "CategoryClickScale"
    )

    if not Scale then

        Scale = Instance.new("UIScale")

        Scale.Name =
            "CategoryClickScale"

        Scale.Scale = 1

        Scale.Parent = Button

    end

    self.CategoryScales[Button] = Scale

    return Scale

end

--==================================================
-- STOP CATEGORY ANIMATION
--==================================================

function Categories:StopCategoryAnimation(Button)

    if not Button then
        return
    end

    --==================================================
    -- CANCEL CURRENT TWEEN
    --==================================================

    local CurrentTween =
        self.CategoryTweens[Button]

    if CurrentTween then

        pcall(function()
            CurrentTween:Cancel()
        end)

        self.CategoryTweens[Button] = nil

    end

    --==================================================
    -- RESET SCALE
    --==================================================

    local Scale =
        self:GetCategoryScale(Button)

    if Scale then

        Scale.Scale = 1

    end

end

--==================================================
-- CATEGORY CLICK ANIMATION
--==================================================
-- Nunca modifica Button.Size.
--
-- Isso é proposital.
--
-- Antes:
--
-- clique
--   ↓
-- Size + 4
--   ↓
-- outro clique antes do retorno
--   ↓
-- pega Size já aumentado
--   ↓
-- + 4 novamente
--   ↓
-- CRESCE PARA SEMPRE
--
-- Agora:
--
-- clique
--   ↓
-- cancela tween anterior
--   ↓
-- escala volta para 1
--   ↓
-- escala para 1.07
--   ↓
-- volta para 1
--
-- O tamanho real do botão nunca muda.
--==================================================

function Categories:AnimateCategoryClick(Button)

    if not Button
    or not Button.Parent then

        return

    end

    if self.CategoryClickAnimation == false then
        return
    end

    local Scale =
        self:GetCategoryScale(Button)

    if not Scale then
        return
    end

    --==================================================
    -- CANCELA ANIMAÇÃO ANTERIOR
    --==================================================

    self:StopCategoryAnimation(Button)

    --==================================================
    -- NOVO TOKEN
    --==================================================

    local Token =
        (self.CategoryAnimationTokens[Button] or 0) + 1

    self.CategoryAnimationTokens[Button] =
        Token

    --==================================================
    -- EXPAND
    --==================================================

    local ExpandTween =
        game:GetService("TweenService"):Create(

            Scale,

            TweenInfo.new(

                self.CategoryClickExpandTime,

                Enum.EasingStyle.Quad,

                Enum.EasingDirection.Out

            ),

            {
                Scale =
                    self.CategoryClickScale
            }

        )

    self.CategoryTweens[Button] =
        ExpandTween

    ExpandTween:Play()

    --==================================================
    -- RETURN
    --==================================================

    task.delay(

        self.CategoryClickExpandTime,

        function()

            if not Button
            or not Button.Parent then

                return

            end

            if self.CategoryAnimationTokens[Button]
                ~= Token then

                return

            end

            local ReturnTween =
                game:GetService("TweenService"):Create(

                    Scale,

                    TweenInfo.new(

                        self.CategoryClickReturnTime,

                        Enum.EasingStyle.Quad,

                        Enum.EasingDirection.Out

                    ),

                    {
                        Scale = 1
                    }

                )

            self.CategoryTweens[Button] =
                ReturnTween

            ReturnTween:Play()

            ReturnTween.Completed:Connect(

                function()

                    if self.CategoryAnimationTokens[Button]
                        ~= Token then

                        return

                    end

                    if self.CategoryTweens[Button]
                        == ReturnTween then

                        self.CategoryTweens[Button] =
                            nil

                    end

                    if Scale
                    and Scale.Parent then

                        Scale.Scale = 1

                    end

                end

            )

        end

    )

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

    --==================================================
    -- COLLECT
    --==================================================

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
-- CLEAR SOUND CONTENT
--==================================================
-- IMPORTANTE:
-- Só remove objetos que pertencem às Sound Cards.
--
-- Isso impede que o sistema de Configuração
-- seja destruído acidentalmente caso o Settings
-- tenha criado elementos dentro do mesmo Scroll.

function Categories:ClearContent()

    if not self.Scroll then
        return
    end

    for _, Object in ipairs(
        self.Scroll:GetChildren()
    ) do

        if Object:IsA("Frame")
        and Object.Name:sub(1, 6) == "Sound_" then

            Object:Destroy()

        end

    end

end

--==================================================
-- NOTIFY SEARCH
--==================================================

function Categories:NotifySearch()

    if self.Search
    and type(self.Search.OnContextChanged)
        == "function" then

        task.defer(

            function()

                pcall(

                    function()

                        self.Search:OnContextChanged()

                    end

                )

            end

        )

    end

end

--==================================================
-- CLEAR SEARCH CONTEXT
--==================================================

function Categories:ClearSearchContext()

    if self.Search
    and type(self.Search.ClearForContext)
        == "function" then

        pcall(

            function()

                self.Search:ClearForContext()

            end

        )

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

    if type(self.Favorites.IsFavorite)
        ~= "function" then

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

            local Success, IsFavorite =
                pcall(

                    function()

                        return self.Favorites:IsFavorite(
                            ID
                        )

                    end

                )

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

    return self:GetSoundsByName("m1")

end

--==================================================
-- HIT
--==================================================

function Categories:GetHitSounds()

    return self:GetSoundsByName("hit")

end

--==================================================
-- GET CURRENT SOUNDS
--==================================================

function Categories:GetCurrentSounds()

    if self.CurrentCategory
        == "Configuração" then

        return {}

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

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

    --==================================================
    -- FILTER
    --==================================================

    local Resolver =
        self.FilterResolvers[
            self.CurrentFilter
        ]

    if type(Resolver) == "function" then

        local Success, Result =
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

        ["Favorite"] = "★ Favorite",

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

    if not CurrentTheme then
        return nil
    end

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

    Button.BorderSizePixel = 0

    Button.Text = Text

    Button.TextColor3 =
        CurrentTheme.Text

    Button.TextSize = 11

    Button.Font =
        Enum.Font.GothamMedium

    Button.AutoButtonColor = false

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.LayoutOrder =
        Order

    Button.ZIndex = 802

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

    if not self.Theme then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

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

    Menu.BorderSizePixel = 0

    Menu.ZIndex = 800

    Menu.Visible = false

    Menu.ClipsDescendants = true

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

    MenuStroke.Thickness = 1

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

    FilterScroll.BackgroundTransparency = 1

    FilterScroll.BorderSizePixel = 0

    FilterScroll.ScrollBarThickness = 3

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

    FilterScroll.ZIndex = 801

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

    if not CurrentTheme then
        return
    end

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

    Button.BorderSizePixel = 0

    Button.Text =
        "All"

    Button.TextColor3 =
        CurrentTheme.Text

    Button.TextSize = 10

    Button.Font =
        Enum.Font.GothamMedium

    Button.AutoButtonColor = false

    Button.ZIndex = 700

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

    Stroke.Thickness = 1

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

    self:ClearContent()

    if not self.Cards
    or type(self.Cards.CreateSoundCard)
        ~= "function" then

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

    self.CurrentCategory =
        "ALL"

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    if self.ContentTitle then

        self.ContentTitle.Text =
            "ALL"

    end

    -- Se o Settings estiver visível,
    -- escondemos o painel antes de mostrar cards.

    if self.Settings
    and type(self.Settings.Hide) == "function" then

        pcall(function()

            self.Settings:Hide()

        end)

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

    if self.Settings
    and type(self.Settings.Hide) == "function" then

        pcall(function()

            self.Settings:Hide()

        end)

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

    if self.Settings
    and type(self.Settings.Hide) == "function" then

        pcall(function()

            self.Settings:Hide()

        end)

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

    if self.Settings
    and type(self.Settings.Hide) == "function" then

        pcall(function()

            self.Settings:Hide()

        end)

    end

    local Sounds =
        self:GetHitSounds()

    self:RenderSounds(
        Sounds
    )

    self:NotifySearch()

end

--==================================================
-- HIDE SETTINGS
--==================================================

function Categories:HideSettings()

    if not self.Settings then
        return
    end

    if type(self.Settings.Hide) == "function" then

        pcall(function()

            self.Settings:Hide()

        end)

    end

end

--==================================================
-- SHOW SETTINGS
--==================================================
-- Esta função agora:
--
-- 1. Limpa a busca.
-- 2. Fecha filtro.
-- 3. Esconde o filtro.
-- 4. Define Configuração como contexto.
-- 5. Limpa SOMENTE Sound Cards.
-- 6. Atualiza o título.
-- 7. Mostra Settings.
--
-- Não chamamos RenderSounds aqui.
-- Não tentamos criar cards.
-- Não destruímos o conteúdo de Settings.

function Categories:ShowConfiguration()

    --==================================================
    -- SEARCH
    --==================================================

    self:ClearSearchContext()

    --==================================================
    -- FILTER
    --==================================================

    if self.FilterButton then

        self.FilterButton.Visible =
            false

    end

    self:CloseFilterMenu()

    --==================================================
    -- CONTEXT
    --==================================================

    self.CurrentCategory =
        "Configuração"

    self.CurrentFilter =
        "All"

    --==================================================
    -- REMOVE SOUND CARDS ONLY
    --==================================================

    self:ClearContent()

    --==================================================
    -- TITLE
    --==================================================

    if self.ContentTitle then

        self.ContentTitle.Text =
            "Configuração"

    end

    --==================================================
    -- SHOW SETTINGS
    --==================================================

    local Settings =
        self.Context
        and self.Context.Settings

    if Settings
    and type(Settings.Show) == "function" then

        local Success, Error =
            pcall(function()

                Settings:Show()

            end)

        if not Success then

            warn(
                "[RIMURU HUB] Erro ao abrir Configuração:",
                Error
            )

        end

    else

        warn(
            "[RIMURU HUB] Settings.Show() não está disponível."
        )

    end

end

--==================================================
-- SHOW CATEGORY
--==================================================

function Categories:ShowCategory(CategoryName)

    if type(CategoryName) ~= "string" then
        return
    end

    --==================================================
    -- CONFIGURATION
    --==================================================

    if CategoryName ==
        "Configuração" then

        self:ShowConfiguration()

        return

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    self:ClearSearchContext()

    self:HideSettings()

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
    -- CATEGORY
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

        -- Garante que o botão anterior
        -- nunca fique visualmente escalado.

        self:StopCategoryAnimation(
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

    --==================================================
    -- TAMANHO FIXO
    --==================================================
    -- Nunca é alterado pela animação.

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

    --==================================================
    -- CREATE SCALE
    --==================================================

    local Scale =
        Instance.new("UIScale")

    Scale.Name =
        "CategoryClickScale"

    Scale.Scale =
        1

    Scale.Parent =
        Button

    self.CategoryScales[
        Button
    ] = Scale

    self.CategoryAnimationTokens[
        Button
    ] = 0

    --==================================================
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(

        function()

            -- Primeiro seleciona.
            self:SelectButton(
                Button
            )

            -- Depois anima.
            self:AnimateCategoryClick(
                Button
            )

            --==================================================
            -- SOUND CATEGORY
            --==================================================

            if ShowSoundCategory then

                self:ShowCategory(
                    CategoryName
                )

                return

            end

            --==================================================
            -- CONFIGURATION
            --==================================================

            if CategoryName ==
                "Configuração" then

                self:ShowConfiguration()

                return

            end

            self:ClearSearchContext()

            self:HideSettings()

            if self.FilterButton then

                self.FilterButton.Visible =
                    false

            end

            self:CloseFilterMenu()

        end

    )

    self.CategoryButtons[
        CategoryName
    ] = Button

    return Button

end

--==================================================
-- CREATE ALL CATEGORIES
--==================================================

function Categories:CreateCategories()

    --==================================================
    -- DESTROY OLD BUTTONS
    --==================================================

    for _, Button in pairs(
        self.CategoryButtons
    ) do

        if Button
        and Button.Parent then

            self:StopCategoryAnimation(
                Button
            )

            Button:Destroy()

        end

    end

    self.CategoryButtons = {}

    self.CategoryScales = {}

    self.CategoryTweens = {}

    self.CategoryAnimationTokens = {}

    self.SelectedButton =
        nil

    self.AllButton =
        nil

    self.ConfigButton =
        nil

    local CategoryIndex =
        0

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

    if type(self.Sounds) ==
        "table" then

        for CategoryName, CategoryData in pairs(
            self.Sounds
        ) do

            if CategoryName ~= "ALL"
            and CategoryName ~= "Configuração"
            and type(CategoryData) == "table" then

                table.insert(
                    SoundCategoryNames,
                    CategoryName
                )

            end

        end

    end

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

            return tostring(A)
                < tostring(B)

        end

    )

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

    CategoryIndex += 1

    self.ConfigButton =
        self:CreateCategoryButton(

            "Configuração",

            CategoryIndex,

            false

        )

    --==================================================
    -- FILTER
    --==================================================

    self:CreateFilterButton()

    return CategoryIndex

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

    self:HideSettings()

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

    self.CurrentCategory =
        "ALL"

    self.CurrentFilter =
        FilterName

    self:ClearSearchContext()

    self:HideSettings()

    self:UpdateFilterButton()

    if self.FilterButton then

        self.FilterButton.Visible =
            true

    end

    self:CloseFilterMenu()

    --==================================================
    -- MAKE SURE ALL BUTTON IS SELECTED
    --==================================================

    local AllButton =
        self.CategoryButtons[
            "ALL"
        ]

    if AllButton then

        self:SelectButton(
            AllButton
        )

    end

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
    ] = Resolver

    return true

end

--==================================================
-- REFRESH CURRENT
--==================================================

function Categories:RefreshCurrent()

    if self.CurrentCategory ==
        "Configuração" then

        self:ShowConfiguration()

        return

    end

    --==================================================
    -- NORMAL CATEGORY
    --==================================================

    if self.CurrentCategory ~= "ALL" then

        local Category =
            self.Sounds
            and self.Sounds[
                self.CurrentCategory
            ]

        if type(Category) == "table" then

            self:HideSettings()

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

        if CurrentTheme then

            self.FilterButton.BackgroundColor3 =
                CurrentTheme.Button

            self.FilterButton.TextColor3 =
                CurrentTheme.Text

        end

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

        if CurrentTheme then

            self.FilterMenu.BackgroundColor3 =
                CurrentTheme.Content

        end

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

        if CurrentTheme then

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

end

--==================================================
-- CLEANUP
--==================================================
-- Pode ser chamado antes de recriar a UI.

function Categories:Cleanup()

    for Button, Tween in pairs(
        self.CategoryTweens
    ) do

        if Tween then

            pcall(function()
                Tween:Cancel()
            end)

        end

    end

    self.CategoryTweens = {}

    for Button, Scale in pairs(
        self.CategoryScales
    ) do

        if Scale
        and Scale.Parent then

            Scale.Scale = 1

        end

    end

    self.CategoryScales = {}

    self.CategoryAnimationTokens = {}

end

--==================================================
-- RETURN
--==================================================

return Categories

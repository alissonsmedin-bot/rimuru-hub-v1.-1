--// 💥 RIMURU HUB
--// MAIN SYSTEM
--// REMOTE LOADER
--// GitHub Modular Architecture
--//
--// Config
--// Theme
--// UI
--// Logo
--// Favorites
--// Cards
--// Categories
--// Sound
--// Settings
--// RGB
--//
--// Sem script.Parent
--// Sem ModuleScripts locais
--// Compatível com carregamento remoto
--// Compatibilidade entre módulos incluída

local RimuruHub = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local Player =
    Players.LocalPlayer

--==================================================
-- GITHUB
--==================================================

local BASE_URL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/"

--==================================================
-- MODULE URLS
--==================================================

local MODULE_URLS = {

    Config =
        BASE_URL ..
        "config.lua",

    Theme =
        BASE_URL ..
        "theme.lua",

    UI =
        BASE_URL ..
        "ui.lua",

    Logo =
        BASE_URL ..
        "logo.lua",

    Favorites =
        BASE_URL ..
        "favorites.lua",

    Cards =
        BASE_URL ..
        "cards.lua",

    Categories =
        BASE_URL ..
        "categories.lua",

    Sound =
        BASE_URL ..
        "sound.lua",

    Settings =
        BASE_URL ..
        "settings.lua",

    RGB =
        BASE_URL ..
        "RGB.lua",

}

--==================================================
-- HTTP FUNCTION
--==================================================

local function GetHttp()

    if type(game.HttpGet) == "function" then

        return function(URL)

            return game:HttpGet(
                URL
            )

        end

    end

    return nil

end

local HttpGet =
    GetHttp()

--==================================================
-- REMOTE MODULE LOADER
--==================================================

local function LoadModule(
    Name
)

    local URL =
        MODULE_URLS[Name]

    if not URL then

        warn(
            "[Rimuru Hub] URL não encontrada para: "
            .. tostring(Name)
        )

        return nil

    end

    if not HttpGet then

        warn(
            "[Rimuru Hub] HttpGet não disponível."
        )

        return nil

    end

    print(
        "[Rimuru Hub] Carregando: "
        .. Name
        .. ".lua"
    )

    --==================================================
    -- DOWNLOAD
    --==================================================

    local Success,
        Source =
        pcall(
            function()

                return HttpGet(
                    URL
                )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Falha HTTP em "
            .. Name
            .. ".lua: "
            .. tostring(Source)
        )

        return nil

    end

    if type(Source) ~= "string"
    or Source == ""
    then

        warn(
            "[Rimuru Hub] "
            .. Name
            .. ".lua retornou conteúdo vazio."
        )

        return nil

    end

    --==================================================
    -- COMPILE
    --==================================================

    local Compiler =
        loadstring

    if type(Compiler) ~= "function" then

        warn(
            "[Rimuru Hub] loadstring não disponível."
        )

        return nil

    end

    local SuccessCompile,
        Chunk =
        pcall(
            Compiler,
            Source
        )

    if not SuccessCompile
    or type(Chunk) ~= "function"
    then

        warn(
            "[Rimuru Hub] Erro de compilação em "
            .. Name
            .. ".lua: "
            .. tostring(Chunk)
        )

        return nil

    end

    --==================================================
    -- EXECUTE
    --==================================================

    local SuccessRun,
        Result =
        pcall(
            Chunk
        )

    if not SuccessRun then

        warn(
            "[Rimuru Hub] Erro ao executar "
            .. Name
            .. ".lua: "
            .. tostring(Result)
        )

        return nil

    end

    --==================================================
    -- RESULT
    --==================================================

    if Result == nil then

        warn(
            "[Rimuru Hub] "
            .. Name
            .. ".lua não retornou um módulo."
        )

        return nil

    end

    print(
        "[Rimuru Hub] OK: "
        .. Name
        .. ".lua"
    )

    return Result

end

--==================================================
-- LOAD DATA/MODULES
--==================================================

RimuruHub.Config =
    LoadModule(
        "Config"
    )

RimuruHub.Sound =
    LoadModule(
        "Sound"
    )

RimuruHub.Theme =
    LoadModule(
        "Theme"
    )

RimuruHub.UI =
    LoadModule(
        "UI"
    )

RimuruHub.Logo =
    LoadModule(
        "Logo"
    )

RimuruHub.Favorites =
    LoadModule(
        "Favorites"
    )

RimuruHub.Cards =
    LoadModule(
        "Cards"
    )

RimuruHub.Categories =
    LoadModule(
        "Categories"
    )

RimuruHub.Settings =
    LoadModule(
        "Settings"
    )

RimuruHub.RGB =
    LoadModule(
        "RGB"
    )

--==================================================
-- STATUS
--==================================================

local function ModuleExists(
    Module
)

    return Module ~= nil

end

--==================================================
-- CONFIG COMPATIBILITY
--==================================================

if RimuruHub.Config then

    --==================================================
    -- CONFIG.UI
    --==================================================

    if type(
        RimuruHub.Config.GetUI
    ) == "function"
    then

        local Success,
            UIData =
            pcall(
                function()

                    return RimuruHub.Config:
                        GetUI()

                end
            )

        if Success
        and type(UIData) == "table"
        then

            RimuruHub.Config.UI =
                UIData

        end

    end

    if type(
        RimuruHub.Config.UI
    ) ~= "table"
    then

        RimuruHub.Config.UI =
            {}

    end

    --==================================================
    -- DEFAULT CARD TRANSPARENCY
    --==================================================

    if RimuruHub.Config.UI.CardTransparency
        == nil
    then

        RimuruHub.Config.UI.CardTransparency =
            0.75

    end

    --==================================================
    -- DRAG COMPATIBILITY
    --==================================================

    if RimuruHub.Config.UI.MainMenuDraggable
        == nil
    then

        if RimuruHub.Config.UI.Draggable
            ~= nil
        then

            RimuruHub.Config.UI.MainMenuDraggable =
                RimuruHub.Config.UI.Draggable

        else

            RimuruHub.Config.UI.MainMenuDraggable =
                true

        end

    end

    --==================================================
    -- ANIMATION COMPATIBILITY
    --==================================================

    if RimuruHub.Config.UI.Animations
        == nil
    then

        local AnimationValue =
            true

        if type(
            RimuruHub.Config.GetAnimation
        ) == "function"
        then

            local Success,
                Value =
                pcall(
                    function()

                        return RimuruHub.Config:
                            GetAnimation(
                                "Enabled"
                            )

                    end
                )

            if Success
            and type(Value) == "boolean"
            then

                AnimationValue =
                    Value

            end

        end

        RimuruHub.Config.UI.Animations =
            AnimationValue

    end

end

--==================================================
-- CONTEXT
--==================================================

RimuruHub.Context = {

    Player =
        Player,

    PlayerGui =
        Player
        and Player:WaitForChild(
            "PlayerGui"
        ),

    Config =
        RimuruHub.Config,

    Theme =
        RimuruHub.Theme,

    UI =
        RimuruHub.UI,

    Logo =
        RimuruHub.Logo,

    Favorites =
        RimuruHub.Favorites,

    Cards =
        RimuruHub.Cards,

    Categories =
        RimuruHub.Categories,

    --==================================================
    -- IMPORTANT
    --==================================================

    Sounds =
        RimuruHub.Sound,

    Sound =
        RimuruHub.Sound,

    Settings =
        RimuruHub.Settings,

    RGB =
        RimuruHub.RGB,

}

--==================================================
-- SAFE INIT
--==================================================

local function InitModule(
    Name,
    Module
)

    if not Module then

        warn(
            "[Rimuru Hub] "
            .. Name
            .. " não carregado."
        )

        return false

    end

    if type(
        Module.Init
    ) ~= "function"
    then

        warn(
            "[Rimuru Hub] "
            .. Name
            .. " não possui Init()."
        )

        return false

    end

    local Success,
        Error =
        pcall(
            function()

                Module:Init(
                    RimuruHub.Context
                )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao iniciar "
            .. Name
            .. ": "
            .. tostring(Error)
        )

        return false

    end

    print(
        "[Rimuru Hub] "
        .. Name
        .. " iniciado."
    )

    return true

end

--==================================================
-- INITIALIZATION
--==================================================

--==================================================
-- 1. CONFIG
--==================================================

InitModule(
    "Config",
    RimuruHub.Config
)

--==================================================
-- 2. THEME
--==================================================

InitModule(
    "Theme",
    RimuruHub.Theme
)

--==================================================
-- 3. UI
--==================================================

InitModule(
    "UI",
    RimuruHub.UI
)

--==================================================
-- 4. FAVORITES
--==================================================

InitModule(
    "Favorites",
    RimuruHub.Favorites
)

--==================================================
-- 5. CARDS
--==================================================

InitModule(
    "Cards",
    RimuruHub.Cards
)

--==================================================
-- 6. CATEGORIES
--==================================================

InitModule(
    "Categories",
    RimuruHub.Categories
)

--==================================================
-- 7. LOGO
--==================================================

InitModule(
    "Logo",
    RimuruHub.Logo
)

--==================================================
-- 8. SETTINGS
--==================================================

InitModule(
    "Settings",
    RimuruHub.Settings
)

--==================================================
-- 9. RGB
--==================================================

InitModule(
    "RGB",
    RimuruHub.RGB
)

--==================================================
-- CARDS COMPATIBILITY
--==================================================

if RimuruHub.Cards then

    -- Categories.lua chama CreateCard().
    -- Cards.lua atual possui CreateSoundCard().

    if type(
        RimuruHub.Cards.CreateCard
    ) ~= "function"
    and type(
        RimuruHub.Cards.CreateSoundCard
    ) == "function"
    then

        RimuruHub.Cards.CreateCard =
            function(
                Self,
                Index,
                Data
            )

                return Self:
                    CreateSoundCard(
                        Index,
                        Data
                    )

            end

        print(
            "[Rimuru Hub] Compatibilidade Cards: CreateCard -> CreateSoundCard"
        )

    end

end

--==================================================
-- REFRESH CONTEXT REFERENCES
--==================================================

if RimuruHub.UI then

    RimuruHub.Context.UI =
        RimuruHub.UI

end

if RimuruHub.Theme then

    RimuruHub.Context.Theme =
        RimuruHub.Theme

end

if RimuruHub.Cards then

    RimuruHub.Context.Cards =
        RimuruHub.Cards

end

if RimuruHub.Categories then

    RimuruHub.Context.Categories =
        RimuruHub.Categories

end

--==================================================
-- CREATE CATEGORIES
--==================================================

if RimuruHub.Categories
and type(
    RimuruHub.Categories.CreateCategories
) == "function"
then

    local Success,
        Error =
        pcall(
            function()

                RimuruHub.Categories:
                    CreateCategories()

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao criar categorias: "
            .. tostring(Error)
        )

    else

        print(
            "[Rimuru Hub] Categorias criadas."
        )

    end

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

if RimuruHub.Categories
and type(
    RimuruHub.Categories.SetDefaultCategory
) == "function"
then

    local Success,
        Error =
        pcall(
            function()

                RimuruHub.Categories:
                    SetDefaultCategory()

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao selecionar categoria padrão: "
            .. tostring(Error)
        )

    end

end

--==================================================
-- BUILD SETTINGS
--==================================================

if RimuruHub.Settings
and type(
    RimuruHub.Settings.Build
) == "function"
then

    local Success,
        Error =
        pcall(
            function()

                RimuruHub.Settings:
                    Build()

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao construir Settings: "
            .. tostring(Error)
        )

    end

end

--==================================================
-- APPLY THEME
--==================================================

if RimuruHub.UI
and type(
    RimuruHub.UI.ApplyTheme
) == "function"
then

    pcall(
        function()

            RimuruHub.UI:
                ApplyTheme()

        end
    )

end

--==================================================
-- APPLY CATEGORY THEME
--==================================================

if RimuruHub.Categories
and type(
    RimuruHub.Categories.ApplyTheme
) == "function"
then

    pcall(
        function()

            RimuruHub.Categories:
                ApplyTheme()

        end
    )

end

--==================================================
-- APPLY CARD THEME
--==================================================

if RimuruHub.Cards
and type(
    RimuruHub.Cards.ApplyTheme
) == "function"
then

    pcall(
        function()

            RimuruHub.Cards:
                ApplyTheme()

        end
    )

end

--==================================================
-- APPLY LOGO THEME
--==================================================

if RimuruHub.Logo
and type(
    RimuruHub.Logo.ApplyTheme
) == "function"
then

    pcall(
        function()

            RimuruHub.Logo:
                ApplyTheme()

        end
    )

end

--==================================================
-- OPEN / CLOSE
--==================================================

function RimuruHub:Open()

    if not self.UI then

        warn(
            "[Rimuru Hub] UI não disponível."
        )

        return false

    end

    if type(
        self.UI.SetVisible
    ) == "function"
    then

        self.UI:
            SetVisible(
                true
            )

        return true

    end

    if self.UI.Main then

        self.UI.Main.Visible =
            true

        return true

    end

    warn(
        "[Rimuru Hub] Main não encontrado."
    )

    return false

end

--==================================================
-- CLOSE
--==================================================

function RimuruHub:Close()

    if not self.UI then
        return false
    end

    if type(
        self.UI.SetVisible
    ) == "function"
    then

        self.UI:
            SetVisible(
                false
            )

        return true

    end

    if self.UI.Main then

        self.UI.Main.Visible =
            false

        return true

    end

    return false

end

--==================================================
-- TOGGLE
--==================================================

function RimuruHub:Toggle()

    if not self.UI then
        return false
    end

    if type(
        self.UI.Toggle
    ) == "function"
    then

        self.UI:
            Toggle()

        return self.UI:IsVisible()

    end

    if self.UI.Main then

        self.UI.Main.Visible =
            not self.UI.Main.Visible

        return self.UI.Main.Visible

    end

    return false

end

--==================================================
-- GET MODULE
--==================================================

function RimuruHub:GetModule(
    Name
)

    return self[Name]

end

--==================================================
-- STATUS
--==================================================

function RimuruHub:GetStatus()

    return {

        Config =
            ModuleExists(
                self.Config
            ),

        Sound =
            ModuleExists(
                self.Sound
            ),

        Theme =
            ModuleExists(
                self.Theme
            ),

        UI =
            ModuleExists(
                self.UI
            ),

        Logo =
            ModuleExists(
                self.Logo
            ),

        Favorites =
            ModuleExists(
                self.Favorites
            ),

        Cards =
            ModuleExists(
                self.Cards
            ),

        Categories =
            ModuleExists(
                self.Categories
            ),

        Settings =
            ModuleExists(
                self.Settings
            ),

        RGB =
            ModuleExists(
                self.RGB
            ),

    }

end

--==================================================
-- PRINT STATUS
--==================================================

print(
    "========================================"
)

print(
    "💥 RIMURU HUB"
)

print(
    "Remote Modular System carregado."
)

print(
    "GitHub Modules carregados."
)

print(
    "========================================"
)

--==================================================
-- AUTO OPEN
--==================================================

task.defer(
    function()

        task.wait(
            0.25
        )

        RimuruHub:
            Open()

    end
)

--==================================================
-- RETURN
--==================================================

return RimuruHub

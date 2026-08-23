--// 💥 RIMURU HUB
--// MAIN LOADER
--// STABLE MODULAR VERSION
--// SAFE INITIALIZATION
--// MODULE ERROR REPORTING
--// THEME SAFE
--// UI SAFE
--// CATEGORY SAFE
--// HARD FALLBACK
--// VERSION 2

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

--==================================================
-- PLAYER
--==================================================

local Player =
    Players.LocalPlayer

if not Player then

    warn(
        "❌ Rimuru Hub: LocalPlayer não encontrado."
    )

    return

end

local PlayerGui =
    Player:WaitForChild(
        "PlayerGui"
    )

--==================================================
-- BASE URL
--==================================================

local BaseURL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/"

--==================================================
-- MODULE LOADER
--==================================================

local function Load(
    FileName
)

    local URL =
        BaseURL ..
        FileName

    local Success, Result =
        pcall(function()

            local Source =
                game:HttpGet(
                    URL
                )

            if type(Source) ~= "string"
            or Source == "" then

                error(
                    "arquivo vazio ou inválido"
                )

            end

            local Loader =
                loadstring(
                    Source
                )

            if type(Loader) ~= "function" then

                error(
                    "loadstring retornou nil"
                )

            end

            return Loader()

        end)

    if not Success then

        warn(
            "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        )

        warn(
            "❌ RIMURU HUB"
        )

        warn(
            "Falha ao carregar: " ..
            tostring(FileName)
        )

        warn(
            tostring(Result)
        )

        warn(
            "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        )

        return nil

    end

    if Result == nil then

        warn(
            "❌ Rimuru Hub: " ..
            FileName ..
            " retornou nil."
        )

        return nil

    end

    return Result

end

--==================================================
-- CONFIG
--==================================================

local Config =
    Load(
        "config.lua"
    )

if type(Config) ~= "table" then

    warn(
        "❌ Rimuru Hub: Config inválido."
    )

    return

end

if type(Config.UI) ~= "table" then

    warn(
        "❌ Rimuru Hub: Config.UI não encontrado."
    )

    return

end

--==================================================
-- SOUNDS
--==================================================

local Sounds =
    Load(
        "sound.lua"
    )

if type(Sounds) ~= "table" then

    warn(
        "❌ Rimuru Hub: Sounds inválido."
    )

    return

end

--==================================================
-- MODULES
--==================================================

local Theme =
    Load("theme.lua")

local UI =
    Load("ui.lua")

local Logo =
    Load("logo.lua")

local Cards =
    Load("cards.lua")

local Favorites =
    Load("favorites.lua")

local Search =
    Load("search.lua")

local Categories =
    Load("categories.lua")

local Settings =
    Load("settings.lua")

local RGB =
    Load("RGB.lua")

--==================================================
-- MODULE VALIDATION
--==================================================

local Modules = {

    Theme =
        Theme,

    UI =
        UI,

    Logo =
        Logo,

    Cards =
        Cards,

    Favorites =
        Favorites,

    Search =
        Search,

    Categories =
        Categories,

    Settings =
        Settings,

    RGB =
        RGB

}

for Name, Module in
    pairs(Modules) do

    if type(Module) ~= "table" then

        warn(
            "❌ Rimuru Hub: módulo inválido -> " ..
            tostring(Name)
        )

        return

    end

end

--==================================================
-- CONTEXT
--==================================================

local Context = {

    Player =
        Player,

    PlayerGui =
        PlayerGui,

    Config =
        Config,

    Sounds =
        Sounds,

    Theme =
        Theme,

    UI =
        UI,

    Logo =
        Logo,

    Cards =
        Cards,

    Favorites =
        Favorites,

    Search =
        Search,

    Categories =
        Categories,

    Settings =
        Settings,

    RGB =
        RGB

}

--==================================================
-- SAFE INIT
--==================================================

local function InitModule(
    Name,
    Module
)

    if type(Module) ~= "table" then

        warn(
            "❌ " ..
            Name ..
            ": módulo inválido."
        )

        return false

    end

    if type(Module.Init) ~= "function" then

        warn(
            "❌ " ..
            Name ..
            ": método Init não encontrado."
        )

        return false

    end

    local Success, Error =
        pcall(function()

            Module:Init(
                Context
            )

        end)

    if not Success then

        warn(
            "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        )

        warn(
            "❌ Rimuru Hub: erro em " ..
            Name
        )

        warn(
            tostring(Error)
        )

        warn(
            "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        )

        return false

    end

    return true

end

--==================================================
-- THEME
--==================================================
-- Theme aceita Config diretamente.
-- Não passamos Context aqui.

if type(Theme.Init) ~= "function" then

    warn(
        "❌ Theme: método Init não encontrado."
    )

    return

end

local ThemeSuccess, ThemeError =
    pcall(function()

        Theme:Init(
            Config
        )

    end)

if not ThemeSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Theme."
    )

    warn(
        tostring(ThemeError)
    )

    return

end

--==================================================
-- UI
--==================================================

if not InitModule(
    "UI",
    UI
) then

    return

end

--==================================================
-- LOGO
--==================================================

if not InitModule(
    "Logo",
    Logo
) then

    warn(
        "⚠️ Rimuru Hub: Logo não inicializado."
    )

end

--==================================================
-- CARDS
--==================================================

if not InitModule(
    "Cards",
    Cards
) then

    return

end

--==================================================
-- FAVORITES
--==================================================

if not InitModule(
    "Favorites",
    Favorites
) then

    warn(
        "⚠️ Rimuru Hub: Favorites não inicializado."
    )

end

--==================================================
-- CATEGORIES
--==================================================

if not InitModule(
    "Categories",
    Categories
) then

    return

end

--==================================================
-- SEARCH
--==================================================

if not InitModule(
    "Search",
    Search
) then

    warn(
        "⚠️ Rimuru Hub: Search não inicializado."
    )

end

--==================================================
-- SETTINGS
--==================================================

if not InitModule(
    "Settings",
    Settings
) then

    warn(
        "⚠️ Rimuru Hub: Settings não inicializado."
    )

end

--==================================================
-- RGB
--==================================================

if not InitModule(
    "RGB",
    RGB
) then

    warn(
        "⚠️ Rimuru Hub: RGB não inicializado."
    )

end

--==================================================
-- SEARCH CONNECT
--==================================================

if type(Search.Connect) ==
    "function" then

    local Success, Error =
        pcall(function()

            Search:Connect()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao conectar Search."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- CREATE CATEGORIES
--==================================================

if type(
    Categories.CreateCategories
) ~= "function" then

    warn(
        "❌ Rimuru Hub: Categories.CreateCategories não existe."
    )

    return

end

local CategoriesSuccess,
    CategoriesError =
    pcall(function()

        Categories:CreateCategories()

    end)

if not CategoriesSuccess then

    warn(
        "❌ Rimuru Hub: erro ao criar categorias."
    )

    warn(
        tostring(
            CategoriesError
        )
    )

    return

end

--==================================================
-- CONFIG BUTTON
--==================================================

local ConfigButton =
    Categories.ConfigButton

if ConfigButton then

    ConfigButton.MouseButton1Click:Connect(

        function()

            if type(Settings.Show) ==
                "function" then

                local Success, Error =
                    pcall(function()

                        Settings:Show()

                    end)

                if not Success then

                    warn(
                        "⚠️ Rimuru Hub: erro ao abrir Settings."
                    )

                    warn(
                        tostring(Error)
                    )

                end

            else

                warn(
                    "⚠️ Rimuru Hub: Settings.Show não encontrado."
                )

            end

        end

    )

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

if type(
    Categories.SetDefaultCategory
) == "function" then

    local Success, Error =
        pcall(function()

            Categories:SetDefaultCategory()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao definir categoria padrão."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- INITIAL UI
--==================================================

if type(
    UI.SetVisible
) == "function" then

    pcall(function()

        UI:SetVisible(
            false
        )

    end)

end

--==================================================
-- INITIAL LOGO
--==================================================

if type(
    Logo.SetVisible
) == "function" then

    pcall(function()

        Logo:SetVisible(
            Config.UI.ShowLogo ~= false
        )

    end)

end

--==================================================
-- APPLY THEME
--==================================================

if type(
    UI.ApplyTheme
) == "function" then

    pcall(function()

        UI:ApplyTheme()

    end)

end

if type(
    Logo.ApplyTheme
) == "function" then

    pcall(function()

        Logo:ApplyTheme()

    end)

end

if type(
    Categories.ApplyTheme
) == "function" then

    pcall(function()

        Categories:ApplyTheme()

    end)

end

if type(
    Search.ApplyTheme
) == "function" then

    pcall(function()

        Search:ApplyTheme()

    end)

end

--==================================================
-- FINAL STATUS
--==================================================

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

print(
    "🌓bem vindo ao mundo, Rimuru Hub.🌓"
)

print(
    "🎨 Tema: " ..
    tostring(
        Theme:GetCurrentName()
        or "Rimuru Dark"
    )
)

print(
    "📂 Categorias: " ..
    tostring(
        Categories:GetAllSoundCount()
    )
)

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

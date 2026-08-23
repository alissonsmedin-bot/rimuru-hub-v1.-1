--// 💥 RIMURU HUB
--// MAIN LOADER
--// STABLE MODULAR VERSION
--// THEME FIX
--// UI FIX
--// SAFE INITIALIZATION

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
    warn("❌ Rimuru Hub: LocalPlayer não encontrado.")
    return
end

local PlayerGui =
    Player:WaitForChild("PlayerGui")

--==================================================
-- BASE URL
--==================================================

local BaseURL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/"

--==================================================
-- LOAD MODULE
--==================================================

local function Load(FileName)

    local URL =
        BaseURL ..
        FileName

    local Success, Result =
        pcall(function()

            local Source =
                game:HttpGet(URL)

            local Loader =
                loadstring(Source)

            if not Loader then

                error(
                    "loadstring retornou nil para " ..
                    FileName
                )

            end

            return Loader()

        end)

    if not Success then

        warn(
            "❌ Rimuru Hub: erro ao carregar " ..
            FileName
        )

        warn(
            tostring(Result)
        )

        return nil

    end

    return Result

end

--==================================================
-- CONFIG
--==================================================

local Config =
    Load("config.lua")

if not Config then

    warn(
        "❌ Rimuru Hub: Config não carregado."
    )

    return

end

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
    Load("sound.lua")

if not Sounds then

    warn(
        "❌ Rimuru Hub: Sounds não carregado."
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
-- VERIFY
--==================================================

local Modules = {

    Theme = Theme,
    UI = UI,
    Logo = Logo,
    Cards = Cards,
    Favorites = Favorites,
    Search = Search,
    Categories = Categories,
    Settings = Settings,
    RGB = RGB

}

for Name, Module in pairs(Modules) do

    if type(Module) ~= "table" then

        warn(
            "❌ Rimuru Hub: módulo inválido -> " ..
            Name
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
-- THEME
--==================================================
-- IMPORTANTE:
-- Theme recebe Config.
-- NÃO Context.

local ThemeSuccess =
    pcall(function()

        Theme:Init(
            Config
        )

    end)

if not ThemeSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Theme."
    )

    return

end

--==================================================
-- UI
--==================================================

local UISuccess =
    pcall(function()

        UI:Init(
            Context
        )

    end)

if not UISuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar UI."
    )

    return

end

--==================================================
-- LOGO
--==================================================

pcall(function()

    Logo:Init(
        Context
    )

end)

--==================================================
-- CARDS
--==================================================

pcall(function()

    Cards:Init(
        Context
    )

end)

--==================================================
-- FAVORITES
--==================================================

pcall(function()

    Favorites:Init(
        Context
    )

end)

--==================================================
-- CATEGORIES
--==================================================

local CategoriesSuccess =
    pcall(function()

        Categories:Init(
            Context
        )

    end)

if not CategoriesSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Categories."
    )

    return

end

--==================================================
-- SEARCH
--==================================================

pcall(function()

    Search:Init(
        Context
    )

end)

--==================================================
-- SETTINGS
--==================================================

pcall(function()

    Settings:Init(
        Context
    )

end)

--==================================================
-- RGB
--==================================================

pcall(function()

    RGB:Init(
        Context
    )

end)

--==================================================
-- SEARCH CONNECT
--==================================================

if type(Search.Connect) == "function" then

    pcall(function()

        Search:Connect()

    end)

end

--==================================================
-- CREATE CATEGORIES
--==================================================

if type(
    Categories.CreateCategories
) == "function" then

    local Success, Error =
        pcall(function()

            Categories:CreateCategories()

        end)

    if not Success then

        warn(
            "❌ Rimuru Hub: erro ao criar categorias."
        )

        warn(
            tostring(Error)
        )

        return

    end

end

--==================================================
-- CONFIG BUTTON
--==================================================

local ConfigButton =
    Categories.ConfigButton

if ConfigButton then

    ConfigButton.MouseButton1Click:Connect(
        function()

            if type(Settings.Show) == "function" then

                pcall(function()

                    Settings:Show()

                end)

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

    pcall(function()

        Categories:SetDefaultCategory()

    end)

end

--==================================================
-- INITIAL UI
--==================================================

if type(UI.SetVisible) == "function" then

    UI:SetVisible(
        false
    )

end

--==================================================
-- INITIAL LOGO
--==================================================

if type(Logo.SetVisible) == "function" then

    pcall(function()

        Logo:SetVisible(
            Config.UI.ShowLogo ~= false
        )

    end)

end

--==================================================
-- APPLY THEME
--==================================================

if type(UI.ApplyTheme) == "function" then

    pcall(function()

        UI:ApplyTheme()

    end)

end

if type(Logo.ApplyTheme) == "function" then

    pcall(function()

        Logo:ApplyTheme()

    end)

end

if type(Categories.ApplyTheme) == "function" then

    pcall(function()

        Categories:ApplyTheme()

    end)

end

if type(Search.ApplyTheme) == "function" then

    pcall(function()

        Search:ApplyTheme()

    end)

end

--==================================================
-- LOADED
--==================================================

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

print(
    "bem vindo ao mundo, Rimuru Hub."
)

print(
    "🎨 Tema: " ..
    tostring(
        Theme:GetCurrentName()
        or "Rimuru Dark"
    )
)

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

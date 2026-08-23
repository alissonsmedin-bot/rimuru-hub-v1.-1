--// 💥 RIMURU HUB
--// MAIN LOADER
--// STABLE MODULAR VERSION
--// THEME FIX
--// UI FIX
--// SEARCH CONTEXT FIX
--// FAVORITES INIT FIX
--// SAFE INITIALIZATION
--// CONFIGURATION CONTEXT FIX

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

--==================================================
-- PLAYER GUI
--==================================================

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
-- LOAD MODULE
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

            if not Source
            or Source == "" then

                error(
                    "Fonte vazia para " ..
                    FileName
                )

            end

            local Loader =
                loadstring(
                    Source
                )

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
            tostring(
                Result
            )
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
    Load(
        "sound.lua"
    )

if not Sounds then

    warn(
        "❌ Rimuru Hub: Sounds não carregado."
    )

    return

end

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
    Load(
        "theme.lua"
    )

local UI =
    Load(
        "ui.lua"
    )

local Logo =
    Load(
        "logo.lua"
    )

local Cards =
    Load(
        "cards.lua"
    )

local Favorites =
    Load(
        "favorites.lua"
    )

local Search =
    Load(
        "search.lua"
    )

local Categories =
    Load(
        "categories.lua"
    )

local Settings =
    Load(
        "settings.lua"
    )

local RGB =
    Load(
        "RGB.lua"
    )

--==================================================
-- VERIFY MODULES
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
    pairs(
        Modules
    ) do

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
-- THEME
--==================================================
-- Theme recebe Config diretamente.
--==================================================

local ThemeSuccess,
      ThemeError =
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
        tostring(
            ThemeError
        )
    )

    return

end

--==================================================
-- UI
--==================================================

local UISuccess,
      UIError =
    pcall(function()

        UI:Init(
            Context
        )

    end)

if not UISuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar UI."
    )

    warn(
        tostring(
            UIError
        )
    )

    return

end

--==================================================
-- LOGO
--==================================================

local LogoSuccess,
      LogoError =
    pcall(function()

        Logo:Init(
            Context
        )

    end)

if not LogoSuccess then

    warn(
        "⚠️ Rimuru Hub: erro ao inicializar Logo."
    )

    warn(
        tostring(
            LogoError
        )
    )

end

--==================================================
-- CARDS
--==================================================

local CardsSuccess,
      CardsError =
    pcall(function()

        Cards:Init(
            Context
        )

    end)

if not CardsSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Cards."
    )

    warn(
        tostring(
            CardsError
        )
    )

    return

end

--==================================================
-- FAVORITES
--==================================================
-- Favorites agora possui Init(Context).
--==================================================

local FavoritesSuccess,
      FavoritesError =
    pcall(function()

        Favorites:Init(
            Context
        )

    end)

if not FavoritesSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Favorites."
    )

    warn(
        tostring(
            FavoritesError
        )
    )

    return

end

--==================================================
-- CATEGORIES
--==================================================

local CategoriesSuccess,
      CategoriesError =
    pcall(function()

        Categories:Init(
            Context
        )

    end)

if not CategoriesSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Categories."
    )

    warn(
        tostring(
            CategoriesError
        )
    )

    return

end

--==================================================
-- SEARCH
--==================================================

local SearchSuccess,
      SearchError =
    pcall(function()

        Search:Init(
            Context
        )

    end)

if not SearchSuccess then

    warn(
        "❌ Rimuru Hub: erro ao inicializar Search."
    )

    warn(
        tostring(
            SearchError
        )
    )

    return

end

--==================================================
-- SETTINGS
--==================================================

local SettingsSuccess,
      SettingsError =
    pcall(function()

        Settings:Init(
            Context
        )

    end)

if not SettingsSuccess then

    warn(
        "⚠️ Rimuru Hub: erro ao inicializar Settings."
    )

    warn(
        tostring(
            SettingsError
        )
    )

end

--==================================================
-- RGB
--==================================================

local RGBSuccess,
      RGBError =
    pcall(function()

        RGB:Init(
            Context
        )

    end)

if not RGBSuccess then

    warn(
        "⚠️ Rimuru Hub: erro ao inicializar RGB."
    )

    warn(
        tostring(
            RGBError
        )
    )

end

--==================================================
-- SEARCH CONNECT
--==================================================

if type(
    Search.Connect
) == "function" then

    local Success,
          Error =
        pcall(function()

            Search:Connect()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao conectar Search."
        )

        warn(
            tostring(
                Error
            )
        )

    end

end

--==================================================
-- CREATE CATEGORIES
--==================================================

if type(
    Categories.CreateCategories
) == "function" then

    local Success,
          Error =
        pcall(function()

            Categories:CreateCategories()

        end)

    if not Success then

        warn(
            "❌ Rimuru Hub: erro ao criar categorias."
        )

        warn(
            tostring(
                Error
            )
        )

        return

    end

else

    warn(
        "❌ Rimuru Hub: Categories.CreateCategories não encontrado."
    )

    return

end

--==================================================
-- CONFIG BUTTON
--==================================================
-- Configuração não é uma categoria de sons.
-- O próprio Categories controla o contexto dela.
--==================================================

local ConfigButton =
    Categories.ConfigButton

if ConfigButton then

    ConfigButton.MouseButton1Click:Connect(

        function()

            --==================================================
            -- LIMPAR PESQUISA
            --==================================================

            if Search
            and type(
                Search.ClearForContext
            ) == "function" then

                pcall(function()

                    Search:ClearForContext()

                end)

            end

            --==================================================
            -- ESCONDER FILTRO
            --==================================================

            if Categories.FilterButton then

                Categories.FilterButton.Visible =
                    false

            end

            if type(
                Categories.CloseFilterMenu
            ) == "function" then

                pcall(function()

                    Categories:CloseFilterMenu()

                end)

            end

            --==================================================
            -- MOSTRAR SETTINGS
            --==================================================

            if type(
                Settings.Show
            ) == "function" then

                local Success,
                      Error =
                    pcall(function()

                        Settings:Show()

                    end)

                if not Success then

                    warn(
                        "⚠️ Rimuru Hub: erro ao abrir Settings."
                    )

                    warn(
                        tostring(
                            Error
                        )
                    )

                end

            end

        end

    )

else

    warn(
        "⚠️ Rimuru Hub: ConfigButton não encontrado."
    )

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

if type(
    Categories.SetDefaultCategory
) == "function" then

    local Success,
          Error =
        pcall(function()

            Categories:SetDefaultCategory()

        end)

    if not Success then

        warn(
            "❌ Rimuru Hub: erro ao definir categoria padrão."
        )

        warn(
            tostring(
                Error
            )
        )

        return

    end

else

    warn(
        "❌ Rimuru Hub: SetDefaultCategory não encontrado."
    )

    return

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
-- FINAL VISIBILITY
--==================================================

if type(
    Search.SetVisible
) == "function" then

    pcall(function()

        Search:SetVisible(
            true
        )

    end)

end

--==================================================
-- LOADED
--==================================================

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

print(
    "🌓seja bem vindo ao mundo, Rimuru Hub. 🌓"
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

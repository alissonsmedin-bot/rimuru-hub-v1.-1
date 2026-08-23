--// 💥 RIMURU HUB
--// MAIN LOADER / CONNECTOR
--// STABLE MODULAR VERSION
--// THEME FIXED
--// UI FIXED
--// SAFE MODULE INITIALIZATION
--// SAFE FALLBACK SYSTEM
--// SEARCH COMPATIBLE
--// CATEGORIES COMPATIBLE
--// FAVORITES COMPATIBLE
--// SETTINGS COMPATIBLE
--// RGB COMPATIBLE

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

    if type(FileName) ~= "string"
    or FileName == "" then

        warn(
            "❌ Rimuru Hub: nome de arquivo inválido."
        )

        return nil

    end

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
                    "arquivo retornou conteúdo vazio"
                )

            end

            local Module =
                loadstring(
                    Source
                )

            if type(Module) ~= "function" then

                error(
                    "loadstring não retornou uma função"
                )

            end

            return Module()

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

    if Result == nil then

        warn(
            "❌ Rimuru Hub: " ..
            FileName ..
            " não retornou um módulo válido."
        )

        return nil

    end

    return Result

end

--==================================================
-- LOAD CONFIG
--==================================================

local Config =
    Load(
        "config.lua"
    )

if type(Config) ~= "table" then

    warn(
        "❌ Rimuru Hub: Config não carregado."
    )

    return

end

--==================================================
-- VALIDATE CONFIG
--==================================================

if type(Config.UI) ~= "table" then

    warn(
        "❌ Rimuru Hub: Config.UI não encontrado."
    )

    return

end

--==================================================
-- LOAD SOUNDS
--==================================================

local Sounds =
    Load(
        "sound.lua"
    )

if type(Sounds) ~= "table" then

    warn(
        "❌ Rimuru Hub: Sounds não carregado."
    )

    return

end

--==================================================
-- LOAD SYSTEMS
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
        RGB,

}

for Name, Module in pairs(
    Modules
) do

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
        RGB,

}

--==================================================
-- SAFE CALL
--==================================================

local function SafeCall(
    Module,
    Method,
    ...
)

    if type(Module) ~= "table" then

        warn(
            "❌ Rimuru Hub: módulo inválido ao executar " ..
            tostring(Method)
        )

        return false

    end

    if type(Module[Method]) ~= "function" then

        warn(
            "❌ Rimuru Hub: método " ..
            tostring(Method) ..
            " não encontrado."
        )

        return false

    end

    local Success, Result =
        pcall(
            function()

                return Module[Method](
                    Module,
                    ...

                )

            end
        )

    if not Success then

        warn(
            "❌ Rimuru Hub: erro em " ..
            tostring(Method)
        )

        warn(
            tostring(Result)
        )

        return false

    end

    return true, Result

end

--==================================================
-- THEME INITIALIZATION
--==================================================
-- IMPORTANTE:
--
-- theme.lua recebe CONFIG diretamente.
--
-- ANTES:
-- Theme:Init(Context)
--
-- ERRADO.
--
-- AGORA:
-- Theme:Init(Config)
--
-- CORRETO.

local ThemeSuccess =
    SafeCall(
        Theme,
        "Init",
        Config
    )

if not ThemeSuccess then

    warn(
        "⚠️ Rimuru Hub: Theme iniciou com problemas."
    )

end

--==================================================
-- CHECK CURRENT THEME
--==================================================

local CurrentTheme

pcall(function()

    if type(Theme.GetCurrent) == "function" then

        CurrentTheme =
            Theme:GetCurrent()

    end

end)

if type(CurrentTheme) ~= "table" then

    warn(
        "⚠️ Rimuru Hub: tema atual não foi criado."
    )

else

    print(
        "🎨 Rimuru Hub: tema carregado -> " ..
        tostring(
            CurrentTheme.Name
        )
    )

end

--==================================================
-- UI INITIALIZATION
--==================================================

local UISuccess =
    SafeCall(
        UI,
        "Init",
        Context
    )

if not UISuccess then

    warn(
        "❌ Rimuru Hub: UI não pôde ser inicializada."
    )

    return

end

--==================================================
-- LOGO INITIALIZATION
--==================================================

local LogoSuccess =
    SafeCall(
        Logo,
        "Init",
        Context
    )

if not LogoSuccess then

    warn(
        "⚠️ Rimuru Hub: Logo iniciou com problemas."
    )

end

--==================================================
-- CARDS INITIALIZATION
--==================================================

local CardsSuccess =
    SafeCall(
        Cards,
        "Init",
        Context
    )

if not CardsSuccess then

    warn(
        "⚠️ Rimuru Hub: Cards iniciou com problemas."
    )

end

--==================================================
-- FAVORITES INITIALIZATION
--==================================================

local FavoritesSuccess =
    SafeCall(
        Favorites,
        "Init",
        Context
    )

if not FavoritesSuccess then

    warn(
        "⚠️ Rimuru Hub: Favorites iniciou com problemas."
    )

end

--==================================================
-- CATEGORIES INITIALIZATION
--==================================================

local CategoriesSuccess =
    SafeCall(
        Categories,
        "Init",
        Context
    )

if not CategoriesSuccess then

    warn(
        "❌ Rimuru Hub: Categories não pôde ser inicializado."
    )

    return

end

--==================================================
-- SEARCH INITIALIZATION
--==================================================

local SearchSuccess =
    SafeCall(
        Search,
        "Init",
        Context
    )

if not SearchSuccess then

    warn(
        "⚠️ Rimuru Hub: Search iniciou com problemas."
    )

end

--==================================================
-- SETTINGS INITIALIZATION
--==================================================

local SettingsSuccess =
    SafeCall(
        Settings,
        "Init",
        Context
    )

if not SettingsSuccess then

    warn(
        "⚠️ Rimuru Hub: Settings iniciou com problemas."
    )

end

--==================================================
-- RGB INITIALIZATION
--==================================================

local RGBSuccess =
    SafeCall(
        RGB,
        "Init",
        Context
    )

if not RGBSuccess then

    warn(
        "⚠️ Rimuru Hub: RGB iniciou com problemas."
    )

end

--==================================================
-- SEARCH CONNECT
--==================================================

if SearchSuccess
and type(Search.Connect) == "function" then

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

if CategoriesSuccess
and type(
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

local ConfigButton

pcall(function()

    ConfigButton =
        Categories.ConfigButton

end)

if ConfigButton
and ConfigButton:IsA("GuiButton") then

    ConfigButton.MouseButton1Click:Connect(
        function()

            if type(Settings.Show) == "function" then

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
                    "⚠️ Rimuru Hub: Settings:Show() não encontrado."
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
-- CLOSE BUTTON
--==================================================
-- O UI já cria seu próprio evento de Close.
--
-- Este bloco serve apenas para sincronizar
-- o Logo quando o menu for fechado.

if UI.Close
and UI.Close:IsA("GuiButton") then

    UI.Close.MouseButton1Click:Connect(
        function()

            if type(UI.SetVisibleAnimated)
                == "function" then

                UI:SetVisibleAnimated(
                    false
                )

            elseif type(UI.SetVisible)
                == "function" then

                UI:SetVisible(
                    false
                )

            end

            if Config.UI.ShowLogo
            and type(Logo.SetVisible)
                == "function" then

                pcall(function()

                    Logo:SetVisible(
                        true
                    )

                end)

            end

        end
    )

end

--==================================================
-- INITIAL UI STATE
--==================================================

if type(UI.SetVisible) == "function" then

    UI:SetVisible(
        false
    )

end

--==================================================
-- INITIAL LOGO STATE
--==================================================

if type(Logo.SetVisible) == "function" then

    local ShowLogo =
        Config.UI.ShowLogo

    if ShowLogo == nil then

        ShowLogo =
            true

    end

    pcall(function()

        Logo:SetVisible(
            ShowLogo == true
        )

    end)

end

--==================================================
-- APPLY THEME TO UI
--==================================================

if type(UI.ApplyTheme) == "function" then

    local Success, Error =
        pcall(function()

            UI:ApplyTheme()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao aplicar tema na UI."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- APPLY THEME TO LOGO
--==================================================

if type(Logo.ApplyTheme) == "function" then

    local Success, Error =
        pcall(function()

            Logo:ApplyTheme()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao aplicar tema no Logo."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- APPLY THEME TO CATEGORIES
--==================================================

if type(Categories.ApplyTheme) == "function" then

    local Success, Error =
        pcall(function()

            Categories:ApplyTheme()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao aplicar tema nas categorias."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- APPLY THEME TO SEARCH
--==================================================

if type(Search.ApplyTheme) == "function" then

    local Success, Error =
        pcall(function()

            Search:ApplyTheme()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: erro ao aplicar tema no Search."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- RGB
--==================================================

if type(RGB.Start) == "function" then

    local Success, Error =
        pcall(function()

            RGB:Start()

        end)

    if not Success then

        warn(
            "⚠️ Rimuru Hub: RGB não pôde iniciar."
        )

        warn(
            tostring(Error)
        )

    end

end

--==================================================
-- FINAL VALIDATION
--==================================================

if not UI.Main then

    warn(
        "❌ Rimuru Hub: UI.Main não foi criada."
    )

    return

end

if not UI.Scroll then

    warn(
        "⚠️ Rimuru Hub: ContentScroll não foi criado."
    )

end

if not Categories.Sidebar
and not UI.Sidebar then

    warn(
        "⚠️ Rimuru Hub: Sidebar não encontrada."
    )

end

--==================================================
-- LOADED
--==================================================

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

print(
    "💥 Rimuru Hub carregado com sucesso!"
)

print(
    "🎨 Tema: " ..
    tostring(
        CurrentTheme
        and CurrentTheme.Name
        or "Rimuru Dark"
    )
)

print(
    "📦 Módulos: OK"
)

print(
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

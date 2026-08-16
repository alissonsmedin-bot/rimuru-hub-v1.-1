--// 💥 RIMURU HUB
--// MAIN SYSTEM
--// REMOTE MODULE LOADER
--// GitHub Modular Architecture
--// Config + Theme + UI + Logo + Categories + Cards
--// Sound + Settings + RGB + Search + Favorites
--// Background handled by UI.lua
--// No script.Parent dependency

local RimuruHub = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local Player =
    Players.LocalPlayer

if not Player then

    warn(
        "[Rimuru Hub] LocalPlayer não encontrado."
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
-- GITHUB BASE URL
--==================================================

local BaseURL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/"

--==================================================
-- REMOTE CACHE
--==================================================

local ModuleCache =
    {}

--==================================================
-- LOAD REMOTE MODULE
--==================================================

local function LoadModule(
    FileName
)

    if type(FileName) ~= "string"
    or FileName == ""
    then

        warn(
            "[Rimuru Hub] Nome de módulo inválido."
        )

        return nil

    end

    --==================================================
    -- CACHE
    --==================================================

    if ModuleCache[FileName] ~= nil then

        return ModuleCache[FileName]

    end

    --==================================================
    -- URL
    --==================================================

    local URL =
        BaseURL
        .. FileName

    print(
        "[Rimuru Hub] Carregando: "
        .. FileName
    )

    --==================================================
    -- HTTP GET
    --==================================================

    local HttpSuccess,
        Source =
        pcall(
            function()

                return game:HttpGet(
                    URL
                )

            end
        )

    if not HttpSuccess then

        warn(
            "[Rimuru Hub] Falha HTTP ao carregar "
            .. FileName
            .. ": "
            .. tostring(Source)
        )

        return nil

    end

    if type(Source) ~= "string"
    or Source == ""
    then

        warn(
            "[Rimuru Hub] Arquivo vazio: "
            .. FileName
        )

        return nil

    end

    --==================================================
    -- COMPILE
    --==================================================

    local CompileSuccess,
        Chunk =
        pcall(
            loadstring,
            Source
        )

    if not CompileSuccess
    or type(Chunk) ~= "function"
    then

        warn(
            "[Rimuru Hub] Erro de compilação em "
            .. FileName
            .. ": "
            .. tostring(Chunk)
        )

        return nil

    end

    --==================================================
    -- EXECUTE
    --==================================================

    local ExecuteSuccess,
        Result =
        pcall(
            Chunk
        )

    if not ExecuteSuccess then

        warn(
            "[Rimuru Hub] Erro ao executar "
            .. FileName
            .. ": "
            .. tostring(Result)
        )

        return nil

    end

    --==================================================
    -- CACHE
    --==================================================

    ModuleCache[FileName] =
        Result

    print(
        "[Rimuru Hub] OK: "
        .. FileName
    )

    return Result

end

--==================================================
-- SAFE INIT
--==================================================

local function InitModule(
    Name,
    Module,
    Context
)

    if not Module then

        warn(
            "[Rimuru Hub] "
            .. Name
            .. " não foi carregado."
        )

        return false

    end

    if type(Module.Init) ~= "function" then

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
                    Context
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
-- LOAD CONFIG
--==================================================

local Config =
    LoadModule(
        "config.lua"
    )

if not Config then

    warn(
        "[Rimuru Hub] Config não carregado."
    )

    return

end

--==================================================
-- LOAD SOUND
--==================================================

local Sound =
    LoadModule(
        "sound.lua"
    )

if not Sound then

    warn(
        "[Rimuru Hub] Sound não carregado."
    )

    return

end

--==================================================
-- LOAD THEME
--==================================================

local Theme =
    LoadModule(
        "theme.lua"
    )

if not Theme then

    warn(
        "[Rimuru Hub] Theme não carregado."
    )

    return

end

--==================================================
-- LOAD UI
--==================================================

local UI =
    LoadModule(
        "ui.lua"
    )

if not UI then

    warn(
        "[Rimuru Hub] UI não carregada."
    )

    return

end

--==================================================
-- LOAD LOGO
--==================================================

local Logo =
    LoadModule(
        "logo.lua"
    )

--==================================================
-- LOAD CATEGORIES
--==================================================

local Categories =
    LoadModule(
        "categories.lua"
    )

--==================================================
-- LOAD CARDS
--==================================================

local Cards =
    LoadModule(
        "cards.lua"
    )

--==================================================
-- LOAD SETTINGS
--==================================================

local Settings =
    LoadModule(
        "settings.lua"
    )

--==================================================
-- LOAD RGB
--==================================================

local RGB =
    LoadModule(
        "RGB.lua"
    )

--==================================================
-- LOAD SEARCH
--==================================================

local Search =
    LoadModule(
        "search.lua"
    )

--==================================================
-- LOAD FAVORITES
--==================================================

local Favorites =
    LoadModule(
        "favorites.lua"
    )

--==================================================
-- VERIFY REQUIRED MODULES
--==================================================

local RequiredModules = {

    Theme =
        Theme,

    UI =
        UI,

    Logo =
        Logo,

    Categories =
        Categories,

    Cards =
        Cards,

    Settings =
        Settings,

    RGB =
        RGB,

    Search =
        Search,

    Favorites =
        Favorites,

}

for Name, Module in
    pairs(
        RequiredModules
    )
do

    if not Module then

        warn(
            "[Rimuru Hub] Módulo obrigatório ausente: "
            .. Name
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

    Sound =
        Sound,

    Sounds =
        Sound,

    Theme =
        Theme,

    UI =
        UI,

    Logo =
        Logo,

    Categories =
        Categories,

    Cards =
        Cards,

    Settings =
        Settings,

    RGB =
        RGB,

    Search =
        Search,

    Favorites =
        Favorites,

}

RimuruHub.Context =
    Context

--==================================================
-- EXPOSE MODULES
--==================================================

RimuruHub.Config =
    Config

RimuruHub.Sound =
    Sound

RimuruHub.Sounds =
    Sound

RimuruHub.Theme =
    Theme

RimuruHub.UI =
    UI

RimuruHub.Logo =
    Logo

RimuruHub.Categories =
    Categories

RimuruHub.Cards =
    Cards

RimuruHub.Settings =
    Settings

RimuruHub.RGB =
    RGB

RimuruHub.Search =
    Search

RimuruHub.Favorites =
    Favorites

--==================================================
-- 1. THEME
--==================================================

if not InitModule(
    "Theme",
    Theme,
    Context
)
then

    return

end

--==================================================
-- 2. UI
--==================================================

if not InitModule(
    "UI",
    UI,
    Context
)
then

    return

end

--==================================================
-- 3. LOGO
--==================================================

if not InitModule(
    "Logo",
    Logo,
    Context
)
then

    return

end

--==================================================
-- 4. CARDS
--==================================================

if not InitModule(
    "Cards",
    Cards,
    Context
)
then

    return

end

--==================================================
-- 5. CATEGORIES
--==================================================

if not InitModule(
    "Categories",
    Categories,
    Context
)
then

    return

end

--==================================================
-- 6. SEARCH
--==================================================

if not InitModule(
    "Search",
    Search,
    Context
)
then

    return

end

--==================================================
-- 7. SETTINGS
--==================================================

if not InitModule(
    "Settings",
    Settings,
    Context
)
then

    return

end

--==================================================
-- 8. RGB
--==================================================

if not InitModule(
    "RGB",
    RGB,
    Context
)
then

    return

end

--==================================================
-- 9. FAVORITES
--==================================================

if not InitModule(
    "Favorites",
    Favorites,
    Context
)
then

    return

end

--==================================================
-- SEARCH CONNECT
--==================================================

if type(
    Search.Connect
) == "function"
then

    local Success,
        Error =
        pcall(
            function()

                Search:Connect()

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao conectar Search: "
            .. tostring(Error)
        )

    end

end

--==================================================
-- CREATE CATEGORIES
--==================================================

if type(
    Categories.CreateCategories
) == "function"
then

    local Success,
        Error =
        pcall(
            function()

                Categories:
                    CreateCategories()

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao criar categorias: "
            .. tostring(Error)
        )

    end

end

--==================================================
-- CONFIGURATION BUTTON
--==================================================

local ConfigButton =
    Categories.ConfigButton

if ConfigButton
and type(
    ConfigButton.MouseButton1Click
) == "userdata"
then

    ConfigButton.MouseButton1Click:
        Connect(
            function()

                if type(
                    Settings.Show
                ) == "function"
                then

                    pcall(
                        function()

                            Settings:
                                Show()

                        end
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
) == "function"
then

    pcall(
        function()

            Categories:
                SetDefaultCategory()

        end
    )

end

--==================================================
-- CLOSE BUTTON
--==================================================

if UI.Close then

    UI.Close.MouseButton1Click:
        Connect(
            function()

                if type(
                    UI.SetVisible
                ) == "function"
                then

                    pcall(
                        function()

                            UI:
                                SetVisible(
                                    false
                                )

                        end
                    )

                elseif UI.Main then

                    UI.Main.Visible =
                        false

                end

                --==================================================
                -- SHOW LOGO
                --==================================================

                if Config.UI
                and Config.UI.ShowLogo
                and Logo
                and type(
                    Logo.SetVisible
                ) == "function"
                then

                    pcall(
                        function()

                            Logo:
                                SetVisible(
                                    true
                                )

                        end
                    )

                end

            end
        )

end

--==================================================
-- INITIAL STATE
--==================================================

if type(
    UI.SetVisible
) == "function"
then

    pcall(
        function()

            UI:
                SetVisible(
                    false
                )

        end
    )

elseif UI.Main then

    UI.Main.Visible =
        false

end

--==================================================
-- INITIAL LOGO
--==================================================

if Logo
and type(
    Logo.SetVisible
) == "function"
then

    local ShowLogo =
        true

    if Config.UI
    and Config.UI.ShowLogo ~= nil
    then

        ShowLogo =
            Config.UI.ShowLogo == true

    end

    pcall(
        function()

            Logo:
                SetVisible(
                    ShowLogo
                )

        end
    )

end

--==================================================
-- INITIAL THEME
--==================================================

if type(
    UI.ApplyTheme
) == "function"
then

    pcall(
        function()

            UI:
                ApplyTheme()

        end
    )

end

if Logo
and type(
    Logo.ApplyTheme
) == "function"
then

    pcall(
        function()

            Logo:
                ApplyTheme()

        end
    )

end

if Categories
and type(
    Categories.ApplyTheme
) == "function"
then

    pcall(
        function()

            Categories:
                ApplyTheme()

        end
    )

end

if Search
and type(
    Search.ApplyTheme
) == "function"
then

    pcall(
        function()

            Search:
                ApplyTheme()

        end
    )

end

--==================================================
-- OPEN
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

        local Success =
            pcall(
                function()

                    self.UI:
                        SetVisible(
                            true
                        )

                end
            )

        if Success then

            if self.Logo
            and type(
                self.Logo.SetVisible
            ) == "function"
            then

                pcall(
                    function()

                        self.Logo:
                            SetVisible(
                                false
                            )

                    end
                )

            end

            return true

        end

    end

    if self.UI.Main then

        self.UI.Main.Visible =
            true

        return true

    end

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

        local Success =
            pcall(
                function()

                    self.UI:
                        SetVisible(
                            false
                        )

                end
            )

        if Success then

            if self.Logo
            and type(
                self.Logo.SetVisible
            ) == "function"
            then

                pcall(
                    function()

                        self.Logo:
                            SetVisible(
                                true
                            )

                    end
                )

            end

            return true

        end

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

    local Visible

    if self.UI.Main then

        Visible =
            not self.UI.Main.Visible

    else

        Visible =
            true

    end

    if Visible then

        self:Open()

    else

        self:Close()

    end

    return Visible

end

--==================================================
-- GET MODULE
--==================================================

function RimuruHub:GetModule(
    Name
)

    return self[
        Name
    ]

end

--==================================================
-- STATUS
--==================================================

function RimuruHub:GetStatus()

    return {

        Config =
            self.Config ~= nil,

        Sound =
            self.Sound ~= nil,

        Theme =
            self.Theme ~= nil,

        UI =
            self.UI ~= nil,

        Logo =
            self.Logo ~= nil,

        Categories =
            self.Categories ~= nil,

        Cards =
            self.Cards ~= nil,

        Settings =
            self.Settings ~= nil,

        RGB =
            self.RGB ~= nil,

        Search =
            self.Search ~= nil,

        Favorites =
            self.Favorites ~= nil,

    }

end

--==================================================
-- STARTUP MESSAGE
--==================================================

print(
    "========================================"
)

print(
    "💥 RIMURU HUB"
)

print(
    "Remote Modular System"
)

print(
    "GitHub Loader: OK"
)

print(
    "========================================"
)

--==================================================
-- RETURN
--==================================================

return RimuruHub

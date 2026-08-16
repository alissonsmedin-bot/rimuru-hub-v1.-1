--// 💥 RIMURU HUB
--// MAIN SYSTEM
--// CENTRAL MODULE LOADER
--// Modular Architecture
--// Config + Theme + Background + UI + Logo
--// Categories + Cards + Sound + Favorites
--// Settings + RGB
--// FIXED CONTEXT + CATEGORY STARTUP
--// Remote / Local Compatible

local RimuruHub = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local Player =
    Players.LocalPlayer

--==================================================
-- MODULE PATH
--==================================================

local Root =
    script.Parent

--==================================================
-- MODULE LOADER
--==================================================

local function LoadModule(Name)

    if not Root then

        warn(
            "[Rimuru Hub] Root não encontrado."
        )

        return nil

    end

    local Module =
        Root:FindFirstChild(
            Name
        )

    if not Module then

        warn(
            "[Rimuru Hub] Módulo não encontrado: "
            .. tostring(Name)
        )

        return nil

    end

    local Success,
        Result =
        pcall(
            function()

                return require(
                    Module
                )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao carregar "
            .. tostring(Name)
            .. ": "
            .. tostring(Result)
        )

        return nil

    end

    return Result

end

--==================================================
-- LOAD MODULES
--==================================================

RimuruHub.Config =
    LoadModule(
        "config"
    )

RimuruHub.Sound =
    LoadModule(
        "sound"
    )

RimuruHub.Theme =
    LoadModule(
        "theme"
    )

RimuruHub.Background =
    LoadModule(
        "background"
    )

RimuruHub.UI =
    LoadModule(
        "ui"
    )

RimuruHub.Logo =
    LoadModule(
        "logo"
    )

RimuruHub.Favorites =
    LoadModule(
        "favorites"
    )

RimuruHub.Cards =
    LoadModule(
        "cards"
    )

RimuruHub.Categories =
    LoadModule(
        "categories"
    )

RimuruHub.Settings =
    LoadModule(
        "settings"
    )

RimuruHub.RGB =
    LoadModule(
        "RGB"
    )

--==================================================
-- PLAYER GUI
--==================================================

local PlayerGui

if Player then

    local Success,
        Result =
        pcall(
            function()

                return Player:
                    WaitForChild(
                        "PlayerGui"
                    )

            end
        )

    if Success then

        PlayerGui =
            Result

    end

end

--==================================================
-- CONTEXT
--==================================================

RimuruHub.Context = {

    Player =
        Player,

    PlayerGui =
        PlayerGui,

    --==================================================
    -- CORE
    --==================================================

    Config =
        RimuruHub.Config,

    Theme =
        RimuruHub.Theme,

    Background =
        RimuruHub.Background,

    UI =
        RimuruHub.UI,

    Logo =
        RimuruHub.Logo,

    --==================================================
    -- SOUND
    --==================================================

    Sound =
        RimuruHub.Sound,

    -- IMPORTANT:
    -- categories.lua usa Context.Sounds
    -- cards.lua usa Context.Sounds
    Sounds =
        RimuruHub.Sound,

    --==================================================
    -- CONTENT
    --==================================================

    Categories =
        RimuruHub.Categories,

    Cards =
        RimuruHub.Cards,

    --==================================================
    -- FAVORITES
    --==================================================

    Favorites =
        RimuruHub.Favorites,

    --==================================================
    -- OTHER
    --==================================================

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
            .. tostring(Name)
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
            .. tostring(Name)
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
            .. tostring(Name)
            .. ": "
            .. tostring(Error)
        )

        return false

    end

    print(
        "[Rimuru Hub] "
        .. tostring(Name)
        .. " iniciado."
    )

    return true

end

--==================================================
-- INITIALIZATION ORDER
--==================================================

--==================================================
-- 1. CONFIG
--==================================================

InitModule(
    "Config",
    RimuruHub.Config
)

--==================================================
-- 2. SOUND
--==================================================

InitModule(
    "Sound",
    RimuruHub.Sound
)

--==================================================
-- 3. UI
--==================================================

InitModule(
    "UI",
    RimuruHub.UI
)

--==================================================
-- 4. BACKGROUND
--==================================================

InitModule(
    "Background",
    RimuruHub.Background
)

--==================================================
-- 5. THEME
--==================================================

InitModule(
    "Theme",
    RimuruHub.Theme
)

--==================================================
-- 6. LOGO
--==================================================

InitModule(
    "Logo",
    RimuruHub.Logo
)

--==================================================
-- 7. FAVORITES
--==================================================

InitModule(
    "Favorites",
    RimuruHub.Favorites
)

--==================================================
-- 8. CARDS
--==================================================

InitModule(
    "Cards",
    RimuruHub.Cards
)

--==================================================
-- 9. CATEGORIES
--==================================================

InitModule(
    "Categories",
    RimuruHub.Categories
)

--==================================================
-- 10. SETTINGS
--==================================================

InitModule(
    "Settings",
    RimuruHub.Settings
)

--==================================================
-- 11. RGB
--==================================================

InitModule(
    "RGB",
    RimuruHub.RGB
)

--==================================================
-- APPLY INITIAL THEME
--==================================================

task.defer(
    function()

        task.wait(
            0.1
        )

        if RimuruHub.Theme
        and RimuruHub.UI
        and type(
            RimuruHub.Theme.GetName
        ) == "function"
        then

            local Success,
                Error =
                pcall(
                    function()

                        if type(
                            RimuruHub.UI.ApplyTheme
                        ) == "function"
                        then

                            RimuruHub.UI:
                                ApplyTheme()

                        end

                    end
                )

            if not Success then

                warn(
                    "[Rimuru Hub] Erro ao aplicar tema inicial: "
                    .. tostring(Error)
                )

            end

        end

    end
)

--==================================================
-- APPLY INITIAL BACKGROUND
--==================================================

task.defer(
    function()

        task.wait(
            0.15
        )

        if not RimuruHub.Background
        or not RimuruHub.Theme
        then

            return

        end

        if type(
            RimuruHub.Background.Apply
        ) ~= "function"
        then

            return

        end

        local ThemeName

        pcall(
            function()

                ThemeName =
                    RimuruHub.Theme:
                    GetName()

            end
        )

        if not ThemeName then
            return
        end

        local Success,
            Error =
            pcall(
                function()

                    RimuruHub.Background:
                        Apply(
                            ThemeName
                        )

                end
            )

        if not Success then

            warn(
                "[Rimuru Hub] Erro ao aplicar background: "
                .. tostring(Error)
            )

        end

    end
)

--==================================================
-- CREATE CATEGORIES
--==================================================

task.defer(
    function()

        task.wait(
            0.2
        )

        local Categories =
            RimuruHub.Categories

        if not Categories then

            warn(
                "[Rimuru Hub] Categories não disponível."
            )

            return

        end

        --==================================================
        -- CREATE CATEGORY BUTTONS
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

                return

            end

        else

            warn(
                "[Rimuru Hub] CreateCategories() não encontrado."
            )

            return

        end

        --==================================================
        -- SELECT DEFAULT CATEGORY
        --==================================================

        if type(
            Categories.SetDefaultCategory
        ) == "function"
        then

            local Success,
                Error =
                pcall(
                    function()

                        Categories:
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

    end
)

--==================================================
-- POST INIT
--==================================================

function RimuruHub:Open()

    if not self.UI then

        warn(
            "[Rimuru Hub] UI não disponível."
        )

        return false

    end

    --==================================================
    -- DIRECT MAIN
    --==================================================

    if self.UI.Main then

        self.UI.Main.Visible =
            true

        return true

    end

    --==================================================
    -- UI OPEN METHOD
    --==================================================

    if type(
        self.UI.Open
    ) == "function"
    then

        local Success,
            Error =
            pcall(
                function()

                    self.UI:
                        Open()

                end
            )

        if not Success then

            warn(
                "[Rimuru Hub] Erro ao abrir UI: "
                .. tostring(Error)
            )

            return false

        end

        return true

    end

    warn(
        "[Rimuru Hub] Não foi possível abrir a UI."
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

    --==================================================
    -- DIRECT MAIN
    --==================================================

    if self.UI.Main then

        self.UI.Main.Visible =
            false

        return true

    end

    --==================================================
    -- UI CLOSE METHOD
    --==================================================

    if type(
        self.UI.Close
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.UI:
                        Close()

                end
            )

        return Success

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

    if self.UI.Main then

        self.UI.Main.Visible =
            not self.UI.Main.Visible

        return
            self.UI.Main.Visible

    end

    if type(
        self.UI.Toggle
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.UI:
                        Toggle()

                end
            )

        if Success then

            return Result

        end

    end

    return false

end

--==================================================
-- GET MODULE
--==================================================

function RimuruHub:GetModule(
    Name
)

    if type(Name) ~= "string" then
        return nil
    end

    return self[
        Name
    ]

end

--==================================================
-- GET STATUS
--==================================================

function RimuruHub:GetStatus()

    return {

        Config =
            self.Config ~= nil,

        Sound =
            self.Sound ~= nil,

        Sounds =
            self.Sound ~= nil,

        Theme =
            self.Theme ~= nil,

        Background =
            self.Background ~= nil,

        UI =
            self.UI ~= nil,

        Logo =
            self.Logo ~= nil,

        Favorites =
            self.Favorites ~= nil,

        Categories =
            self.Categories ~= nil,

        Cards =
            self.Cards ~= nil,

        Settings =
            self.Settings ~= nil,

        RGB =
            self.RGB ~= nil,

    }

end

--==================================================
-- DEBUG STATUS
--==================================================

function RimuruHub:PrintStatus()

    local Status =
        self:GetStatus()

    print(
        "========================================"
    )

    print(
        "💥 RIMURU HUB STATUS"
    )

    print(
        "Config:",
        Status.Config
    )

    print(
        "Sound:",
        Status.Sound
    )

    print(
        "Sounds:",
        Status.Sounds
    )

    print(
        "Theme:",
        Status.Theme
    )

    print(
        "Background:",
        Status.Background
    )

    print(
        "UI:",
        Status.UI
    )

    print(
        "Logo:",
        Status.Logo
    )

    print(
        "Favorites:",
        Status.Favorites
    )

    print(
        "Categories:",
        Status.Categories
    )

    print(
        "Cards:",
        Status.Cards
    )

    print(
        "Settings:",
        Status.Settings
    )

    print(
        "RGB:",
        Status.RGB
    )

    print(
        "========================================"
    )

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
    "Modular System carregado."
)

print(
    "Config System carregado."
)

print(
    "Sound System carregado."
)

print(
    "Theme System carregado."
)

print(
    "UI System carregado."
)

print(
    "Favorites System carregado."
)

print(
    "Categories System carregado."
)

print(
    "Cards System carregado."
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
            0.35
        )

        RimuruHub:
            Open()

    end
)

--==================================================
-- RETURN
--==================================================

return RimuruHub

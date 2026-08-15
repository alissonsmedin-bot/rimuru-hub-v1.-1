--// 💥 RIMURU HUB
--// MAIN SYSTEM
--// CENTRAL MODULE LOADER
--// Modular Architecture
--// Config + Theme + UI + Logo + Categories + Cards + Sound + Settings + RGB

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

local function LoadModule(
    Name
)

    local Module =
        Root:FindFirstChild(
            Name
        )

    if not Module then

        warn(
            "[Rimuru Hub] Módulo não encontrado: "
            .. Name
        )

        return nil

    end

    local Success,
        Result =
        pcall(
            require,
            Module
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao carregar "
            .. Name
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

RimuruHub.Theme =
    LoadModule(
        "theme"
    )

RimuruHub.UI =
    LoadModule(
        "ui"
    )

RimuruHub.Logo =
    LoadModule(
        "logo"
    )

RimuruHub.Categories =
    LoadModule(
        "categories"
    )

RimuruHub.Cards =
    LoadModule(
        "cards"
    )

RimuruHub.Sound =
    LoadModule(
        "sound"
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

    Categories =
        RimuruHub.Categories,

    Cards =
        RimuruHub.Cards,

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

    if type(Module.Init) ~=
        "function" then

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
-- 4. LOGO
--==================================================

InitModule(
    "Logo",
    RimuruHub.Logo
)

--==================================================
-- 5. CATEGORIES
--==================================================

InitModule(
    "Categories",
    RimuruHub.Categories
)

--==================================================
-- 6. CARDS
--==================================================

InitModule(
    "Cards",
    RimuruHub.Cards
)

--==================================================
-- 7. SOUND
--==================================================

InitModule(
    "Sound",
    RimuruHub.Sound
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
-- POST INIT
--==================================================

function RimuruHub:Open()

    if not self.UI then

        warn(
            "[Rimuru Hub] UI não disponível."
        )

        return false

    end

    --================================================
    -- OPEN MAIN
    --================================================

    if self.UI.Main then

        self.UI.Main.Visible =
            true

    elseif type(
        self.UI.Open
    ) == "function" then

        pcall(
            function()

                self.UI:Open()

            end
        )

    else

        warn(
            "[Rimuru Hub] Não foi possível abrir a UI."
        )

        return false

    end

    return true

end

--==================================================
-- CLOSE
--==================================================

function RimuruHub:Close()

    if not self.UI then
        return false
    end

    if self.UI.Main then

        self.UI.Main.Visible =
            false

        return true

    end

    if type(
        self.UI.Close
    ) == "function" then

        local Success =
            pcall(
                function()

                    self.UI:Close()

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
            self.Config ~= nil,

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

        Sound =
            self.Sound ~= nil,

        Settings =
            self.Settings ~= nil,

        RGB =
            self.RGB ~= nil,

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
    "Modular System carregado."
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
            0.15
        )

        RimuruHub:Open()

    end
)

--==================================================
-- RETURN
--==================================================

return RimuruHub

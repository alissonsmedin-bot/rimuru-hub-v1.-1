--// 💥 RIMURU HUB
--// MAIN SYSTEM
--// REMOTE MODULAR LOADER
--// GitHub Architecture
--// Main Modules + UI Folder

local RimuruHub = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local Player =
    Players.LocalPlayer

--==================================================
-- GITHUB CONFIG
--==================================================

local BASE_URL =
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/"

local UI_URL =
    BASE_URL .. "UI/"

--==================================================
-- REMOTE CACHE
--==================================================

local ModuleCache = {}

--==================================================
-- REMOTE LOADER
--==================================================

local function LoadRemote(
    URL,
    Name
)

    if ModuleCache[URL] then

        return ModuleCache[URL]

    end

    print(
        "[Rimuru Hub] Carregando: "
        .. tostring(Name)
    )

    --==================================================
    -- HTTP
    --==================================================

    local SuccessHttp,
        Source =
        pcall(
            function()

                return game:HttpGet(
                    URL
                )

            end
        )

    if not SuccessHttp then

        warn(
            "[Rimuru Hub] Falha HTTP em "
            .. tostring(Name)
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
            .. tostring(Name)
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

    if not SuccessCompile then

        warn(
            "[Rimuru Hub] Erro de compilação em "
            .. tostring(Name)
            .. ": "
            .. tostring(Chunk)
        )

        return nil

    end

    if type(Chunk) ~= "function" then

        warn(
            "[Rimuru Hub] "
            .. tostring(Name)
            .. " não produziu uma função."
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
            .. tostring(Name)
            .. ": "
            .. tostring(Result)
        )

        return nil

    end

    if Result == nil then

        warn(
            "[Rimuru Hub] "
            .. tostring(Name)
            .. " não retornou módulo."
        )

        return nil

    end

    ModuleCache[URL] =
        Result

    print(
        "[Rimuru Hub] OK: "
        .. tostring(Name)
    )

    return Result

end

--==================================================
-- LOAD MAIN MODULE
--==================================================

local function LoadMainModule(
    Name
)

    return LoadRemote(
        BASE_URL
        .. Name
        .. ".lua",
        Name .. ".lua"
    )

end

--==================================================
-- LOAD UI MODULE
--==================================================

local function LoadUIModule(
    Name
)

    return LoadRemote(
        UI_URL
        .. Name
        .. ".lua",
        "UI/" .. Name .. ".lua"
    )

end

--==================================================
-- LOAD MAIN MODULES
--==================================================

RimuruHub.Config =
    LoadMainModule(
        "config"
    )

RimuruHub.Theme =
    LoadMainModule(
        "theme"
    )

RimuruHub.Sound =
    LoadMainModule(
        "sound"
    )

RimuruHub.Favorites =
    LoadMainModule(
        "favorites"
    )

RimuruHub.Logo =
    LoadMainModule(
        "logo"
    )

RimuruHub.Categories =
    LoadMainModule(
        "categories"
    )

RimuruHub.Cards =
    LoadMainModule(
        "cards"
    )

RimuruHub.Settings =
    LoadMainModule(
        "settings"
    )

RimuruHub.RGB =
    LoadMainModule(
        "RGB"
    )

--==================================================
-- UI
--==================================================

RimuruHub.UI =
    LoadUIModule(
        "init"
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

    Favorites =
        RimuruHub.Favorites,

}

--==================================================
-- INIT MODULE
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
-- 3. FAVORITES
--==================================================

InitModule(
    "Favorites",
    RimuruHub.Favorites
)

--==================================================
-- 4. SOUND
--==================================================

InitModule(
    "Sound",
    RimuruHub.Sound
)

--==================================================
-- 5. UI
--==================================================

InitModule(
    "UI",
    RimuruHub.UI
)

--==================================================
-- 6. LOGO
--==================================================

InitModule(
    "Logo",
    RimuruHub.Logo
)

--==================================================
-- 7. CATEGORIES
--==================================================

InitModule(
    "Categories",
    RimuruHub.Categories
)

--==================================================
-- 8. CARDS
--==================================================

InitModule(
    "Cards",
    RimuruHub.Cards
)

--==================================================
-- 9. SETTINGS
--==================================================

InitModule(
    "Settings",
    RimuruHub.Settings
)

--==================================================
-- 10. RGB
--==================================================

InitModule(
    "RGB",
    RimuruHub.RGB
)

--==================================================
-- UI REFERENCE SYNC
--==================================================

if RimuruHub.UI then

    RimuruHub.Context.UI =
        RimuruHub.UI

end

--==================================================
-- RE-INIT DEPENDENT MODULES
--==================================================

-- Alguns módulos dependem da UI já
-- estar construída. Repassamos o Context
-- depois da inicialização da UI.

if RimuruHub.Categories
and type(
    RimuruHub.Categories.Init
) == "function"
then

    pcall(
        function()

            RimuruHub.Categories:
                Init(
                    RimuruHub.Context
                )

        end
    )

end

if RimuruHub.Cards
and type(
    RimuruHub.Cards.Init
) == "function"
then

    pcall(
        function()

            RimuruHub.Cards:
                Init(
                    RimuruHub.Context
                )

        end
    )

end

if RimuruHub.Settings
and type(
    RimuruHub.Settings.Init
) == "function"
then

    pcall(
        function()

            RimuruHub.Settings:
                Init(
                    RimuruHub.Context
                )

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
        self.UI.Open
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.UI:
                        Open()

                end
            )

        return Success

    end

    if self.UI.Main
    and self.UI.Main:IsA("GuiObject")
    then

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

    if self.UI.Main
    and self.UI.Main:IsA("GuiObject")
    then

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

    if self.UI.Main
    and self.UI.Main:IsA("GuiObject")
    then

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

        Sound =
            self.Sound ~= nil,

        Favorites =
            self.Favorites ~= nil,

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

    }

end

--==================================================
-- STARTUP
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
    "UI Folder Loader conectado."
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
            0.5
        )

        RimuruHub:Open()

    end
)

--==================================================
-- RETURN
--==================================================

return RimuruHub

--// 💥 RIMURU HUB
--// Main Loader / Connector

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

local function Load(FileName)

    local URL =
        BaseURL ..
        FileName

    local Success, Result =
        pcall(function()

            return loadstring(
                game:HttpGet(URL)
            )()

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
-- LOAD CONFIGURATION
--==================================================

local Config =
    Load("config.lua")

if not Config then
    return
end

--==================================================
-- LOAD SOUNDS
--==================================================

local Sounds =
    Load("sound.lua")

if not Sounds then
    return
end

--==================================================
-- LOAD SYSTEMS
--==================================================

local Theme =
    Load("theme.lua")

local UI =
    Load("ui.lua")

local Logo =
    Load("logo.lua")

local Cards =
    Load("cards.lua")

local Search =
    Load("search.lua")

local Categories =
    Load("categories.lua")

local Settings =
    Load("settings.lua")

local RGB =
    Load("RGB.lua")

--==================================================
-- VERIFY MODULES
--==================================================

if not Theme then
    return
end

if not UI then
    return
end

if not Logo then
    return
end

if not Cards then
    return
end

if not Search then
    return
end

if not Categories then
    return
end

if not Settings then
    return
end

if not RGB then
    return
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

Theme:Init(
    Context
)

--==================================================
-- UI
--==================================================

UI:Init(
    Context
)

--==================================================
-- LOGO
--==================================================

Logo:Init(
    Context
)

--==================================================
-- CARDS
--==================================================

Cards:Init(
    Context
)

--==================================================
-- SEARCH
--==================================================

Search:Init(
    Context
)

Search:Connect()
--==================================================
-- CATEGORIES
--==================================================

Categories:Init(
    Context
)

--==================================================
-- SETTINGS
--==================================================

Settings:Init(
    Context
)

--==================================================
-- RGB
--==================================================

RGB:Init(
    Context
)

--==================================================
-- CREATE CATEGORIES
--==================================================

Categories:CreateCategories()

--==================================================
-- CONFIGURATION BUTTON
--==================================================

local ConfigButton =
    Categories.ConfigButton

if ConfigButton then

    ConfigButton.MouseButton1Click:Connect(function()

        Settings:Show()

    end)

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

Categories:SetDefaultCategory()

--==================================================
-- CLOSE BUTTON
--==================================================

if UI.Close then

    UI.Close.MouseButton1Click:Connect(function()

        UI:SetVisible(
            false
        )

        -- A logo continua disponível
        -- enquanto a UI estiver fechada.

        if Config.UI.ShowLogo then

            Logo:SetVisible(
                true
            )

        end

    end)

end

--==================================================
-- INITIAL STATE
--==================================================

UI:SetVisible(
    false
)

Logo:SetVisible(
    Config.UI.ShowLogo
)

--==================================================
-- INITIAL THEME
--==================================================

UI:ApplyTheme()

Logo:ApplyTheme()

Categories:ApplyTheme()

Search:ApplyTheme()
--==================================================
-- LOADED
--==================================================

print(
    "💥 Rimuru Hub carregado."
)

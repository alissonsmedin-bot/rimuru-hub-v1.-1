--// 💥 RIMURU HUB
--// UI CORE
--// REMOTE UI FOLDER LOADER
--// Loads:
--// Window / References / Topbar / Results
--// Search / Events / Drag / Animation
--// Logo / Styling / Transparency
--// Compatible with Remote Main
--// Compatible with Config / Theme / Sound
--// SAFE REMOTE ARCHITECTURE

local UI = {}

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
    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/refs/heads/main/UI/"

--==================================================
-- MODULE NAMES
--==================================================

local MODULE_NAMES = {

    "Window",
    "References",
    "Topbar",
    "Results",
    "Search",
    "Events",
    "Drag",
    "Animation",
    "Logo",
    "Styling",
    "Transparency",

}

--==================================================
-- MODULE CACHE
--==================================================

UI.Modules = {}

--==================================================
-- SAFE HTTP
--==================================================

local function GetRemote(
    Name
)

    local URL =
        BASE_URL
        .. Name
        .. ".lua"

    local Success,
        Result =
        pcall(
            function()

                return game:
                    HttpGet(
                        URL
                    )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro HTTP UI/"
            .. Name
            .. ": "
            .. tostring(Result)
        )

        return nil

    end

    if type(Result) ~= "string"
    or Result == ""
    then

        warn(
            "[Rimuru Hub] UI/"
            .. Name
            .. " retornou conteúdo vazio."
        )

        return nil

    end

    return Result

end

--==================================================
-- LOAD REMOTE MODULE
--==================================================

local function LoadModule(
    Name
)

    if UI.Modules[Name] then

        return UI.Modules[Name]

    end

    local Source =
        GetRemote(
            Name
        )

    if not Source then
        return nil
    end

    local Loader =
        loadstring

    if not Loader then

        warn(
            "[Rimuru Hub] loadstring não disponível para UI/"
            .. Name
        )

        return nil

    end

    local Success,
        Chunk =
        pcall(
            Loader,
            Source,
            "RimuruHub_UI_" .. Name
        )

    if not Success
    or type(Chunk) ~= "function"
    then

        warn(
            "[Rimuru Hub] Erro de compilação UI/"
            .. Name
            .. ": "
            .. tostring(Chunk)
        )

        return nil

    end

    local ExecuteSuccess,
        Result =
        pcall(
            Chunk
        )

    if not ExecuteSuccess then

        warn(
            "[Rimuru Hub] Erro ao executar UI/"
            .. Name
            .. ": "
            .. tostring(Result)
        )

        return nil

    end

    if type(Result) ~= "table" then

        warn(
            "[Rimuru Hub] UI/"
            .. Name
            .. " não retornou uma tabela."
        )

        return nil

    end

    UI.Modules[Name] =
        Result

    print(
        "[Rimuru Hub] UI/"
        .. Name
        .. " carregado."
    )

    return Result

end

--==================================================
-- LOAD ALL
--==================================================

for _, Name in
    ipairs(
        MODULE_NAMES
    )
do

    LoadModule(
        Name
    )

end

--==================================================
-- DIRECT REFERENCES
--==================================================

for _, Name in
    ipairs(
        MODULE_NAMES
    )
do

    UI[Name] =
        UI.Modules[Name]

end

--==================================================
-- CONTEXT
--==================================================

UI.Context = {}

--==================================================
-- SET CONTEXT
--==================================================

function UI:SetContext(
    Context
)

    if type(Context) ~= "table" then

        Context = {}

    end

    for Key, Value in
        pairs(Context)
    do

        self.Context[Key] =
            Value

    end

    --==================================================
    -- CORE
    --==================================================

    self.Context.UI =
        self

    self.Context.UIRoot =
        self

    --==================================================
    -- UI MODULES
    --==================================================

    for _, Name in
        ipairs(
            MODULE_NAMES
        )
    do

        self.Context[Name] =
            self.Modules[Name]

    end

    return true

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
            "[Rimuru Hub] UI/"
            .. Name
            .. " não carregado."
        )

        return false

    end

    if type(
        Module.Init
    ) ~= "function"
    then

        print(
            "[Rimuru Hub] UI/"
            .. Name
            .. " não possui Init()."
        )

        return true

    end

    local Success,
        Result =
        pcall(
            function()

                return Module:
                    Init(
                        Context
                    )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao iniciar UI/"
            .. Name
            .. ": "
            .. tostring(Result)
        )

        return false

    end

    return Result ~= false

end

--==================================================
-- FIND RECURSIVE
--==================================================

local function FindRecursive(
    Root,
    Names
)

    if not Root
    or typeof(Root) ~= "Instance"
    then

        return nil

    end

    for _, Name in
        ipairs(
            Names
        )
    do

        local Success,
            Result =
            pcall(
                function()

                    return Root:
                        FindFirstChild(
                            Name,
                            true
                        )

                end
            )

        if Success
        and Result
        then

            return Result

        end

    end

    return nil

end

--==================================================
-- UPDATE REFERENCES
--==================================================

function UI:UpdateReferences()

    local Main =
        nil

    --==================================================
    -- REFERENCES MODULE
    --==================================================

    local References =
        self.Modules.References

    if References then

        if type(
            References.GetMain
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return References:
                            GetMain()

                    end
                )

            if Success
            and typeof(Result) == "Instance"
            then

                Main =
                    Result

            end

        end

        if not Main
        and References.Main
        and typeof(
            References.Main
        ) == "Instance"
        then

            Main =
                References.Main

        end

    end

    --==================================================
    -- WINDOW MODULE
    --==================================================

    local Window =
        self.Modules.Window

    if not Main
    and Window
    then

        if Window.Main
        and typeof(
            Window.Main
        ) == "Instance"
        then

            Main =
                Window.Main

        elseif Window.Window
        and typeof(
            Window.Window
        ) == "Instance"
        then

            Main =
                Window.Window

        elseif type(
            Window.Get
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return Window:
                            Get()

                    end
                )

            if Success
            and typeof(Result) == "Instance"
            then

                Main =
                    Result

            end

        end

    end

    --==================================================
    -- PLAYER GUI FALLBACK
    --==================================================

    if not Main
    and Player
    then

        local PlayerGui =
            Player:FindFirstChild(
                "PlayerGui"
            )

        if PlayerGui then

            Main =
                FindRecursive(
                    PlayerGui,
                    {
                        "RimuruHub",
                        "Main",
                    }
                )

        end

    end

    self.Main =
        Main

    --==================================================
    -- REFERENCES
    --==================================================

    if Main then

        self.Sidebar =
            FindRecursive(
                Main,
                {
                    "Sidebar",
                }
            )

        self.Scroll =
            FindRecursive(
                Main,
                {
                    "Scroll",
                    "ScrollingFrame",
                    "SoundList",
                    "Results",
                    "Content",
                    "Items",
                }
            )

        self.ResultsContainer =
            FindRecursive(
                Main,
                {
                    "ResultsContainer",
                    "Results",
                    "Content",
                }
            )

        self.Header =
            FindRecursive(
                Main,
                {
                    "Header",
                    "Topbar",
                }
            )

        self.Background =
            FindRecursive(
                Main,
                {
                    "BackgroundImage",
                    "Background",
                }
            )

        self.LogoInstance =
            FindRecursive(
                Main,
                {
                    "Logo",
                }
            )

    end

    --==================================================
    -- RESULTS
    --==================================================

    local Results =
        self.Modules.Results

    if Results then

        if Results.Scroll
        and typeof(
            Results.Scroll
        ) == "Instance"
        then

            self.Scroll =
                Results.Scroll

        end

        if Results.Container
        and typeof(
            Results.Container
        ) == "Instance"
        then

            self.ResultsContainer =
                Results.Container

        end

    end

    --==================================================
    -- TOPBAR
    --==================================================

    local Topbar =
        self.Modules.Topbar

    if Topbar then

        if Topbar.Container
        and typeof(
            Topbar.Container
        ) == "Instance"
        then

            self.TopbarInstance =
                Topbar.Container

        end

    end

    return Main ~= nil

end

--==================================================
-- CREATE WINDOW
--==================================================

function UI:CreateWindow()

    local Window =
        self.Modules.Window

    if not Window then

        warn(
            "[Rimuru Hub] Window não disponível."
        )

        return false

    end

    if type(
        Window.Create
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return Window:
                        Create(
                            self.Context
                        )

                end
            )

        if Success then

            self:UpdateReferences()

            return Result ~= false

        end

    end

    if type(
        Window.Init
    ) == "function"
    then

        local Success =
            InitModule(
                "Window",
                Window,
                self.Context
            )

        self:UpdateReferences()

        return Success

    end

    return false

end

--==================================================
-- INIT MODULES
--==================================================

function UI:InitModules()

    -- Window is initialized separately.

    local ORDER = {

        "References",
        "Topbar",
        "Results",
        "Search",
        "Events",
        "Drag",
        "Animation",
        "Logo",
        "Styling",
        "Transparency",

    }

    for _, Name in
        ipairs(
            ORDER
        )
    do

        InitModule(
            Name,
            self.Modules[Name],
            self.Context
        )

        self:UpdateReferences()

    end

end

--==================================================
-- INIT
--==================================================

function UI:Init(Context)

    --==================================================
    -- CONTEXT
    --==================================================

    self:SetContext(
        Context or {}
    )

    --==================================================
    -- PLAYER
    --==================================================

    self.Player =
        self.Context.Player
        or Player

    if not self.Player then

        warn(
            "[Rimuru Hub] LocalPlayer não encontrado."
        )

        return false

    end

    --==================================================
    -- PLAYER GUI
    --==================================================

    local ExistingPlayerGui =
        self.Context.PlayerGui

    if ExistingPlayerGui then

        self.PlayerGui =
            ExistingPlayerGui

    else

        self.PlayerGui =
            self.Player:WaitForChild(
                "PlayerGui"
            )

    end

    self.Context.Player =
        self.Player

    self.Context.PlayerGui =
        self.PlayerGui

    --==================================================
    -- WINDOW FIRST
    --==================================================

    local WindowSuccess =
        self:CreateWindow()

    if not WindowSuccess then

        warn(
            "[Rimuru Hub] Window não pôde ser inicializada."
        )

    end

    --==================================================
    -- REFERENCES
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- MODULES
    --==================================================

    self:InitModules()

    --==================================================
    -- FINAL REFERENCES
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- TRANSPARENCY
    --==================================================

    local Transparency =
        self.Modules.Transparency

    if Transparency
    and type(
        Transparency.Apply
    ) == "function"
    then

        pcall(
            function()

                Transparency:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- STYLING
    --==================================================

    local Styling =
        self.Modules.Styling

    if Styling
    and type(
        Styling.Apply
    ) == "function"
    then

        pcall(
            function()

                Styling:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- FINAL
    --==================================================

    print(
        "[Rimuru Hub] UI Folder Loader conectado."
    )

    if self.Main then

        print(
            "[Rimuru Hub] UI disponível."
        )

    else

        warn(
            "[Rimuru Hub] UI não disponível."
        )

    end

    return true

end

--==================================================
-- GET MAIN
--==================================================

function UI:GetMain()

    if self.Main
    and self.Main.Parent
    then

        return self.Main

    end

    self:UpdateReferences()

    return self.Main

end

--==================================================
-- GET SCROLL
--==================================================

function UI:GetScroll()

    if self.Scroll
    and self.Scroll.Parent
    then

        return self.Scroll

    end

    self:UpdateReferences()

    return self.Scroll

end

--==================================================
-- GET SIDEBAR
--==================================================

function UI:GetSidebar()

    if self.Sidebar
    and self.Sidebar.Parent
    then

        return self.Sidebar

    end

    self:UpdateReferences()

    return self.Sidebar

end

--==================================================
-- GET BACKGROUND
--==================================================

function UI:GetBackground()

    if self.Background
    and self.Background.Parent
    then

        return self.Background

    end

    self:UpdateReferences()

    return self.Background

end

--==================================================
-- BACKGROUND TRANSPARENCY
--==================================================

function UI:SetBackgroundTransparency(
    Value
)

    Value =
        tonumber(Value)

    if not Value then
        return false
    end

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    local Background =
        self:GetBackground()

    if not Background then
        return false
    end

    if Background:IsA(
        "ImageLabel"
    )
    or Background:IsA(
        "ImageButton"
    )
    then

        Background.ImageTransparency =
            Value

        return true

    end

    return false

end

--==================================================
-- OPEN
--==================================================

function UI:Open()

    local Main =
        self:GetMain()

    if not Main then
        return false
    end

    local Animation =
        self.Modules.Animation

    if Animation
    and type(
        Animation.Open
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    Animation:
                        Open()

                end
            )

        if Success then
            return true
        end

    end

    Main.Visible =
        true

    return true

end

--==================================================
-- CLOSE
--==================================================

function UI:Close()

    local Main =
        self:GetMain()

    if not Main then
        return false
    end

    local Animation =
        self.Modules.Animation

    if Animation
    and type(
        Animation.Close
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    Animation:
                        Close()

                                    Animation:
                        Close()

                end
            )

        if Success then
            return true
        end

    end

    Main.Visible =
        false

    return true

end

--==================================================
-- TOGGLE
--==================================================

function UI:Toggle()

    local Main =
        self:GetMain()

    if not Main then
        return false
    end

    if Main.Visible then

        self:Close()

        return false

    else

        self:Open()

        return true

    end

end

--==================================================
-- IS OPEN
--==================================================

function UI:IsOpen()

    local Main =
        self:GetMain()

    if not Main then
        return false
    end

    return Main.Visible == true

end

--==================================================
-- GET STATUS
--==================================================

function UI:GetStatus()

    return {

        Main =
            self.Main ~= nil,

        Window =
            self.Modules.Window ~= nil,

        References =
            self.Modules.References ~= nil,

        Topbar =
            self.Modules.Topbar ~= nil,

        Results =
            self.Modules.Results ~= nil,

        Search =
            self.Modules.Search ~= nil,

        Events =
            self.Modules.Events ~= nil,

        Drag =
            self.Modules.Drag ~= nil,

        Animation =
            self.Modules.Animation ~= nil,

        Logo =
            self.Modules.Logo ~= nil,

        Styling =
            self.Modules.Styling ~= nil,

        Transparency =
            self.Modules.Transparency ~= nil,

        Sidebar =
            self.Sidebar ~= nil,

        Scroll =
            self.Scroll ~= nil,

        Background =
            self.Background ~= nil,

    }

end

--==================================================
-- IS READY
--==================================================

function UI:IsReady()

    return
        self.Main ~= nil

end

--==================================================
-- REFRESH
--==================================================

function UI:Refresh()

    self:UpdateReferences()

    local Styling =
        self.Modules.Styling

    if Styling
    and type(
        Styling.Apply
    ) == "function"
    then

        pcall(
            function()

                Styling:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    local Transparency =
        self.Modules.Transparency

    if Transparency
    and type(
        Transparency.Apply
    ) == "function"
    then

        pcall(
            function()

                Transparency:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    return true

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    local Styling =
        self.Modules.Styling

    if Styling
    and type(
        Styling.Apply
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    Styling:
                        Apply(
                            self.Context
                        )

                end
            )

        return Success

    end

    return false

end

--==================================================
-- DESTROY
--==================================================

function UI:Destroy()

    --==================================================
    -- EVENTS
    --==================================================

    local Events =
        self.Modules.Events

    if Events then

        if type(
            Events.Destroy
        ) == "function"
        then

            pcall(
                function()

                    Events:
                        Destroy()

                end
            )

        elseif type(
            Events.Disconnect
        ) == "function"
        then

            pcall(
                function()

                    Events:
                        Disconnect()

                end
            )

        end

    end

    --==================================================
    -- DRAG
    --==================================================

    local Drag =
        self.Modules.Drag

    if Drag
    and type(
        Drag.Destroy
    ) == "function"
    then

        pcall(
            function()

                Drag:
                    Destroy()

            end
        )

    end

    --==================================================
    -- ANIMATION
    --==================================================

    local Animation =
        self.Modules.Animation

    if Animation
    and type(
        Animation.Destroy
    ) == "function"
    then

        pcall(
            function()

                Animation:
                    Destroy()

            end
        )

    end

    --==================================================
    -- WINDOW
    --==================================================

    local Window =
        self.Modules.Window

    if Window
    and type(
        Window.Destroy
    ) == "function"
    then

        pcall(
            function()

                Window:
                    Destroy()

            end
        )

    end

    --==================================================
    -- CLEAR REFERENCES
    --==================================================

    self.Main =
        nil

    self.Scroll =
        nil

    self.Sidebar =
        nil

    self.ResultsContainer =
        nil

    self.Header =
        nil

    self.Background =
        nil

    self.LogoInstance =
        nil

    self.TopbarInstance =
        nil

    return true

end

--==================================================
-- DEBUG
--==================================================

function UI:Debug()

    local Status =
        self:GetStatus()

    print(
        "========================================"
    )

    print(
        "★ RIMURU HUB - UI STATUS"
    )

    print(
        "========================================"
    )

    for Name, Value in
        pairs(Status)
    do

        print(
            "[UI] "
            .. tostring(Name)
            .. " = "
            .. tostring(Value)
        )

    end

    print(
        "========================================"
    )

    return Status

end

--==================================================
-- STARTUP MESSAGE
--==================================================

print(
    "★RIMURU HUB"
)

print(
    "Remote Modular UI Folder carregado."
)

--==================================================
-- RETURN
--==================================================

return UI

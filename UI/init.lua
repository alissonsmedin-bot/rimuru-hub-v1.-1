--// 💥 RIMURU HUB
--// UI CORE
--// Modular UI Controller
--// Folder Architecture
--// Connects:
--// Window / References / Topbar / Results
--// Search / Events / Drag / Animation
--// Logo / Styling / Transparency
--// SAFE CONTEXT SYSTEM
--// Compatible with Remote Main
--// Compatible with Config + Theme + Cards + Categories + Settings + RGB

local UI = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local Player =
    Players.LocalPlayer

--==================================================
-- MODULE FOLDER
--==================================================

local ModuleFolder =
    script.Parent

--==================================================
-- MODULE CACHE
--==================================================

UI.Modules = {}

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
-- SAFE REQUIRE
--==================================================

local function LoadModule(
    Name
)

    if UI.Modules[Name] then

        return UI.Modules[Name]

    end

    local Module =
        ModuleFolder:FindFirstChild(
            Name
        )

    if not Module then

        warn(
            "[Rimuru Hub] UI module não encontrado: "
            .. Name
        )

        return nil

    end

    if not Module:IsA(
        "ModuleScript"
    )
    then

        warn(
            "[Rimuru Hub] "
            .. Name
            .. " não é ModuleScript."
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
            "[Rimuru Hub] Erro ao carregar UI/"
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

    return Result

end

--==================================================
-- LOAD ALL MODULES
--==================================================

for _, Name in
    ipairs(
        MODULE_NAMES
    )
do

    UI.Modules[Name] =
        LoadModule(Name)

end

--==================================================
-- DIRECT REFERENCES
--==================================================

UI.Window =
    UI.Modules.Window

UI.References =
    UI.Modules.References

UI.Topbar =
    UI.Modules.Topbar

UI.Results =
    UI.Modules.Results

UI.Search =
    UI.Modules.Search

UI.Events =
    UI.Modules.Events

UI.Drag =
    UI.Modules.Drag

UI.Animation =
    UI.Modules.Animation

UI.Logo =
    UI.Modules.Logo

UI.Styling =
    UI.Modules.Styling

UI.Transparency =
    UI.Modules.Transparency

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

        return false

    end

    for Key, Value in
        pairs(Context)
    do

        self.Context[Key] =
            Value

    end

    --==================================================
    -- CORE REFERENCES
    --==================================================

    self.Context.UI =
        self

    self.Context.UIRoot =
        self

    self.Context.Window =
        self.Window

    self.Context.References =
        self.References

    self.Context.Topbar =
        self.Topbar

    self.Context.Results =
        self.Results

    self.Context.Search =
        self.Search

    self.Context.Events =
        self.Events

    self.Context.Drag =
        self.Drag

    self.Context.Animation =
        self.Animation

    self.Context.Logo =
        self.Logo

    self.Context.Styling =
        self.Styling

    self.Context.Transparency =
        self.Transparency

    return true

end

--==================================================
-- SAFE INIT MODULE
--==================================================

local function InitModule(
    Name,
    Module
)

    if not Module then

        return false

    end

    if type(
        Module.Init
    ) ~= "function"
    then

        return true

    end

    local Success,
        Result =
        pcall(
            function()

                return Module:Init(
                    UI.Context
                )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] UI/"
            .. Name
            .. " Init error: "
            .. tostring(Result)
        )

        return false

    end

    return true

end

--==================================================
-- FIND INSTANCE
--==================================================

local function FindRecursive(
    Root,
    Names
)

    if not Root then
        return nil
    end

    for _, Name in
        ipairs(Names)
    do

        local Object =
            Root:FindFirstChild(
                Name,
                true
            )

        if Object then

            return Object

        end

    end

    return nil

end

--==================================================
-- UPDATE REFERENCES
--==================================================

function UI:UpdateReferences()

    local Main

    --==================================================
    -- REFERENCES MODULE
    --==================================================

    if self.References then

        if type(
            self.References.GetMain
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return self.References:
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
        and self.References.Main
        and typeof(
            self.References.Main
        ) == "Instance"
        then

            Main =
                self.References.Main

        end

    end

    --==================================================
    -- WINDOW MODULE
    --==================================================

    if not Main
    and self.Window
    then

        if self.Window.Main
        and typeof(
            self.Window.Main
        ) == "Instance"
        then

            Main =
                self.Window.Main

        elseif self.Window.Window
        and typeof(
            self.Window.Window
        ) == "Instance"
        then

            Main =
                self.Window.Window

        elseif type(
            self.Window.Get
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return self.Window:
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
                        "Main",
                    }
                )

        end

    end

    self.Main =
        Main

    --==================================================
    -- COMMON REFERENCES
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
                }
            )

        self.ResultsContainer =
            FindRecursive(
                Main,
                {
                    "Results",
                    "ResultsContainer",
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

        self.Close =
            FindRecursive(
                Main,
                {
                    "Close",
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
    -- RESULTS MODULE
    --==================================================

    if self.Results then

        if self.Results.Scroll
        and typeof(
            self.Results.Scroll
        ) == "Instance"
        then

            self.Scroll =
                self.Results.Scroll

        end

        if self.Results.Container
        and typeof(
            self.Results.Container
        ) == "Instance"
        then

            self.ResultsContainer =
                self.Results.Container

        end

    end

    --==================================================
    -- TOPBAR MODULE
    --==================================================

    if self.Topbar then

        if self.Topbar.Container
        and typeof(
            self.Topbar.Container
        ) == "Instance"
        then

            self.TopbarInstance =
                self.Topbar.Container

        end

    end

    return self.Main ~= nil

end

--==================================================
-- INITIALIZE WINDOW
--==================================================

function UI:CreateWindow()

    if not self.Window then

        warn(
            "[Rimuru Hub] Window não disponível."
        )

        return false

    end

    --==================================================
    -- CREATE
    --==================================================

    if type(
        self.Window.Create
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Window:
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

    --==================================================
    -- INIT FALLBACK
    --==================================================

    if type(
        self.Window.Init
    ) == "function"
    then

        local Success =
            InitModule(
                "Window",
                self.Window
            )

        self:UpdateReferences()

        return Success

    end

    return false

end

--==================================================
-- INITIALIZE MODULES
--==================================================

function UI:InitModules()

    --==================================================
    -- REFERENCES
    --==================================================

    InitModule(
        "References",
        self.References
    )

    --==================================================
    -- TOPBAR
    --==================================================

    InitModule(
        "Topbar",
        self.Topbar
    )

    --==================================================
    -- RESULTS
    --==================================================

    InitModule(
        "Results",
        self.Results
    )

    --==================================================
    -- SEARCH
    --==================================================

    InitModule(
        "Search",
        self.Search
    )

    --==================================================
    -- EVENTS
    --==================================================

    InitModule(
        "Events",
        self.Events
    )

    --==================================================
    -- DRAG
    --==================================================

    InitModule(
        "Drag",
        self.Drag
    )

    --==================================================
    -- ANIMATION
    --==================================================

    InitModule(
        "Animation",
        self.Animation
    )

    --==================================================
    -- LOGO
    --==================================================

    InitModule(
        "Logo",
        self.Logo
    )

    --==================================================
    -- STYLING
    --==================================================

    InitModule(
        "Styling",
        self.Styling
    )

    --==================================================
    -- TRANSPARENCY
    --==================================================

    InitModule(
        "Transparency",
        self.Transparency
    )

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

    self.PlayerGui =
        self.Context.PlayerGui
        or self.Player:WaitForChild(
            "PlayerGui"
        )

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
    -- REFERENCES AFTER WINDOW
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- MODULES
    --==================================================

    self:InitModules()

    --==================================================
    -- UPDATE AGAIN
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- TRANSPARENCY
    --==================================================

    if self.Transparency
    and type(
        self.Transparency.Apply
    ) == "function"
    then

        pcall(
            function()

                self.Transparency:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- STYLING
    --==================================================

    if self.Styling
    and type(
        self.Styling.Apply
    ) == "function"
    then

        pcall(
            function()

                self.Styling:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- DEFAULT VISIBILITY
    --==================================================

    if self.Main then

        -- A janela começa fechada.
        -- O Main/Events pode controlar o toggle.

        if self.Main.Visible == nil then

            self.Main.Visible =
                false

        end

    end

    print(
        "[Rimuru Hub] UI Folder conectado."
    )

    return true

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

    if self.Scroll
    and self.Scroll.Parent
    then

        return self.Scroll

    end

    return nil

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
-- SET BACKGROUND TRANSPARENCY
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

    if self.Animation
    and type(
        self.Animation.Open
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.Animation:
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

    if self.Animation
    and type(
        self.Animation.Close
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.Animation:
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

        warn(
            "[Rimuru Hub] Não foi possível encontrar Main para Toggle."
        )

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
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    --==================================================
    -- STYLING
    --==================================================

    if self.Styling
    and type(
        self.Styling.Apply
    ) == "function"
    then

        pcall(
            function()

                self.Styling:
                    Apply(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- TOPBAR
    --==================================================

    if self.Topbar
    and type(
        self.Topbar.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Topbar:
                    ApplyTheme(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- RESULTS
    --==================================================

    if self.Results
    and type(
        self.Results.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Results:
                    ApplyTheme(
                        self.Context
                    )

            end
        )

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar
    and type(
        self.Sidebar.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Sidebar:
                    ApplyTheme(
                        self.Context
                    )

            end
        )

    end

    return true

end

--==================================================
-- APPLY TRANSPARENCY
--==================================================

function UI:ApplyTransparency()

    if self.Transparency
    and type(
        self.Transparency.Apply
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.Transparency:
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
-- REFRESH
--==================================================

function UI:Refresh()

    --==================================================
    -- REFERENCES
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- STYLING
    --==================================================

    self:ApplyTheme()

    --==================================================
    -- TRANSPARENCY
    --==================================================

    self:ApplyTransparency()

    return true

end

--==================================================
-- GET STATUS
--==================================================

function UI:GetStatus()

    return {

        Main =
            self.Main ~= nil,

        Window =
            self.Window ~= nil,

        References =
            self.References ~= nil,

        Topbar =
            self.Topbar ~= nil,

        Results =
            self.Results ~= nil,

        Search =
            self.Search ~= nil,

        Events =
            self.Events ~= nil,

        Drag =
            self.Drag ~= nil,

        Animation =
            self.Animation ~= nil,

        Logo =
            self.Logo ~= nil,

        Styling =
            self.Styling ~= nil,

        Transparency =
            self.Transparency ~= nil,

        Scroll =
            self.Scroll ~= nil,

        Sidebar =
            self.Sidebar ~= nil,

        PlayerGui =
            self.PlayerGui ~= nil,

    }

end

--==================================================
-- READY
--==================================================

function UI:IsReady()

    return
        self.Main ~= nil
        and self.Scroll ~= nil

end

--==================================================
-- DESTROY
--==================================================

function UI:Destroy()

    --==================================================
    -- EVENTS
    --==================================================

    if self.Events
    and type(
        self.Events.Destroy
    ) == "function"
    then

        pcall(
            function()

                self.Events:
                    Destroy()

            end
        )

    end

    --==================================================
    -- DRAG
    --==================================================

    if self.Drag
    and type(
        self.Drag.Destroy
    ) == "function"
    then

        pcall(
            function()

                self.Drag:
                    Destroy()

            end
        )

    end

    --==================================================
    -- ANIMATION
    --==================================================

    if self.Animation
    and type(
        self.Animation.Destroy
    ) == "function"
    then

        pcall(
            function()

                self.Animation:
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
-- STARTUP MESSAGE
--==================================================

print(
    "[Rimuru Hub] UI Folder Loader conectado."
)

return UI
